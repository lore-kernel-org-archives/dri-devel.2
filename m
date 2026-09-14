Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92559C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B883F10E141;
	Mon, 14 Sep 2026 00:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A13MD8t5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jDUGA1D6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E52510E65C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:03:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNYRRI3122717
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QCkweCa7F1/CfL9F/9LUYh2D
 moFaRAIGZJkNvknrjg8=; b=A13MD8t5ztJPFtfgVH/8KEWLJcSSvt+HA2SlvQbM
 AZK5ZLrulxyLHOFRHGSD1EKyQx5gDQn9MN984XcBQ9hSqkPCuIX4hdKHr2UzY3eC
 vbrwkfTcjmzqfwUnPcojt31V0O6roFyb/+erS4Yx8t0TVuZyglYeWxiPUUj/cxbJ
 ETH9p6bWWCqxYwGxlL3s/IleiDANgCQzD6FCCnuw+Frp7qqBfFuo55yssWA92iSC
 SW4k+Vi6DgqLKc+kKR0BbESfq4v0urXQjxpQhiUfVsPdkDNprzK6HAmNRAiKCxm2
 UTuqQQeUYqZjGODhiJDWf0PD3/D5Gy+XPpGaOeXJOhQCOg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d4cex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:03:31 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-982a948acf8so1241295241.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344211; x=1789949011;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QCkweCa7F1/CfL9F/9LUYh2DmoFaRAIGZJkNvknrjg8=;
 b=jDUGA1D6TkoW7nz11Eyx02jtHmuA9fLiC187MIadFjVY492CFtf64DPqffldDIvTSa
 XBNe2KghQa5bih2ss2gcZPnzHlWTpSzMjrcZj2yCSUIyMf00TKwZjxnQBNGs6OVfaG1I
 NO3QGPiArRRyMXyM1/29x253sD4jmBxZm9zq5MhhcvBd0QR3Ur805F0YqXl/nf1II5Qy
 OYbw1tkZn2PJOQLFT6uslhkzAvRLVoBMrW+v/bkTUv2ak6Fj2gfd05nGf4zabwyO3jND
 doybGin5IEMYGFptBZweZJzhNqtG5RQn2MLV0jZVHUHYjug9GwmQIr0xm6p8tsuDg99y
 NPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344211; x=1789949011;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QCkweCa7F1/CfL9F/9LUYh2DmoFaRAIGZJkNvknrjg8=;
 b=BWHgkX9f4m+GWsVdnLfkVxnCymcoP0VkT7iIpUqPB5gzJS+NZa+GGv0T8kib4vjtAw
 owbodlCnumzuWWeJDpLmcoEuA48GHFw9OCLtptOBO/9nB+7dvAgvy331CmsvvtCuOLDp
 1FF43ph4FoS4teuXtRJszOubcb6Jk2zCyLeK+ss1qtK79VvOvuK48RIY5lnGsPl0D6nr
 HbGVKar8IyGQ//59lpIt7EpUOLF60uujb10zJMifXOKuxJ50dSWDAzD/+WKZQoOwgVra
 fvZ7YDHklB2KyMF2iHB3BAgw0s22y5x9ZJqwje2FQzbVTCriu0FDzcdyxIQHNZQ0CCEa
 zTyw==
X-Forwarded-Encrypted: i=1;
 AKwUvByH8WFcXkOKaCEJT0Dr78a0mN7VfH7WFNo80bAQVCNnPIXf5QynruYZS9sRtyLaIE0+g9Wm9E1+xAQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k6LcaxhpGNx2U9Suki9Onz/CLdoCvJzuBo1Yyn+gSKDMXmcFhB
 QAq5jUbX3QgCq6vhOM3z2SnDE6/ze6byDNeN67KW3ku+nZCL70xugG24PjeXFyoZ+yr0cIo5mUX
 zZ24n2diJa//y0FfVT7w3Ea1FT+iah3hiW0xfxLAAoQGStbQtMgBYPOsHnRKnZODSO3afZUQ=
X-Gm-Gg: AYBFou1hGR9WS6z02eeU7x/vNzMOcj7N9Pe1/nf20cR92Mw9dDcv74tWqtKh8acKVCz
 Pud8K/aJL2wMI0Wd3M9Yt8XY1DNtndiX2ZDIl0ZAKcGaH2dOPnyV+NVLFmyg+1ECj1FD0Z42wS+
 sJkvD+/nbE3map578S+71XVTtpwK114Ob5GOZjfGZBFuvtByiBBlFI1Q+GY5bj0UwIYk8bEqMa1
 avBIJMSmJNPux+WGzWH5o0eYdpzhDdutLkmBHWSxDmDjR0E7SHqLZ3/vcQidsU5IMOqyRLWQxAv
 2NMLEbm3sYxn92OQw+Iv36jR6M+2kuUW0AolnhQhrGdVssg/mJERSBJ95O0/4kaVlmny82bpRnK
 c/7EH6klBYLkrS99nRxqx8bNcam9EUtxko1qhKF5V+GgSpaClHHpT5BWgwTKoOw2sMD6J9wcH92
 eHb1F5cpSLi86I
