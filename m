Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4FCC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243F810EBEB;
	Mon, 14 Sep 2026 08:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="imN5fpI9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VqxMGo8p";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE6510EBE9
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:08:14 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5j5bs063767
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LrqX32EnO3d4Uq7N4G8r4oWD6xf4vvdnOcV1PMGcjmU=; b=imN5fpI9OinQuYhs
 Zm681p87GeCmBBbnNrsmV+rIMI3TIs9DAG63YrWCk4+cv0xplTeOssEsSTDfC3gf
 FCNFkRpVuiiMue+2+16QSY29pGduwe4c/flZYQiz319NL316w0em1y4KIKl06OL/
 u2MXHvKc5c56927lq1UFY9JfkW6h+5Y+Z0U3tTjODp0iBg3MFfp6HGTpyanRduDA
 i3eyhMEZ8GiqvjdxD6f8NIqJOlbILvDpmPHlps9/YS8PZiZtAVCBD+s+XXO1GUHs
 xh3zfbtYP708s+YalzI0KsFeFwZirB9r+Hw/RW+tNtajftA+MONIeBeMqbQgbWRN
 B6AEvA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dnq6x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:08:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90ce451128fso6979126d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789373293; x=1789978093;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LrqX32EnO3d4Uq7N4G8r4oWD6xf4vvdnOcV1PMGcjmU=;
 b=VqxMGo8p5aGr2V2F0WeJKE35WouaU3alDCA1Kc0UZ1lQzJlBRcsaw5FH8h0dprmvsW
 H7Xi8XjbgnHooVLfkte4YanS0XTrV4dvAWF7O0nkecuWMGi7IjMAop5C4pPLI+9PZlv1
 QTwtTbITyyXzx2psKStCdBjb7N7ON+SMXXDCJ0SlckXuas/4TmB7X02Mx89+dmj8gT4J
 x6BhO0/CkwPBgSWRHaq05F8VPZv6eFtx5m4swwRkSzCZmbZ1x4vit945HuRXPvLH2kBb
 yA9zngDn4r4DYT5v5AmgHxFpBbS+ztwWAyIvLm7zWjs3xT2ykfncVncdhovk87DS6e0f
 53PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373293; x=1789978093;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LrqX32EnO3d4Uq7N4G8r4oWD6xf4vvdnOcV1PMGcjmU=;
 b=sdZ8EbrKa7HT0n0qT14o7RuZWUITAQIfrz0xUZmZaRG9WjKY/3MTUUAZ2DSTLwzE93
 hVe4iGs1qoa45Fhy2nZ2uSSXNc9JXaKwmsxQUmEjePauCXOsI9rYWUQEF91whZtYiXLV
 GUlN/1NdWRriBw6mdsSFhuh3x3viDw9fS6YsF51NEpfMnCE4sBOcJ4vygKryKb1Qv5Aj
 jnC20tvhAsTu+8uh6drH99dfPzqjJV8P1uenUHCSY/4DoMqJWRSekrzvsSM0ekyFhnsE
 YwfTRR3FiY0lcJ2OFmzzvKICfW5dQS9tqqOdqs9zA9lTMkb3MrWE3Q+v9CIwJ7Sd9f0t
 M3KQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBytlKV0l8Ft819Hnc8viJNMNB4tEIloFA4GEej3m4V5bo0hVFQj1w/0L4BjIEmcFjj4qppPqtHynFA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKO1Kektoyr2sLmvSx5DMywtDw9QX8+DX/yVklklRgt1CLLjVC
 KFPpQXoLutYlpPQYVqnv5ToG1pAG0XMIVuqMEifGk+J+3RSmsSX0XhlqewFc2xot4JTjtBET5k7
 6P0AEpvmryJp0wSUjX0942t0oqgAGdcnQ7I4cilZjQjZC1Zx6YhVyRdtPkw4B+UBul1IUsWc=
X-Gm-Gg: AYBFou3rp4zUHHxZjJ9zuRzFXISphZ3pGt8D2ElIl1BalTyZvygtgX5YV0PjNyyncuF
 lbp7ngn6vLBQpfGOs5cHySNURP9NJqHI+kn8sZfcxYiLAJ9B7ocCrvUpGKLekzBPzybzxroi54o
 RUVsvDgpN9xbyIWIeDzTp87N0uyeqa+2Iek5lalOFI5XC99El7yiqJ83LN9S305pu4KCLNjAo8I
 TshiSu77FArUUOkuRHwk+cNpFKu5UO2PYvFs7xYvn4Ymqajoc0LPw5Km2jdBsPLHwb+QaFh8Dp4
 oAmS1LKRs1ETWqRTnGPVzdlBoSvia2f4gaaLJP2E0zL0fbOBWZH81uKDZnfdK8bZId+hgWMBCsQ
 87Mn6eG7tigOGJ6PafushOQ==
