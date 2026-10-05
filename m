Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72790CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 01:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE4D10EB69;
	Mon,  5 Oct 2026 01:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvoqzNZd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULZZGCC7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7D810EB62
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 01:06:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695102aN291392
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 01:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=57RP371wUSCZPw6u6uxhcm1e
 ciD0zGPP4tFb3PYgbLI=; b=PvoqzNZd5o6PSmM8Cn2262wbRN5h7S1ueXgX376k
 QilApoBgoEFeAXV3zA0jlxlL7dLP8ORCvzcPLb1MVuEa6ZaLbF4axqleA5yth53p
 mcTrxzaPcuAl6u28Q4+Xx2QW/XCBouMxcUaespB3fkj2WV6hpka7K3AFI+8J1UF3
 Q9Zp4Pm76GjAZ6D/KUv+GyMzGE43parIPH836FLbZq9F3Zn3251ALSXUvdWeAdct
 ml5L5mYgOTD2yolt/1+mZ7IQBxWHyxgc6JTWnfGLkQASDXfC24qq6BP7mKawD7Q2
 txc+Ssrz3o6TrxlizeHBDh5FXBxBTgfVfCC+nl7T8iE9ig==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs0aaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 01:06:15 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5df0d59528dso279089e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 18:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791162374; x=1791767174;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=57RP371wUSCZPw6u6uxhcm1eciD0zGPP4tFb3PYgbLI=;
 b=ULZZGCC7TE9Pn83UIhcxeMXo17LYsRb7tYx5HMdItGN7Oi1ke2DV0mGkW8AhBEdTE2
 7b6kWrv15T/6xhSfAuuKtMUvsYAhITCUyEXs5GiLYrSphcnim8mcv3Wn5XKQVSGvv7DN
 H9ijf6fvU1quxjXGWukNy/0sgoWVKhXJqfck9BmVQEpwFgXU/znCvrdYzKjKyPM5qccb
 fVoqBFcZGFbO9wQAIARLffgUbaij12gf8rOPqWG7QsLTHMzueCipYK3bgqQO1XpJMKUO
 VSOyiOv2qR0n0sPobWcwOUGlSlex0naOuv/XE4IxEmBFFq64N0Q/zsRa48eMZ2dYuBhQ
 K35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791162374; x=1791767174;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=57RP371wUSCZPw6u6uxhcm1eciD0zGPP4tFb3PYgbLI=;
 b=izL+5MNR3rOvXYxZU/0VwjlZ6NoqsWk4cjwYyGiRr9FVOojdQy8mvYqQBeeMszl3jY
 tkx873D7Bex7Tw7CqvO3ejZnhAxIIH7JP+wacFjIwf72e3U1pbl2aGml3iuY1FjIj9uf
 7D2gy93edksyVzEXD302T9UnG5VyVkXcIUfSC/2SyzwHKMkndBpRQJb6UJ0VJP2SRivO
 p0znb3+GtTmIsVyJaGdcD0O79oqE+h26FOpJIL6dB4CpUCJsijWtgtfNVpNlg3byF0rh
 SJDcFHUYlD+ccaHlmHACoCGVSn9F2cfNjzaaIkOE4QWOZmjCAHna6IZEeqPHtt4wSFcv
 5qjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxppG5g4jL5rli1oqFFRox+7gyQOyPwbhEqGkwz3U1JuV6TooCQCYp919RaFm76QChOTf2yAu67tdg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIw6XMkwCaXYCfofp1wiRybLPqjq0H5202gNRJYO/sLh0FWaRAl
 Db2Fa7yuwrZrotWxigzKNKhm2EmOGWA5ZJ88f2mdMG3fP1YHunddF5+6rcS5oi7W6syf/E4ftT/
 tmw9rsLkN9BY7m4anRU5gMKJll+mSp2gJXFhu+67jZOnlAUMCfPkzh1Ywz8lmnxoXtsV30gs=
