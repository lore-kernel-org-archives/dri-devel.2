Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA8CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BA710F605;
	Tue, 13 Oct 2026 08:47:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D0810F605
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:47:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7OXIs015275
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IxEa8Pb0nd9li3Y0xVvL05fY
 BOkeTK7g0eV66MENLQI=; b=KEkVwhbk0wuOcnJ1TkMKcfb2hCTRrP5E8RJDZFHh
 /bMRgihMcV7Q/HmXwIGZTJRsAQP1C+HWCs57+KLsjhrk/TEAVZjgnPowKqkictTV
 kT2c/HHbe1z5X6G7jNaFLEHSsFzniX65KDDkZzaPmcSfFSkBK9WZTZfS4kDs1Lh4
 kOqQi2ptLoa9s2Yvm8i4D9IHuDILe+nhmqXwkVo4nrIEDUwNdIIGzY6dcl95j14U
 9xd9G0Tt3R/lF+02bVJ+SqVeimUFBqCnZqrE1PtM5ps58F9ErlCrgYTH2z8HwY8t
 p71DX1IR8z56Y5vAOG06LAhcq7niRCW3dX1jVoZjg9i7qA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugavn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:47:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93dea1b6c89so526400285a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881232; x=1792486032;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IxEa8Pb0nd9li3Y0xVvL05fYBOkeTK7g0eV66MENLQI=;
 b=hqPwuuA6P/xXDwzRa8EfVxDmSyVYhGOSOAh/pQa120bXjR5DIjZolnZP8uONL2FBIw
 lqqrqXo8RQlhEVrVFaCXPUsabJ7+ohwwD5NkBGfEKVZUZRb8rzFXy+V0CtELOK6BXGU2
 7v5GPZEE7584mru+ovnglgVm2GdpkYXuOaOhWw011vXLzL2eLjIDC8C/bMQcvDiAFN/t
 zaVilXzp04FL3M6mFWdkrmHmwe50jIUCjYF7/V7CS3kVqlDZjmvjuTyJrYfNgApgXd6O
 ZoAvkOBdcQHw4QMCLqu/lhM3V6LbAvfiAOn3OLFfu0bFE1/l0qvxsYRJEeG4wqDpQDNM
 RWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881232; x=1792486032;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IxEa8Pb0nd9li3Y0xVvL05fYBOkeTK7g0eV66MENLQI=;
 b=M0JrQ990/st5j50foxvp5HdelzBR1bgW1eqbj8sc9iPhvUYo5IeJdg9HbiNEsGMS92
 j3F8YrKhJwFHy0rAwscNTtYhLPeUmNquYrC25Q7D5aS2xkTlq3mxTtyhwWUKxvkvXLVF
 M1oOa17xcGc8dS9vAvdEtzqcuheOK+6EnGwVTknDuhRuuqnD9yX+0QOetCS2sthbNzRG
 /J9w7EhWWs4bVmxjdLF+rwHrkPbtGetijR/j/Td+DFFOGosKOLVaeCVN30DKEEq1CqsE
 o+h7FmnE8QqptpUJQXc4TGAhD35O2uxjbLGwzOTBH+1yklWhhNeK9jjaok78q63akk6X
 A9lQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxI3yPst+wH7xma+ZtBQ7iIewcZm2AI/YXVggvwbSYsDGb82Khw9XVwLSaP3sSlOMFWv+ng9e981Jo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLfxPIh+24wh136/pwDpt4MQhecBG4GjDb3r8E64SZuuq7vv/WH
 KPZKlCtW2umqatjcaO5V1oK10gb/iFD7CV3uYSlrykQfsUoqdEmMrmFHEwT3Z1zv36VsODWQZ3b
 VTbkYX2tI8YuzpOVmhoVKST7iuN3UXF+PQW62ovlR7JYuRUdMs47Ly3inedWI+PYyNe1vhiI=
X-Gm-Gg: AYBFou0qYvMIOomUG2PWah60r6ssO7gJZwvPDq4nxcuURb0TopSC4IJ7wWLpzLnwFYf
 33s+A+KkI+VSJuOpj/qtFWHmhcWif59JNTjwWGdSSs1PsN8uWWZxD6BR6MzeXNA2LH6D7zCFwgA
 gunrcmhtCeReW5tkUc4jqWp+PlCdAXhIhzVt8iJempr6oyd+3KS3n8RwS/NUY2YL7A5ztEezELY
 OwK12oaYGsoRbCyqXwDV0YDzSxkPWUcYDgPGLVcS3MiXkA7ZT2P187R8MwRu7Ej3t/l7K4JQuWA
 8wJ3gfNAd/YKdRPwD3SuO0jtTuY93gDmw6AiWx6y4H0gtqWMYxhwfvukOtmS4GZXDxscK1bWct4
 +EcUz1qe0LZomuqY=
