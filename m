Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9557BC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044B410F5FC;
	Fri, 17 Jul 2026 20:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DPwoP/H3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H57qmUpx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C75610E4F1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtbpj2906442
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6DIg0hlu8qf
 HUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=; b=DPwoP/H3ufNRn+Fl9blicbA6v56
 zh8FQw+VWMQbbn1ixbGniXIrBG3RtMHYj7jkOWIgH3fxAUCQWqLRRUekRUzktYBq
 oG2akPAGgtX6E10yRLFQaL2nIoeZUpqSl7jO3YhcteDs7Pwp64hrLUGNKoeo9SjQ
 jdxMeMxxqySY9Hca7/gD5It7E76IjBUAGMjFx8a9PTRS85QLbfxH00NPZ7ZsK69E
 vuyrUYmT9tKlWcHv03xreoztgA49JpA1WPetKmf/mVklKpY+Twyruq3uWJ5ltNGG
 oEy+8sfSZNxuMDbfTrPBRZmHnwmT5LdqExDObrwUOVI4SC/uKwCObBEPIyA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrsq8re2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cce870a060so145980215ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321342; x=1784926142;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DIg0hlu8qfHUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=;
 b=H57qmUpxKkL6I+sk+X57HrvYrcp+nrDH3TszFhNN+qNjmWyszsKGMBq2ukExl/haxW
 CFdUpYCIJ9BLY3xQufQccw+aj7rG13g2iJy5aWaQZh17c98VAHqFPw/zO5MotWWXUq1M
 Yq8MqRhYOF7osUUrqbcGIONW5MeCr3yzQVusVmBSRSzbewE27bCv5JqRZjwzU7gNBZ2H
 KnSauA6gctfyskFmYv0dqiMEqcx6pFmR1QXE5A7AocWUtxX6/eZDAkj3dlHaoTLTmTVz
 8D/UMcJObfgd+kpBQrm+ixxvDhJeYoPOv2DOxi58dADfTGCUsfbZS4NoKN9iQeXcpWk/
 /M1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321342; x=1784926142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DIg0hlu8qfHUQoWpRSk0/2wgFEbxEIf2WTCugbqRdk=;
 b=Li8zbxMG1jtcD+OYCD0OiavSxM18mO0trt4/CyJYitqL5A9rpRAbbnh0+vlSDQ6bpz
 KWcVqXAIsZ/H2Hfw9nBrCQcUjS5BbzCxgUc4UEdVq28Nx9aczi2zrmfaWMPx0HDNN2VO
 ZrN/l1BRWXiW+DMhMmaorAtDwSTtKw0Vh1Sypg2CWa9SLD+rSoGoKqlYNrAP6pVAfzoB
 j1ZJlYXws2TCPVO+yUH2Og9YlAkp9DJG6uNZ7m0C9wJYpoHYsIC3DNf1S+MYb3fDaR7f
 lg1/gGMfWKrZFHscl4naaN/6OSwHvfaJtngKtPBrekHfyGNw1SU0rDbNavuxY4FVTQAz
 hbVg==
X-Gm-Message-State: AOJu0YxQ7BXk25r89h11dCwgCemosLFNc1mfAILCjEm3Oh8UiGnKrBIM
 ED6aZyeMScusC4FsXOv9647tMqyOUgmR/eVcxHYh/wNT5jUfzGgvtE79EwBfpmUaaRVFdJcLelA
 sGRFQFzSg8qlTAf8AU+mQu/Ou9mA2t/nKuZmYEPc9Y8+tHGb+e6o1Vh/KFyep/r6NvQnnEkKPrW
 SWrIs=
X-Gm-Gg: AfdE7cn+z0FeKlZm7StgOEbcxDnq5o+QatB63kfvdM8Fo04paIieJj/S67/KE4Erk+j
 UUYyz186fSyYr2Ajsdr51uxxgf4Tp5pb/OwvRofDKHnCTPBfeiOo9YfSV5nPwfDadQ7LijMAuXR
 2XPlhqaNUClqVlt2TFjJ+oex+i1Rd5Bbgkr9zNf70yrVQgy/Crb4QXfPO0BBcKa4cVa+R860C5e
 sx5I5vodL+NJVDBzMRHd63mQ+l15YajRSYQjvMXNDTJtnIFqbGd6FH9oP6lem0jEMh6Oo1VRrtX
 OOfUQkbCfEOZ5DNxAI5Sl03FZiwUO3BgjApIJhbDRRveUPACFUeQB/Y5Y1zwEf/CCHQ5VLvDa0B
 LWCYDUij0SnGvDuALoyggTYG9wP9dQWkG3x/YzeQ7Ih6Inlg=
