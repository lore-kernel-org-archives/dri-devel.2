Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A09C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3639E10E73D;
	Tue, 22 Sep 2026 08:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="xK5NoVzk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QA1GXq2p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QFNfSnfv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="53hBZT3V";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 177B010E5AB;
 Tue, 22 Sep 2026 08:23:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C7331F769;
 Tue, 22 Sep 2026 08:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790065425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W3ND6DVrzWx/s1g+qbrdwBJ3l+UBU2v/2dJ3/tEVJYM=;
 b=xK5NoVzkOA8RfHUWyIjLPrSa+YoakJWuV+lsrVi80WWlaAGEKZBP+YptjBml7hRDkh4BgI
 PaTZXADl/5rdHbPPCwY7EglFpdqztmNFYjlTgzRuZiG9Ktn/okU2gQza0YONEmUoW8w6zD
 cKMdQw+FqwuviOJ8/Hn483QUxjl0VnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790065425;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W3ND6DVrzWx/s1g+qbrdwBJ3l+UBU2v/2dJ3/tEVJYM=;
 b=QA1GXq2pXotS9o/4FmsK1dWzuRVtv8ftma8DkiKMp0SCoqkyYNlQsmML/wMtgrMB412Jgk
 DK4rHtIC9HMELGCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QFNfSnfv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=53hBZT3V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790065421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W3ND6DVrzWx/s1g+qbrdwBJ3l+UBU2v/2dJ3/tEVJYM=;
 b=QFNfSnfvjZ2RtJUUQpA58DazcdY6xKEyeVNxyraXBRMoQSTCu1Q+i7fax7Uf3sKoywACjt
 39htyB3wvs+P4oWbAf0yggq8OVKmC/KHfVUlO6MIavfmzW9Va8ZO3Nf4U/Cjt1iT7ck/WW
 OSZQyVdjN4RlNrVIkVF9w4VeM3v0Ihg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790065421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W3ND6DVrzWx/s1g+qbrdwBJ3l+UBU2v/2dJ3/tEVJYM=;
 b=53hBZT3Vx5mtfi21vt6KRoLckPXA9pqu7RJhKj/AFMIZPy1aWik97uB/RC45cM9jt4Ihdh
 BrbaPAubMjg+kBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAE81132D3;
 Tue, 22 Sep 2026 08:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GFg9HAw7smrFGwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 22 Sep 2026 08:23:40 +0000
Message-ID: <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
Date: Tue, 22 Sep 2026 10:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260908044035.62093-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5C7331F769
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[amd.com,lists.freedesktop.org,ffwll.ch,linux.intel.com,kernel.org,gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[16];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kernel.org,intel.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.com:url, intel.com:email, suse.de:dkim,
 suse.de:mid]
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

Hi Mario

