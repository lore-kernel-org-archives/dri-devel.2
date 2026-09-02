Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ACAC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DFC10F0EA;
	Wed,  2 Sep 2026 10:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="mr04NowF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CZzg47ax";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2P9eNzG8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2o1dpfvS";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FF010F0EA
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:03:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A27321FE4;
 Wed,  2 Sep 2026 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788343428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vez8vLax1GKYTGEh2m2c8AxxDtc9H0RW3XI/RS736fg=;
 b=mr04NowFVSvM25iRZCGN59aWk8e5rlnZYJPlriGc77PNywXSV80sOEGft76ipeLUk4txmd
 Sr6zyhFSq31/zICwcsZ9+IhRE3dUzPWiC89oQV/C7r/XzYZiNY3BSkNd94sGXIzlRhH7r8
 4cf/sTT8sNpSnBnQl4iKSAaXuDABaRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788343428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vez8vLax1GKYTGEh2m2c8AxxDtc9H0RW3XI/RS736fg=;
 b=CZzg47axCUyvf+bxTumIxY71De3auI8HPUy0Q9xG9njKK286i0l4wLM8LfezmcYZ2Zqmdo
 NOcW/wvJJTxWvwBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2P9eNzG8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2o1dpfvS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788343424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vez8vLax1GKYTGEh2m2c8AxxDtc9H0RW3XI/RS736fg=;
 b=2P9eNzG8b4xF/7uu/8Fr/Nkk5Z+5bNjysf+Xs7z5MSqMk8C0bP5WJl0srSM9oAC4yUIV6Q
 HjzsbxPCI3ukYbK2yoa3IoDVSlTcK1+xBtsoILr4sMmvB0g64K+x55JZZ+xYn4fcIzwKpI
 qVZZPxrirOCg9vd3aoNKTtoEmxp5LCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788343424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vez8vLax1GKYTGEh2m2c8AxxDtc9H0RW3XI/RS736fg=;
 b=2o1dpfvSM4HB4Fr+dXfqdKSwg0resj1rnF/3yIa/KcM6JXywfFdsxLB3jtYnhENNf+S9G/
 7Qc3SnsdvlB2+lCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14D6213515;
 Wed,  2 Sep 2026 10:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9B+SA4D0l2obBwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 02 Sep 2026 10:03:44 +0000
Message-ID: <79f25a88-e5a1-45c4-8b80-67830d7e63eb@suse.de>
Date: Wed, 2 Sep 2026 12:03:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: Leander Kieweg <kieweg.leander@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, u.kleine-koenig@baylibre.com
References: <20260824195418.17707-1-kieweg.leander@gmail.com>
 <20260824195418.17707-3-kieweg.leander@gmail.com>
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
In-Reply-To: <20260824195418.17707-3-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A27321FE4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,vger.kernel.org];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,linux.intel.com,kernel.org,baylibre.com]; 
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[dt];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.com:url,
 gitlab.freedesktop.org:url]
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

