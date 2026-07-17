Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687CC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCDE10F605;
	Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNkF/IDT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZIfTr28";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309A110F60A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:13 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJuFoQ2450989
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4y99CIHhO7Z
 Ma20JkU9vG7q5Jf/ock0IskJ460LHt8I=; b=RNkF/IDTdB/8cjkd877OsA0iNJx
 Ijt0TcpsLXlUxHxa8yrB64zdCa2GR47qr620wPjFoH/yaYVDx6FFqxWuZwQcYt0d
 D1eNFOxcJaSGlY1dVrUfq2WiUXgU/C7kjw0z7OAPH3wjbEfXH3TJhepuGWuQ1i/7
 4Dw0vG5RmKKJYvDz96ryZDtgV4Ot9AYNxV7+i0wc/gGYx6dSBEoQeXBDY2O9oWWX
 V6laMNUaPDj0RzcwpDCNBeJaT1hjGnhc42agsPpJSIKAfvuqfFT5C1NDsyKFUkax
 7QebA0diTVVW3XpY/1eRTrftgcOxArw4ZekoI+y9Q85wMDV9e6BOP3f3Qqg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffj78tg8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-384419c6c74so10460157a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321352; x=1784926152;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4y99CIHhO7ZMa20JkU9vG7q5Jf/ock0IskJ460LHt8I=;
 b=NZIfTr28C/BrcSc90HdJE5OlEASsKYfwF50c875aCyH5gXCKu7wE0tLCaFucLawBmS
 i0+jhnh4SMQ4SLXG7kRlfejicMV6hxYxTTh6Z62K8HWPCFGkN6y9iP8CP95QUsji68nw
 mgWphjOPHWCSoOsDYli961FahSZdavlI5jW6FjCFC4Xlrmk4OZjRZcKo2wZeOsoVUMLd
 r5Y9baIZrZXm2FZfPu0uMqU9eNw8HBXsxRZY2W3wdpdm9yoQiNxtvFNrC64SU8wndBY1
 QvVeF9/QJldFuhYvjLO1RFT5rEAc1W97Yu4ee9OKq9gb4/zEJbtNI5SbQJ6Mq4hz/FOS
 ES/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321352; x=1784926152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4y99CIHhO7ZMa20JkU9vG7q5Jf/ock0IskJ460LHt8I=;
 b=Wze7k0fmrcLRd0vLrs2Fv66RBI7MXwV0sb/yd2F8GEjaqixNehivjWKyw0wvuCSMHR
 R9kmXCvK8BOxv8o9KfgYhcjgm4sNFoPpgI816+nFohuzTz5cEq2cpjuf2M83Qn6Hex30
 OfKYR6x0F2ooL0Z++tbwogE806VkosX1xMo4Tn1zh8bFaYgclqYX6IJ+2XJgag1Qy2yz
 kIR0s4xWr0CMcFr/9ERWCPge/gebJD6715FpgcIBGRDQ7FsNW3fAP0lNhZ2ADBm8I5Gz
 CRW29mwj0NpMZnHULldH8KLqL1myYZ8l9+AQZKvjuWaO9VC52gffnFQiGOfJAfJ6StHN
 0pxw==
X-Gm-Message-State: AOJu0YxG7Vy/mAwAi+WVB6TnfeAXR5ABrK2+Ou8biiJSBhNQQEL0f51q
 IOyvi1l93DTnScuOsryP15J3GdRfGbwHlo8EGgxIw1RLcalajmpedPGJTGx2mVHSDj54Ho0ASFy
 uSRNMpjAm22YlSp57h7waldvM1jpKaZvGrQYgbqF19lpwi6Cnw+09qkA7OesH7VuBZoZ/1qh3OK
 923bA=
