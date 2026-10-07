Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D96CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF4110E0A9;
	Wed,  7 Oct 2026 06:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQr8HF4+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XWFM6zVR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D2E10E0A9
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 06:27:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974UAmj1895402
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 06:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Cl6uQFa+n5AW/tdXzfCPHDiO4SySDJDdRMN6Z7wpw8=; b=pQr8HF4+R+USK0/0
 YhmBYiPm6QStkGpYu56s7w67YR6kBhKzyOZK96+UNbegYVGvxlKkOdQuoqybb6BH
 wDBOfT/YDTlSJ4Al133Fwst1T+K7BNJGlqFy2fJpVIbXVlGlk+zRt8wP2Nrt8mrj
 ct8yWuo8hUQPlwBhiThljQHkDTj9F9pfzE5jHRHJQZZUVF4LA3opR+1jUkh8jtL4
 37MWFsBA4U+eaJKQcvK0OfWzEOvxkioOdlMaoDG2FpOvVPedaMj9dSVxkBpnG25X
 DNXSkugPu+P2jtj5o20PHbzYlxbf9PNkwh7kS4Gry8ZvgNvYlJd21GwbD+niWqGI
 I84csA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53ask5jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:27:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc489e7a701so4155381a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 23:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791354424; x=1791959224;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Cl6uQFa+n5AW/tdXzfCPHDiO4SySDJDdRMN6Z7wpw8=;
 b=XWFM6zVRGYepIgwriytB125iRy3GlIqOanf0SV/HKNzr92HQfc4+DYpu9xAxk2xab1
 K8BsMDWJrmMwcKLHsKUSOn/gQyO3Pkeie2PFfq/MNm1CRJ+o8ovoIRL304duMKNPr1Ta
 COwdin4/H1Ri26Ceocu3E1NF0BFdmsotfiu/hfHkf3RDifgMs89iSjn6G/TH28gG07LY
 KJMzoJDINIzKUyW+bl0y2wSLBsLbBI9s2vncr5tD7qMVhqHa6D0zzKldDlpDjzn+W6VH
 l5foLnJ73uq6tMh0k7hMgJueCnNLAKMQI3kZ7eyAHpU869RVLMeG8T86gAntiC+RBFT8
 hYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791354424; x=1791959224;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Cl6uQFa+n5AW/tdXzfCPHDiO4SySDJDdRMN6Z7wpw8=;
 b=WIBAknDxTf2xe06p6CpEUiER42fAkEnkX/yKDzrdCcHotae89kxNUSDkvbr32cJ65q
 L1JZZB03ozQfAcBonrTTHWM6cY1cuMQjKd7KTc1yQHX93qzU+J8ub/MDP01ZOMg+NFlZ
 2Ujgs1voq0ZcIDqdtDNG79B1PcA+HgZpHfMFygccxn32aos9b4rhYozGlXgTaoDKIert
 lxdRuo8jEUGjpBfWDjq7fzQkGBp62FjGwrExuOwrX5ZHCaWkZ19a2AftTWKJyyk/K/Ee
 maCv6wJfy5FysPI/WGvOd0m4nMqprla2n79D7rq1cXF0ydN3IFH4+/80uiJMw02tsQds
 Cj0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE+lyyg+UpCwyne+hNSh/ALTkcSr9xDk3i7YGlEf5J7/Ken+av8MkzOyTYyE8Qt//6hETbb0xJ3ic=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqCEV02bR7rgpb4oP5UJ+cJ00XPrrDunKbDdKbYxjUFxa1A9Cq
 DGMVRXZVneOD2KX6LdlWD4VZ2R2hfFJVqkOwavDmGAbTsstsKSBBwq5+FEgOxI40rnNdH8OxI1s
 SRhHpbnK2ulPg5zYAIKgov1P1cStGjlgJt98hNkAoTxrGZqQRp+1T02zE8aA2dfJ80kLvIUU=