Am 24.08.26 um 21:54 schrieb Leander Kieweg:
> Introduce the core DRM/KMS driver for GlandaGPU. This driver
> supports basic modesetting, atomic updates via shadow plane helpers,
> and optional QEMU PCI probing alongside the platform driver.
>
> Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
> ---
>   MAINTAINERS                      |   6 +
>   drivers/gpu/drm/tiny/Kconfig     |  11 +
>   drivers/gpu/drm/tiny/Makefile    |   1 +
>   drivers/gpu/drm/tiny/glandagpu.c | 587 +++++++++++++++++++++++++++++++
>   4 files changed, 605 insertions(+)
>   create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dea93a41..c16d1ed70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8076,6 +8076,12 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/gud/
>   F:	include/drm/gud.h
>   
> +DRM DRIVER FOR GLANDAGPU
> +M:	Leander Kieweg <kieweg.leander@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/kieweg,gpu.yaml
> +F:	drivers/gpu/drm/tiny/glandagpu.c
> +
>   DRM DRIVER FOR GRAIN MEDIA GM12U320 PROJECTORS
>   M:	Hans de Goede <hansg@kernel.org>
>   S:	Maintained
> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6..267b3103d 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -56,6 +56,17 @@ config DRM_CIRRUS_QEMU
>   	   - qxl (DRM_QXL, qemu -vga qxl, works best with spice)
>   	   - virtio (DRM_VIRTIO_GPU), qemu -vga virtio)
>   
> +config DRM_GLANDA
> +	tristate "GlandaGPU DRM driver"
> +	depends on DRM && MMU && (PCI || COMPILE_TEST)
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_SHMEM_HELPER
> +	help
> +	  DRM/KMS driver for the GlandaGPU display controller
> +	  (FPGA soft IP). This driver supports basic modesetting,
> +	  dumb buffers, and atomic updates via shadow planes.
> +	  It also provides PCI probing for QEMU testing.
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
> index 000000000..a91e00f71
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/glandagpu.c
> @@ -0,0 +1,587 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>	/* udelay (polling) */
> +#include <linux/of.h>
> +#include <linux/slab.h>		/* GFP_KERNEL */
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
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_vblank.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_modeset_helper.h>
> +#include <drm/drm_probe_helper.h>
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
> +/* Hardware Constants */
> +#define GLANDA_WIDTH      640
> +#define GLANDA_HEIGHT     480
> +#define GLANDA_VRAM_SIZE  (GLANDA_WIDTH * GLANDA_HEIGHT * 4)
> +#define GLANDA_MMIO_SIZE  32
> +#define GLANDA_MMIO_OFFSET 0x00200000
> +
> +/* QEMU test device ID, from the range reserved for experimental use (docs/specs/pci-ids.rst). */
> +#define PCI_DEVICE_ID_GLANDA_GPU 0x10f0
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
> +	phys_addr_t vram_phys;
> +
> +	int irq;
> +
> +	/* drm */
> +	struct drm_plane primary_plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
> +};
> +
> +#define to_glanda(dev) container_of(dev, struct glanda_device, drm)

container_of_const() is nowadays preferred over container_of()

> +
> +static const u32 glanda_plane_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static void glanda_plane_atomic_update(struct drm_plane *plane,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_shadow_plane_state *shadow_state = to_drm_shadow_plane_state(new_state);
> +	struct drm_framebuffer *fb = new_state->fb;
> +	struct glanda_device *gdev = to_glanda(plane->dev);
> +	u32 src_pitch, width, height, x, y;
> +	int idx;
> +
> +	if (!fb)
> +		return;

If you return here, you can never clear the display.  Typically, the 
CRTC would disable the VGA sync and thereby clear the display. But the 
CRTC code doesn't do that. The alternative for displays that cannot 
blank via CRTC is to memset the video memory to 0. You can do this here 
before returning.


> +
> +	if (!drm_dev_enter(plane->dev, &idx))
> +		return;
> +

Below, your driver reads the buffer object's memory to copy it to the 
video memory.  The buffer object's memory could have been imported from 
another driver, which keeps streaming data into it. Therefore it 
requires synchronization first.

Direct buffer access needs to be wrapped in 
drm_gem_fb_begin_cpu_access() and drm_gem_fb_end_cpu_access(). See [1] 
for a simple example.

[1] 
https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c#L347

> +	src_pitch = fb->pitches[0];
> +	width = min_t(u32, fb->width, GLANDA_WIDTH);
> +	height = min_t(u32, fb->height, GLANDA_HEIGHT);
> +
> +	for (y = 0; y < height; y++) {
> +		size_t offset = y * GLANDA_WIDTH * sizeof(u32);
> +		u32 __iomem *dst = (u32 __iomem *)(gdev->vram_base + offset);
> +
> +		for (x = 0; x < width; x++) {
> +			u32 pixel = iosys_map_rd(&shadow_state->data[0],
> +						 y * src_pitch + x * sizeof(u32), u32);
> +			pixel = le32_to_cpu((__force __le32)pixel);
> +			u32 packed = ((pixel >> 12) & 0x0F00) |
> +				((pixel >> 8) & 0x00F0) |
> +				((pixel >> 4) & 0x000F);
> +
> +			writel_relaxed(packed, &dst[x]);
> +		}
> +	}

Your driver cannot directly loop over the framebuffer to copy it over.

1) Instead use damage iterators. Damage handling lets user space clip 
against areas that have been changed between frames. For example, if the 
user moves the mouse pointer, it would not update the whole screen, but 
only the small area around the cursor image. AFAICT damage handling is 
the main reason why the simple displays have any usable performace at all.

2) The framebuffer might be larger than the video memory and be panned 
(i.e., moved around). Details are stored in the plane state. Your driver 
needs to calculate the position in video memory from the plane state. 
See the loop at [2] for how to do this.

