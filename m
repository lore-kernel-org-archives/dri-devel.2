Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A44606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NIIzl0sG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RNMZn5yt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A12A10E05A;
	Sat, 31 Oct 2026 20:27:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC7110E05A
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:27:20 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJFxTx2000772
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=U5YmrFJ9xFF8sJ7me68N1z1N
 hFM5GxKEjaWMihJs3s8=; b=NIIzl0sGSoeqHRvyEzKaGiGSnfBuMhyy48qA5DvE
 FplqLBB6x5XJu+B1+L7nf5shPuAWoT+BpaARqQeqZ/69clzof8BdvDpll9OscVdj
 qz4JSNXcYjUaChxpju62SeHroIxim4zAqoySWCTeT2Cp6Ul4R9d0JAdHiSHikD/b
 CM/pWKpS+keNlsKu9WIkLTHb1nr242axLtGmt4GPB7HqVSoWnscysGDsSrCVUcfd
 JQfjmi76sbygprrMeCQreWmXlJo4OoVQjrGgzj2BpBQ3LVrgfq459DWJEvhvCFqI
 JhzsGzH2+qGgmVVkccXePEKxgqbIi0kwbUOeTMuIqOAvqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m99t9q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:27:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f568dee56so322396585a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793478439; x=1794083239;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U5YmrFJ9xFF8sJ7me68N1z1NhFM5GxKEjaWMihJs3s8=;
 b=RNMZn5ytOrJkIBDgIowxrB/g0cNhfqBI/h9RE5ksj7hKWk9HgLRIPoQ+7Yx94fmqzC
 xs3s7XKT7y0+G3lJmN4CigyEJVax8kjP+dlsei3PwHB1s0/0Aee644DlVGZIOltb2wxs
 VNWGjJVVhT1lcYPPfXkmhTo7qAzro80fCSEJjVgxuEiBUhULs0rrxotUiIPzAXwV0WQz
 AjnpnFQSMPgtn/Y1CdAt/Bnba+vMaO0Iu/rOSvkQLIB4otWuj7B1pb5NaV9KwIOSrg20
 HUi49M/W6gePbMcu0C/7Fm73e7x50PCCtHGCkjp+Qkqf1Yv1K1IdUWFwWoe5gGYCGuf3
 bJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793478439; x=1794083239;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U5YmrFJ9xFF8sJ7me68N1z1NhFM5GxKEjaWMihJs3s8=;
 b=vQlpwFyPAQTajIt8dpOHSeOWlvdJmjszqhqeXP7LwTsRnzONYJYlO6nJ+oUXUuOoM8
 TEsKBOwRHAgGWLrmqLWipaAKssR79WstbbBJ4Op3XWPGmlVO0vdQdihUsKdURiXZBi7J
 kN6kDKSXHHQLWOu0At4HtH9+DiIoUxlhVYiU6yWxgtTJ7muTHng/+zEfYdEKnrHioosc
 J8G8XaMspKKih+YdLJjC7wcXvNG34A24VURdG+kA5ToymP9XpKv94RyDdzQRUsKcj6u1
 7cNCgglk7E5rj3GMMX+QuG68a+YrsBWidCINIjgDicSR4It8bsEx9LYuOG2ntX5DQqp3
 rJAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDH8s0wASeRByYX43dhEgmkJddPL6Maej0NlCpdurzNGw7yt37NhwKOdrrCIZ6PHa8qpFKIwHajDU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK1qxYEV3OGF8Tyuzj4IBDiMFGper8RH08tEvqtPrtkr6gcA7KO
 NYWTzTwh8xqqacQIld7hZo0yveJ57DjEJDC73/pO+1z4unxMbK0pa6k7rl1EjbBTZJQYM8RPjYR
 8QHnWD+szDIgSYIJCSetfk7Ftb3D1xJaaCe7iEEElMcznUWSFWFZmYvp6Aoc1bRnCq0oN4zfUui
 3S6ZU=
X-Gm-Gg: AYBFou2elwI1oNxHJhG7KAcWn2RqrgvS7zEfjk4qhKL052l6bI2KaaWp2oegeWLkb22
 3MCj7cCXmQ3oGbDB8gHg+X0Pb7PW+38yUgjID1Ags1WotQvZg75swyHoJvnc/zTVgXo3W1znjGY
 C4ByOEeDuNqDRNcVVX/BBiew2eWjJEKnO0e23dMwaGONUsimJGOOKkHXsLUQU9wxjSATi/48Ubj
 JwFKeA/VrOGy4MpdkEfvFLI5bK6hh+BE7owWvgDuW76iEPAGqBZqm1wR1CMU5NOJ+ZXY3nCfKAx
 H5kIRw9BhVzCnAZ0zcA8wRgIeIYOcbjo6Ba6CTp0MXJgdB1yd49BKpWNgXjyoajrQFoqVWtzJBU
 kEAXnCQxNeXoxZf1M7JU7D7kElyJeBI10bezOACypVOuuIylPeMgnAhveN+yLAeRRwwQU9hakTc
 oCRCVErFR/pu+e4aCH1AFhjBy556oZY5k3EJwEgwe4AIdi5D0NN8pagJO/bgEZ0A==
X-Received: by 2002:a05:620a:28c5:b0:936:ab1f:6aa4 with SMTP id
 af79cd13be357-944214dce98mr1001815985a.1.1793478439344; 
 Sat, 31 Oct 2026 13:27:19 -0700 (PDT)
X-Received: by 2002:a05:620a:28c5:b0:936:ab1f:6aa4 with SMTP id
 af79cd13be357-944214dce98mr1001813485a.1.1793478438875; 
 Sat, 31 Oct 2026 13:27:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe072d19csm750618e87.40.2026.10.31.13.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:27:16 -0700 (PDT)
