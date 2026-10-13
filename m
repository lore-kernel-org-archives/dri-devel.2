Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F359CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0EB10F6F9;
	Tue, 13 Oct 2026 10:26:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A6A10F706
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:26:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D907Ri791622
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=XFUwTfQDkVnqeA/tF6NFKAol
 awlux0KkzVVWyuMzsqc=; b=GX9DqWwH+E/919mEvs0RhmiLoecGAC768fDrT/sO
 IkRtgNHxo/mWWGvL87dS0gk56l+Xq4Rxq6J+SGFvTUV8UBVRjvsbcXIOOuxU77ZO
 izHpUyd22ulUGhNp1C49mYak2O96vfFV6Rz/7HY96nW+TJgdQsUPpmSLPioSgJ/T
 WVKHuM+zuwr4KWsgoMA4oJEc+kZ85azti/CDznStH+xwI0lBZ4Q1ZdnXf1vHx41+
 D43ObdnskSLTwofeDI/qTKviiJSoWpM/rhJz7Is1mWl7n3bjwpA/qVJRXWBIrWnC
 LEGB/LTdJIdevg1W0enyQwk9D9gBj5hpXwwCJMunxtikWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrcdp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:26:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e46c120dfso293157385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887171; x=1792491971;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XFUwTfQDkVnqeA/tF6NFKAolawlux0KkzVVWyuMzsqc=;
 b=RWGEFxSgacZ760S9Q06CY4YhMAnGONjJcvYJQF0wK+emAML416emFd7ZJ8Ph2YcSfd
 tnlxaaXUx/senzBPwVj8HizQYpNdmnMJbfpn7iFY8low5NboVO+rCp2izgrZkbZKeR9R
 yEkmI+7c0OecvHZ2aR6A5LryYOFOasZsMcNps+ucyiH8dcsoDoTFuqaB+noRfXG7zqNZ
 /KvODbcs4C4PzaptLryzkxOSGXubrS5AagbLJfmtMx9JWiqxM+uffWsD2CYtzdOvrzme
 wMAKnY4gn6jbC62mcMWHzKcTqrM4sDRUQSo0q/ZhD/3bjn8wO0dDEAz2lHmXynEsuEPV
 9Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887171; x=1792491971;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XFUwTfQDkVnqeA/tF6NFKAolawlux0KkzVVWyuMzsqc=;
 b=lIEPPoKYvXtda6wlOmFmK4z+L+szku5TzMseyGqttorL1xWpLk/TSB3uN9sF413C4n
 T71fv3lrgT5qNwizhOAK1Og6GPCLjC56bPZKRD9PxVN2PPVJQ7vHXAvLsy/1lYeUVqwF
 BImOCXMl4314MjGF84NrfEP+QJSIrBcm+ioYQXgIg2WlT3ZxpwjkIGHfVYtYTAr5BV3a
 WgIvG7ABeH4yaoofqeu7mLR+RcFiK1GwTOZRPANacYEIvqEw7ehGcKqmgwtch0AuHK05
 FUUpNvzn4iEsNGCmddqRiRdsx4S0wpypFAMotx498j+dyXEeMC01IlcUmbAj/JaqxmNL
 yBCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTtGZTv/EAyLmt+xpPsT1McVz/QIkJdj6HpLnwN5T9DweljweFTnmq/DVmcpc9PxGiKwAOaBZdjxE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKx0Q2FcFyP0vlmGYMSbpwjVmaqBay6zzlguMSmb2X4V4RPAPBw
 /yKR+4+gbSl7zu8uhI4QOxApdQtfM7UAa91nNrWeOi4UzKTWaR4Wi/xtv8uRfMd2RAwgJV8Ka0M
 dGW5Uohqdk9qWjLtiMDwjWupR7K0rEAVWTSDFghLC2Dd2QZXVEOXi0zuQJFapWGs5FJulis8=
X-Gm-Gg: AYBFou176FrfNlVpySQdakIfD8MMlJumchKJxHfKnmfEeg5+VJCjtQwBlm3yjp+2S56
 E0vt0Rn7xooqX9Hgfmqtg2R1JMt2yXrPnGSzxTNfHVVfJlJryA9eSiOm+wQu83oGeyB9aOdlrr0
 wa2em4N98vshPDYxNDe1qkTGHalsaZIlVDj9s4AmsuM/S822CmYNf3EUr1EG62tMQWAtSlBJYF9
 M3Xt1rq1Ltykd2B1CdE25ugTyEGVFHimhYBLCk8LMY14ASMgnQ45whqOCPegmnRB9WK2Rnof3yN
 liAb+AhfWvVQZ7GPMamWEVU9zeKUptB7zwuPYTTk6WtHcRgY1EIejwnA41UtKlrgDsenn7PKPLI
 9UW9skkXgXBIKjtGuaU2e8OnzNNMWkFh2AryTZTwEnJuYZd6/4Z9XD3PWQjVue3dplZ9AjiIFfn
 59ghDfqsF58kMo
