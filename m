Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE28C54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5106E10ECD7;
	Wed, 29 Jul 2026 15:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kXHWtps/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AVPnEqI0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD0A10ECDD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFFlUJ2092562
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nr8Y2kLGOAQ
 fP+6If92MLZogonNmCXdm3m2GqTYBhjE=; b=kXHWtps//Rt18b9iSdW8msUMbV3
 /yTPPMO/9q2Gw4dAShfKKmTJD+2aZ3Gj9N0v/GQ0cUCdmQvwiXyBxCz8aftN0Tiv
 98C8qYyJ4cqe0iJ806MEU3IAgPi2Ar57kC/Dzpyjw7gd9R2/QHuYZKfgr9p7NXff
 AoHfHUfTaArwMMlUqfdJ+Zq3/LVm/NqBVpgTEEzeU09WDzITqi7J7Dabi9H81AxS
 of0H93OHa7AjNIer3S5IAVBCgPQVstNGmXGjHjR9Sdddrih0vvD/pWU5EjiVP4yk
 JKpvNZI/Rl063xqKgIlQvHKPtWBZ3j6TKFYYRzOyhnmv5lq2R2iN7oQKQ7Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqm0fgb5y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e63de75aaso1738623a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340619; x=1785945419;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nr8Y2kLGOAQfP+6If92MLZogonNmCXdm3m2GqTYBhjE=;
 b=AVPnEqI0FyBxfUBSAonZftFW4neSI78WQjfgOvfE1bgpOBWXe/w/l94ssFQawhoJHG
 whWY0Q40gLvPQlP/CTujR6sowP6Vbf6Adg9q+UnbQO+EoVcHOm6GW+yptsAUHV7jltfL
 K17h6R1wUC/eTU9Bem0EEsnVtLGhWOGFt3K6gUByCWRQ0LKjFffZ9fU93IJjRugaibHK
 0GOvgvaW2SraJ4XMKlXqMZhEfJL89C0LszKdWGmLrbZpUQNMsPD9lFoaJ2Pu/7vtZeRj
 3vgsdf3H2dL8fqSWODdSvublzVe0NkOMguY/6d4ZtA9nM8aQJ4j71qJyqLeokK+/H3g0
 K6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340619; x=1785945419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nr8Y2kLGOAQfP+6If92MLZogonNmCXdm3m2GqTYBhjE=;
 b=DcXwCSPgz1vRz7+Ay5xsf/J4SdaZEpduRmo+xDlglq5aPuZjDFlVdwDcpjN/y5bNPW
 QB4m7Rdi90LloAPIIyJn1aZCVRZdpjjgVdiehGPfebdUR10FmQ+Ry4LCuv8Sx8K/+7/i
 x7HCubhaw6UVbfTDe8+q36BTmVWjN7Rb4QftXFJzLF3fqezRh2AvZsmt0qUJnk6HwPcM
 qNWGJVIRbFI0A3eR/SvFhYIegpbj0d2nEeP4+1k4zx/qsN/ezNz8KyQFCrUCkoSlhuAk
 8VM2EjLs0MBy33iefYgyPa4RHzd7oS0Jr0COm6zg4ieSacUcGpZk2sBprH+NoUBX9ozO
 Mekw==
X-Gm-Message-State: AOJu0YxRcl+X+DnD+/BlIGhJbtLekCLq21/fkNSnIBp+oGLlB0v+8vj7
 V55HV/18IddCpbQp0A3HicyAZeB24/N0du+VnmKLJ9kWzEiapaboq2XuGV/YKUkRT06DmvqhSji
 f8sSJVKqCPVag4euX+Fk9JxUI//FkKAlnS4ZGlZXuM92ofwUkpjxM94uAc3d/BUHKce3fYkhl7p
 no+qs=
