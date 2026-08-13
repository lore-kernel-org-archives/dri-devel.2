Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F515C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEAE10F416;
	Thu, 13 Aug 2026 16:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="byomBt3V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HIVX0CLs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC7910F403
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:26:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFqsVM3180701
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6RfxM2ertZqIr+2plkalpmps
 fFAQnAaF+gcYLua2ztA=; b=byomBt3VpgmEO75Eav+uM5WxGNaJaSzHFLXCVFhj
 iaLxn7f9B/Lt32VbKY2Mf39PzdfCKGRunJ3NHkfSpntJeT2F2IgeQIzromBvs/ij
 GU7Qhc1jFQrgCu2uNuRwmvjMqzzOtuev3psln6gA4UGRwZaAiJ08qm2VdTSBGQzH
 n4dc9j9NmEg4cSbKX3JEVy2bIMMot0Dp0rrdIcpVIlgygQc0D8XIqM6Pv2/mFxqf
 JQ0rNFrzeaC7Je1W9C45f/nUXxDTXHMbJElYi6nKiT4NZOjaHDspCre4yJwGExZq
 r3Zn6R4zhdlbs7sEI1zib2WhiNeeqnGbNcgWqTbZ2/6EVA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4r666-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:26:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5283df62d68so1506391cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786638383; x=1787243183;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6RfxM2ertZqIr+2plkalpmpsfFAQnAaF+gcYLua2ztA=;
 b=HIVX0CLsb7V908cdFTdcJSQGU6d3aC++TK9qCq0oWGL5+5Mlwhc6IfLe3Ny0de4eor
 pKACdvU/1FNmeetwKk/qhM3MiIYcjdHZOXojRnlaGqRzM+xTg4fIquGsrUuXrL9M9e6c
 +1c5WCy8bszZfGxVozf7AfGFJ+4c2llNyVdRFjscCHtL6bdOf4kBY3ILdYJeT8LSVp/R
 qnorFAyCJ1nJRpHcBnpAZDNCXiAqdcLj44HYFXf7UHP2oE6aF8JvD6o4XY0LhQm88s5j
 2m/AAlXMDRh3W42HAhUanBGwrx2HvXxITl1kmv8Ju95xy0+Ib6HME8n7tWG0uphMG98U
 lnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638383; x=1787243183;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6RfxM2ertZqIr+2plkalpmpsfFAQnAaF+gcYLua2ztA=;
 b=iBKxwgN3c631pCHt0FkBSe9kwWnO2R1jTErrmab2gYsqDR1NwHAByZZATwkCTQZXdC
 UImSXRemHUCi0+U6SLozFrUJWMXBXzsTADTGxH7PGunkj6NHN93RGDaMOux3BcCD9R+k
 H4/pjGc+v6kZ9hrR1EfSYX0LC0xVf8Kcpb1BScEgxm9aXmc4vhSwVPiYYQmZ6qFvARq3
 ky98tkjJM7fDq6qVjNohhNoNW1vQdvzcu6iEIxD3YYJ1Pk4kTfekg6V6gYK3ScvI/KD7
 6ROZc7U7LU6/C2MWGO/Uk3XX8Ch8DLHYd7DyTSsV3OL6hk5kAmgzgSlcrGQkseLx3vV5
 0pcA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVU1KB0YaFKNyOF+l7E0E9A0jx/FCrTiIpllbogkg+ZMB9Q76cXZa19GxamQYx7RIKAMlb7WlePNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqWTq6QQ1MR6qYTGOQq5iUEef3Egdmoezd9n8R1M9e6W/TaMiz
 to87mprUnhpKdPiM0Cq+7jtpmsbOXtSMyaFIu5RtrJ0zUXLO5BBDouoqgyNaUE71s2WOlxIMqc8
 7z2K3k5RUylkHQgZ4J7CoPCyfxKoMRM36u8II5hIPuZSqLUSJ57IfaySvaADLNKf8rNykpds=
