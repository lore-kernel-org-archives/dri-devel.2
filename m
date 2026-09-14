Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544CFC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C7010EAA7;
	Mon, 14 Sep 2026 00:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPjvea92";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/cUAqAK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE7D810EAA7
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:49:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06FC93187576
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=krxzRCBNf6IAYBv92gpHf6Fb
 vyiCF798aoMw427kF6U=; b=KPjvea92vvXTcX6alUjNOQuEyvFCVPEEGPCjbaCV
 ElczueZvP/ymcuOD/W4YbmOOVtZtrXXF6gLnUqg58NX2VuW3qv/3pWNgqRzOUhqI
 QD64TfW3Tw1CLaoQ9iBIb7ftxX+ADJHmPbxrPMnBRbdXiuEKJsYVOaLyJC1QTlzQ
 RAAQJDEAe3k4GqQhymLVai7bsmvWQui536QVSQyviOq9DTHPN/DBvVUcKqfk9k5P
 s6xoQX7Ei1wyN/pT2V3sAbIFyn3N4A1DOirQAo/DPD9HdPxg9X58V9hLqBdirxbq
 IxRdZS8+/7TpVx2yEtcdv7v5teNIRKpKwKhfyM3phkx9Hw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d4f0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:49:48 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-78d25a8ff32so770006137.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789346987; x=1789951787;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=krxzRCBNf6IAYBv92gpHf6FbvyiCF798aoMw427kF6U=;
 b=Z/cUAqAKkOCtd6zerlYC12yDJO1Fef59iAtmjxNBHdhg75UeUwOA1J9RDp/H0Mw/U5
 RGp7IB890WY8Qour1IKGF63nQl62c8zpZ5gZtVIutBsI5N5NbHsHaKcd0oIULOSKYyM6
 rP5tsQ9q5yAPl+lp+erhk1Q9DTntP0HtWBqv2AmvukOpusk33Y2CE1Mv9r4UKXPGDngL
 hZxY4401AA98yFwPVq6zNEG+rXUukUBOxrTSwDKaUImHmiDuuFoztcsdgtJAeG561IjY
 1jc9LMpJ7tjT+A4HwBTNnBLtgG+F00MfC9lCMdSI9fCv6lFIaQIVkAK2ZhoBIp5kbidG
 PenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789346987; x=1789951787;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=krxzRCBNf6IAYBv92gpHf6FbvyiCF798aoMw427kF6U=;
 b=B+mhxt2RUPrBvX2MPkDx9BtwBsOf/eSKA7hmkUK/zXOBMylzGE4kO8oTZ2kjeIUYvm
 TQSzD558gyNPz3gHcMwZUowy3NE69JctPcMCW9Avza9F+EoP5zxYs2eaXsF2YQyZCQAS
 VVQNqOhpaieADKOKvWEKE/Cat6gn4rLuIa9MJT43IrCYW3VoGTHzeUt5y9Cp7o90MQCZ
 gIXxY8/KmUrfLP9JZNSzsayb9VE/MMBPKy/tmRvIx+zAZ9W5q5V+V6vm31o23wvEOmV+
 ZSLddoF+mly+jmKH3A6FUYH7zUNtjfTMeqXmThcvScyFAlji/yVa30L2z+2sRtb9brhN
 srQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrMt+sXXzvrn+lETaFdXbr0MD2qd77fqk5Z2pcHjoZb1jgEAGPkbZN7VzBMSa18SPxWkdvG+1gDyg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mG5u8HYyUsRIPfVcS1f91+PZOdGq1FRE9zHYB20QozmLC3gm35
 1Ff7Js0dm5QTdktVQHhvraiA5NAbKilEO27XfeDVF1dmoh31YM0Csv5hM1+hV/VMX1RSAwWK/aw
 ZPVj1mztAGR7wcnY18Qlln+jFWFxbWjLe3E9q+FuD4fdjsOIe/+w+FzNaJLWuINQU/Dwx/yXXYs
 NupdA=
