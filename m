Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A299FC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA5D10E7AE;
	Mon,  6 Jul 2026 15:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AN2GHhtm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xh7qaOvZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0654D10E3A8
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 15:04:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666EE58F812763
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 15:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ca2td9+EyVlsweraoMntmzjY
 hSdPbwsqF8kFzfiyaX4=; b=AN2GHhtmMMxBmwhxImr+fE8YcEtR/M0eVlKUqV66
 oveiQyg3nTu2wZ76otqvpdNWss7noUClU42QGos4EFu7VQ45pPxoEzw+nEbb7gtZ
 ucCyHSsB+Dwx9kIiLWf7SSS9Xn03PlC1Sr3JRro1hzjF/5fC8BR/fXRDI/lFznfm
 an8HJClriUnfgVKmtNWH6tbqL9ARkTzeCVTDiXnHojqMVfDGGz27/RYhPKy1jpD/
 uu/iPvQ/cN+PywxEzBuQG3qJEgH3zcpQ2vRLikbfVNLFUMjjglMMnA0Tkgov8fOi
 qX9PpDojdZEesiY4S09lTIJs6Opw01D8MlDxo05HdA/6EQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99typ-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:04:48 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bd797e447cso4444238e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783350288; x=1783955088;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ca2td9+EyVlsweraoMntmzjYhSdPbwsqF8kFzfiyaX4=;
 b=Xh7qaOvZiMDGQtjAcSe8d1Dyou6JamSQc73Se1IlLi5aEyrtKSiwVhx/hcxPJyHVKt
 omAYu0r8EPWyn5E2vzOyH3abgsCuy8+L/ebRUhN44cdrBJXVDNTCxeO4qUvQuvoHN3rJ
 d87G2frP2kmVw4lX9rANX97u0cCEzBTwk06bK8lehS6kz2GIO2Zg2pXsmT+Or3vuEuVs
 GUHFx2DXITtGn37TIIzhcGCOt/6oT802FfcV3T055JUfzhT1IKxp+JwME/2Fog+/8KVF
 fmkUtrTBCAskUvvsm5fuu/nT8UdXVKQRSZrfZT2RsCv6NRsa4bD8XBWyoXjLfqFvG3H5
 8krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350288; x=1783955088;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ca2td9+EyVlsweraoMntmzjYhSdPbwsqF8kFzfiyaX4=;
 b=HwfAs9WpYWHcA0lHi1DGBqOiBqhu00FLEy67kmwldYnxBIV4BKjN0LLNOkbZRBnjcI
 7al5KSNqq9ZgGzegTiIQGO4EEFgrG9UAGj2KgMggUWmcRl5vg+PVFs54buKdS0kUsYoy
 t7YgT0RbRcqTb7GQLqalVVRQVod9I/yQG25YxYLtG6R6uZ2WvwundxMGLJ1GZ/i3mbVs
 0DkwgtyCQsOCBMzqVHqeu09XK1ZelT79QWspkKz8xsh3q4GcdPdQwN/R4DySmgRMkm4h
 Sos+Bdv3Y7ckWSUHz3oNovlRg8IKIWduAuqqAML3unbZ0GBrxeweJLWTlkgrWMSAWWvW
 UEmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0Uy19O01YN4tLow1/AT09JTETwvOdLK2CTPzUYub/les7iQCrN0KTf8povvJyXg7e5FpwImrIX3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwW1VV7CfNXIWu6vQeUE4vHoVzqx6jmYymGdYpU+yVWs89WY1wR
 zt0SStDDLFU2Apk/lJVB3OcYxQt0tAjYjNT0DQRgkEjY294d4GxO3XG87wVRqiElaXQhfxLdNke
 K9HE1j/yuwAOkeLL/F3nSoQt6/9rQuyEVD2WM65OYpD/nKva1zNcittNp8mb8IBbVQLGW8HM=