X-Received: by 2002:a05:6214:410b:b0:90e:9616:d7ac with SMTP id
 6a1803df08f44-9122e67e91dmr18605756d6.4.1789373292982; 
 Mon, 14 Sep 2026 01:08:12 -0700 (PDT)
X-Received: by 2002:a05:6214:410b:b0:90e:9616:d7ac with SMTP id
 6a1803df08f44-9122e67e91dmr18605436d6.4.1789373292507; 
 Mon, 14 Sep 2026 01:08:12 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2966067345sm391067666b.32.2026.09.14.01.08.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:08:11 -0700 (PDT)
Message-ID: <d9671bb6-9924-4b37-bd7c-de9e343e6f4e@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] phy: qcom: edp: Add Nord PHY power-on and reset
 state-machine callbacks
To: Nabige Aala <nabige.aala@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-11-e25c073cf1b6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-11-e25c073cf1b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExNCBTYWx0ZWRfX3Scy8r2bZVvl
 QsZ+43sEP9Ot4Y4U0ac+GFJyaIRNII51odkYg0miW5pzbkOZ1Lq8u67Q9Smk9/sQHYM+kGeNo3v
 aKxqzAWrOLsQ72Vh1ivJYiBqQsrVkFcK2EitWgOn7HqdbGJRcvi/uUfsqaHJHTY/RqXtG9lBQ5B
 HEzHVApamjULd3fxNNLOUe+uDjqe3XdxKRvFa1U5EtXIsb/t00NI+psC+g0FzbTIx1b6oSYBv6O
 h6iRcZUVbx+aefFhn9z24ZMl6ymFp3r7gP+HsWMG2vkDI0wCQATj5oqw5hH1CnjgiEcIabpC60k
 csCZpqa6wvbxvgq6OKofNdcR9AanIFlhA2/7B9G7R3UjwWYwGywrcJJ2PVrxeD3x1O98tS34PoM
 vUnillqtS8aLcDYXQbMu0KPPrRybxMHiIWKciuOT8unzM15YdkFRGxIsdWdJxkjrPyc03Omb9Xv
 1KaF1p/JpIMKsKDig+w==
X-Proofpoint-ORIG-GUID: Uh79QqRbLVHStWvGuRJ1GjX3J2Kcwr3b
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExNCBTYWx0ZWRfX+8LgAxKNwNJw
 ByeMhHhRMx2+qK7SNHFdmb/igGJCfvz06vpqjpjGk1Z7d8qZ6rcq47BxI+5jI6Y+nsS4gCrww1y
 15PKz+7SG6zk0EGdQ1OpEDkj7SZE1iA=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa7ab6d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vbpSL41SLP_TpwptBaYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: Uh79QqRbLVHStWvGuRJ1GjX3J2Kcwr3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140114
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

On 9/11/26 5:36 PM, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord relocates the QSERDES COM CMN_STATUS and C_READY_STATUS registers
> so the generic sequences cannot be reused.  Add
> qcom_edp_phy_power_on_nord() which powers down all lanes and polls
> CMN_STATUS_NORD (0x1d0), and qcom_edp_phy_com_resetsm_cntrl_nord()
> which triggers the reset SM and polls C_READY_STATUS_NORD (0x1f8).
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 64878398f43c..6cac4b55b66f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1612,6 +1612,31 @@ static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
>  };
>  
>  
> +static int qcom_edp_phy_power_on_nord(const struct qcom_edp *edp)

This commit introduces compile warnings (-Wunused-function)
> +{
> +	u32 val;
> +
> +	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
> +	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
> +	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> +	       edp->edp + DP_PHY_PD_CTL);
> +	writel(0xfc, edp->edp + DP_PHY_MODE);
> +
> +	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_CMN_STATUS_NORD,
> +				 val, val & BIT(7), 5, 200);
> +}
> +
> +static int qcom_edp_phy_com_resetsm_cntrl_nord(const struct qcom_edp *edp)
> +{
> +	u32 val;
> +
> +	writel(0x20, edp->pll + DP_QSERDES_V8_COM_RESETSM_CNTRL);
> +
> +	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_C_READY_STATUS_NORD,
> +				 val, val & BIT(0), 500, 10000);
> +}
> +
> +

Double \n

Konrad