X-Gm-Gg: AYBFou2DpeNB6cSJsBSpYxK4D+FOhb6gIXdwAExoq6ed9qOsLDdcsaFSpkYXZK/EZla
 diDh3xzREFEeG4wlFZEH9noKzz3uMB7BIeyg5saFlOPvW9Xqmmd/uxcS4Wbxj6GQGv+s25nGZLz
 u3OiulNbuhF+6wKA1B/0nSCtycwNvX2W2VCvLrfwzXEfH/4KDl+kQRm8sgdzt+514gcATAF5hCP
 6gcn+DrVmH2YmL1V0f3Xt/VsmaB2rlwTut7lfABrVFmnm7QpOgbK2ZgSDaJ1IDad/FObr0avrLI
 /rbux51/U9nRiXQQIRn0AHrl5DA86bXRZFUdgCls/q8XV6hYfVie6e37YFlWYx87z+aBC8WSgFC
 PF3y+jZoRO+HznsT6kOocH6/n05XOG9JDRh0Sy0IF3xDssLB2OqbGKXIsDPeUcJ1XYNoTDQ8mI0
 Tk19+dxrz1VBkr
X-Received: by 2002:a05:6102:80a5:b0:795:87ac:9cc2 with SMTP id
 ada2fe7eead31-79b58d7558fmr114320137.4.1789346987276; 
 Sun, 13 Sep 2026 17:49:47 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:795:87ac:9cc2 with SMTP id
 ada2fe7eead31-79b58d7558fmr114312137.4.1789346986825; 
 Sun, 13 Sep 2026 17:49:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456c06sm2106722e87.28.2026.09.13.17.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:49:44 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:49:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/7] drm/msm/dsi: Fix indentation of if block in
 dsi_mgr_bridge_mode_valid()
Message-ID: <hqm4hn56tewbc5xexxtpyiijcld3sy2mt3e4nulwepms44imq7@ke2lzseaieqq>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-6-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-6-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfX/+JZGIwB2gwQ
 IlWFD24QVlKRTATbzRInbXzn0muEm67VzyToCjyse4oq7LsFCEVVwfHwODN8QAuAELAXMWaJBUz
 +tzETUbO64W30c0Jbz7WNa4KqPAUwyw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfX6Pbq9QLDQ6Lq
 U46TS7ee1Y8iJtupc8nTQ+g7WG0UR3g3FdsKfAxtcO6ncXAVGb6Q/iult2mKEYOSXy/6940eaIH
 /4MN1qCGHSgFishhR3L6kNM65R5BLItxJNyfZVgZj1U3xcHmfh9wGfXKpn8kELeR/HbV0RwsZ97
 0EwVQrQqnGqNaiBzcHPHLjc4gGRIGWB0dSQA2e4Zw09qDbv9QCNHsXyPf9fZgMD9ghm/UUORXQz
 zH9RDv3t/HtNIGrtNqwRK+d3zm3CXbW3h27yjsyOd2icPs1U4utkYAv1VUIJ+nPnLX8O4i19eC8
 kNEKPVyYkItyekaYreUjDkFsVZX9g/rBRkD5beNBESFGpGP9hxYe8+mD/Q/Foyp/hEMrZo08HF5
 PV2VyUnHoTLIEBWYncBHv00a0XT/Qwaa5XFnXx0pdDMr1A0M+A+JX0hdYgyEdtqZLTZ3S8Vr/gJ
 tcoJmuqPzdT9WPQCokQ==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa744ac cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=oMov3bMtrqd5QQYwA5wA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: eThziPHszU_PLEb4RY5-2s0AcuJi5r64
X-Proofpoint-GUID: eThziPHszU_PLEb4RY5-2s0AcuJi5r64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140008
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

On Fri, Sep 11, 2026 at 12:29:39PM +0200, Krzysztof Kozlowski wrote:
> Correct confusing indentation within else {} block in
> dsi_mgr_bridge_mode_valid().
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
