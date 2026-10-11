Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0918CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 06:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EEFF10E058;
	Sun, 11 Oct 2026 06:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajeoGkG7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/ZHQVTB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDC810E030
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 06:37:10 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B50N9w1743937
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 06:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Rnc1OvV3U/gwC+BGfdFIj9X0
 ZgV2oXUIAGTErZwS/rQ=; b=ajeoGkG72+UszQfqRQjwKJvpTzVW/N+uTk+L0ykb
 N0OeWNHPAzLGMFLydcu/nl0Wx5qecgAHaTagMRuhn1OgjXr4UaiFkJS/tZd/36ju
 saSnqUbLo/EfXnikVWyRioLyYLulomrn5+mXRW2C42hs0oDMZ4ItmGqmoBaK6TOx
 QXkJVm4BfzVCeCbvEuIVQasEcqljMuop9N4B1VOCS1UXLOcZ0btyYtAaR/fCYV1u
 s+Koc3BNmPx5hFNUqvNo3ATPis06z56ZSshoO9nVZTMMPHSz7wcZQvRh+KJ+HLYm
 qmn0yPFZ995V6OCDl1tfLYTtSaT4nV9zKmSZZLCKgqRa2A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9taxq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 06:37:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3515266f6eeso1988524eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 23:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791700628; x=1792305428;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rnc1OvV3U/gwC+BGfdFIj9X0ZgV2oXUIAGTErZwS/rQ=;
 b=N/ZHQVTB2ug8Ke4RJ446fO1LD40JXbmX63PEqOjj+4PyTaPpFEa3rKBQCBh00b8j/s
 dQXM1/nGZSK3xolbVxVdyOVHZDJaxXZsMXEQyWSbwmScDV4tYV3GkNgpjjdMdI0u/qSp
 5vZA+cXScWB00MBhd46ixx+sTl4Hij78Mw6elE84ow9to4DKAVdfeu7lhx3IZ9Wg8w8X
 wo2J5Myaew8PYZJ3HyxLAHFMxZkYWBZuT7gDf7j+LnaAuAuFJSMyruouxSZBRgIt4Odb
 ZiN4rQJpWUBvo2pMZuHiDz+/GUHqhVpisldDO0PPYiy3dmusxvlGSS03CrZlHWeAyQMB
 SaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791700628; x=1792305428;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rnc1OvV3U/gwC+BGfdFIj9X0ZgV2oXUIAGTErZwS/rQ=;
 b=wMQLYGU1z7+AkEtaFzSGzZvFqmtGnJwZQZjxlniEGuQ5iS1eX/o5bV3HtDDnOsdxzM
 y7R2LTNjCmcCo3YSGrZeTDsn6hjuvGghFHnNVOa8+a3IBXzhJS04veKJRbcjOD8hPnPF
 wmHyCiCdzTnaKIyJtrQgBudv3RUsvD0MvTS+2DC6Pgq8qKTGtgHMZ6YNaTpp0q4+citA
 PEDJAvtvHdxYTltnO4ZNT/81cwQM+gswLuBMIXDhGwsh5yIVpghKYkEPT5cj3Bz/HkZb
 IhBVK/TPEaf93SFWGE3Dv2rU/yRMenlLT92r4WF8jPCJmjJvhTzcT5YOXv3oqzmOT8O9
 iLzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydAd5dQdSXjqLQbcan5zht+QOdcipXfqVyBWVj/tjmETnTUxcMnGaBuOmAa4cfuwYUD5utrIPoYPc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJnXssh7wgmuoc4teDappY8km9kGBd089fpH82PqqNH7x1phtnq
 BNdrgmIUdeSGVlk0WUyim11a0M9mq8+LLVY2WOliJRDun8Isi6QAmNg2mvYONaJwVR4S2hCKO9e
 mjIvjeuvPItB+rM6QyyphyeMXKLgb9pe0IVAucBGQ+PI2U/rOrYtFNJmh5gC8iQ5iV2l/FAY=
