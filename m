Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814A8C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83F610F569;
	Thu,  3 Sep 2026 12:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="i7zLglKE";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA4A10F569
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788437276; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UOqXUjksauaCF6j0R2WvQGx7W7ct+pOGuB7xfJWI66RWvgqGBovfoP+kY4t9s+SH9mCMM9/cXFYWNPdIhQqK2iKkAIwecmv7I/3pK+7dPJNb1yGfOXnwcfjSbBHg73HIzk1pa5dL0vKwa/Lh9G53Bg6TiUIKjDRf046YFW2tN8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788437276;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RJgIA2x6iwR3vu3rMv+chG5TvTVx8Bb5vQhtPq96FMU=; 
 b=Cpx3fJTxmt/9BXiesVlQnNyKgX+2+JvqI4arZ0SEPUSgp+tEecPdWC+cOV+TDhZ8W1zQgjqahckbB+4yJarPi6t0b3b59JLuqtq/Sey4UAEVJ+N8SyssY6dJb3f0dbDTqxdbkETCADP6DU0qVrKrwu2vjYlQ/eNp4gxAHQKWFcA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788437276; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=RJgIA2x6iwR3vu3rMv+chG5TvTVx8Bb5vQhtPq96FMU=;
 b=i7zLglKEVY7pNBWONkcosdNW3xTVTY80NNc0MyThCD612ifHLfShJ65cR8lTDK+d
 yOF0t2u7N5U6qMf/3slzaROi2bOH+8oDZkgA6SNFhwpOebLhrj8HGjax+NEmswq59NM
 3a27a0pwykeN6WQMcLLlSDKJLLkS4WjqCCGcREnDOWm7I6vcHl9Mtucspnoq+Zi34vM
 ECsqq7V1ZYg3mSI/bJPIAo7moAWlEUO5LGbPNuKXskKj/QP4rlJiuodGxeAMKFu3ABk
 UHQmB742mtntNXuc4JSMZRHoi/Je5bKp52TiXHSxAQoMiabCq6EGSBBy4gOEz29bp4W
 WzYhWUzDXQ==
Received: by mx.zohomail.com with SMTPS id 1788437273594422.63839805930354;
 Thu, 3 Sep 2026 05:07:53 -0700 (PDT)
Message-ID: <e492222feabaa5c72229c93ce75f9500e4346da1.camel@icenowy.me>
Subject: Re: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device driver
From: Icenowy Zheng <uwu@icenowy.me>
To: codykang.hk@gmail.com, David Airlie <airlied@gmail.com>, Simona Vetter	
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan	
 <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>, Michael
 Turquette	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney	 <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yao Zi
 <me@ziyao.cc>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <u.kleine-koenig@baylibre.com>, Guodong Xu <docular.xu@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org
Date: Thu, 03 Sep 2026 20:07:32 +0800
In-Reply-To: <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-08-09=E6=97=A5=E7=9A=84 21:14 +0800=EF=BC=8CCody Kang via B4=
 Relay=E5=86=99=E9=81=93=EF=BC=9A
