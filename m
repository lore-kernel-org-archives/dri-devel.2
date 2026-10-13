Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61682CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE92D10E6B8;
	Tue, 13 Oct 2026 10:27:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4040F10F6F4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:27:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D7OXsP015278
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QGAQ+SPDmvHqJzwZscytDbFj
 nJRM1Cy8AUNB2ckczKY=; b=GDoecBCKYq1UclhMIzU6gAUGU4jyMdg/pjj7HFCh
 OSBVOjrQb/rnKJefWlP2oCTz5X84+x9Q6kLuzN/zBFUJwPFcm6MuYB7kHM0GrNrE
 1OBV4u+hpOsd45NiSUbyJv5UI8nocTMzwD6+5oNVw3FZbRWE+/J8OgwV0FOY1jqw
 DVEGmXldwF483UBV7CR6pX3Sv/qNnNOKuNLOKvbzPG5GoXntVR+9mfzaMhkG4NGZ
 g6SNw3HglhZj1u737cu+EbIsUj67YBzexyOPv30e2WECOTAa6KsLuLxcbXMKSLTZ
 OsVrTeHs+rllxvCsom40XvAwN+JGyK3hh8GQJt9Z4mZRuw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugrvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 10:27:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso307924785a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887257; x=1792492057;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QGAQ+SPDmvHqJzwZscytDbFjnJRM1Cy8AUNB2ckczKY=;
 b=O+gAzv5l+4Q+YMDkJDUHh1cROpIr8+axNtHM9qd0W/oyG16ED+3ZfFmnkkKz2PIFGR
 Fovz5z2oOyXfIbmIemqoCD+lgkCZY+jiIshEhUE05c+QFeLSvUlj4dskc5wPqzhcEJBC
 8aj/1zeb5kJjjtLd/Gzmc26zFQIDoINnjZ9VnhcCKLb1o/jRzwvDnEe+M+30TJBrAABs
 xnYErnuKhLzrmxk6cPKqzI3KeBh1YUE5GSSRSp5fURnunaf4MnVmkGSmQzeNwkP8VUXF
 1r6sSnN5WImlXEC+/NgcbOIOHnqUZDVRP/XrDsMKwojnuMUmEWzerECFGa96fjMx2KAT
 E6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887257; x=1792492057;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QGAQ+SPDmvHqJzwZscytDbFjnJRM1Cy8AUNB2ckczKY=;
 b=gRrQT8GL9l6QLrq9NyvfK6rq1WcVt8gJP7cf03RuNyO2lzpikeJx+TVdbF/c+9qSl/
 7oqn2taJJZCpumagoLsRm/1GuzLcIHb974LxHh/6mNSag35FCw5lRPDvSA9zi7Eqw6iC
 zZy9QhPRwnOE+A7NB0Rkh2d6aCUDqzCxc25PwXGi8JLNGONRJIdeECB5lk5RpWcTzj1o
 BuDgzKv2IMFpfwVNu7lQRCTCw5xAvVqW/X4OvA9yf+V/zudEZIdHKLUyECeea67JrSwX
 6siMr0pR7W0mGXG0lLK5Cn9tpRHm4NJaHNvtDoTMohaxUA8BV80+BxsxBF5H3NabCuhs
 sJdw==
X-Forwarded-Encrypted: i=1;
 AKwUvByjVf7apMuKbO90yArA93tyVDf4iX9Lfj71dt9ROrxsBU4hXk9vuiVNaOxS8JMA0atEKCNRfkA9d2Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK4J5ZikdNjXaecy/UZCnu47+ECtMzilUqclYz3yzd372bWw9ta
 aTF+zocwVQrdpv8zwm+AbaW4ec7Cx2IsGugMTiUpq7Ja76qvp1Vvzz6qtSyzSy1k0XmrZnN1ewU
 vzq6bc/xXfcYCJGD0hY28axklgoxBx3bAjSQr4+qAMA5GwRFbvFUVj1Ko10epQdzYzFIECBs=
X-Gm-Gg: AYBFou3ONaE2OVPhKBFuvRBzUTOTj76GF9Z0DZtKICd0mJ1eUoDTsFKtGRWvLp1OowS
 p2Ki1zxJfc+6BJs+YP7bUucHv1XjFFm7kk+65TArt1QZ7oJwo4qwvmvvfC1OhHuECvSkVWK8m3e
 nbQzhG344dGMDj4ySkpNW5ZF/icoyici2uXD9ZesAB+DlcUA/9wxl8QfcuaoCISQGEOPa9+L97O
 Rk/wCIJ5Z+5Lgq1GmnYz2BmBbvDaTvxoINr5WDMc/8JCkYD/E6bJGLNfBgQ4P6HFZf2y67cFkYz
 6C7DvK0hMJEG6n4DL7YBKs95InL4B3Hsg2v7EH+rGJQGeZef49LEsXLuZ+ABNL/qFJ6X4jQBojZ
 D0aM2wCxZwwdlrviMMEvv9zHAEEBQTIc0ajy7DqCDfGIGBs9FxlI8jRJW9cuRUN7nfbmOFT4mA1
 w6pIjW3Y7djCQj
