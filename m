Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EB606A332
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=chtUgxUh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C+jDOkPm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1EC10E3E0;
	Sun,  1 Nov 2026 17:49:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98ED10E3F0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:49:24 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HQAVh1443658
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PfKYqLgzZzm
 YKZpUbUyekzc0kmd71RSx1CMCJtY98mY=; b=chtUgxUhfKLFu4EYyhY58yJJTJh
 NfS08mSF8ubxnpT5RrUk5TPrC63MrpBbf2mBqHndJSVS/AcmIy7EtrdNMXPL88eo
 0yixR1GcWGnktQv7DagFtfpTbxJXm32d+79ixb+7Fa7Sr9jQ8KBbFPj0+zAznRjy
 efJafFfOYMb9b9J8mwOUGyD11IXk4twtOpP+HianywROkdP9LcXP7bMhNIaXHM8/
 6vLHMEz6m6o5yzzC9DdDDMlV24Wx/dyIimumOsviYSaGaedkDrfpLj6p/Z0ohKi3
 sy9eG0pbctSRyUKt+poSJDwH9zFHiCeUaTaWw4nGH9/r+vyAb+Z+2M+VvmA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dububr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:49:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ea0fe07201so14021585ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555363; x=1794160163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PfKYqLgzZzmYKZpUbUyekzc0kmd71RSx1CMCJtY98mY=;
 b=C+jDOkPmPnq2bSUtkewj9MQrkyB+ojzC+/+vbUY/s+o52V/WvS2jhgGzkLzhxsxy9l
 QmqVkC1nCbuCpNamf3mM+3RDyysvxapWkKps4JGIeV+liCZ30izfSoV186L6my4VtWwp
 qpA4SM4pB0tGvQRH0SCD5PJCPDB02+HCOX1KQlaPcvzA2lNrGw9ofbPM6n2hN35urrHr
 PrdfVKev1enc5ZZD9NEiyQ7yHWfSQg87lldYxvaZA7GDBbh71W2WiYjKkMPxpBeMlcua
 CMIpC8+ekKK2cGUR0boW8bVNd7eWBMTk7XLwaX5C6qOIlEWJMUnODUpSZiarju+cQAqU
 sVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555363; x=1794160163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PfKYqLgzZzmYKZpUbUyekzc0kmd71RSx1CMCJtY98mY=;
 b=FDAvFwJmSzoJLLmxj1SYnnjTkbjHSIGt24YSnVf2GNBGKilMatSDL41JhL9d09II1M
 kQmATedn6fwXWgCb6PPodCLC0bojFF3LacbPAYsdD4x0vxcoKRgIajFqxO9M2zgLIB+g
 d7hBVs4HVVTr0eS6PmbuKdM1BNRgXOmQN4xOyw3WEj3VuQdxKUSyCf09CMLlavu8Srn+
 nL1wd5Krh3eVFjX2L7xS0by0fhL/RFNBelJ/dbX2ndhg6ba7i8rYQd8YXiWWoKzBn8tL
 6jhB1e9Klh54xKn2VVUCtJQWi/lxHkL62Dgo4e2lhUnO1A9lGQYjC75fuN55Lctmxrgy
 0jTA==
X-Gm-Message-State: APuU4Z+RFvLVMRLuwobBY0tyTpyyQu924tJMMU54yfJJBUXgbPXaMTqq
 iwVSRUFWsmcjulFzqOW+e1789AV1mTSqk4g2FGZW/t3ovsOgIYBMCMlPwXxKUVe6PIcbbcz6uF4
 pcVGPoavqmmLJuxgYNxyqKym5b3mKQzDC59PWIFwx6eRvFZ9A1XQtYZFXwS5jruH9VvJ22maMfg
 EGNff18w==
