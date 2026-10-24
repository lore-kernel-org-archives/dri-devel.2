Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B16606A31B
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b2IO1Ip/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdf9dcAx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005B010E570;
	Sat, 24 Oct 2026 10:31:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9ECE10E570
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8oVXB254521
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=; b=b2IO1Ip/yTuqxOc/
 k6PpGXfC6zyRvx5EAyZ5wfOcuXSB0OL9ZRCWv4KSH1Q9T1T0v5sndAde6mK2JY92
 S1qjSt+rew3pujqHIk3uGOLZPf/ai/CvqjI7zCiY1SV7mL8GhnRq5zVkdODHZPev
 EuiB39D/gwfZ2uXHY2+TfN6f6Hckolh7eHaZwlCM4i6osDHM4aQKvKD9GFlLDMbz
 kD4QkMHTKcREEjRlni8N+mRneBwyuPnW902OJTK241hXZsbDczKgY9DR37MdeakS
 uPN3qkx2KinvbOXpRUpxrE/FGcp7TFuFc4Tt9N6/KlAJMA+4rJ4Y4gocRaX0FycR
 lVkhAQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9rjw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-156b5338d4bso298644c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837858; x=1793442658;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=;
 b=gdf9dcAx4kK/TOiXNffzppOeMBaqQMi+sxBOUYK9dR2Sh7hTzol8FAzhAVa7beSOK9
 Mh8wx/Scd1uCobztuyeUMG82PYaDBg6G6J52bO5oGn+HG42F6SDAnlcK0tedSeyFceER
 oG90gN+ExXJaACosmY1p+/IdpVU0sXXtTbrgJfNYqyY5AkflMuv4TGxuWGCJjWEjAJ6s
 4aRogxpBGg465ERXoXVP5bUE5glLfnyqKbpaSxIcrdrcu+BsxWbV49kZnEegWmVOxEam
 7aWARpDCcpy8KC91Q6Aut2HX7DKhyGyHjZclhKDl788OAth+pj5vnsId+5aFvLOdrPGp
 vAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837858; x=1793442658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W3J2Hpv3nr4vSLVvjMy+VwXttjkCdlyxfB9Ss9Q/kT4=;
 b=Qv7ndqVZDiFRk/RrEZYrXfIbMljfhDXe6NNsrKk6OLD/0eOlWlbTAfJ4M6/+w7FSkW
 MXo2ZNCUZcjk9GXeJtgC/tBBnYxpTve/UTIwozTExlxZX7AwPBGcrr9faBZoYdRfcqff
 yWXpQ/jFNKzuOuiKNLlvBEmjC0PuQ5Pu3qE8MB08dHnAjKKb7uptKj9VE/Wjac9LW9up
 GbwoTUHgxTp81IsJWd1SDmUKq+cLQc8Tzm/ilYfuFb/zsg9i58QbdHSgireTL7bYzn5G
 xfHGAbK+JUQ+1q35SfJNlFUjR/DHSbfX6KcyECabNMF3TJvb2/gsrXn1n42JEMZlmssZ
 ChaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt7sMybyYaZ8r3JDtafIyRzIUeiKvIDnRiqsF48l8/heqYCLfkmi7d+jfC6GXEBcRPm8Ewp+rRiQA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKL5DLPUiG6sQGgaHXYj/d6yISlWXv1BqQ7ACAaSEADeQhgWCQu
 EoWK1jddYjfRinXRsGdBK3VYIS9iNZ74QK4tBr6AwnTjrq2ExnYSPvsUxTcs5Bk5Ix7397vVEiX
 TCqNzdQzBsBwhlP54oP5td0fogUri6e7cbqvdms+RbZSxV0jm6Nj0H5xQhewHcurTSSBTw1M=
X-Gm-Gg: AYBFou1CxvZbJDEUU5DlWVWhmDZ5VEJtVIbDS57S2ptwG7XpmIBJCQ62zei9/VOrwyI
 88dKyX/QLGObM+sMMWkvyxAa2t5VvRcqJROcKv9ffjUsgjNHjj0PC4H+kjXBwLVb7trYl3sE590
 qXicd6MmNCWfP2bzzzO020AUB/iMpOoanU8kbr6EzRZ005DO0VyW0tQ62X6FWZlqAUp2jYIfRQm
 Ea6hfyICv7Nv1OP+b83iDkOGFqQOh35hGmaoumpLilJmTma4J6Y/ARwDaOPXLip5qOGbO2wcsB/
 b20ANJA1whPJTWm2fQtRqc7R+WsdtAL7wXjOGJGW5uxgUK39o7BrA01simwL41lFbyWbinXwbfa
 VpiMXSFWrezeR4VDThUYt5lM=
X-Received: by 2002:a05:7022:1508:b0:17f:7280:134e with SMTP id
 a92af1059eb24-19937025bfamr2402485c88.32.1792837857573; 
 Sat, 24 Oct 2026 03:30:57 -0700 (PDT)
X-Received: by 2002:a05:7022:1508:b0:17f:7280:134e with SMTP id
 a92af1059eb24-19937025bfamr2402436c88.32.1792837856936; 
 Sat, 24 Oct 2026 03:30:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:30:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:11 +0530
