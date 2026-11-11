Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F9606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S1djNy02;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T2M1q3vT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8CAC10FC9E;
	Wed, 11 Nov 2026 17:09:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0FB10FC75
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:09:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF04xB3597129
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tVcctW/oKDuxTt7DrKIQJLMM
 mlpeEMy6Mr9dwtxp8WY=; b=S1djNy02soVsnM6zgLcxLwbTC4mKwOQot0aMq5SJ
 svQ58fBgLts9WD/bnLtpmQBZaz+5SN+YHJVUWm5vGbCtlDNA2lEN0awRmnJfT/Ek
 qmaqwyfT2sbuGxL+alvXmY73mfehcdLC7CclqIBeqnZ2U81QKb7bjrEnqfjAGBRp
 7nDfGjbUAQ9a6QpHSrNryZ0wUnmzOT6/ivbJc7Is/qesQ6AUTgU8afQFHSmZZXtQ
 ueu4z4Rz2aHdnEPHY/roYhHbNiOz1wiHrkVJUulvtamN5Z4IHM42eBBNh0QcRc42
 Y5e8zvnbJsZRBdwYGODw9uVDY7BhdxAjucBsntxv+AiDnQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u8qs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:09:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ece7f075c4so1015995e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794416950; x=1795021750;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tVcctW/oKDuxTt7DrKIQJLMMmlpeEMy6Mr9dwtxp8WY=;
 b=T2M1q3vTQWJQ444ObYcrZkPYo8/jttFJkjyjQVD0gbepvZT+wIWHPvoyFu0IMJ83C0
 vdReH3ZEIgO8jHxQzS0mIGoCCJTLHKQ0wc69+uVI4w7OLe5WjZKipCMYzGkA0ZItGy8X
 +9sQtghW0ohPWngshehbuzm4FlnIMpxArKu4vE7f1XcDzeCZvcPP5msFAMBlvbPCuUYH
 1uYUJCcViKnZUAyC0HmyHylDCUuChVNDqxHEZTZTzFhTgDgtr/Q/Z6HWfZHrK8mxbyh+
 R+1Hm7W0DOTotIRKdPMOJeeRBWBnflsqTptksU/7akuLc/dL9muKnHb32YJ6Vh5y7sDs
 dUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416950; x=1795021750;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tVcctW/oKDuxTt7DrKIQJLMMmlpeEMy6Mr9dwtxp8WY=;
 b=cho/u39UoQzVgnOcQGlOtDwREfA7+Hkv8dKkiwMeB6kbATmVOw2UC1By+aTaQ0/m9g
 z043yePfO1G9/9/xplloE4H8OK8BYd6iWe7sCdNstE15kOQjRcNil64QXKPIYiGJYaQO
 sml44140GxGciNJW20ebXpTY03VThCnHqFT8lsEluK+XMNtBaImvagWLFONhMnkhpowI
 Ps0EDurz36ISiY5jv01WW/7ImxmbTr/G8+Zzty7wecdMvRVlmEyWwjzeDCFb26TkXKQ1
 qNOLHjnxHnnuW3vsYODUwe09z5usnfhPyFVK21Xg9YArkkTHyD1vTu067SiakT13NtXy
 ZP8g==
X-Forwarded-Encrypted: i=1;
 AL+hErF/elox9awPkIhJsXa0dH5Y+mbWOzfVYfcr0sUk/p3PvvifvT0hqFNZ5r9KpwC9FZm6lFrzUtEdr0k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MnLz6UQpn3OP9pob2zAm9qvGklSQfywQupgV0eKQ/5AEY7d7J
 tu+UvKELCB0fLnpMGnFr4sY2BirmaqKoHKB+kzbxqrCSWWDYZ+rfi1bhOKulPZQP/uojGvgvIqY
 +1XDNTDMfwAmpg2tQvV3SG1LPOpy1kHWb4KwMy/PaMqaGiKp91/5Dtn9JuC5k4k6EwzWuALI=
X-Gm-Gg: AYBFou1p0yg6FftYlH7x1+bgWvAylF1faKg7hYW9hqjsV+jNWlCYbBuOOqCU+ndjeNI
 JxyKTiTrAKecOA3Gm/dWeyqPqo0ZyNtrGNTcDArf2Po7oudNnhxHMmi7g85ksunhgbJUW+HCx7w
 deKMPTAMkyUpvroUHifhCdadnStLycnBiat9osS7CJSmvSc2UTCf92CJI4MqStmkgrLv9PdQ+ZI
 hY0Eh7hXBsTmPeGubIKf7b/jWFBQwBAHcCceO1j4jMGBFj9D4k+gIen+2+Ozuv3qXsVEZ6eit4E
 0geFXNxC9+YkZJ6dTPwcsRyAoX4r3ixhus/Nat4upSsuTc/Z0UcDEYURKbOZBP8RzK+YVhlpHUs
 uU43kORbMnB5AvW7ZdFLOd88i9uXovBygcHB5R2O1/YQ19NtBwS2SQVnOXypXz8vxQo27KAejCt
 aith4uOuqGp3vlekNGKknqQHyUeTE9W3VJAGa5RDs+yQTce/xV/Tt19VBaCLsIeA==
