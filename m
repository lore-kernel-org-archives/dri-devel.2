Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B648CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BDB10EC9B;
	Tue, 29 Sep 2026 04:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NMSbiZPr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFAB10EC9B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:48:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A87BD43F12;
 Tue, 29 Sep 2026 04:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625251F000FF;
 Tue, 29 Sep 2026 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657333;
 bh=5egSnMOHtuzAbiDl0e53O3z5lobefFB0CGYohLAX+io=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NMSbiZPrkwb3Zacl+Td7yxRAfL1os8KQsJyRhPJRprLrLODBiALjNZLRraVyC3lx/
 R4NRI5S6iEVq3QXnrtIdNKXkIZXP+xztWgpCc+AoZsGay82wlb7YODM7+6qb5v+/Lv
 Op0g/dZZ1pEXIlV1ffl5USKDM1F3KpU4/Cs4ZvkGmywnpZ/ToxP4w1VEwm+uvwRHOn
 lzm51LR+nPe0IG8vOvCdmDdP0cEuiZqyPShivP0LZq0EaFztXHqiEh2zqFxFvW749r
 kUcSZybXjsfipe6UNBc1cF/ND82gzYkgH59BJD7ivHN1bOirHXsNCSURvgV6HP2bDv
 oXkge/Zd3x6GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/35] drm/msm/dp: introduce dp_mst_drm module
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-18-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-18-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:48:52 +0000
Message-Id: <20260929044853.625251F000FF@smtp.kernel.org>
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
- [High] drm/msm/dpu: NULL pointer dereference in dpu_kms_destroy() during =
error paths
--

commit a4f8ebdb83ba4326d66366d808a6aed47be384e3
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: introduce dp_mst_drm module

This commit adds the dp_mst_drm module and the core MST manager data
structures. It introduces the MST manager object, per-stream encoder state,
and the registration hooks used to initialize and destroy the MST manager
during DP device setup.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index da3556eb6ecc2..7ee4e7e4d34a3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
[ ... ]
> @@ -905,6 +915,8 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_k=
ms)
>  static void dpu_kms_destroy(struct msm_kms *kms)
>  {
>  	struct dpu_kms *dpu_kms;
> +	struct msm_drm_private *priv;
> +	int i;
> =20
>  	if (!kms) {
>  		DPU_ERROR("invalid kms\n");
> @@ -912,6 +924,11 @@ static void dpu_kms_destroy(struct msm_kms *kms)
>  	}
> =20
>  	dpu_kms =3D to_dpu_kms(kms);
> +	priv =3D dpu_kms->dev->dev_private;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(priv->kms->dp); i++)

[Severity: High]
Does this cause a NULL pointer dereference if initialization fails early?

If msm_kms_init() fails (e.g., if alloc_ordered_workqueue() fails and
returns -ENOMEM), it populates kms->funcs before failure. The failure
propagates up to msm_drm_init(), which then triggers the err_msm_uninit err=
or
path calling msm_drm_kms_uninit().

Because kms->funcs is set, kms->funcs->destroy() (which maps to
dpu_kms_destroy()) is executed. However, dpu_kms->dev is only assigned
after a successful msm_kms_init(), so it remains NULL.

Unconditionally dereferencing dpu_kms->dev to access dev_private here appea=
rs
to cause a kernel panic on driver probe error paths.

> +		if (priv->kms->dp[i])
> +			msm_dp_mst_unregister(priv->kms->dp[i]);
> =20
>  	_dpu_kms_hw_destroy(dpu_kms);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D18