X-Received: by 2002:a05:620a:2b8b:b0:93e:bbda:dd06 with SMTP id
 af79cd13be357-93ebcc0f86emr1896453085a.0.1791887171118; 
 Tue, 13 Oct 2026 03:26:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8b:b0:93e:bbda:dd06 with SMTP id
 af79cd13be357-93ebcc0f86emr1896447685a.0.1791887170357; 
 Tue, 13 Oct 2026 03:26:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddea81c7sm3490792e87.49.2026.10.13.03.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:26:09 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:26:07 +0300
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH v2 08/13] phy: qcom: edp: Generalize power-on path for
 per-SoC overrides
Message-ID: <y5yofnl3x5jg7yxwzlpl543yir6uos3c3tj45u4ocjvy7u6sgz@2c5u5szohx2i>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-8-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-8-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXxYTvMvxYcKRv
 T5U1wapTxXrDEtLA4wLDMphajOqIrwuEqg6lyD8aS+PgTov6TiNePlZsPKAuCytFKNBDEQ2bncU
 xzGnZBvtDdgBg0xQepLXxr2GIb2b5J8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX/iGa4zzjkvW9
 C3tMEzIBQ1E1XCWJMy9t4gd1bA5nC+KkwVSNZpcqR5dexLyPdZTWmP3afIBYVqft1y26F04u1UG
 40ozJtE28lxCJhAaWq0kxD0Op4a/VFkTWq4rxWElIv/4hddZl28Uci7dqFihH4ViJh3NO+1l9fy
 aenrXJzZ/3DcM0eBQUiP9o7hAZnNScMQd1nTriXZuzOOa/8DXYEVh00H23HOdnNrDRi2mWFhaEt
 U5tMrHOIOVKI6VzX0CeWUkCD5JrOBnzhbcICVtPBBOYTgT7cHyGr19ZEILROJDyfmdPXefMXkCg
 M+q1VRMF1JvMRIGvFmlc4ddZrRNRwqrN6/LDWMOxZKp0P4R1Wyx55+rOyRHPUajweqs2I1vt6VP
 KznASCoXHXIGytPyNWEUqLdfVbInwfISM6TI2WdDwLPWuhKvzkKUvcqUazHXFH9XeJf0PDM08oG
 bwT8Wfib+04SyKHeoWw==
X-Proofpoint-ORIG-GUID: lfvZrXSMb-ItP3moRx3SX6gofo-yBaPg
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace0744 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=x5eWZYghlK0YOYNvIKQA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: lfvZrXSMb-ItP3moRx3SX6gofo-yBaPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041
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

On Mon, Oct 12, 2026 at 07:02:18PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord has a different register layout that the existing hard-coded
> power-on path cannot accommodate.  Introduce qcom_edp_tx_res_entry
> and replace open-coded TX resistor writes with a data-driven loop
> that also handles base=2 (PHY/edp base) for Nord.  Add
> phy_status_reg, bias1_en_2lane, tx2_tx3_lane_ctl, tx_res_cfg,
> cmn_status_reg and c_ready_status_reg to qcom_edp_phy_cfg, and
> make com_clk_fwd_cfg optional.  No functional change for existing
> SoCs.

This becomes too much table-driven, while the edp driver preferred the
code-driven approach.

> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 82 +++++++++++++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index d5c6835b6c70..c5df1086607f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -81,6 +81,15 @@ struct qcom_edp_swing_pre_emph_cfg {
>  
>  struct qcom_edp;
>  
> +struct qcom_edp_tx_res_entry {
> +	u8  base;
> +	u32 offset;
> +	u32 val;
> +};
> +
> +#define QCOM_EDP_TX_RES_ENTRY_END { .offset = 0, .val = 0, .base = 0xff }
> +#define qcom_edp_tx_res_entry_is_end(e) ((e)->base == 0xff)
> +
>  struct phy_ver_ops {
>  	int (*com_power_on)(const struct qcom_edp *edp);
>  	int (*com_resetsm_cntrl)(const struct qcom_edp *edp);
> @@ -98,6 +107,12 @@ struct qcom_edp_phy_cfg {
>  	const struct qcom_edp_swing_pre_emph_cfg *dp_swing_pre_emph_cfg;
>  	const struct qcom_edp_swing_pre_emph_cfg *edp_swing_pre_emph_cfg;
>  	const struct phy_ver_ops *ver_ops;
> +	u32 phy_status_reg;
> +	u8 bias1_en_2lane;
> +	u32 tx2_tx3_lane_ctl;
> +	const struct qcom_edp_tx_res_entry *tx_res_cfg;
> +	u32 cmn_status_reg;
> +	u32 c_ready_status_reg;

If anything, it should become a part of the ver_ops. But, I think, it's
better if you add callbacks to ver_ops instead of just describing regs.

>  };
>  
>  struct qcom_edp {
> @@ -313,9 +328,11 @@ static int qcom_edp_phy_init(struct phy *phy)
>  
>  	memcpy(aux_cfg, edp->cfg->aux_cfg, sizeof(aux_cfg));
>  
> -	ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
> -	if (ret)
> -		return ret;
> +	if (edp->cfg->ver_ops->com_clk_fwd_cfg) {
> +		ret = edp->cfg->ver_ops->com_clk_fwd_cfg(edp);
> +		if (ret)
> +			return ret;
> +	}

This is fine, but why?

>  
>  	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
>  	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
> @@ -672,6 +689,16 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
>  	.com_ldo_config		= qcom_edp_ldo_config_v4,
>  };
>  
> +static const struct qcom_edp_tx_res_entry tx_res_cfg_default[] = {
> +	{ 0, TXn_RES_CODE_LANE_OFFSET_TX0, 0x11 },
> +	{ 0, TXn_RES_CODE_LANE_OFFSET_TX1, 0x11 },
> +	{ 1, TXn_RES_CODE_LANE_OFFSET_TX0, 0x11 },
> +	{ 1, TXn_RES_CODE_LANE_OFFSET_TX1, 0x11 },
> +	{ 0, TXn_TX_EMP_POST1_LVL,         0x10 },
> +	{ 1, TXn_TX_EMP_POST1_LVL,         0x10 },
> +	QCOM_EDP_TX_RES_ENTRY_END,
> +};

This becomes hard to manage. Please use ops instead.

> +
>  static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
>  	.is_edp = false,
>  	.aux_cfg = edp_phy_aux_cfg_v5,
> @@ -679,6 +706,9 @@ static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>  	.ver_ops = &qcom_edp_phy_ops_v4,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
>  };
>  
>  static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
> @@ -687,6 +717,9 @@ static const struct qcom_edp_phy_cfg sc7280_dp_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v3,
>  	.ver_ops = &qcom_edp_phy_ops_v3,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
>  };
>  
>  static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
> @@ -695,6 +728,9 @@ static const struct qcom_edp_phy_cfg sc8180x_dp_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v2,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v2,
>  	.ver_ops = &qcom_edp_phy_ops_v3,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
>  };
>  
>  static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
> @@ -703,6 +739,9 @@ static const struct qcom_edp_phy_cfg sc8280xp_dp_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>  	.ver_ops = &qcom_edp_phy_ops_v4,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
>  };
>  
>  static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
> @@ -712,6 +751,9 @@ static const struct qcom_edp_phy_cfg sc8280xp_edp_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>  	.ver_ops = &qcom_edp_phy_ops_v4,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
>  };
>  
>  static int qcom_edp_phy_power_on_v6(const struct qcom_edp *edp)
> @@ -913,6 +955,9 @@ static struct qcom_edp_phy_cfg x1e80100_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>  	.ver_ops = &qcom_edp_phy_ops_v6,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
>  };
>  
>  static int qcom_edp_com_configure_ssc_v8(const struct qcom_edp *edp)
> @@ -1045,8 +1090,8 @@ static int qcom_edp_phy_com_resetsm_cntrl_v8(const struct qcom_edp *edp)
>  
>  	writel(0x20, edp->pll + DP_QSERDES_V8_COM_RESETSM_CNTRL);
>  
> -	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_C_READY_STATUS,
> -				     val, val & BIT(0), 500, 10000);
> +	return readl_poll_timeout(edp->pll + edp->cfg->c_ready_status_reg,
> +				  val, val & BIT(0), 500, 10000);

This is already a version-specific callback. Can't you just add one for
Nord?

