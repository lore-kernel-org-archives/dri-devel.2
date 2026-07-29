Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738F5C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB78D10ECD1;
	Wed, 29 Jul 2026 15:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RDbDCgOU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVw1SkrU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE0E10ECC7
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF37tm3343219
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QToEERHB/YX
 j06omeVD4G3Qa5rVxfi5IbCI988AYdmc=; b=RDbDCgOUmHwGk3nNfzvBwVjdu1c
 T1f8qh/c04cVKZbKjexPmUkU9BvSuNjZl/95c4OXocn2EHqeashGBG+8lRsETOuv
 ePBVo4L2OpjGFWs1Yry/HOSdPtwGMILSr0iVCvf1+21hyfO5SiugNMzH68FHRJGH
 nwZosLbTpnNIVXuyBGrIbwkBoUoR2RkcjyFI+PnV0MTBj4Af1bmV+8jMmUj1L5Vj
 o5Kz3Tzd0wv1FrN9OEUbFPSn9cmMGxvjl+9S+m+W6HTlz+NK8CqAqG5vyHpDLLA0
 sTjw5J+HIi1r4EaWXjKmeYN/nPHfvi+T6fxjlGk46TG7ROZ3Egmb3CuA75Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ms6tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso1212275b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340632; x=1785945432;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QToEERHB/YXj06omeVD4G3Qa5rVxfi5IbCI988AYdmc=;
 b=fVw1SkrUQuFUeGE8rQ7vxa3ruihN1J4UZhPSIBxi43aVNCuxZuvsxOLbPKPUD0ad/A
 oyTMkBujSnukJPc7frXlBYKaD1dYeQpHm5JJKz+7ZydZfyYj/2lcdIG9ZxZJPu7y5Lbm
 j1wZP22DSZH8XGndKa61l9tGkBQU/Zt1L6sb6Q10IUl619tjtDtUwrJ5y+lpzJat0Zqe
 rOLZr6BeBrAHwDssl69TmqjTGQzN3YXQuAsTvwPRo3kKJEu1V/H+ecr6UBTLvKycNoB8
 AMX45NIAv5500sqMXw1YHjo0OvMqd8FWOEFWOZgaH3/rC+X9ryMTs7MrXZUKd1fHXXQW
 X2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340632; x=1785945432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QToEERHB/YXj06omeVD4G3Qa5rVxfi5IbCI988AYdmc=;
 b=OEs7X8zyzp4ieca9IvGNhYBwZHpXGUBbFxi5jpT4/9WhoS689CdNXnzC1z70NHNyzC
 cwic77NJlmcuexU923SDjNx+Gk7oUxi1ID6FzKOJ0ueqYeHDsL7dudHe7xUG75B1wagO
 SQ2Au+Rm03GcSw5SHqqa3waap4l7M/xMK3qmTnUkaqPStG5btsEzRCH05PqOQf72B+5R
 cbYL6vtAL40JLyB0rIXse7E3eC1YxklFKGmhJ3k9b1XHlLigrBe/OvhPbx7zMpyV9vhu
 Sq6cPij0lmVeKIJO9BxXHXGjzFe+pelZnuDR9PHL0T2uPGDc8cKx4MS9R4m2kqwg2SzB
 wcKQ==
X-Gm-Message-State: AOJu0Yw2msjggkl/aFsYvSypn0che5VR5BNtsZWOESg80dts4QKsE5qd
 Su2HG0uf8EkXbVMlvRuIoGTMPKwdZxMiTOfBQhmxxU9id6tLnw4BCh9Y8YOIx1jPL9mbMOzirpL
 OmaJeba8pQD7vyFzCxXZrw2zUG2lgB6wNdAOSaCYAcGrxb2pm9eIakyKSpbsuEMsF7GQpGdjN3U
 ixSsY=
