Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBDDC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E00810E4AD;
	Mon, 27 Jul 2026 17:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H6yZMlzt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B3axaHUK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C97010E4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RHKcXK194040
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YhD2+q7DI4A
 UEN5rkLNrrIb48BZuP48MkgWKn7wK1dc=; b=H6yZMlztaVJxlWo5rCHHOWyWfA8
 g5ItqUw6r53slx3ZcT/46RSMcr3ATeMalBR6NJsVJhp8UKBiiUF2xcu45raH1L4v
 ZoN1u47sx5+A8cMhyBHpJjQaENZOOt76Sk7k2usbJbXvEvd9AhRYjSzSbT5CxUTw
 NuQPTqB0rKkK6mCS62lRk4CT10n1KDu+IvrPPUUU2/W1uf5RlO02HSpHZMpSEyXg
 bddbw47FJ2rioypZQxWLOx8azF61pOb3vKd1/f6EX6Gr6fx0opGuRTuztjsv+hvD
 lT4I/b7UuFcj7cQBfng7pKcIkqTkyrq5vufTNH4YzifrwkC1yUqm9SW9yiA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn881tu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 17:33:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso54419551cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785173615; x=1785778415;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YhD2+q7DI4AUEN5rkLNrrIb48BZuP48MkgWKn7wK1dc=;
 b=B3axaHUKEoL1jIhFgz4E7cqZsEh+AiPq7KQhKhVAdUvtzPP1JF7YGEsgKq11W3Hphx
 UrpkovYcqkbpmLtgQw6jjHqxZRU6SUvZyAoe2fnloM8aHZcq0MXtAiC9iS2qpUvIxX4+
 b2JfkcuaQyLgLR5Z5LC+3OlNT3tw+IihPVQn7Vhka7xYSy7khMBUKS8HiPzB5Mc8/n0l
 3A0Enycd64xln37k076tUqRp6MZr3VUtXiLqD0vog4h13jkuYl0U4nBqfN0DnkvPmBkB
 PHVqnijIF5cNNdCZOYCELb6DmY2c+OkeABhNMMd9bs2989MF1NpqiMMSOUraRIOnkmDF
 8V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785173615; x=1785778415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YhD2+q7DI4AUEN5rkLNrrIb48BZuP48MkgWKn7wK1dc=;
 b=a6Pv+Vvyr5FbyFFjEqDGthJdhiLUNFWzNuYTPbtyiikyqBRBoW3jaa/G68drNzyfe5
 Ni8NIzvc7vaHsDKAg4AKUYYCuesGzZIKq0m8q0xCuAi2NfT2u67YXWXePuEH/dXxPTsj
 U6r7IoQeIlzbaODseqDUdz2XYTpAeSfRsBCPgN804IHw8kMKVuK0IcOscXhJ7b0OLGo2
 PU4VWKE/XGMyLLFiKtOX3OPkNJyGsWQuWcE3aelmPBbtCSVjlpGHEafAWPmH8nBdCQ2Y
 5ht1EZXuVpinAAYCByGaoj8D6icbDDKPW+8n7Ibx44NvOoItGpgUKVOUIHmgP5i133Dm
 ZtkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlGYsCKA747zOPJ3WQD5QkhpphJ6KeRxpW7n8rzgTf6JTx5I90ioThofjZwfnLMWSil4NzZpm3GMk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx13xw33/xtTG3TAvt7D9lWOvdn/r+zteOhIRQHQDGEVCMouF/P
 u3HN7RVjvNtGG/3hbsuJflU5DxncvLDEiOlAG+oP2h/gjGnXNHyQLJ1dr+gWHRhDnVIR56jJ/SG
 1V9ynjgt936DXE8F9tx84N7gMcgJdgm+RNAHkaqzfileR5MtVrmOAL22cZ+jbwWeFD/s77fU=
