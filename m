Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DD0CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:56:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFA810EFF3;
	Wed, 13 May 2026 18:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bUD614Ik";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zs7YYuar";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C16710EFF3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:56:37 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGuOIe3995749
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=y+b5KahouhbwAIhBboZSol26
 da2D8dxI3ira6HX/6q0=; b=bUD614IkbDSuQUd17+BNBVn4XCudpG6IPe+ltoQx
 DHjsycoZi/LZyPNrXK67kUAQJkmtQYpe80gDgB3AYLxSLrm89G42MyI4U+wi7elG
 EbrriJIVx+5QLhl+pYglAU9mm61KakQYrcHnmJt9+EYKXoNrwDTBqzGQ9Fe3sTxR
 lYp8VDo9xc6yexhuqMFocRfxIYyL9b2Nj74Uu6iHctEAKYzL8q1tk1hxVDdONUui
 G6N3uMFm+P2Wcfc/bJmm0YGGL26/lXTw3G3lNRpeyVxREQRf9/cOyuyJeOJ6dby2
 WO4bvMRaXdIH9BomZ0103EtP77FVyEDcPWyj2TfZrYqzGg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8urgwm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:56:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50edf01172bso18424731cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778698596; x=1779303396;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y+b5KahouhbwAIhBboZSol26da2D8dxI3ira6HX/6q0=;
 b=Zs7YYuarj77wSoGY45YLYWWL3lo+Y2h9jA/s5Kgo1T2iHH6y/x0Lsm2OyjDLm3xPX9
 pyOT1Pnbm06dGfBRQmojZCgLV6gQJyTExIQG6Kf4NOmcB4F7b8FKDBYf65mDOzyT1BPr
 Aa9rNH2Bcx8KBVenpXqTB+IZ+yDoP0WAF+frosl8GznGV2is53oed6PX0XSZ1yMEL614
 XCs9lfSeHsvfMiLC8QYI/i5BTmD5oN8mA4t7Du6uqac46jCpHo1twYm3b7b5T6dz2ugJ
 emsjCZEWxnq2Ifwz2gN/NbMk8S9M1EwH81Zjtoo6exyD51q7t0A8ruOm99psJK74wwQE
 ZKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778698596; x=1779303396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+b5KahouhbwAIhBboZSol26da2D8dxI3ira6HX/6q0=;
 b=gmxlXoMYjoL9jdmxglJj+aignMSCC6bG//VwH215r2sad/Alv3Qhu+wkIlC88UDYL8
 bFmehAeqLOnTv1r17JSMiwfLKFF1H3CAQcEmVXE1FrCk1ZePayXt6gV61jeo3fnlBKcZ
 Q4pUGiYMqW5P9QPC3tKTi8+T5mTSYRRX4nol/cw7G5mBG6To5QJ5CWXS/kCoREmNyy76
 Q0cpvw4Rg9AqKLypdoVUQmuXy18eqIbQBAhxDECcOjpzYabkCejMPusFjX5GAMuhhQur
 bVC6m47rNQJKevcq/LheyTQT7oPbEeOfddsrOGu3X2y06xwJHbQB4sCCjiUC3p0wswq4
 k9kA==
X-Gm-Message-State: AOJu0YzrKTk/X22uqNabnYquSSq6QFuWDLzsmDUpFv5wj4twrb3/fRpy
 hQ2H7yS6RyUAB/ybIuGmVE/At8orhRfHQc3IRKheIw9YOtFMyRDET8SovK/zPUcPvmjIlm94Qtu
 pU4GTaXyJaP+qQsrQ14qHAOcGZK2SlwczSCv6v2CBT6MuV8xSGCVVuRGokbMcr59HORnPv9A=
X-Gm-Gg: Acq92OHOlbdvnumV4tWwbmhKz9tDIGXdoF3nWXuM9JHiRMvDogSif/BmSpEW9RQSIpC
 HN+X8nG2pENR7ZOePV2+V6x7bTIoBDuZavcbrBgrSE5vYJorJfL6ZnjyO/B3OUpVjVunZRZs7NX
 08izbP2Yt3wP2Tr86lr2msW69DlwimlmTg9SfJyXF3L9WWg+lK+ztYczvUN94WmC0gHHM8YRhis
 dR/LV0VWK97ZpXuZcWXtb5Dpg7nY2IUGIQLT6LzAaStJw7mVNZgyUmmG3PfVv/LVSlJ7k9DQAG8
 Utmb2zqFN5artdHl4aDn0Vd/uTAFJSGtY5wpSboeXMOv3B23B5qwSUBBywyTLliWRbr7//uQDgj
 o4L4nlEuK+l/spdhzUcUmz3eHGtKCyq2OczVlbdTJnXp5t9eqsX4OMGGr9jjCD7YbKSx29sonxD
 G+mPcZuz+J7zUd4C30Ho3jxzYYSBZHrlR7OiE=
X-Received: by 2002:ac8:57cf:0:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-5162fdd2f26mr62626081cf.7.1778698595702; 
 Wed, 13 May 2026 11:56:35 -0700 (PDT)
X-Received: by 2002:ac8:57cf:0:b0:50b:29a6:8696 with SMTP id
 d75a77b69052e-5162fdd2f26mr62625361cf.7.1778698595001; 
 Wed, 13 May 2026 11:56:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945cb4d422sm447201fa.40.2026.05.13.11.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:56:32 -0700 (PDT)
Date: Wed, 13 May 2026 21:56:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/16] drm/msm/a6xx: Add yield & flush helper
Message-ID: <mdls5yrexjfe4x44r723lpe7noawco7i32xf6ruopnlvsnpmgj@eiwghjos4trt>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
 <20260511130017.96867-9-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511130017.96867-9-robin.clark@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04c964 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=w45FyVj_P0zaBx9YAu0A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: _zzkZ8fMyRGIxh_yzhtfRrVWtt3sqfA3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NyBTYWx0ZWRfX8l2LXiVYnIZK
 kL9zxtHjPH3sd7KfOeYtZ8qy2y+ojz4gpjzAumTIYaY/z445EomGO6VzFlKUDP/oREHqERT6AeS
 qnVcJShX4j/UPVC2dtYc+wHInceAI/HZNOPE5AqyAv1ZJJyCoShCH2PuGaIx/RkE55dTyqbR0HW
 XHYli3jKc+rlQp1jzMzhj3BjkwN/BQxesvpxgRrEwUdNw+GiDzQzrIXNPyyJatgsLVRE8+vry94
 1/EMcZb4BNuhhiulsxlibt4a5iUxCuc4/s+8BuW43Q8WhgTiOanpePT/IyUgLvqOP3mKSySCDXq
 4kygrOxWDGyQtMOaPbqnyilLYpIOZH9ci5+316FyNu6Ya5BAElDPceLdVkR0MvO/V6S2k0ECNB3
 Kan/+R66INFqDcnh3rvkJPEjMGLYQkynVu1rjaXQqOJc/LlKno5jtmJXfPnYhttz+vhRRVSxSPl
 QiNKela92RGfwjiP8ng==
X-Proofpoint-ORIG-GUID: _zzkZ8fMyRGIxh_yzhtfRrVWtt3sqfA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130187
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

On Mon, May 11, 2026 at 05:59:21AM -0700, Rob Clark wrote:
> It's a common pattern, needing to insert a yield packet before flushing
> the rb.  And we'll need this once again for configuring perfcntr SEL
> regs.  So add a helper.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 +++++++++++++--------------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 10 +----
>  3 files changed, 28 insertions(+), 38 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
