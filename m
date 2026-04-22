Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553A4FA1FE8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C088610EA9F;
	Wed, 22 Apr 2026 19:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NlyVYy50";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UW2w9FPe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D8810EA9F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:24:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MFftsN3528466
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7oLPkRXVPS252hXu7p5Tdr59
 EFiQlyvDx1eHWycECCU=; b=NlyVYy50poAmb6fNN3hUX8pPU0Wp3v8uJzgJJHxl
 92OVKz7GVo0uOaLik2XIf9X+o7FzJ3R/yDnouP/+iY8VTl23QUX9Duf9umqzkM2H
 XVutbH1SXpCbh0wtlk1FeP0d62XYJHjOLZ5O1NFcbS9h+YrDztHwviyEDHJM4OzE
 DlQxFgnsP8Fg3ulbr5L4bNYhRN+MLJwNRnAH7BIOVvjFMDx2fChTWIQtBks+dU11
 K4Zv+gfSMWLqGf7j5w8cKTexDxs+TQMGEBd/Gthz5rCQxE8Ja4CTHTwvn8uFGnU9
 tt3DcOgrqpzsmwdbtjKTi7WnFMGnAALdEHGPQPg4WOnAfw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wrt5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 19:24:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e67a4f642so82691591cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776885846; x=1777490646;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7oLPkRXVPS252hXu7p5Tdr59EFiQlyvDx1eHWycECCU=;
 b=UW2w9FPeVNEeW8bTG3YB8daNEBzwhqmVQVkkbxpHY/gX0AZUeJo+chMLfq8ySNyutc
 0GolTro8K0dCcjhrrh741HdqCdF/9qvmIFbM5qIQosKK6rZ/ziaQ2eBUVs/pTanhGIJ7
 m/SvV8qJsHOHYeErzUY/dDZTc1mhiAMHr5rzXx6j2aKWNPKrIXqLCVMEB2MwpFgbJwX/
 EPVLo8+sNimbGKTC0tRan3NdIF/mIgvN6M9C2hkjE0uJwDQHZdp5ojNrUSOiTxUg/OPa
 rkpyk6sBz2hZpIoCN9lzw2ExmtKq0+++onnuFHfGr7u8UEBv40RIqJ4ZhhSVUTrtwRqO
 hTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776885846; x=1777490646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oLPkRXVPS252hXu7p5Tdr59EFiQlyvDx1eHWycECCU=;
 b=gesm7U5pSmEwKNUOdL1IQyLEAnrukz4ms3xWh2ipUJjvjwzwpmax2jqX+Aw4FKJFIY
 ml7/dMZ3HoxQsfY9uSAR4+RHjUyfTKQw/Wf2VQLLj03vvp/8HxXRsAVoS7W5ZGdb2k+9
 jCejdINmIHR9yggReisYFkTn5b9KlnDz/YoVFreeFm9r0quDrc+QaE76E5AOgGbbuuzI
 DcHbj1ZygA8b6T65YiWFFKS31yAeIQeTgLmp10PcSpFJmEehJVD0phHYTuDQLB/eYoQK
 f/VJumVgFK+IlTM+17Wkh8X7pUdwjBxBHmfCiBZth2i025BO8eoiAUaYNrGk3Hbc5IB+
 D/yg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cBxQtVBYJ9tRTDf+1/RJmQ2IZOq5eWwEFYv9SFR7HUEO1MuHuzS1+p3aGXm4TZxb8AbiaNSLHo9s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAPrnS08uObV/hfb4d2hZu9bVMjQDus4Kzdwi1vksTsQEyFmlj
 7QSQcS0v027savZeDankUb85P3ImPUde/KFxHXUIvPY8bnSoPf3C1aJVF8ntVIgIwuzmcerYHV4
 +8DRSuVuYphPgESmxp5u3STngvgUxaa2l4ncqWncGMbh7iHjlUtiJ8Lqj5UMmTCfPvzZcbIg=