X-Gm-Gg: AR+sD10DhPiMNyFtpSDV92CywkA5NcEAU74uua0q066krsR/7BAl3BAmjlirRjtj5bH
 I6kQaFLz8t7AJK1cIhsPyylWV64qBmZack1YigwT1nxlGyUjo0ZVo+kPV8RmUwNk5ld0srZ0UpO
 ctZvPkrJjhwjkWMKkuSgUdDwV3ghq6b4zH2wLLajL7IyxjKsO9Oqpw4u3UtPXhgblpoqSOcrZnl
 q+2AC3xBFOz4T4R3E9Nb/nAoyXnxQySGjghluNwwIKz3zM3EyZEsl9BuMc4vOKiDdSbTxTgL+re
 OeEoU70vv+XSwQ637oCrDcIOE+jhnxbDHXvNrwlkb897z4d7Y2+4hB1vxJK2A9NqHN6iLRtVwNV
 bfgB2XUbsmvZG9hY+JuiHajvcwlhkuAlu1TIWOnm8
X-Received: by 2002:ac8:5813:0:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-529d1c72479mr5131631cf.86.1785173614990; 
 Mon, 27 Jul 2026 10:33:34 -0700 (PDT)
X-Received: by 2002:ac8:5813:0:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-529d1c72479mr5131231cf.86.1785173614486; 
 Mon, 27 Jul 2026 10:33:34 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5543370sm2945391a12.15.2026.07.27.10.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:33:33 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/5] accel/qaic: Add <linux/device-id/mhi.h> to qaic_drv.c
Date: Mon, 27 Jul 2026 19:33:23 +0200
Message-ID: <20260727173326.2219191-3-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260727173326.2219191-1-youssef.abdulrahman@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX/PF/0mSSQ9vS
 ZdYjMLXJfa0J4bBI7sGm5rd4f7dB2L8PLDADV/yNnuA0Y2NMVSXchJf13XO30eDxfhu5PpV4ij4
 jTd2UQ/xVL3Z7XXKg9ftld+T+xXAZRn/Iq3jcbRrQEm0M8RIGjqVnWs9Mbx0Z0d8fbT3gviL1at
 +Wv4gk5Jrg1fCIH1HCiMXDNfT45bf3qZazfPUk/eJXAMqG+VanAEHwbcLVApFNdW5JouIs6NSYn
 gGsAY3geb5ubhghogOy89opK7YPFO5ZKf6oLNC/60HuzzUeeVbcypf4XsYybKBKc0BMY5/zURxY
 Ca6lTQ0xMXLmOfsmwyEjVZczDoDGVLYyH55K5c2vKcJQ3CACPqA2Kb34VfjB43mySXSdhs+ySPC
 t7tujdNs/CMrfgH+FyKgqE68vB4TuZBVoI3yZT/zd0SgLGWgpATutjp8AnubEz2erRSc8Qv4XsH
 EcsgBaNIxMpst1m7fhg==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a67966f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=470nOrkEHAbYtoG9YpMA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: oGykzpssOKtPjb6EmbsRo6jMyGFRIPln
X-Proofpoint-GUID: oGykzpssOKtPjb6EmbsRo6jMyGFRIPln
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MiBTYWx0ZWRfX4OrD2xlk7koa
 wOYeMOhRptk1gwGxd+kJt6gY0+Jm4UkXyNic2iP+C/UgKDsGEX53tQnrVm7BqpOGkaQXICJbqSJ
 xEXcPYV6JiejIeKJoWSbEhR5m8vB6GY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270162
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

qaic_drv.c uses mhi_device_id implicitly. Include <linux/device-id/mhi.h>.

Fixes: c501ca23a6a3 ("accel/qaic: Add uapi and core driver file")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 0acf6cdd44f8..c1bb6db78d12 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -4,6 +4,7 @@
 /* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
 
 #include <linux/delay.h>
+#include <linux/device-id/mhi.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
-- 
2.43.0

