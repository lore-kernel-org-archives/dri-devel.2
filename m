Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C93CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB9210EF05;
	Wed, 20 May 2026 06:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PY5IXu+Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ADSoha5H";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444CE10E5F4
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:08 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JMN35K341538
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tFUu7w/Mdhl
 BRhU4Ur6TRUhTba4EbTByy053HqbjsgU=; b=PY5IXu+QmiipXKS5ptBVL/hfa6i
 irYkrRW5+36Ep7v/ipE3UqaybAj56aw7Ho3f2QaadkNBaqBO6tMu5dSQyu/DnUpl
 l28Pp5qpR/v9a/HQ7KBLkBqq/HRfOywC7Ewxs7z0dNzI7ExI7WJWUQk9d4VFrbEw
 iVRReHKhZJGDUAhAyP/t4x+kp0D/M/7SSyul/dgDBb4KR9xKlvkgWoVUXR5ohfhr
 eSnZgBSBAtJhowGrol/MWtMLfXU6/PMu2RpiFutLb4I09rRx8Ups60LXQGkh6n7F
 /7eN5F4mgOGpQIUIyqtxm+oq1Q5NNKKztAo9/gX5TvYFitKElfG5mpWrwaA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vbcbx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2babc42244aso111342855ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779259866; x=1779864666;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=ADSoha5H260AF6IFiaLw3HpS9Yp1X0TPoL4WR2hqbjkqFHV7/jgFgtHBgrwX1oXJbJ
 CSFXvH5X/SXPh7wtU0M/tRUtX2a35zsL5OjHwEMCMNCngCZWusdmZ658OYZZKk/x6npe
 MPvBgN9j1btep4TQ32mC4SotzdtUtR8l2TmlSxUzGQW6Ig5PsQsl+WCYP7OB42gQVE0v
 dishHm9m0FH26TDoaLXN5LMdu1H3YghUoUPI7mIGz5tx8HHs9euOWx1uhm4V4RMMuAzM
 PCCAsoBVk/RQsjipKx/MMzzEcPv+WXcXowlqz3J4AqW68IxeM/fK9YcZTgYRxwP/Y6ME
 z+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259866; x=1779864666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=KZX93wpBxMf4Dh7KqkHR/AkRvmwmIF4c5CKyYgCCHKH0YOSK0Hmm9eTWrouQzJf75R
 LXEXdtnQPS793NM763JDm+xRlK1d9A9FzaA3l3NY6C16wbCS0RFOdgkhOgDi2fOdtvlO
 ciIAqA5BQXuxaOAfRPz9rIk5d/hQ5HmvvOLn1EyEy1VeU2g/CQttiw42Anhi4t4O1WGC
 4S4BRWA34386JwRK4IbB5IoWw8UmmvvSdswpF6J9Dfi5iWv4Z1BigmyDJZxHbVyVVzVY
 SSXCiQZZtQk39llpp+22aqPkYXn5RwO6+CZFfoG9GpjjFR0s0MFdHw7nc7ISIaJ9qvMC
 D83A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bXRcw1XYcarmjjlzCHjP8Q07YXckl4g5XJjV+GkRFzv51YNh5bxjI0NUyTQNT/jIu3Rm0owsllLQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXl8QF3IxVQihm7U+8XTZseMBIVMe8q4UViwBhabZwnaRF/6Ju
 Cbv5l6PwarMjFdIWnEMib8Q+nLKRQWS7RNAHre8gXIKcOhLhsyIermQf5ewQdt8rwuAgG1yILnn
 VLQ93+6Z2i0FVoaekbcjBLdGihkdqYhnEUjc0Uch7tuF9WXJaKF1QwU+chOB42CTLv2U3rtc=
