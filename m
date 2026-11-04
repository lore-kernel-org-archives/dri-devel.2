Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1F606EEB1
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YY5rD0Hh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B8B10E878;
	Wed,  4 Nov 2026 16:47:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBE1810FD33
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:46:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DFDB419A1;
 Wed,  4 Nov 2026 16:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB31F000C1;
 Wed,  4 Nov 2026 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793810813;
 bh=swD8KhQ6qSFZQXwIepcGqt3q8zYEv+GOJdSSjJrzNEE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YY5rD0Hh3eGSR3XyiPJYjE09HOzBLyvoztJFwJ2LzbzWo70lXkJbB5kLHJgl7dSvW
 K1RfPSzXBIqOWjb7j8YMVRNrzYhq7650JxBhqJLpcxZkOarkMtz5OySNEpbyE9y7sb
 jH+qPUJda1qhsToozIOr6B+FzAbwwiO+aAxOwEQe4d/2zJgwaS0unxFakDJzpP3fS5
 1DAQk59ylho4SL8qPEWgQfqXRAYVFt8qGLR1xjNytWYsyPgfzuXYItWYeNWQVQemwE
 UxQ69CyHCnvUpMcgDIgvIZSH7tNuJZsBB1AvtgQ/m3UcL5Sm10DULoGynLZ/Na++zV
 zblnUDwMlPGmA==
Message-ID: <sashiko-outbox-197680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] drm/fourcc: describe the Qualcomm UBWC layout
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261104-ubwc-format-docs-v1-4-389044012b4e@oss.qualcomm.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
 <20261104-ubwc-format-docs-v1-4-389044012b4e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:46:52 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/fourcc: documented UBWC P010 layout mismatches msm driver
--

commit 9d1d25812fbfd6458cdaf0aaead9ba0fe219bc18
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/fourcc: describe the Qualcomm UBWC layout

This commit documents the buffer layout, plane ordering, tile sizes, and
alignment requirements for DRM_FORMAT_MOD_QCOM_COMPRESSED across RGB,
DRM_FORMAT_NV12, and DRM_FORMAT_P010 formats.

> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 0bb049f91524e..4b6a4a827f6b8 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -820,13 +820,53 @@ extern "C" {

[ ... ]

> + * DRM_FORMAT_P010, two planes, Y then CbCr, 16 bits per sample:
> + *   Y data: pitch ALIGN(width * 2, 256), ALIGN(height, 16) lines
> + *   Y metadata: 32x4 pixel tiles, stride ALIGN(DIV_ROUND_UP(width, 32),=
 64),
> + *   ALIGN(DIV_ROUND_UP(height, 4), 16) lines
> + *   CbCr data: pitch ALIGN(width * 2, 256),
> + *   ALIGN(DIV_ROUND_UP(height, 2), 16) lines
> + *   CbCr metadata: 16x4 sample tiles,
> + *   stride ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(width, 2), 16), 64),
> + *   ALIGN(DIV_ROUND_UP(DIV_ROUND_UP(height, 2), 4), 16) lines

[Severity: Medium]
Does the documented layout for DRM_FORMAT_P010 match what the msm driver
currently expects for DRM_FORMAT_MOD_QCOM_COMPRESSED?

In drivers/gpu/drm/msm/disp/mdp_format.c, mdp_formats_ubwc[] defines the
compressed P010 entry using PSEUDO_YUV_FMT_TILED, which unconditionally
sets MSM_FORMAT_FLAG_UNPACK_TIGHT:

drivers/gpu/drm/msm/disp/mdp_format.c:
    #define PSEUDO_YUV_FMT_TILED(fmt, a, r, g, b, e0, e1, chroma, flg, tile=
_height) \
        ...
        .fetch_mode =3D MDP_FETCH_UBWC,                                    =
 \
        .flags =3D MSM_FORMAT_FLAG_UNPACK_TIGHT |                          =
 \
                 MSM_FORMAT_FLAG_YUV |                                    \
                 MSM_FORMAT_FLAG_COMPRESSED | flg,                        \

    static const struct msm_format mdp_formats_ubwc[] =3D {
        ...
        PSEUDO_YUV_FMT_TILED(P010,
            BPC8, BPC8, BPC8,
            C1_B_Cb, C2_R_Cr,
            CHROMA_420, MSM_FORMAT_FLAG_DX,
            MDP_TILE_HEIGHT_UBWC),

When DRM_IOCTL_MODE_ADDFB2 calls msm_framebuffer_create() ->
msm_framebuffer_init() -> mdp_format_ubwc_plane_sizes(), the presence of
MSM_FORMAT_FLAG_UNPACK_TIGHT causes it to take the tightly packed TP10/QC10C
branch instead of the 16-bit per sample else branch described in this
comment:

drivers/gpu/drm/msm/disp/mdp_format.c:mdp_format_ubwc_plane_sizes() {
    ...
    if (MSM_FORMAT_IS_DX(fmt)) {
        if (fmt->flags & MSM_FORMAT_FLAG_UNPACK_TIGHT) {
            /* can't use round_up() here because 192 is NPoT */
            stride =3D roundup(width, 192);
            stride =3D round_up(stride * 4 / 3, 256);
            y_tile_width =3D 48;
        } else {
            stride =3D round_up(width * 2, 256);
            y_tile_width =3D 32;
        }
    ...
}

Because msm_framebuffer_init() checks that mode_cmd->pitches[0] equals
ubwc_pitch[0]:

drivers/gpu/drm/msm/msm_fb.c:msm_framebuffer_init() {
    ...
    } else if (mode_cmd->pitches[0] !=3D ubwc_pitch[0]) {
        ret =3D UERR(EINVAL, dev, "pitch %u, expected %u",
                   mode_cmd->pitches[0], ubwc_pitch[0]);
        goto fail;
    }
    ...
}

won't a DRM_FORMAT_P010 framebuffer allocated with
DRM_FORMAT_MOD_QCOM_COMPRESSED according to this documentation (with pitch
ALIGN(width * 2, 256) and 32x4 Y tiles) be rejected with -EINVAL by
msm_framebuffer_init(), or have the DPU unpacker configured with
UNPACK_TIGHT =3D 1 and UNPACK_ALIGN_MSB =3D 0 in dpu_hw_setup_format_impl()=
 and
dpu_hw_wb_setup_format()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-ubwc-forma=
t-docs-v1-0-389044012b4e@oss.qualcomm.com?part=3D4
