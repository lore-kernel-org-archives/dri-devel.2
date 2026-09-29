Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE58CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF7310EF82;
	Tue, 29 Sep 2026 16:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OlyTRCL4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YTh5ZFjh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED7410EF82
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:03:35 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqe9G1016876
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EoSYHQeRQORq80QIQ9nw9GOz
 XyX4Kx5dEh//Fq2RPgs=; b=OlyTRCL49XlblzOllkE8PoSeXe3jS5SpBnpdlZRJ
 XwGGO8WSo+LXfr9Xuzscs77MI1y47R5zUpqFKshC90aMZVTSzi3GgVHk3HD1lC5A
 ZF05nuXV5nuNRMTdAqoEeFMXUCFUtq9x9o8MVCwefXpasBUtQ6L3MIjmYJ7zEPWC
 +AXPD/3Ry03CYE5aEC+DhpTl31qqoG45H/+SkkTPIpcIyX9FJC9jgjJQUq4I3EPV
 DxruumVOT9NALxy9CzSJDIdvSezc3uBjIcRD/nYWd1kITGab7Gg/jb4K+6xG578N
 cBjiOY1Bg8OiPbrgK8p/94yj8PKWbxqOd8depKggfoqufA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxjybp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:03:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7b335cdddaeso1021773137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790697814; x=1791302614;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EoSYHQeRQORq80QIQ9nw9GOzXyX4Kx5dEh//Fq2RPgs=;
 b=YTh5ZFjhtA3UbtzO5NXiMG64DWUSgH/xZCrxuMvhQofGwv1CGIV8S8M9QD+KqxkcnV
 cpsD8gljXHGWXscLuygA/cQWfS3WYL/9eVh/WHQX2cJ7KoPR+Hs60eW+92N6lEeBneKU
 3N/nXe2X2sObIgJxa/F6uZCv8M/zRs4SL0vnxIpOL1WzyK62JSRFOXZL8LMBBj9Vb82y
 c2Ae2kxTJs3Enkxy0NqKX29y0Zh0FFN/kFSv5C3MQSzjws9rVEQ3ldnLMLswKXTJQn1C
 EGezMfcvu3e8Rwjq18KRQwROg+aGqESSTckviJ6poo87jKNseDS/qPNuWz6KGe+0r1Hl
 e6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697814; x=1791302614;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EoSYHQeRQORq80QIQ9nw9GOzXyX4Kx5dEh//Fq2RPgs=;
 b=mGyAhDqgAU8NSCkkWFgOyrrCf45bCqUNh8wbtjqHq1UoTzUTXQa632sqTW5Pq24JWy
 mEB6gOJm2hWENljHyVkYINgfqBGnQnBPX5EE4VOY/0steHVfZr+KjVg2f3ul4x58aCym
 0e24k6bIJHxSbI6jPv27w8/vAZFuEzeIfZWWX20GbS0LgfTl+CziaGA/YF6tgc7wRJM4
 bhMp8rz1QCKoe09X9A/1cADJhf9hxsozhjZLljFWQLAZ8w/n59v2XZy9lhvHnkNzyd1+
 e6UKrB+1XgW195SMJm0wJcV63ETb8VW08cCU2xCnS6RGqlqwHY32lfbnUWs944ynm2pH
 c/9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqe5VI2Xp1zjJYYuMKHd5hz3brhlpu7fZrFPFV+13Veiy5wVyWZH3ImyX59+p3hQosTChOow3XIN4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuUHYzEZPys2cbApA/D8fmp/YVAB9WdD9JQUXfrXCEsFPsjoue
 sHnWrDbP5b+krb2Z4mCrj6UCKfnX+btjUx8jmfJmXvBvrIbnbEiDB2ll6iHzn2FqqsRZG3Mo3WO
 tM3JGfLJoK0cTrmqTDz5C+9FtjghilPUALwLn5n3H1uWNNdDkFqBa13HZ3vulFeYQ3gcNsiU=
X-Gm-Gg: AYBFou05hV03lU0DEMOoboL/cTUT/LeGMyHEuBPesWHOkw6dMVtWGRrDjI8r5SUwoyY
 azJ7YYGn8jRRVR0adDJd4lynGOIrdrX4vAAneN0IJsUivU5gLlzUFsMbo+7LjvvhS0N18f5rcrB
 FATRe1oomL8eqzNxIKTYasYA9HIdXr3ixTR5xtPlD7IXVRcorD4mrbI9xgc8QbyPgg4gZTgqjhS
 +nZt+fPcKB32OKmpIwOqqkyXXlcwkBHtipOrXhinEBpVR04wEOq2JiUQXMV7Zkzt0X8hBi644S5
 aaoPTVXKY11ZGAW4IEbn9Z22h9QzU2iDbbcuP+i9IfgX8o6RsBaMH3CZTleUZqL9DKeH0uJxHAj
 lYxL7mOOzfuvVyh5RZ4r4TzHJbfevNQIbMt2N2W9+TX8qfbuQFd6gAFnjGa+M+1Y57PMf77bsLr
 yw00OOxcEH2HuL
X-Received: by 2002:a05:6102:2143:b0:7b4:9eba:69dd with SMTP id
 ada2fe7eead31-7b9514bea49mr650607137.45.1790697812179; 
 Tue, 29 Sep 2026 09:03:32 -0700 (PDT)