Am 08.09.26 um 06:40 schrieb Mario Limonciello:
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
>   - rebase
>   - Use guard(mutex)
>
> V4: Mario Limonciello (AMD) <superm1@kernel.org>
>   - Adjust return type for backlight_set_brightness() to return errors
>   - Stop clamping in backlight_set_brightness()
>   - Drop backlight_device_lookup()
>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/video/backlight/backlight.c | 66 +++++++++++++++++++++++++++++
>   include/linux/backlight.h           | 45 ++++++++++++++++++++
>   2 files changed, 111 insertions(+)
>
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 4401f6294ccc8..1c700c1e77c3f 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -126,6 +126,9 @@ static void backlight_generate_event(struct backlight_device *bd,
>   	case BACKLIGHT_UPDATE_HOTKEY:
>   		envp[0] = "SOURCE=hotkey";
>   		break;
> +	case BACKLIGHT_UPDATE_DRM:
> +		envp[0] = "SOURCE=drm";
> +		break;
>   	default:
>   		envp[0] = "SOURCE=unknown";
>   		break;
> @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>   	struct backlight_device *bd = to_backlight_device(dev);
>   	unsigned long power, old_power;
>   
> +	/* A luminance-aware DRM client has taken over this backlight; the
> +	 * legacy sysfs interface is disabled until the last such client
> +	 * goes away.
> +	 */
> +	if (atomic_read(&bd->drm_takeover) > 0)
> +		return -EBUSY;
> +
>   	rc = kstrtoul(buf, 0, &power);
>   	if (rc)
>   		return rc;
> @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device *dev,
>   	struct backlight_device *bd = to_backlight_device(dev);
>   	unsigned long brightness;
>   
> +	/* A luminance-aware DRM client has taken over this backlight; the
> +	 * legacy sysfs interface is disabled until the last such client
> +	 * goes away.
> +	 */
> +	if (atomic_read(&bd->drm_takeover) > 0)
> +		return -EBUSY;

Can you really do that?  AFAIU sysfs is now a de-facto uapi for backlights.


> +
>   	rc = kstrtoul(buf, 0, &brightness);
>   	if (rc)
>   		return rc;
> @@ -514,6 +531,41 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>   	return *r == data;
>   }
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
>   /**
>    * backlight_register_notifier - get notified of backlight (un)registration
>    * @nb: notifier block with the notifier to call on backlight (un)registration
> @@ -548,6 +600,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL(backlight_unregister_notifier);
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

With the sysfs interfaces disabled, who is going to trigger this code 
except DRM?

AFAICT when the DRM connector updates the backlight status, backlight 
runs this notifier only to call back into DRM to read back the value. 
But the luminance property should already store that same value.

Best regards
Thomas

> +
>   /**
>    * devm_backlight_device_register - register a new backlight device
>    * @dev: the device to register
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 015183d129f96..fac1acbc698a1 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -31,6 +31,12 @@ enum backlight_update_reason {
>   	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
>   	 */
>   	BACKLIGHT_UPDATE_SYSFS,
> +
> +	/**
> +	 * @BACKLIGHT_UPDATE_DRM: The backlight was updated from DRM, i.e. through
> +	 * a connector LUMINANCE property rather than the legacy sysfs interface.
> +	 */
> +	BACKLIGHT_UPDATE_DRM,
>   };
>   
>   /**
> @@ -82,6 +88,11 @@ enum backlight_notification {
>   	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
>   	 */
>   	BACKLIGHT_UNREGISTERED,
> +
> +	/**
> +	 * @BACKLIGHT_BRIGHTNESS_CHANGED: The backlight brightness has changed.
> +	 */
> +	BACKLIGHT_BRIGHTNESS_CHANGED,
>   };
>   
>   /** enum backlight_scale - the type of scale used for brightness values
> @@ -310,8 +321,23 @@ struct backlight_device {
>   	 * @use_count: The number of unblanked displays.
>   	 */
>   	int use_count;
> +
> +	/**
> +	 * @drm_takeover: Number of luminance-aware DRM clients that have
> +	 * taken over brightness control of this device. When non-zero,
> +	 * writes to the legacy sysfs ``brightness`` attribute return
> +	 * ``-EBUSY``. Managed by the DRM backlight helpers.
> +	 */
> +	atomic_t drm_takeover;
>   };
>   
> +/* Forward declaration for backlight_update_status */
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +void backlight_notify_brightness(struct backlight_device *bd);
> +#else
> +static inline void backlight_notify_brightness(struct backlight_device *bd) {}
> +#endif
> +
>   /**
>    * backlight_update_status - force an update of the backlight device status
>    * @bd: the backlight device
> @@ -325,6 +351,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
>   		ret = bd->ops->update_status(bd);
>   	mutex_unlock(&bd->update_lock);
>   
> +	/* Notify DRM and other listeners that brightness changed */
> +	if (ret == 0)
> +		backlight_notify_brightness(bd);
> +
>   	return ret;
>   }
>   
> @@ -431,6 +461,21 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
>   { }
>   #endif
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
>   #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
>   
>   /**

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