X-Gm-Gg: AYBFou1k/n3FsfuezxEEoh94blab5ZvoOyPYJPVsHTJ2zoFAWEpfE3agrAe0eJhQgmF
 +hoB8tHmLZv1IelMMX8I3xXHHZKiqTofaD6Tnu2KfEvuM9/41+ECBfQX8WOXU3V3xqUHuXGIfQ1
 y+bfQk7Gd+vnDd4MG9k5nMaiAB0oIN3FAWS/IXgfzpQHO+Zy8GCrVc7rpILriNU6jNg9WwvUHfe
 Vk3502ARJrYCnTmkEW+W73Ah9LUQerTeBrgujpaQlInD0r+/P9+j2b3r59MgmYV+hwVIjyLz1JU
 tMTSitemKN8GgU0d4kGrg1YDtosL3+7xP2PQJcHQRbj6VG73IJ80SIQpnXX1wOBphhzYn7enoMq
 sczIaongWGjAyTM7aQUI+3vjJIwgcnH8n1M9168cEv+ElbbYjf4cxc2OzRKWp/yuKUk5z2/PhMX
 Y84Hi6EFz5dOuQ
X-Received: by 2002:a05:6102:449a:b0:7c3:9464:efaa with SMTP id
 ada2fe7eead31-7c39464f65fmr744658137.2.1791162374400; 
 Sun, 04 Oct 2026 18:06:14 -0700 (PDT)
X-Received: by 2002:a05:6102:449a:b0:7c3:9464:efaa with SMTP id
 ada2fe7eead31-7c39464f65fmr744633137.2.1791162373891; 
 Sun, 04 Oct 2026 18:06:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303896sm35500531fa.19.2026.10.04.18.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 18:06:12 -0700 (PDT)
Date: Mon, 5 Oct 2026 04:06:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Add INT2 GDSC to Kaanapali DPU
Message-ID: <epga5fcyf2d3esucs5ulht4s7ixwpwlb35iygz63aqeefruc2m@mwmmkaw2z5r2>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-msm_gdsc2-v2-3-9157237b8382@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: IDjZHy7NnopmOtQ82QTX5agY5wGUhudV
X-Proofpoint-GUID: IDjZHy7NnopmOtQ82QTX5agY5wGUhudV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAwNCBTYWx0ZWRfX5Eh2JstrTLBn
 E8g+4eQanraURR/P5YTW5+CRTBtpSptNvHD9x4uw7QFTWIIyxa2146Pyz8WalRJhsKKHOV5ft2m
 8Nw6FIe+MZyXBxZA8bzcr/57WZEUcpw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAwNCBTYWx0ZWRfX3ELRnUdG4tco
 thGtLwX46Q0tlZl/IyRXvMHRmnEKVZYFLEwhVUjawOgKq0Mt+Ub6DeKljRAe+AgRlDZcRqRkPKp
 mqfAQCOcaHAfk5mBF88Xaso2RZyZgXN3xG9ECJMeBnixSrB25brARX6YFrm1dwHX1cGSqyQ3MWJ
 eatweXKbgwR0VYeWCRYnkCelGB57Vjmp6YQ5BPLv8E5pLw+zCNiHkrPCglYbP/X/VWq4nJYPpSm
 3kwOD+VeAip3FvN+QSetnNVhByI2/TX7LqDMA8WdnAT9/SccLPaYD6UoroMPBY7gQ9TkwaEHg0f
 RSvillEMxJWF8QgKADoGYkyItgRgwesQ31LfTGeusX6Pe1Cx9xaKrRFrDQmusUTlDWtJ0lkaPRZ
 0dipCZBOkRpGlWUsVhEaLHunoT+L+ZHnLPPusE3v8TelEJppTaaScppLifNqRigeP7rZ2YM7kx6
 oxKBmp/7jFs/+3bU2LA==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac2f807 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ES-ZHpzwIs2e-kRI9IwA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050004
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

On Tue, Sep 15, 2026 at 05:27:50PM +0800, Yongxing Mou wrote:
> The INT2 GDSC on Kaanapali (SM8850) powers a subset of the DPU
> source pipes (VIG2/VIG3/DMA5). Add it as a second power domain of
> the display-controller (DPU) node, alongside the existing MMCX
> performance-state power domain.
> 
> The MDSS node's CORE_GDSC is unaffected, since it continues to power
> the rest of the MDSS hardware on its own.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index ace19b8b12d7..b3e3cd1d311c 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -3619,7 +3619,9 @@ mdss_mdp: display-controller@9801000 {
>  
>  				operating-points-v2 = <&mdp_opp_table>;
>  
> -				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +				power-domains = <&rpmhpd RPMHPD_MMCX>,

Should it continue to be RPMHPD_MMCX or should it become
DISP_CC_MDSS_CORE_GDSC?

> +						<&dispcc DISP_CC_MDSS_CORE_INT2_GDSC>;
> +				power-domain-names = "mmcx", "int2";
>  
>  				ports {
>  					#address-cells = <1>;
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