X-Received: by 2002:a05:6102:2143:b0:7b4:9eba:69dd with SMTP id
 ada2fe7eead31-7b9514bea49mr650575137.45.1790697811357; 
 Tue, 29 Sep 2026 09:03:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3b30dd50sm31720e87.5.2026.09.29.09.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:03:29 -0700 (PDT)
Date: Tue, 29 Sep 2026 19:03:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v5 2/6] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
Message-ID: <5r6xd4iiwnv2v5ji7xeddihlqstmtajvw5ixmntlwxxmcvo7y6@zueqflvz3lr5>
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-2-c042266b9eeb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-sm8650-7-1-bonded-dsi-v5-2-c042266b9eeb@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MyBTYWx0ZWRfX2ut23FpN9iN7
 19YdZwSaXwooolghoBDrD/BnGV/i2sl2pVRdqWJhTLuyt/AcF7TkZa9Lc3mtszrfljjqEWTnJUD
 Kai4xH5qnE7F2rd4QKsmmMMFlMAFZ6E=
X-Proofpoint-GUID: vgp5VIkjHC7RAiHlbB2Ms-pyqTyTg3xi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MyBTYWx0ZWRfX5z2RA4IizZnT
 fwnZ7MbZFio528NvEo1+d7t5DEbjr29BiYP+sJlnNHkNEfr8Px5uYChzoqryonno9jA/d8cU4gF
 TiaRN2MAcYz9GLdAsfN8z7AfnOOqKEcQQpWakXtRU1uZsVYnaGy6Rtlvb14/l11BQY9pgGGFnfl
 BgsnZFn1yRGHMkPEPSIXLLfscD4z++PpPq5B5iRhBRZhj/BGwCgeq0JY2UF61BOemvNNVtMpbzE
 3S5qwCGx33V29/xMP5eMleWLIyhDgvUU+yfMpqgGVI5yZ6k1KL44s9oGWsLjlMDgbbe/tcvadz3
 /P3nPUTca/Ro7FF7dZKFLFsPwrJ6COHKN+zMXqMJfDUg+h9gPm+/qZ69H72Y1YJUGxxGR936i91
 KoHoLlGqCNHNzpSRNQFuirMIZLOLaPRVHXwPh1nj2hKTeXXWwABfrW2rdAjQ8YboJCRs8PO7vFH
 Z/a09AMi0pLS+PAWy3g==
X-Proofpoint-ORIG-GUID: vgp5VIkjHC7RAiHlbB2Ms-pyqTyTg3xi
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbe156 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=RAbU-raeAAAA:8
 a=KKAkSRfTAAAA:8 a=732f6QRgeebKLVb_Er0A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=JiizpSU_mAIq9zsZDqn2:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290063
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Jul 27, 2026 at 04:08:41PM +0800, Jun Nie wrote:
> Some panels require multiple slice to be sent in a single DSC packet. And
> this feature is a must for specific panels, such as Sharp ls026b3sa06. Add
> a dsc_slice_per_pkt member into struct drm_dsc_config and support the
> feature in msm mdss driver.
> 
> Co-developed-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 27 ++++++++++++---------------
>  include/drm/display/drm_dsc.h      |  7 +++++++
>  2 files changed, 19 insertions(+), 15 deletions(-)
> 
> @@ -1719,8 +1709,14 @@ static int dsi_host_attach(struct mipi_dsi_host *host,
>  	msm_host->lanes = dsi->lanes;
>  	msm_host->format = dsi->format;
>  	msm_host->mode_flags = dsi->mode_flags;
> -	if (dsi->dsc)
> +	if (dsi->dsc) {
>  		msm_host->dsc = dsi->dsc;
> +		/* for backwards compatibility, assume 1 if not set */
> +		msm_host->dsc_slice_per_pkt = dsi->dsc->dsc_slice_per_pkt ?: 1;
> +	} else {
> +		msm_host->dsc = NULL;
> +		msm_host->dsc_slice_per_pkt = 0;
> +	}

Why do you need the else branch? Isn't it already NULL / 0 by default?

>  
>  	if (msm_host->format == MIPI_DSI_FMT_RGB101010) {
>  		if (!msm_dsi_host_version_geq(msm_host, MSM_DSI_VER_MAJOR_6G,
> @@ -1757,6 +1753,7 @@ static int dsi_host_detach(struct mipi_dsi_host *host,
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  
>  	dsi_dev_detach(msm_host->pdev);
> +	msm_host->dsc = NULL;

If you are fixing something, it should come as a separate commit.

>  
>  	DBG("id=%d", msm_host->id);
>  
> diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_dsc.h
> index bbbe7438473d3..c522ab3d71853 100644
> --- a/include/drm/display/drm_dsc.h
> +++ b/include/drm/display/drm_dsc.h
> @@ -267,6 +267,13 @@ struct drm_dsc_config {
>  	 * Offset adjustment for second line in Native 4:2:0 mode
>  	 */
>  	u16 second_line_offset_adj;
> +
> +	/**
> +	 * @dsc_slice_per_pkt:
> +	 * Number of DSC slices to be sent in a single packet. This is not
> +	 * part of DSC standard, and only used in some DSI panels so far.
> +	 */
> +	unsigned int dsc_slice_per_pkt;

If it's not a part of the standard, I think, it should not be a part of
drm_dsc_config. In the end, drm_dsc_config is also being used by other
parties, e.g. DP or HDMI. A year ago I saw a version of this patch,
having this field in the struct mipi_dsi_device. I think it's a more
correct place.

-- 
With best wishes
Dmitry
