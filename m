Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504CBC44519
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE6110F3DC;
	Thu, 16 Jul 2026 20:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOba50vT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwJ9OAzo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5547910F3D2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJpDZt3453727
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WnSM4lxQZEs
 mTxwUeMg+vWDIzmfUTyWcy5ySJC3KBaU=; b=BOba50vTP5/8GNhmwJ5nFp+W5O8
 8wEng31bEDk4F2kmXZ/ez6WW5b8LWVc4xRonLY60iIl5tpEyrKLcyqpcbEL5h//O
 z73bUO4jZUsEZMokqSQ+7kT6o1BSV4Tq1wuXFysNN+Sl4PHESnWK2QYg0Mgfgx0c
 9s5sU42PleRa4z+JRMcl6znNEsZnZy1hWacgPrnP7mNWrDgxwtHFti3vliMD5VKg
 rpxD32jNNWn+XcoMim/DxwGnfpIvUq3LzdBVYbCEHwjHETljqdSTkN+/MchoPLOR
 As1pdTCqtI5nnX0Pfhkq+Vn36HpxMzzPA4cIvvEtHqz2C4dNIB+lDzoAcMA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff1m9h9q2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:15:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so3597168a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232959; x=1784837759;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WnSM4lxQZEsmTxwUeMg+vWDIzmfUTyWcy5ySJC3KBaU=;
 b=CwJ9OAzouiGgvZ7KLKXNdUArErmjFs2vgh5acXHvgMS6KwnGIyiu+yqhjg9xnMKLuH
 4KkASnabq30dW21s42zOLEhFhaueUjbzGB6FsAaoVhIfvqK0tg94JQWh0XCrS1GDCYNH
 l6LTxDSCyO7oMG7s18/sEt6HwRqBmZnEGXjZFZ3Zy7acbw5C3Y7qGhC1L7Hel5J8M84e
 dmw541nz6FEf+ZwEw5ffy9KT5mpPD3be0jFjTk+O48hRBMgydxDkV7ivZ2Le2TQvury/
 /Ncxp++qsdIU0fRpACKmo8DXkVToheqTwQp3mxqfFLiutFNXUabxsZYGGuNDaxl4tRK4
 Ag2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232959; x=1784837759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WnSM4lxQZEsmTxwUeMg+vWDIzmfUTyWcy5ySJC3KBaU=;
 b=ToLiLVmm6pqwaNc9F6QFnXr3UYwM3zYXPuz34LzJ7gLdFcfarhmUi7D8IlUwyGWDsD
 c6BMt3HiNIgl2XmrBZqh5p4lwftGXb73Thr1qts5VsshTUvdy8rgP1NVz3Ppi/HlreUd
 KImWJMrci12qql+sYE/QkfJGUUPowS6IseXRZciNUqJ/tpY8Ht8HZ12FbygmGsGjLRfe
 m1pI4qq5gmG6vL6nHpHmnkWde8Pbu9HuJEr1XBHMLwT05S0x7wc35kkUCTgUQZ9znoso
 /tHKc04z18eXB1dD73Ch2hZaH5OMPPjbSajEaKgbW6TufSol7mIiFPTSWtSB+XgVthmZ
 jVTA==
X-Gm-Message-State: AOJu0Ywt6kpOCF6a+TgWw+yQPP6UQ83/ujdZAO2oUvFUsUofux58SMhP
 jzKW6y0e46blefmnz994EabiDckXQfsRaoJ6a4Br94QMv2qS6QejU0VBqd1S8JsFKaeUVDN7d1T
 RKzz4/3LOtJT314Us0R+N7omWqIifaaWRjdUikYhkHAvfnVQ/bxl+A9BJl1lRdbie/7sdiaVj4z
 3CK8M=
