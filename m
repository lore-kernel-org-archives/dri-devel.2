Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5BFC79FAE
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD0FC10ECD3;
	Tue,  8 Sep 2026 15:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P5/fwn4t";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3818910ECD2;
 Tue,  8 Sep 2026 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788882354; x=1820418354;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=zoP+eLQAO8cgrM3D1vkXQBjPSrnRb8rLf86f8yjY2i4=;
 b=P5/fwn4t9KUtE32w43+TeVmX/CD4HG5mZGyLGrChVhFnUWu+H+/9+CEi
 6laq1izb22c36BZJi1V492sZajlxXbVpTNo8xRGwAlO7w59G8DrYfzVca
 7cW++tmJEYgp8qZlwqsylv+EBy77+zCjM/UE8kkK6NrzMj4nr1VgnVcH9
 4DYUMTCKILPI/5hSQ/G5QsV+IV3AxB0HdHLAIt710/t6apX/emOJ5ipOQ
 L/1ssPnIVisbNMy5RWM+29w0wsLN48tnv/1R0IFrFxja6XDfPl741/WoT
 lCF5u85yoyYgFVUjbarbX54VDj3VVUP5w8xTodqZdv+c7nCyEK4ThuqDl Q==;
X-CSE-ConnectionGUID: 4RnGYmUXRSmWMxNl3DdIrg==
X-CSE-MsgGUID: 48SVLa/CSsmRHq1qwqNl4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89305723"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="89305723"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:45:53 -0700
X-CSE-ConnectionGUID: bX4JCOwIRZqTeT8vo7TXFA==
X-CSE-MsgGUID: /R3UcP9qTvGx+EYmSfbVfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="271020010"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.140])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 08:45:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, David
 Herrmann <dh.herrmann@gmail.com>, Marta Lofstedt
 <marta.lofstedt@intel.com>, Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
