Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1CC88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31D7710E65C;
	Mon, 14 Sep 2026 00:05:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjGLO2iR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ENQ+kkco";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E927710E65C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:05:45 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNYSZf3475571
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RFfMXnGd4KZ9ZeGQQ7T1vM3J
 mMfNVsWmNXWnKZ/EyFU=; b=RjGLO2iR56z9k1Wyb9BNCcvkFLnw4qHtmwKfIZrw
 EJPCVhCVz0aqhlq8ZAM+gQ+r4Gkv/Ax3LAQEtsX7BWlvFf2mfJWoLzZPhJkGDzaN
 amIa1e9Fi6bSk9GtCtbXOFw+x+fY/3vZlkbn0a4HxBuIurQ9PGeIFY//5nCVAfOr
 xfTfEENE4Pt7V9JDNKMdvO4BqcgiCNgU1pChHNsNCJ6tFNKarLOmrIT6Tb20nChr
 NFzzWvvVKTvNrBbVh/M/MVESsiK9LVH0/iHNFRXv7V3LJ53FVT3rbKqqXJBg7lZI
 iGHb+POvy59JDGsRxhKi1wYqmQW0Y7y/josD5L1Bhr/mVw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dmeh0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:05:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c79915791eso901552e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789344344; x=1789949144;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RFfMXnGd4KZ9ZeGQQ7T1vM3JmMfNVsWmNXWnKZ/EyFU=;
 b=ENQ+kkcozvdf2SF532Xi6sYDKXUrE2mOSgEuXmqyJgPuUemGx1HpjnFtaPnrFJ58YX
 XJDvp1u+mp5IDwFeO2SambCMq+rV+NOWRI4Jun9GWBz4vuqRhjpJHiKnpH3Ifa/qBS77
 xEPxUS/5evM5TAFOTIQHp27bTcMfzq79rhHHUw/KV/joUZq3hmNXliXnmftLrQiE/4p2
 KL5K0GMHdiDq39Ks0axBlnZvzbGPVQVYMInog7uCMEGdcnTWgfxwvTpkAmThbCnM/Mgi
 97BvmscKaKSymDcMc+8ml1/T9IRSRVvsLaJMutt4cRVgaw6V8ddniqR62+LEiX4/lWqt
 0CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344344; x=1789949144;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RFfMXnGd4KZ9ZeGQQ7T1vM3JmMfNVsWmNXWnKZ/EyFU=;
 b=AGfeuBV/hq93aP2dJbSisPeG1xcGiNSgelkSi20L8IwkpKOyjAFRrrHvNGBT1qkHIv
 tRUPQN2RJJ94L7Oz/faKkIs3CM8DplXicbul1JlU2iVI5uLw224F8TtT0dcD9y1ytLOI
 k6OcaUyyvauVA8aMXcLJpAuNksXSVBqe10f6D8PU3HKP5vCmqXw3LS5ffsgriPsSNlnB
 QekMbyXMyadipdqM2bkF3F37aYCQe37SNjXyolD8Qr+8g2df/CTVmeLppH9Kh1Iy3Igb
 14IRAqfMijvg82rD/+8QDY0i+1G0UY6vra8uAAotx2H5TcpCDJN03Jwx1A9ZECb4XyNr
 nqUA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9+oxg7jZCBZ43llF9he3b7Nblfy9BliXalV4dLFS7eej4S1ZopR9fnG5MpANtlzPRomo7QMpA0fM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktdUQukWWtPkWxDx3OSm0E0MeyEHsVSwN6fVkmPT2QYPw3Nfb6
 o38+itanLi8aAzl+AsJbWHaRRzos5D1duf7gXmGkdYrTb2++zfgUZqCVeI2A716J+wkN7199jil
 iISzj4DJr4DTry6v9dulnbRWjXUFostBXwFX3xSsnGF7lnnLSyjML3qGLgo9qBQRXIxHeFpI=
X-Gm-Gg: AYBFou1AlR7maLOC3YKFdHF8zvpZvPpwH9Mr1kaJ+2TrWaZiR47AlpF7UvbiLWdRyhZ
 3aroyr3BpQkVby8yq1YH5csEIAhd3BT181MTKnKZ+uzcmUm9t10aaoILT8OOzAkdQKOsZG2xJDm
 DUbjBrL+326lMHHGY1B6vI6+XD9jArzoXpF02TJ0p258cReHPVF1yVxZ+VIqcrOtXaDYjybaH/I
 8uOAztnhhlP7PgskryWB6fCprMzuUgGzA2Wi+OAWXkbWXIRYZSId84yrpcon5pNSgQMkYWXiu1G
 K29LbUYs1eVVDffIGXNatrhABzxIqQH5ZsA81k0hX/FKY2s+3gWMw9ODsyTys75N2aa2rOPwa3e
 XTOKMFAClSh5s20je6jDQAA4HiH1uh1Hp4xZIfM1F3TwmfU9TIetADTqD9yXr2hsqV1Koxuq/Rz
 iGJNNuuKFB3XuI
