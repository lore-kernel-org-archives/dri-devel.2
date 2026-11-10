Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9ldlVb+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBDF10E227;
	Tue, 10 Nov 2026 05:18:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9299210E227
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34E8340AD2;
 Tue, 10 Nov 2026 05:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8D61F0089F;
 Tue, 10 Nov 2026 05:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794287883;
 bh=16qT4jMYFBrN0LVMSp2d6jxNPPPFRGOVf74XCZcDZKg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M9ldlVb+0yi5iHtFn2MVvtnyyBlrGEXdYeAaDStPjkirMWkWkncpb7qokVuep/C8N
 Zvj3O+oQt2Fj+r7yNvI2g8V09n9Zm3ToFgdhB2+9GabzlHazCkHRpExlnm9KcASyGp
 5tiFcJ1MNqgFgjHa2h+/WEbIStPYZJ573vEkNrl181QDx7RoLIGk0qmv/5VJkNZGF9
 UCZVYcoPvgfrpQ+fnHnYlyG6vUYRXAFrWvGtGctQdUPNGCg6cPb4xmaAUUJYaF5QiY
 6uVaRW3VCCbZ7Uabba+eMva5nfTCd/GtQnQW8WgO3AP6WPCuNQ6raz7SIVvrkkO8iX
 nDGx8V4Ma5Cxw==
Message-ID: <sashiko-outbox-206271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 22/29] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-22-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-22-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:18:01 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/msm: link failure from unconditional DP MST calls when
  DRM_MSM_DP=3Dn
--

commit aae2fe1d03e1fee18f3ec2335e15f03b9cd4b21b
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: wire MST helpers into atomic check and commit paths

This commit wires the DisplayPort MST atomic helpers into msm_atomic_check(=
),
msm_atomic_commit_tail(), and a new msm_atomic_commit_setup() callback.

> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_a=
tomic.c
> index a8babf1dbe0d3..e70e5088cfe53 100644
> --- a/drivers/gpu/drm/msm/msm_atomic.c
> +++ b/drivers/gpu/drm/msm/msm_atomic.c
> @@ -4,6 +4,7 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
> =20
> +#include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_vblank.h>
> =20
> @@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct =
drm_atomic_commit *state)
>  	if (ret)
>  		return ret;
> =20
> -	return drm_atomic_helper_check(dev, state);
> +	ret =3D drm_atomic_helper_check(dev, state);
> +	if (ret)
> +		return ret;
> +
> +	return drm_dp_mst_atomic_check(state);
>  }
> =20
>  void msm_atomic_commit_tail(struct drm_atomic_commit *state)
> @@ -221,6 +226,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit =
*state)
> =20
>  	trace_msm_atomic_commit_tail_start(async, crtc_mask);
> =20
> +	drm_dp_mst_atomic_wait_for_dependencies(state);
> +
>  	kms->funcs->enable_commit(kms);
> =20
>  	/*
> @@ -322,3 +329,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit =
*state)
> =20
>  	trace_msm_atomic_commit_tail_finish(async, crtc_mask);
>  }
> +
> +int msm_atomic_commit_setup(struct drm_atomic_commit *state)
> +{
> +	return drm_dp_mst_atomic_setup_commit(state);
> +}

[Severity: Medium]
Does this fail to link when CONFIG_DRM_MSM_KMS is enabled and
CONFIG_DRM_MSM_DP is disabled?

msm_atomic.o is built under CONFIG_DRM_MSM_KMS, which only selects
DRM_DISPLAY_HELPER, whereas drm_dp_mst_topology.o is built under
CONFIG_DRM_DISPLAY_DP_HELPER (selected by DRM_MSM_DP) and
drm_dp_mst_helper.h provides no inline stubs for these helpers.  When no
other enabled driver selects DRM_DISPLAY_DP_HELPER, the build fails with
undefined references to drm_dp_mst_atomic_check(),
drm_dp_mst_atomic_wait_for_dependencies(), and
drm_dp_mst_atomic_setup_commit().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D22
