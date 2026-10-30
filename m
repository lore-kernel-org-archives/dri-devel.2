Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D460A3812
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GcWSIzdl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FOIitdxw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC5E1129FE;
	Fri, 30 Oct 2026 21:20:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6468F1129E8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:55 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAlNC823903
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qxjIA7KASQh
 Ghn46iliBMgwf2sYMP5ZuywBwiiD60Wc=; b=GcWSIzdlPZ3On+CQgsWhHT4B8Qp
 RCegYtt7nTlBGo4L2ZgKWuHEwyQ9Ii3VroLy9hOaJFdpUL94slVibfGE2FsEqsL0
 rjC7VIj0y0rHJR3gdhdKzLXyz6/4SD8o+UcERsMLDcOk+SprAnpt3vXzL7il63SD
 ZcJcttP1XNPXWfiDYN1uBdHJTsQsfJFajvoXoNXX9Wvk1gRpIa5PvkE+9u/VLrEm
 FwBzLS9fSlg00wyIfZjSG4Ylovn5haaSx5+QScSYKsogs99DwMcItaviUwckejio
 c67Joyy05q8itkFUBXNGotqDPEbu3NF0C6yunxDu1PhlRlzc+oqWSdPaxNw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x081hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4216aee8fso1262811a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395193; x=1793999993;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qxjIA7KASQhGhn46iliBMgwf2sYMP5ZuywBwiiD60Wc=;
 b=FOIitdxwwTzotEhLjVtvjFWILRXSWKnjtcu3qh0AXBNWrro2QCYmbRZTkA4ka4StlG
 p5GtHqb8bWHCy6rdFmtY1KkHJwFa8LdMsjG1Yj/hSi9b467IFzJ0GP4eMpz1/45S4ai5
 Y/i6sImGnT3OSYyROdxyu7hRkIpO0jmnhGm5OY4qsUvhx35x6vyOr47tW/mn+8IkIX0C
 hRzl/F5lpI/ix8XJYoV8RJi1ReZODggJxbREHDyNw1mP/vdEALIaxcfbtyfNHtIyzt2H
 jUU/tlWMHq9Jhd1qjG+md56b0oSjDS+dSvgzzcgdihizW4dCs11omZMf6gdArAR6TMOz
 fgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395193; x=1793999993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qxjIA7KASQhGhn46iliBMgwf2sYMP5ZuywBwiiD60Wc=;
 b=UpOAxp/NitqxlqJrm701+7yMSZeEjpUWDLCLm8/1oVKt5CHtGx6yJ1woIJH1pLUr85
 U8RkcSbneo5kxdEkEMk6K+qraXe+sM7FWM/2PgLc+r4AC9hmwoaAKkMtS6ZKQtpUyXcK
 +wOAxGxC+Epied44IBhXpxGGf8gpY4g2LTSAPlv2A0jErk2/fkkUXCl5xupwRW8K/Guw
 HgmvY007L5ySlsmXVKAqmUewttMMqbk+kA0y9eouI9kcz2NR4bADCkdtde8JRYgPATWO
 ySa13QwtUJZT+nJkMEiQLhHK6aXRP5KVPbaoeAsDnfE2ZHkIfo+95FgoYYkQDU6h23Ok
 Mzbg==
X-Gm-Message-State: AFq9FYI0ePWOGhdnnLpUTTgJXs4XpLX0Sb91r8xvSDGPnU50Ntb6k6W8
 yYQZ97Doty174/S9+sXGpfzRyDI/mriJcVYRB+G3VDCnOYqaJNo7urxD5KGfkZAn2VKf2AlmBEf
 QvduzoycdGW6uZmtQJyL2NnPmfVbJacoBsheV5XjHNobyIXB0S4Sal5H/TF7NGHh8VthvnTJpsy
 rqTwE=
