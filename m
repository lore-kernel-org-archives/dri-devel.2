Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B2CF3ED67
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250AD10E276;
	Sun, 12 Apr 2026 00:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eq4MWcO0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJeVRM++";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BCB10E056
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:34:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63C0Tkr8012138
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SVhnyDMjwHr0n052rO7zFDjE
 11BoIx6fN45sSKbMcwU=; b=eq4MWcO0Zij4zS/w3ydf4BwdN9GMEELjbuyan2D9
 d8lZ6dmSTiqsDdh4M/qMPC6+rA9SRBQyMCGlv42UrbDQSHHvRfo/scVy7NKfEVWY
 cM3AyxtdIbSTq3Dck8zhgWbT33+ZZGYtDXl7wIdhzsRe4yCdDZFniIlHDQCq+2b/
 EyYvNpdwp40e6V5XI8aPwl43GKAjbZngEr4Nz067EK5eRQqRjuuCpCRDE+72zxhE
 X1OVZ7CB8Ch1kn9aGReqgVs2VvLy4oY1+PyQOkKkNIvHuY13SpcIH2bOxBQyD0g/
 102m0uX61dPl5IinkdK/T/Mvd3yeKtv9VThObejJff1gZw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffk6hj6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:34:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d984c74a8so76185601cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775954079; x=1776558879;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SVhnyDMjwHr0n052rO7zFDjE11BoIx6fN45sSKbMcwU=;
 b=VJeVRM++kZQal7Q0P5cg5D+zIGMZzt+//kGodzNKl6Ho1DZKDnacD3aTnHyAxxTBfC
 m/kCc7dVJNIFbUIcIIM4IuBfdihERYdyJu7ECVqG16agCVeBD5Qz5MzN4F11gR2p6S+h
 QcijEei379/jBW3b7n2RrgEjsU5G5a7DCMOmOSDdGh2zzymlUOfMQ0/Lxzbn1kNpo4b5
 qFozI6mad21m4T3r5k9rwNEi/zjUhRQALloyV6God/A0SaA2l+PZIoHXyDH76U3cXSHI
 PtYP8pApnWRWikDfbxtjj5ixuDRZxkIwqGHAwmh+edw/2B//Y7ZJ65HpfzzO6eu+GxKQ
 nS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775954079; x=1776558879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SVhnyDMjwHr0n052rO7zFDjE11BoIx6fN45sSKbMcwU=;
 b=hpuRe4Gx/w8MKlBhEouQvZDj7DkrjW0b5o5ehSeOkcDU1tVB4wVLUSTCMhqpILgEAh
 UymIsZDyOP/hP7TN84SMYZArz9ls4lNkjdh730O6xXgxBjG+KICPJTCBCUxt0XEA5l4x
 5RWTAkXi8P75lwELS/claQxL38POkCZEqlPyLLK+CQrAne4/JAY09DDogqnAmWarmaRb
 nWWWogXOy1ec3bSqhFmUjiAHLP8LZ3tcM97Iu6lxR0ZjLMPYw98Mv9BoG5prWQVHTWXX
 OTHHmc96hBwP0uiVMThtadK0UA8UusaqSZr36SlHPgSWC5b/L4TbGBopIo2wG4F/8L/S
 gN4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvPupglO1j8mUEamuTVHP0agHYhyju6sPU48+L65IdStssm+kvb9Wl6y7yE98J3pRmudyT7B+zbAM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSuMD/3UovVaNHj5Rht0f0oGSGHXGzCGNlze4UdyRNGFceReRJ
 eWqR7s4YMKTT6lc/12FIvWYs2smC+pJWECthUY3bXqcbsYJX3aza65DWp/HCbBeOMiqzLeKpsp6
 6MCSGlCdkVW9rlWhvgTH20jRIrDq1oIq0CUW9gX8XOY6Uhg6sSaKT0oMNUyLgJ6myMwEXjEQ=
X-Gm-Gg: AeBDieuyruSkKZvpLG5rW/GUrMXK69RdiwV8psWZxOTcsAOgRSsVgIEBDWn/Gdg57W/
 sODzXi6m9jeuwiWrQg59OUxldgdREoI0HSzizmNkqa0buHA0Q/FVmp52XeampVbsF4vrXvMtLeK
 ixYvJ3CrSdbmwEWEqXAcZffQTPnJEvf8vSa9f8XqNVFV0/zGEUya25Q70jCeGlIodqhIbVpp6xc
 l3iAPvcA6DonFYhaWhNpx0n+Yicn5IZnSog/ZPe358ROnuonuSvc6DJOCUtTV+lfgsLsSxJtZnI
 wp92d0WmOzTqv17dEAwA/lMYr8G4MrTzHJ1/nTbcGJjLMff7rhOJEULNbRpDkni0NPPIhe2dQan
 KAPWgjSa1C0eonWNlRwoWIKzKXOzyaHJzKtZ8ppRN5NxbLVs4kI5V4ldEMt7aa3GqQKU2TES10L
 Sfjvkev2mAl8m/4tNK0UUD0iblT9+CGHzTBUE=