X-Received: by 2002:a05:6102:162b:b0:797:b4ae:5897 with SMTP id
 ada2fe7eead31-79b5db96600mr47876137.7.1789344343808; 
 Sun, 13 Sep 2026 17:05:43 -0700 (PDT)
X-Received: by 2002:a05:6102:162b:b0:797:b4ae:5897 with SMTP id
 ada2fe7eead31-79b5db96600mr47836137.7.1789344343016; 
 Sun, 13 Sep 2026 17:05:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a33263c7sm21536081fa.21.2026.09.13.17.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:05:41 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:05:39 +0300
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
Subject: Re: [PATCH 10/17] phy: qcom: edp: Add Nord voltage-swing and
 pre-emphasis tables
Message-ID: <rrkzp7kbest7vmkcgq3g4ewhpskl4sdawtjncvfdgmixi2bjod@faldfme3q4wr>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-10-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-10-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0NCBTYWx0ZWRfXwPpaadK2DIqE
 LCOvmUdXYJTwpSK1y4DXKgWitvA0BhgldwcYGAslG6YzHkuXKewHytXMfLIv/KBwsDM6oJy2Iyr
 MP0SqaVkQM7tD1pl2LSd9ihPgJmFv0XdwMieviP4TeXU6C9xHAnmsTVrH99MpCJPa3XYpDVjwTD
 Ec91vLjEFZVAJQJDaSf84xPGpIj610lGsVJECgXCAq46DQDoeRzpKiqzF9Hg5uAhKDDrA6E2szn
 Q65U+CRBPISe5qjWYfUdjdl3yWWozpnB7VoUrq1jZed5x7Rp42oZ/IhYr8XJPzZQEAGK8jR20dG
 231Rc58dazsUJ0tcyNrZThbCT2K8EvxhNkFQNNcI6H1FVgyKA8wRe1QidhNECqGLGgeHgWxFqyJ
 hovq9R9cGNs2jWj4lghF7PTxBWjPwbstAYssqABPhKi4znMrL8dEukAtDzetWl/fe591JrnXXbV
 UIrkYmQw28Frm2CKjHA==
X-Proofpoint-ORIG-GUID: eMqTuvBhVQtCm4tMfsG7xelFwtk7bD-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0NCBTYWx0ZWRfX9rzUOpQ4RPR4
 W616zUTNctCOCemzumlSkkzs7RZS9seJhonqNuy3iJlfGTCk5/Z4yTyocWzBkqrdjzR9PSmFNXl
 AEIsKPddpyET9SLux/nTiKca5n1u/zc=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa73a58 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=WDH15GvG5mASCzW3U0MA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: eMqTuvBhVQtCm4tMfsG7xelFwtk7bD-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130344
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

On Fri, Sep 11, 2026 at 09:06:41PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different TX voltage-swing and pre-emphasis levels for
> both eDP and DP modes.  Add four pairs of 4x4 tables covering RBR/HBR
> and HBR2/HBR3 for each mode, sourced from HPG Tables 2-2, 2-4, 2-6-a
> and 2-6-b, and wrap them in qcom_edp_swing_pre_emph_cfg descriptors.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

How many commits do we have for a Nord? There is no point in splitting
it in 10 different commits.

> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 85 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index ee0d7f1a90fe..64878398f43c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1527,6 +1527,91 @@ static const u8 edp_phy_vco_div_cfg_nord[4] = {
>  };
>  
>  
> +/*
> + * nord eDP swing/pre-emphasis tables (eDP mode, low HBR: RBR/HBR).
> + * From HPG Table 2-2: LDO ON 550mV (0x51).
> + * Rates: 1.62/2.16/2.43/2.7 Gbps
> + */
> +static const u8 nord_edp_swing_hbr_rbr[4][4] = {
> +	{ 0x07, 0x0f, 0x16, 0x1f },
> +	{ 0x0d, 0x16, 0x1e, 0xff },
> +	{ 0x11, 0x1b, 0xff, 0xff },
> +	{ 0x16, 0xff, 0xff, 0xff },
> +};