X-Received: by 2002:a05:620a:4689:b0:93c:70da:e45e with SMTP id
 af79cd13be357-93ebd223c74mr2039228985a.36.1791881232240; 
 Tue, 13 Oct 2026 01:47:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4689:b0:93c:70da:e45e with SMTP id
 af79cd13be357-93ebd223c74mr2039224385a.36.1791881231577; 
 Tue, 13 Oct 2026 01:47:11 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.215])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18d12fe04sm215536315e9.4.2026.10.13.01.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:47:10 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:47:08 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 10/13] phy: qcom: edp: Add Nord spread-spectrum
 clocking configuration callback
Message-ID: <7cojksxbq3mznhkn7g6rxxxl2kmgd4hpkup35oj4qdbcqnqjsi@c63o5bgxps3y>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-10-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-10-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX/5407WCWPjoo
 wRF6i5hznuMA3/IWiYHfe3odfyrusYknrBBdM2RSsJX8w/u7Od+ULq3FtzLB711DVFzfNc5gCuv
 AbGSIPTF24zkUpXPBN66VmvB1MWqytWwGTsAy2LqzVjl7WkO7Moydt/zdRRCTI+dugBfplJ6NK+
 Uy2PPZITDyP4/65qHktI7tYbEtRIInoYHSrHmS1H66Q2DcEOgZ+lABh8HYdWNnUZOe8h3zfj5CS
 PnA1ipj30J0v1G6yeVZQ5vGLTC9KhhRWRz5WzwVjgb2MV9V/ck1NYDHc6Yi4PquK9d6fRYS0EXN
 tBKI8ERAI+ZsJWlJfuUChSlYhldu1oBdk6jg9HK1xpxROqmSeyVJj8l/9OSWxsjgBs1LzH2yPpC
 5jRAyP3wcSFLH1fJ2XeqGpd0/Qk9fQCAcsxRNwSvrc0E6Q4oxAlDBcb56astZyVLNjQlq5wYbCN
 kPFokyJrFOtV90MJTeQ==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6acdf011 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Rt3kCFFBWhWisHNmluDamg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2vP-gcZVKESdWMdgu4kA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: z6dXdvikc63ZRG2LLXDEhqsxiMjjFIVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXyBzgpD6bO+Qy
 KwFjHivQtDurWBPURG5+Thy09XqSQo+d21gGC9bIhVMR13JMkocXcMrxc2Knopg7BdeBfJn4vOG
 8toSb4iLJw+XBOTzdgqhkrfEuEKpPg0=
X-Proofpoint-GUID: z6dXdvikc63ZRG2LLXDEhqsxiMjjFIVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034
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

On 26-10-12 19:02:20, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different SSC register values compared to existing SoCs.
> Add qcom_edp_com_configure_ssc_nord() which programs SSC_PER1/2 with
> fixed values and link-rate-dependent SSC_STEP_SIZE1/2 for RBR, HBR,
> HBR2 and HBR3, per HPG Table 2-9.
> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index c63f721702b1..66c31684c48e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1601,6 +1601,42 @@ static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
>  	.pre_emphasis_hbr3_hbr2	= &nord_dp_pre_emp_hbr2_hbr3,
>  };
>  
> +static int qcom_edp_com_configure_ssc_nord(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
> +	u32 step1;
> +	u32 step2;
> +
> +	switch (dp_opts->link_rate) {
> +	case 1620:
> +		step1 = 0x83;
> +		step2 = 0x02;
> +		break;
> +
> +	case 2700:
> +	case 5400:
> +		step1 = 0x18;
> +		step2 = 0x02;
> +		break;
> +
> +	case 8100:
> +		step1 = 0x5b;
> +		step2 = 0x02;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	writel(0x01, edp->pll + DP_QSERDES_V8_COM_SSC_EN_CENTER);
> +	writel(0x00, edp->pll + DP_QSERDES_V8_COM_SSC_ADJ_PER1);
> +	writel(0x6b, edp->pll + DP_QSERDES_V8_COM_SSC_PER1);
> +	writel(0x02, edp->pll + DP_QSERDES_V8_COM_SSC_PER2);
> +	writel(step1, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0);
> +	writel(step2, edp->pll + DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0);
> +
> +	return 0;
> +}

Why is this a separate patch?

I think you can squash patches 10 to 13 in a single patch.
