Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087EFCD98E6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 06:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EEC10F455;
	Fri, 19 Jun 2026 06:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="e/ChM2/L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k1+VIVyB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WFdoU/F0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tq3RgdMt";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7BB10E05B
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 06:25:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE2886D8FE;
 Fri, 19 Jun 2026 06:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781850313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvnMRN0gvEwFmK1FbFOHnivTVJZdxGkV9S8yV/F04y4=;
 b=e/ChM2/LQyXoqWc7sI36uMWE8c5ioK6WXfcSqi//90sEFBWvWr+Zz9OPHL2PadXF6HUrxu
 TxW9EQfEaZsLXaMi17dgLeMd3pOTaOqrBiM9imWQg0x7mPzcq8tE1JwwsENMVAt1CsIBhC
 PZmy0xM2JhjOLwfI5u/27lQqzAJOiAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781850313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvnMRN0gvEwFmK1FbFOHnivTVJZdxGkV9S8yV/F04y4=;
 b=k1+VIVyBLXmyjHIVZ3WAH7fOUNOAHEYuuhx2uO9yQftPhYzybJ484y9kq3+piqgwJuWzBw
 LFR7X7Mra2gsfzAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="WFdoU/F0";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tq3RgdMt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781850311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvnMRN0gvEwFmK1FbFOHnivTVJZdxGkV9S8yV/F04y4=;
 b=WFdoU/F0jXtoplP8Ue2kqxii0jyocWiHUtgU3zknSCzkhRM0eBMMhgoZfFhkf/NyWGIVJ0
 Ca2l5Ark8bgwPmCAnzD4iaQ0jYWdTGYGJ2QggYuvZKBQMlcDVPV8Xj4NZ8bqR5eQgWPTHR
 MMsvAcLHN8gVn4ubzrvRxXu/Q8g/88k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781850311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lvnMRN0gvEwFmK1FbFOHnivTVJZdxGkV9S8yV/F04y4=;
 b=tq3RgdMt/XwpOlK+P+HUuXMpHzYx2BJT3OrDbk3n0cvNV4uQ7FSmHAiU5jITus4nDvdyQc
 ZEdQOjDCHmNIdkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5A55779A8;
 Fri, 19 Jun 2026 06:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 840HK8fgNGqzLQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 06:25:11 +0000
Message-ID: <9937cd6d-7724-47bf-8bf6-a5d0580bdd60@suse.de>
Date: Fri, 19 Jun 2026 08:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: cleanup duplicate dependencies in kconfig
To: Julian Braha <julianbraha@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260618204654.458654-1-julianbraha@gmail.com>
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
In-Reply-To: <20260618204654.458654-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE2886D8FE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,i.mx:url,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Am 18.06.26 um 22:46 schrieb Julian Braha:
> There is already an 'if DRM..endif' wrapping all of the source entries for
> the nested Kconfig files, meaning that the config options in these
> directories already depend on DRM. Yet, some of them have another,
> additional 'depends on DRM', which is unnecessary.

Is there a functional difference between 'if' and 'depends on'?

IMHO it would be nicer to remove the if.

Best regards
Thomas

