Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2F606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDnd6lhh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AFA910E31D;
	Mon, 26 Oct 2026 14:58:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4463210E31D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:58:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E66964179B;
 Mon, 26 Oct 2026 14:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619AF1F01825;
 Mon, 26 Oct 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793026708;
 bh=7kKsnvErS2M7mKHODfGafs0HP9Wc3MpeX/H2tS7dZrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JDnd6lhhiOA7DhYFcunEHmvb2582D3BM9BaZ7yJItYIB9X+PuaFsN2NPDuBTuJvV1
 okDsQzSO5wCU6XC+clfBktKvb9IQ26jr7lPkLektaU2zPbeVJo4vFmBjIc4fza7lct
 qZAUXa3iV44IZ02XMti8EGYMDq7xiiCEOabZsXa2otE6bu2MYiKcQ4fP5g8tXSuIMN
 bAPt+Uutma0dyAewAlRdnCjtRM+E85SiDkw+I4CUMDCWYTKy+6xVysF/hr54/RXq3o
 7ENbinP6Mqq1bnoNSehSsgNy8yjl3QgfEY0PiHtUZwsCzJGh1jhw2sxykQoJmQg/WD
 KkccojwNdZBuw==
Message-ID: <sashiko-outbox-185418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/23] drm/msm: Register the DCP backend
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-22-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 14:58:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/msm: misordered msm_dcp_register() and msm_dcp_unregister() ca=
lls
- [High] drm/msm: missing msm_separate_gpu_kms_components() check and DCP c=
ount
- [Low] drm/msm: link failure in msm_dcp_register() when DRM_MSM=3Dy and VI=
RTIO=3Dm
--

commit 8c20c0a0e35ec53b4a670a45026a398c4476bb45
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm: Register the DCP backend

This commit registers and unregisters the DCP platform driver from the MSM
DRM module init and exit paths, and provides no-op stubs in msm_drv.h when
CONFIG_DRM_MSM_DCP is disabled.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 5816c64d7ce7d..d413c361c4426 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -1208,6 +1208,7 @@ static int __init msm_drm_register(void)
>  	DBG("init");
>  	msm_mdp_register();
>  	msm_dpu_register();
> +	msm_dcp_register();
>  	msm_dsi_register();
>  	msm_hdmi_register();
>  	msm_dp_register();
> @@ -1229,6 +1230,7 @@ static void __exit msm_drm_unregister(void)
>  	msm_dsi_unregister();
>  	msm_mdp_unregister();
>  	msm_dpu_unregister();
> +	msm_dcp_unregister();

[Severity: High]
Are msm_dcp_register() and msm_dcp_unregister() ordered in the right place
relative to adreno_register() and adreno_unregister()?

In msm_drm_register() and msm_drm_unregister(), MDP5 (msm_mdp_register()) a=
nd
DPU (msm_dpu_register()) are registered first and unregistered last because
their platform devices are children of the top-level msm_mdss device. They
are populated when msm_mdss_register() runs at the end of msm_drm_register()
and depopulated via mdss_remove()->of_platform_depopulate() when
msm_mdss_unregister() runs at the start of msm_drm_unregister(), which tears
down the component master before adreno_unregister() is called.

By contrast, DCP (qcom,dcp-virtio) is a standalone top-level platform device
rather than a child of msm_mdss:

drivers/gpu/drm/msm/dcp/dcp_drv.c:dcp_component_register() {
    ...
	/* A GPU is optional for the DCP display-only DRM device. */
	msm_add_gpu_components(dev, &match);

	ret =3D component_master_add_with_match(dev, &msm_drm_ops, match);
    ...
}

drivers/gpu/drm/msm/dcp/dcp_drv.c:dcp_component_unregister() {
	struct msm_drm_private *drv =3D dev_get_drvdata(dev);

	component_master_del(dev, &msm_drm_ops);
	dcp_dpu_kms_cleanup_bridges(drv->kms);
}

Calling msm_dcp_register() before adreno_register() registers the DCP
component master before the Adreno component driver is registered. On module
unload, calling msm_dcp_unregister() at the end of msm_drm_unregister() runs
adreno_unregister() while the DCP component master (dcp_subsystem_dev) is
still active and bound, rather than first deleting the component master via
msm_dcp_unregister()->dcp_virtio_unregister()->dcp_virtio_remove()->
dcp_component_unregister()->component_master_del().

