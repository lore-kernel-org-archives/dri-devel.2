Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4012EC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8167B10E7A9;
	Mon, 31 Aug 2026 09:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KcBtwXFq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF18210E7A9
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 650B242B94;
 Mon, 31 Aug 2026 09:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7E21F000E9;
 Mon, 31 Aug 2026 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788169054;
 bh=6eYFTLXV5iCkECEXMV16V438S1S8bj0C/GTR/1INfBA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KcBtwXFqa4f6l9M1yT2vN35GtCRGTUJg9QW996KYMCrgJC2JedAswC8N5zfd4wavM
 DzkxVuhjyO7GOiJkp+9etB7REZ7wR2z65l4kiCvSHnksslIAUwW2tEQYo5EooZg3dd
 7iO7A7FzTJyak02w4epFDmKZ+WVFGSCmCytAWpXwChkjWvmdyTYbBytl+4FDOT80KT
 56iMxadmiAqr75/8MWEca3fW0NkZHgjRQbmG0IctwWKuXqEvNDy6aQQdXUt/trBCh2
 guOBY2+1eYyahSRAPFey7K96neYthIE2Wxc19FZSeHbaaCwb0OhFd0T5LD/lbBkAId
 1xF1ezz61HVSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/29] drm/msm/dp: introduce dp_mst_drm module
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-18-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-18-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:37:33 +0000
Message-Id: <20260831093734.1C7E21F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing teardown for DRM MST topology manager via drm_dp_mst_topol=
ogy_mgr_destroy(), leading to leaked internal resources (workqueues, mutexe=
s, payload arrays) and a Use-After-Free vulnerability.
--

commit 27699c490812d953e1c2e18da505fffee4442084
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: introduce dp_mst_drm module

This commit introduces the core MST manager data structures and the
initialization path for creating a DRM MST topology manager associated
with a DP controller. It also adds the registration hooks used to
initialize the MST manager during DP device setup.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
[ ... ]
> @@ -678,6 +678,16 @@ static int _dpu_kms_initialize_displayport(struct dr=
m_device *dev,
>  			DPU_ERROR("modeset_init failed for DP, rc =3D %d\n", rc);
>  			return rc;
>  		}
> +
> +		stream_cnt =3D msm_dp_get_mst_max_stream(priv->kms->dp[i]);
> +
> +		if (stream_cnt > 1) {
> +			rc =3D msm_dp_mst_register(priv->kms->dp[i]);
> +			if (rc) {
> +				DPU_ERROR("dp_mst_init failed for DP, rc =3D %d\n", rc);
> +				return rc;

[Severity: High]
If `msm_dp_mst_register()` fails on a subsequent DP port after successfully
registering a prior one in this loop, does returning early here leak the
successfully initialized MST managers from the previous iterations?

> +			}
> +		}
>  	}
> =20
>  	return 0;

[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
[ ... ]
> @@ -0,0 +1,54 @@
[ ... ]
> +int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, stru=
ct drm_dp_aux *drm_aux)
> +{
> +	struct drm_device *dev =3D dp_display->drm_dev;
> +	struct msm_dp_mst *mst;
> +	int ret;
> +
> +	mst =3D devm_kzalloc(dev->dev, sizeof(*mst), GFP_KERNEL);
> +	if (!mst)
> +		return -ENOMEM;
> +
> +	mst->msm_dp =3D dp_display;
> +	mst->max_streams =3D max_streams;
> +	mst->dp_aux =3D drm_aux;
> +
> +	ret =3D drm_dp_mst_topology_mgr_init(&mst->mst_mgr, dev,
> +					   drm_aux,
> +					   16,
> +					   max_streams,
> +					   dp_display->connector->base.id);

[Severity: High]
Does this leak the MST topology manager resources?

`drm_dp_mst_topology_mgr_init()` creates non-devres-managed resources like
workqueues (`delayed_destroy_wq`) and background worker threads. Since `mst`
is allocated with `devm_kzalloc()`, it will be freed automatically upon
device unbind or probe failure.

Without a paired teardown action (e.g. via `devm_add_action_or_reset()`
calling `drm_dp_mst_topology_mgr_destroy()`), won't the active workqueues
and threads be left running?

Can this lead to a Use-After-Free when those background threads later
dereference the freed `mst` memory?

> +	if (ret) {
> +		drm_err(dev, "[MST] topology manager init failed\n");
> +		return ret;
> +	}
> +
> +	dp_display->msm_dp_mst =3D mst;
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D18