X-Gm-Gg: AfdE7cmLyx/XET8PovHCDK5Mmrid+pmJ/Q0NFtjHlBLwbu26zssYkwR7K3u4ShtiTls
 UeFlB0lve6/8CHz5LURTXnysB2lt5nDHNW+cDby+oZ+Ty3vgIgxY+Dx8TQETRpaVMVQ9qdAu2DW
 vYB+UV6krA52rkb+BsV/PEaHgTAaIhGOJZ/nUvenJ527GTERC5BV3eFCoAYyz9py/j9vRR3EC7j
 9Y0gakVeMTU7sLKa2MwZOVURxC/YDr/8GLhQWBw56CIBqNNfIzNBhXgKzSNKVgv5mWa7CqX6o65
 DMsfCq5wieP1xlUDqm5J7IZBOj9VxJVmIpVMLmDbZ1fnPNUqoEp5D1CRJArW1wN8Dpg9Z1LV8NH
 PtXuLEbc56RSoF2iEJFbIP0PkyHM8J4ZrZup2Kd7DtlZRveU=
X-Received: by 2002:a17:90b:1844:b0:37f:9ce1:cdb2 with SMTP id
 98e67ed59e1d1-38e4b55aeebmr4534797a91.32.1784321351939; 
 Fri, 17 Jul 2026 13:49:11 -0700 (PDT)
X-Received: by 2002:a17:90b:1844:b0:37f:9ce1:cdb2 with SMTP id
 98e67ed59e1d1-38e4b55aeebmr4534758a91.32.1784321351503; 
 Fri, 17 Jul 2026 13:49:11 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e3a11e36fsm3627781a91.17.2026.07.17.13.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:10 -0700 (PDT)
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
Subject: [PATCH v6 14/16] drm/msm: Don't fallback to shared VM for VM_BIND
Date: Fri, 17 Jul 2026 13:48:30 -0700
Message-ID: <20260717204841.26120-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX/Vvbyf/E8vGU
 DlqBkG5PiygVtcRv7mOK33X+6+0Qi52htmFMEOOw0Lk87+k4ojBiy3rtY0Qk0q9n4nmFg5TAXwc
 6UUYHLhXEFq6wF6Kel3nu/aOwKZUfWpiHJUNQAnfwiwX4SHVCVeu/IOyXQ14H/c3SLB0jzQJOzs
 sodUjhsf7CBToCprE/nfnDomL+09U/Sa8Btx6ldWJGnQi1JgfbFa0e48rPRfgNeBbw/nf5u3Vka
 LabVeEp/sG18hgz30VnQu0nlgo5dU9EMnjxZDO0zzXRFCudaO2p7mVisakER98hCf2/Wckh+CCP
 5SAuEt6OOCyTdHIq8QhjQJQwGVQvMG/JNdgFdBtaKo+y6M3B0JC9tOSVgxvqKlFpUJInGMhlfNW
 kQSv7pAHx/BEJtd+omsCF1R6DxI1DAaVXW++rd4bhMZeGL0lfKkfP3FRNFAKH5XeGd2sOI2GGES
 18ZH4qgTMKWdqLVv+RQ==
X-Proofpoint-ORIG-GUID: 5RjSrNfuQdReSfyPA2Z_1vhdqzOFVMUl
X-Authority-Analysis: v=2.4 cv=U9Ciy+ru c=1 sm=1 tr=0 ts=6a5a9548 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 5RjSrNfuQdReSfyPA2Z_1vhdqzOFVMUl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX4ZW0oaN/MOGk
 nX8NTcj15DO0OS/ikv3hc/E9vWFkwBRAHhSXHOHDyQYxQGDcd6dh2KqMjR5aK+ahhRX+TeuAFnM
 H13YgBpMMBuwP6Z/sj/apvgOLkrjq7U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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
index 18ed00e5f143..a1c4adcac128 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -875,7 +875,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct task_struct *task,
 			to_msm_vm(vm)->pid = get_pid(task_pid(task));
 	}
 
-	if (IS_ERR_OR_NULL(vm))
+	if (IS_ERR_OR_NULL(vm) && kernel_managed)
 		vm = drm_gpuvm_get(gpu->vm);
 
 	return vm;
-- 
2.55.0