X-Gm-Gg: AfdE7ck/8d0Pj02/WTb8bhOFOMhr6fzW/Fk/0jbicTu2Lq7i9IKLBucIgWtGfW7R1yY
 VoOHIGr/i1oz4OBDEk8bkN6TN2diHS5gc+3Y7u0ECCaGq06pYRl0Caol+rdidNh69lMykS4ySms
 29t7VMrhPCzvwfUle7eakocKAwe2RK7ytn6wZmCPmryeI7S+/beD4Sw8ju0eez7+mQm/0aIoUAF
 8B4M64yDx/d57jdOtsJEpkGnMrDozlThKWluSWbpYoLcVXxybT7KZ7t0mc+siMwmY7mzuClqygp
 +W7xIPoF9xm8goNiHRT2NriCTvywWaIuxiQXNd1LFYRcelHJ1YvI1DinnzVTwj04N9+S1Pu3rv9
 ukLFrfcwD/96hf1Q+R2NPNNaU2NQ9pSD6PZ4iVp3B/aCMbomW8HBFPSO7dh8vX5gDt18TPTFq4+
 /oGC2gAj2D5svX32j1/PiGXWpQ
X-Received: by 2002:a05:6122:c89:b0:59e:f727:4bb4 with SMTP id
 71dfb90a1353d-5be90771737mr579920e0c.1.1783350288333; 
 Mon, 06 Jul 2026 08:04:48 -0700 (PDT)
X-Received: by 2002:a05:6122:c89:b0:59e:f727:4bb4 with SMTP id
 71dfb90a1353d-5be90771737mr579889e0c.1.1783350287799; 
 Mon, 06 Jul 2026 08:04:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c5e58bee3sm2046451fa.8.2026.07.06.08.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:04:46 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:04:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
X-Proofpoint-ORIG-GUID: ci87BTaRi3CY51Q02YfC-1uXAkwJdVC7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1MyBTYWx0ZWRfX6lr+QKwGwi4b
 BFJrrj5jPqiWByIZI23L7y6tj+jFdwIFNgqhbSuLra7CF6MzT1UR2cxIMRcB/AEzJT7F1wqU6oY
 S9zTkjZycne8Is1CUiTWPhfWQEMG3zc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1MyBTYWx0ZWRfX7zcUz8Y4RuIH
 Wy2w8UWI2AZcWrzOKYRUw6UYRF9daRI355jNhOW6Dqj5StQl+EJk5VaGLEnQpvv8Bhl93We7NLi
 sR8eKs3uQ4S7F2qtqwumgdFGi+q8W/J06C9PXb7FG5Z6NOz2jGj5fnpajDWinTp7UptO41c0Y6D
 o136JKuO4wbQ4cNO50FLDXY0KEbsnFQfjdI+arDB9dI75jfur3at+xBfbtLBam0XPDMSMQPgyzM
 nDf57M0ylPB807D90JFy100jpXXKHSmi/emKJfo5wf/K0+xCEc5OO/7/YkNEgNRk9iTo/h6jKLO
 B4Gambrfk/+NkrN/eV3bxIyMAUuri2hfcrpvPyRR7zdplm2VfyCbhpqSAjQH4ZBcCo4o5Ca+e37
 fk2f7KyukSa/Q5sdtj+UHyLUXNxlc2/BmGS3l98y5XhzztwlVUkUkAAIE1okcaU+pVoEWiCpWxB
 mnwowsD+eszEFYwZNMw==
X-Proofpoint-GUID: ci87BTaRi3CY51Q02YfC-1uXAkwJdVC7
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bc410 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=lS1fCJvthqzCmkgEd28A:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060153
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

On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> In order to associate the SID used by LPAC to it's own domain and
> context bank we need a separate node on the DTS.

Can we use iommu-map instead of adding a new device using the same
addresses? You provide zero explanations, but it seems like you are
trying to separate a part of the GPU into a separate device, but it's
unnecessary.

> 
> Add the code to look up that node on initialization.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.h           |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