Should msm_dcp_register() be called at the end of msm_drm_register() and
msm_dcp_unregister() at the start of msm_drm_unregister(), alongside
msm_mdp4_register()/msm_mdss_register() and
msm_mdss_unregister()/msm_mdp4_unregister()?

> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index aa5dfd82ac6f7..befaa9f2cb5c5 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -417,6 +417,14 @@ static inline void msm_dpu_register(void) {}
>  static inline void msm_dpu_unregister(void) {}
>  #endif
> =20
> +#ifdef CONFIG_DRM_MSM_DCP
> +void msm_dcp_register(void);
> +void msm_dcp_unregister(void);

[Severity: Low]
Will enabling CONFIG_DRM_MSM_DCP cause a vmlinux link failure when
CONFIG_DRM_MSM=3Dy and CONFIG_VIRTIO=3Dm?

In drivers/gpu/drm/msm/Kconfig, DRM_MSM_DCP is a bool symbol that depends on
tristate DRM_MSM and tristate VIRTIO:

config DRM_MSM_DCP
	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
	depends on DRM_MSM
	depends on VIRTIO

When CONFIG_DRM_MSM=3Dy and CONFIG_VIRTIO=3Dm, CONFIG_DRM_MSM_DCP can be en=
abled
as y, building msm_drv.o and the DCP VirtIO backend objects into vmlinux
while virtio.ko and virtio_ring.ko are built as loadable modules, leaving
msm_drm_register()->msm_dcp_register()->dcp_virtio_register() with unresolv=
ed
references to VirtIO symbols such as register_virtio_driver(),
register_virtio_device(), and vring_create_virtqueue().

> +#else
> +static inline void msm_dcp_register(void) {}
> +static inline void msm_dcp_unregister(void) {}
> +#endif

[Severity: High]
How does DCP registration interact with msm_separate_gpu_kms_components() a=
nd
msm_separate_gpu_kms_auto()?

When msm_dcp_register()->dcp_virtio_register()->dcp_virtio_probe()->
dcp_component_register() runs, it adds the GPU to the component match list
unconditionally:

drivers/gpu/drm/msm/dcp/dcp_drv.c:dcp_component_register() {
    ...
	/* A GPU is optional for the DCP display-only DRM device. */
	msm_add_gpu_components(dev, &match);

	ret =3D component_master_add_with_match(dev, &msm_drm_ops, match);
    ...
}

Unlike msm_drv_probe() in drivers/gpu/drm/msm/msm_drv.c, this does not check
!msm_separate_gpu_kms_components():

drivers/gpu/drm/msm/msm_drv.c:msm_drv_probe() {
    ...
	if (!msm_separate_gpu_kms_components()) {
		ret =3D msm_add_gpu_components(master_dev, &match);
		if (ret)
			return ret;
	}
    ...
}

When msm_separate_gpu_kms_components() is true and an Adreno GPU is present
in DT, adreno_probe() calls msm_gpu_probe() instead of component_add().
Because dcp_component_register() still adds the GPU node to its match list,
component_master_add_with_match() will wait indefinitely for a GPU component
that is never registered, preventing the DCP DRM device from ever binding.

In addition, unlike CONFIG_DRM_MSM_MDP4 and CONFIG_DRM_MSM_MDSS in
drivers/gpu/drm/msm/msm_drv.h, no msm_count_dcp() helper is provided or
included in msm_separate_gpu_kms_auto():

drivers/gpu/drm/msm/msm_drv.c:msm_separate_gpu_kms_auto() {
	int gpus =3D msm_count_gpus();
	int display_subsystems =3D msm_count_mdss() + msm_count_mdp4();

	if (gpus <=3D 0 || display_subsystems <=3D 0)
		return false;

	/* Single card if there is exactly one GPU and one display subsystem */
	return gpus > 1 || display_subsystems > 1;
}

Without counting DCP nodes in display_subsystems, won't
msm_separate_gpu_kms_auto() miscalculate the number of display subsystems on
platforms with DCP?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D22