X-Received: by 2002:a05:6102:5093:b0:77b:28c1:210e with SMTP id
 ada2fe7eead31-79b579b2355mr81975137.1.1789344210741; 
 Sun, 13 Sep 2026 17:03:30 -0700 (PDT)
X-Received: by 2002:a05:6102:5093:b0:77b:28c1:210e with SMTP id
 ada2fe7eead31-79b579b2355mr81948137.1.1789344210374; 
 Sun, 13 Sep 2026 17:03:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a047aa12sm2040899e87.74.2026.09.13.17.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:03:28 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:03:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 09/17] phy: qcom: edp: Add Nord AUX channel and VCO
 divider configuration tables
Message-ID: <clxbpw3awcpispcixwrvwj7hocvoag6fhhp7d4azamxghk5x5o@ar3infqpcy56>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-9-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-9-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0NCBTYWx0ZWRfX4LVhMaqTgzm8
 NyZETQ065RhYlDaesvAnWDdr7EgOjkyzq6fTrJ9d2IDj0Kxo1ueoKF44Vy/LL8PcCOX7vxu+EqJ
 ZuJC3xbqJIIxWMIpf+f8D1jXpW46IxY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0NCBTYWx0ZWRfXw1VEPy4YMHit
 uJQ1+8pyPyXwrsbaQGOksEwXAZz/N5WTx7ukVA/s4EH5SPS4dd2t2eGnls9yPdAmqk7k72W0hW8
 VmGlKsDI8SvgTxkIVMxwOhLGvmkJxU973zp5XFJc5Fm2/IBdgrSgQmpBxejgptGKaHaeaflj+rD
 JMst4dk46i97Ve2MHGy0svXW4Nzi6YNMR1ubxUHoO3cQiz8e3SgsRJXYgFAzIe4TCUbt/bM+eND
 FtjImxqJVEKyH/5CIIinR39zDFYLH8IE+EPdRR7aVbTkujve064Kr3GFR6CmpOYW9qzIa1wtzGi
 g8uAKM/bhVblU9fBdMG0T99bUUKAkLazdlRNcN+Cp9rA879l2aO1XWGvnBRLeH7tHYep+sp+bHc
 nnZU/xXflvDUGuE8y+ub17LoJXMHUwagvBOzMBKpT+OyQdJPPKslTL2EMsEe/+ntGoegx/pBqFW
 EloZJ07MtigCeqHjZjg==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa739d3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=_h1llJ5GsiActe-pZHAA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: t5pa3tZPjw7Cp6Gg3Bo0NnIBHWkPSa16
X-Proofpoint-GUID: t5pa3tZPjw7Cp6Gg3Bo0NnIBHWkPSa16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130344
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

On Fri, Sep 11, 2026 at 09:06:40PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different AUX channel and VCO divider settings compared
> to existing SoCs.  Add edp_phy_aux_cfg_nord and edp_phy_vco_div_cfg_nord
> with values sourced from HPG Tables 2-1-a and 2-1-b respectively.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 373f13b3d6d5..ee0d7f1a90fe 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1508,6 +1508,25 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> +/*
> + * nord AUX config (eDP mode).
> + * From HPG Table 2-1-a: edp_phy_aux_bist.csv
> + * Index:  0     1     2     3     4     5     6     7     8     9    10    11    12

Drop useless comments.

> + */
> +static const u8 edp_phy_aux_cfg_nord[DP_AUX_CFG_SIZE] = {
> +	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x04,

So, it's the same as edp_phy_aux_cfg_v5, except for the last register?

> +};
> +
> +/*
> + * nord VCO_DIV config for eDP mode.
> + * From HPG Table 2-1-b AUX Clock Settings (eDP mode) - Nominal/Turbo column.
> + * Indices: [0]=1620, [1]=2700, [2]=5400, [3]=8100

:-(

If it's AI, fix the AI prompt, please.

> + */
> +static const u8 edp_phy_vco_div_cfg_nord[4] = {
> +	0x00, 0x00, 0x02, 0x01,
> +};
> +
> +
>  static const struct of_device_id qcom_edp_phy_match_table[] = {
>  	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
>  	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