> From: Cody Kang <codykang.hk@gmail.com>
>=20
> Add the DRM device for the SpacemiT K3 Saturn display processing unit
> and hook the driver up to the build. The SoC has two DPU instances;
> each drives one CRTC that scans out a single primary plane in linear
> RGB at up to 3840x2160@60 and feeds a downstream DP/eDP controller
> over an OF-graph endpoint. Buffers use drm_gem_shmem_helper. The
> AFBC/compressed decode path is not exposed and writeback is not
> implemented.
>=20
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
>=20
> ---
> v2:
> - check for an ERR_PTR component match before
> =C2=A0 component_master_add_with_match() (Sashiko)
> - add a comment explaining why commit_tail waits for flip_done before
> =C2=A0 commit_hw_done (Sashiko)
> ---
> =C2=A0drivers/gpu/drm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/spacemit/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 18 ++++
> =C2=A0drivers/gpu/drm/spacemit/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 12 +++
> =C2=A0drivers/gpu/drm/spacemit/spacemit_drm.c | 140
> ++++++++++++++++++++++++++++++++
> =C2=A05 files changed, 172 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f6..81081562a6da2 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -341,6 +341,7 @@ source "drivers/gpu/drm/renesas/Kconfig"
> =C2=A0source "drivers/gpu/drm/rockchip/Kconfig"
> =C2=A0source "drivers/gpu/drm/sitronix/Kconfig"
> =C2=A0source "drivers/gpu/drm/solomon/Kconfig"
> +source "drivers/gpu/drm/spacemit/Kconfig"
> =C2=A0source "drivers/gpu/drm/sprd/Kconfig"
> =C2=A0source "drivers/gpu/drm/sti/Kconfig"
> =C2=A0source "drivers/gpu/drm/stm/Kconfig"
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd7830..4a105520ee912 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -204,6 +204,7 @@ obj-$(CONFIG_DRM_MSM) +=3D msm/
> =C2=A0obj-$(CONFIG_DRM_TEGRA) +=3D tegra/
> =C2=A0obj-$(CONFIG_DRM_STM) +=3D stm/
> =C2=A0obj-$(CONFIG_DRM_STI) +=3D sti/
> +obj-$(CONFIG_DRM_SPACEMIT) +=3D spacemit/
> =C2=A0obj-y=C2=A0			+=3D imx/
> =C2=A0obj-$(CONFIG_DRM_INGENIC) +=3D ingenic/
> =C2=A0obj-$(CONFIG_DRM_LOGICVC) +=3D logicvc/
> diff --git a/drivers/gpu/drm/spacemit/Kconfig
> b/drivers/gpu/drm/spacemit/Kconfig
> new file mode 100644
> index 0000000000000..51e38dabfdba5
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config DRM_SPACEMIT
> +	tristate "DRM support for SpacemiT display controllers"
> +	depends on DRM && OF && MMU
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	select DRM_CLIENT_SELECTION
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_SHMEM_HELPER
> +	select REGMAP_MMIO
> +	select VIDEOMODE_HELPERS
> +	help
> +	=C2=A0 Choose this option if you have a SpacemiT SoC with the
> Saturn
> +	=C2=A0 display processing unit, such as the K3. The DPU scans out
> +	=C2=A0 framebuffers through its private display MMU and feeds a
> +	=C2=A0 DisplayPort or embedded DisplayPort controller.
> +
> +	=C2=A0 If M is selected the module will be called spacemit-drm.
> diff --git a/drivers/gpu/drm/spacemit/Makefile
> b/drivers/gpu/drm/spacemit/Makefile
> new file mode 100644
> index 0000000000000..b3b148000cf7b
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +spacemit-drm-y :=3D spacemit_drm.o \
> +		=C2=A0 spacemit_crtc.o \
> +		=C2=A0 spacemit_cmdlist.o \
> +		=C2=A0 spacemit_planes.o \
> +		=C2=A0 spacemit_dmmu.o \
> +		=C2=A0 dpu/dpu_saturn.o \
> +		=C2=A0 dpu/dpu_saturn_hee.o \
> +		=C2=A0 dpu/saturn_fbcmem.o
> +
> +obj-$(CONFIG_DRM_SPACEMIT) +=3D spacemit-drm.o
> diff --git a/drivers/gpu/drm/spacemit/spacemit_drm.c
> b/drivers/gpu/drm/spacemit/spacemit_drm.c
> new file mode 100644
> index 0000000000000..12b2fe8b6fc99
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025-2026 SpacemiT Co., Ltd.
> + *
> + */
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_fbdev_shmem.h>
> +#include <linux/component.h>
> +#include <linux/of_graph.h>
> +
> +#include "spacemit_drm.h"
> +#include "spacemit_crtc.h"
> +
> +#define DRIVER_NAME	"spacemit"
> +#define DRIVER_DESC	"SpacemiT SoC DRM driver"
> +#define DRIVER_MAJOR	1
> +#define DRIVER_MINOR	0
> +
> +static void spacemit_drm_atomic_commit_tail(struct drm_atomic_commit
> *old_state)
> +{
> +	struct drm_device *dev =3D old_state->dev;
> +
> +	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> +
> +	drm_atomic_helper_commit_modeset_enables(dev, old_state);
> +
> +	drm_atomic_helper_commit_planes(dev, old_state,
> +					DRM_PLANE_COMMIT_ACTIVE_ONLY
> );
> +
> +	/*
> +	 * Flip first, hw_done second: the cmdlist engine reads the
> old
> +	 * state's DMA buffers until the frame boundary, and hw_done
> both
> +	 * releases the next commit to start programming and lets
> the old
> +	 * state (with those buffers) be torn down.
> +	 */
> +	drm_atomic_helper_wait_for_flip_done(dev, old_state);
> +
> +	drm_atomic_helper_commit_hw_done(old_state);
> +
> +	drm_atomic_helper_cleanup_planes(dev, old_state);
> +}
> +
> +static const struct drm_mode_config_helper_funcs
> spacemit_drm_mode_config_helper =3D {
> +	.atomic_commit_tail =3D spacemit_drm_atomic_commit_tail,
> +};
> +
> +static const struct drm_mode_config_funcs
> spacemit_drm_mode_config_funcs =3D {
> +	.fb_create =3D drm_gem_fb_create,
> +	.atomic_check =3D drm_atomic_helper_check,
> +	.atomic_commit =3D drm_atomic_helper_commit,
> +};
> +
> +int spacemit_drm_mode_config_init(struct drm_device *drm)
> +{
> +	int ret;
> +
> +	ret =3D drmm_mode_config_init(drm);
> +	if (ret)
> +		return ret;
> +
> +	drm->mode_config.min_width =3D 1;
> +	drm->mode_config.min_height =3D 1;
> +	/* K3 user manual: each DPU scans out at most 3840x2160@60
> */
> +	drm->mode_config.max_width =3D 3840;
> +	drm->mode_config.max_height =3D 2160;

This is for the biggest possible framebuffer instead of the possible
scanout pixel count.

The width here should be based on the maximum allowed pitch of the
display controller instead of the single-GPU maximum size, otherwise it
won't be able to drive two 3840x2160 screens in a side-by-side
configuration because this will create a 7680x2160 framebuffer.

Thanks,
Icenowy

> +
> +	drm->mode_config.funcs =3D &spacemit_drm_mode_config_funcs;
> +	drm->mode_config.helper_private =3D
> &spacemit_drm_mode_config_helper;
> +
> +	return 0;
> +}
> +
> +DEFINE_DRM_GEM_FOPS(spacemit_drm_fops);
> +
> +struct drm_driver spacemit_drm_drv =3D {
> +	.driver_features =3D DRIVER_GEM | DRIVER_MODESET |
> DRIVER_ATOMIC,
> +	.fops =3D &spacemit_drm_fops,
> +
> +	DRM_GEM_SHMEM_DRIVER_OPS,
> +	DRM_FBDEV_SHMEM_DRIVER_OPS,
> +
> +	.name		=3D DRIVER_NAME,
> +	.desc		=3D DRIVER_DESC,
> +	.major		=3D DRIVER_MAJOR,
> +	.minor		=3D DRIVER_MINOR,
> +};
> +
> +static int compare_of(struct device *dev, void *data)
> +{
> +	return dev->of_node =3D=3D data;
> +}
> +
> +int spacemit_drm_of_component_probe(struct device *dev)
> +{
> +	struct device_node *ports, *port, *ep;
> +	struct device_node *remote;
> +	struct component_match *match =3D NULL;
> +
> +	if (!dev->of_node)
> +		return -EINVAL;
> +
> +	/* The DPU is the drm root: its OF graph names the DP/eDP
> components. */
> +	ports =3D of_get_child_by_name(dev->of_node, "ports");
> +	if (!ports) {
> +		dev_err(dev, "missing 'ports' child node\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(ports, port) {
> +		if (!of_node_name_eq(port, "port"))
> +			continue;
> +		for_each_child_of_node(port, ep) {
> +			if (!of_node_name_eq(ep, "endpoint"))
> +				continue;
> +			remote =3D
> of_graph_get_remote_port_parent(ep);
> +			if (!remote)
> +				continue;
> +			if (of_device_is_available(remote))
> +				drm_of_component_match_add(dev,
> &match,
> +							=C2=A0=C2=A0
> compare_of, remote);
> +			of_node_put(remote);
> +		}
> +	}
> +	of_node_put(ports);
> +
> +	if (!match) {
> +		dev_err(dev, "no downstream component available\n");
> +		return -ENODEV;
> +	}
> +	if (IS_ERR(match))
> +		return PTR_ERR(match);
> +
> +	return component_master_add_with_match(dev,
> &spacemit_drm_master_ops,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match);
> +}