edp_swing_hbr_rbr? Why do you need to duplicate it? Drop the duplicate
tables.

> +
> +static const u8 nord_edp_pre_emp_hbr_rbr[4][4] = {
> +	{ 0x05, 0x11, 0x17, 0x1d },
> +	{ 0x05, 0x11, 0x18, 0xff },
> +	{ 0x06, 0x11, 0xff, 0xff },
> +	{ 0x00, 0xff, 0xff, 0xff },
> +};
> +
> +/*
> + * nord eDP swing/pre-emphasis tables (eDP mode, high HBR: HBR2/HBR3).
> + * From HPG Table 2-4: LDO ON 660mV (0x91).
> + * Rates: 3.24/4.32/5.4/5.94/8.1 Gbps
> + */
> +static const u8 nord_edp_swing_hbr2_hbr3[4][4] = {
> +	{ 0x0b, 0x11, 0x17, 0x1c },
> +	{ 0x10, 0x19, 0x1f, 0xff },
> +	{ 0x19, 0x1f, 0xff, 0xff },
> +	{ 0x1f, 0xff, 0xff, 0xff },
> +};
> +
> +static const u8 nord_edp_pre_emp_hbr2_hbr3[4][4] = {
> +	{ 0x0c, 0x15, 0x19, 0x1e },
> +	{ 0x0b, 0x15, 0x19, 0xff },
> +	{ 0x0e, 0x14, 0xff, 0xff },
> +	{ 0x0d, 0xff, 0xff, 0xff },
> +};
> +
> +static const struct qcom_edp_swing_pre_emph_cfg nord_edp_swing_pre_emph_cfg = {
> +	.swing_hbr_rbr		= &nord_edp_swing_hbr_rbr,
> +	.swing_hbr3_hbr2	= &nord_edp_swing_hbr2_hbr3,
> +	.pre_emphasis_hbr_rbr	= &nord_edp_pre_emp_hbr_rbr,
> +	.pre_emphasis_hbr3_hbr2	= &nord_edp_pre_emp_hbr2_hbr3,
> +};
> +
> +/*
> + * nord DP swing/pre-emphasis tables (DP mode, COMBO_PHYS TypeC).
> + * From HPG Table 2-6-a (HBR3/HBR2) and Table 2-6-b (HBR/RBR).
> + */
> +static const u8 nord_dp_swing_hbr2_hbr3[4][4] = {
> +	{ 0x02, 0x12, 0x16, 0x1a },
> +	{ 0x09, 0x19, 0x1f, 0xff },
> +	{ 0x10, 0x1f, 0xff, 0xff },
> +	{ 0x1f, 0xff, 0xff, 0xff },
> +};
> +
> +static const u8 nord_dp_pre_emp_hbr2_hbr3[4][4] = {
> +	{ 0x00, 0x0c, 0x15, 0x1b },
> +	{ 0x02, 0x0e, 0x16, 0xff },
> +	{ 0x02, 0x11, 0xff, 0xff },
> +	{ 0x04, 0xff, 0xff, 0xff },
> +};
> +
> +static const u8 nord_dp_swing_hbr_rbr[4][4] = {
> +	{ 0x07, 0x0f, 0x16, 0x1f },
> +	{ 0x11, 0x1e, 0x1f, 0xff },
> +	{ 0x16, 0x1f, 0xff, 0xff },
> +	{ 0x1f, 0xff, 0xff, 0xff },
> +};
> +
> +static const u8 nord_dp_pre_emp_hbr_rbr[4][4] = {
> +	{ 0x00, 0x0e, 0x15, 0x1a },
> +	{ 0x00, 0x0e, 0x15, 0xff },
> +	{ 0x00, 0x0e, 0xff, 0xff },
> +	{ 0x02, 0xff, 0xff, 0xff },
> +};
> +
> +static const struct qcom_edp_swing_pre_emph_cfg nord_dp_swing_pre_emph_cfg = {
> +	.swing_hbr_rbr		= &nord_dp_swing_hbr_rbr,
> +	.swing_hbr3_hbr2	= &nord_dp_swing_hbr2_hbr3,
> +	.pre_emphasis_hbr_rbr	= &nord_dp_pre_emp_hbr_rbr,
> +	.pre_emphasis_hbr3_hbr2	= &nord_dp_pre_emp_hbr2_hbr3,
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
