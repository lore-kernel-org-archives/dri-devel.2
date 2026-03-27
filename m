Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0494910F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DBB410EE82;
	Fri, 27 Mar 2026 19:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDfH9+Cg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKki33pd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404ED10EE9A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:50 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2VI5890267
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K6XR8VEr9ypixa6lsMOHaJVt1KW3Mhm37VQBvXFJnis=; b=nDfH9+CgSmUTr/Jy
 DUyPM4HxcFXuCvnrg1gW8YY5wolyL5bmU/VZq1nOWa5t9lRzcrYw6t+Jjn7eJtj8
 qZ9T6/A0ZhwuZY026SGhK6xdzMrLfrFsvQHcEr0gFLIVbmOOMNbSAXBW2XRLpvFz
 huHSaUAAyBISbik4HoET5P6dwPYbxpv5lAPCzPY3oaPgiQCdo6wxkaf28n81rgJr
 pWIfGcCqezlnvSb7pfEqo9aGaTXCjgkNp2nfD5rat/r455oWdE/5XnftMV3Rr6Ye
 HM34D9oCwEjHsHUjUhUtTRm9IIbneprd3hDswPrVXKYQICCMPB4WssTfijCQ8xXG
 j+OPrA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vf6ruet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:47:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5093b92f327so55623221cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640869; x=1775245669;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6XR8VEr9ypixa6lsMOHaJVt1KW3Mhm37VQBvXFJnis=;
 b=MKki33pdvdzblyv5OXnqPICzyU9h6btBllBNW+3HoJt+2oS114Ga86EreOZoDNmCzs
 RmAQGbsHP3gCIeWNGB6aOMDKetuWu+t8vcWzn9UjBlIkGB08r0jSwrdM8F7tuTq8BTtg
 Y/yK7nR5r1SiS2h1Eu61j4KUivDRzl/ftkiGiugy44G8/VQ55/TLzEwbH6Oe7LW5/O2I
 H70A+bnbhtK2zrMvVvo6tHf8vcwBH9Dh0Z6kveDt0wfu2npRMflbNbH0NoksCnx7OLXX
 t8QHf6PuED7p6tvRXKZBeTdY35c+mAJre8yUKnyUQBCQaelQbeyrSQXdo3WcRKdee9QA
 P89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640869; x=1775245669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6XR8VEr9ypixa6lsMOHaJVt1KW3Mhm37VQBvXFJnis=;
 b=G2rv7+ubYI9wx3FiSIkSd2bxuSVMIb9AfO0/nDFI8rXH3+d+nwkLpvl5xowBbmpART
 F1BJHU/eg+ii2Z8AlvckXLn0kZOBMFBFpYFTfjc3b0/Iju77O9FihRxhsChcwAwXQxN0
 WbqVQsxyK4rI2xJHz87DRuUy5ODY+/lydO87Hdco/yJLJkEo4KXTdFEh1d249VT+wAk3
 0CzdQKJ4Mcj9PpBZzRQr09NM0BnVGmko6keM377KLTYglR2DRkkOUSOb7NII3OrwWCvq
 8TKMmNoEyFcOAOFssg/njrcBDkZIP9WJoJvIA9nZBNPOQWI0d1hkft2MirJR+AG2SL3k
 tXNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0SMZqEbYPi8FCx34TmSl7pqkHt/k/2eeJVNW90bYxr05EHHQfK/xYkIaHZSMUnFYjZUdAep1QxLE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxkh9rvuGxOVtZoc+IFvwkTei/tzzW56rEixTAS5DStvZxf91Jr
 Hl2s9cyeck0CcsfuSidON21wTFtCpezsRHeQ6h3riEKc+5LZDVUmvj8Vtat/X1aEJ948Igp/YrC
 bYgECp3vHdx07pmbfP+jn0UfApWRWmVdUjnhlumy77HkrcB+IbiRewpzcUH3WwMZUXWDZ9oQ=
