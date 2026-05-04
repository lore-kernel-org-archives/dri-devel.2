Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E551CCD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D93810E823;
	Mon,  4 May 2026 19:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WNJqRhap";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NaV1Dgn4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A169E10E808
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:18 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644DrEM0331109
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QpEOCCW2frO
 5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=; b=WNJqRhapNaIGfUkgELB7bB9p/Sn
 wH5IACswdNeuv7ebxiGWk36eB5G2Ebvb1fl3KZSZXnXIjjij6ZXTLArrDA1f+fqY
 b9CV2qzT/9a0dVr2dZisqn3y/zx90Ct+9LFEpE8UiY2vZ/53eyNWJOhPqPwu1XYo
 ooqzIbpD30qd9g8tPgbFUrFjBeeGyrUzmZPpJ5/5kpGckMEADraHB+e36H0k/8hx
 z2ShEhfAc1aXG6mBggBJ5pb5aLikiCkrJ6KTA//Jtu+/+79OR33KPFRooYcNheeW
 NrIpOVrOtjLYlOeI/EQVS37JHXgSZvQqQ6PlscG/N/cEVKb0yoplV/DamLQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr198ns-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:18 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3653e382405so1674465a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921697; x=1778526497;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpEOCCW2frO5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=;
 b=NaV1Dgn4br/6nSjVo2ncVFpVvgVJb1JpokIta2QCUEpropG9xBSzGUrvdi5AUgnKSE
 o2eizj46c8hOWo9zPNV0X9Jnf5tr4HhOsFqy4C+hB36cP6AJHyaPsiEG0ySsgTRLp2SK
 kIquNJeW3o4HweWn8l6FcaP7X+utet9u9jEH0QHGzY+XYOr5HyBJvAzktQWP7g2+XVc8
 80DO1j7cysFq+G771mgOoBWO660QIM3eTT2WrT/ET1niqTRaWLqmnIbCQ/BRfSWXvQZo
 pDsRDE/4sG8S1cYTjoN39NzirrBZj69AV+2cJ6slgiGE+FiPzvkZIJzfNZMRjHNKXLCu
 d0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921697; x=1778526497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QpEOCCW2frO5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=;
 b=CG+d6g9dhxt2C4YHpzNMS55JDmMUs/DZVAR6TabCQ8a/vRBtuKL1HaUjk6eSN4A/qb
 MHk8JPHuuTIiPKlwtsQDTjB8tKBNcXpRAJYsQb/vjdsKjeWqPKlGgOQ/okM2PNogmAt1
 rOjtvGk80pvl9tWgRPod/yqeXWsgOwmmMrgOwvcsFqTFICloobIn5+NNXFF3G3mIKv5r
 ff0mLvIlOvzkIDGzNZsmeMy27y868QMMOKdFWz6ZTtZBSz3/f0D5qTM8IhLKmhqU36hh
 6HklX2mNVijuT0DC/XzkSs41kIGUbA2pS1wQgPoReTB/WW78iWPeBBg7SMsUaq1nfgVP
 IFJg==
X-Gm-Message-State: AOJu0YxLYVlZpGoG4ZENPY1ogI1VKcfc2rSBfN+TkcmETGBlCIC3aLfJ
 +Ccq6rD4DVM3V5uENxNiQhe55/Wi107ZM/igaQ+ctGERxlQUzKXHjF6yGS95CHufldsOsxv6/zT
 thD4e2+CvXjb/agSGzi3LKhNmlHQoogyvSAz9k3izNJmbh8Xmq18nBFFPT4dKpjEZVXQ0NONOou
 Q4XJs=
X-Gm-Gg: AeBDievIy9mHW0633R6k6DQiBvUGdUKHSLT8cLCkIg7FDyqQNXIVXk6FaY9Asr2tume
 ZKQZe2CKVuN5766455yTYYmJdE8bei4mZTi8jBNPhyVfIoAlimrKLNpJmclGf4WTgEXR8FVUI6I
 Qnr+3diWnXfRFmCSrQrjWujSkgMvN/mEGyZtEAZVIP8KlNuAIxOjUiCovdiH7SMHb/o49vYXxzc
 I15v3fMF7L/nUiDWkcLr5l6RJbzTPSH/CQBDiJ38rtbaHsGngwTPUaWhJH93d021Yu6/nb1ef/3
 npT+Vn39741gLoUNymIQUJS6C406lEunFyT+5L7OJm6xyRdrpJ2W53+SIVNpC3xFm+/KweTnajd
 CEYLuv9elKNOSrn7FERzCqkVLr5k8c0tZzSSuLdGbHhM=
X-Received: by 2002:a17:90b:44:b0:35d:a90d:580e with SMTP id
 98e67ed59e1d1-3650cef4475mr10744338a91.23.1777921697410; 
 Mon, 04 May 2026 12:08:17 -0700 (PDT)
X-Received: by 2002:a17:90b:44:b0:35d:a90d:580e with SMTP id
 98e67ed59e1d1-3650cef4475mr10744305a91.23.1777921696879; 
 Mon, 04 May 2026 12:08:16 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364f48be507sm4609984a91.14.2026.05.04.12.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:16 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Mon,  4 May 2026 12:06:45 -0700
Message-ID: <20260504190751.61052-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HYAcAloov8Y1k9PN2k0WitwpcYcT9XFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX3gkORY5AsAa0
 oQEJLZPPgfVDYFVTTrFTOmniYQqXXJSNS5OY6E0IsrJ8yLLsYsAJJHJB9RvX5gMMENvntRSZSnS
 6z75ds+Yej82IB+s7OioOlYLCtWoee9HJz7Jw1+HXPot+3LdW4NwOT4VIvWkeYkWly0mxTJRWsh
 OCjWV/6wabqBsZQNAF3CKzEGaNnmJltA+cG2GDyCZRl48HKD4HMDuSHHG+oPFeBKZZktJVmpUSx
 yZjgtq21cbYwchr6TPqCE8OZ5K4Vbxq5YZll/6mmI6bBxewYySQiHGgIt7Z3EyZKTW/jN/7b7Om
 XRiT+JDa++4KQuXwNWYaf/8SEBTjyoeOGAuovlZYeu9ICE04EJOuFcbKN/CEm/fM7t6jpM9wimk
 FCkIQ/HaDrJGzUHh/Z/xxVi1bMhQCsx2kXduXrFLk91oGrbC0P3i1fKfT9fj7+N1QD+4WIiNL/k
 Xb2aaGQW3ZBongV5jOg==
X-Proofpoint-GUID: HYAcAloov8Y1k9PN2k0WitwpcYcT9XFc
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f8eea2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=ZRXlmS4ShPoOlOK7p90A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040175
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.54.0