X-Gm-Gg: AfdE7cn3tvjCOD7u5OHrfAfrGqGfNHaqB3CZ6UkTG4EFTrwIY72RvVE3HI86v44TUwF
 2PrHC11hPb3ktTK1MESyl4THhqCApYTAccKJAncKVslzo6r9I1JMGu0HUxcyqTFqLmBoTLyBPu/
 UpCnAdNsChRaq40PV8heHzGb2PZry9MwAfUhW2jn0rbgLl1N5VFBmbnjqgjvlWik9RvKwhbGi+m
 hnO2rFJT/mC8P90wn30CbyyjNv59NARa7vz8AkEG5HcA0I3oTWXYxxZLrXLgQzTVZNWvP1ccYmW
 Aj5iSgQv7FhhONzD2AyYtSAuKppQOGfi8GYbJcBFpacaVCmrppkA3Oktg62k/0a1dBIdsn8z36/
 iply8UAs6BF1P6hWqYFkY9bOqJtUNfBopYVe79BnvG52l3+U=
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:7481:7a03 with SMTP id
 adf61e73a8af0-3c3a5cf5b48mr670982637.34.1784232959072; 
 Thu, 16 Jul 2026 13:15:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:7481:7a03 with SMTP id
 adf61e73a8af0-3c3a5cf5b48mr670951637.34.1784232958595; 
 Thu, 16 Jul 2026 13:15:58 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb258ff4402sm2291627a12.25.2026.07.16.13.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:58 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 07/10] drm/msm: Don't fallback to shared VM for VM_BIND
Date: Thu, 16 Jul 2026 13:15:30 -0700
Message-ID: <20260716201538.365824-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IMIyzAvG c=1 sm=1 tr=0 ts=6a593bff cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX0naLMszYpEFT
 ezGstwyjT4SptvYYyxfjaUUAhIAgCJhJ/caYLrnMQPcmn8eWXy8lHKhzJ7GIG1jNElVpxDr0y9n
 SkwrLFnD2crB9C+3nZnIkKMNaNh1S2rT+8QfAMBPy81UbodEI8t+M6E3VwpSBkG139KAv34ygkk
 T0Or+7aDKPyFAfBQMx6+LHk4OYXkHokWVM3kTNe17432G9ZzvkKF4t8p8pE8LT7W0gkMi+rR6zg
 JFCPNqoWQdbNlOqphzZ4gP8NUxg4h9wyu29hyLkQT+Nn34wjm/nquh26oHmoXXvqgtCX8w2YGGa
 JdtKBJeItEJp+Z3+7hvcUTLHpP9v0SJV4c2yAzWdWj89QQvpL9me6wr+hKdJAt/eD7jFTZ9vKud
 SV1U1lkjVt8uXnGYv8jLeAcc7uzzqFH0RufAUDeSQEFkPhOXLRGxn0QjtQzJxrIFWAube7VgVnF
 EHDCPJLP3FwyiUOpodQ==
X-Proofpoint-GUID: v7acMELa2XPyxwplZn0Ma9uzNtSXCsUS
X-Proofpoint-ORIG-GUID: v7acMELa2XPyxwplZn0Ma9uzNtSXCsUS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXwUPCDSceL5zr
 Zd1mrhMg9vQHNFKaEjG5gOuVlil9xFJ9v6FGhwSHeqJaz6A7aQ+2q/hCNlZd4T/WhdHzbfrwQ9J
 LEnjaa0Ds3fF7RRyuGFesvjO2WxMzi4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160206
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

If the user wants a userspace managed VM (EN_VM_BIND) don't silently
fall back to shared VM.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ++-
 drivers/gpu/drm/msm/msm_gpu.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 52ff72d8e17a..73d99bde26f1 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -234,7 +234,8 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_context *ctx
 	if (!ctx->vm) {
 		vm = msm_gpu_create_private_vm(
 			priv->gpu, current, !ctx->userspace_managed_vm);
-		smp_store_release(&ctx->vm, vm);
+		if (!IS_ERR_OR_NULL(vm))
+			smp_store_release(&ctx->vm, vm);
 	}
 
 	return ctx->vm;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18ed00e5f143..d02c37380414 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -875,7 +875,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
 			to_msm_vm(vm)->pid = get_pid(task_pid(task));
 	}
 
-	if (IS_ERR_OR_NULL(vm))
+	if (IS_ERR_OR_NULL(vm) && !kernel_managed)
 		vm = drm_gpuvm_get(gpu->vm);
 
 	return vm;
-- 
2.55.0

