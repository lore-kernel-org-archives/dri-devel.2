Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRAZij1+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13EE10ED4B;
	Mon, 26 Oct 2026 09:48:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126CE10ED5F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:48:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D25A843534;
 Mon, 26 Oct 2026 09:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DE51F01825;
 Mon, 26 Oct 2026 09:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793008088;
 bh=QNjun783pTdiQfTLrK5OlpyTvS0qYP5wBlMosU8czwU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WRAZij1+fo95xgkPP6IeMvJXu04cno+M94OLhvwCJWahVV2HDahyQg+UaLuOONoDA
 v9EzPlyA/1VGve/xAg3e5pB762wjipFXQ79Nm1+wUpgNaYsSoGXjv8AfuXuDwObv+U
 ZnLHFR0gIL5s3batFhAHagCxSp8Z9RHPwm8NZxqsE3OaskCio0gmy9Zoy2qMVE12XY
 9MsgGyYNG97usTLazHC3RZKeKXI6xQ7NEaumt+d4YxHJiorJURsjOlaW/+hiEqzj7D
 /zKMpnmZu2g3Qo0HWLrj3Et+ooCE7dkQs80TkYZAFs1o9IhIQRfDajSoZ3Lz7nb2qK
 Chumyth2YaFVw==
Message-ID: <sashiko-outbox-184837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/23] drm/msm/dcp: Add HFI packet helpers
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-2-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-2-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:48:07 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/msm/dcp: DRM_MSM_DCP bool dependency on tristate VIRTIO allows =
DRM_MSM=3Dy with VIRTIO=3Dm
--

commit 29edd03d5dbd7916e10401025f35f2e578051ed0
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI packet helpers

This commit adds the HFI packet definitions, packing and unpacking helpers,
and key-value parsing utilities for communicating with the Display
Coprocessor (DCP) firmware, along with the DRM_MSM_DCP Kconfig symbol and
Makefile rules.

> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index ed1c4775d1e92..a9f049271c251 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -114,6 +114,31 @@ config DRM_MSM_DPU
>  	  the MSM DRM driver. It is the display controller found in devices
>  	  using e.g. SDM845 and newer platforms.
> =20
> +config DRM_MSM_DCP
> +	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
> +	depends on DRM_MSM
> +	depends on VIRTIO
> +	select DRM_MSM_KMS
> +	select DRM_BRIDGE_CONNECTOR
> +	select DRM_MIPI_DSI
> +	select DRM_DISPLAY_DSC_HELPER
> +	default y

[Severity: Low]
Can this Kconfig dependency allow CONFIG_DRM_MSM_DCP=3Dy when CONFIG_DRM_MS=
M=3Dy
and CONFIG_VIRTIO=3Dm?

Both DRM_MSM and VIRTIO are tristate symbols, while DRM_MSM_DCP is a bool
symbol whose objects in drivers/gpu/drm/msm/Makefile are linked directly
into msm.o via msm-display-$(CONFIG_DRM_MSM_DCP) and
msm-$(CONFIG_DRM_MSM_KMS) +=3D $(msm-display-y):

drivers/gpu/drm/msm/Makefile:
    msm-display-$(CONFIG_DRM_MSM_DCP) +=3D \
            dcp/hfi/hfi_packer.o \
            dcp/hfi/hfi_unpacker.o \
            dcp/hfi/hfi_utils.o

In Kconfig, a bool option with depends on DRM_MSM and depends on VIRTIO
evaluates its upper bound as y even when CONFIG_DRM_MSM=3Dy and
CONFIG_VIRTIO=3Dm. When the DCP VirtIO transport and driver objects are add=
ed
to msm-display-$(CONFIG_DRM_MSM_DCP) later in this series ("drm/msm/dcp: Add
HFI VirtIO transport", "drm/msm/dcp: Add Qualcomm VirtIO transport wrapper",
and "drm/msm/dcp: Add DCP VirtIO driver"), built-in msm.o calls VirtIO core
and vring symbols such as register_virtio_driver(), register_virtio_device(=
),
virtio_find_vqs(), and vring_create_virtqueue() that live in loadable
modules when CONFIG_VIRTIO=3Dm, resulting in a vmlinux link failure.

Should DRM_MSM_DCP use depends on VIRTIO=3Dy || VIRTIO=3DDRM_MSM (or DRM_MS=
M use
depends on VIRTIO || !DRM_MSM_DCP) to prevent a built-in msm driver from
linking against modular virtio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D2
