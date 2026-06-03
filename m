Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D62CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597D8112485;
	Wed,  3 Jun 2026 23:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JyZjPCpX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bc2siAWs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FB6112484
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:09:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653K6ehj2076419
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 23:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zYQm4k/RnCbtoz4G4uzh93rP
 8MS0q/z/Jb8qOX/3f6w=; b=JyZjPCpXDV/KRX+EmGw+f9M406g2NvLbqEMngBRQ
 XxhNUldIZ8AF+mA8uAsG9nvLfvLwoFFNgP6g97jeOqhN53SaR8EyrUipQV8B75Hd
 zch5jVCBwykJTXc8GKuEREalMTM1awlQKjGE3pv34P04rIUV76BMXhhuvCZhKbUZ
 bT/QXthdYD81vitEM1c2tzPnl536tuqRprIutirK5QgytWMQQHGS6ksQVYp6PPop
 1a/NfAhqgh6kIU6m58Uip/TpKwCjMY9RbsUQFWtp+CT9QlNFi8suBGkbnKhXGBPb
 nfuJYYql8Fya0DY10Wz3cUjKPQZ1z51ilXCpkAi9rkHHsg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1c1uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:09:30 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6cfd65ab97aso138726137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780528170; x=1781132970;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zYQm4k/RnCbtoz4G4uzh93rP8MS0q/z/Jb8qOX/3f6w=;
 b=Bc2siAWs/jy4BwLn32J0rKiPwTYiM563GkOt9hDb/IY6XPR916B4MMIJX4+qgIpbzC
 YG/CMkG+q02WG3M4layfAg514iMXU1uZX/TLQKQbtWSaVKivp5VlR5jsEqleJWvx7T59
 k21fzXplHPggo5zH6TCMQ5DVOEBZWFH7Eq+0Nwl5ojaNf9w+oy0CGKcvDShnIS0HuEUs
 F1c/+41E4+XvPs7CZNyP0y7r/cDfGHeAyVGhGFFvB8ZrSCBzA21lQGvZWW0gOFW194kK
 IkTrl0lCTgXbkrnwVajtpbow3YbxQQTFBu9s/9NTWlpblrkxr8vhqsicGNEFYtTECBcS
 I5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780528170; x=1781132970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYQm4k/RnCbtoz4G4uzh93rP8MS0q/z/Jb8qOX/3f6w=;
 b=WykGCAvMG9JVWMRGy79CfTuI5j+df5wg0CxYftvP0tLunZMwk13Nrk9dulULPhDWEc
 bvs9H1cSpzA3Nnagy9H2EvCPoVUvQrvOvIfvNqiQ5N8NRCXAyXnkLLNJfPkhihLotup7
 uP0arKHVBoEoKWUGiDV8J5LosH40NRH41JqK8Y1Q08UZYH3mzAn9oXoouN5w9DffK2+8
 i2d6h52cm9qFogzrgvFQl35qwpDpbLtKNCe3bQRoxqECq+0TgdjAweOmXVSf1JyyYLeB
 VfQnBNIGupdU/111SMBlsBu+wL1uxi5K7p7S92+6DRxqY60nrO0faeHgAPwSD1qVBmnz
 J49g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MEDwWkQhqC9NmaC62TsJiaQWWOuC3hvoXVTbzoZ5BE9p6IWtNEhlKrd8Ewaco7nSOacJXUjndmA4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywj3lzsZWtShuah/DDf2wr6A/olOb9gmYqr9A3adGsuZyKviwKJ
 9P/LdEyTXa/4HEmm2SnlHhd30p5Vj37yyXxic2ksG8tZbH0WLd5mugPYBssPzgUDeAMovHn8IXP
 KSp1iP+s48Ldf3MybFT/KlJsbzAM3NCb5yR59apcDYl4lVsbtgkIcDD80/487vejhUtqxUWU=
