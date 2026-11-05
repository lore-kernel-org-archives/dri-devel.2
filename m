Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C3606A92B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BJaMlyrx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c5Irgno2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABDB10E6B7;
	Thu,  5 Nov 2026 16:42:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2EC10E2C1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:16 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQGcN2004538
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=i1Q64R4YoBH
 KvX+mYcDs4C+P4TdP3kbJ/gihntCEHa8=; b=BJaMlyrx5UwYstA2cnkcjQb9j+Y
 rbctTCYC3jmToKo+/+gqC+1asUjURUuA+1yOGOh98EnSE4+iW0dFLxT/faLnF80s
 10Tqwdydgq6C+LEZHfUMvGLxERhWUU2/Yaq05tGfOaB+9Qq6D9Hf/j7R4lf2+Bfz
 oi4poDNP8cErX9m0Wy6RYEmHGLCLr3UcKRO2rxZT8a/qe1TVH7rY0LuEGLfBdH2i
 6spgN/mdiya+RaMYFFsM12xJaEFcXrX4iYZxaWwKQbRzSm0NgbTF63bpN6LwApfj
 ZtDwm1B0LCZrk35MjY+XGJPmPyx35CKpjBSjOd7T8CCh2y1rFhx5zFxyRpw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd1pyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cdb061cc4dbso660276a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896935; x=1794501735;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i1Q64R4YoBHKvX+mYcDs4C+P4TdP3kbJ/gihntCEHa8=;
 b=c5Irgno2R3ocFCsWt+2wXIuYw0d5eaYWB57vLgzYyfCWrYrE9nTuam3PiUPgaN/sjL
 r9rTRO1VaPnfdJesXCwGUOdzJMuXy6blCQVsmDukflLCCG0z6TdbopRup6TuwBODg8js
 tR6kCbvQ1r3Gl/Q2TmhFNkBi4JCLl8HRszG5TrF9bDyKpeqzXXe3V1U3MTXjdcvp/7SP
 T2D2LnqU/bTJBLxFq6Wle0+Ob6scFH/XOmDmzXONLqxvrX7e6scibn+cSnv9pw9jt7fL
 CWMY6R2G1eb1pg/Hgs7NuNOVw/oesVfq095ybP4OwSW5bTdGYc1B8Y15a4vbN3cVPyb6
 S90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896935; x=1794501735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i1Q64R4YoBHKvX+mYcDs4C+P4TdP3kbJ/gihntCEHa8=;
 b=SEeprv0143AEatb8i1xCWF2xArKHqkcWVVAOza6R57QY45t+mAANUDyL7fzARcnsOL
 3bmaDvVbs8H3G22iHFnSFhGQK+4pYUvsuy7zjDiT7ZXAtJf3FbC2DiT9rBz3I2ahG1E8
 /QMoXzGs2T1t9gn4GkDQ5htQHT31/IqaoOgg5qMUH1SVz2jUIV41SrNhKZu6b8dvFAwL
 ImSDsRsgT9enoRXfxhws06yqWvXuDIq4t2cvFV7+pJRZmeWF84MKYVY4ddjT1pGfN/1r
 Oy/lh70SLlJ3ClJ3DbddmnDyFO4N8QcYmCb7oNAOmzdd1wgZrchnG856/MumZaSQzY+p
 YUKw==
X-Gm-Message-State: APuU4Z8PzxnTp7xuZdIWQrzspLQ0DQSdQGjZIpgToPMVa6nKt7YwNyFm
 Ga2dfiDHugfCs66UVisCpstrhvSmmCDzco1BPzDpIMFnWrdytPcoWgwwpYKcjMRMutIG15temtq
 1I7C3XjxxSnK34z/AkyL+/b2yqvJ4q8tmkYcglzUVsnepWUfNwVyEU/bhAlfuIBWByux+e/tagB
 2pF44=