X-Gm-Gg: AYBFou1d5yafGqO6csGbhSKTe/sSHmTRhGyCqjr3ywHPCtQLjhipi87BbGVrAt6FZIr
 qghyURBIfQlLg/Gy7V2mCE4jxC1r/oe0xgChLnBwYlBj2QKwb/ZJv9zvIslsIO64wt/MoEybxEV
 RjV9Y2vIgIj2abQDh1mVn2947j5j168m8X4T3SPm5rQ0TfOiGlkhdzG2FJ3XMfegGN4U5muUlJ7
 aphOWgW20gio9ql7LbnJqlaIboRhw4VqGDUNxd6OE5i4U4Mt5jmuC4kbZJ3ygoPT1eLpDkfZEmJ
 YU2YzfRKIlVsvbu97fGT2KJE7W/PFZFPK2ZMeEUumXrFi81y7EtDhIM+bjp7DcJzIrrLqCPmOs1
 UMC6pEbNwGwM6oF8n9h1EPdXkIgr3
X-Received: by 2002:a05:6a21:3b92:b0:3cc:8344:1213 with SMTP id
 adf61e73a8af0-3e133db4acfmr1098892637.8.1791354423663; 
 Tue, 06 Oct 2026 23:27:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:3b92:b0:3cc:8344:1213 with SMTP id
 adf61e73a8af0-3e133db4acfmr1098857637.8.1791354423123; 
 Tue, 06 Oct 2026 23:27:03 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd0a92d6547sm850526a12.13.2026.10.06.23.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 23:27:02 -0700 (PDT)
Message-ID: <10b8c78d-7981-400b-8270-db0c54509272@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 11:56:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] phy: qcom: edp: Generalize power-on path to support
 per-SoC overrides
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Ritesh Kumar
 <ritesh.kumar@oss.qualcomm.com>, Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-8-e25c073cf1b6@oss.qualcomm.com>
 <mpkoztwm2ts4pb3m4t6347wfes4yeua5a5uxrn66dgmn6b6gpq@syu2fxzfmvp7>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <mpkoztwm2ts4pb3m4t6347wfes4yeua5a5uxrn66dgmn6b6gpq@syu2fxzfmvp7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LG7SwX_WTII40dDGoFt00mkoq5JOg-5n
X-Proofpoint-GUID: LG7SwX_WTII40dDGoFt00mkoq5JOg-5n
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac5e638 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=LataAnNBLSGNWv3D5v0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNSBTYWx0ZWRfXzu5tMxG19bWh
 u4APR+vUzqB0EOx5GhH2Sre8GvPlx5e5cHkcx7KqYpmjgmioI4X51PyCcnwyG3yS2hXHuqnh8LV
 6eXl/KLt0KZDjPk3xNN+R2fP2djnzS2rhU2N7n7pkXzIQeZ3HBMDvY8qgAA7iRXo0OFvh7YRANQ
 zrAT3YXvIOr//I8OjbfsiKy3J4d//QlmAdWj4K7XngH+/b3C7SrmtSgH94tB+mZ9h6ubhC90gO0
 ufgNDF0p8Vw1I9H52jm7TAiJMgdHWyPl/uy5VoH3iXIJUu89pnrUuEeEXOYujXYinbn3bNrTjWI
 fAJdlerscHpSeEPxhhhypTSdCXqtoiHEDyliNcEfSM1RiZ+Cj3vf+nZudhH/uG7pIywwSNli+AX
 BEEnO+UAtAu52fxNYqlgK79ZHEM+91PIwegokYM4bG9wh/3Ku6y1KoC4lx4cCMPF0pQt2o6hN3k
 Po3G7BPRGo23jbHPqjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNSBTYWx0ZWRfXxxH60GhXWmQh
 2XRv2JljLSrzWGy2avyXZ6Y+ocYWrJEzSjoPdRO8mw0batFrmWb8Nw0UZKsIXYYVRqIQ8kKrRPp
 q/jpuPlvaVcxkq9hE6p1Vhvq1mWPJLg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070025
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


On 9/14/2026 5:30 AM, Dmitry Baryshkov wrote:
> On Fri, Sep 11, 2026 at 09:06:39PM +0530, Nabige Aala wrote:
>> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>>
>> Nord has a different register layout and power-on sequence that the
>> existing hard-coded paths cannot accommodate.  Make com_clk_fwd_cfg
>> optional,
> Why?
As per the HPG, Nord does not require the com_clk_fwd_cfg callback 
implementation. However, qcom_edp_phy_init() currently invokes this 
callback unconditionally, without checking whether it is present.

I see two possible ways to address this:

1. Add a dummy com_clk_fwd_cfg implementation for Nord.
2. Check whether the com_clk_fwd_cfg callback is present before invoking 
it. This is the approach I have taken in this patch.