X-Gm-Gg: AeBDiesg3UKwmU4voVwWDzFPoK2jD5su5kx4+8fMVkFOO7c2/gJAL0WcMDVyJ2qwsh2
 PuStCdhOx2H2Vdx657yvttIl/vr8UmTi0h39qFNfxt05yg/o+h617wYtKbvnpp24YMCpmpLxWlv
 MKZ0Eo5qmwoWAWtiA8+L89JJyLELZx6tr1+RlOos9wAR3jgKRbJ51tCEZLKisMQaD/0ebpakZcG
 Rk4OvdHOdGfevKoR3RU4JVXzzfpooH4La/5IJ6IAuay0PxoEGkXUNoIxZL1zxpMZQgsVPBjQ0k1
 FkP8K/FUcIwlR2BvCQ+Ub9RzTuUNYZRWCVqRXkvQvlfck8/U/+bDWOTwHwPbI6vJofXfhz8pPmi
 h/N8J8zHHMtOjkJxDxxBk4oFLwBu8UlmT2CNO/U1DAhpM2Gba6S0pTxgOET5KfEcSRadyQpAGOb
 PLkz8NrjQxEOowWV735ToKtCMTSoNKXwf0NKH3kYOAi15Low==
X-Received: by 2002:ac8:5f8c:0:b0:50d:6907:56cd with SMTP id
 d75a77b69052e-50e36ec40e7mr380660961cf.56.1776885845833; 
 Wed, 22 Apr 2026 12:24:05 -0700 (PDT)
X-Received: by 2002:ac8:5f8c:0:b0:50d:6907:56cd with SMTP id
 d75a77b69052e-50e36ec40e7mr380660401cf.56.1776885845363; 
 Wed, 22 Apr 2026 12:24:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a5241f6583sm2303543e87.39.2026.04.22.12.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:24:04 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:24:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>,
 Yuho Choi <dbgh9129@gmail.com>
Subject: Re: [PATCH v1] drm/panel: lg-sw43408: remove panel on DSI attach
 failure
Message-ID: <3ihxcwja3unx2257xbbk2e2aeiptb42bjkti6xnipwnvzrigw5@mhjhwckbyr2s>
References: <casey.connolly@linaro.org>
 <20260420073945.65849-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420073945.65849-1-mhun512@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE4OCBTYWx0ZWRfX1AcCjKjcZDB9
 1xyFCLoEtpfxzblC0iaTQ4m67Ehmuzl1yrNO29a5IetAcAOssVXHqjOXmJPfYvSCSQsStAwk6Be
 pcYldtwgPi+P2WBx9So0yMbtVXpKwAVF1JGFDAgDnQdK0wA9cGVg6kYTHS9Pmin3hlo7IXr2FP7
 EcD1m26FPSXy7eCaZhOD0RWPQ7m6M5B9/QC8k8oYjXGAi4CRzMZw0Cn55fG38SMUgt5A/+S+/3U
 FN4LvqsxFayG5B3O5EKdNaLGsaKQMcbnH8c2GdjvufFA0WdTbqFZRTKDQtubzsvQ2EvHw2i5jwa
 q2Tqsklg/mD/Z4QA6a3N7R2KksCe/ENwn/3+RYpdXiNvE2Dn0qh2rnhXNo4OCGYJ31QwO6Jths8
 HD5ayfmowSvRVSQ75gdFx07/+pYdbu6wfmECHuDuGQhftu1xLI2pw3JhWOyW1DyVxrn8RtOCNAd
 UUgGsiMi1xA0Hf0/c9w==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69e92056 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8
 a=Rr31s13eGTgy8hZw5cIA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: QQOLCZ6gGnJstO0GWy_44koiGMt_9wFf
X-Proofpoint-ORIG-GUID: QQOLCZ6gGnJstO0GWy_44koiGMt_9wFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220188
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

On Mon, Apr 20, 2026 at 04:38:27PM +0900, Myeonghun Pak wrote:
> The probe path registers the panel by calling drm_panel_add() in
> sw43408_add(), then returns the result of mipi_dsi_attach() directly
> from sw43408_probe().
> 
> If mipi_dsi_attach() fails, the probe path exits without calling
> drm_panel_remove(), leaving the panel registered in the global DRM
> panel list. The .remove() callback does not cover this case because
> it is only invoked after a successful probe.
> 
> Fix this by unwinding the panel registration with drm_panel_remove()
> when mipi_dsi_attach() fails.
> 
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> Co-developed-by: Yuho Choi <dbgh9129@gmail.com>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-lg-sw43408.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

You can also switch to devm_drm_panel_add().

-- 
With best wishes
Dmitry
