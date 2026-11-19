Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA910606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/74/H+0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A20711218F;
	Thu, 19 Nov 2026 08:46:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AD611218F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:46:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4C8E62033;
 Thu, 19 Nov 2026 08:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BC21F000C5;
 Thu, 19 Nov 2026 08:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795077982;
 bh=scBlr3IqasjUMz2yPm3va+s7LRECxyRyjlz4MMEBY0w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D/74/H+0Vn6WheAheiLobaZlVtEXe1HZZxLN8PHNSI9X4EtHuOT4v5OQloj7YhjWA
 f34yAZSS47O3O/Owyrc0CktOmtIVUpxVce80UXrBBI8/KL6lEsT8zcwheaXjXq+ACI
 5g5ZGlLiGlAiqpK9Ut0ao5MPo2BvzzHcbCaDcUSoarLlG+VTJWb+pcWQYiAGleGo/x
 qvuH5xUZnc00/DCkhMjlW5N7dvD81rEh6CrmiEbl+E9jzf9NQehR0N/b68LX73MbRM
 kN9VYzn7/azNBf52x+Yj1xvGdd1A9aD4ShakMqhVQR93EPMEEL+CJKF4cxwCsCQAd/
 Pffixh+8lys+Q==
Message-ID: <sashiko-outbox-222708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 22/29] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-22-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-22-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:46:21 +0000
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

commit 45937631fc3531311a3391632556b054bf1c3512
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: wire MST helpers into atomic check and commit paths

This commit wires the DisplayPort MST atomic helper functions into the
MSM KMS atomic check, commit setup, and commit tail paths.

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
Will calling drm_dp_mst_atomic_check(),
drm_dp_mst_atomic_wait_for_dependencies(), and
drm_dp_mst_atomic_setup_commit() unconditionally break the build when
CONFIG_DRM_MSM_KMS is enabled and CONFIG_DRM_MSM_DP is disabled?

msm_atomic.c is built under CONFIG_DRM_MSM_KMS, which only selects
DRM_DISPLAY_HELPER, whereas drm_dp_mst_topology.o is built under
CONFIG_DRM_DISPLAY_DP_HELPER (selected by CONFIG_DRM_MSM_DP) and
drm_dp_mst_helper.h does not provide inline stubs when
CONFIG_DRM_DISPLAY_DP_HELPER is disabled.  Unless DRM_DISPLAY_DP_HELPER
is selected by another enabled driver, linking fails with undefined
references to these three symbols.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D22
