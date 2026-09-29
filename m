Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5F2CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20EC210E059;
	Tue, 29 Sep 2026 04:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0nLQ8/C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5258510E059
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:46:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2295A43600;
 Tue, 29 Sep 2026 04:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06BA1F000FF;
 Tue, 29 Sep 2026 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657207;
 bh=RJgJLirqbYNMzI0F60LpFf1YOmVnFIWb5n7CwtH0Vn4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M0nLQ8/CWTll8BNAMJBYhuNEyFOzDx65+MjYwhmKhwvfCl9X0iK62KSGT/OJYO2S4
 2QQDfkJKDy5SLuIs2uFQDUY9FyDaTxc0LimXU7TiqGi5Z4XRNhKJk2wqpuYl3vuSso
 X0GhyPcDeT7UASC457Mlh3Xk9JrNzVk0puwvzeTPnHCGbQgQEZQ1KrlsDfcA+xi+q4
 jb5hryPj8ILl01vKq8LKt5860OZG/cFUXLQdjLZyIRvwIWBMONeBVMIV1xa75+UncJ
 vy1f3PGTYQmN0XV1gVWTy0hb0CxD/9rWikDYlz/LgqNKrUckECDhJM0Y2Kdhsmhohh
 rO/nquKeenVwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/35] drm/msm/dpu: add per-stream MST encoders
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-22-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-22-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:46:46 +0000
Message-Id: <20260929044646.D06BA1F000FF@smtp.kernel.org>
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
- [High] mm: memory leak of msm_dp_panel during DRM master bind/unbind
--

commit cfe400464204530420fa599c1a7624cb1685cc3b
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dpu: add per-stream MST encoders

This commit establishes the per-stream encoder infrastructure required for
DP MST support. It creates one DRM encoder per MST stream, associates it
with a stream ID, and initializes it with MST-specific encoder helper
callbacks.

[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 169b34f985c0e..88687b97ed6e6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -145,6 +145,26 @@ static int msm_dp_mst_encoder_stream_id(struct msm_d=
p_mst *mst,
>  	return -1;
>  }
> =20
> +int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int st=
ream_id,
> +			      struct drm_encoder *encoder)
> +{
> +	struct msm_dp_mst *mst =3D dp_display->msm_dp_mst;
> +	struct msm_dp_panel *dp_panel;
> +
> +	dp_panel =3D msm_dp_display_get_panel(dp_display, stream_id);

[Severity: High]
Does this code leak the struct msm_dp_panel allocations on DRM master
bind/unbind cycles?

When KMS initialization executes during the DRM master bind sequence, it
calls msm_dp_mst_attach_encoder(). This in turn allocates a new panel for
each stream via the following chain:

msm_dp_mst_attach_encoder()
  msm_dp_display_get_panel()
    msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, ...)
      devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);

The devres allocation is anchored to the persistent subordinate DP platform
device rather than the ephemeral DRM master device. When the DRM master is
unbound, KMS is torn down but the DP platform device remains bound. On the
next DRM master bind cycle, new panels are allocated on the same DP
platform device, permanently leaking the previous allocations.

Can this lead to resource exhaustion if a user repeatedly unbinds and binds
the DRM master via sysfs?

> +	if (!dp_panel) {
> +		drm_err(dp_display->drm_dev,
> +			"[MST] failed to allocate panel for stream %d\n", stream_id);
> +		return -ENOMEM;
> +	}
> +
> +	mst->mst_encoders[stream_id].enc =3D encoder;
> +	mst->mst_encoders[stream_id].stream_id =3D stream_id;
> +	mst->mst_encoders[stream_id].dp_panel =3D dp_panel;
> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D22