X-Gm-Gg: AR+sD11ubUzpaW4+2/zdubWPIweEiPzU5BU82DRt7A4KIr1ITjOYfPhiTea+0klE/2K
 BREiCAr2QMdXKnRG6gMr7Qw/LHSzdigJtTSMu4nY/0SE7hpuHyZDpReMfinFUKnvbmSS3NfIRx2
 nbGXOhv/ZScbMx5/DOniHk8FcSDLau7hs2fs+CsaCW6GnhNsbIy2yboDxZeqamRV7mMntYG5TwQ
 C64N/tIcXGYxzgcmPN8/vxV5+pB/R10puAwgWt8NZ1axp34AhF2aigiFZpoMTLip8PtLt+slLja
 IFuakwdpdeHQt6Zp2MncB+f8h/5+EcEHMm8J6Pml1/iIVNybDL556dx+XMKYueKyixl2QLZahQI
 e4x8moSmCoD7Jts1qm+ReKAwaxKbPuMIXvra88kVY7m0tfCZ1IRWZGACalzhVowLQ0pk6DuoE10
 Cq06MHwsifuuqC
X-Received: by 2002:a05:622a:1f07:b0:527:f4d0:4bb8 with SMTP id
 d75a77b69052e-52d73cf93e1mr88840601cf.22.1786638382923; 
 Thu, 13 Aug 2026 09:26:22 -0700 (PDT)
X-Received: by 2002:a05:622a:1f07:b0:527:f4d0:4bb8 with SMTP id
 d75a77b69052e-52d73cf93e1mr88839301cf.22.1786638382256; 
 Thu, 13 Aug 2026 09:26:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b453a548besm600836e87.42.2026.08.13.09.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:26:21 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:26:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8750: Add GPU and GMU nodes
Message-ID: <4tr55ef4n3zdcecln477zuxkty7zlv3lkzm4ke346cgcjqnw7z@25npbkmfltoh>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-3-207ad1fac1c7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-pakala-gpu-v1-3-207ad1fac1c7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 98jmquZvexyIW_OYqIeQl7vzTo7Jh5tD
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7df02f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=qJow9a4cVNqwEOATeeYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExOCBTYWx0ZWRfX5D0T7q+rHp/Z
 Dr+0rZHl4yTQLIv+i3OlqNtgoDG2oaQJ9gOMksJWEMEQaP8jmNRSIYTEvxm0fZ+LaCMXLSgOdyl
 nBw7Km/Ndj4WxIsNwpeyVJ9UkcQI7J0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExOCBTYWx0ZWRfX7XpKS1tnNNCP
 LARyyW68/36Hc41okQgpfpC/AigOuzMx3eWcS+N/z4mx15zrkWOTSnZ9HZYfvTwnK2h7sv6UZw1
 1JsSFJQM3bBa7CbJOhjvmO4lBbsUt/jJSDm8C57Yc2caRPRop3wZqoEwp0+AlzYyogAFEBSNKOs
 ACxA0GL6mtUTu/fgxTqiGj2W8e6zWuYH96CcqplDgCt5ex9ryTqLGMWIrn1Lbko/6rQ/5a5fXuw
 z3hVESvc7fakNkkptoUNHnZBMp861aNsxFevYRgkhRSFg6LH9JgcHx+EyJRwJF06dHaJu5BreMV
 gVZP2TmcC7HfIdWgLWrVXzjKAyH79bE2TEnMkeIvDUPlawbWcLHjlU8kXD5RAC05+Yp7/UN/sSY
 qpz5jX9f27KlIeQXL1udVryOFugfzgft0buvEUn93qzJWct4wy37VXXD+Thkw2U/mdJe3dp5U9O
 mfB7/gx1/hTvA461JTA==
X-Proofpoint-GUID: 98jmquZvexyIW_OYqIeQl7vzTo7Jh5tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130118
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

On Sun, Aug 09, 2026 at 01:53:10AM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Adreno 830 GPU present in SM8750 chipset belongs to the A8x family of
> Adreno GPU. It is similar to Adreno 840 GPU with some meaningful
> differences like GMEM size, register file size etc.
> 
> Describe A830 GPU and GMU nodes in SM8750 devicetree. Also, add the
> qfprom node to describe the GPU speedbin fuse register.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 231 +++++++++++++++++++++++++++++++++++
>  1 file changed, 231 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
