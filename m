Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BB1CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0081F10E1EA;
	Thu,  4 Jun 2026 20:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ie40GLMB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E4/9xKoG";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE6F10E1EA
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654JWga12477978
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ia1skyxQmkO7JqYCXK2wWQZtv88kEi4DeIduMmc3/kc=; b=ie40GLMBF0ujDd3p
 BkqF8GTZz62fxeG+88YY67NZbwf/mcH5U9+rj3nUvRkatHit1GoP3kmGyVH/QCsh
 Nt5LV6o0iIy/MK9iwucC3Zmez96CNPkPSoFrSP1QCspMT+lE3+PSzsF4HR1rTeZh
 ABNRkbDyWQqiTxUW5gH49nbcZRnHCAIE0Ahp5SRzZ5iH4nOpHYTEsxTb/mbu6VHC
 zy93nUrCZe/Fc93pZ7gW5pn/mQ8McLsQ/1p/p2v+ZnrlGdEQHXGLYOB2Eau33Ujl
 6gB2R25Ao7AIB7bnAPjbbJwA20y3B/mY7wA8SZGJ9zY0Sma/bZFcIjjeLm4jecnZ
 ElzZZg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvkfvv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:38 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8425a9979e1so725063b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603838; x=1781208638;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ia1skyxQmkO7JqYCXK2wWQZtv88kEi4DeIduMmc3/kc=;
 b=E4/9xKoGs/dZCvja/7AQY6vJujVMlb3CvAcNvfh2YZe3jdeMNTn6xz+bNaAX3/D6iF
 7M72c0VEtJbesT6xw63sBnCMNyiIu4TboIFkWsgMJRTxrPL/FR9tVKogZlTRkMHoPW/y
 d90GWQMcx5wuGGrX2j3c6fUnEiYWd3nA0eWaoqsEjshW65TqHW/NIqJCMOKY7ex5F2Xb
 EUamLJs9aH3yPh4OAXQ4zkm6iHIE54Mrv7f6dvH7URaNxH4yYQfHjdSxW2eSCQtaSnZM
 k4rJiOSorkO3zupw4T97iLV1Ynm38f8B7HHmQgtZpdwcPRoXJuf4tIfXwowLE5Ek1rwj
 Cr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603838; x=1781208638;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ia1skyxQmkO7JqYCXK2wWQZtv88kEi4DeIduMmc3/kc=;
 b=s0JWC/vD/v2vdGNIDxFNR5MJbCO97rJfsmsNdmuhf+HxDf9nbw2Q/dLG0XMZWXyUzx
 EU0l8iQ6j3bymWoJhZUD+eM86hrU9p7TWXqs8zSwp91tRKvV9ppDTw6yTponHDqKtc3W
 vlDiqXJC60Uo7zCzpZ8GAhKUetxa0DYkNLOoSAo92rbDZJOd49gRzcDAou5YwM+iUv2y
 KlZmsfM6/gmmoa9wfN/k8BosG4eNdh+NRs72zVzlma6vRGgxbfJEJzTepj6mGPKLKkGA
 Lz8AuBPTQ8OVT4lrc2qeGbto7H1lbMEesieAHm7vx3gtsxBWgzQvUK8No+ahfjgBiwZx
 zZng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uFkct7TA4jtFi0PN046oVA/NJOXXruRm+t7yWBO+E9Ut5uIhOdmZ9bww0VG/9ace5dyhLtMGrRKo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFUV1D2xrcC4lQgeqvRxTn9iwxJb33cioPChCf2eaRQnY7PPb9
 gdQQXULknvupCXXPe/BVr5ItugYdh87IdMCUsUVln8/HC++MR0PxW205j2x0oTnfFDWy81R5ZF0
 Zt2L8QjQBYUAO9MdwHzzwAj/2wCWkyRFxmUaoLCjCrbjnASA+VEUgoxssphsX12fgVH8TR9Y=
