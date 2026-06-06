Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09FCD8C8C
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 12:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2DC10E77D;
	Sat,  6 Jun 2026 12:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpo9IbW2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnGiG2bT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0F410E77D
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 12:17:32 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656BGKSh1290762
 for <dri-devel@lists.freedesktop.org>; Sat, 6 Jun 2026 12:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vgZvs8ItyoeNzwdrSoQaw7NU
 3tYQCqRT79Wusa/gol8=; b=Wpo9IbW2U2wCrMvLt6Xez0VLv8ki56i9WVHlQUZp
 bZooegCRoCJXy5IX18MVaTLrte5oIcfWoS9qaiLiVqEtwTVNKDPGdej+SKmX/FX7
 dwnxOh5eNKpI0M9t1AcExvxaLEvhZWxOhSJ/zTKsdACXfTr93T7SGknbAcrFXCtB
 lKYI1aL6epM8UXzLhlH33hc3OpiMVEi8I9hSx4Jnr0pbzE8DnpM0ZFmd+8z/YXMc
 KwugfXljpdaQToMRX/9XQaQvO+mAONFvpj0RsabkdtlEOQEsdcg0sEBYRh+fHP5m
 NM2dnniTrJIJrMK2054lywh6lRSYo7JSXRXJ83ZpyP5scQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmr91d4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:17:31 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-59ec77e0184so2425775e0c.2
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780748251; x=1781353051;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vgZvs8ItyoeNzwdrSoQaw7NU3tYQCqRT79Wusa/gol8=;
 b=RnGiG2bTV3LMnoGSXHFCXK1e8ICBPQPnu+45F1aWttV/PsFGln+qS+ctsAOiZoE9fW
 cc0AuG9jIm4/j9cihZDrqhbI3cWHGX8BwszJkT8NIKZqCCYpzRyHJv3RA+uxF46J5PaS
 pcrbmxTTTnepw2Pt6QdYU/bda1kHTi4U9Joq2/OydGhi6ExEnCFqyXyjRpzELvojJPyB
 RyZJ88BlgfoznMq0FrjjUO1j/cXXDtzIgYlznxuIxs6fYtteJOA2cUFvnTYRKtIx0OFH
 BAGRnB9KPq0aMDajPng7/zkPprSOoJX2nuaBz6RaRrV/B8f8kzJ6XOEFDVhA4VGjYhJB
 ExuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780748251; x=1781353051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgZvs8ItyoeNzwdrSoQaw7NU3tYQCqRT79Wusa/gol8=;
 b=dPkrD4x+En48o/NJDRJpVlC5LyvGprXQvijvYR0e2EI4Az78LgRrVZsRYljzOGSOkb
 tKf7/N7bsR2sBBG5lstaZwYyl304V/7ugTT1aU5gfpH9QwUQzhwalc6VOeexcLhPr7cP
 kyyn3/tmP9yr4uEJiEyf2eJyyDVBz/+nLmKfZNKJQ9Qp8XdRF2gBeZDoDk/LsBghQ2LD
 AhsOXVdwMwfhJLqsidTSJ5lnWvAUwHroUyrxYBu+oo40LL/vJ1QXKuKYmpaWJz/UeEx+
 JKuoq5BJ2xATMZVQHmEyaDxfstT0AiSSp1vW9nm6xT8jP4ZO28A4jN1cszi22rqoLYc0
 XSLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ebH2hzqci9hWJ3zan9+xqPmgNw+myoNXWbvk06CZpwSR0vM0yrQUyFEJsrF4UMDao3E9uaXhiv1M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiCwQcoIE8KTVs0Fr7lH1zblkUYPDCJbSYuKxhf7QvhmWesUsV
 l+Prp4DEwWeNVbyfszGM7N8cYXuotRawx6IvbPV1iMhWK1EqFiObtFj8BoG3BCbE/bHWmrwb1+O
 YFWLmVI01j8uMQ5NOr8fZQL+kPN0caxzUpTJtI6cSH/mGH+AmN+40ur5Tne6iDQt6gru7GAo=