X-Gm-Gg: ATEYQzwJSF34vGw0wbKWXvsExbO0w9++Q0rENXIcV910bTEJwU2REiBJ+ISgRl7zg5k
 Q/EnaPlv954PTSichIFih3H+jQXybtsr37/VKAR30i8ZpJkfANwc0QtJDI22i0LJAdy5i2ribZq
 Jud5sROy/ofB0JK97V9ijcY09ccAi97KpvtoyMrDSPmofP7XC1hHGf+TrLM079I+wZ4AaWK0c6O
 zVW5pf+U16YRIJeUkX5fjGjzQt6oIHyEQ7wbr7oCnrowOgcKcjVv+gbOw8Hmt0PxBGBqZUxIYQJ
 YafVLWQXnM6eTqC2Viz7ng+inJ9MZZB9TagLUL+gxDEAamE3DnIUexuyV+5jnkdAK8R6wUYLHD+
 Fx0hpqDEVlubtdHbEN3Xhwle8niEfMlLHpHi5XjABnI7fxEeoSa6JH94sKE0e/5/XQGXuLzDUQL
 /yH8hS6pW7bowBID9Z9pLpld3RD8uDmIQF
X-Received: by 2002:a05:622a:4812:b0:509:31bd:3de4 with SMTP id
 d75a77b69052e-50ba39780fbmr53426991cf.56.1774640868719; 
 Fri, 27 Mar 2026 12:47:48 -0700 (PDT)
X-Received: by 2002:a05:622a:4812:b0:509:31bd:3de4 with SMTP id
 d75a77b69052e-50ba39780fbmr53426511cf.56.1774640868259; 
 Fri, 27 Mar 2026 12:47:48 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:47:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com,
 =?UTF-8?q?C=C3=A9dric=20Bellegarde?= <cedric.bellegarde@adishatz.org>
Cc: lumag@kernel.org, abhinav.kumar@linux.dev, jessica.zhang@oss.qualcomm.com, 
 sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
 simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix vblank IRQ registration before
 atomic_mode_set
Date: Fri, 27 Mar 2026 21:47:39 +0200
Message-ID: <177463970790.3488980.11725092140153098793.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318171700.394945-1-cedric.bellegarde@adishatz.org>
References: <20260318171700.394945-1-cedric.bellegarde@adishatz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X/Zf6WTe c=1 sm=1 tr=0 ts=69c6dee5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=3Bny_bJLngoGic2QnrEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: eL0nraH_HvoXk78kCncTUtUxTUGFnqeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX2tnM6hGavxmV
 /EKKC1WtoXt238jLel4A+XVQOsfWCXb7ZbXO3lxUP9n4MUAweh2K5Smbp7SfgiWaOkJLjGo0j5A
 m56OTkx+v75ZcfOXzWZGbVHM7DLcwPOxsVHF31wybi8tkE9cXXgOz83n7nd/Kkl7rRY1G6BSBZB
 XuxevWD6/cLk7BIUxeW6KJbgsIQ81Cn3/vyPlXBaq+JTa830Bcm/HzCnY++XGpSUhL/URRebBDP
 7lmWjC4GAVBIkeISH7iNFs2S8sx6SJDbwWKIuEUwLqqtMsOIrbUBrE1gp70sfCwHm34aR8KUIjm
 Nr8kLWzY24etsIti5K4j5m39YE4ks1D8DnPjKvYWjY3vBLS/tJzcK7ZJ+YHg7MtIMnK1Rv4HqDJ
 6hq9KsqMaUXGFhN/HYFq5J63xI8V9Xt6QShzutzNizm8AE9zIMHFi4a+WevakC7LJVFNDQ6lOE0
 qsDHtG5fJIHsYk2zqnA==
X-Proofpoint-GUID: eL0nraH_HvoXk78kCncTUtUxTUGFnqeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Wed, 18 Mar 2026 18:17:00 +0100, Cédric Bellegarde wrote:
> dpu_encoder_toggle_vblank_for_crtc() can call control_vblank_irq()
> at any time in response to a userspace vblank request, independently
> of the atomic commit sequence. If this happens before the encoder's
> first atomic_mode_set(), irq[INTR_IDX_RDPTR] is still zero.
> 
> Passing irq_idx=0 to dpu_core_irq_register_callback() is treated as
> invalid, and DPU_IRQ_REG(0) and DPU_IRQ_BIT(0) produce misleading
> values of 134217727 and 31 respectively due to unsigned wraparound
> in the (irq_idx - 1) macros, resulting in the confusing error:
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: fix vblank IRQ registration before atomic_mode_set
      https://gitlab.freedesktop.org/lumag/msm/-/commit/961c900628fe

Best regards,
-- 
With best wishes
Dmitry