X-Gm-Gg: AYBFou0iQU/HEi2o7CRmpcxTxMY9qeBFzGm49Za0Q5l5vjCBsFhNc+/5GtJzBpK3n1H
 iHSWUM8cJyVI5OxQKXdmk8X/i8W+qtnRhnODDfDFNpNUfwdiPmX/2QNSndefssZwCyJh8PJC1cE
 n+fG4cGgysGGwtbjsAz5kA5OGXbNCqM31B9jX6UAuMa7Kg1J5bsenQbVtXvSzDVBiu7vhtR3WzN
 Z7n5vrE7yudf2dYIHjt1K7DdK4AcluJn8ZJJ9AyAU8rlpjoII3CwTaMwzxujYGCV8yzEWS8mVkp
 e8wxgJpT1VpsrHYhjJku8Iue76Gs8lssRpEZ0v8alInRHiNzwGi4ymjqgcKjKvjoxVRPX348NzB
 JkSLdyxsPwQGcUMigfMjnqS9Awis53sBjCjAAla+DE7PgKRKkFs3u7sGRQv/ZqTlg6iKX0Og3jm
 tH0IidrD7e5PbnJXKiwojFp3n0Y2VWVJ2Tp96x6pCBb1bjj3G32gIaB+XERWJ3cA==
X-Received: by 2002:a17:90a:d446:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3b0afbf6995mr1859252a91.6.1793896929869; 
 Thu, 05 Nov 2026 08:42:09 -0800 (PST)
X-Received: by 2002:a17:90a:d446:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3b0afbf6995mr1859212a91.6.1793896929286; 
 Thu, 05 Nov 2026 08:42:09 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b323cd3csm4447277a91.3.2026.11.05.08.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:08 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 4/6] drm/msm: Add cleanup help for disabling IFPC
Date: Thu,  5 Nov 2026 08:41:51 -0800
Message-ID: <20261105164158.23263-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX7V1OhFzoTzBS
 zXdqzF6lF/exSxyDiOyxpz4WVa/sBQYp8FVf3RGQLL87gPUfUs2ns+cUg5cDUIsBPMDfCxu5aYI
 +JvtjOCpK2VxWh5WMJOMRYo7G0Zcr+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX4+zL+pXycGoS
 vfLSQLHywvbDnUwrwn3TLTWuEMdLFfsF+SAVA5hts7y/LAjCp+c6bN9OcHn5YBbZYZ4T8I0C+dN
 YhJqWLlLJ1703hYonedVJdqg675NdjnYed/V2hf5LN8vBCRWqh6fDZpka4sRg662MouS16Z+1/y
 LEvjHCp6hI7YRt3k6YWDDxsMyOk+4j8itONyi0RRw4dqXpZfxDV/vgtIHlqk5gqSYbQZ2jDau91
 snf4iBTckcJ24XAqMnQA6aCgOcAPTXhguDUMg+JmdbCVVvJec7yxSMcfLs5TB0sA7r+KJcGtNK+
 2xAgRZ2yegeVzuL3gwyO/Xk8gWj2A/dtRY8ZIZ/pSYKbBQdchH5TmZEIklzq5NNKIW43Ls72Czk
 pGbrbedVbGjHvE9vncadVUpt+ItSFOI8/8skFsToX/1fGy+vC63jErblvlygvZcVfAP7ywE/FDi
 ONkzHeUHC7Sos9hieaQ==
X-Proofpoint-ORIG-GUID: CJ-RM4jnJBdBZ5_yqmyyZoH57C3DTO9s
X-Proofpoint-GUID: CJ-RM4jnJBdBZ5_yqmyyZoH57C3DTO9s
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aecb1e7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=vTD2gfctXtM-Q-VHBdUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050066
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

Simplify error path cleanup for IFPC-disable critical sections.

Note that this moves where we re-enable IFPC until after the
wake_up_all(), but that is harmless.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.h      | 4 ++++
 drivers/gpu/drm/msm/msm_perfcntr.c | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d1abe0ef3d1d..055b9bffad39 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -405,6 +405,10 @@ msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
 		gpu->funcs->ifpc_update(gpu);
 }
 
+DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
+	     msm_gpu_disable_ifpc_get(_T),
+	     msm_gpu_disable_ifpc_put(_T))
+
 /*
  * The number of priority levels provided by drm gpu scheduler.  The
  * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index b1b07212252a..23b967be0323 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -267,7 +267,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	msm_gpu_disable_ifpc_get(gpu);
+	guard(ifpc_disable)(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -303,9 +303,6 @@ sample_worker(struct kthread_work *work)
 		}
 	}
 
-	/* Re-enable IFPC: */
-	msm_gpu_disable_ifpc_put(gpu);
-
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
 }
-- 
2.56.0

