Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF53606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHWHs1Qb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F7E10EDB5;
	Tue, 10 Nov 2026 05:21:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFE310EB86
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB9B5450D4;
 Tue, 10 Nov 2026 05:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE3C1F0089F;
 Tue, 10 Nov 2026 05:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288081;
 bh=5Q0aV0oSq5gkKvkwCPVUph/xGekW848HB+67UwIjJxg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SHWHs1Qb0cCmaquSraovsInVMLuFywcyxbGgasK2yOCZyvJRUECvtIy8nFeeHllTw
 J00BbhA+YhjA2zS8KeIgbyMHRK7qkOEL32B9cDoqzR4OYjLjkheMovsTIYG4VMpJG2
 WCgiTr/8aUzhvg8/H1uWkxrLjSjHN/JshGl+eg8MV0NsPql6Dvy2UzxacpDImRm0DN
 u9pp/zFezmst1ecj5xRMhSl2OINdqddS7IYQPpuoFjJ9IqIRDiM+lX9sU5Gttau1RH
 +ph+WbcJpgHaM5DxuXjvTVHu5HZcDQYRgwVBsLvPkK6TcjC1sK3R3DQ56/3SwLQkt0
 EarHOB7oMmyfg==
Message-ID: <sashiko-outbox-206277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/29] drm/msm/dp: add support for MST channel slot
 allocation
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-7-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-7-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:21:21 +0000
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
- [Low] drm/msm/dp: unused DP_MAX_TIME_SLOTS macro in
  msm_dp_ctrl_mst_calculate_rg()
--

commit 0628c2c6f6b7a217c52d585875dabea16424021f
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support for MST channel slot allocation

This commit adds DP controller support for programming per-stream MST
timeslot allocations and calculating the rate governor parameters.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 8a2396aec6d5e..0b34db3bd5d22 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -83,6 +83,7 @@
>  #define MR_LINK_PRBS7 0x100
>  #define MR_LINK_CUSTOM80 0x200
>  #define MR_LINK_TRAINING4  0x40
> +#define DP_MAX_TIME_SLOTS 64

[ ... ]

> +static void msm_dp_ctrl_mst_calculate_rg(struct msm_dp_ctrl_private *ctr=
l,
> +					 struct msm_dp_panel *panel,
> +					 const struct msm_dp_mst_slot_info *slots,
> +					 u32 *p_x_int, u32 *p_y_frac_enum)
> +{
> +	u64 min_slot_cnt, max_slot_cnt;
> +	u64 raw_target_sc, target_sc_fixp, scale_fixp;
> +	u64 pclk =3D panel->msm_dp_mode.drm_mode.clock;
> +	u64 lclk =3D 0;
> +	u64 lanes =3D ctrl->link->link_params.num_lanes;
> +	u64 bpp =3D panel->msm_dp_mode.bpp;
> +	u64 pbn =3D slots[panel->stream_id].pbn;
> +	u64 numerator, denominator, temp, temp1, scaled_target_sc;
> +	u32 x_int =3D 0, y_frac_enum =3D 0;
> +	u64 target_strm_sym, y_frac_enum_fixp;
> +
> +	lclk =3D ctrl->link->link_params.rate;
> +
> +	/* min_slot_cnt */
> +	numerator =3D pclk * bpp * 64 * 1000;

[Severity: Low]
This isn't a bug, but DP_MAX_TIME_SLOTS is defined above and never used;
should this calculation use DP_MAX_TIME_SLOTS instead of 64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D7
