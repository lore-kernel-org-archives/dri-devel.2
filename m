Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1570CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3FD10FF87;
	Fri,  9 Oct 2026 08:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qz91mjRH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFwPKVoB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC4710FF82
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 08:23:07 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KNgf1223232
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 08:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iNcP9lIMFixukf9jSoJkK4cx
 lZP96poOCV/W1Al4rms=; b=Qz91mjRHyHCL8vofDqUgYO+5zTg3hjs5dCMg8J+f
 P6+a+7XbCDIIgLNkKRZgcg/VUykHcL6tlQqGSOTT0YqIy4FX8njnILTnBL5cPi1D
 E84JT1HgPDixSuu8MTRbyzHF0XxgvoyoLIUEFbdWz0MvHDDQr3obh0qjIu0VP52f
 oKc/FPHzliL7OWWg6m24r8io34ATeu8Hf/Ieexenph2oLROrTTdtNjdjqOx98rNE
 Hsl5yLT7Yjt7L/NL9WsiE4UpZwmJ/Ri4Jjjw9kzX143VyCGNhm2GeE+c11IPpu3a
 DsxdPIcCTqFRWD5/1cGPJJCCFCGghkZGlV6Ev5jlzNWBYA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkaju4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 08:23:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b52dc0daaso13947166d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791534185; x=1792138985;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iNcP9lIMFixukf9jSoJkK4cxlZP96poOCV/W1Al4rms=;
 b=MFwPKVoBzH0JyRGstIJczMCjha0Q4j30VEKvQ0PVowNDJVO9sh2sMSD3Jxbt39JDss
 nTV+Vb2vHRumiX/5WVjsiqYNiU9EqFtr7RWEwHvcf5FWHy4iDxx/JDJAdtOg144GI332
 QkSsW5aXMt3pVd39J96CLqIztxU8IsB4378DiEqx44wcd4j6Sr+27YEJCQJibagv3bVZ
 ESMqacNvrqic+h8/pYh9pEEZ6V1zbAuqvtzG9on1OPv1lHCOYxLtrdUb9CcKB9wJbKsg
 BsddqlrzQMmGjffp7GVcuoAYX+qEKe4nuHs+dSSnjoPjGKxWKQ1xP/SrQ4e8dOFIKZB8
 uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534185; x=1792138985;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iNcP9lIMFixukf9jSoJkK4cxlZP96poOCV/W1Al4rms=;
 b=XO2WSzK3mj2l0mmwP0zEO/HKmywrFXMDLxMgrfAyNBcNbezxfVynazw1E6mUFTXdeZ
 9vRu9LY3KxCXcpjxaQPP6W3bTILtPbclgBJShfOwI7Mq4CTJgV9kC8GoprsqZx3Bn6Nd
 DfA9MhCmxMkI3/sMMWmHlrn1P1jUO620FLFmkOxxNjTFqk+gSGAA7mhLtB6+OTQk8okp
 fTGkCRwSPgEeq222YPnezdQp66tMvcbb9Z2TqGIBbGDvp8BINocunLdsP9XsUP3rZwqE
 VwoEzrTPoGOfawi+aT4Rd6882MwA+opmm1jsscMt9s9ps2EoKNZQ66VxSTWwELd+1sIe
 J1QQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt1t26ODy/OEK09ICVWB/Hhf4oG1YLQVfp74Ss7JKwbXBfjf5M3ZrQqxF/HqIPe6IIEwHsdq8SnTE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kz534Z6yu0Rb6OnzjRLy4i3xDmAFql/pdWdkXENp+ukb8elfhe
 1PTSN1yk2uTX4phw5yh+PCETkLtB/X/aglfsY9AHydvG992Q5Mi4rJQy6C3OT/zOQrDGKdjqkZu
 ssi6OCi/2gKk16nrGMWM8x0rQdqgwrhWtf3XjlXVDoN8ngbPxyUClUj2/IbMf+zH55kqI7QU=
X-Gm-Gg: AYBFou2PmExYQM63YP/D7EJZDjVP0YglhdM2SSWxChJpdST2LOdRVI6vxz9aJl3y55q
 ndTgnDRPqU84EiGC5ssFarZSF7acyu3Xazv3o44sQpS5EYNd0SDh2Bzdz4CFyoypww/GyBxedRe
 sI46lj2ax3RF6jLGKfSeAMFyMLyNh4m+mM4vMx1dWP1iI71HOqMqTfzU2PKBV3cUTM5Fe4lXBZm
 7igtFfCkdcBIpPEj4nh/UpWy9hb7Qxgao0IfT5FCZ+VXyc00hVgoJCvIMh/GXcPJ5A3kKvl9RQj
 Zhg7KT7H91c/anKSSYcpA7MlaLsrtDHrAYRNdY6rjGZmYqsa2QjXOarwTTl+oOsoizwEKTdrcu7
 m+uN0IrNBmyV7KDcyBuc=
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id
 af79cd13be357-93ebd24ecabmr153056585a.42.1791534185557; 
 Fri, 09 Oct 2026 01:23:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93e:5dcb:eb9b with SMTP id
 af79cd13be357-93ebd24ecabmr153053585a.42.1791534185087; 
 Fri, 09 Oct 2026 01:23:05 -0700 (PDT)
Received: from umbar.lan ([2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a9c3cd783csm4527711fa.32.2026.10.09.01.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:23:03 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:23:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>, dragon@radxa.com,
 Daniele Briguglio <hello@superkali.me>
Subject: Re: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
Message-ID: <p34hqt4x5pthm5ailvwvde4le3ubhcsxsiixi4y4f3ma2qehrr@54mthvv3carp>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
X-Proofpoint-GUID: Xr680VgaJA3FBZB6IYZMka6px05IFZMi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXxdxP7+Kq/Efa
 PEFmcLvlGvvbqebDhDaxAnaAzruHeITNYHRIYiEonzxbpO4EpX+e/ypYIxlANctdH2UBt0xNrku
 3seKyrr2WG2Forvg3jLaKB6ZgwxoUDc=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8a46a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=6mBZQueXRAtxK1RCuRwA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX8YojKUKoCqbn
 X8zR1UEs4/QokgW/av2VgcyjHt0bxfkfQuhH4CLPnkV9hz4T8bBLQ0wqNCI3d+7hKnEAvJ3THZK
 49bNRi5aTlNhqkQ9KdoeB4Gk3X8ZZJ7mAsrwTe8Wa4nRFhftrfNvwt7x4LsEtKZaoTO9CXOlH3l
 bxIECjDAMNsksNZHWshO2ubi06q85gbteLtgnOERbEW1Z1ljDb+u/ddSKtBU1D3Akdohzl2hdjV
 FqelQLZGCXQ3b32MZDMuT5zbKAJnd4xAbibWcoN0PvZHzd21K2qmm4yg57fZeh7DTBGnol4vtG9
 UQy7lEkg/u+za2xyE0RHQoWYk1fdvonOdqrLKVn/Af/nkG2EKx1eEECcnXAegekreouhEpxyM3C
 bAimpAf89b8n59KUksI/5edX+1FTV24oX4+agWdN8Klj0PQoCbZPAGqkGSkDVSNLnBOpt1xOuQh
 pKbo2pVYBNZNC8D6qow==
X-Proofpoint-ORIG-GUID: Xr680VgaJA3FBZB6IYZMka6px05IFZMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
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

On Fri, Oct 09, 2026 at 03:55:07PM +0800, Xilin Wu wrote:
> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
> 
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
> 
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
