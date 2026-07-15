Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982F2C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91D310E8ED;
	Wed, 15 Jul 2026 16:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="XyYRN6vv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P2dV1mBn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XyYRN6vv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P2dV1mBn";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4105E10E8ED
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 16:09:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26F1E7848F;
 Wed, 15 Jul 2026 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784131749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dq671rgXYsuJbZZhBcFVohcPqqyzSkvUaycHZXRuyRU=;
 b=XyYRN6vvYZZ/OXL4oDPTMVGAzZkLXDl7OyvTWkjViDBZjzXELFzG3ctALUuj5OqriWjNoK
 Pgawh31hwMS3QMo/mB7TTdPRXKErLaDX6m1xE3Rz7HTQXHVIGr22+aNt9GXjmbm6QxFjz4
 Jl5PMYEfo9sVU9EHTZctlDJdMvsK/RE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784131749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dq671rgXYsuJbZZhBcFVohcPqqyzSkvUaycHZXRuyRU=;
 b=P2dV1mBn6y7xEbjl2HvnIQYyuAvjV462e+XHiLFmf9TkP7xDXtiRDteJtrdhNgDP8dg9mE
 Hxb5XFjr8KdzJWAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784131749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dq671rgXYsuJbZZhBcFVohcPqqyzSkvUaycHZXRuyRU=;
 b=XyYRN6vvYZZ/OXL4oDPTMVGAzZkLXDl7OyvTWkjViDBZjzXELFzG3ctALUuj5OqriWjNoK
 Pgawh31hwMS3QMo/mB7TTdPRXKErLaDX6m1xE3Rz7HTQXHVIGr22+aNt9GXjmbm6QxFjz4
 Jl5PMYEfo9sVU9EHTZctlDJdMvsK/RE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784131749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dq671rgXYsuJbZZhBcFVohcPqqyzSkvUaycHZXRuyRU=;
 b=P2dV1mBn6y7xEbjl2HvnIQYyuAvjV462e+XHiLFmf9TkP7xDXtiRDteJtrdhNgDP8dg9mE
 Hxb5XFjr8KdzJWAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D19F4779AD;
 Wed, 15 Jul 2026 16:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4mjJMaSwV2qONQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Jul 2026 16:09:08 +0000
Message-ID: <d817d031-6ef2-4909-81cb-a9d417550dd8@suse.de>
Date: Wed, 15 Jul 2026 18:09:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] drm/glanda: Add initial DRM driver for GlandaGPU
To: Leander Kieweg <kieweg.leander@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-3-kieweg.leander@gmail.com>
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
In-Reply-To: <20260714101146.200416-3-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[dt]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 suse.com:url]
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

Hi,

you can find a quick review below.