X-Gm-Gg: AR+sD10zWJ9bRcRS3Ih35+z5EoD+lYmBkasF/PJeH4u7kMcjfdSdf/XA3rW+cowcXR2
 baeAMasPMb8cqmoBQU7v7sns5Xi1jMS/33FmCrLXOakmlVymbK6yJGU24cXwXr99zsiISZt6iEo
 bpU1GpCScBYUkUxpQZTTh6I7dwKJ8oQBnkxEpBuBlXpygxmBgESjQHXzTThZ+kD84XbxMlqWAgm
 MqzS+UvjaR8YP7d71yjx2NJoRiBfXuUGt+S7i48CCCZfEO0KkaduPJN+47uXNxFHaR3JRvQOqo5
 1m7eXOajneFPMawudDbfzhoxpDlaYLFLSLTUODa3SsQrNlBCsXrNLMEx1sknJfmFFkvJNfX/8Ec
 bzEycEIE+/6o7Nlpkc1NF8gUW+OZxiRNzUycSTX1zz9pF/rY=
X-Received: by 2002:a05:6a00:39a8:b0:848:7731:d95a with SMTP id
 d2e1a72fcca58-84e933e8275mr7336327b3a.37.1785340632516; 
 Wed, 29 Jul 2026 08:57:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:39a8:b0:848:7731:d95a with SMTP id
 d2e1a72fcca58-84e933e8275mr7336308b3a.37.1785340632131; 
 Wed, 29 Jul 2026 08:57:12 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdba929728sm1055763a12.29.2026.07.29.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:11 -0700 (PDT)
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
Subject: [PATCH v7 13/17] drm/msm/gem: Validate lazy VM in GEM_NEW
Date: Wed, 29 Jul 2026 08:55:50 -0700
Message-ID: <20260729155609.20190-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX9NmnPa/OEXQL
 enf4nTgfVpTPitGELcXeBumv2rSEnN9+QVHkPbXr+u1Ks/qR1pKG/kjao/YsVxlmKjwhLDxNzMa
 KHlwRZNFCmavfKrkwSzQK99JqFLEiXOOkxYUDYhEJJ2LfzSJNB9zK6xtPTUaarEj+ix+u62IK8z
 22720Air77hEvIh0aMv2lt6YNCOm/kgL574B56TP3Q3LTZkZectbE6rlvp1mGVDvq7VwTkeeD3e
 nslXE/bw3SeAvJ9mU4PVvQZe4rSIoWrNev0VlOi5NQ9Wgx+DlnRS6zbnt9UeFjagu4SNXFLCYDn
 2CxxoY22VEwurRZXPLoELOyh/p0XQ5K+5Cvd9pCAyAhJnZwDPgoNaN9qUJ6ICo2ZxNL27LEWYbN
 nxY8Z3rR5rZa1Rs2CSyMxD4L7+jjT7usdi41u2/+Q/sp4zkohhNGU7usjsT3I0Qn19T6tVKa/NX
 bE/m6VmxJ8CxsxZuG3g==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a22d9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VGCgC6sU4evaG-_1UnEA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: QNLgckyxXGiOzFtGnXcBUJljLMSkIYML
X-Proofpoint-ORIG-GUID: QNLgckyxXGiOzFtGnXcBUJljLMSkIYML
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXwKgdnxYX9R2K
 S1erLAE0ZsQJjfhGQS04pTHOm345G/ryvPZxqvLt9EqARuvZ888SMWkKX31mbF/QIq6hoPqCvFr
 hjTGgUPtHKL0yWEbUe/rEGwDsvB0h+0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 535c6e1acb3c..de4e60e28a71 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1140,9 +1140,13 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	int ret;
 
 	if (flags & MSM_BO_NO_SHARE) {
+		struct msm_drm_private *priv = dev->dev_private;
 		struct msm_context *ctx = file->driver_priv;
 		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 
+		if (!priv->gpu || !vm)
+			return UERR(EINVAL, dev, "not supported with shared VM");
+
 		r_obj = drm_gpuvm_resv_obj(vm);
 	}
 
-- 
2.55.0