X-Gm-Gg: Acq92OFXZW5qkjwdAMzjFTVB2oCa1LjCDqE0vMotxAOzyTxLLDLurDmTYOPuH/DdK7B
 eybmJAPdkxhAD5yN57eed48ayeTxLdgEcXP1ZWYE/2qsqhE4lKGuE2y5ganNPpaPMSzgUjIbZ/d
 a1V+eesuN/Eosno2rYEntCEwGEiOcNMuM3avezqDWbVJOnXhEPcgbigg5sFyjLD7ULXx1LdkuX/
 bdj0Xlg2SDn8efU54P1v9RbdDpDsI0Y7lJk7yExZY8dnrWL3+qMCNnNLo7+GLNBRF4FQAzdkDeW
 FsIx7GDEd7kaOn6rdK9QOw4MBU9+a4eJhG8XFkRy//2/YowfDLRTAccV6koEykPYmEk4IC7GwRp
 tSZs1kjsxD29wsyCjaPEZD1aLF9EPnlhtwkeq9H5rAZFAIeSQwgdWmoGUQhVz/RLxRuVv9JFC3O
 F96nKDUknXEdg/kLJXGWxpIaG+NXbbWMTuYUsOLp0W2p3SMA==
X-Received: by 2002:a05:6102:f12:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-6ec4710d8d3mr3972141137.18.1780528170149; 
 Wed, 03 Jun 2026 16:09:30 -0700 (PDT)
X-Received: by 2002:a05:6102:f12:b0:633:c6c4:b321 with SMTP id
 ada2fe7eead31-6ec4710d8d3mr3972124137.18.1780528169804; 
 Wed, 03 Jun 2026 16:09:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b9862fesm871133e87.57.2026.06.03.16.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 16:09:27 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:09:25 +0300
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
Subject: Re: [PATCH 2/5] drm/msm/mdss: Add Shikra support
Message-ID: <jw4pps5xn2a6onu6fvb66cyd5jrvw2akx7zu7rtk4ejddu7czl@lmsxmbnryjyc>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-2-aeac1b94faa7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-2-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: dzXtuqrfrusp9EDHJkso033h5ZoTNUwA
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a20b42a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=fWyEoBxJXmLHvYXwyp0A:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: dzXtuqrfrusp9EDHJkso033h5ZoTNUwA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX2VTVi1ZQ1KU0
 YlJ1+aeEAxC4F8BJANnAhtEb6FuGTr3ZKYFr3K0NmkdaxrzK844MNjrDgvr0vRkZKE3ufHM5UE3
 cC4IK8CzKsfTGfAB0FsTQBxKtIUhFTImN7ux+ha8NFPvAsEYQd36hFlabuGtRY0upPjnjd8mdDt
 lm4pp3RbIxkNiAv5CEF0o5I6q0YJ/g1g7aA22BUZdFwcqtuhMRpUWtA7ITvLkC5XndP1x9GE96o
 eYh2aI8lJWFvG/ic4XEWBgg9Rrw0bne7suTozaYj/ULd1Q3wJZ6Q+hWTJNpZo2a8O40MqW14jBA
 OnpYmQDyivwOS3UzoikHcP7fgm4mWHn3gzcT1pbWd+zHVinGGkauIydFEqr85zLLa4DbYEy/3vE
 NEw+spkaXyaBSQAE7dxwkTnxjf3kyCux/qVXk4awmHb4EdQoJORIBJxe7IXP9FIr27B51ZEE3N2
 pAkyCgLlbtbJYLB4vUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030226
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

On Wed, Jun 03, 2026 at 08:29:27PM +0530, Nabige Aala wrote:
> Add Mobile Display Subsystem (MDSS) support for the Shikra platform.
> Shikra uses the same MDSS and DPU 6.5 hardware as QCM2290, so it
> reuses the same AHB clock rate configuration (data_76k8) and DPU
> catalog. Register qcom,shikra-dpu in the DPU KMS match table pointing
> to dpu_qcm2290_cfg.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 1 +
>  drivers/gpu/drm/msm/msm_mdss.c          | 1 +
>  2 files changed, 2 insertions(+)
> 

This points out that the previous comment was correct. Drop this patch
and use compat strings.

-- 
With best wishes
Dmitry
