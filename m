Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9869FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8A310E95B;
	Tue,  5 May 2026 07:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ZN02lz0d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uiHP0+nA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZN02lz0d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uiHP0+nA";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD2610E94B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 07:08:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F2EBA5CA2B;
 Tue,  5 May 2026 07:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777964896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qmKJS0mjkUx0ZP7rEEd7oK+tRjQ7W9s3aTurYW5DpMU=;
 b=ZN02lz0dYt0eYhak5AIRQ3vSj+Dx9VvvdnHwqvs+4rokn4O5STJDQU7gkofaDPrIDhB+T2
 cXQI7PyShY0gQme2cQubIjfMP58F9hujKsI3X35MgSHp/8jfQJ8QdiVNctqZyD39kvtYV9
 LONp40OEZNL8bkTVg1MOHtBc/MjNvgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777964896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qmKJS0mjkUx0ZP7rEEd7oK+tRjQ7W9s3aTurYW5DpMU=;
 b=uiHP0+nAl15Acyckjh1TJzz6SR60M7WsIEidtKLT66tsjDCVzxLfIb6TBokW04HW4diFRO
 gvyc0ekZCM6zJgDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777964896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qmKJS0mjkUx0ZP7rEEd7oK+tRjQ7W9s3aTurYW5DpMU=;
 b=ZN02lz0dYt0eYhak5AIRQ3vSj+Dx9VvvdnHwqvs+4rokn4O5STJDQU7gkofaDPrIDhB+T2
 cXQI7PyShY0gQme2cQubIjfMP58F9hujKsI3X35MgSHp/8jfQJ8QdiVNctqZyD39kvtYV9
 LONp40OEZNL8bkTVg1MOHtBc/MjNvgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777964896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qmKJS0mjkUx0ZP7rEEd7oK+tRjQ7W9s3aTurYW5DpMU=;
 b=uiHP0+nAl15Acyckjh1TJzz6SR60M7WsIEidtKLT66tsjDCVzxLfIb6TBokW04HW4diFRO
 gvyc0ekZCM6zJgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D528593A7;
 Tue,  5 May 2026 07:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CuVvEV+X+Wl8KwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 05 May 2026 07:08:15 +0000
Message-ID: <af9a1cde-00be-49fd-b236-1cb2bfb4837e@suse.de>
Date: Tue, 5 May 2026 09:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/tiny: panel-ssd16xx: Add power management support
To: Devarsh Thakkar <devarsht@ti.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: praneeth@ti.com, vigneshr@ti.com, s-jain1@ti.com, s-wang12@ti.com,
 r-donadkar@ti.com, r-sharma3@ti.com, afd@ti.com
References: <20260430183311.2978142-1-devarsht@ti.com>
 <20260430183311.2978142-5-devarsht@ti.com>
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
In-Reply-To: <20260430183311.2978142-5-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[dt]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[20];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[ti.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,linaro.org,oss.qualcomm.com,lists.freedesktop.org,vger.kernel.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:url, suse.de:mid]
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

Hi

Am 30.04.26 um 20:33 schrieb Devarsh Thakkar:
> Add system suspend/resume and runtime PM with idle timeout support to
> the SSD16xx driver.

I'll go over this patch after the core driver from patch 3 is ready.

Best regards
Thomas