X-Gm-Gg: AYBFou1wfL/n5CLWPn+Rnh+2NXEhSbJMiVhbUpbIrlci+bgEuL5aftHWnmQMS9oJC6q
 rJ3bfQ72WpjlCQ2DCH7qyulHd6Utj1PnVW5uNz89NObRJrStjvqHpZAubi+dDF3JbSberiWFq49
 YxCdgVoLVNMY1w7VPj0+H94G1VkGHqlh3kEaKoeYmm44o9li57bPoce7qcDnrPX8G2HYjAzVUp4
 8RTKQ7h4Otnf1gQ1KQkCzc+pOLDcx1YrRwJ7onhVbtZeQdsKpWTcV+zppjciwE9E2clYEdiRa/R
 o4Ye5/Uj16uBfM5M/QdTBKKpTeSAM+ueTmyMfRVNsuxijNuZDYwY1FRdUv0nw3ii7IMf61sGtfA
 YsysbQNgweBk/vklT1vHfYbkgSyDpMO0igF7pKqFJLw==
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-3537e0bdfe0mr9337656eec.23.1791700628201; 
 Sat, 10 Oct 2026 23:37:08 -0700 (PDT)
X-Received: by 2002:a05:7300:d18b:b0:351:1e2e:da4d with SMTP id
 5a478bee46e88-3537e0bdfe0mr9337612eec.23.1791700627378; 
 Sat, 10 Oct 2026 23:37:07 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb6a279sm20811159eec.30.2026.10.10.23.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 23:37:07 -0700 (PDT)
Date: Sun, 11 Oct 2026 14:36:58 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] drm/msm: Support for GPU in Nord
Message-ID: <assuimpZe3J5E2rs@QCOM-aGQu4IUr3Y>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acb2e95 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7srVW7kWV-eK-ianrkkA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: XjI-VQYDy82mZt3p2D4p13sMTsVR_vWG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDAyNiBTYWx0ZWRfX4PgksgUTZh2u
 ea2swoVtlOeCkaOuXS5U1C0wIndBVSVxQquPe0EpbANwm0ek/CDCvglD9IaJX9AHyzCVuKbrv0a
 KcSJ/lcXABoiJfO2U/gAxrUwCTHyHV3rFvRvVq23gqIPA+yDT5u5mYkRM6PR4TTcSyvqXqgHXE9
 sNi681AYWPxksDD3FpUFYseOO9bmwL0guA8canjNjOxg82Rj3qsuNQ1Tkg2wnYijO8geFuGDJFD
 B6mz0jFy+dP4NTS2EcgB/bB+OJljTpRO3AVFEUC3iABpjIyJ40AybXj2avoMnEhxUCkkRaIRK43
 +kX9zxktwdtGTuf3syqIIXBy/FZUmIuNEFK3FIm9KSp+Og202uQeAP72kn3+FF3wnnZ626M5bUZ
 /wN3xtYeY7ryL9lXGaWZ+8eAKmziukmA0Azmue8p4fuaqWp7iIJ/0Bof5EQAV0gO2il5T3EnysU
 z/IF4TN9nToVsjmmMiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDAyNiBTYWx0ZWRfXz4grbCZ5heQV
 2BDGRby1RDTn0Ftb7HzX6353N/L3d1Yh/2aF3HngidNrjThOJDczKQRbhVkz1sMWhK1JFupOFJy
 ioHfyakOeZM/iXA8EDT2xH8NzwVkU+Q=
X-Proofpoint-ORIG-GUID: XjI-VQYDy82mZt3p2D4p13sMTsVR_vWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110026
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

On Fri, Oct 09, 2026 at 02:36:34AM +0530, Akhil P Oommen wrote:
> Nord is the first Snapdragon chipset with 2 integrated GPUs. It has
> an Adreno 753 GPU which is very similar to the existing A750 (SM8650
> chipset) and an Adreno A735 which is similar to the Adreno X1-45 GPU.
> This series adds support for the A753 GPU. A735 support will come later
> in a separate series.
> 
> The driver and dt-bindings patches are for Rob Clark and the devicetree
> bits are for Bjorn to pick up.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Aastha Pandey (1):
>       arm64: dts: qcom: nord: Add GPU cooling
> 
> Shivam Rawat (4):
>       drm/msm/a6xx: Add Adreno 753 support
>       dt-bindings: display/msm: Document Adreno 753 GPU/GMU
>       arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU nodes
>       arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU

I tested it on RRD board (against next-20261009). While kmscube seems
running fine, I saw the following errors.

root@qcom-armv8a:~# kmscube
[   30.192468] adreno 3d00000.gpu: [drm:adreno_zap_shader_load [msm]] *ERROR* Unable to authorize the image
[   30.192503] msm_dpu ae01000.display-controller: [drm:adreno_load_gpu [msm]] *ERROR* gpu hw init failed: -22
[   30.202644] platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x0

Are they relevant? Or am I missing something?

Shawn