X-Gm-Gg: Acq92OEvvYL+dSEo1KcK5VWomd+tSZNibzDJIs+K6DQygJ/+zhNMElNmSoQb0Lk+AUF
 IHEn148Rn1RUs+L5uufQIAYlD0w5xjsKQ0ol/eAI0PqK3a4K2zTy/UbyAFFwm31hkNDPgKFUfhw
 fIr89rp5fVW82qxEcdoBypV5lzIrHMxvlhe1X1sqxm7O+MEwDJuR9w1C38Xor/krq5o7oSlkfAs
 4nMOkEhjUvztgylGpANiptxvFe0NSbceKf+Ca71vNAXbuBXURVmI0t6JEMueXJkpFNF7gF5bCHt
 X4OXVOEY4YxS5dDaeKgfXyTeIySM2K2/aW34bUzl2nCzp2SWhN/OxmQZ8YVWFLGMDEqG8VTz3mQ
 1xf3ohdes6ecb2DE17VMwaBAiregKfQSQ5BCC0vmF/0/lNfhkaEMhrjfvypg/S2pVh7Q4FVqJmB
 G9qXX6f9wT9b+uORfjnwhlqREYk7AUC36MSAGSlpR5uOCGYg==
X-Received: by 2002:a05:6102:4411:b0:5f7:240f:bbee with SMTP id
 ada2fe7eead31-6feef48d3c8mr3403149137.1.1780748251219; 
 Sat, 06 Jun 2026 05:17:31 -0700 (PDT)
X-Received: by 2002:a05:6102:4411:b0:5f7:240f:bbee with SMTP id
 ada2fe7eead31-6feef48d3c8mr3403141137.1.1780748250808; 
 Sat, 06 Jun 2026 05:17:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2ed56fsm30934311fa.37.2026.06.06.05.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 05:17:29 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:17:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
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
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
Message-ID: <aiQP1wpq1MAlsttR@umbar.lan>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
 <20260605-shikra-display-v3-2-9846ba5fe635@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-shikra-display-v3-2-9846ba5fe635@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyMiBTYWx0ZWRfX+PzjE7JiGWz3
 2xePFyD7LBucAXSX/rc+bMWNrxK65Nv+1w4KkZJUe+qpN8SIjbU7Dpf3n31YS9srn4kHodNDOts
 TK5k4WgAiY/zMsSDpFu+FNuC74Q7iU8HWeB7uQeiKXqRv1uzIiirVtr6VCT9ihmP+yrPksXmKhy
 +qk42If+e4VBQ9Nk6BPOepUDRA5BqlRopBQePNp23+gAoL1ngxtEEDBHbmxhm2T808ZS9AV0vTj
 wQhtdDNB/Bwy+3toerFm2uXhB/6SFoPycf5k2BnAQUBRkuOClCne2mDjqzREM+KIt3NDzCMwEif
 rfI3DzjVY8SCF3bZWDSnYXH7lzZ+ZkUQznLVofiEw6ufzqpwVRDpfLIJMv8ovnzc6kdqu44AYAb
 /qnSzrOB0NfH8+Mji+BewcmIvLFISzCmwLBVaCDdY0n/3Dl1TzurK7GU7kUev1n+w1LxRMFr3gf
 Jw58/7zWb0Lop9srUBw==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a240fdb cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=oNl6jLlcSFQHEdJXP8oA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: le13cb1ITjIEFNHipEo81GE1Xj7wcAPr
X-Proofpoint-ORIG-GUID: le13cb1ITjIEFNHipEo81GE1Xj7wcAPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060122
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

On Fri, Jun 05, 2026 at 03:48:52PM +0530, Nabige Aala wrote:
> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
> used on the Shikra CQM EVK board.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Okay, you are really not reading any feedback. This patch doesn't belong
here. Move it to the series adding the actual DT with the panel.

-- 
With best wishes
Dmitry