In-Reply-To: <20260908044035.62093-3-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
Date: Tue, 08 Sep 2026 18:45:44 +0300
Message-ID: <dd7f11d6772b9422793cbcf1011f4f1aa98bfa3d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 07 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
> So far backlights have only been controlled via sysfs. However, sysfs is
> not a proper user-space API for runtime modifications, and never was
> intended to provide such. The DRM drivers are now prepared to provide
> such a backlight link so user-space can control backlight via DRM
> connector properties. This allows us to employ the same access-management
> we use for mode-setting.
>
> This patch adds a few kernel-internal backlight helpers so we can modify
> backlights from within DRM, a brightness-changed notification, and a
> per-device takeover count so that legacy sysfs writes can be inhibited
> (-EBUSY) while a luminance-aware DRM client is in control.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>
> V2: Marta Lofstedt <marta.lofstedt@intel.com>
> - rebase
> - minor edit for checkpatch warning
>
> Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
>
> V3: Mario Limonciello (AMD) <superm1@kernel.org>
>  - rebase
>  - Use guard(mutex)
>
> V4: Mario Limonciello (AMD) <superm1@kernel.org>
>  - Adjust return type for backlight_set_brightness() to return errors
>  - Stop clamping in backlight_set_brightness()
>  - Drop backlight_device_lookup()
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/video/backlight/backlight.c | 66 +++++++++++++++++++++++++++++
>  include/linux/backlight.h           | 45 ++++++++++++++++++++
>  2 files changed, 111 insertions(+)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 4401f6294ccc8..1c700c1e77c3f 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -126,6 +126,9 @@ static void backlight_generate_event(struct backlight_device *bd,
>  	case BACKLIGHT_UPDATE_HOTKEY:
>  		envp[0] = "SOURCE=hotkey";
>  		break;
> +	case BACKLIGHT_UPDATE_DRM:
> +		envp[0] = "SOURCE=drm";
> +		break;
>  	default:
>  		envp[0] = "SOURCE=unknown";
>  		break;
> @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>  	struct backlight_device *bd = to_backlight_device(dev);
>  	unsigned long power, old_power;
>  
> +	/* A luminance-aware DRM client has taken over this backlight; the
> +	 * legacy sysfs interface is disabled until the last such client
> +	 * goes away.
> +	 */
> +	if (atomic_read(&bd->drm_takeover) > 0)
> +		return -EBUSY;
> +
>  	rc = kstrtoul(buf, 0, &power);
>  	if (rc)
>  		return rc;
> @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device *dev,
>  	struct backlight_device *bd = to_backlight_device(dev);
>  	unsigned long brightness;
>  
> +	/* A luminance-aware DRM client has taken over this backlight; the
> +	 * legacy sysfs interface is disabled until the last such client
> +	 * goes away.
> +	 */
> +	if (atomic_read(&bd->drm_takeover) > 0)
> +		return -EBUSY;
> +
>  	rc = kstrtoul(buf, 0, &brightness);
>  	if (rc)
>  		return rc;
> @@ -514,6 +531,41 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>  	return *r == data;
>  }
>  
> +/**
> + * backlight_set_brightness - set brightness on a backlight device
> + * @bd: backlight device to operate on
> + * @value: brightness value to set on the device
> + * @reason: backlight-change reason to use for notifications
> + *
> + * This is the in-kernel API equivalent of writing into the 'brightness' sysfs
> + * file. It calls into the underlying backlight driver to change the brightness
> + * value.
> + * A uevent notification is sent with the reason set to @reason.
> + * Return: 0 if successfully notified, -EINVAL for invalid values, -ENXIO if the
> + * device has no ops (e.g. it is being unregistered)
> + */
> +int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
> +			      enum backlight_update_reason reason)
> +{
> +	int rc = -ENXIO;
> +
> +	scoped_guard(mutex, &bd->ops_lock) {
> +		if (bd->ops) {
> +			if (value > bd->props.max_brightness)
> +				return -EINVAL;
> +
> +			dev_dbg(&bd->dev, "set brightness to %u\n", value);
> +			bd->props.brightness = value;
> +			rc = backlight_update_status(bd);
> +		}
> +	}
> +	if (rc == 0)
> +		backlight_generate_event(bd, reason);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(backlight_set_brightness);
> +
>  /**
>   * backlight_register_notifier - get notified of backlight (un)registration
>   * @nb: notifier block with the notifier to call on backlight (un)registration
> @@ -548,6 +600,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL(backlight_unregister_notifier);
>  
> +/**
> + * backlight_notify_brightness - notify brightness change to listeners
> + * @bd: backlight device that changed
> + *
> + * Notify registered listeners that the backlight brightness has changed.
> + * This is called automatically after successful brightness updates.
> + */
> +void backlight_notify_brightness(struct backlight_device *bd)
> +{
> +	blocking_notifier_call_chain(&backlight_notifier,
> +				     BACKLIGHT_BRIGHTNESS_CHANGED, bd);
> +}
> +EXPORT_SYMBOL(backlight_notify_brightness);
> +
>  /**
>   * devm_backlight_device_register - register a new backlight device
>   * @dev: the device to register
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 015183d129f96..fac1acbc698a1 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -31,6 +31,12 @@ enum backlight_update_reason {
>  	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
>  	 */
>  	BACKLIGHT_UPDATE_SYSFS,
> +
> +	/**
> +	 * @BACKLIGHT_UPDATE_DRM: The backlight was updated from DRM, i.e. through
> +	 * a connector LUMINANCE property rather than the legacy sysfs interface.
> +	 */
> +	BACKLIGHT_UPDATE_DRM,
>  };
>  
>  /**
> @@ -82,6 +88,11 @@ enum backlight_notification {
>  	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
>  	 */
>  	BACKLIGHT_UNREGISTERED,
> +
> +	/**
> +	 * @BACKLIGHT_BRIGHTNESS_CHANGED: The backlight brightness has changed.
> +	 */
> +	BACKLIGHT_BRIGHTNESS_CHANGED,
>  };
>  
>  /** enum backlight_scale - the type of scale used for brightness values
> @@ -310,8 +321,23 @@ struct backlight_device {
>  	 * @use_count: The number of unblanked displays.
>  	 */
>  	int use_count;
> +
> +	/**
> +	 * @drm_takeover: Number of luminance-aware DRM clients that have
> +	 * taken over brightness control of this device. When non-zero,
> +	 * writes to the legacy sysfs ``brightness`` attribute return
> +	 * ``-EBUSY``. Managed by the DRM backlight helpers.
> +	 */
> +	atomic_t drm_takeover;
>  };
>  
> +/* Forward declaration for backlight_update_status */
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)

I think IS_REACHABLE() is almost always a mistake. It's a hack to avoid
link errors when something in a module needs something that is
built-in. It's a combo that should be handled at Kconfig level, not at
build level.

BR,
Jani.


> +void backlight_notify_brightness(struct backlight_device *bd);
> +#else
> +static inline void backlight_notify_brightness(struct backlight_device *bd) {}
> +#endif
> +
>  /**
>   * backlight_update_status - force an update of the backlight device status
>   * @bd: the backlight device
> @@ -325,6 +351,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
>  		ret = bd->ops->update_status(bd);
>  	mutex_unlock(&bd->update_lock);
>  
> +	/* Notify DRM and other listeners that brightness changed */
> +	if (ret == 0)
> +		backlight_notify_brightness(bd);
> +
>  	return ret;
>  }
>  
> @@ -431,6 +461,21 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
>  { }
>  #endif
>  
> +int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
> +			      enum backlight_update_reason reason);
> +
> +static inline void backlight_device_ref(struct backlight_device *bd)
> +{
> +	if (bd)
> +		get_device(&bd->dev);
> +}
> +
> +static inline void backlight_device_unref(struct backlight_device *bd)
> +{
> +	if (bd)
> +		put_device(&bd->dev);
> +}
> +
>  #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
>  
>  /**

-- 
Jani Nikula, Intel