X-Received: by 2002:a17:903:1b2e:b0:2cf:32bc:9722 with SMTP id
 d9443c01a7336-2cf349979bamr46951105ad.34.1784321342399; 
 Fri, 17 Jul 2026 13:49:02 -0700 (PDT)
X-Received: by 2002:a17:903:1b2e:b0:2cf:32bc:9722 with SMTP id
 d9443c01a7336-2cf349979bamr46950785ad.34.1784321341975; 
 Fri, 17 Jul 2026 13:49:01 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf346db036sm17221035ad.46.2026.07.17.13.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:01 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 08/16] drm/msm: Add helper to check for per-process
 pgtables VM
Date: Fri, 17 Jul 2026 13:48:24 -0700
Message-ID: <20260717204841.26120-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX4uhSDmTAQibq
 eAKMgtSE0fqNEdLK6H4oizxLcguoXtaKNkvLd19RlQOSz7AYQ/egQcrEVkq7281835VFkR/8Nj+
 k2Ts6O9nuvjJhJxN7vPHcoCr4vabmxg=
X-Proofpoint-ORIG-GUID: 9C_TdF5tvmvDd4ViArAh_M-AIsf9qQGq
X-Proofpoint-GUID: 9C_TdF5tvmvDd4ViArAh_M-AIsf9qQGq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX3jvneMhMZB7S
 ZIYw5PKzAer1MzSZce0M7THwKIMVnZGX4sbruBEWDTP4QYS+3xKZU3uz9CuU4FvteLrQ1B/u0tu
 YfllrN0ywUdOFkKS6Q19bgcvkVpRimSXf4vaXO4hYBVvUeoFL6tZFju8pdTxxdWEQESYiCa+CUi
 KiaV5qTfEX7HAygbQ7AZPulOI+cBOYi17u0P7hanxtWGTUv0TCeqI9XLsKmpp9jBkCbhpRTp/g4
 pdqs7sfdQpp6e2PdE7U1ECXA5Vo0i7iZAYh+Nr6v1TjZtICkx2pikHH84kdBx0C/joZLgtDuCJf
 LiakAcRfNsq/o9X39SWO1hGO53zlw2KkeADUFYdvN7gBK2UMUOQc9fYa6V27Ol2xOgL4opq1l4F
 CYdD5UHXw9GHpiYHD+mJ0y2H4TDpSh4zUC9ZbjMQRYVI26VzEFI/3c2cXqdRWttUqZpdQuvrtSd
 uDuJ3tujvswZ/U0J/kw==
X-Authority-Analysis: v=2.4 cv=OJIXGyaB c=1 sm=1 tr=0 ts=6a5a953f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=4aDCzPfTH0uMOhJcsooA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170214
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

This will simplify a following commit to allow lazy VM creation to fail.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 0d54141ff089..5738eac9aebd 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -356,6 +356,12 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 	return 0;
 }
 
+static bool
+valid_per_process_vm(struct msm_gpu *gpu, struct drm_gpuvm *vm)
+{
+	return (vm != gpu->vm);
+}
+
 int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		     uint32_t param, uint64_t *value, uint32_t *len)
 {
@@ -414,12 +420,12 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = gpu->suspend_count;
 		return 0;
 	case MSM_PARAM_VA_START:
-		if (vm == gpu->vm)
+		if (!valid_per_process_vm(gpu, vm))
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 		*value = vm->mm_start;
 		return 0;
 	case MSM_PARAM_VA_SIZE:
-		if (vm == gpu->vm)
+		if (!valid_per_process_vm(gpu, vm))
 			return UERR(EINVAL, drm, "requires per-process pgtables");
 		*value = vm->mm_range;
 		return 0;
-- 
2.55.0