X-Gm-Gg: AR+sD12vdJ1KVCC0NCDaT9Y2U2hcVm8B2AZpK7wPuI5PHtafGzBAxAJqY/hvhM3ZTQC
 IRE3XNBc7YvGWPzquiW63YcrEqwKEZb345KTnKn79zcaUglnCcnCkNkMxj57q9ZcEjUgr3mpqC4
 3NFjSqSQvfWJr3MXNYAu6BldJC3d1AmfH8E3H72MESFm+8iuqgm7xRAulDP3CeNalOQIZPtBWP0
 2Y55212bBMUgwUL5GpiLqkIeLc32+2b/lx8AqVn3UstjirO50AGyqYjLhWbAyRkd6tQxbJnLpYq
 Y+i6DOtd7VcosZxhtlgEAl23wu6L5gIYITMh2BUqxOER2nCJYZjJ+gUjG5ABzdaBBrW9rFdqmMt
 l790KzhAH+3Lf/DK8jpB5MCy69q/xUH3gFcVLL1n4DN2LKbU=
X-Received: by 2002:a17:903:291:b0:2cc:f4d4:299f with SMTP id
 d9443c01a7336-2d015ee2321mr87596355ad.27.1785340619619; 
 Wed, 29 Jul 2026 08:56:59 -0700 (PDT)
X-Received: by 2002:a17:903:291:b0:2cc:f4d4:299f with SMTP id
 d9443c01a7336-2d015ee2321mr87596035ad.27.1785340619194; 
 Wed, 29 Jul 2026 08:56:59 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a4af04sm14176905ad.31.2026.07.29.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:56:58 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 05/17] drm/msm: Move nr_cmds initialization
Date: Wed, 29 Jul 2026 08:55:42 -0700
Message-ID: <20260729155609.20190-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NOGPH7vw2Vc8OHY_tspty5SXhcpbc92p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX36M1ZGRR47/+
 wZgG2TkntMps6wcdlDShgoYHaUDo/NiNcU34xXhCf31MtJZM/diFxu/sTgBCQgdnl87jt05tfmQ
 pnsrweH3exvkv1EJyPisXJoty33JmQw2Dduvnxux2Hg7QuNCCR6vLdAmRmld6kWzd8jiTtvHVDi
 HFVNm4/CjR2KWz9SjF2Kk3WtqXXedyhn86bgLd2tO5ZA/2wha/GD+eAqLVB3Fwxgmfy5ypFlPYi
 Uzsn11M3v2kTJu2xp01TL7N0UuNrgcWLJ3hMVsbcKKzsQvN++WjV5JA3clzo2rRBhjflXwMjeTe
 qrF9Nrb9v0rW1iApqdGuEtPdq+sVm7y5CK+lGyrtcTqJQ3PIiCVPrImEr5QoAK/klmCY3SAfR5I
 zGhmhn9r6h0Ubu9DNu17UtrgaVBXXmBWmmENaif6NiqPN985ZbRejZ3gLjZ228ILUErFzBqPrdR
 WuY47b82YrnHYPFvGLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX+tPU4XZChSb+
 MsMYsP/hpjv6sOfjRimKw3aLoXL8B3C9EEGwA5NEYsRs4NL8/bx4VjmxVW7d6mj/4oxqYZHJJty
 aq/tjuT9qM0XozQ/tijPT6RvGD1J6xk=
X-Authority-Analysis: v=2.4 cv=LvuiDHdc c=1 sm=1 tr=0 ts=6a6a22cc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=F5a-vUUdUzRQ_IYq5r4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: NOGPH7vw2Vc8OHY_tspty5SXhcpbc92p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290127
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

Previously if we entered an error path between these two points, we
could leak the relocs tables due to submit->nr_cmds still being zero.

In practice, relocs are disallowed on a6xx+, and non-ancient userspace
will not use relocs on earlier gens unless running on an ancient kernel.
But userspace could use this to trigger a memory leak.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3c6bc90c3d48..aa48ea4e7f58 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -260,6 +260,9 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 			ret = -ENOMEM;
 			goto out;
 		}
+
+		submit->nr_cmds = i + 1;
+
 		ret = copy_from_user(submit->cmd[i].relocs, userptr, sz);
 		if (ret) {
 			ret = -EFAULT;
@@ -719,8 +722,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			goto out;
 	}
 
-	submit->nr_cmds = args->nr_cmds;
-
 	idr_preload(GFP_KERNEL);
 
 	spin_lock(&queue->idr_lock);
-- 
2.55.0