X-Received: by 2002:ac8:5ac8:0:b0:509:120d:4311 with SMTP id
 d75a77b69052e-50dd5c02761mr126828181cf.60.1775954079558; 
 Sat, 11 Apr 2026 17:34:39 -0700 (PDT)
X-Received: by 2002:ac8:5ac8:0:b0:509:120d:4311 with SMTP id
 d75a77b69052e-50dd5c02761mr126827901cf.60.1775954078972; 
 Sat, 11 Apr 2026 17:34:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eef0b4c6sm1705912e87.84.2026.04.11.17.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:34:37 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:34:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 00/39] drm/msm/dp: Add MST support for MSM chipsets
Message-ID: <bmkdeyquoyvcwcgucijcxmgnip32fs4gyqe6gvponokwiu55cf@7ncsbggx23ar>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEyMDAwMyBTYWx0ZWRfXzVZu+YRwStVL
 THZ+MkC6jecHdPf0LqGo8257sx+nP/AGJ7El2ICClV9FddR5pDUk3hZB6Yuk9viR4LCsxPaAR5E
 77L9sxZ72B3bA3jbAMzeuD4M3hzWUoT3V7WqUebKGwuKHfhaazT25PhtA9aBU226KD/14UFc1dN
 Yj/bp+pD0rCYlw8BHxUdxF7iBQOixmAhNpj68iR4ZyMiCuLw5BPeQ2rhHpPC3IciAeYlwmDns82
 XuEmdtw8rgTezYok5rKCqfLKRruR7Qbw3lGAIeNUNZgY/Xj+PpnDvQqSLTfYDrGl/sHHu3OPGdj
 qoyfSEyTtZnT4Qq8G4OpbJaXvHdv2VVvpXUgn6R4E9KpkqZYCX4hwX58Q006YUv9b82qPFbdJeO
 5dfhIIaC83E3570WnEVMxm9B9Nzhp9Kzj9yNTczeJ+eC3OPypcTAn44Bj5exk6rVxj0OZn74Cz9
 vNl5oRMxf5xVewp1tnw==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69dae8a0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=Eq5kGMd5Xxsw3PZyeDsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: EqqZZNjTl60DNic6qZe3J9t1d9BbZqod
X-Proofpoint-ORIG-GUID: EqqZZNjTl60DNic6qZe3J9t1d9BbZqod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604120003
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

On Fri, Apr 10, 2026 at 05:33:35PM +0800, Yongxing Mou wrote:
> Add support for Multi-stream transport for MSM chipsets that allow
> a single instance of DP controller to send multiple streams.
> 
> This series has been validated on sa8775p ride platform using multiple
> MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
> 
> With 4x4K monitors, due to lack of layer mixers that combination will not
> work but this can be supported as well after some rework on the DPU side.
> 
> In addition, SST was re-validated with all these changes to ensure there
> were no regressions.
> 
> This patch series was made on top of:
> 
> [1] : https://patchwork.freedesktop.org/series/151522/ (v5 to fix up HPD)
> 
> Overall, the patch series has been organized in the following way:
> 
> 1) First set are a couple of fixes made while debugging MST but applicable
> to SST as well so go ahead of everything else
> 2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
> of the work as current DP driver design had to be adjusted to make this happen.
> 3) Finally, new files to handle MST related operations

General suggestion. Please reorg the series into the more logical
chunks. If you are touching enable / disable path, then continue doing
that until its done (more or less). I'd really like to be able to merge
at least a part of the series in the next cycle, but there needs to be a
logical "halfway done" moment. Let's define it at the "all paths are
refactored, all booleans are in place, we are ready to get MST parts".

I've not found a use for separate bridges in the MST path. Please split
the functionality between the MST connector and, maybe, another private
object for generic state (like connector -> encoder mapping). Other
drivers don't have this issue because they have fixed CRTC -> encoder
mapping. MSM doesn't so we need a separate way to store that. It's sad
that we can't subclass MST topology manager (or its state). Maybe it
would be worth changing that and letting our topology manager handle the
assignment in it.

Also, I found a set of warnings while trying to build the code. Please
make sure that there are no warnings.

> Note:
> Validation for this series has so far been done on the latest linux-next
> on LeMans, covering both FB console and Weston.

It wasn't. I couldn't apply it to the latest linux-next. There were
fuzz-based rejections because of one of the patches merged some time
ago.

> 
> Broader validation, including additional Type-C DP use cases, is still
> in progress and may lead to some follow-up adjustments in the next
> revision. I wanted to post the current version first to collect early
> feedback on the overall approach.

It's nice, but please keep in mind that majority of users use Type-C
rather than native DP connectors. In some cases your lack of Type-C
testing affects the design (e.g. for the HPD handling).

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

-- 
With best wishes
Dmitry