Date: Sat, 31 Oct 2026 22:27:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/msm/dsi: add per-SoC bonded command-path config
Message-ID: <pql25o7nhpmdbwkprsu5b3xurusxmnht3p3xb3425ubdkxnzdy@wguqdarh7h2a>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261031150305.1107572-3-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031150305.1107572-3-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-ORIG-GUID: 0ghCfsBQZYC0D1i8JT_xiej2rhX9C7V3
X-Proofpoint-GUID: 0ghCfsBQZYC0D1i8JT_xiej2rhX9C7V3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX3UiDWVz0iulv
 CScj15els+vWYKWt8uZMOAIqwlIxnKmCulizTG2w7VHJVxd5x1JrLdigNtp0LGgX+S9HFiRpu9l
 1XF4dTKFGMLD4u5vCg6QSwMoc6lGEZ3O0mowuP4lHCFGhQJIA6PxkE2PHbqKh+xVfGZNLNvD1hR
 ydlDhaWUf392I2nq/ERLpjxctuABzZVnynDelVS2pJfYabDdT9s0R2U+SmA3qC3HwPLlED800dl
 F6QIbr9e2weGAy+jI+Bs6vS9qg3GgUl3LhWFli4YKY7drObl66S6y7uJhGq/rHPrKiNdZWFmcP5
 sMZp7+iqovgdWYSAgxACG3bTwGSL2tmZpT6jBXUw2L7OJKmlCy0QYZPXRkm4cuOJVLYANE8H6LN
 2KHuUTCuo6e8GHVIwG8JXDiT9P54aJMKj21N0Dlk7/y5HcZ1svfUYSsKdw3I9WTA9iMwXKRa2T2
 PZWoSjsXqj+882Ohz6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfXxQEjWwOEq6UN
 O1En4NL5EZx6tfkmyb2/paiWq+XnYGPs95FtJRdZxwdPuB9wqQVKszqMQGzPkPHZE8Qb/CfNgl5
 1xELxe8JQj6chiSyFfmnu4WpwB/tfMs=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae64f28 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=luF8A-hlZe_ITdDpm1sA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310081
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 11:03:02PM +0800, Qianhui Xu wrote:
> The bonded command path carried its constants inline: the error-mask bits
> in dsi_cmd_error_prepare()/dsi_cmd_error_cleanup(), the CMD_DMA_CTRL bits
> staged before a broadcast and the peer poll budget. Those are controller
> facts, so they belong in the existing per-SoC table next to the regulator
> and bus-clock data rather than in the driver body.

Do they differ from platform to platform?

> 
> Add struct msm_dsi_bonded_cfg and hang it off struct msm_dsi_config.
> SM8750 reports DSI 6G v2.9, which selects the sm8650 cfg entry, so the
> bonded data is attached there with values copied verbatim from the
> current code. Use remains gated on the sm8750 compatible, so behaviour is
> unchanged.

What happens on the other platforms?

> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 26 ++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h  | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 22 +++++++++++++++-------
>  3 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index da3fe68244..640ebe8244 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include "dsi_cfg.h"
> +#include "dsi.xml.h"
>  
>  static const char * const dsi_v2_bus_clk_names[] = {
>  	"core_mmss", "iface", "bus",
> @@ -194,6 +195,24 @@ static const struct regulator_bulk_data sm8650_dsi_regulators[] = {
>  	{ .supply = "vdda", .init_load_uA = 16600 },	/* 1.2 V */
>  };
>  
> +/*
> + * Bonded command-path data. Values are copied verbatim from the vendor-derived
> + * in-tree code; the SM8750 compatible check in dsi_host.c/dsi_manager.c still
> + * gates every use until the master link moves into this table as well.
> + * TODO(doc): err_clear_bits/err_cleanup_bits touch bits that dsi.xml does not
> + * describe (see reports/b5-per-soc-cfg-design-20261027.md, RFC-SCOPE R1).
> + */
> +static const struct msm_dsi_bonded_cfg sm8750_dsi_bonded_cfg = {
> +	.master_link_id = DSI_0,
> +	.cmd_dma_ctrl = DSI_CMD_DMA_CTRL_BROADCAST_EN |
> +			DSI_CMD_DMA_CTRL_FROM_FRAME_BUFFER,
> +	.err_clear_bits = 0x001f0200,
> +	.err_cleanup_bits = 0x44440400,
> +	.poll_timeout_us = 5000,	/* 500 polls, 10 us apart */
> +	.needs_link_clk_bump = true,
> +	.needs_sw_reset = true,
> +};
> +
>  static const struct msm_dsi_config sm8650_dsi_cfg = {
>  	.io_offset = DSI_6G_REG_SHIFT,
>  	.regulator_data = sm8650_dsi_regulators,
> @@ -203,6 +222,13 @@ static const struct msm_dsi_config sm8650_dsi_cfg = {
>  	.io_start = {
>  		{ 0xae94000, 0xae96000 },
>  	},
> +	/*
> +	 * SM8750 reports DSI 6G v2.9, i.e. it selects this very table entry, so
> +	 * the bonded data has to hang off it. Its use is still gated on the
> +	 * "qcom,sm8750-dsi-ctrl" compatible, so an actual SM8650 keeps taking
> +	 * the regular command path.
> +	 */

Huh?

> +	.bonded = &sm8750_dsi_bonded_cfg,

If it's a sm8650 struct all the fields should be sm8650 too.

>  };
>  
>  static const struct msm_dsi_config kaanapali_dsi_cfg = {

-- 
With best wishes
Dmitry
