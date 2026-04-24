Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E43FE51FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A2A10F4B1;
	Fri, 24 Apr 2026 09:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+Mx6JYq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aXhLUlzK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D6C10F4B1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O5kddF1959571
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tFUu7w/Mdhl
 BRhU4Ur6TRUhTba4EbTByy053HqbjsgU=; b=O+Mx6JYq7lRFZnEvnCHom8+ViqT
 vUb/8nKJbqqYoLFxCdnrkK8qkmQraq9eE/UikMhzqK4la3A2hLQbgfUv5nzXr2vM
 xcVYWE1e4ttib7gQ3oBPEtQytC862/CO3HyokD2leb2Tnlcbj1bnhe8UZqrD6w3S
 pLeOiuoMKdVVvDPtwuO2CjwUzMOfF5twIUdWyMQXf8PSwO2wGrrWi3u38x4Go7Es
 v2fcyINrSoIJ77DNWoVBdivKa4rpuhEcf+gEPdS2ZYJnFeD0+KDBLqehq+NjYIys
 Tjmzv8rU/FvHx70clezLYFEVcXrj7+XuZVItDK9QGbjAxl+JNT5S8Hml1UA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr2nrh3f3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:24 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c798ace3e03so2754624a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777024764; x=1777629564;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=aXhLUlzKTsnLW83UeWeh5n57vZuqsBVCzgRaF6u6KDehpa1x+HrRvDQ3fpphC/aNSm
 fhvtcbF+9uHnWddlU3OBSRlUZA6j8d4GP4oCKfHw9xN27B6F6e3JyMa4ojGrpzxLOcRH
 UWwHRU4Z4VaDjCNAB+3O4g0sNBpMGGQyQoup6iRO6vpckaw73V+NM51XUjgTl/EnEmxU
 hjaZHIMEQjpbKvTSU8zQWBe/18tzufteg1T+bpsA3/jdtGKRUK+wiVwOJqZ9PReumsUQ
 H26xFKZoNSyCx0c1rdN50qt75iY8IHzpigDzlAmTqa9eyK1DhzmXeAnGU4MvjZwuZdcz
 nSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777024764; x=1777629564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=YCMode5Ja6EXZryZsUUhxWWJL6vK+0PWMjzmqGYR2qi/PywoeSv+tvxRmB6sur5pH1
 YvlMmcCnDYTED/Xph3Pr8GtQfsANlFE/46m8Gzm4BsftQnHPXBw0ueTF5YfHSiIozrju
 MqB9KT6yZotaplBJoec0IOeqRO5UOTj3kYAlNIG8/zxxJ6SQhJWkzHlJcSzskyfqhdCb
 GWI4Crk6vnwtlCP7VUG18qbrp5hViz9iGtLbBoQVh/RZr2oBo7Dy/cPqgSK6L+rFUf7D
 UrwHWA9O1t4/dAbwll8BC6aTLiEkPbXDvJKuNcDgTGuEk8R9R8xY4DXgTSy0FFKJS50B
 F/9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e5gBO0VSGye0MuvRaATalYMqqSKQgdZwHYVLyOJghRI3c5hQpmRHoQ32LCABCPGudmqgzqlZrh2s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbbbokRuikDVaqLPPiIz4DfdXAKEGdfoyDZSSXgk0l1UgdqoyQ
 sctW9+eT1/MOYBGHyF3LoMxgX24RK7r5/O5XmsrvVY8PxT7gI5UJdcnymS+34XyfG5yXu6rqAKh
 2lorOjXZzm1WLS9JaI0YpnTl8FYWKCdkqwhQyPs7CA+K3+eB/OBvjnAOXHbC9vh9tuJX+stM=
X-Gm-Gg: AeBDievwIT7K9b9lFdo0GYHb3Qo4MQnAc6DjXSQ4Zy8GmxajZSAPW+xzMQGuWf31nq0
 l7lURaZXW5QO8xw+w5cTN5Dm2SZd3VYMoglQB0itMxAy1Su8yd5HQAYBDWCQPF5BZ8/r4JYeBeW
 hJbIOPkhpbe6GEW7QqRaIQMs+e74nlapvJH+0ok1CUIBbOXSKBsPg60B2OFpjLlxBshF1YrMkZQ
 cvoiIydGIXEcMybkojW8U3e1zMBuDgPhf+hAEUvrY4l10F7RZjB67pNimA39bPmo+10Qfayb2w/
 mTQ4beMQXfZtKD9xvoa/3cm7y6guG8f+KpZ+MKFCwW9+hGlAaehhWrGJsJGviFObHrnKAkaHh6S
 ySdzolh4tz1jh59usvaY+G/ptBZreodt12SCnuv/qjiRC2tB65uizl0FUujkm1Sbk
X-Received: by 2002:a05:6a00:ba02:b0:82f:4cc9:1854 with SMTP id
 d2e1a72fcca58-82f8c93cffamr33456239b3a.49.1777024763938; 
 Fri, 24 Apr 2026 02:59:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:ba02:b0:82f:4cc9:1854 with SMTP id
 d2e1a72fcca58-82f8c93cffamr33456210b3a.49.1777024763420; 
 Fri, 24 Apr 2026 02:59:23 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d35acsm23679702b3a.15.2026.04.24.02.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:59:22 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v10 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Fri, 24 Apr 2026 15:29:02 +0530
Message-Id: <20260424095903.1622565-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
References: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MyBTYWx0ZWRfX3Cava9J7MMqo
 aeGNPLyvA3f6lJSaqTj+8Axzk7O3bEPG0gnXs6m8eVQcoaya4aOJjZyN4XkV2jCyY/Z1OxmENG/
 HbrbIhBOCm4Eb2R4J7SNjQZsFnrMpEaFr41hkMLz7DcE5YnVE9mX5tKzQqHMCh6V0lwfMsWcPNy
 7QePVVrhWCZfbFhTecfV+QKneVsJaOFxN6EO5P8bNmPdCoBdGcIemNWZ2xTzaGpmvMNGy1nArUM
 u0KNsZE+E7BOHPJ5mplXvphgTntxr5sUSvIY3l8fxgA8wn0f7VEo/qDlPZwRkOmLNNpPQpgQ1Li
 GtxEWha66D9uoDGmq366ZbF+w9d+qn9d/sUnP+Jm6acXxccp7ZPcJgahoBOKx6K4r5XxyUHzbiO
 x/UFYzuKZZ/HOXwgFyUajfyFwii2F4/7Pt8UC8nL3CydUX5AiiRcJl5/tjaoQKdbDxkKMHFRuOK
 WtydTMnpN51H4CpKtcw==
X-Authority-Analysis: v=2.4 cv=UqpT8ewB c=1 sm=1 tr=0 ts=69eb3efc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: fjRYvSOvZ2FYg97ojT5WudhLzIzf-9Ik
X-Proofpoint-GUID: fjRYvSOvZ2FYg97ojT5WudhLzIzf-9Ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240093
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

