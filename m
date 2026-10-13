Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C202CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D8110F714;
	Tue, 13 Oct 2026 10:34:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC8010F6EB
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:33:48 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8V03J922844
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0vSG8Ljr5b10pBXucNpPOPKZ
 f1BmJbl53I6Oq9DgsGI=; b=KJ3Zlk3IhP6BXtSNbZ3XO1PwV4ShC1Vu0zAijAWN
 uWx7u6lZ/QqL7cv59e4KMrQqi5s4pg3RrgzndC7budPfwi6PpOunYbCnaKNP4bHN
 JltrgL0OmfmnXf4r47z5caLBtQc+GejYfFPLw9ZEQBHYQ3aWEPa6aij+UYnRYzYx
 X0TBBilKy44rq7kPfkGV6UIJXQpJvwK6FcmI52es5Glj5EIBOy7xYTwY5IOeDMNz
 3PVrOnJaAGSEqG5/TC0JedcxuXgBe7fqMSYRrjshyuNFIXw8AlHH6r3y+L4J/m4j
 kmnOkMIIdLlenO/2ovmsx6xF/3Nbpu8QiIO3YuUQHqMhtQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1tfnu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:33:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ea9ea9d13so470403885a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887627; x=1792492427;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0vSG8Ljr5b10pBXucNpPOPKZf1BmJbl53I6Oq9DgsGI=;
 b=H9qVmp0htcvOtXvS/kkc+o8K9UIM8JdxdlCTfcbBxlXsJL1r0bdMl4xOhj4T2+B+Rs
 g/1Q6kWZugbOmjI55GtzX6UFczczUE6bVXU37EUcBNMyrhCr487G5ro471Z4NF7TYR2w
 mOuIf/I3nGTS1DBBMDFipdF5wileAVbubpHUlxjoAcOcJZ3lYtnZ8MYqCtLhhgFhz0gI
 qiJiRIXrVLc3AJCvC6lyprRpp/F4Xrzc5n5JjT0MNa5Ph5Fm5CE5RpkDglDx1XyuN8zC
 1PDf78JZFZzD0j3KxdLybttH2qloRD7X7qpXlB5wIauGkUnaiYcNtHdhSBZifJV5g4B/
 5lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887627; x=1792492427;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0vSG8Ljr5b10pBXucNpPOPKZf1BmJbl53I6Oq9DgsGI=;
 b=xU7eczQ3D/exyrtJ13UjSslgYxKNcmNwJH9p9HSi5g7liX5KdyCizDWLCgHRkliUie
 tgr/SFJ1pp3JBvzIMFLsjeJrs59h+QsZnF4UXn6p6Hy9evDG8+WCYvQkzhJPPEzLBkLD
 RlOrVsF/FysoCzV84D+0W/A5ILga1DQDxSzXSbVsej1/pYmDt9Cj2oK8Au44zd9/RsRz
 LiobMkS6O2fji4+DRuVQ0aZgnmDdXC5H0gCUkEROpOnA8as8QO1MzNR6zhYCsIVfHA5T
 hKyRlgnjySRMqxJIgbFlh5Y223Skfz9Xbje+X2e9i1C1XXC4XLIzu2gY5i88c37JPUCI
 DMBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8xyRzBLNxA6Qo4zLdNZJcARgHOuF9Xooag4mTvm9m7qT6cfdtI+GO+lqQ3ezTG1pHRDh48iKLWlI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKrilZE7dHWDKMmRZqOLqOzigecOR9LKWYf6KZrv6gtyQhNurYZ
 H4g/NNRBSYF7GTbrZgzwF5vFAfLASgkiRH20HhYIABB8ukXWhFTViqi1vTDrHHIeloRagqegn1B
 UI57PpL8GFbpfxaEXlCNyUe6J92g6JJUcbjm1Ypxlwy87aFnB4VCAwA92ilbx83B/3OBikio=
X-Gm-Gg: AYBFou3eK3NFg0p5DWAtC4Op6yRiGUc5vTB7yMOr5GB+2eTen1T+QApZ1LU4+VYmOzC
 4zaTCbXhNR8op+W1Ml/q9XcJ1NAlOQFcMX1DWExeuvUHm8agMEfljHxOj31rUcExxEqGwoDx0ML
 ocU8SLOqefoeniLWdrBivYztlNRbq0xkNqFG+abRI5AG2d8NqTeHbkEwzKQf0Bgrekvatg/bqsT
 iFfmqws57nUyVEfVU8vKKGWvtGF8DC3zKOwCFoa8c0aEI194HEEc9gFcpF7y9eJIjFCixh0gNL7
 lREaMEvgyxsP58ZqsqvOB2tohSDkCTsxlVhZK40tvgo12YapWrytuOau2AEKF0dcOH9MXtayc9q
 Xx529wB4+VTIQ7UWywrBZXYCleUKitC4kFzjpEwO0mVBxq5GQOsGOqPAmyhsUTZRLJe8yE1VlGx
 rGPa+Y6WCtxFQT