X-Received: by 2002:a05:6122:4b16:b0:5ea:b9b5:8c43 with SMTP id
 71dfb90a1353d-5ee1c480a5emr1354765e0c.18.1794416950237; 
 Wed, 11 Nov 2026 09:09:10 -0800 (PST)
X-Received: by 2002:a05:6122:4b16:b0:5ea:b9b5:8c43 with SMTP id
 71dfb90a1353d-5ee1c480a5emr1354753e0c.18.1794416949763; 
 Wed, 11 Nov 2026 09:09:09 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157b7a0dcsm1105809e87.5.2026.11.11.09.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:09:08 -0800 (PST)
Date: Wed, 11 Nov 2026 19:09:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi/phy: program PLL_SYSTEM_MUXES on the first
 PHY enable
Message-ID: <e4ul4zxjta4oyo5fpjjzwkykb4gicztcn7yrgjw7aer6bqowkw@6nx2arhvmyca>
References: <20261019130041.305805-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019130041.305805-1-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX9XyfmkxeQYZY
 7v4CZasxRrzao9cmJqrB1L9urgakFDjaTPEP15mC1OGwZnCOxI3Rm9hgJCILFrcRFPh1hqklcUn
 Je7Uxc4WlS7px11tchrE4yxtO/pQFDs=
X-Proofpoint-GUID: J9rDTrp_bNVJ7BARqXwzAuOGrB6AS4wu
X-Proofpoint-ORIG-GUID: J9rDTrp_bNVJ7BARqXwzAuOGrB6AS4wu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2OCBTYWx0ZWRfX5wvLdX5FM0Qt
 9RdNDILolx7yAvbgignsLfOt8jpAbiA09gdHfNxqCMsOeeJU9uGi4/E+41E36FZoWrdd8R3DD3V
 AMTnBvrahem5mZQm+4j1B2sW5XEDBcgG3laHn9kQzX41OOZJC4z/iKSleHcVxr65wRFAPR8YevB
 aCVOgVwQdbtaAGIOlNbIIjRZ5YdjqgVXYSAJ9Enz5Vy1T8m4VUIgoxa70N9UPbV9HyNPLLWYLaY
 eEW1YYUWbNR2Bktfpcj6+Mns7mqpPcK+DwvpBEuDhEu7uVz3MmTkx7NLrhojm8IMBRoL2RI+FaK
 HBl7AfWejNa8M0glZSpSkDHp+6/BPrejDssKGHtJwyCwAip5oX31w4ETrJei0FTCuQNW2Pzqt+8
 NpNVwLH6D4yWuuey5k5t7ZG7Yz5HpDX4VwN2vPj3UeUcRUQo0Ciqh9641Y0yFTrFWEbmO9Cmji2
 MedQSgS1gzjS0eq3kjA==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af4a137 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=InjWm6lT3iDBAsjdKxMA:9
 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110068
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

On Mon, Oct 19, 2026 at 09:00:41PM +0800, Qianhui Xu wrote:
> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> 
> dsi_7nm_phy_enable() pre-seeds pll_enable_cnt = 1 before calling
> dsi_pll_enable_pll_bias().  That makes the bias helper take its
> early-return path, so its PLL_SYSTEM_MUXES = 0xc0 write is skipped on the
> first (bonded) bring-up and the register is left at 0x0.  Panels wired
> for bonded DSI then come up with a blank display.
> 
> Write PLL_SYSTEM_MUXES in dsi_7nm_phy_enable() as well.  The write in
> dsi_pll_enable_pll_bias() is kept for the warm re-enable path where
> pll_enable_cnt is 0.
> 
> Fixes: 44784327815b ("drm/msm/dsi: phy: rework PLL bias enable/disable")
> Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> index 1fc3b4f0c..5dd4830a1 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -1144,6 +1144,15 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
>  	data = DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
>  	       DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
>  	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
> +	/*
> +	 * Program the PLL output muxes here as well.  The pll_enable_cnt
> +	 * pre-seed above makes dsi_pll_enable_pll_bias() take its early-return
> +	 * path, so on the first (bonded) bring-up PLL_SYSTEM_MUXES would
> +	 * otherwise never be written and the panel would stay dark.  The bias
> +	 * function keeps its own write for the warm re-enable path
> +	 * (pll_enable_cnt == 0).
> +	 */

This belongs to the commit message rather than the code.

> +	writel(0xc0, pll->phy->pll_base + REG_DSI_7nm_PHY_PLL_SYSTEM_MUXES);
>  	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
>  
>  	/* Assert PLL core reset */
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