X-Gm-Gg: Acq92OGY8592xSSll9qYdXx4r30DMX/Uovj1evBUyeEa2Z1Lx6hDHxum6ldIaf1RvLI
 NeElMqJrqckOnz3RJfp32Hppkf2sAzdOrhsUP/YGqYDS9i4+9JISIVdHVbhestIjeMetFammLiX
 hzFOI64eO3/vbny5bLMsd/CJANjecVretcUU0b/SNXqdJi/wi4w2sYvn5MhIdgx0OYAIzCrZ7Tx
 T/UAOOnLE3gcTVfr6iyBqrLzaUKn4B92ZjZxJFIVMTlNBzZRe+FZq+mZaFSozE6lyxcmMm8CIKO
 dioC3bU0PWp/iDoZdvRHiHTxuZMQs86+Io6HcV1DDIlk/XIibQyO8OSbDnapSkEIvf3ackEeZYj
 L5P6rVxsLZkZlz5PeeNlC7nqhbfB8GPfuOH3fI3EqDvOhk1nWvboZeA==
X-Received: by 2002:a17:902:f64c:b0:2ba:fed:7891 with SMTP id
 d9443c01a7336-2bd7e92c24amr260092515ad.30.1779259866271; 
 Tue, 19 May 2026 23:51:06 -0700 (PDT)
X-Received: by 2002:a17:902:f64c:b0:2ba:fed:7891 with SMTP id
 d9443c01a7336-2bd7e92c24amr260092335ad.30.1779259865775; 
 Tue, 19 May 2026 23:51:05 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fe51sm206410165ad.2.2026.05.19.23.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:51:05 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v11 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Wed, 20 May 2026 12:20:46 +0530
Message-Id: <20260520065047.3415790-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
References: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RNkoZOuOTYiUWz1e2qSHUYEgX3JWDbo5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MyBTYWx0ZWRfX6+BEcwfR8qHd
 AWB8hOMLO3iFYt+haMf0eONzh4xaWGjJlxRlcKYmMHjmzHuqv5fMDSyMzIlDoyZyUmH4mNhAfDO
 kB9zwn6CEDtKMAzFokS4hP8PVr988gW5VvsdPw9LmNHhet7Q5XJ/CFO0OCxJcLbMYUcgeKdUziS
 RzwRiu89u6xunvtCqVYbHxyGE6rbVxmPx/PLr9s+kwdeGUDYCQCyE6rY7v6ut0wZqdwaIWEvkZu
 3pMT0HcmZS/HCpm/kwaoO50yl4tnyTfQM74b3GLrs4TJJXT5668pjtQfxm8CuT1fcL0+/qJJxmd
 +4dBS6D1cMKMEpyV0Y3zZyPJXhRHXlmUjiYqPVyHx+eCPdvdJbHT1mkEh/iwdu4YL/633WVc4dN
 4sR7r48CIT4102r9JjeiJqpGPRQ5jK0n5YqKGYMAuYx2HqYdhH+Rrdo65JlO1Xe18vmN9cs8lcD
 cC/+5QTBN7A4n5loGxA==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d59db cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: RNkoZOuOTYiUWz1e2qSHUYEgX3JWDbo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200063
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

Current FastRPC context uses a 12-bit mask:
  [ID(8 bits)][PD type(4 bits)] = GENMASK(11, 4)

This works for normal calls but fails for DSP polling mode.
Polling mode expects a 16-bit layout:
  [15:8] = context ID (8 bits)
  [7:5]  = reserved
  [4]    = async mode bit
  [3:0]  = PD type (4 bits)

If async bit (bit 4) is set, DSP disables polling. With current
mask, odd IDs can set this bit, causing DSP to skip poll updates.

Update FASTRPC_CTXID_MASK to GENMASK(15, 8) so IDs occupy upper
byte and lower byte is left for DSP flags and PD type.

Reserved bits remain unused. This change is compatible with
polling mode and does not break non-polling behavior.

Bit layout:
  [15:8] = CCCCCCCC (context ID)
  [7:5]  = xxx (reserved)
  [4]    = A (async mode)
  [3:0]  = PPPP (PD type)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3f5d5d73be5a..c4a3547a5c7f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,7 +38,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK GENMASK(11, 4)
+#define FASTRPC_CTXID_MASK GENMASK(15, 8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
-- 
2.34.1