X-Received: by 2002:a05:620a:2a10:b0:93e:c12c:9b71 with SMTP id
 af79cd13be357-93ec12c9ef0mr1880576185a.76.1791887627103; 
 Tue, 13 Oct 2026 03:33:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2a10:b0:93e:c12c:9b71 with SMTP id
 af79cd13be357-93ec12c9ef0mr1880571485a.76.1791887626526; 
 Tue, 13 Oct 2026 03:33:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde3667csm3574962e87.5.2026.10.13.03.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:33:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:33:43 +0300
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
Subject: Re: [PATCH v2 12/13] phy: qcom: edp: Add Nord PHY configuration data
 tables
Message-ID: <qqfucmyebsvemdr5px33wabsxxq4owozwmxcqu62sprs5k32bo@kb5pjx2m4ucq>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-12-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-12-a2ab9af954d2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace090c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=XaE-5AV0Kcntrrlu8H4A:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: g6mA2PAkzh9YmFKQiHSIbZgLECyWReCz
X-Proofpoint-ORIG-GUID: g6mA2PAkzh9YmFKQiHSIbZgLECyWReCz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX5b+dtlocy3Gt
 LhUSlYUY1JQe0LNJoFQ6anUMoczSifdBn6yPzWNcI+oOyN5K1N7b8QUwXguMmIrkZi/UiJJLv5c
 dxz7nRWNmRhdAsHwQnQABRepvmGFv5I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX4y5Hv0zJ9iWz
 hbyiO8hM/nC1N6RkTx05nZ+reZw6Pq56pP2plakb+XbbTvLBHkOdOfARaYZdDm0tI4JGMiEL6z4
 2HxJQUBU+FwgYW15by3zeQvkQ5BW98K+Liq22iRbeo+bhWXA0wiwBL5gIwIIytKkob/2iS3k29F
 FhOXxjCTH+MM7j5re9cVjNlSpYcpUtA3YHrtAhp4phqA8mEte1S2X676rb7wTqU6AJ6rW4rza/G
 a17pXJJdQhQw3PFNz3oaWKhwjVD6V3wlG/W2tA/TEm9dupOViL/LHobzRW4Y4Vh+wnzHtKf/hcg
 eZZZShvpCp8hfamT44wEzMsK4YT9+Ks0MbC+V2EHOj31bTfDWmidbPXiPKpr0s4H1cp5CghPwRr
 tv8cJVAn62b3mZNOJhOrjvgaQ1JHjCb8F5sdluJgX2B/hXni6TiuftnH+1p9AySZDzwDA0bYviK
 K+ft9HsOcKAaZyheWkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
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

On Mon, Oct 12, 2026 at 07:02:22PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Add Nord-specific AUX channel, VCO divider, LDO and TX resistor
> calibration data: edp_phy_aux_cfg_nord[], edp_phy_vco_div_cfg_nord[],
> qcom_edp_ldo_config_nord() and tx_res_cfg_nord[], sourced from HPG
> Tables 2-1-a, 2-1-b and 2-1-d.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index 3e857d105668..cb5f6e0ae607 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1741,6 +1741,39 @@ static int qcom_edp_com_configure_pll_nord(const struct qcom_edp *edp)
>  	return 0;
>  }
>  
> +static const u8 edp_phy_aux_cfg_nord[DP_AUX_CFG_SIZE] = {
> +	0x00, 0x13, 0xa4, 0x00, 0x0a, 0x26, 0x0a, 0x03, 0x37, 0x03, 0x02, 0x02, 0x04,
> +};
> +
> +static const u8 edp_phy_vco_div_cfg_nord[4] = {
> +	0x00, 0x00, 0x02, 0x01,
> +};
> +
> +static int qcom_edp_ldo_config_nord(const struct qcom_edp *edp)
> +{
> +	const struct phy_configure_opts_dp *dp_opts = &edp->dp_opts;
> +
> +	writel(0xd0, edp->tx0 + TXn_LDO_CONFIG);
> +	writel(dp_opts->lanes > 2 ? 0xd0 : 0x00, edp->tx1 + TXn_LDO_CONFIG);
> +	writel(0x03, edp->edp + DP_PHY_LDO_CFG_NORD);
> +
> +	return 0;
> +}
> +
> +static const struct qcom_edp_tx_res_entry tx_res_cfg_nord[] = {
> +	{ 0, TXn_RES_CODE_LANE_OFFSET_TX0, 0x06 },
> +	{ 0, TXn_RES_CODE_LANE_OFFSET_TX1, 0x06 },
> +	{ 1, TXn_RES_CODE_LANE_OFFSET_TX0, 0x06 },
> +	{ 1, TXn_RES_CODE_LANE_OFFSET_TX1, 0x06 },
> +	{ 0, TXn_TX_EMP_POST1_LVL,         0x06 },
> +	{ 1, TXn_TX_EMP_POST1_LVL,         0x06 },
> +	{ 0, TXn_TX_BAND_NORD,             0x05 },
> +	{ 1, TXn_TX_BAND_NORD,             0x05 },
> +	{ 2, DP_PHY_TX_LN0_DRV_LVL_NORD,  0x12 },
> +	{ 2, DP_PHY_TX_LN1_DRV_LVL_NORD,  0x12 },
> +	QCOM_EDP_TX_RES_ENTRY_END,

As I was fearing, this table does more than its non-NORD counterpard.
No, please don't do it.

> +};
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