Do you have a preference between these approaches? Alternatively, if you 
think there is a better way to handle this, I would appreciate your 
guidance.
>
>> add phy_tx_lane_cfg and phy_tx_res_cfg callbacks to
>> phy_ver_ops, and add phy_status_reg and bias1_en_2lane fields to
>> qcom_edp_phy_cfg so each SoC can override the defaults.  No
>> functional change for existing SoCs; new fields default to zero/NULL.
>>
>> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 43 ++++++++++++++++++++++++++-----------
>>   1 file changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index bf8a17336c7e..373f13b3d6d5 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -92,6 +92,8 @@ struct phy_ver_ops {
>>   	int (*com_configure_pll)(const struct qcom_edp *edp);
>>   	int (*com_configure_ssc)(const struct qcom_edp *edp);
>>   	int (*com_ldo_config)(const struct qcom_edp *edp);
>> +	int (*phy_tx_lane_cfg)(const struct qcom_edp *edp);
>> +	int (*phy_tx_res_cfg)(const struct qcom_edp *edp);
>>   };
>>   
>>   struct qcom_edp_phy_cfg {
>> @@ -101,6 +103,8 @@ struct qcom_edp_phy_cfg {
>>   	const struct qcom_edp_swing_pre_emph_cfg *dp_swing_pre_emph_cfg;
>>   	const struct qcom_edp_swing_pre_emph_cfg *edp_swing_pre_emph_cfg;
>>   	const struct phy_ver_ops *ver_ops;
>> +	u32 phy_status_reg;
>> +	u8 bias1_en_2lane;
>>   };
>>   
>>   struct qcom_edp {
>> @@ -316,9 +320,11 @@ static int qcom_edp_phy_init(struct phy *phy)
>>   
>>   	memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
>>   
>> -	ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
>> -	if (ret)
>> -		return ret;
>> +	if (edp->cfg->ver_ops->com_clk_fwd_cfg) {
> Why?
>
>> +		ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>>   	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
>> @@ -1131,7 +1137,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>>   
>>   	/* TX Lane configuration */
>>   	writel(0x05, edp->edp + DP_PHY_TX0_TX1_LANE_CTL);
>> -	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
>> +	if (edp->cfg->ver_ops->phy_tx_lane_cfg) {
>> +		ret = edp->cfg->ver_ops->phy_tx_lane_cfg(edp);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
> if it's about a single register, add a register to the map instead.
Ack, I will update this in the next revision.
>
>> +	}
>>   
>>   	/* TX-0 register configuration */
>>   	writel(0x03, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
>> @@ -1169,13 +1181,18 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>>   	writel(0x00, edp->tx1 + TXn_TX_POL_INV);
>>   	writel(0x10, edp->tx0 + TXn_TX_DRV_LVL_OFFSET);
>>   	writel(0x10, edp->tx1 + TXn_TX_DRV_LVL_OFFSET);
>> -	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
>> -	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
>> -	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
>> -	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
>> -
>> -	writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
>> -	writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
>> +	if (edp->cfg->ver_ops->phy_tx_res_cfg) {
>> +		ret = edp->cfg->ver_ops->phy_tx_res_cfg(edp);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
>> +		writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
>> +		writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
>> +		writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
>> +		writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
>> +		writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
> Either use a register map or move defaults to the callback too. My
> preference is towards the former option.
Ack, I will use the register map approach
>
>> +	}
>>   	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
>>   	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
>>   
>> @@ -1187,7 +1204,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>>   		cfg1 = 0x1;
>>   	} else if (edp->dp_opts.lanes == 2) {
>>   		bias0_en = 0x03;
>> -		bias1_en = 0x00;
>> +		bias1_en = edp->cfg->bias1_en_2lane;
>>   		drvr0_en = 0x04;
>>   		drvr1_en = 0x07;
>>   		cfg1 = 0x3;
>> @@ -1210,7 +1227,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>>   
>>   	writel(0x19, edp->edp + DP_PHY_CFG);
>>   
>> -	ret = readl_poll_timeout(edp->edp + DP_PHY_STATUS,
>> +	ret = readl_poll_timeout(edp->edp + (edp->cfg->phy_status_reg ?: DP_PHY_STATUS),
> No hidden defaults, thank you.
>
>>   				 val, val & BIT(1), 500, 10000);
>>   	if (ret)
>>   		return ret;
>>
>> -- 
>> 2.34.1
>>