X-Gm-Gg: Acq92OHlLMdmvsKgWiOgdNYYN9fpLgzP13fkRatLHSqnQb+kVBO9AOWRxweRg/jgsn3
 IsCYAgzUu0qXuCuw//+tvDjwjSHHBI5DWKo7qgUbvz3U/SrbxuUvAWsRuPWnmdwQBPA55iuRwcB
 QTGlwl1yCr+Z0nQhccpv5UUASd6QnGm8jZqJiR3fgDx5djNe2RJw7r+bBM+ZutzWBvZB233JLhr
 tD7jEcXcdj3FrKDa/X9PBkJVlvwORZoLf20epaPazr6pv3GF8mpLRCbqgIx3pDZ1ATExK9A/GxE
 nMeYDeVxnAaSJULBK5uEpp0d3NJvxnizisfM526Rhv9ivnxZSLH5gPZwdAkq2TOBLMA1t6n0t6o
 VjksnM7c0oBi8uLVB8Mr43IwFC8/+SZCfijR66kEHvBeZwYKAwiNIVIVO
X-Received: by 2002:a05:6a00:4008:b0:83f:2568:d466 with SMTP id
 d2e1a72fcca58-842b1007fe4mr217717b3a.31.1780603838121; 
 Thu, 04 Jun 2026 13:10:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:4008:b0:83f:2568:d466 with SMTP id
 d2e1a72fcca58-842b1007fe4mr217695b3a.31.1780603837668; 
 Thu, 04 Jun 2026 13:10:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 01:38:22 +0530
Subject: [PATCH 6/6] drm/msm: Fix task_struct reference leak in recover_worker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-assorted-fixes-june-v1-6-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=904;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=X3vJeCumKhjjotRl6yk2pCMRTx61cAms8ve5tuXIPwI=;
 b=MNquq63XpQbBR4dEKjskl1CiKb+qtEacdlCYU32SnWmRLXACBNuc6h1X9R0rKCo68B1hhUVxJ
 WYHWX94jP+iAQ1SQJHj1Bzo8lcKhms0Svb6GrNBRovKuhfK4w0WGYZ5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: lCxbc3__KQYRWNlRLWAob3BEqDHeJCme
X-Proofpoint-ORIG-GUID: lCxbc3__KQYRWNlRLWAob3BEqDHeJCme
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a21dbbe cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nKn9kxNhn4xvKzSdCgcA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfX3HJ7jHTrPcDA
 SEQxpRJqqNIJAWgcraCyGdjT/ui6o6nt6qw5WwQm3aIBX0E75Ni2wGDkPNTuopVKhjwdSsPVsUd
 l0sYwObVZkrZtO9SZxMI0v6cDnSMG78yFDgd5yiLOfbRH0NzZr2vY9+E40Lo2O7OuqLXBBj0mkV
 u82+AUCzZp6Iz4bFzG9upUhjty5UNwqSvI+U0NPxLKe0oop7mQwg7L+gNkrqFTVYt/MS0doEL33
 YU6LyHnnNYAhXQl9PRrJhKSApQSLhjuMQpW6R7X4MpxONyFrW5lKQlrCDB+18wc3VdtU2dB26XA
 L0ZcMEKHTkajNDUtI1es4GnTDmMraEHwLLxXHwZ4SF0HUl1uk0jAo5p3BqeZ4fZIIPbFg/sTB+n
 QBA5m1lS6zKk6mzmmvN8xAmdTKIxBP1xCV4RLsoMVMfYhDRmjS41m3Mx5B0slw7Ln8PyV30c9ul
 +MYOvqedk6klCsPDPvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040197
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

get_pid_task() increments the task reference count, but the
corresponding put_task_struct() was missing in the else branch,
leaking a reference on every GPU hang recovery.

Fixes: 25654a1756a4 ("drm/msm: Update global fault counter when faulty process has already ended")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 48ac51f4119b..03c057856065 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -505,6 +505,8 @@ static void recover_worker(struct kthread_work *work)
 		 */
 		if (!vm->managed)
 			msm_gem_vm_unusable(submit->vm);
+
+		put_task_struct(task);
 	}
 
 	noreclaim_flag = memalloc_noreclaim_save();

-- 
2.51.0

