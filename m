Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B8A1061B13
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A22610E5AB;
	Mon, 30 Mar 2026 15:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2K8atL8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D72B10E68D
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 15:31:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 889AA600CB;
 Mon, 30 Mar 2026 15:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63A3C4CEF7;
 Mon, 30 Mar 2026 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1774884236;
 bh=dKbvp8ix6uRKUnW/rwHFQfK0m1zd7znPNt3Pmzy/8Bo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r2K8atL8MqpujJ5k8HvDGbO0gUeLJfNwYswhkLoukYH8tk2SKIhJjGknHCbf1GpQ+
 TyFdnC7EEfUNF7mljVJKA2F+ZqelVrjqd16sTEOa88sC++REbkD8rRp1f86+YxtHln
 L3TjvpIz0bW+LB7iMIW9H8oScq61ZpZ//BBGEAxE=
Date: Mon, 30 Mar 2026 17:23:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yug Merabtene <yug.merabtene@gmail.com>
Cc: andy@kernel.org, hvaibhav.linux@gmail.com, johan@kernel.org,
 elder@kernel.org, vaibhav.sr@gmail.com, mgreer@animalcreek.com,
 rmfrfs@gmail.com, pure.logic@nexus-software.ie,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: greybus: switch sysfs show paths to
 sysfs_emit()
Message-ID: <2026033036-dry-dominion-c63a@gregkh>
References: <20260329180117.611024-1-test@test.com>
 <20260329184124.775392-1-yug.merabtene@gmail.com>
 <20260329184124.775392-3-yug.merabtene@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329184124.775392-3-yug.merabtene@gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, Mar 29, 2026 at 08:41:24PM +0200, Yug Merabtene wrote:
