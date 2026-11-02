Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFE606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GgBr25bF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RR8hooii
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49EC10F178;
	Mon,  2 Nov 2026 19:00:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745EC10F178
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:00:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HP2En965867
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 19:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rxoPTuCm5jn
 Mt/VDeTNC1QYpW68FPUdXFuvA3Ncyf5g=; b=GgBr25bFRLP0IAUuXFu0m92G9xJ
 WkAbzzxapuqVVpxp6QTZ7Atl/tpBJfdDX4ym+ZolImpVlp9TwWYpMx/KlyjczB1u
 plqk7jaUhArgUjotWs2rekgEeHpUEY6bgZcKltIzGP86I6qjZn1dg/z504jN6l0u
 Br3Xx65Pc6pPQYtGCSESXv6SyCsLS9cpzsTdOK7k9kYw8WIHu82yBf2MD6/6yECk
 vV2pdKrTQZ+I54O7uZWW3wnK4uvhkg85Oac9AxjYRYyPr9W2qvsf3O2avJzMZNZ/
 BzALXtkxM3+RrGeyxhwipo9UvjzUWAG5QmKfJ/uoI01SrshNSxgUbzx37EQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph1arps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 19:00:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e818ca61bfso35175595ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793646018; x=1794250818;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rxoPTuCm5jnMt/VDeTNC1QYpW68FPUdXFuvA3Ncyf5g=;
 b=RR8hooiiqrBcbhXveRXsKyT2LtotrcmuGi9q6RFyye2VJRxXDplmkg0DbcR4DF/Abk
 O+e24PLIyBnErawuJCh75FNyN5iG4fWQgmZFmzWLXvAZZMeIWpPaR1aWtisniqdxO6k9
 AaRjfxPEE8fQE3opdJ5jDnbkhfNllrD2WbgkO0osErA2F9icb4wB+DSsHzOwbV7faHeB
 7mKTVzTvDujqsAfRz3cXMOYi15nR2BOb4xszEpgUiTYvOIZk6w2oZmUkbNNhmozpKN7T
 GsGbPRBNsWF6SQIsTjwL35i739ZhlmkLlxB/nXC6RPcK6XvFKhYSjMSK0l7QWG53HC5o
 F+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793646018; x=1794250818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rxoPTuCm5jnMt/VDeTNC1QYpW68FPUdXFuvA3Ncyf5g=;
 b=cU9SddT2FB3JUFFX50BEvGI4wKW9JjXnF0scPG3qA6PUssxBBshcIStOwDQoT8n+Aa
 2gE3AHD1A/YrmuCzYoLEp5QHiKztttobJEd676Nl+IaFNGmfLTQjeI3CqdPFeD2DRm24
 0ni8zKUtGa4dG4H74SbAS8pN0iKpJLwaaQnpy1rFvKdJbKnhawcDrH2j8AtKneKsSTyj
 nvioDgTgrmaApdqgsb3VITiUywixLREgjlwQJ4x9uyMC7emgNBS716PdAdVjWgI5MG1G
 s27Tzwxt2h8f2gu9xb5hJ0P8TdqybIEveyGfVZ0KxvJ3Z4sVpCMxreciYv2BVy6GMmQd
 h6kg==
X-Gm-Message-State: APuU4Z9fb2fom3yQfj+NWYOz3bRaXaX3YlwhbCGZKIrkt1oRjAyDcYGc
 0lCiECwMpUlGuVBCURSbvqctWMWvd619dv3ILZlaTzJITA3qYzjHKIJxa8Sn6iXjEzoM9cLzlCr
 KC58gYdRzJzECXcXcbizXnpt0LFUmecsoESH2EP3a1r52ZZqgvocJpq03suhbCL5L4UmwWUQECu
 7Jv3PkWA==