>
> E-paper panels are bistable: they continue to display the last rendered
> image indefinitely even in deep sleep or when power is cut to the
> controller IC.  This makes it practical to suspend the controller
> aggressively — including while a display application is still open and the
> user is simply reading — without any visible disruption.  The driver
> exploits this by firing the autosuspend timer after an idle timeout,
> putting the controller into deep sleep regardless of CRTC state, and waking
> it transparently on the next frame update.
>
> The SSD16xx family supports two deep sleep modes:
>
> Mode 1 (RAM retained): used for runtime idle.  Display RAM survives the
> sleep, so resume only requires a hardware reset and re-initialisation; no
> full redraw is needed, keeping wake latency minimal.
>
> Mode 2 (RAM lost): used for system suspend.  Maximises power savings at
> the cost of a complete controller re-init and repaint on resume.
>
> Runtime PM: Each hardware-touching callback wraps its SPI access with
> pm_runtime_resume_and_get() / pm_runtime_put_autosuspend() pairs so the PM
> reference count drops to zero after every update.  This allows the
> autosuspend timer to fire while the CRTC is still enabled, putting the
> controller into Mode 1 deep sleep between updates without requiring the
> application to close or the display pipeline to be torn down.
>
> An autosuspend delay of 35 seconds keeps the panel active across typical
> user-interaction gaps while still capturing long idle periods.
>
> System suspend/resume: On system suspend the driver switches to Mode 2 and
> quiesces the atomic pipeline via drm_mode_config_helper_suspend().  If the
> autosuspend timer already fired (device is RPM_SUSPENDED), the driver wakes
> the panel via HWRESET (the only exit from deep sleep since SPI is
> unresponsive), sends Mode 2 directly, and tracks the state with a
> pm_force_suspended flag so the matching force_resume is called only when
> needed.  On resume, Mode 1 is restored for subsequent runtime PM cycles and
> the atomic pipeline is rebuilt via drm_mode_config_helper_resume().
>
> Per-client initialisation refresh: A drm_driver.master_set callback arms
> init_refresh_pending when a new client opens the DRM device as a DRM
> master, ensuring its first frame uses the configured init-refresh waveform.
> A paired master_drop callback clears the flag on fd close by a DRM master.
> This is kept separate from the runtime resume path since Mode 1 retains RAM
> and a full refresh on every runtime wake would be wasteful.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>   drivers/gpu/drm/tiny/panel-ssd16xx.c | 203 +++++++++++++++++++++++++--
>   1 file changed, 193 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/tiny/panel-ssd16xx.c b/drivers/gpu/drm/tiny/panel-ssd16xx.c
> index b232837c54ff..6bf763667d82 100644
> --- a/drivers/gpu/drm/tiny/panel-ssd16xx.c
> +++ b/drivers/gpu/drm/tiny/panel-ssd16xx.c
> @@ -12,6 +12,7 @@
>   #include <linux/delay.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/property.h>
>   #include <linux/spi/spi.h>
>   
> @@ -88,6 +89,7 @@ MODULE_PARM_DESC(color_mode,
>   
>   /* SPI command codes (common) */
>   #define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL		0x01
> +#define SSD16XX_CMD_DEEP_SLEEP_MODE			0x10
>   #define SSD16XX_CMD_DATA_ENTRY_MODE			0x11
>   #define SSD16XX_CMD_SW_RESET				0x12
>   #define SSD16XX_CMD_MASTER_ACTIVATION			0x20
> @@ -100,6 +102,9 @@ MODULE_PARM_DESC(color_mode,
>   #define SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER		0x4E
>   #define SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER		0x4F
>   
> +/* Runtime PM autosuspend delay (ms): keep display active across typical gaps */
> +#define SSD16XX_PM_AUTOSUSPEND_DELAY_MS			35000
> +
>   /*
>    * Data Entry Mode (command 0x11) AM/IDY/IDX bit encoding (common).
>    *
> @@ -405,8 +410,10 @@ struct ssd16xx_panel {
>   	bool init_refresh_pending; /* First frame after refresh_mode_init enable */
>   	bool first_clear_done;  /* clear_on_init has already fired once */
>   	bool display_cleared_on_deinit; /* Avoid redundant clear in atomic_disable/master_drop */
> +	bool pm_force_suspended;  /* pm_runtime_force_suspend was called in pm_suspend */
>   
> -	int orientation; /* Display orientation in degrees: 0/90/180/270 */
> +	int orientation;      /* Display orientation in degrees: 0/90/180/270 */
> +	u8 deep_sleep_mode;   /* Deep sleep mode to use on next disable */
>   	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
>   	enum ssd16xx_color_mode color_mode;     /* Active color mode (BW or 3-color) */
>   	bool fast_lut_pending; /* LUT pre-load needed before next fast refresh */
> @@ -1526,10 +1533,9 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
>   	struct drm_rect rect;
>   	int ret;
>   
> -	drm_dbg(&panel->drm, "plane_atomic_update: fb=%p, initialized=%d\n",
> -		fb, panel->initialized);
> +	drm_dbg(&panel->drm, "plane_atomic_update: fb=%p\n", fb);
>   
> -	if (!fb || !panel->initialized)
> +	if (!fb)
>   		return;
>   
>   	/*
> @@ -1541,6 +1547,12 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
>   		return;
>   	}
>   
> +	ret = pm_runtime_resume_and_get(panel->drm.dev);
> +	if (ret < 0) {
> +		drm_err(&panel->drm, "plane_atomic_update: failed to resume: %d\n", ret);
> +		return;
> +	}
> +
>   	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect)) {
>   		rect.x1 = 0;
>   		rect.y1 = 0;
> @@ -1598,6 +1610,9 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
>   		panel->init_refresh_pending = false;
>   		panel->border_waveform_pending = true;
>   	}
> +
> +	pm_runtime_mark_last_busy(panel->drm.dev);
> +	pm_runtime_put_autosuspend(panel->drm.dev);
>   }
>   
>   static const struct drm_plane_helper_funcs ssd16xx_plane_helper_funcs = {
> @@ -1656,6 +1671,10 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
>   	if (panel->clear_on_disable < 0 || panel->display_cleared_on_deinit)
>   		goto out;
>   
> +	ret = pm_runtime_resume_and_get(panel->drm.dev);
> +	if (ret < 0)
> +		goto out;
> +
>   	drm_dbg(&panel->drm, "clear_on_disable: running, mode=%d\n",
>   		panel->clear_on_disable);
>   	ret = ssd16xx_clear_display(panel,
> @@ -1663,10 +1682,12 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
>   								  panel->clear_on_disable));
>   	if (ret) {
>   		drm_err(&panel->drm, "atomic_disable: clear failed: %d\n", ret);
> +		pm_runtime_put_autosuspend(panel->drm.dev);
>   		goto out;
>   	}
>   
>   	panel->display_cleared_on_deinit = true;
> +	pm_runtime_put_sync_suspend(panel->drm.dev);
>   out:
>   	drm_dev_exit(idx);
>   }
> @@ -1682,6 +1703,12 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
>   		return;
>   
>   	panel->display_cleared_on_deinit = false;
> +	ret = pm_runtime_resume_and_get(panel->drm.dev);
> +	if (ret < 0) {
> +		drm_err(&panel->drm, "crtc_atomic_enable: failed to resume: %d\n", ret);
> +		drm_dev_exit(idx);
> +		return;
> +	}
>   
>   	drm_dbg(&panel->drm, "atomic_enable: %dx%d\n",
>   		crtc_state->mode.hdisplay, crtc_state->mode.vdisplay);
> @@ -1689,12 +1716,19 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
>   	panel->width = crtc_state->mode.hdisplay;
>   	panel->height = crtc_state->mode.vdisplay;
>   
> -	ret = ssd16xx_hw_init(panel);
> -	if (ret) {
> -		drm_err(&panel->drm, "crtc_atomic_enable: HW init failed: %d\n", ret);
> -		goto out;
> +	/*
> +	 * pm_runtime_resume_and_get() triggers pm_runtime_resume which runs
> +	 * hw_init and sets initialized. If runtime PM is disabled the callback
> +	 * never fires, so fall back to running hw_init directly here.
> +	 */
> +	if (!panel->initialized) {
> +		ret = ssd16xx_hw_init(panel);
> +		if (ret) {
> +			drm_err(&panel->drm, "crtc_atomic_enable: HW init failed: %d\n", ret);
> +			goto out;
> +		}
> +		panel->initialized = true;
>   	}
> -	panel->initialized = true;
>   
>   	/* Clear display on first app launch if configured */
>   	ret = ssd16xx_clear_display_on_init(panel);
> @@ -1714,6 +1748,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
>   	}
>   
>   out:
> +	pm_runtime_mark_last_busy(panel->drm.dev);
> +	pm_runtime_put_autosuspend(panel->drm.dev);
>   	drm_dev_exit(idx);
>   }
>   
> @@ -1730,7 +1766,7 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
>   	struct drm_rect full;
>   	int ret, idx;
>   
> -	if (!panel->reinit_pending || !panel->initialized)
> +	if (!panel->reinit_pending)
>   		return;
>   
>   	if (!drm_dev_enter(&panel->drm, &idx))
> @@ -1738,6 +1774,13 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
>   
>   	panel->reinit_pending = false;
>   
> +	ret = pm_runtime_resume_and_get(panel->drm.dev);
> +	if (ret < 0) {
> +		drm_err(&panel->drm, "atomic_flush: failed to resume: %d\n", ret);
> +		drm_dev_exit(idx);
> +		return;
> +	}
> +
>   	drm_dbg(&panel->drm, "atomic_flush: reinit, orientation=%u°\n",
>   		panel->orientation);
>   
> @@ -1762,6 +1805,8 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
>   	}
>   
>   out:
> +	pm_runtime_mark_last_busy(panel->drm.dev);
> +	pm_runtime_put_autosuspend(panel->drm.dev);
>   	drm_dev_exit(idx);
>   }
>   
> @@ -2189,11 +2234,17 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
>   	if (panel->clear_on_close < 0 || panel->display_cleared_on_deinit)
>   		return;
>   
> +	ret = pm_runtime_resume_and_get(drm->dev);
> +	if (ret < 0)
> +		return;
> +
>   	ret = ssd16xx_clear_display_on_exit(panel);
>   	if (ret)
>   		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
>   
>   	panel->display_cleared_on_deinit = true;
> +	/* sync suspend — bypass autosuspend, sleep immediately after clear */
> +	pm_runtime_put_sync_suspend(drm->dev);
>   }
>   
>   static struct drm_driver ssd16xx_drm_driver = {
> @@ -2496,6 +2547,20 @@ static int ssd16xx_probe(struct spi_device *spi)
>   	if (ret)
>   		return ret;
>   
> +	/* Default to runtime sleep mode (RAM retained if supported) */
> +	panel->deep_sleep_mode = panel->controller_cfg->deep_sleep_mode_level1;
> +	/*
> +	 * Mark the device active before enabling runtime PM.  The SPI device
> +	 * persists across module reload cycles; pm_runtime_enable() alone
> +	 * does not clear a stale dev->power.runtime_error left by a previous
> +	 * failed hw_init, which would cause pm_runtime_resume_and_get() to
> +	 * return -EINVAL on every subsequent call.
> +	 */
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, SSD16XX_PM_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
>   	drm_dbg(drm, "SSD16xx e-paper display initialized (%dx%d, %d° rotation)\n",
>   		panel->width, panel->height, panel->orientation);
>   
> @@ -2508,6 +2573,8 @@ static void ssd16xx_remove(struct spi_device *spi)
>   {
>   	struct ssd16xx_panel *panel = spi_get_drvdata(spi);
>   
> +	pm_runtime_dont_use_autosuspend(&spi->dev);
> +	pm_runtime_disable(&spi->dev);
>   	drm_dev_unplug(&panel->drm);
>   	drm_atomic_helper_shutdown(&panel->drm);
>   }
> @@ -2516,9 +2583,124 @@ static void ssd16xx_shutdown(struct spi_device *spi)
>   {
>   	struct ssd16xx_panel *panel = spi_get_drvdata(spi);
>   
> +	pm_runtime_dont_use_autosuspend(&spi->dev);
> +	pm_runtime_disable(&spi->dev);
>   	drm_atomic_helper_shutdown(&panel->drm);
>   }
>   
> +static int ssd16xx_pm_suspend(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +	struct ssd16xx_panel *panel = to_ssd16xx_panel(drm);
> +	int ret;
> +
> +	/* System suspend: Mode 2 (max savings, RAM lost, full re-init on resume). */
> +	panel->deep_sleep_mode = panel->controller_cfg->deep_sleep_mode_level2;
> +	dev_dbg(dev, "system suspend: entering deep sleep mode 0x%02x\n",
> +		panel->deep_sleep_mode);
> +
> +	ret = drm_mode_config_helper_suspend(drm);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * With per-update PM gating the panel may already be in MODE_1 deep
> +	 * sleep (autosuspend fired while the user was reading).
> +	 * pm_runtime_force_suspend() skips its callback when the device is
> +	 * already RPM_SUSPENDED, so MODE_2 would never reach the hardware.
> +	 *
> +	 * Per the datasheet, HWRESET is the only way to exit deep sleep (SPI
> +	 * is unresponsive in both modes).  After the reset, MODE_2 can be
> +	 * sent immediately — no full hw_init is required.  The RPM state
> +	 * remains RPM_SUSPENDED; pm_runtime_force_suspend() is skipped since
> +	 * the device is already in the right state.
> +	 */
> +	if (pm_runtime_status_suspended(dev)) {
> +		int err = 0;
> +
> +		dev_dbg(dev, "system suspend: upgrading MODE_1 -> MODE_2 via HWRESET\n");
> +		ssd16xx_hw_reset(panel);
> +		ssd16xx_send_cmd(panel, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
> +		ssd16xx_send_data(panel, panel->controller_cfg->deep_sleep_mode_level2, &err);
> +		panel->pm_force_suspended = false;  /* Skip force_resume on resume */
> +		return err;
> +	}
> +
> +	/* Force runtime-suspended state for clean resume. */
> +	pm_runtime_force_suspend(dev);
> +	panel->pm_force_suspended = true;  /* Resume must call force_resume */
> +
> +	return 0;
> +}
> +
> +static int ssd16xx_pm_resume(struct device *dev)
> +{
> +	struct drm_device *drm = dev_get_drvdata(dev);
> +	struct ssd16xx_panel *panel = to_ssd16xx_panel(drm);
> +
> +	dev_dbg(dev, "system resume: restoring state\n");
> +
> +	/*
> +	 * Only call force_resume if we actually called force_suspend during
> +	 * system suspend. The MODE_1->MODE_2 upgrade path skips force_suspend
> +	 * since the device is already RPM_SUSPENDED.
> +	 */
> +	if (panel->pm_force_suspended) {
> +		pm_runtime_force_resume(dev);
> +		panel->pm_force_suspended = false;
> +	}
> +
> +	/* Restore Mode 1 (RAM retained) for subsequent runtime PM cycles. */
> +	panel->deep_sleep_mode = panel->controller_cfg->deep_sleep_mode_level1;
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +
> +static int ssd16xx_pm_runtime_suspend(struct device *dev)
> +{
> +	struct ssd16xx_panel *panel = to_ssd16xx_panel(dev_get_drvdata(dev));
> +	int err = 0;
> +
> +	dev_dbg(dev, "runtime suspend: entering deep sleep mode 0x%02x\n",
> +		panel->deep_sleep_mode);
> +
> +	ssd16xx_send_cmd(panel, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
> +	ssd16xx_send_data(panel, panel->deep_sleep_mode, &err);
> +	panel->initialized = false;
> +
> +	return err;
> +}
> +
> +static int ssd16xx_pm_runtime_resume(struct device *dev)
> +{
> +	struct ssd16xx_panel *panel = to_ssd16xx_panel(dev_get_drvdata(dev));
> +	int ret;
> +
> +	dev_dbg(dev, "runtime resume: initialized=%d%s\n",
> +		panel->initialized,
> +		!panel->initialized ? " (running hw_init)" : "");
> +
> +	/*
> +	 * pm_runtime_suspend clears initialized after sending the deep sleep
> +	 * command.  If a new app opens before the suspend fires (the put was
> +	 * cancelled), initialized is still true and hw_init is unnecessary.
> +	 */
> +	if (!panel->initialized) {
> +		ret = ssd16xx_hw_init(panel);
> +		if (ret)
> +			return ret;
> +
> +		panel->initialized = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ssd16xx_pm_ops = {
> +	SYSTEM_SLEEP_PM_OPS(ssd16xx_pm_suspend, ssd16xx_pm_resume)
> +	RUNTIME_PM_OPS(ssd16xx_pm_runtime_suspend, ssd16xx_pm_runtime_resume, NULL)
> +};
> +
>   static const struct of_device_id ssd16xx_of_match[] = {
>   	{ .compatible = "gooddisplay,gdey042t81", .data = (void *)GDEY042T81 },
>   	{ }
> @@ -2535,6 +2717,7 @@ static struct spi_driver ssd16xx_spi_driver = {
>   	.driver = {
>   		.name = "ssd16xx",
>   		.of_match_table = ssd16xx_of_match,
> +		.pm = pm_ptr(&ssd16xx_pm_ops),
>   	},
>   	.probe = ssd16xx_probe,
>   	.remove = ssd16xx_remove,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