X-Received: by 2002:a05:620a:2691:b0:93b:d7a2:dd2c with SMTP id
 af79cd13be357-93ebd2823e2mr1854076385a.60.1791887257363; 
 Tue, 13 Oct 2026 03:27:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2691:b0:93b:d7a2:dd2c with SMTP id
 af79cd13be357-93ebd2823e2mr1854072785a.60.1791887256775; 
 Tue, 13 Oct 2026 03:27:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bce8aecad1sm2774560e87.8.2026.10.13.03.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:27:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:27:33 +0300
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
Subject: Re: [PATCH v2 09/13] phy: qcom: edp: Add Nord voltage-swing and
 pre-emphasis tables
Message-ID: <ftif4r4l4orj7zgvssjqdtmkfj4kfahbxjx6kh4fo2dve6o33j@johl5kwn7cuz>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-9-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-nord-drv-dt-v2-9-a2ab9af954d2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX2rhFxMwxVS0Q
 1vGTQrRfV0Xc0S3LV3iTyQPa24dDiaZWB9qrjuwmT4tOVUrU8iBhgKWdyJj6cHE8xSr1984RoIF
 Mfj+kgyJ5BcZrASY6vns2p4w+FMxA4+Jaevj4KquqL2qGL/dSeVSMVG15KsN/MPJKU/2SAeeWLh
 qvwZdepP+rhHIV07JlbCQN2mg+cGdPwd2rh04dJXZl+CeLY6rg/OEDnXkPVoySw6jOrpSza11b+
 6CR9t5oEaQnuRWjfVZCmd0LXQevEzzh86BWnDOq1w8+SbqiZY/ZOSwQvEWi20NOk/MeO4ziKJde
 mqKrs0Z5WVE/pZUWC5DHIAVCNRgRzSLW6sZpJDKy/c86AbqaqYVqWObiNvK9AL9boHcvhgQD6f/
 Sc74+KNSmRqKpPXby1oz17f6vWnTMGhCt1Q3HGin87z/MndmUXnyUC7z/KIVJ9ZEmKl6+9ARrWv
 QGBY/B27qAIzh8TMpCA==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace079a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=JfrnYn6hAAAA:8
 a=EUspDBNiAAAA:8 a=HDF95dwk5MVqU-wvWFsA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: 57yg3KTbW8Fr3XoaxKnq_nt63FCrtieS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX4rDXfac9CsBW
 UDD5ABAlHJP7iJ12y0XAWXK5hDRog7MtAexvEvc6XEcCPortUKeanhnWOGrVr/VkZGzy0IPH+La
 uffbZAqJTxPJ9m4oJMZBc0HuGl47BfE=
X-Proofpoint-GUID: 57yg3KTbW8Fr3XoaxKnq_nt63FCrtieS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
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

On Mon, Oct 12, 2026 at 07:02:19PM +0530, Nabige Aala wrote:
> From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> 
> Nord requires different TX voltage-swing and pre-emphasis levels for
> both eDP and DP modes.  Add four pairs of 4x4 tables covering
> RBR/HBR and HBR2/HBR3 for each mode, sourced from HPG Tables 2-2,
> 2-4, 2-6-a and 2-6-b, and wrap them in qcom_edp_swing_pre_emph_cfg
> descriptors.  The eDP RBR/HBR swing table reuses the existing
> edp_swing_hbr_rbr directly; all other tables are new.
> 
> Assisted-by: LLM
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 64 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index c5df1086607f..c63f721702b1 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -1538,6 +1538,70 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> +static const u8 nord_edp_pre_emp_hbr_rbr[4][4] = {
> +	{ 0x05, 0x11, 0x17, 0x1d },
> +	{ 0x05, 0x11, 0x18, 0xff },
> +	{ 0x06, 0x11, 0xff, 0xff },
> +	{ 0x00, 0xff, 0xff, 0xff },
> +};
> +
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
> +	.swing_hbr_rbr		= &edp_swing_hbr_rbr,
> +	.swing_hbr3_hbr2	= &nord_edp_swing_hbr2_hbr3,
> +	.pre_emphasis_hbr_rbr	= &nord_edp_pre_emp_hbr_rbr,
> +	.pre_emphasis_hbr3_hbr2	= &nord_edp_pre_emp_hbr2_hbr3,
> +};
> +
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

Double empty line. But also these tables are unused at this point. Why
do you need to split the commit into multiple? You have performed
refactoring in a separate commit, that's good, now just add support for
Nord, squashing all "add Nord foo" commits.

>  static const struct of_device_id qcom_edp_phy_match_table[] = {
>  	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
>  	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
> 
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry
