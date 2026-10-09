Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094FFCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F5F10FF97;
	Fri,  9 Oct 2026 08:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dm+PmXOM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jurGCA19";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0213110FF98
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 08:32:51 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KGkm1625878
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 08:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rTY5MltW4IcuX1L4KNFAaxZO
 ejIWHfJIHVYUxsUR3Lk=; b=Dm+PmXOMTtLCj8IW980LNZDG3w5Yf0q+89TGOY3R
 aWPY7lSPxFkJlMabqTAV+UkQPZoDeaPgEt/BgS1M23hmRelJ/qCLYGqoM3OXX09G
 fJVGH1bk0ozvdOEw+X8TQIamIl4gWOEUB7Ohtt0tr6vCeSEooOJvbDXn5a/83bS/
 fi83Ld2sP0LxStiDSMNakOiK26RH9CdkMVsd2wMRxTHdGKBjuVAgi0VkrM4n+6sB
 O0uUQaAYXh7uyfcTF2tCwFVLVT+le6p7RyF2KU+MD8e79ZCAL0ddiboRuSoBn2wd
 m+PMVUDEUJOGvM6DKTIR9J2CFw2P9mzQwU6URXXiO9QHbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj2nfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 08:32:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cbf2fd504so1125225485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791534770; x=1792139570;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rTY5MltW4IcuX1L4KNFAaxZOejIWHfJIHVYUxsUR3Lk=;
 b=jurGCA19a9y6eAIzFXIC9jPi8yXXPUqko2iDjTN52mt0aP3IFdPXACsY5AcZCjMnQw
 tHArL3inRLsJuAHlg13QBk1r9Ley7jsGnNdKkjooMHi4aCw1eHCM2yRCcL0xRXrmSeRI
 C6JJyN1jguWgruMQc1JIyWdj1Z7QWNf3CLgdKr0j2vfbIWfMEaEMsql5X55htNyMJZCW
 m8X3BnhyxcGPDAkzxfPgZ9Sp7nzEtH9H7fngwgpROwBVMmSGOP0A31fJkOjV/EC8thPQ
 sCY9ZHpxoj6lRNaujtCOL27TBNQxExe/qiavhCHGHV7NIatv+3YTRnebtfZHnBSLayRo
 rk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534770; x=1792139570;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rTY5MltW4IcuX1L4KNFAaxZOejIWHfJIHVYUxsUR3Lk=;
 b=NNX2E9OZyHS0EI/rhhuzezIO7vxz1itHU419Owo663JGjnvEMgIjKvcAMIs7eFm2pp
 FXxqNpapnk2vYCok238phayFWxwt3R1DlgYwTdaVKnS1KHBvCNeCq4y4NOxh6cAVvrae
 bS3a7UjTadEN0+R/7mdK4mvWI2q0S0NC5GawLJXLiOY9J9qEFx5Y6KZa9jsEcJKSCmxA
 Q1FyhMTOPrFgsgTMJPe2jCIn0+hiNHzv4j9TZtNcGYBeGKWBbnISkQS9pPmTGt9l+Yx7
 d4skM22TDdvsRDHVpf0PUJkvxwCdNYWrsz7fhtccW8LDqEWYfgd7M1eUM4MJYR2tyNlr
 yy3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/erhqIunAqNpxei0WD/vJjmsMW3GPWCklRXae1nEVakZo9vC3SMvDmtQlQKxfD3aREEWVkM4LTqk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kVglnSBdBswGmvZIM6K7fLaK+3NML5xniwgwt10sqk6u1b2Thy
 bur7cU5e7UamCkdi2C7sP+cjxxTvgGbwVKZ6Ob40Qr+QG2hkxZbwQssmuF6GHIXlcOAbjYv7pGF
 JcU9JGTMehF1I+emAUJEG+woE83JPHRAc1akXjWA3X7fJCyf94abIbSBnJj8qNriFaCalCbY=
X-Gm-Gg: AYBFou3NX5bvWnaa/HHM4LRMdt1nE1EGFiyy0FxXYhMGVxxErniNxUowr70xoqIi0WO
 iME2ksKz3Ghi2/lvNEKOx7Cgqm09m0QR0nx0PVsLV8s2NUZXW2iJ8uDMHTMP/6kavNV35sq7Z/L
 N+4DqoXQ0Nzvd+eAmMQKR94vPUSirsz/8EtUq/q7E4Mi+JB6M8YljPLo5WDc2oyb5ljT2gV9P66
 JykzseGK0hGlyg6AMUSnqETXAicnNoZ5+PakaxA/u4kh42m0RBd5LKUQzo63R/TxeB5IlRGqqTs
 fWDZod6lDdBmLeXuQgimxY9i5+kvDALy/YfAjwXwaOHmpjB1MIVmGREjdoawax4t5NgZ87+dG9B
 rcnhIt6w9+LG+53Eh7j5A09x29rWds0ZnS1p0OY52ogcVMU/Ld4BblDQjskhU1vhQfENsjQfc9D
 Y2Lp85wVBNk3tP
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:440f with SMTP id
 af79cd13be357-93ec12c4a41mr55455385a.75.1791534770154; 
 Fri, 09 Oct 2026 01:32:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:440f with SMTP id
 af79cd13be357-93ec12c4a41mr55452285a.75.1791534769663; 
 Fri, 09 Oct 2026 01:32:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddeb627fsm436591e87.68.2026.10.09.01.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:32:48 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:32:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: kaanapali: Add DisplayPort
 controller
Message-ID: <e2ng5qasvi7bd2btgbmli6oehn774k57giwzalsyksimgbcf7t@phjas5ymdwgc>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-kaanapali_dp-v1-3-6faeac3a6d59@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac8a6b2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rG78yz47eWoMus8saG0A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: vSNpCqyhIMQ074I0ToqV69DaFY3mIBsb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX5YitjBU+alhA
 JadCtHxvGwFdKxq5xI7imRk01lQIk6uCd4QZkigG/FvrOZTUpIE0zd5YCs4xWKLFiblfHxplU2U
 O1bdRmnsjz6L6L5PmZUPFoIklxESrFiMz7HOe56hJm/9syDwP6xINVqYEtpvQAaZKv65/MJMRE0
 aD2ClQZezhZfqgQ6Hrcgebkp8a8rqfy1xG4+djw+1WmXx8KT2aRFph7k4oNDGmKrhl8u/+KGIkY
 MkBoor+3reoI30iKjgvwmiHFtraPqYvgWQdl3Nhogq6IXaQNPulzsPQB1yiFsZKF2WeWmPEtnK+
 ihIfpe+/YUinWzJAMbCKayjzeRHiaxK6PuPQ64T/ZIgPX5wcBC9CPDBiMehsLOkLP1qu40NylH8
 7NN9uoALBGTMFXGdQvZqGBAwiZB0ci8oEfBBdDrH02WJ19GRXAlakvgx8qMlCLo+ImRVRu/nA0D
 JKkP1zSYALwXeLtH83A==
X-Proofpoint-GUID: vSNpCqyhIMQ074I0ToqV69DaFY3mIBsb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX4VKyMwBffLBL
 KoQd8hBDT0yyGzr1wrCDBNG3SF8gmz8qEYD4wqfttyjJ8OacQbDvDY78KAG4LJJy5dApTjNA01U
 PYqI4Xq4DS01oNRIO7cshqBOMML0mzU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090032
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

On Mon, Oct 05, 2026 at 12:54:28PM +0530, Balaji Kalkonda wrote:
> Add device node for the DisplayPort controller, its OPP table, clocks
> and power domain, and connect it to the DPU and USB/DP QMP PHY.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 87 ++++++++++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index e48a179d0722..155c590c8eb6 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -3565,6 +3565,7 @@ usb_dp_qmpphy: phy@88e8000 {
>  			#clock-cells = <1>;
>  			#phy-cells = <1>;
>  
> +			mode-switch;

Not mentioned in the commit message.

>  			orientation-switch;
>  
>  			status = "disabled";
> @@ -3851,6 +3854,86 @@ mdss_dsi0_phy: phy@9ac1000 {
>  
>  				status = "disabled";
>  			};
> +
> +			mdss_dp0: displayport-controller@9ad2000 {
> +				compatible = "qcom,kaanapali-dp";
> +				reg = <0x0 0x09ad2000 0x0 0x10c>,
> +				      <0x0 0x09ad2200 0x0 0xc8>,
> +				      <0x0 0x09ad3000 0x0 0x78>,
> +				      <0x0 0x09ad4000 0x0 0xa0>;
> +
> +				interrupts-extended = <&mdss 12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +

Please define all pixel clocks that are used by the DP controller. Is it
not MST-capable?

> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents =
> +					<&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,

Don't break the line here.

> +					<&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +
> +				power-domains = <&rpmhpd RPMHPD_MX>;

MMCX. If you need to cast a vote on MX domain too, add second entry to
the power domains and handle it in the driver.

> +
> +				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +

-- 
With best wishes
Dmitry