Am 14.07.26 um 12:11 schrieb Leander Kieweg:
> Introduce the core DRM/KMS driver for GlandaGPU. This driver
> supports basic modesetting, atomic updates, and custom 2D hardware
> acceleration IOCTLs.
>
> Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
> ---
>   MAINTAINERS                      |   7 +
>   drivers/gpu/drm/tiny/Kconfig     |  11 +
>   drivers/gpu/drm/tiny/Makefile    |   1 +
>   drivers/gpu/drm/tiny/glandagpu.c | 769 +++++++++++++++++++++++++++++++
>   include/uapi/drm/glanda_drm.h    |  40 ++
>   5 files changed, 828 insertions(+)
>   create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
>   create mode 100644 include/uapi/drm/glanda_drm.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dea93a41..49bbb5c43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8076,6 +8076,13 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/gud/
>   F:	include/drm/gud.h
>   
> +DRM DRIVER FOR GLANDAGPU
> +M:	Leander Kieweg <kieweg.leander@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/glanda,gpu.yaml
> +F:	drivers/gpu/drm/tiny/glandagpu.c
> +F:	include/uapi/drm/glanda_drm.h
> +
>   DRM DRIVER FOR GRAIN MEDIA GM12U320 PROJECTORS
>   M:	Hans de Goede <hansg@kernel.org>
>   S:	Maintained
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6..7a15bf95a 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -56,6 +56,17 @@ config DRM_CIRRUS_QEMU
>   	   - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
>   	   - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
>   
> +config DRM_GLANDA
> +    tristate "GlandaGPU DRM driver"
> +    depends on DRM
> +    select DRM_KMS_HELPER
> +    select DRM_GEM_SHMEM_HELPER
> +	help
> +	  DRM/KMS driver for the GlandaGPU hardware-accelerated 2D
> +	  display controller (FPGA soft IP). This driver supports
> +	  basic modesetting, dumb buffers, and simple 2D drawing
> +	  acceleration via custom hardware IOCTLs.
> +
>   config DRM_GM12U320
>   	tristate "GM12U320 driver for USB projectors"
>   	depends on DRM && USB && MMU
> diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
> index 48d30bf61..b4fa1554a 100644
> --- a/drivers/gpu/drm/tiny/Makefile
> +++ b/drivers/gpu/drm/tiny/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_APPLETBDRM)		+= appletbdrm.o
>   obj-$(CONFIG_DRM_ARCPGU)		+= arcpgu.o
>   obj-$(CONFIG_DRM_BOCHS)			+= bochs.o
>   obj-$(CONFIG_DRM_CIRRUS_QEMU)		+= cirrus-qemu.o
> +obj-$(CONFIG_DRM_GLANDA) 			+= glandagpu.o
>   obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
>   obj-$(CONFIG_DRM_PANEL_MIPI_DBI)	+= panel-mipi-dbi.o
>   obj-$(CONFIG_DRM_PIXPAPER)              += pixpaper.o
> diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glandagpu.c
> new file mode 100644
> index 000000000..8f87ae096
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/glandagpu.c
> @@ -0,0 +1,769 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>	/* udelay (polling) */
> +#include <linux/mod_devicetable.h>	/* Device Tree parsing */
> +#include <linux/of.h>
> +#include <linux/slab.h>		/* GFP_KERNEL */
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/uaccess.h>
> +#include <linux/interrupt.h>
> +#include <linux/wait.h>
> +#include <linux/mm.h>
> +#include <linux/mutex.h>
> +#include <linux/iosys-map.h>
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_ioctl.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_vblank.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_modeset_helper.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_print.h>
> +
> +#include <uapi/drm/glanda_drm.h>
> +
> +/* Hardware Constants */
> +#define GLANDA_WIDTH      640
> +#define GLANDA_HEIGHT     480
> +#define GLANDA_VRAM_SIZE  (GLANDA_WIDTH * GLANDA_HEIGHT * 4)
> +#define GLANDA_MMIO_SIZE  32
> +#define GLANDA_MMIO_OFFSET 0x00200000
> +
> +/* Base addresses used by the x86 test device. */
> +#define BRIDGE_BASE       0xC0000000
> +#define GLANDA_VRAM_BASE  (BRIDGE_BASE + 0x00000000)
> +#define GLANDA_MMIO_BASE  (BRIDGE_BASE + GLANDA_MMIO_OFFSET)
> +#define GLANDA_BASE_SIZE  (BRIDGE_BASE + 0x01000000 - 1)
> +
> +/* Register Offsets */
> +#define REG_STATUS  0x00
> +#define REG_CTRL    0x04
> +#define REG_COORD0  0x08
> +#define REG_COORD1  0x0C
> +#define REG_COLOR   0x10
> +#define REG_ISR     0x14
> +#define REG_IER     0x18
> +
> +/* Bit Masks */
> +#define INT_DONE    BIT(0)
> +#define INT_VSYNC   BIT(1)
> +
> +#define STATUS_BUSY BIT(0)
> +#define CMD_CLEAR   (0x1)
> +#define CMD_RECT    (0x2)
> +#define CMD_LINE    (0x3)
> +#define CTRL_START  BIT(4)
> +
> +struct glanda_device {
> +	struct drm_device drm;
> +
> +	/* hw */
> +	void __iomem *mmio_base;
> +	void __iomem *vram_base;
> +	struct device *dev;

Please use drm_device.dev instead.

> +	phys_addr_t vram_phys;
> +
> +	int irq;
> +	wait_queue_head_t cmd_wq;
> +	bool cmd_done;
> +
> +	struct mutex lock; /* for every ineration with the hardware */
> +
> +	/* drm */
> +	struct drm_plane primary_plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
> +};
> +
> +#define to_glanda(dev) container_of(dev, struct glanda_device, drm)
> +
> +static const u32 glanda_plane_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static int glanda_wait_idle(struct glanda_device *gdev)
> +{
> +	int ret;
> +	unsigned int status;
> +
> +	status = readl(gdev->mmio_base + REG_STATUS);
> +	if (!(status & STATUS_BUSY))
> +		return 0;
> +
> +	if (gdev->irq < 0) {
> +		int timeout = 10000;
> +
> +		do {
> +			status = readl(gdev->mmio_base + REG_STATUS);
> +			if (!(status & STATUS_BUSY))
> +				return 0;
> +			udelay(1);
> +		} while (--timeout > 0);
> +
> +		dev_err(gdev->dev, "GlandaGPU: polling wait_idle timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	gdev->cmd_done = false;
> +
> +	ret = wait_event_interruptible_timeout(gdev->cmd_wq, gdev->cmd_done ||
> +					       !(readl(gdev->mmio_base + REG_STATUS) & STATUS_BUSY),
> +					       msecs_to_jiffies(500));
> +
> +	if (ret == 0) {
> +		dev_err(gdev->dev, "GlandaGPU: IRQ wait_idle timeout\n");
> +		return -ETIMEDOUT;
> +	} else if (ret < 0) {
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int glanda_hw_clear(struct glanda_device *gdev, int color)
> +{
> +	u32 ctrl;
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&gdev->lock))
> +		return -ERESTARTSYS;
> +
> +	ret = glanda_wait_idle(gdev);
> +	if (ret) {
> +		mutex_unlock(&gdev->lock);
> +		return ret;
> +	}
> +
> +	writel(color, gdev->mmio_base + REG_COLOR);
> +	ctrl = CTRL_START | CMD_CLEAR;
> +	writel(ctrl, gdev->mmio_base + REG_CTRL);
> +
> +	mutex_unlock(&gdev->lock);
> +	return 0;
> +}
> +
> +static int glanda_hw_draw_rect(struct glanda_device *gdev,
> +			       int x, int y, int w, int h, int color)
> +{
> +	u32 coord0, coord1, ctrl;
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&gdev->lock))
> +		return -ERESTARTSYS;
> +
> +	ret = glanda_wait_idle(gdev);
> +	if (ret) {
> +		mutex_unlock(&gdev->lock);
> +		return ret;
> +	}
> +
> +	coord0 = (y << 16) | (x & 0x3FF);
> +	coord1 = (h << 16) | (w & 0x3FF);
> +
> +	writel(coord0, gdev->mmio_base + REG_COORD0);
> +	writel(coord1, gdev->mmio_base + REG_COORD1);
> +	writel(color, gdev->mmio_base + REG_COLOR);
> +
> +	ctrl = CTRL_START | CMD_RECT;
> +	writel(ctrl, gdev->mmio_base + REG_CTRL);
> +
> +	mutex_unlock(&gdev->lock);
> +	return 0;
> +}
> +
> +static int glanda_hw_draw_line(struct glanda_device *gdev,
> +			       int x1, int y1, int x2, int y2, int color)
> +{
> +	u32 coord0, coord1, ctrl;
> +	int ret;
> +
> +	if (mutex_lock_interruptible(&gdev->lock))
> +		return -ERESTARTSYS;
> +
> +	ret = glanda_wait_idle(gdev);
> +	if (ret) {
> +		mutex_unlock(&gdev->lock);
> +		return ret;
> +	}
> +
> +	coord0 = (y1 << 16) | (x1 & 0x3FF);
> +	coord1 = (y2 << 16) | (x2 & 0x3FF);
> +
> +	writel(coord0, gdev->mmio_base + REG_COORD0);
> +	writel(coord1, gdev->mmio_base + REG_COORD1);
> +	writel(color, gdev->mmio_base + REG_COLOR);
> +
> +	ctrl = CTRL_START | CMD_LINE;
> +	writel(ctrl, gdev->mmio_base + REG_CTRL);
> +
> +	mutex_unlock(&gdev->lock);
> +	return 0;
> +}
> +
> +static int glanda_drm_ioctl_clear(struct drm_device *dev, void *data,
> +				  struct drm_file *file_priv)
> +{
> +	struct glanda_device *gdev = to_glanda(dev);
> +	struct glanda_clear_cmd *cmd = data;
> +
> +	return glanda_hw_clear(gdev, cmd->color);
> +}
> +
> +static bool glanda_rect_cmd_is_valid(const struct glanda_draw_rect_cmd *cmd)
> +{
> +	if (cmd->x >= GLANDA_WIDTH || cmd->y >= GLANDA_HEIGHT)
> +		return false;
> +	if (cmd->w > GLANDA_WIDTH || cmd->h > GLANDA_HEIGHT)
> +		return false;
> +	if (cmd->x + cmd->w > GLANDA_WIDTH)
> +		return false;
> +	if (cmd->y + cmd->h > GLANDA_HEIGHT)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int glanda_drm_ioctl_draw_rect(struct drm_device *dev, void *data,
> +				      struct drm_file *file_priv)
> +{
> +	struct glanda_device *gdev = to_glanda(dev);
> +	struct glanda_draw_rect_cmd *cmd = data;
> +
> +	if (!glanda_rect_cmd_is_valid(cmd))
> +		return -EINVAL;
> +
> +	return glanda_hw_draw_rect(gdev, cmd->x, cmd->y, cmd->w, cmd->h,
> +				   cmd->color);
> +}
> +
> +static bool glanda_line_cmd_is_valid(const struct glanda_draw_line_cmd *cmd)
> +{
> +	if (cmd->x0 >= GLANDA_WIDTH || cmd->y0 >= GLANDA_HEIGHT)
> +		return false;
> +	if (cmd->x1 >= GLANDA_WIDTH || cmd->y1 >= GLANDA_HEIGHT)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int glanda_drm_ioctl_draw_line(struct drm_device *dev, void *data,
> +				      struct drm_file *file_priv)
> +{
> +	struct glanda_device *gdev = to_glanda(dev);
> +	struct glanda_draw_line_cmd *cmd = data;
> +
> +	if (!glanda_line_cmd_is_valid(cmd))
> +		return -EINVAL;
> +
> +	return glanda_hw_draw_line(gdev, cmd->x0, cmd->y0, cmd->x1, cmd->y1,
> +				   cmd->color);
> +}
> +
> +static void glanda_plane_atomic_update(struct drm_plane *plane,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_framebuffer *fb = new_state->fb;
> +	struct glanda_device *gdev = to_glanda(plane->dev);
> +	struct drm_gem_shmem_object *shmem;
> +	struct iosys_map map;
> +	u32 src_pitch;
> +	u32 width;
> +	u32 height;
> +	int ret;
> +
> +	if (!fb)
> +		return;
> +
> +	shmem = to_drm_gem_shmem_obj(fb->obj[0]);
> +	if (!shmem)  {
> +		drm_err(&gdev->drm, "GlandaGPU: framebuffer is not a shmem GEM object\n");
> +		return;
> +	}
> +
> +	dma_resv_lock(shmem->base.resv, NULL);

Synchronization happens with drm_gem_fb_begin_cpu_access(). No need to 
take the lock here.

> +	ret = drm_gem_shmem_vmap_locked(shmem, &map);

This vmap should not happen here, but in begin_fb_access.  We have 
helpers that set up the mapping for your driver. Take a look at 
DRM_GEM_SHADOW_PLANE_HELPER_FUNCS and DRM_GEM_SHADOW_PLANE_FUNCS and the 
drivers that use them.

> +	if (ret) {
> +		dma_resv_unlock(shmem->base.resv);
> +		drm_err(&gdev->drm,
> +			"GlandaGPU: failed to vmap GEM shmem object\n");
> +		return;
> +	}
> +
> +	mutex_lock(&gdev->lock);
> +
> +	ret = glanda_wait_idle(gdev);
> +	if (ret) {
> +		drm_err(&gdev->drm, "GlandaGPU: timed out waiting for idle\n");
> +		mutex_unlock(&gdev->lock);
> +		drm_gem_shmem_vunmap_locked(shmem, &map);
> +	dma_resv_unlock(shmem->base.resv);
> +		return;
> +	}
> +
> +	src_pitch = fb->pitches[0];
> +	width = min_t(u32, fb->width, GLANDA_WIDTH);
> +	height = min_t(u32, fb->height, GLANDA_HEIGHT);
> +
> +	u8 __iomem *dst_base = gdev->vram_base;
> +	u8 *src_base = map.vaddr;
> +	u32 y;
> +
> +	for (y = 0; y < height; y++) {
> +		u32 *src = (u32 *)(src_base + y * src_pitch);
> +		u32 __iomem *dst = (u32 __iomem *)(dst_base + y * GLANDA_WIDTH * sizeof(u32));
> +		u32 x;
> +
> +		for (x = 0; x < width; x++) {
> +			u32 pixel = src[x];
> +			u32 packed = ((pixel >> 12) & 0x0F00) |
> +				((pixel >> 8) & 0x00F0) |
> +				((pixel >> 4) & 0x000F);
> +
> +			writel_relaxed(packed, &dst[x]);

That's confusing. Each pixel is 32 bit. But each color channel is only 4 
bit. So there's a 20-bit hole in each pixel, right?   Why don't you use 
16 bit per pixel?

> +		}
> +	}
> +
> +	mutex_unlock(&gdev->lock);
> +	drm_gem_shmem_vunmap_locked(shmem, &map);
> +	dma_resv_unlock(shmem->base.resv);
> +}
> +
> +static int glanda_plane_atomic_check(struct drm_plane *plane,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!new_plane_state->crtc)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
> +
> +	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
> +		DRM_PLANE_NO_SCALING, DRM_PLANE_NO_SCALING,
> +		false,	/* can_position */
> +		false	/* can_update_disabled */);
> +}
> +
> +static const struct drm_plane_helper_funcs glanda_plane_helper_funcs = {
> +	.atomic_update = glanda_plane_atomic_update,
> +	.atomic_check = glanda_plane_atomic_check,
> +};
> +
> +static const struct drm_plane_funcs glanda_plane_funcs = {
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane = drm_atomic_helper_disable_plane,
> +	.destroy = drm_plane_cleanup,
> +	.reset = drm_atomic_helper_plane_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
> +};
> +
> +static int glanda_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct drm_display_mode *mode;
> +
> +	mode = drm_mode_create(connector->dev);
> +	if (!mode) {
> +		dev_err(connector->dev->dev, "GlandaGPU: failed to create display mode\n");
> +		return 0;
> +	}
> +
> +	/* Standard VGA timing: 640x480 @ 60 Hz. */
> +	mode->hdisplay = 640;
> +	mode->hsync_start = 656;
> +	mode->hsync_end = 752;
> +	mode->htotal = 800;
> +
> +	mode->vdisplay = 480;
> +	mode->vsync_start = 490;
> +	mode->vsync_end = 492;
> +	mode->vtotal = 525;
> +
> +	mode->clock = 25175;	/* 25.175 MHz pixel clock */
> +
> +	mode->flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 1;
> +}
> +
> +static enum drm_connector_status glanda_connector_detect(struct drm_connector
> +							 *connector, bool force)
> +{
> +	return connector_status_connected;
> +}
> +
> +static int glanda_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	struct glanda_device *gdev = to_glanda(crtc->dev);
> +	u32 ier;
> +
> +	ier = readl(gdev->mmio_base + REG_IER);
> +	writel(ier | INT_VSYNC, gdev->mmio_base + REG_IER);
> +
> +	return 0;
> +}
> +
> +static void glanda_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +	struct glanda_device *gdev = to_glanda(crtc->dev);
> +	u32 ier = readl(gdev->mmio_base + REG_IER);
> +
> +	writel(ier & ~INT_VSYNC, gdev->mmio_base + REG_IER);
> +}
> +
> +static void glanda_crtc_atomic_enable(struct drm_crtc *crtc,
> +				      struct drm_atomic_commit *state)
> +{
> +	drm_crtc_vblank_on(crtc);
> +}
> +
> +static void glanda_crtc_atomic_disable(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
> +{
> +	drm_crtc_vblank_off(crtc);
> +}
> +
> +static void glanda_crtc_atomic_flush(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_pending_vblank_event *event;
> +
> +	if (new_state && new_state->event) {

I don't think it is possible that new_state is NULL.


> +		event = new_state->event;
> +
> +		new_state->event = NULL;
> +
> +		spin_lock_irq(&crtc->dev->event_lock);
> +
> +		if (drm_crtc_vblank_get(crtc) == 0)
> +			drm_crtc_arm_vblank_event(crtc, event);
> +		else
> +			drm_crtc_send_vblank_event(crtc, event);
> +
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +	}
> +}
> +
> +static const struct drm_crtc_funcs glanda_crtc_funcs = {
> +	.destroy = drm_crtc_cleanup,
> +	.set_config = drm_atomic_helper_set_config,
> +	.page_flip = drm_atomic_helper_page_flip,
> +	.reset = drm_atomic_helper_crtc_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +	.enable_vblank = glanda_crtc_enable_vblank,
> +	.disable_vblank = glanda_crtc_disable_vblank,
> +};
> +
> +static const struct drm_crtc_helper_funcs glanda_crtc_helper_funcs = {
> +	.atomic_enable = glanda_crtc_atomic_enable,
> +	.atomic_disable = glanda_crtc_atomic_disable,
> +	.atomic_flush = glanda_crtc_atomic_flush,
> +};
> +
> +static const struct drm_connector_helper_funcs glanda_connector_helper_funcs = {
> +	.get_modes = glanda_connector_get_modes,
> +};
> +
> +static const struct drm_connector_funcs glanda_connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = drm_connector_cleanup,
> +	.detect = glanda_connector_detect,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_framebuffer_funcs glanda_fb_funcs = {
> +	.destroy = drm_gem_fb_destroy,
> +	.create_handle = drm_gem_fb_create_handle,
> +	.dirty = drm_atomic_helper_dirtyfb,
> +};
> +
> +static struct drm_framebuffer *glanda_fb_create(struct drm_device *dev,
> +						struct drm_file *file,
> +						const struct drm_format_info *info,
> +						const struct drm_mode_fb_cmd2 *mode_cmd)

No need for this function. drm_gem_fb_create_with_dirty() is exactly 
what you're looking for.

> +{
> +	return drm_gem_fb_create_with_funcs(dev, file, info, mode_cmd, &glanda_fb_funcs);
> +}
> +
> +static const struct drm_mode_config_funcs glanda_mode_config_funcs = {
> +	.fb_create = glanda_fb_create,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
> +
> +/*
> + * RFC NOTE: These three fixed-function ioctls (clear/rect/line) are a
> + * minimal placeholder UAPI to demonstrate the hardware's 2D drawing
> + * capability end-to-end. Given plans to add polygon/3D rendering support
> + * in the future, feedback is explicitly requested on whether a generic
> + * command-buffer submission ioctl (similar to virtio_gpu) would
> + * be a better long-term UAPI direction before this is treated as stable.
> + */
> +static const struct drm_ioctl_desc glanda_ioctls[] = {
> +	DRM_IOCTL_DEF_DRV(GLANDA_CLEAR, glanda_drm_ioctl_clear,
> +			  DRM_AUTH | DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(GLANDA_DRAW_RECT, glanda_drm_ioctl_draw_rect,
> +			  DRM_AUTH | DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(GLANDA_DRAW_LINE, glanda_drm_ioctl_draw_line,
> +			  DRM_AUTH | DRM_RENDER_ALLOW),
> +};

Drop these ioctls entirely. As I outlined in my reply to the cover 
letter, these will not work with DRM as they are now. Especially since 
you're using gem-shmem as a shadow buffer. All your rendering happens in 
system memory in user space in software.


> +
> +DEFINE_DRM_GEM_FOPS(glanda_drm_fops);
> +
> +static const struct drm_driver glanda_drm_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_RENDER,
> +	.name = "glandagpu",
> +	.desc = "GlandaGPU Hardware Accelerated DRM Driver",
> +	.major = 1,
> +	.minor = 0,
> +	.fops = &glanda_drm_fops,
> +	.dumb_create = drm_gem_shmem_dumb_create,
> +	.ioctls = glanda_ioctls,
> +	.num_ioctls = ARRAY_SIZE(glanda_ioctls),
> +};
> +
> +static irqreturn_t glanda_irq_handler(int irq, void *dev_id)
> +{
> +	struct glanda_device *gdev = dev_id;
> +
> +	if (!gdev || !gdev->mmio_base)
> +		return IRQ_NONE;
> +
> +	u32 isr = readl(gdev->mmio_base + REG_ISR);
> +
> +	if (!isr)
> +		return IRQ_NONE;
> +
> +	if (isr & INT_DONE) {
> +		gdev->cmd_done = true;
> +		wake_up_interruptible(&gdev->cmd_wq);
> +	}
> +
> +	if (isr & INT_VSYNC)
> +		drm_crtc_handle_vblank(&gdev->crtc);
> +
> +	/* Clear interrupt(W1C) */
> +	writel(isr, gdev->mmio_base + REG_ISR);
> +	return IRQ_HANDLED;
> +}
> +
> +static int glandagpu_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct glanda_device *gdev;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "GlandaGPU Probe started\n");
> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	gdev->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, gdev);
> +
> +	mutex_init(&gdev->lock);
> +	/* Interrupt setup */
> +	init_waitqueue_head(&gdev->cmd_wq);
> +	gdev->irq = -1;
> +	/* Map VRAM */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	gdev->vram_phys = res->start;
> +	gdev->vram_base = devm_ioremap(&pdev->dev, res->start, GLANDA_VRAM_SIZE);
> +	gdev->mmio_base = devm_ioremap(&pdev->dev, res->start + GLANDA_MMIO_OFFSET,
> +				       GLANDA_MMIO_SIZE);
> +
> +	if (!gdev->vram_base || !gdev->mmio_base) {
> +		drm_err(&gdev->drm, "failed to ioremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	writel(0, gdev->mmio_base + REG_IER);
> +	writel(0xFFFFFFFF, gdev->mmio_base + REG_ISR);	/* clear flags */
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret > 0) {
> +		gdev->irq = ret;
> +		ret = devm_request_irq(&pdev->dev, gdev->irq, glanda_irq_handler,
> +				       IRQF_SHARED, "glandagpu", gdev);
> +		if (ret) {
> +			drm_err(&gdev->drm, "Failed to request IRQ %d\n",
> +				gdev->irq);
> +			return ret;
> +		}
> +
> +		writel(INT_DONE, gdev->mmio_base + REG_IER);
> +		drm_info(&gdev->drm, "IRQ %d requested and enabled\n", gdev->irq);
> +	} else {
> +		drm_warn(&gdev->drm, "No IRQ found, falling back to polling\n");
> +	}
> +
> +	/* DRM mode config */
> +	drm_mode_config_init(&gdev->drm);
> +	gdev->drm.mode_config.min_width = 640;
> +	gdev->drm.mode_config.min_height = 480;
> +	gdev->drm.mode_config.max_width = 640;
> +	gdev->drm.mode_config.max_height = 480;
> +	gdev->drm.mode_config.funcs = &glanda_mode_config_funcs;
> +
> +	ret = drm_universal_plane_init(&gdev->drm, &gdev->primary_plane, 1 << 0,
> +				       &glanda_plane_funcs,
> +				       glanda_plane_formats,
> +				       ARRAY_SIZE(glanda_plane_formats), NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize primary plane\n");
> +		goto err_mode_cleanup;
> +	}
> +	drm_plane_helper_add(&gdev->primary_plane, &glanda_plane_helper_funcs);
> +
> +	/* VBlank init */
> +	ret = drm_vblank_init(&gdev->drm, 1);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize vblank\n");
> +		goto err_mode_cleanup;
> +	}
> +
> +	/* CRTC init */
> +	ret = drm_crtc_init_with_planes(&gdev->drm, &gdev->crtc,
> +					&gdev->primary_plane, NULL,
> +					&glanda_crtc_funcs, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize CRTC with planes\n");
> +		goto err_mode_cleanup;
> +	}
> +	drm_crtc_helper_add(&gdev->crtc, &glanda_crtc_helper_funcs);
> +
> +	ret = drm_simple_encoder_init(&gdev->drm, &gdev->encoder, DRM_MODE_ENCODER_DAC);

This function is going away. You can open-code it instead.

Best regards
Thomas

> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize encoder\n");
> +		goto err_mode_cleanup;
> +	}
> +	gdev->encoder.possible_crtcs = 1;
> +
> +	ret = drm_connector_init(&gdev->drm, &gdev->connector,
> +				 &glanda_connector_funcs, DRM_MODE_CONNECTOR_VGA);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize connector\n");
> +		goto err_mode_cleanup;
> +	}
> +	drm_connector_helper_add(&gdev->connector, &glanda_connector_helper_funcs);
> +
> +	drm_connector_attach_encoder(&gdev->connector, &gdev->encoder);
> +
> +	/* Populate connector state early so userspace can enumerate modes. */
> +	mutex_lock(&gdev->drm.mode_config.mutex);
> +	drm_helper_probe_single_connector_modes(&gdev->connector, 1024, 768);
> +	mutex_unlock(&gdev->drm.mode_config.mutex);
> +
> +	drm_mode_config_reset(&gdev->drm);
> +
> +	ret = drm_dev_register(&gdev->drm, 0);
> +	if (ret)
> +		goto err_mode_cleanup;
> +
> +	drm_info(&gdev->drm, "GlandaGPU DRM Initialized (/dev/dri/cardX created)\n");
> +	return 0;
> +
> +err_mode_cleanup:
> +	drm_mode_config_cleanup(&gdev->drm);
> +	return ret;
> +}
> +
> +static void glandagpu_remove(struct platform_device *pdev)
> +{
> +	struct glanda_device *gdev = platform_get_drvdata(pdev);
> +
> +	/* Disable interrupts first so no new IRQ work can race the teardown
> +	 * below, and wake up anyone still blocked in glanda_wait_idle().
> +	 */
> +	writel(0, gdev->mmio_base + REG_IER);
> +	gdev->cmd_done = true;
> +	wake_up_interruptible(&gdev->cmd_wq);
> +
> +	drm_info(&gdev->drm, "GlandaGPU DRM Driver removed\n");
> +	drm_dev_unregister(&gdev->drm);
> +	drm_mode_config_cleanup(&gdev->drm);
> +}
> +
> +/* Device Tree match table. */
> +static const struct of_device_id glanda_of_match[] = {
> +	{.compatible = "glanda,gpu-1.0", },
> +	{ /* end of table */  }
> +};
> +
> +MODULE_DEVICE_TABLE(of, glanda_of_match);
> +
> +static struct platform_driver glandagpu_driver = {
> +	.driver = {
> +		.name = "glandagpu",
> +	   .of_match_table = glanda_of_match,
> +	},
> +	.probe = glandagpu_probe,
> +	.remove = glandagpu_remove,
> +};
> +
> +static int __init glandagpu_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&glandagpu_driver);
> +	if (ret) {
> +		pr_err("GlandaGPU: Failed to register platform driver\n");
> +		return ret;
> +	}
> +
> +	pr_info("GlandaGPU: Module loaded successfully\n");
> +	return 0;
> +}
> +
> +static void __exit glandagpu_exit(void)
> +{
> +	platform_driver_unregister(&glandagpu_driver);
> +	pr_info("GlandaGPU: Module unloaded\n");
> +}
> +
> +module_init(glandagpu_init);
> +module_exit(glandagpu_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Leander Kieweg <kieweg.leander@gmail.com>");
> +MODULE_DESCRIPTION("DRM driver for GlandaGPU, an FPGA-based 2D GPU with VGA output");
> diff --git a/include/uapi/drm/glanda_drm.h b/include/uapi/drm/glanda_drm.h
> new file mode 100644
> index 000000000..35d25ba83
> --- /dev/null
> +++ b/include/uapi/drm/glanda_drm.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#ifndef _GLANDA_DRM_H_
> +#define _GLANDA_DRM_H_
> +
> +#include <linux/types.h>
> +#include <drm/drm.h>
> +
> +struct glanda_clear_cmd {
> +	__u32 color;
> +};
> +
> +struct glanda_draw_rect_cmd {
> +	__u16 x;
> +	__u16 y;
> +	__u16 w;
> +	__u16 h;
> +	__u32 color;
> +};
> +
> +struct glanda_draw_line_cmd {
> +	__u16 x0;
> +	__u16 y0;
> +	__u16 x1;
> +	__u16 y1;
> +	__u32 color;
> +};
> +
> +#define DRM_GLANDA_CLEAR     0x00
> +#define DRM_GLANDA_DRAW_RECT 0x01
> +#define DRM_GLANDA_DRAW_LINE 0x02
> +
> +#define DRM_IOCTL_GLANDA_CLEAR \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_GLANDA_CLEAR, struct glanda_clear_cmd)
> +#define DRM_IOCTL_GLANDA_DRAW_RECT \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_GLANDA_DRAW_RECT, struct glanda_draw_rect_cmd)
> +#define DRM_IOCTL_GLANDA_DRAW_LINE \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_GLANDA_DRAW_LINE, struct glanda_draw_line_cmd)
> +
> +#endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