[2] 
https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c#L354


> +
> +	drm_dev_exit(idx);
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

Your driver should call drm_atomic_helper_check_plane_state() in any 
case. So don't return earlier than that. See [3] for the pattern of how 
to do this.

[3] 
https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c#L298

> +}
> +
> +static const struct drm_plane_helper_funcs glanda_plane_helper_funcs = {
> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> +	.atomic_update = glanda_plane_atomic_update,
> +	.atomic_check = glanda_plane_atomic_check,
> +};
> +
> +static const struct drm_plane_funcs glanda_plane_funcs = {
> +	.update_plane = drm_atomic_helper_update_plane,
> +	.disable_plane = drm_atomic_helper_disable_plane,
> +	.destroy = drm_plane_cleanup,
> +	DRM_GEM_SHADOW_PLANE_FUNCS,
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

You can leave out this function. The default value is 'connected'.

> +
> +static int glanda_crtc_enable_vblank(struct drm_crtc *crtc)
> +{
> +	struct glanda_device *gdev = to_glanda(crtc->dev);
> +	u32 ier;
> +
> +	ier = readl(gdev->mmio_base + REG_IER);
> +	writel(ier | INT_VSYNC, gdev->mmio_base + REG_IER);

Please see the Sashiko bot's comment on this code.

You also have to wrap all hardware access in drm_dev_begin() and 
drm_dev_end().

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

Since you're only doing vblank_on, please use 
drm_crtc_vblank_atomic_enable()

> +
> +static void glanda_crtc_atomic_disable(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
> +{
> +	drm_crtc_vblank_off(crtc);
> +}

drm_crtc_vblank_atomic_disable()

> +
> +static void glanda_crtc_atomic_flush(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct glanda_device *gdev = to_glanda(crtc->dev);
> +	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_pending_vblank_event *event;
> +
> +	if (new_state->event) {
> +		event = new_state->event;
> +		new_state->event = NULL;
> +
> +		spin_lock_irq(&crtc->dev->event_lock);
> +
> +		if (gdev->irq > 0 && drm_crtc_vblank_get(crtc) == 0)
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
> +static const struct drm_encoder_funcs glanda_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
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
> +static const struct drm_mode_config_funcs glanda_mode_config_funcs = {
> +	.fb_create = drm_gem_fb_create_with_dirty,
> +	.atomic_check = drm_atomic_helper_check,
> +	.atomic_commit = drm_atomic_helper_commit,
> +};
> +
> +DEFINE_DRM_GEM_FOPS(glanda_drm_fops);
> +
> +static const struct drm_driver glanda_drm_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.name = "glandagpu",
> +	.desc = "GlandaGPU Hardware Accelerated DRM Driver",

"Hardware Accelerated" is kind of overselling it :)

> +	.major = 1,
> +	.minor = 0,
> +	.fops = &glanda_drm_fops,
> +	.dumb_create = drm_gem_shmem_dumb_create,
> +};
> +
> +static irqreturn_t glanda_irq_handler(int irq, void *dev_id)
> +{
> +	struct glanda_device *gdev = dev_id;
> +	u32 isr, ier;
> +
> +	if (!gdev || !gdev->mmio_base)
> +		return IRQ_NONE;
> +
> +	isr = readl(gdev->mmio_base + REG_ISR);
> +	ier = readl(gdev->mmio_base + REG_IER);
> +
> +	if (!(isr & ier))
> +		return IRQ_NONE;
> +
> +	if (isr & INT_VSYNC)
> +		drm_crtc_handle_vblank(&gdev->crtc);
> +
> +	/* Clear interrupt(W1C) */
> +	writel(isr, gdev->mmio_base + REG_ISR);
> +	return IRQ_HANDLED;
> +}
> +
> +/* Common DRM setup once MMIO/VRAM/IRQ are known(used by both probe paths) */
> +static int glanda_drm_init(struct glanda_device *gdev, int irq)
> +{
> +	int ret;
> +
> +	gdev->irq = -1;
> +
> +	writel(0, gdev->mmio_base + REG_IER);
> +	writel(0xFFFFFFFF, gdev->mmio_base + REG_ISR);	/* clear flags */
> +
> +	/* DRM mode config */
> +	ret = drm_mode_config_init(&gdev->drm);

Please use drmm_mode_config_init() to that it cleans up the modesetting 
pipeline automatically.

> +	if (ret)
> +		return ret;
> +
> +	gdev->drm.mode_config.min_width = 640;
> +	gdev->drm.mode_config.min_height = 480;
> +	gdev->drm.mode_config.max_width = 640;
> +	gdev->drm.mode_config.max_height = 480;

Rather use DRM_SHADOW_PLANE_MAX_WIDTH and DRM_SHADOW_PLANE_MAX_HEIGHT 
for the max values. Userspace can be picky about framebuffer sizes and 
this should handle it.  It will also allow userspace to do panning on 
your driver.


> +	gdev->drm.mode_config.funcs = &glanda_mode_config_funcs;
> +
> +	ret = drm_universal_plane_init(&gdev->drm, &gdev->primary_plane, 1 << 0,
> +				       &glanda_plane_funcs,
> +				       glanda_plane_formats,
> +				       ARRAY_SIZE(glanda_plane_formats), NULL,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize primary plane\n");
> +		return ret;
> +	}
> +	drm_plane_helper_add(&gdev->primary_plane, &glanda_plane_helper_funcs);

Call drm_plane_enable_fb_damage_clips() here to enable damage clipping.  
You really want this for improving overhead and performance.

> +
> +	/* VBlank init */
> +	ret = drm_vblank_init(&gdev->drm, 1);

I suggest to call this right before drm_mode_config_reset().

> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize vblank\n");
> +		return ret;
> +	}
> +
> +	/* CRTC init */
> +	ret = drm_crtc_init_with_planes(&gdev->drm, &gdev->crtc,
> +					&gdev->primary_plane, NULL,
> +					&glanda_crtc_funcs, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize CRTC with planes\n");
> +		return ret;
> +	}
> +	drm_crtc_helper_add(&gdev->crtc, &glanda_crtc_helper_funcs);
> +
> +	ret = drm_encoder_init(&gdev->drm, &gdev->encoder, &glanda_encoder_funcs,
> +			       DRM_MODE_ENCODER_DAC, NULL);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize encoder\n");
> +		return ret;
> +	}
> +	gdev->encoder.possible_crtcs = 1;
> +
> +	ret = drm_connector_init(&gdev->drm, &gdev->connector,
> +				 &glanda_connector_funcs, DRM_MODE_CONNECTOR_VGA);
> +	if (ret) {
> +		drm_err(&gdev->drm, "Failed to initialize connector\n");
> +		return ret;
> +	}
> +	drm_connector_helper_add(&gdev->connector, &glanda_connector_helper_funcs);
> +
> +	drm_connector_attach_encoder(&gdev->connector, &gdev->encoder);
> +
> +	/* Populate connector state early so userspace can enumerate modes. */
> +	mutex_lock(&gdev->drm.mode_config.mutex);
> +	drm_helper_probe_single_connector_modes(&gdev->connector, 1024, 768);

Please don't do this. The DRM framework takes care if it and will 
populate the mode list when user space needs it.


> +	mutex_unlock(&gdev->drm.mode_config.mutex);
> +
> +	drm_mode_config_reset(&gdev->drm);
> +
> +	if (irq > 0) {
> +		gdev->irq = irq;
> +		ret = devm_request_irq(gdev->drm.dev, gdev->irq, glanda_irq_handler,
> +				       IRQF_SHARED, "glandagpu", gdev);
> +		if (ret) {
> +			drm_err(&gdev->drm, "Failed to request IRQ %d\n",
> +				gdev->irq);
> +			return ret;
> +		}
> +
> +		writel(INT_VSYNC, gdev->mmio_base + REG_IER);

Don't enable IRQs unconditionally.

> +	} else {
> +		drm_warn(&gdev->drm, "No IRQ found, falling back to polling\n");
> +	}
> +
> +	ret = drm_dev_register(&gdev->drm, 0);
> +	if (ret) {
> +		writel(0, gdev->mmio_base + REG_IER);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Shared teardown, mirrors glanda_drm_init() */
> +static void glanda_drm_fini(struct glanda_device *gdev)
> +{
> +	drm_dev_unplug(&gdev->drm);
> +	drm_atomic_helper_shutdown(&gdev->drm);

Rather just unplug. After unplug, no hardware access will be done.

> +
> +	/* Disable interrupts */
> +	writel(0, gdev->mmio_base + REG_IER);

You don't have to disable IRQs here, as DRM should do this during shutdown.

Best regards
Thomas

> +}
> +
> +static int glandagpu_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct glanda_device *gdev;
> +	int irq;
> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	platform_set_drvdata(pdev, gdev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	if (resource_size(res) < GLANDA_MMIO_OFFSET + GLANDA_MMIO_SIZE) {
> +		dev_err(&pdev->dev, "MMIO region too small: %llu bytes, need at least %u\n",
> +			(unsigned long long)resource_size(res),
> +			GLANDA_MMIO_OFFSET + GLANDA_MMIO_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	gdev->vram_phys = res->start;
> +	gdev->vram_base = devm_ioremap(&pdev->dev, res->start, GLANDA_VRAM_SIZE);
> +	gdev->mmio_base = devm_ioremap(&pdev->dev, res->start + GLANDA_MMIO_OFFSET,
> +								   GLANDA_MMIO_SIZE);
> +	if (!gdev->vram_base || !gdev->mmio_base) {
> +		drm_err(&gdev->drm, "failed to ioremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq == -ENXIO)
> +		irq = -1;	/* no IRQ resource, fall back to polling */
> +	else if (irq < 0)
> +		return irq;
> +
> +	return glanda_drm_init(gdev, irq);
> +}
> +
> +static void glandagpu_remove(struct platform_device *pdev)
> +{
> +	glanda_drm_fini(platform_get_drvdata(pdev));
> +}
> +
> +/* Device Tree match table. */
> +static const struct of_device_id glanda_of_match[] = {
> +	{ .compatible = "kieweg,gpu-1.0" },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, glanda_of_match);
> +
> +static struct platform_driver glandagpu_driver = {
> +	.driver = {
> +		.name = "glandagpu",
> +		.of_match_table = glanda_of_match,
> +	},
> +	.probe = glandagpu_probe,
> +	.remove = glandagpu_remove,
> +};
> +
> +/* PCI probe path for the QEMU test device, real hardware uses platform_driver */
> +static int glandagpu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct glanda_device *gdev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +	pci_set_master(pdev);
> +
> +	if (pci_resource_len(pdev, 0) < GLANDA_MMIO_SIZE ||
> +		pci_resource_len(pdev, 1) < GLANDA_VRAM_SIZE) {
> +		dev_err(&pdev->dev, "BAR too small: BAR0=%llu (need %u), BAR1=%llu (need %u)\n",
> +			(unsigned long long)pci_resource_len(pdev, 0), GLANDA_MMIO_SIZE,
> +			(unsigned long long)pci_resource_len(pdev, 1), GLANDA_VRAM_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(1), "glandagpu");
> +	if (ret)
> +		return ret;
> +
> +	gdev = devm_drm_dev_alloc(&pdev->dev, &glanda_drm_driver, struct glanda_device, drm);
> +	if (IS_ERR(gdev))
> +		return PTR_ERR(gdev);
> +
> +	pci_set_drvdata(pdev, gdev);
> +
> +	gdev->mmio_base = pcim_iomap_table(pdev)[0];
> +	gdev->vram_base = pcim_iomap_table(pdev)[1];
> +	gdev->vram_phys = pci_resource_start(pdev, 1);
> +
> +	return glanda_drm_init(gdev, pdev->irq);
> +}
> +
> +static void glandagpu_pci_remove(struct pci_dev *pdev)
> +{
> +	glanda_drm_fini(pci_get_drvdata(pdev));
> +}
> +
> +static const struct pci_device_id glanda_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_DEVICE_ID_GLANDA_GPU) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, glanda_pci_ids);
> +
> +static struct pci_driver glandagpu_pci_driver = {
> +	.name = "glandagpu-pci",
> +	.id_table = glanda_pci_ids,
> +	.probe = glandagpu_pci_probe,
> +	.remove = glandagpu_pci_remove,
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
> +	ret = pci_register_driver(&glandagpu_pci_driver);
> +	if (ret) {
> +		pr_err("GlandaGPU: Failed to register PCI driver\n");
> +		platform_driver_unregister(&glandagpu_driver);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit glandagpu_exit(void)
> +{
> +	pci_unregister_driver(&glandagpu_pci_driver);
> +	platform_driver_unregister(&glandagpu_driver);
> +}
> +
> +module_init(glandagpu_init);
> +module_exit(glandagpu_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Leander Kieweg <kieweg.leander@gmail.com>");
> +MODULE_DESCRIPTION("DRM driver for GlandaGPU, an FPGA-based 2D GPU with VGA output");

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


