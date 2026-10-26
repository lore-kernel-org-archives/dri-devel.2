Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC86606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SS+gdKcT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24D910E369;
	Mon, 26 Oct 2026 06:59:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E2F10E369
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:59:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B81364322E;
 Mon, 26 Oct 2026 06:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F501F01825;
 Mon, 26 Oct 2026 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792997971;
 bh=PvtNn02SEHhLD5isLZTb60cV55xxExDkkpgs/aFxMlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SS+gdKcTUvTYXYbGW5yV7WOnhYHipnA7DssMIWCY5v6nU9wY0XZJ6/n6k1CHzT1Xb
 NdRa/fu4YOloupA0F5bU2QyuxjgEC9vrYDaWWFgtJGq8u0XbvquydcSMTzEoPTGlIH
 8uknYEf9TFmfHgrGd2Tg5tGoit6G3i2X4ApREZRa1hBnkNcqisVDhwi8rAfApum0+O
 ttFY8cApf7/Gf7gh8oKZUKkQ7so5prDfb0FJJfpaSOZYrNNvCZHA1IV4xdnjqQBKIH
 Q1YLRWB6qJQtYu6tGnNcpEX2hy+QsJu9V+G1J/jodKLdOlzIz2EAiulKnLHgBC/G8Z
 r1fbiBwjOc95w==
Message-ID: <sashiko-outbox-184640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Support for querying Firmware information
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026-fwversion-v1-1-3ed17c65bf4c@imgtec.com>
References: <20261026-fwversion-v1-1-3ed17c65bf4c@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 06:59:30 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/imagination: missing 64-bit padding in struct drm_pvr_dev_qu=
ery_fw_info
--

commit 1360941b5bdd5b35c5e7870e3bae3cb8d37c65fd
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Support for querying Firmware information

This commit adds a new dev query subtype to query firmware version
information from the driver.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.h b/drivers/gpu/drm/imag=
ination/pvr_drv.h
> index 7fa147312dd11..fd01feeeda1d4 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.h
> +++ b/drivers/gpu/drm/imagination/pvr_drv.h
[ ... ]
> @@ -68,6 +69,7 @@ int pvr_set_uobj_array(const struct drm_pvr_obj_array *=
out, u32 min_stride, u32
>  	PVR_UOBJ_DECL(struct drm_pvr_dev_query_heap_info, heaps) \
>  	PVR_UOBJ_DECL(struct drm_pvr_static_data_area, offset) \
>  	PVR_UOBJ_DECL(struct drm_pvr_dev_query_static_data_areas, static_data_a=
reas) \
> +	PVR_UOBJ_DECL(struct drm_pvr_dev_query_fw_info, minor_version) \
>  	)
> =20
>  /**
[ ... ]
> diff --git a/include/uapi/drm/pvr_drm.h b/include/uapi/drm/pvr_drm.h
> index ccf6c2112468f..94281af974c78 100644
> --- a/include/uapi/drm/pvr_drm.h
> +++ b/include/uapi/drm/pvr_drm.h
> @@ -434,6 +434,18 @@ struct drm_pvr_dev_query_static_data_areas {
>  	struct drm_pvr_obj_array static_data_areas;
>  };
> =20
> +/**
> + * struct drm_pvr_dev_query_fw_info - Container used to fetch information
> + * about the GPU Firmware like its version.
> + */
> +struct drm_pvr_dev_query_fw_info {
> +	/** @major_version: Major version of the Firmware. */
> +	__u16 major_version;
> +
> +	/** @minor_version: Minor version of the Firmware. */
> +	__u16 minor_version;
> +};

[Severity: Medium]
Should struct drm_pvr_dev_query_fw_info include an explicit __u32 _padding_4
field to pad the structure to 64-bit alignment, and pass _padding_4 as the
last member in the pvr_drv.h declaration macro?

The documentation at the top of include/uapi/drm/pvr_drm.h states that all
ioctl and dev query structs must be padded to 64-bit alignment using explic=
it
_padding_[x] fields:

include/uapi/drm/pvr_drm.h:
 *  - All members must be type-aligned.
 *  - The overall struct must be padded to 64-bit alignment.
 *  - Explicit padding is almost always required. This takes the form of
 *    ``_padding_[x]`` members of sufficient size to pad to the next power-=
of-two
 *    alignment, where [x] is the offset into the struct in hexadecimal. Ar=
rays
 *    are never used for alignment. Padding fields must be zeroed; this is
 *    always checked.
 ...
 * In addition to the IOCTL argument structs, the PowerVR UAPI makes use of
 * DEV_QUERY argument structs. These are used to fetch information about the
 * device and runtime. These structs are subject to the same rules set out
 * above.

As defined, struct drm_pvr_dev_query_fw_info is only 4 bytes, so
pvr_ioctl_dev_query() -> pvr_fw_info_get() reports a size of 4 when
args->pointer is zero and copies out a 4-byte structure.

If a 64-bit field is appended to struct drm_pvr_dev_query_fw_info in the
future, leaving it at 4 bytes now would introduce implicit compiler padding=
 at
offset 4 on 64-bit architectures and cause a 32-bit versus 64-bit layout
mismatch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-fwversion-=
v1-1-3ed17c65bf4c@imgtec.com?part=3D1