>
> By my counts, there are 568 config options under this directory, of which
> 141 have the duplicated DRM dependency.
>
> These duplicate dependencies were found by kconfirm, a static analysis tool
> for Kconfig.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>   drivers/gpu/drm/Kconfig                  | 32 ++++++------------------
>   drivers/gpu/drm/Kconfig.debug            | 14 +++++------
>   drivers/gpu/drm/adp/Kconfig              |  2 +-
>   drivers/gpu/drm/amd/amdgpu/Kconfig       |  2 +-
>   drivers/gpu/drm/amd/display/Kconfig      |  2 +-
>   drivers/gpu/drm/arm/Kconfig              |  5 ++--
>   drivers/gpu/drm/arm/display/Kconfig      |  2 +-
>   drivers/gpu/drm/armada/Kconfig           |  2 +-
>   drivers/gpu/drm/aspeed/Kconfig           |  2 +-
>   drivers/gpu/drm/ast/Kconfig              |  3 +--
>   drivers/gpu/drm/atmel-hlcdc/Kconfig      |  2 +-
>   drivers/gpu/drm/bridge/Kconfig           |  6 ++---
>   drivers/gpu/drm/bridge/analogix/Kconfig  |  2 --
>   drivers/gpu/drm/clients/Kconfig          |  2 --
>   drivers/gpu/drm/display/Kconfig          |  2 --
>   drivers/gpu/drm/etnaviv/Kconfig          |  1 -
>   drivers/gpu/drm/fsl-dcu/Kconfig          |  2 +-
>   drivers/gpu/drm/gma500/Kconfig           |  2 +-
>   drivers/gpu/drm/gud/Kconfig              |  2 +-
>   drivers/gpu/drm/hisilicon/hibmc/Kconfig  |  2 +-
>   drivers/gpu/drm/hisilicon/kirin/Kconfig  |  3 +--
>   drivers/gpu/drm/hyperv/Kconfig           |  2 +-
>   drivers/gpu/drm/i915/Kconfig             |  1 -
>   drivers/gpu/drm/imagination/Kconfig      |  1 -
>   drivers/gpu/drm/imx/dc/Kconfig           |  2 +-
>   drivers/gpu/drm/imx/dcss/Kconfig         |  2 +-
>   drivers/gpu/drm/imx/ipuv3/Kconfig        |  2 +-
>   drivers/gpu/drm/imx/lcdc/Kconfig         |  2 +-
>   drivers/gpu/drm/ingenic/Kconfig          |  1 -
>   drivers/gpu/drm/kmb/Kconfig              |  1 -
>   drivers/gpu/drm/lima/Kconfig             |  1 -
>   drivers/gpu/drm/logicvc/Kconfig          |  1 -
>   drivers/gpu/drm/loongson/Kconfig         |  2 +-
>   drivers/gpu/drm/mcde/Kconfig             |  1 -
>   drivers/gpu/drm/mediatek/Kconfig         |  1 -
>   drivers/gpu/drm/meson/Kconfig            |  2 +-
>   drivers/gpu/drm/mgag200/Kconfig          |  2 +-
>   drivers/gpu/drm/msm/Kconfig              |  1 -
>   drivers/gpu/drm/mxsfb/Kconfig            |  4 +--
>   drivers/gpu/drm/nouveau/Kconfig          |  2 +-
>   drivers/gpu/drm/omapdrm/Kconfig          |  2 +-
>   drivers/gpu/drm/panel/Kconfig            |  3 +--
>   drivers/gpu/drm/panfrost/Kconfig         |  1 -
>   drivers/gpu/drm/panthor/Kconfig          |  1 -
>   drivers/gpu/drm/pl111/Kconfig            |  2 --
>   drivers/gpu/drm/qxl/Kconfig              |  2 +-
>   drivers/gpu/drm/radeon/Kconfig           |  2 +-
>   drivers/gpu/drm/renesas/rcar-du/Kconfig  |  4 +--
>   drivers/gpu/drm/renesas/rz-du/Kconfig    |  2 +-
>   drivers/gpu/drm/renesas/shmobile/Kconfig |  3 +--
>   drivers/gpu/drm/rockchip/Kconfig         |  1 -
>   drivers/gpu/drm/sitronix/Kconfig         |  8 +++---
>   drivers/gpu/drm/solomon/Kconfig          |  2 +-
>   drivers/gpu/drm/sprd/Kconfig             |  3 +--
>   drivers/gpu/drm/stm/Kconfig              |  2 +-
>   drivers/gpu/drm/sun4i/Kconfig            |  2 +-
>   drivers/gpu/drm/sysfb/Kconfig            | 12 ++++-----
>   drivers/gpu/drm/tegra/Kconfig            |  1 -
>   drivers/gpu/drm/tidss/Kconfig            |  2 +-
>   drivers/gpu/drm/tilcdc/Kconfig           |  2 +-
>   drivers/gpu/drm/tiny/Kconfig             | 30 +++++++++++-----------
>   drivers/gpu/drm/tve200/Kconfig           |  1 -
>   drivers/gpu/drm/udl/Kconfig              |  1 -
>   drivers/gpu/drm/v3d/Kconfig              |  1 -
>   drivers/gpu/drm/vboxvideo/Kconfig        |  2 +-
>   drivers/gpu/drm/vc4/Kconfig              |  1 -
>   drivers/gpu/drm/verisilicon/Kconfig      |  2 +-
>   drivers/gpu/drm/vgem/Kconfig             |  2 +-
>   drivers/gpu/drm/virtio/Kconfig           |  2 +-
>   drivers/gpu/drm/vkms/Kconfig             |  2 +-
>   drivers/gpu/drm/vmwgfx/Kconfig           |  3 +--
>   drivers/gpu/drm/xe/Kconfig               |  2 +-
>   72 files changed, 86 insertions(+), 143 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f..9f2a103b5c0b 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -26,36 +26,31 @@ menuconfig DRM
>   	  details.  You should also select and configure AGP
>   	  (/dev/agpgart) support if it is available for your platform.
>   
> +if DRM
> +
>   menu "DRM debugging options"
> -depends on DRM
>   source "drivers/gpu/drm/Kconfig.debug"
>   endmenu
>   
> -if DRM
> -
>   config DRM_MIPI_DBI
>   	tristate
> -	depends on DRM
>   	select DRM_KMS_HELPER
>   
>   config DRM_MIPI_DSI
>   	bool
> -	depends on DRM
>   
>   config DRM_KMS_HELPER
>   	tristate
> -	depends on DRM
>   	select FB_CORE if DRM_FBDEV_EMULATION
>   	help
>   	  CRTC helpers for KMS drivers.
>   
>   config DRM_DRAW
>   	bool
> -	depends on DRM
>   
>   config DRM_PANIC
>   	bool "Display a user-friendly message when a kernel panic occurs"
> -	depends on DRM && PRINTK
> +	depends on PRINTK
>   	select FONT_SUPPORT
>   	select DRM_DRAW
>   	help
> @@ -132,7 +127,6 @@ config DRM_PANIC_SCREEN_QR_VERSION
>   
>   config DRM_RAS
>   	bool "DRM RAS support"
> -	depends on DRM
>   	depends on NET
>   	help
>   	  Enables the DRM RAS (Reliability, Availability and Serviceability)
> @@ -172,7 +166,6 @@ config DRM_DEBUG_MODESET_LOCK
>   
>   config DRM_CLIENT
>   	bool
> -	depends on DRM
>   	help
>   	  Enables support for DRM clients. DRM drivers that need
>   	  struct drm_client_dev and its interfaces should select this
> @@ -183,7 +176,6 @@ source "drivers/gpu/drm/clients/Kconfig"
>   
>   config DRM_LOAD_EDID_FIRMWARE
>   	bool "Allow to specify an EDID data set instead of probing for it"
> -	depends on DRM
>   	help
>   	  Say Y here, if you want to use EDID data to be loaded from the
>   	  /lib/firmware directory or one of the provided built-in
> @@ -197,7 +189,7 @@ source "drivers/gpu/drm/display/Kconfig"
>   
>   config DRM_TTM
>   	tristate
> -	depends on DRM && MMU
> +	depends on MMU
>   	select SHMEM
>   	help
>   	  GPU memory management subsystem for devices with multiple
> @@ -206,13 +198,11 @@ config DRM_TTM
>   
>   config DRM_EXEC
>   	tristate
> -	depends on DRM
>   	help
>   	  Execution context for command submissions
>   
>   config DRM_GPUVM
>   	tristate
> -	depends on DRM
>   	select DRM_EXEC
>   	help
>   	  GPU-VM representation providing helpers to manage a GPUs virtual
> @@ -220,14 +210,12 @@ config DRM_GPUVM
>   
>   config RUST_DRM_GPUVM
>   	bool
> -	depends on DRM
>   	select DRM_GPUVM
>   	help
>   	  Choose this if you need GPUVM functions in Rust
>   
>   config DRM_GPUSVM
>   	tristate
> -	depends on DRM
>   	select HMM_MIRROR
>   	select MMU_NOTIFIER
>   	help
> @@ -236,20 +224,17 @@ config DRM_GPUSVM
>   
>   config DRM_BUDDY
>   	tristate
> -	depends on DRM
>   	select GPU_BUDDY
>   	help
>   	  A page based buddy allocator
>   
>   config DRM_VRAM_HELPER
>   	tristate
> -	depends on DRM
>   	help
>   	  Helpers for VRAM memory management
>   
>   config DRM_TTM_HELPER
>   	tristate
> -	depends on DRM
>   	select DRM_TTM
>   	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>   	select FB_CORE if DRM_FBDEV_EMULATION
> @@ -259,7 +244,6 @@ config DRM_TTM_HELPER
>   
>   config DRM_GEM_DMA_HELPER
>   	tristate
> -	depends on DRM
>   	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>   	select FB_CORE if DRM_FBDEV_EMULATION
>   	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
> @@ -268,7 +252,7 @@ config DRM_GEM_DMA_HELPER
>   
>   config DRM_GEM_SHMEM_HELPER
>   	tristate
> -	depends on DRM && MMU
> +	depends on MMU
>   	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>   	select FB_CORE if DRM_FBDEV_EMULATION
>   	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
> @@ -277,18 +261,16 @@ config DRM_GEM_SHMEM_HELPER
>   
>   config RUST_DRM_GEM_SHMEM_HELPER
>   	bool
> -	depends on DRM && MMU
> +	depends on MMU
>   	select DRM_GEM_SHMEM_HELPER
>   	help
>   	  Choose this if you need the GEM shmem helper functions In Rust
>   
>   config DRM_SUBALLOC_HELPER
>   	tristate
> -	depends on DRM
>   
>   config DRM_SCHED
>   	tristate
> -	depends on DRM
>   
>   # Separate option as not all DRM drivers use it
>   config DRM_PANEL_BACKLIGHT_QUIRKS
> @@ -365,7 +347,7 @@ source "drivers/gpu/drm/xe/Kconfig"
>   source "drivers/gpu/drm/xen/Kconfig"
>   source "drivers/gpu/drm/xlnx/Kconfig"
>   
> -endif
> +endif # DRM
>   
>   # Separate option because drm_panel_orientation_quirks.c is shared with fbdev
>   config DRM_PANEL_ORIENTATION_QUIRKS
> diff --git a/drivers/gpu/drm/Kconfig.debug b/drivers/gpu/drm/Kconfig.debug
> index 1f4c98cbf090..99f8b255f81a 100644
> --- a/drivers/gpu/drm/Kconfig.debug
> +++ b/drivers/gpu/drm/Kconfig.debug
> @@ -2,7 +2,6 @@ config DRM_USE_DYNAMIC_DEBUG
>   	bool "use dynamic debug to implement drm.debug"
>   	default n
>   	depends on BROKEN
> -	depends on DRM
>   	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
>   	depends on JUMP_LABEL
>   	help
> @@ -13,7 +12,7 @@ config DRM_USE_DYNAMIC_DEBUG
>   
>   config DRM_WERROR
>   	bool "Compile the drm subsystem with warnings as errors"
> -	depends on DRM && EXPERT
> +	depends on EXPERT
>   	depends on !WERROR
>   	default n
>   	help
> @@ -27,7 +26,7 @@ config DRM_WERROR
>   
>   config DRM_HEADER_TEST
>   	bool "Ensure DRM headers are self-contained and pass kernel-doc"
> -	depends on DRM && EXPERT && BROKEN
> +	depends on EXPERT && BROKEN
>   	default n
>   	help
>   	  Ensure the DRM subsystem headers both under drivers/gpu/drm and
> @@ -39,7 +38,6 @@ config DRM_HEADER_TEST
>   config DRM_DEBUG_MM
>   	bool "Insert extra checks and debug info into the DRM range managers"
>   	default n
> -	depends on DRM
>   	depends on STACKTRACE_SUPPORT
>   	select STACKDEPOT
>   	help
> @@ -52,14 +50,14 @@ config DRM_DEBUG_MM
>   
>   config DRM_KUNIT_TEST_HELPERS
>   	tristate
> -	depends on DRM && KUNIT
> +	depends on KUNIT
>   	select DRM_KMS_HELPER
>   	help
>   	  KUnit Helpers for KMS drivers.
>   
>   config DRM_KUNIT_TEST
>   	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
> -	depends on DRM && KUNIT && MMU
> +	depends on KUNIT && MMU
>   	select DRM_BRIDGE_CONNECTOR
>   	select DRM_BUDDY
>   	select DRM_DISPLAY_DP_HELPER
> @@ -85,7 +83,7 @@ config DRM_KUNIT_TEST
>   
>   config DRM_TTM_KUNIT_TEST
>   	tristate "KUnit tests for TTM" if !KUNIT_ALL_TESTS
> -	depends on DRM && KUNIT && MMU && (UML || COMPILE_TEST)
> +	depends on KUNIT && MMU && (UML || COMPILE_TEST)
>   	select DRM_TTM
>   	select DRM_BUDDY
>   	select DRM_EXPORT_FOR_TESTS if m
> @@ -102,7 +100,7 @@ config DRM_TTM_KUNIT_TEST
>   config DRM_SCHED_KUNIT_TEST
>   	tristate "KUnit tests for the DRM scheduler" if !KUNIT_ALL_TESTS
>   	select DRM_SCHED
> -	depends on DRM && KUNIT
> +	depends on KUNIT
>   	default KUNIT_ALL_TESTS
>   	help
>   	  Choose this option to build unit tests for the DRM scheduler.
> diff --git a/drivers/gpu/drm/adp/Kconfig b/drivers/gpu/drm/adp/Kconfig
> index 9fcc27eb200d..5e0225811c64 100644
> --- a/drivers/gpu/drm/adp/Kconfig
> +++ b/drivers/gpu/drm/adp/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only OR MIT
>   config DRM_ADP
>   	tristate "DRM Support for pre-DCP Apple display controllers"
> -	depends on DRM && OF && ARM64
> +	depends on OF && ARM64
>   	depends on ARCH_APPLE || COMPILE_TEST
>   	select DRM_KMS_HELPER
>   	select DRM_BRIDGE_CONNECTOR
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 12e4a41bf1f0..f9e1ad1205cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config DRM_AMDGPU
>   	tristate "AMD GPU"
> -	depends on DRM && PCI
> +	depends on PCI
>   	select FW_LOADER
>   	select DRM_CLIENT
>   	select DRM_CLIENT_SELECTION
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 1727d25646cc..e51f08f73403 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -2,7 +2,7 @@
>   # Copyright © 2019-2024 Advanced Micro Devices, Inc. All rights reserved.
>   
>   menu "Display Engine Configuration"
> -	depends on DRM && DRM_AMDGPU
> +	depends on DRM_AMDGPU
>   
>   config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index ed3ed617c688..f68e23a40dc1 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -1,10 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0
>   menu "ARM devices"
> -	depends on DRM
>   
>   config DRM_HDLCD
>   	tristate "ARM HDLCD"
> -	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
> +	depends on OF && (ARM || ARM64 || COMPILE_TEST)
>   	depends on COMMON_CLK
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> @@ -27,7 +26,7 @@ config DRM_HDLCD_SHOW_UNDERRUN
>   
>   config DRM_MALI_DISPLAY
>   	tristate "ARM Mali Display Processor"
> -	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
> +	depends on OF && (ARM || ARM64 || COMPILE_TEST)
>   	depends on COMMON_CLK
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/display/Kconfig
> index 415c10a6374b..cb281867d958 100644
> --- a/drivers/gpu/drm/arm/display/Kconfig
> +++ b/drivers/gpu/drm/arm/display/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config DRM_KOMEDA
>   	tristate "ARM Komeda display driver"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on COMMON_CLK
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/armada/Kconfig b/drivers/gpu/drm/armada/Kconfig
> index b22c891a670b..dfa2b81b6c0c 100644
> --- a/drivers/gpu/drm/armada/Kconfig
> +++ b/drivers/gpu/drm/armada/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_ARMADA
>   	tristate "DRM support for Marvell Armada SoCs"
> -	depends on DRM && HAVE_CLK && ARM && MMU
> +	depends on HAVE_CLK && ARM && MMU
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
> diff --git a/drivers/gpu/drm/aspeed/Kconfig b/drivers/gpu/drm/aspeed/Kconfig
> index 6e68f20aac21..b3dd5c7e6655 100644
> --- a/drivers/gpu/drm/aspeed/Kconfig
> +++ b/drivers/gpu/drm/aspeed/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_ASPEED_GFX
>   	tristate "ASPEED BMC Display Controller"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on (COMPILE_TEST || ARCH_ASPEED)
>   	depends on MMU
>   	select DRM_CLIENT_SELECTION
> diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
> index 242fbccdf844..6fc92923c904 100644
> --- a/drivers/gpu/drm/ast/Kconfig
> +++ b/drivers/gpu/drm/ast/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_AST
>   	tristate "AST server chips"
> -	depends on DRM && PCI
> +	depends on PCI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KMS_HELPER
> @@ -13,4 +13,3 @@ config DRM_AST
>   	 and a version of AST that knows to fail if KMS
>   	 is bound to the driver. These GPUs are commonly found
>   	 in server chipsets.
> -
> diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> index f8b9c91907d8..c8ff28561a34 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/Kconfig
> +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_ATMEL_HLCDC
>   	tristate "DRM Support for ATMEL HLCDC Display Controller"
> -	depends on DRM && OF && COMMON_CLK && ((MFD_ATMEL_HLCDC && ARM) || COMPILE_TEST)
> +	depends on OF && COMMON_CLK && ((MFD_ATMEL_HLCDC && ARM) || COMPILE_TEST)
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 4a57d49b4c6d..b37a53e5cbe3 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_BRIDGE
>   	def_bool y
> -	depends on DRM
>   	help
>   	  Bridge registration and lookup framework.
>   
> @@ -31,7 +30,7 @@ config DRM_AUX_HPD_BRIDGE
>   	  support.
>   
>   menu "Display Interface Bridges"
> -	depends on DRM && DRM_BRIDGE
> +	depends on DRM_BRIDGE
>   
>   config DRM_CHIPONE_ICN6211
>   	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
> @@ -241,7 +240,6 @@ config DRM_MICROCHIP_LVDS_SERIALIZER
>   
>   config DRM_NWL_MIPI_DSI
>   	tristate "Northwest Logic MIPI DSI Host controller"
> -	depends on DRM
>   	depends on COMMON_CLK
>   	depends on OF && HAS_IOMEM
>   	select DRM_KMS_HELPER
> @@ -430,7 +428,7 @@ config DRM_TOSHIBA_TC358775
>   
>   config DRM_TI_DLPC3433
>   	tristate "TI DLPC3433 Display controller"
> -	depends on DRM && DRM_PANEL
> +	depends on DRM_PANEL
>   	depends on OF
>   	select DRM_MIPI_DSI
>   	help
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> index 57bb2daa5aaf..6c4aa04fb924 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -29,13 +29,11 @@ config DRM_ANALOGIX_ANX78XX
>   
>   config DRM_ANALOGIX_DP
>   	tristate
> -	depends on DRM
>   	depends on OF
>   	select DRM_DISPLAY_DP_AUX_BUS
>   
>   config DRM_ANALOGIX_ANX7625
>   	tristate "Analogix Anx7625 MIPI to DP interface support"
> -	depends on DRM
>   	depends on OF
>   	depends on TYPEC
>   	depends on USB_ROLE_SWITCH
> diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
> index 6096c623d9d5..03a0d243d1f6 100644
> --- a/drivers/gpu/drm/clients/Kconfig
> +++ b/drivers/gpu/drm/clients/Kconfig
> @@ -2,7 +2,6 @@
>   
>   config DRM_CLIENT_LIB
>   	tristate
> -	depends on DRM
>   	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
>   	select FB_CORE if DRM_FBDEV_EMULATION
>   	help
> @@ -11,7 +10,6 @@ config DRM_CLIENT_LIB
>   
>   config DRM_CLIENT_SELECTION
>   	tristate
> -	depends on DRM
>   	select DRM_CLIENT_LIB if DRM_CLIENT_LOG
>   	select DRM_CLIENT_LIB if DRM_FBDEV_EMULATION
>   	help
> diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
> index df09cf9a8ca1..bbfbbb7f9478 100644
> --- a/drivers/gpu/drm/display/Kconfig
> +++ b/drivers/gpu/drm/display/Kconfig
> @@ -2,12 +2,10 @@
>   
>   config DRM_DISPLAY_DP_AUX_BUS
>   	tristate
> -	depends on DRM
>   	depends on OF
>   
>   config DRM_DISPLAY_HELPER
>   	tristate
> -	depends on DRM
>   	select CEC_CORE if DRM_DISPLAY_DP_AUX_CEC || DRM_DISPLAY_HDMI_CEC_HELPER || CEC_NOTIFIER
>   	help
>   	  DRM helpers for display adapters.
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index faa7fc68b009..0a1c8b0b6f37 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -2,7 +2,6 @@
>   
>   config DRM_ETNAVIV
>   	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
> -	depends on DRM
>   	depends on MMU
>   	select SHMEM
>   	select SYNC_FILE
> diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
> index 0e0f910ceb9f..f42d1fa3690f 100644
> --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_FSL_DCU
>   	tristate "DRM Support for Freescale DCU"
> -	depends on DRM && OF && ARM && COMMON_CLK
> +	depends on OF && ARM && COMMON_CLK
>   	select BACKLIGHT_CLASS_DEVICE
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> index a2acaa699dd5..efde10ded8f6 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_GMA500
>   	tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> -	depends on DRM && PCI && X86 && HAS_IOPORT
> +	depends on PCI && X86 && HAS_IOPORT
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select FB_IOMEM_HELPERS if DRM_FBDEV_EMULATION
> diff --git a/drivers/gpu/drm/gud/Kconfig b/drivers/gpu/drm/gud/Kconfig
> index b4d2136942f0..e86faeccf032 100644
> --- a/drivers/gpu/drm/gud/Kconfig
> +++ b/drivers/gpu/drm/gud/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config DRM_GUD
>   	tristate "GUD USB Display"
> -	depends on DRM && USB && MMU
> +	depends on USB && MMU
>   	select LZ4_COMPRESS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> index d1f3f5793f34..d2d78e57678f 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_HISI_HIBMC
>   	tristate "DRM Support for Hisilicon Hibmc"
> -	depends on DRM && PCI
> +	depends on PCI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_DISPLAY_HELPER
>   	select DRM_DISPLAY_DP_HELPER
> diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> index 43e8a4fd2d11..95f2010d4d93 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_HISI_KIRIN
>   	tristate "DRM Support for Hisilicon Kirin series SoCs Platform"
> -	depends on DRM && OF && (ARM64 || COMPILE_TEST)
> +	depends on OF && (ARM64 || COMPILE_TEST)
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -9,4 +9,3 @@ config DRM_HISI_KIRIN
>   	help
>   	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
>   	  If M is selected the module will be called kirin-drm.
> -
> diff --git a/drivers/gpu/drm/hyperv/Kconfig b/drivers/gpu/drm/hyperv/Kconfig
> index e48e35fb7f8b..8afd731ec340 100644
> --- a/drivers/gpu/drm/hyperv/Kconfig
> +++ b/drivers/gpu/drm/hyperv/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_HYPERV
>   	tristate "DRM Support for Hyper-V synthetic video device"
> -	depends on DRM && PCI && HYPERV_VMBUS
> +	depends on PCI && HYPERV_VMBUS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 5e939004b646..a0d2be387bb1 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_I915
>   	tristate "Intel 8xx/9xx/G3x/G4x/HD Graphics"
> -	depends on DRM
>   	depends on X86 && PCI
>   	depends on !PREEMPT_RT
>   	select INTEL_GTT if X86
> diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
> index 1fd4c635c2c9..6e402e4e01a5 100644
> --- a/drivers/gpu/drm/imagination/Kconfig
> +++ b/drivers/gpu/drm/imagination/Kconfig
> @@ -4,7 +4,6 @@
>   config DRM_POWERVR
>   	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
>   	depends on (ARM64 || RISCV && 64BIT)
> -	depends on DRM
>   	depends on MMU
>   	depends on PM
>   	depends on POWER_SEQUENCING || !POWER_SEQUENCING
> diff --git a/drivers/gpu/drm/imx/dc/Kconfig b/drivers/gpu/drm/imx/dc/Kconfig
> index 415993207f2e..d8f59199656a 100644
> --- a/drivers/gpu/drm/imx/dc/Kconfig
> +++ b/drivers/gpu/drm/imx/dc/Kconfig
> @@ -1,6 +1,6 @@
>   config DRM_IMX8_DC
>   	tristate "Freescale i.MX8 Display Controller Graphics"
> -	depends on DRM && COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
> +	depends on COMMON_CLK && OF && (ARCH_MXC || COMPILE_TEST)
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
> index e014ed3ae66c..55cca90bd95c 100644
> --- a/drivers/gpu/drm/imx/dcss/Kconfig
> +++ b/drivers/gpu/drm/imx/dcss/Kconfig
> @@ -7,7 +7,7 @@ config DRM_IMX_DCSS
>   	select DRM_BRIDGE_CONNECTOR
>   	select DRM_GEM_DMA_HELPER
>   	select VIDEOMODE_HELPERS
> -	depends on DRM && ((ARCH_MXC && ARM64) || COMPILE_TEST)
> +	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
>   	help
>   	  Choose this if you have a NXP i.MX8MQ based system and want to use the
>   	  Display Controller Subsystem. This option enables DCSS support.
> diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
> index 3ca237515e46..5c28c07ed03e 100644
> --- a/drivers/gpu/drm/imx/ipuv3/Kconfig
> +++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
> @@ -5,7 +5,7 @@ config DRM_IMX
>   	select DRM_KMS_HELPER
>   	select VIDEOMODE_HELPERS
>   	select DRM_GEM_DMA_HELPER
> -	depends on DRM && (ARCH_MXC || COMPILE_TEST)
> +	depends on ARCH_MXC || COMPILE_TEST
>   	depends on IMX_IPUV3_CORE
>   	help
>   	  enable i.MX graphics support
> diff --git a/drivers/gpu/drm/imx/lcdc/Kconfig b/drivers/gpu/drm/imx/lcdc/Kconfig
> index 75869489b0e6..ef554a74f5be 100644
> --- a/drivers/gpu/drm/imx/lcdc/Kconfig
> +++ b/drivers/gpu/drm/imx/lcdc/Kconfig
> @@ -1,6 +1,6 @@
>   config DRM_IMX_LCDC
>         tristate "Freescale i.MX LCDC displays"
> -      depends on DRM && (ARCH_MXC || COMPILE_TEST)
> +      depends on ARCH_MXC || COMPILE_TEST
>         select DRM_CLIENT_SELECTION
>         select DRM_GEM_DMA_HELPER
>         select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
> index 04ecfb0c5dd6..1a3d630b31a3 100644
> --- a/drivers/gpu/drm/ingenic/Kconfig
> +++ b/drivers/gpu/drm/ingenic/Kconfig
> @@ -1,7 +1,6 @@
>   config DRM_INGENIC
>   	tristate "DRM Support for Ingenic SoCs"
>   	depends on MIPS || COMPILE_TEST
> -	depends on DRM
>   	depends on CMA
>   	depends on OF
>   	depends on COMMON_CLK
> diff --git a/drivers/gpu/drm/kmb/Kconfig b/drivers/gpu/drm/kmb/Kconfig
> index 7a2aa892a957..c67e523b9a8f 100644
> --- a/drivers/gpu/drm/kmb/Kconfig
> +++ b/drivers/gpu/drm/kmb/Kconfig
> @@ -1,6 +1,5 @@
>   config DRM_KMB_DISPLAY
>   	tristate "Intel Keembay Display"
> -	depends on DRM
>   	depends on ARCH_KEEMBAY || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/lima/Kconfig b/drivers/gpu/drm/lima/Kconfig
> index fa1d4f5df31e..81ae0fbf71fb 100644
> --- a/drivers/gpu/drm/lima/Kconfig
> +++ b/drivers/gpu/drm/lima/Kconfig
> @@ -3,7 +3,6 @@
>   
>   config DRM_LIMA
>          tristate "LIMA (DRM support for ARM Mali 400/450 GPU)"
> -       depends on DRM
>          depends on ARM || ARM64 || COMPILE_TEST
>          depends on MMU
>          depends on COMMON_CLK
> diff --git a/drivers/gpu/drm/logicvc/Kconfig b/drivers/gpu/drm/logicvc/Kconfig
> index 579a358ed5cf..4a9d4d05e8a0 100644
> --- a/drivers/gpu/drm/logicvc/Kconfig
> +++ b/drivers/gpu/drm/logicvc/Kconfig
> @@ -1,6 +1,5 @@
>   config DRM_LOGICVC
>   	tristate "LogiCVC DRM"
> -	depends on DRM
>   	depends on OF || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/loongson/Kconfig b/drivers/gpu/drm/loongson/Kconfig
> index d739d51cf54c..659b0c7c4003 100644
> --- a/drivers/gpu/drm/loongson/Kconfig
> +++ b/drivers/gpu/drm/loongson/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config DRM_LOONGSON
>   	tristate "DRM support for Loongson Graphics"
> -	depends on DRM && PCI
> +	depends on PCI
>   	depends on LOONGARCH || MIPS || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/mcde/Kconfig b/drivers/gpu/drm/mcde/Kconfig
> index 3516c8d2a5d9..cdeca6ba5249 100644
> --- a/drivers/gpu/drm/mcde/Kconfig
> +++ b/drivers/gpu/drm/mcde/Kconfig
> @@ -1,6 +1,5 @@
>   config DRM_MCDE
>   	tristate "DRM Support for ST-Ericsson MCDE (Multichannel Display Engine)"
> -	depends on DRM
>   	depends on CMA
>   	depends on ARM || COMPILE_TEST
>   	depends on OF
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
> index ad8c8b823681..fb161e39acde 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_MEDIATEK
>   	tristate "DRM Support for Mediatek SoCs"
> -	depends on DRM
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
>   	depends on COMMON_CLK
>   	depends on HAVE_ARM_SMCCC || COMPILE_TEST
> diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
> index 417f79829cf8..d1c82183ec81 100644
> --- a/drivers/gpu/drm/meson/Kconfig
> +++ b/drivers/gpu/drm/meson/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_MESON
>   	tristate "DRM Support for Amlogic Meson Display Controller"
> -	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
> +	depends on OF && (ARM || ARM64 || COMPILE_TEST)
>   	depends on ARCH_MESON || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
> index a962ae564a75..e9f602c6167b 100644
> --- a/drivers/gpu/drm/mgag200/Kconfig
> +++ b/drivers/gpu/drm/mgag200/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_MGAG200
>   	tristate "Matrox G200"
> -	depends on DRM && PCI
> +	depends on PCI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 250246f81ea9..9b2a8f3f9ced 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -2,7 +2,6 @@
>   
>   config DRM_MSM
>   	tristate "MSM DRM"
> -	depends on DRM
>   	depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
>   	depends on COMMON_CLK
>   	depends on IOMMU_SUPPORT
> diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
> index 31db7a824a93..caedc637a260 100644
> --- a/drivers/gpu/drm/mxsfb/Kconfig
> +++ b/drivers/gpu/drm/mxsfb/Kconfig
> @@ -6,7 +6,7 @@ config DRM_MXS
>   
>   config DRM_MXSFB
>   	tristate "i.MX (e)LCDIF LCD controller"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on COMMON_CLK
>   	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
> @@ -24,7 +24,7 @@ config DRM_MXSFB
>   
>   config DRM_IMX_LCDIF
>   	tristate "i.MX LCDIFv3 LCD controller"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on COMMON_CLK
>   	depends on ARCH_MXC || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
> index 3b5757aed9c8..559aeb4449ab 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_NOUVEAU
>   	tristate "Nouveau (NVIDIA) cards"
> -	depends on DRM && PCI
> +	depends on PCI
>   	select IOMMU_API
>   	select FW_LOADER
>   	select FW_CACHE if PM_SLEEP
> diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
> index 9d4016bd0f44..9c17d5250508 100644
> --- a/drivers/gpu/drm/omapdrm/Kconfig
> +++ b/drivers/gpu/drm/omapdrm/Kconfig
> @@ -2,7 +2,7 @@
>   config DRM_OMAP
>   	tristate "OMAP DRM"
>   	depends on MMU
> -	depends on DRM && OF
> +	depends on OF
>   	depends on ARCH_OMAP2PLUS || (COMPILE_TEST && PAGE_SIZE_LESS_THAN_64KB)
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 7450b27622a2..6a447d737767 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1,12 +1,11 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_PANEL
>   	bool
> -	depends on DRM
>   	help
>   	  Panel registration and lookup framework.
>   
>   menu "Display Panels"
> -	depends on DRM && DRM_PANEL
> +	depends on DRM_PANEL
>   
>   config DRM_PANEL_ABT_Y030XX067A
>   	tristate "ABT Y030XX067A 320x480 LCD panel"
> diff --git a/drivers/gpu/drm/panfrost/Kconfig b/drivers/gpu/drm/panfrost/Kconfig
> index e6403a9d66ad..5df66a9e7a73 100644
> --- a/drivers/gpu/drm/panfrost/Kconfig
> +++ b/drivers/gpu/drm/panfrost/Kconfig
> @@ -2,7 +2,6 @@
>   
>   config DRM_PANFROST
>   	tristate "Panfrost (DRM support for ARM Mali Midgard/Bifrost GPUs)"
> -	depends on DRM
>   	depends on ARM || ARM64 || COMPILE_TEST
>   	depends on !GENERIC_ATOMIC64    # for IOMMU_IO_PGTABLE_LPAE
>   	depends on MMU
> diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
> index 911e7f4810c3..d4c8bc59add4 100644
> --- a/drivers/gpu/drm/panthor/Kconfig
> +++ b/drivers/gpu/drm/panthor/Kconfig
> @@ -2,7 +2,6 @@
>   
>   config DRM_PANTHOR
>   	tristate "Panthor (DRM support for ARM Mali CSF-based GPUs)"
> -	depends on DRM
>   	depends on ARM || ARM64 || COMPILE_TEST
>   	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
>   	depends on MMU
> diff --git a/drivers/gpu/drm/pl111/Kconfig b/drivers/gpu/drm/pl111/Kconfig
> index 82e918820950..20302aa22a39 100644
> --- a/drivers/gpu/drm/pl111/Kconfig
> +++ b/drivers/gpu/drm/pl111/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_PL111
>   	tristate "DRM Support for PL111 CLCD Controller"
> -	depends on DRM
>   	depends on ARM || ARM64 || COMPILE_TEST
>   	depends on VEXPRESS_CONFIG || VEXPRESS_CONFIG=n
>   	depends on COMMON_CLK
> @@ -13,4 +12,3 @@ config DRM_PL111
>   	help
>   	  Choose this option for DRM support for the PL111 CLCD controller.
>   	  If M is selected the module will be called pl111_drm.
> -
> diff --git a/drivers/gpu/drm/qxl/Kconfig b/drivers/gpu/drm/qxl/Kconfig
> index d8f24bcae34b..258f50e62a15 100644
> --- a/drivers/gpu/drm/qxl/Kconfig
> +++ b/drivers/gpu/drm/qxl/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_QXL
>   	tristate "QXL virtual GPU"
> -	depends on DRM && PCI && HAS_IOPORT
> +	depends on PCI && HAS_IOPORT
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_TTM
> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
> index c479f0c0dd5c..e57afbaa3321 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config DRM_RADEON
>   	tristate "ATI Radeon"
> -	depends on DRM && PCI
> +	depends on PCI
>   	depends on AGP || !AGP
>   	select FW_LOADER
>   	select DRM_CLIENT_SELECTION
> diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> index 840305fdeb49..671821223a50 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config DRM_RCAR_DU
>   	tristate "DRM Support for R-Car Display Unit"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on ARM || ARM64 || COMPILE_TEST
>   	depends on ARCH_RENESAS || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
> @@ -27,7 +27,7 @@ config DRM_RCAR_CMM
>   
>   config DRM_RCAR_DW_HDMI
>   	tristate "R-Car Gen3 and RZ/G2 DU HDMI Encoder Support"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on DRM_RCAR_DU || COMPILE_TEST
>   	select DRM_DW_HDMI
>   	help
> diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
> index 7f2ef7137ae5..51abb0fd614c 100644
> --- a/drivers/gpu/drm/renesas/rz-du/Kconfig
> +++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
> @@ -2,7 +2,7 @@
>   config DRM_RZG2L_DU
>   	tristate "DRM Support for RZ/G2L Display Unit"
>   	depends on ARCH_RENESAS || COMPILE_TEST
> -	depends on DRM && OF
> +	depends on OF
>   	depends on VIDEO_RENESAS_VSP1
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
> diff --git a/drivers/gpu/drm/renesas/shmobile/Kconfig b/drivers/gpu/drm/renesas/shmobile/Kconfig
> index 52e160464001..457ce24acfdf 100644
> --- a/drivers/gpu/drm/renesas/shmobile/Kconfig
> +++ b/drivers/gpu/drm/renesas/shmobile/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config DRM_SHMOBILE
>   	tristate "DRM Support for SH Mobile"
> -	depends on DRM && PM
> +	depends on PM
>   	depends on ARCH_RENESAS || ARCH_SHMOBILE || COMPILE_TEST
>   	select BACKLIGHT_CLASS_DEVICE
>   	select DRM_CLIENT_SELECTION
> @@ -13,4 +13,3 @@ config DRM_SHMOBILE
>   	help
>   	  Choose this option if you have an SH Mobile chipset.
>   	  If M is selected the module will be called shmob-drm.
> -
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index e7f49fe845ea..c35fc8a97deb 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_ROCKCHIP
>   	tristate "DRM Support for Rockchip"
> -	depends on DRM
>   	depends on ARCH_ROCKCHIP || COMPILE_TEST
>   	depends on ROCKCHIP_IOMMU || !ROCKCHIP_IOMMU
>   	depends on OF
> diff --git a/drivers/gpu/drm/sitronix/Kconfig b/drivers/gpu/drm/sitronix/Kconfig
> index 41a428ef8295..dbc2b8eed16c 100644
> --- a/drivers/gpu/drm/sitronix/Kconfig
> +++ b/drivers/gpu/drm/sitronix/Kconfig
> @@ -1,6 +1,6 @@
>   config DRM_ST7571
>   	tristate "DRM support for Sitronix ST7567/ST7571 display panels"
> -	depends on DRM && MMU
> +	depends on MMU
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KMS_HELPER
> @@ -41,7 +41,7 @@ config DRM_ST7571_SPI
>   
>   config DRM_ST7586
>   	tristate "DRM support for Sitronix ST7586 display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -54,7 +54,7 @@ config DRM_ST7586
>   
>   config DRM_ST7735R
>   	tristate "DRM support for Sitronix ST7715R/ST7735R display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -70,7 +70,7 @@ config DRM_ST7735R
>   
>   config DRM_ST7920
>   	tristate "DRM support for Sitronix ST7920 LCD displays"
> -	depends on DRM && SPI && MMU
> +	depends on SPI && MMU
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KMS_HELPER
>   	select REGMAP_SPI
> diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
> index 400a6cab3a67..b6de9fdbf6dd 100644
> --- a/drivers/gpu/drm/solomon/Kconfig
> +++ b/drivers/gpu/drm/solomon/Kconfig
> @@ -1,6 +1,6 @@
>   config DRM_SSD130X
>   	tristate "DRM support for Solomon SSD13xx OLED displays"
> -	depends on DRM && MMU
> +	depends on MMU
>   	select BACKLIGHT_CLASS_DEVICE
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/gpu/drm/sprd/Kconfig b/drivers/gpu/drm/sprd/Kconfig
> index e22b780fe822..231f838fc996 100644
> --- a/drivers/gpu/drm/sprd/Kconfig
> +++ b/drivers/gpu/drm/sprd/Kconfig
> @@ -1,7 +1,7 @@
>   config DRM_SPRD
>   	tristate "DRM Support for Unisoc SoCs Platform"
>   	depends on ARCH_SPRD || COMPILE_TEST
> -	depends on DRM && OF
> +	depends on OF
>   	select DRM_GEM_DMA_HELPER
>   	select DRM_KMS_HELPER
>   	select DRM_MIPI_DSI
> @@ -9,4 +9,3 @@ config DRM_SPRD
>   	help
>   	  Choose this option if you have a Unisoc chipset.
>   	  If M is selected the module will be called sprd_drm.
> -
> diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
> index 635be0ac00af..7355b056c904 100644
> --- a/drivers/gpu/drm/stm/Kconfig
> +++ b/drivers/gpu/drm/stm/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_STM
>   	tristate "DRM Support for STMicroelectronics SoC Series"
> -	depends on DRM && (ARCH_STM32 || COMPILE_TEST)
> +	depends on ARCH_STM32 || COMPILE_TEST
>   	depends on COMMON_CLK
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
> index b56ba00aabca..4feadbe21bfc 100644
> --- a/drivers/gpu/drm/sun4i/Kconfig
> +++ b/drivers/gpu/drm/sun4i/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_SUN4I
>   	tristate "DRM Support for Allwinner A10 Display Engine"
> -	depends on DRM && COMMON_CLK
> +	depends on COMMON_CLK
>   	depends on ARCH_SUNXI || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
> diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
> index 2559ead6cf1f..436e3763a695 100644
> --- a/drivers/gpu/drm/sysfb/Kconfig
> +++ b/drivers/gpu/drm/sysfb/Kconfig
> @@ -1,15 +1,13 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
>   menu "Drivers for system framebuffers"
> -	depends on DRM
>   
>   config DRM_SYSFB_HELPER
>   	tristate
> -	depends on DRM
>   
>   config DRM_COREBOOTDRM
>   	tristate "Coreboot framebuffer driver"
> -	depends on DRM && MMU
> +	depends on MMU
>   	depends on GOOGLE_FRAMEBUFFER_COREBOOT
>   	select APERTURE_HELPERS
>   	select DRM_CLIENT_SELECTION
> @@ -25,7 +23,7 @@ config DRM_COREBOOTDRM
>   
>   config DRM_EFIDRM
>   	tristate "EFI framebuffer driver"
> -	depends on DRM && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
> +	depends on MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
>   	select APERTURE_HELPERS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
> @@ -41,7 +39,7 @@ config DRM_EFIDRM
>   
>   config DRM_OFDRM
>   	tristate "Open Firmware display driver"
> -	depends on DRM && MMU && OF && (PPC || COMPILE_TEST)
> +	depends on MMU && OF && (PPC || COMPILE_TEST)
>   	select APERTURE_HELPERS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
> @@ -56,7 +54,7 @@ config DRM_OFDRM
>   
>   config DRM_SIMPLEDRM
>   	tristate "Simple framebuffer driver"
> -	depends on DRM && MMU
> +	depends on MMU
>   	select APERTURE_HELPERS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
> @@ -75,7 +73,7 @@ config DRM_SIMPLEDRM
>   
>   config DRM_VESADRM
>   	tristate "VESA framebuffer driver"
> -	depends on DRM && MMU && X86 && (!SYSFB_SIMPLEFB || COMPILE_TEST)
> +	depends on MMU && X86 && (!SYSFB_SIMPLEFB || COMPILE_TEST)
>   	select APERTURE_HELPERS
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 8a3b16aac5d6..40b4203e1b55 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -3,7 +3,6 @@ config DRM_TEGRA
>   	tristate "NVIDIA Tegra DRM"
>   	depends on ARCH_TEGRA || COMPILE_TEST
>   	depends on COMMON_CLK
> -	depends on DRM
>   	depends on OF
>   	select DRM_CLIENT_SELECTION
>   	select DRM_DISPLAY_DP_HELPER
> diff --git a/drivers/gpu/drm/tidss/Kconfig b/drivers/gpu/drm/tidss/Kconfig
> index 31ad582b7602..3a1d3feaddcd 100644
> --- a/drivers/gpu/drm/tidss/Kconfig
> +++ b/drivers/gpu/drm/tidss/Kconfig
> @@ -1,6 +1,6 @@
>   config DRM_TIDSS
>   	tristate "DRM Support for TI Keystone"
> -	depends on DRM && OF
> +	depends on OF
>   	depends on ARM || ARM64 || COMPILE_TEST
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
> index 89df7528756c..e7510a47b9b5 100644
> --- a/drivers/gpu/drm/tilcdc/Kconfig
> +++ b/drivers/gpu/drm/tilcdc/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_TILCDC
>   	tristate "DRM Support for TI LCDC Display Controller"
> -	depends on DRM && OF && ARM
> +	depends on OF && ARM
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6a47..87f353fd4ecb 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config DRM_APPLETBDRM
>   	tristate "DRM support for Apple Touch Bars"
> -	depends on DRM && USB && MMU
> +	depends on USB && MMU
>   	depends on X86 || COMPILE_TEST
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KMS_HELPER
> @@ -15,7 +15,7 @@ config DRM_APPLETBDRM
>   
>   config DRM_ARCPGU
>   	tristate "ARC PGU"
> -	depends on DRM && OF
> +	depends on OF
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
>   	select DRM_KMS_HELPER
> @@ -26,7 +26,7 @@ config DRM_ARCPGU
>   
>   config DRM_BOCHS
>   	tristate "DRM Support for bochs dispi vga interface (qemu stdvga)"
> -	depends on DRM && PCI && MMU
> +	depends on PCI && MMU
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_SHMEM_HELPER
>   	select DRM_KMS_HELPER
> @@ -38,7 +38,7 @@ config DRM_BOCHS
>   
>   config DRM_CIRRUS_QEMU
>   	tristate "Cirrus driver for QEMU emulated device"
> -	depends on DRM && PCI
> +	depends on PCI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_SHMEM_HELPER
> @@ -58,7 +58,7 @@ config DRM_CIRRUS_QEMU
>   
>   config DRM_GM12U320
>   	tristate "GM12U320 driver for USB projectors"
> -	depends on DRM && USB && MMU
> +	depends on USB && MMU
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_SHMEM_HELPER
> @@ -68,7 +68,7 @@ config DRM_GM12U320
>   
>   config DRM_PANEL_MIPI_DBI
>   	tristate "DRM support for MIPI DBI compatible panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -84,7 +84,7 @@ config DRM_PANEL_MIPI_DBI
>   
>   config DRM_PIXPAPER
>           tristate "DRM support for PIXPAPER display panels"
> -        depends on DRM && SPI
> +        depends on SPI
>           depends on MMU
>           select DRM_CLIENT_SELECTION
>           select DRM_GEM_SHMEM_HELPER
> @@ -100,7 +100,7 @@ config DRM_PIXPAPER
>   
>   config TINYDRM_HX8357D
>   	tristate "DRM support for HX8357D display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -114,7 +114,7 @@ config TINYDRM_HX8357D
>   
>   config TINYDRM_ILI9163
>   	tristate "DRM support for ILI9163 display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select BACKLIGHT_CLASS_DEVICE
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
> @@ -128,7 +128,7 @@ config TINYDRM_ILI9163
>   
>   config TINYDRM_ILI9225
>   	tristate "DRM support for ILI9225 display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -141,7 +141,7 @@ config TINYDRM_ILI9225
>   
>   config TINYDRM_ILI9341
>   	tristate "DRM support for ILI9341 display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -155,7 +155,7 @@ config TINYDRM_ILI9341
>   
>   config TINYDRM_ILI9486
>   	tristate "DRM support for ILI9486 display panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -170,7 +170,7 @@ config TINYDRM_ILI9486
>   
>   config TINYDRM_MI0283QT
>   	tristate "DRM support for MI0283QT"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -182,7 +182,7 @@ config TINYDRM_MI0283QT
>   
>   config TINYDRM_REPAPER
>   	tristate "DRM support for Pervasive Displays RePaper panels (V231)"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_DMA_HELPER
> @@ -197,7 +197,7 @@ config TINYDRM_REPAPER
>   
>   config TINYDRM_SHARP_MEMORY
>   	tristate "DRM support for Sharp Memory LCD panels"
> -	depends on DRM && SPI
> +	depends on SPI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_GEM_DMA_HELPER
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/tve200/Kconfig b/drivers/gpu/drm/tve200/Kconfig
> index a9d6fe535d88..1380176da0db 100644
> --- a/drivers/gpu/drm/tve200/Kconfig
> +++ b/drivers/gpu/drm/tve200/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_TVE200
>   	tristate "DRM Support for Faraday TV Encoder TVE200"
> -	depends on DRM
>   	depends on CMA
>   	depends on ARM || COMPILE_TEST
>   	depends on OF
> diff --git a/drivers/gpu/drm/udl/Kconfig b/drivers/gpu/drm/udl/Kconfig
> index d7a6abef7d78..0c8d9b8eb8d2 100644
> --- a/drivers/gpu/drm/udl/Kconfig
> +++ b/drivers/gpu/drm/udl/Kconfig
> @@ -1,7 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_UDL
>   	tristate "DisplayLink"
> -	depends on DRM
>   	depends on USB
>   	depends on USB_ARCH_HAS_HCD
>   	depends on MMU
> diff --git a/drivers/gpu/drm/v3d/Kconfig b/drivers/gpu/drm/v3d/Kconfig
> index ce62c5908e1d..4faa91fcafa4 100644
> --- a/drivers/gpu/drm/v3d/Kconfig
> +++ b/drivers/gpu/drm/v3d/Kconfig
> @@ -2,7 +2,6 @@
>   config DRM_V3D
>   	tristate "Broadcom V3D 3.x and newer"
>   	depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
> -	depends on DRM
>   	depends on COMMON_CLK
>   	depends on MMU
>   	select DRM_SCHED
> diff --git a/drivers/gpu/drm/vboxvideo/Kconfig b/drivers/gpu/drm/vboxvideo/Kconfig
> index 180e30b82ab9..c2f3ac0b8d21 100644
> --- a/drivers/gpu/drm/vboxvideo/Kconfig
> +++ b/drivers/gpu/drm/vboxvideo/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config DRM_VBOXVIDEO
>   	tristate "Virtual Box Graphics Card"
> -	depends on DRM && X86 && PCI
> +	depends on X86 && PCI
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_VRAM_HELPER
> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> index bb8c40be3250..ce5fcd09b3bf 100644
> --- a/drivers/gpu/drm/vc4/Kconfig
> +++ b/drivers/gpu/drm/vc4/Kconfig
> @@ -5,7 +5,6 @@ config DRM_VC4
>   	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
>   	# happen when COMPILE_TEST=y, hence the added !RASPBERRYPI_FIRMWARE.
>   	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> -	depends on DRM
>   	depends on SND && SND_SOC
>   	depends on COMMON_CLK
>   	depends on PM
> diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
> index 7cce86ec8603..175cec6c138a 100644
> --- a/drivers/gpu/drm/verisilicon/Kconfig
> +++ b/drivers/gpu/drm/verisilicon/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_VERISILICON_DC
>   	tristate "DRM Support for Verisilicon DC-series display controllers"
> -	depends on DRM && COMMON_CLK
> +	depends on COMMON_CLK
>   	depends on RISCV || COMPILE_TEST
>   	select DRM_BRIDGE_CONNECTOR
>   	select DRM_CLIENT_SELECTION
> diff --git a/drivers/gpu/drm/vgem/Kconfig b/drivers/gpu/drm/vgem/Kconfig
> index c419cdadd54c..d2d4bfb61440 100644
> --- a/drivers/gpu/drm/vgem/Kconfig
> +++ b/drivers/gpu/drm/vgem/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_VGEM
>   	tristate "Virtual GEM provider"
> -	depends on DRM && MMU
> +	depends on MMU
>   	select DRM_GEM_SHMEM_HELPER
>   	help
>   	  Choose this option to get a virtual graphics memory manager,
> diff --git a/drivers/gpu/drm/virtio/Kconfig b/drivers/gpu/drm/virtio/Kconfig
> index fc884fb57b7e..a12ed38097f1 100644
> --- a/drivers/gpu/drm/virtio/Kconfig
> +++ b/drivers/gpu/drm/virtio/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_VIRTIO_GPU
>   	tristate "Virtio GPU driver"
> -	depends on DRM && VIRTIO_MENU && MMU
> +	depends on VIRTIO_MENU && MMU
>   	select VIRTIO
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/vkms/Kconfig b/drivers/gpu/drm/vkms/Kconfig
> index 3977bbb99f7d..ad3e3032c91d 100644
> --- a/drivers/gpu/drm/vkms/Kconfig
> +++ b/drivers/gpu/drm/vkms/Kconfig
> @@ -2,7 +2,7 @@
>   
>   config DRM_VKMS
>   	tristate "Virtual KMS (EXPERIMENTAL)"
> -	depends on DRM && MMU
> +	depends on MMU
>   	select DRM_CLIENT_SELECTION
>   	select DRM_KMS_HELPER
>   	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/gpu/drm/vmwgfx/Kconfig b/drivers/gpu/drm/vmwgfx/Kconfig
> index aab646b91ca9..f2350d916584 100644
> --- a/drivers/gpu/drm/vmwgfx/Kconfig
> +++ b/drivers/gpu/drm/vmwgfx/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   config DRM_VMWGFX
>   	tristate "DRM driver for VMware Virtual GPU"
> -	depends on DRM && PCI
> +	depends on PCI
>   	depends on (X86 && HYPERVISOR_GUEST) || ARM64
>   	select DRM_CLIENT_SELECTION
>   	select DRM_TTM
> @@ -24,4 +24,3 @@ config DRM_VMWGFX_MKSSTATS
>   	default n
>   	help
>   	   Choose this option to instrument the kernel driver for mksGuestStats.
> -
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 4d7dcaff2b91..9aff93e1b1fc 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config DRM_XE
>   	tristate "Intel Xe2 Graphics"
> -	depends on DRM && PCI
> +	depends on PCI
>   	depends on KUNIT || !KUNIT
>   	depends on INTEL_VSEC || !INTEL_VSEC
>   	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


