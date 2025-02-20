// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"
import FlashController from "./flash_controller"

application.register("flash", FlashController)

export { application }