>  }
>  
>  static int qcom_edp_com_clk_fwd_cfg_v8(const struct qcom_edp *edp)
> @@ -1074,8 +1119,8 @@ static int qcom_edp_phy_power_on_v8(const struct qcom_edp *edp)
>  	       edp->edp + DP_PHY_PD_CTL);
>  	writel(0xfc, edp->edp + DP_PHY_MODE);
>  
> -	return readl_poll_timeout(edp->pll + DP_QSERDES_V8_COM_CMN_STATUS,
> -				     val, val & BIT(7), 5, 200);
> +	return readl_poll_timeout(edp->pll + edp->cfg->cmn_status_reg,
> +				  val, val & BIT(7), 5, 200);

The same.

>  }
>  
>  static const struct phy_ver_ops qcom_edp_phy_ops_v8 = {
> @@ -1094,6 +1139,11 @@ static struct qcom_edp_phy_cfg glymur_phy_cfg = {
>  	.dp_swing_pre_emph_cfg = &dp_phy_swing_pre_emph_cfg_v8,
>  	.edp_swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg,
>  	.ver_ops = &qcom_edp_phy_ops_v8,
> +	.phy_status_reg = DP_PHY_STATUS,
> +	.tx2_tx3_lane_ctl = DP_PHY_TX2_TX3_LANE_CTL,
> +	.tx_res_cfg = tx_res_cfg_default,
> +	.cmn_status_reg = DP_QSERDES_V8_COM_CMN_STATUS,
> +	.c_ready_status_reg = DP_QSERDES_V8_COM_C_READY_STATUS,
>  };
>  
>  static int qcom_edp_phy_power_on(struct phy *phy)
> @@ -1128,7 +1178,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  
>  	/* TX Lane configuration */
>  	writel(0x05, edp->edp + DP_PHY_TX0_TX1_LANE_CTL);
> -	writel(0x05, edp->edp + DP_PHY_TX2_TX3_LANE_CTL);
> +	writel(0x05, edp->edp + edp->cfg->tx2_tx3_lane_ctl);

This one is almost fine.

>  
>  	/* TX-0 register configuration */
>  	writel(0x03, edp->tx0 + TXn_TRANSCEIVER_BIAS_EN);
> @@ -1166,13 +1216,13 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  	writel(0x00, edp->tx1 + TXn_TX_POL_INV);
>  	writel(0x10, edp->tx0 + TXn_TX_DRV_LVL_OFFSET);
>  	writel(0x10, edp->tx1 + TXn_TX_DRV_LVL_OFFSET);
> -	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX0);
> -	writel(0x11, edp->tx0 + TXn_RES_CODE_LANE_OFFSET_TX1);
> -	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX0);
> -	writel(0x11, edp->tx1 + TXn_RES_CODE_LANE_OFFSET_TX1);
> +	for (const struct qcom_edp_tx_res_entry *e = edp->cfg->tx_res_cfg;
> +	     !qcom_edp_tx_res_entry_is_end(e); e++) {
> +		void __iomem *base = e->base == 2 ? edp->edp :
> +				    e->base ? edp->tx1 : edp->tx0;
>  
> -	writel(0x10, edp->tx0 + TXn_TX_EMP_POST1_LVL);
> -	writel(0x10, edp->tx1 + TXn_TX_EMP_POST1_LVL);
> +		writel(e->val, base + e->offset);
> +	}

Unreadable. Once we move on, these regs can be used to write anything.
If it's a really one-off for Nord, just check for the compatible string
or do something similar. I'll check the other patch.

>  	writel(0x1f, edp->tx0 + TXn_TX_DRV_LVL);
>  	writel(0x1f, edp->tx1 + TXn_TX_DRV_LVL);
>  
> @@ -1184,7 +1234,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  		cfg1 = 0x1;
>  	} else if (edp->dp_opts.lanes == 2) {
>  		bias0_en = 0x03;
> -		bias1_en = 0x00;
> +		bias1_en = edp->cfg->bias1_en_2lane;
>  		drvr0_en = 0x04;
>  		drvr1_en = 0x07;
>  		cfg1 = 0x3;
> @@ -1207,7 +1257,7 @@ static int qcom_edp_phy_power_on(struct phy *phy)
>  
>  	writel(0x19, edp->edp + DP_PHY_CFG);
>  
> -	ret = readl_poll_timeout(edp->edp + DP_PHY_STATUS,
> +	ret = readl_poll_timeout(edp->edp + edp->cfg->phy_status_reg,
>  				 val, val & BIT(1), 500, 10000);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