Subject: [PATCH 5/8] drm/msm: Fix sched_prio inversion within a ring
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-5-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=3775;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=/p/xExe2wnQ1Pu4lNe12i74ui9lWBHsGWXEq9LYZN/g=;
 b=hgIcpVXBteagZ4vvfmPlFpmSXbnrYhFRwM5DvkNGy7xtffRy5qpGkfxqu0prTpDW2AkWa6/pD
 Um0wfeBa7bkBJzLTWIS/wYiSFGTxf/POcyBWIkaof79aeSxwPpLDfov
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: NnfDpopSp8IBSanAIr1l-ilXqCUJuL6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfXwY5q6CzN4LrP
 922UV85VNXjYHokfgiR/bN+vmI9Ft13YTAGXJ4lexdZVMo/agm6KYG4KmS3uZ3Ag5hvKlUXAcDX
 4hdOTw64gBRN32Q3RflqjmbXrWBmLd3SPh6ZiV6qNPE5sRgMLXpAScxF1BHqdjOB+6qwGA0LUTJ
 Srzx1hUBm5CoDDu1DQ2wDfgdAOsF64fK83hrK/2hx9kOAPVuEt09PIAdiA+C5ClP7jdqejAxf8j
 UwO302hrvcuXpn5Whe4iLqPW9E6bP8QjAW/69Y4tT2rHahBp4rl8BlTlanbMuAjIKbrqoj48lOC
 abvlCMbUrNcwspkhRKCqKQyU+HZ+pQI889RjHPi08Q0Rrbr+JzH5l367GPJxHLmL27oJiXp7mlI
 pi3/S1EOTX00oEDGLO6dtPHp+zlqy5hIwQTtDsjGNjT3xER93pxOjxCCCfhv4MLeO0o49Bsn6PK
 7KmBLU90i8frGLLK+zQ==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adc88e2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=F1ZHhNDtVFIJyJQHAloA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: NnfDpopSp8IBSanAIr1l-ilXqCUJuL6t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX78mi8329+Zii
 wE1EkkD4iSwXhzZzb5om49FCy2D6beKVUGkzJ+StDFDnmDl/8cNg0mwNp81GidOBtRHX/UFnhAi
 6J9kGWYRoJJnHeCKEiryxTLlTegsezA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Commit 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
reversed the values of each sched priority. But it didn't update
msm_gpu_convert_priority() to match the new order. This results in
incorrect sched priorities within a ring.

To fix this, remove the inversion logic and add an offset of
DRM_SCHED_PRIORITY_HIGH to keep the range within [HIGH..LOW], reserving
KERNEL for internal submissions.

Fixes: 38f922a563aa ("drm/sched: Reverse run-queue priority enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.h         | 24 ++++++++++--------------
 drivers/gpu/drm/msm/msm_submitqueue.c |  2 +-
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..bc5b31eb1eca 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -522,17 +522,18 @@ msm_context_is_vmbind(struct msm_context *ctx)
  * @sched_prio: [out] the gpu scheduler priority level which the userspace
  *              priority maps to
  *
- * With drm/scheduler providing it's own level of prioritization, our total
+ * With drm/scheduler providing its own level of prioritization, our total
  * number of available priority levels is (nr_rings * NR_SCHED_PRIORITIES).
- * Each ring is associated with it's own scheduler instance.  However, our
- * UABI is that lower numerical values are higher priority.  So mapping the
- * single userspace priority level into ring_nr and sched_prio takes some
- * care.  The userspace provided priority (when a submitqueue is created)
- * is mapped to ring nr and scheduler priority as such:
+ * Each ring is associated with its own scheduler instance.  Both the MSM
+ * UABI and drm/scheduler use lower-numeric = higher-priority, so the mapping
+ * from a single userspace priority level into ring_nr and sched_prio is:
  *
  *   ring_nr    = userspace_prio / NR_SCHED_PRIORITIES
- *   sched_prio = NR_SCHED_PRIORITIES -
- *                (userspace_prio % NR_SCHED_PRIORITIES) - 1
+ *   sched_prio = (userspace_prio % NR_SCHED_PRIORITIES) + DRM_SCHED_PRIORITY_HIGH
+ *
+ * The offset by DRM_SCHED_PRIORITY_HIGH keeps the range within [HIGH..LOW],
+ * intentionally excluding DRM_SCHED_PRIORITY_KERNEL which is reserved for
+ * kernel-internal submissions.
  *
  * This allows generations without preemption (nr_rings==1) to have some
  * amount of prioritization, and provides more priority levels for gens
@@ -547,16 +548,11 @@ static inline int msm_gpu_convert_priority(struct msm_gpu *gpu, int prio,
 
 	rn = div_u64_rem(prio, NR_SCHED_PRIORITIES, &sp);
 
-	/* invert sched priority to map to higher-numeric-is-higher-
-	 * priority convention
-	 */
-	sp = NR_SCHED_PRIORITIES - sp - 1;
-
 	if (rn >= gpu->nr_rings)
 		return -EINVAL;
 
 	*ring_nr = rn;
-	*sched_prio = sp;
+	*sched_prio = sp + DRM_SCHED_PRIORITY_HIGH;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index d307cdd17d90..8d550d281704 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -136,7 +136,7 @@ get_sched_entity(struct msm_context *ctx, struct msm_ringbuffer *ring,
 		 unsigned ring_nr, enum drm_sched_priority sched_prio)
 {
 	static DEFINE_MUTEX(entity_lock);
-	unsigned idx = (ring_nr * NR_SCHED_PRIORITIES) + sched_prio;
+	unsigned idx = (ring_nr * NR_SCHED_PRIORITIES) + (sched_prio - DRM_SCHED_PRIORITY_HIGH);
 
 	/* We should have already validated that the requested priority is
 	 * valid by the time we get here.

-- 
2.55.0