> Signed-off-by: Yug Merabtene <yug.merabtene@gmail.com>
> ---
>  drivers/staging/greybus/arche-apb-ctrl.c       | 12 ++++++------
>  drivers/staging/greybus/arche-platform.c       | 10 +++++-----
>  drivers/staging/greybus/audio_manager_module.c | 12 ++++++------
>  drivers/staging/greybus/gbphy.c                |  2 +-
>  drivers/staging/greybus/light.c                |  4 ++--
>  drivers/staging/greybus/loopback.c             | 14 +++++++-------
>  6 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
> index 33f26a65f0cc..10effbe07a2a 100644
> --- a/drivers/staging/greybus/arche-apb-ctrl.c
> +++ b/drivers/staging/greybus/arche-apb-ctrl.c
> @@ -300,16 +300,16 @@ static ssize_t state_show(struct device *dev,
>  
>  	switch (apb->state) {
>  	case ARCHE_PLATFORM_STATE_OFF:
> -		return sprintf(buf, "off%s\n",
> -				apb->init_disabled ? ",disabled" : "");
> +		return sysfs_emit(buf, "off%s\n",
> +				  apb->init_disabled ? ",disabled" : "");
>  	case ARCHE_PLATFORM_STATE_ACTIVE:
> -		return sprintf(buf, "active\n");
> +		return sysfs_emit(buf, "active\n");
>  	case ARCHE_PLATFORM_STATE_STANDBY:
> -		return sprintf(buf, "standby\n");
> +		return sysfs_emit(buf, "standby\n");
>  	case ARCHE_PLATFORM_STATE_FW_FLASHING:
> -		return sprintf(buf, "fw_flashing\n");
> +		return sysfs_emit(buf, "fw_flashing\n");
>  	default:
> -		return sprintf(buf, "unknown state\n");
> +		return sysfs_emit(buf, "unknown state\n");
>  	}
>  }
>  
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index f669a7e2eb11..de5de59ea8ab 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -374,15 +374,15 @@ static ssize_t state_show(struct device *dev,
>  
>  	switch (arche_pdata->state) {
>  	case ARCHE_PLATFORM_STATE_OFF:
> -		return sprintf(buf, "off\n");
> +		return sysfs_emit(buf, "off\n");
>  	case ARCHE_PLATFORM_STATE_ACTIVE:
> -		return sprintf(buf, "active\n");
> +		return sysfs_emit(buf, "active\n");
>  	case ARCHE_PLATFORM_STATE_STANDBY:
> -		return sprintf(buf, "standby\n");
> +		return sysfs_emit(buf, "standby\n");
>  	case ARCHE_PLATFORM_STATE_FW_FLASHING:
> -		return sprintf(buf, "fw_flashing\n");
> +		return sysfs_emit(buf, "fw_flashing\n");
>  	default:
> -		return sprintf(buf, "unknown state\n");
> +		return sysfs_emit(buf, "unknown state\n");
>  	}
>  }
>  
> diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
> index e87b82ca6d8a..f22ee73eb8d2 100644
> --- a/drivers/staging/greybus/audio_manager_module.c
> +++ b/drivers/staging/greybus/audio_manager_module.c
> @@ -76,7 +76,7 @@ static void gb_audio_module_release(struct kobject *kobj)
>  static ssize_t gb_audio_module_name_show(struct gb_audio_manager_module *module,
>  					 struct gb_audio_manager_module_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%s", module->desc.name);
> +	return sysfs_emit(buf, "%s\n", module->desc.name);
>  }
>  
>  static struct gb_audio_manager_module_attribute gb_audio_module_name_attribute =
> @@ -85,7 +85,7 @@ static struct gb_audio_manager_module_attribute gb_audio_module_name_attribute =
>  static ssize_t gb_audio_module_vid_show(struct gb_audio_manager_module *module,
>  					struct gb_audio_manager_module_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d", module->desc.vid);
> +	return sysfs_emit(buf, "%d\n", module->desc.vid);
>  }
>  
>  static struct gb_audio_manager_module_attribute gb_audio_module_vid_attribute =
> @@ -94,7 +94,7 @@ static struct gb_audio_manager_module_attribute gb_audio_module_vid_attribute =
>  static ssize_t gb_audio_module_pid_show(struct gb_audio_manager_module *module,
>  					struct gb_audio_manager_module_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d", module->desc.pid);
> +	return sysfs_emit(buf, "%d\n", module->desc.pid);
>  }
>  
>  static struct gb_audio_manager_module_attribute gb_audio_module_pid_attribute =
> @@ -104,7 +104,7 @@ static ssize_t gb_audio_module_intf_id_show(struct gb_audio_manager_module *modu
>  					    struct gb_audio_manager_module_attribute *attr,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%d", module->desc.intf_id);
> +	return sysfs_emit(buf, "%d\n", module->desc.intf_id);
>  }
>  
>  static struct gb_audio_manager_module_attribute
> @@ -115,7 +115,7 @@ static ssize_t gb_audio_module_ip_devices_show(struct gb_audio_manager_module *m
>  					       struct gb_audio_manager_module_attribute *attr,
>  					       char *buf)
>  {
> -	return sprintf(buf, "0x%X", module->desc.ip_devices);
> +	return sysfs_emit(buf, "0x%X\n", module->desc.ip_devices);
>  }
>  
>  static struct gb_audio_manager_module_attribute
> @@ -126,7 +126,7 @@ static ssize_t gb_audio_module_op_devices_show(struct gb_audio_manager_module *m
>  					       struct gb_audio_manager_module_attribute *attr,
>  					       char *buf)
>  {
> -	return sprintf(buf, "0x%X", module->desc.op_devices);
> +	return sysfs_emit(buf, "0x%X\n", module->desc.op_devices);
>  }
>  
>  static struct gb_audio_manager_module_attribute
> diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
> index bdb0f5164a6f..bb9a5b538e6e 100644
> --- a/drivers/staging/greybus/gbphy.c
> +++ b/drivers/staging/greybus/gbphy.c
> @@ -31,7 +31,7 @@ static ssize_t protocol_id_show(struct device *dev,
>  {
>  	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
>  
> -	return sprintf(buf, "0x%02x\n", gbphy_dev->cport_desc->protocol_id);
> +	return sysfs_emit(buf, "0x%02x\n", gbphy_dev->cport_desc->protocol_id);
>  }
>  static DEVICE_ATTR_RO(protocol_id);
>  
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index cab02b5da867..2689f9a7524a 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -173,7 +173,7 @@ static ssize_t fade_##__dir##_show(struct device *dev,			\
>  	struct led_classdev *cdev = dev_get_drvdata(dev);		\
>  	struct gb_channel *channel = get_channel_from_cdev(cdev);	\
>  									\
> -	return sprintf(buf, "%u\n", channel->fade_##__dir);		\
> +	return sysfs_emit(buf, "%u\n", channel->fade_##__dir);		\
>  }									\
>  									\
>  static ssize_t fade_##__dir##_store(struct device *dev,			\
> @@ -220,7 +220,7 @@ static ssize_t color_show(struct device *dev, struct device_attribute *attr,
>  	struct led_classdev *cdev = dev_get_drvdata(dev);
>  	struct gb_channel *channel = get_channel_from_cdev(cdev);
>  
> -	return sprintf(buf, "0x%08x\n", channel->color);
> +	return sysfs_emit(buf, "0x%08x\n", channel->color);
>  }
>  
>  static ssize_t color_store(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index aa9c73cb0ae5..3a502d89d19f 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -125,7 +125,7 @@ static ssize_t field##_show(struct device *dev,			\
>  			    char *buf)					\
>  {									\
>  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	return sprintf(buf, "%u\n", gb->field);			\
> +	return sysfs_emit(buf, "%u\n", gb->field);			\
>  }									\
>  static DEVICE_ATTR_RO(field)
>  
> @@ -137,8 +137,8 @@ static ssize_t name##_##field##_show(struct device *dev,	\
>  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
>  	/* Report 0 for min and max if no transfer succeeded */		\
>  	if (!gb->requests_completed)					\
> -		return sprintf(buf, "0\n");				\
> -	return sprintf(buf, "%" #type "\n", gb->name.field);		\
> +		return sysfs_emit(buf, "0\n");				\
> +	return sysfs_emit(buf, "%" #type "\n", gb->name.field);		\
>  }									\
>  static DEVICE_ATTR_RO(name##_##field)
>  
> @@ -158,7 +158,7 @@ static ssize_t name##_avg_show(struct device *dev,		\
>  	rem = do_div(avg, count);					\
>  	rem *= 1000000;							\
>  	do_div(rem, count);						\
> -	return sprintf(buf, "%llu.%06u\n", avg, (u32)rem);		\
> +	return sysfs_emit(buf, "%llu.%06u\n", avg, (u32)rem);		\
>  }									\
>  static DEVICE_ATTR_RO(name##_avg)
>  
> @@ -173,7 +173,7 @@ static ssize_t field##_show(struct device *dev,				\
>  			    char *buf)					\
>  {									\
>  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	return sprintf(buf, "%" #type "\n", gb->field);			\
> +	return sysfs_emit(buf, "%" #type "\n", gb->field);			\
>  }									\
>  static ssize_t field##_store(struct device *dev,			\
>  			    struct device_attribute *attr,		\
> @@ -199,7 +199,7 @@ static ssize_t field##_show(struct device *dev,		\
>  			    char *buf)					\
>  {									\
>  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	return sprintf(buf, "%u\n", gb->field);				\
> +	return sysfs_emit(buf, "%u\n", gb->field);				\
>  }									\
>  static DEVICE_ATTR_RO(field)
>  
> @@ -209,7 +209,7 @@ static ssize_t field##_show(struct device *dev,				\
>  			    char *buf)					\
>  {									\
>  	struct gb_loopback *gb = dev_get_drvdata(dev);			\
> -	return sprintf(buf, "%" #type "\n", gb->field);			\
> +	return sysfs_emit(buf, "%" #type "\n", gb->field);			\
>  }									\
>  static ssize_t field##_store(struct device *dev,			\
>  			    struct device_attribute *attr,		\
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