X-Gm-Gg: AYBFou0ukC4GZpSbt/Trfltdyg9LlEaRICAf83icYqDZxuO4KuRuX75SyBFFb/eLblD
 D4XOlfUeSXeckgndQ23s4P1OpHYy2Xyi8GcoY9xeBS+9CJRIHPiDK57VUztamTz/C20SCf5uwG3
 zID9SGucKtIymiXnbeNj5tU9V2Ou9kiYqJYQodJPmCYSy9q87AtLrcYn2N9GemCTY5t7KL85JMY
 wKvbcdQw2vUC8NmtqtttAiAwwCsMGa5b0L/44fRxL/10vZbYTrzy93qidoHC70BVz+dzH+2Ic9N
 abKEJkuM0O/aYbFn6mqO8riKtuYGaD1FCBhFezNim0CDUJ38HXkmgHY0xOnr7a/dyTZrwUySi7N
 GmjSAvXuBIt0ZsYyr4lsRou6nkiRS30IyLTlhsxtQhow3PxHz195vO9wcJmZETR51y/Vb24RdQ5
 zK29muJEmToBZAdvYnU5iXCtc=
X-Received: by 2002:a17:90b:3d88:b0:3ad:370f:46be with SMTP id
 98e67ed59e1d1-3ae8980ee00mr6291770a91.36.1793555362826; 
 Sun, 01 Nov 2026 09:49:22 -0800 (PST)
X-Received: by 2002:a17:90b:3d88:b0:3ad:370f:46be with SMTP id
 98e67ed59e1d1-3ae8980ee00mr6291756a91.36.1793555362395; 
 Sun, 01 Nov 2026 09:49:22 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85f3e087sm6386285a91.1.2026.11.01.09.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:49:21 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/gem: Disallow nr_bos for VM_BIND contexts
Date: Sun,  1 Nov 2026 09:49:10 -0800
Message-ID: <20261101174911.25184-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae77ba3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=5-JVGYL1QLZbPSRHqMAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: qQ_ky16ItVglV8WLhypvYNPvPs_miaW5
X-Proofpoint-GUID: qQ_ky16ItVglV8WLhypvYNPvPs_miaW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfXypDtvXTYz+ak
 LDqTR/qcwFxqbAmb8+MQxyI9glFTvF+p3dw5ZU8SxiAoeg0FbQyu1CWXk4wi3kB4UN66nbRKPuV
 2SEVi1+8IbxANM1OjZAyedCdGTAGxjh/yl/GUr2Mi14N6P0OSnqmJthUlpzzPSFa4JN4Bc9n8nj
 cWIpbrTBRfqCnkWKeENhFYd69Eq11UCstJG6JbO4DR7qd1W6ZbfIiSvUkE58GtctILWeweaT1/k
 Ci2bj1BS8tWDmqj1hDR4LdkmwmZoghD+LZO+qANnYeNS/a2QmsL4Qw8qNqwv6f3fcZTFOZT7tp5
 8nlF4OqjkwLu2F+Q8XvoWNr6/ls8QnfxV4hOFYoW9NEsnNfKC6pcOjg+8wxNldSOWN+h4/B50Q4
 /cH2Jz30yGuDpCCM3YNjdHHz2/veQEKW6+bQveaZIOk+ejZxXADyVvSRM74gjLvEdmTVYOLaggX
 YFamoUrZTmjW2qMo/WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX9U9AeB5ubnrd
 ieRIy/xkf4/YpjxKWARTxUSLDYvC5S7hJ8EsCZ7HSXgLAuwtwadjDjSTmNj4qff+pOtkDop0eTh
 9anGpbtJs+tCkiXMECs570MWD7sTX9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010070
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If using VM_BIND, it is invalid to attach BOs to a GEM_SUBMIT ioctl.
Only the VM_BIND ioctl should be used for binding objects.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index ff6cf39587c9..b558d07ed2b6 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -272,7 +272,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
 	struct drm_exec *exec = &submit->exec;
 	int ret = 0;
 
-	drm_exec_init(&submit->exec, flags, submit->nr_bos);
+	drm_exec_init(&submit->exec, flags, 0);
 	submit->has_exec = true;
 
 	drm_exec_until_all_locked (&submit->exec) {
@@ -589,6 +589,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			return -EINVAL;
 	}
 
+	if (msm_context_is_vmbind(ctx) && args->nr_bos)
+		return UERR(EINVAL, dev, "invalid nr_bos, must be zero for VM_BIND contexts");
+
 	queue = msm_submitqueue_get(ctx, args->queueid);
 	if (!queue)
 		return -ENOENT;
-- 
2.56.0