X-Gm-Gg: AYBFou3E3u2FEXxNyEIV3l4sHGv1mk132g4TGkH16JXCvay7GdAaevqaeJZslOqL8OH
 EFwsn7Yat/t7xygvuuxPX3p/QxyYVHqKOBESjEjBJPvNMZLXwRSbLi20HDQePw+kkFmBS5/RNf2
 x8sBSpO4Flk2I0fZN7E46EvN5PX9tmHKiaBY3Do6rASc5rCO1v1GFHQqNTbjj/C1D4E0hUixgmp
 2Y0zi0eovCmhOq1hJyQd7rfW4CGzlnI0dsOudDMEMuNgTlyoDhbU4dfadJS7SM05b8qa4jAEh4s
 b8bpO3zCRm1yiaCI5RVsYCUdhUJ9iwAB08VW7PNkCHLjmeXm/ixNxegqzodZRaJZM0DqToiIjMp
 m12xP01FOrhzx/gDjNvraHP5d9FYGIsHJjqc6m6Ttbh0zACopCSEqGpFX2ezOCZ5Q9rrTkkdPhB
 9Sb24T5g7BIewNY3UENhiuOis=
X-Received: by 2002:a17:90b:17cd:b0:3ac:b7b9:6471 with SMTP id
 98e67ed59e1d1-3ae8987a7bfmr2897298a91.65.1793395193362; 
 Fri, 30 Oct 2026 14:19:53 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:3ac:b7b9:6471 with SMTP id
 98e67ed59e1d1-3ae8987a7bfmr2897278a91.65.1793395192916; 
 Fri, 30 Oct 2026 14:19:52 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845429e6sm5310288a91.6.2026.10.30.14.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:52 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 10/19] drm/msm: Add cleanup help for disabling IFPC
Date: Fri, 30 Oct 2026 14:18:12 -0700
Message-ID: <20261030211928.45761-11-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TGB9eSdiRU552g0a3rrfMsFIsLYzt0tO
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae509fa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=vTD2gfctXtM-Q-VHBdUA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX7RdlJdhGAuMD
 oCPcP1HB3357IDgh5qu12nJHzkdGBbSDtlrl/2XOY+KLF58JIYYj1wedaqPRXXxIHidkebA4rQZ
 C4hA3kCQMFPhfFC8lwBKbw0UEo/uZS56lC2bdWIY25753JrNrF2UZOJjDice9e7hlu/D4+ub0da
 p9fpzhSwQl8qJ4+JQXdsWwdB9Tca4KSugKcJUp5LysWRkKA52FBdDii/YwIq5a7DXyhF4inYqlb
 TgnXN4azQOu1uTrasai0fmivkvfygjb0+wG2TK+k41JKJkxeiUEaeXVPfmn68NX19ixnuUDRQPn
 /RYXMNvGgnOcvczpkL0DaCrnnjsBbjo2kBfgOJ7zHIH5Sk3oUqKXyLYOGNsPxQMHsGbs3b3iUcQ
 2KsPnjKu8mZxYGlP64SoazpT1Jzj6jsDWJsZkElyNW1ZtijBJnmnkGh/SPySKmoxMcIg/0ybMly
 VXE8ZjqHRWdBqKdLdTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX8GHZJkHn1v/A
 CT4KUGgPNBl3XoGFDI16WE92DxTPsIHTyMycc0+YAmA/UuJ0sqWi3nibVECswGTRUagKzZbTJON
 R4tXYwn15++qrAyxaOKsh5a2MGL9wmo=
X-Proofpoint-ORIG-GUID: TGB9eSdiRU552g0a3rrfMsFIsLYzt0tO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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
 drivers/gpu/drm/msm/msm_perfcntr.c | 7 +------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 2e1b1bea37ce..4e18c2427c69 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -381,6 +381,10 @@ msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
 	return refcount_read(&gpu->sysprof_active) > 1;
 }
 
+DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
+	     if (_T->funcs->ifpc_update) _T->funcs->ifpc_update(_T, true),
+	     if (_T->funcs->ifpc_update) _T->funcs->ifpc_update(_T, false));
+
 /*
  * The number of priority levels provided by drm gpu scheduler.  The
  * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index 7b4a6e49d3a7..995857273aca 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -259,8 +259,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	if (gpu->funcs->ifpc_update)
-		gpu->funcs->ifpc_update(gpu, true);
+	guard(ifpc_disable)(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -296,10 +295,6 @@ sample_worker(struct kthread_work *work)
 		}
 	}
 
-	/* Re-enable IFPC: */
-	if (gpu->funcs->ifpc_update)
-		gpu->funcs->ifpc_update(gpu, false);
-
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
 }
-- 
2.56.0