X-Gm-Gg: AYBFou356KH+dkGIbhdtGe3CqLep9w+DXGGUoFUjFYs73xEYaHmECkIY6uCa7s2BbEn
 naa+JBySTACorH1aoZCpmnXByODyINj7DqB9VYvSKp5PoOkydanHMjQ2rX5uMQu+yJMcQsk2bHz
 8m3d8pyRl26kGtSRUN0nLJxTG0kemh87wO02TSR/Enf/s6ae8Mh1/VtvCocSOMbJaFtDpbJnkSG
 pViJ20y5ugG1B0cpWsfqalHpfmCCwD/DBq/e0oA0+v2CwkrJz72GDJ2u+QmYx6CWD0FkauupdQL
 R4SBJxaIF+g3Lsx89zw6FwSwmvQj2MPn+CBa8UowjRvxwcpYGxGyYvgjcK/urFpwc8Q6z+1qklC
 Xnva/exhq2GjQeXwSoXP5K4jYs+gQonzZvxMKx31E91nAhD+lGG3m34fzF8a0EtJ13cyNDRtmwo
 7nGGTAdl1gTyZnYc+EpZvvyQ==
X-Received: by 2002:a17:903:b8f:b0:2e9:5ed2:c3a3 with SMTP id
 d9443c01a7336-2eb364bfe04mr105228815ad.37.1793646018375; 
 Mon, 02 Nov 2026 11:00:18 -0800 (PST)
X-Received: by 2002:a17:903:b8f:b0:2e9:5ed2:c3a3 with SMTP id
 d9443c01a7336-2eb364bfe04mr105228505ad.37.1793646017926; 
 Mon, 02 Nov 2026 11:00:17 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39230bbfsm31091015ad.19.2026.11.02.11.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:00:16 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] drm/msm: Add cleanup help for disabling IFPC
Date: Mon,  2 Nov 2026 11:00:05 -0800
Message-ID: <20261102190010.720443-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tuYCGC3dchZvx9Y_EgjgJoJc6quuWoj8
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae8ddc3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=vTD2gfctXtM-Q-VHBdUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: tuYCGC3dchZvx9Y_EgjgJoJc6quuWoj8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfXwhGwqnoYl6wG
 fZyej0RO1M5VuWVvEjk4lumCofs7QVQXR8WNkBoi75I/ctpr3aGtzP+OJz9PzhplJuS7xPqd7Xa
 ojS9bV+EHkLndWY5j80vkeTwwZbqeFU8+/4KyIpUvGACj7yh5FZi8nzLxkpXH0v1e9zrc0LJy80
 kLf8YS4LzUZFI35bajvYzYYgDfZsuHia0xXCBPDwgW3WaU5kSgOWemNWJ/WyR5UqY91y0DCdPkh
 pL1xedHP4BQCreQ5W/ZRvkccUXwAIiv44WZnSVqH1/0TysZRnE/XVMB8euOFrx0GPnYotSOB+RU
 Kjz+cXnNnfpuLu2I1k1utftaVplsS+CMGUik1jxcVSQwBWoQ4DkCKYf40czqDucl0ZrepfWNMzm
 GV7KebbCpxOf0lU3AKNroOTYZcqfnTs79g7jgydK4/o2AOP9ENzX8h4lv1X1FnFvV6yK0x6Bgnr
 D+nw7Cs2AYjcBacoG7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfXyo9v5BtGH+xh
 9MUAl6hixj6Tqq+2CDutQhR+FLT6tjwHcTds9V9+xCQhGsGSS+3F9JrNazhFuD7uFlS1hoBucox
 dRCTFepHXuXbuF0mELlddskw5f2/Rk0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020075
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

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.h      | 4 ++++
 drivers/gpu/drm/msm/msm_perfcntr.c | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 0334a0f604ac..e7912d2180a5 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -399,6 +399,10 @@ msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
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
index 867dd476ed88..995857273aca 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -259,7 +259,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	msm_gpu_disable_ifpc_get(gpu);
+	guard(ifpc_disable)(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -295,9 +295,6 @@ sample_worker(struct kthread_work *work)
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

