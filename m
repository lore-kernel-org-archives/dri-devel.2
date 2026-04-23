Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1969BF589D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7134810F134;
	Thu, 23 Apr 2026 13:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ou1L+JEe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KYADEJJP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF89910F12F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:31 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8uM661565689
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UCyS/VSZ598bgRvBororH4kzu2wJIntee/DjGCCJkUA=; b=Ou1L+JEeJU6MbIKI
 20PGOoNTYvsyMdxzlYGyJ9kq7WniVsEPfbjt8jX4NIn4S8VZgaUPCLXKSlBrHP9I
 eYJa3dm1iWqQ/G+MkYFsIi1IYUIfsfZ4JJ9rTkk2QiadNTNXxLcZmvER/DHrq6tm
 QbfnRHrnWnbYa5/2s01/BVDp7bapY5lx/8LgLg5yU/0ZfHGRxx65L5LBxwGC9RgZ
 D9rqeFyPz0WIfHEhvXOD3jPRFzoCZlHWwYeALhbJBTeFikC4sW6cPr0juo0nqaUb
 dbX7rt8WJXvjnFl4wlm+kXQTsATInldn4HxRaLXjLLfGrKpdW4k06ZPRuyf9+JIN
 Z+ypug==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wv7md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b7aba0af02so6671625ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951090; x=1777555890;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UCyS/VSZ598bgRvBororH4kzu2wJIntee/DjGCCJkUA=;
 b=KYADEJJPh2aZck9hpnudbPTAsQI0byoi3Hy5CVSZ3DqEgqKmhVKRnd30kNJO5n1R/1
 EKhgcMqH0chv7nvYBZ7hc02gBnXTbDEnLjLl3NXOkPkKuDpVCw8AwVKoDim46MOdxAiN
 9whsJ21y1po7atCRGwSM/E8Ga1xLwOsXrZO5tL3sgtKbXBARqBKl+X4GJNa/S3WOX0Ij
 Yh0pgQnO4geu+P3ZwZCxkRgHT3HKzVFnt2mjQOyssvRTU1qjEi2qTBlBBUE5LEp1m7dK
 +M7wFgZ6ul+sJbd/lWw55x4jv7zbppeoPSYQ/qLTbUPrdEM01IqmIRK6FW51/H09BgEs
 1MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951090; x=1777555890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UCyS/VSZ598bgRvBororH4kzu2wJIntee/DjGCCJkUA=;
 b=CgBNLSVa6x3j4eZoHBJEFIo8/4fEKUbXnyrdxeVDJVA8EK//TNf0J+ywHIWEy7MjM4
 EsROYta1zA/OLOF/Y+lC3lMHsaNJ2BAjBifmqpp/DX9wvjOBtqtFd/ushUY50LTjoQeY
 EZrapOZicYnZatmj+YhepHMbyJ7u/+vAOI5mdrgm46RZf078pPgFuB1/xzVaBAffsLYt
 CUVUhHYF3GEoW8kk8mFV+ijVJzRHzIc3ARtaO8PB5GVDVOMyMDuIlJgOT5kAJq5qV2+N
 dU1g5UkCP+gLR4HHR0tDTvQ7gkfJP5KbOSmwFVoFAvv/IRWc+o8dFPwy1DCotT6qI+D5
 tjOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yVyL+7FmcJOHOOoDZ40cVc6zuhDQQCU6YWZSlWldhSj6oSOtjHFvyJqet/ux+MsgE0yAoWUWfi6Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVf1sjt0vCT3rxPm0GjgD6BWK9Y5vmbBdjJ/qrx9HnoZH7e1Ny
 XiFqXRpzA4luRWWf+BArQ92NKxrRdYyNjpz1wacsAo6EzDKoufLDt/Z6fGuD9eN9bTrCUpS+InQ
 TgkH85SlQEFdxJ5yz6uPzKRP38eRdxV2qz3WKwi7+Gw5exDmqsKTv3zkixe5YrYClYADOTqU=
X-Gm-Gg: AeBDiespVycN9gr7rpcBrzgvlSSvQbA/HBNhWw2EyW2e3R2J0dBoiCzzsubWqpbAXuP
 GW+aRi8pfjOO0hbUvhQZ+b8Ea9nXa3oTK1h+1nUGtvjCXH09qgMMc1RWhsRnPV9OKaTEkkifzOz
 BLpte93jl9wXF8w9mkmcq6RPKCa4YZJinWCuUFg9b3XkRYly+GnHb3Tu10baPKubPGRbGkmG1uF
 3Zl2cslYkCe1Bl0py8acv3M7OSSbAXvX42jLb339hw9PxlbkR0Y4LY7T46KC8i3xLYWz2Tvk6/8
 dClZDkx6+DMyoqwyWL53RsogId/cvKvrfkTl7l6qRIVZURIUBiwlX5RQZ23tUutuyEgHBHU/yoQ
 6vGlZzybjjYlSZCyeZ6APWGRXrYNwe/tVCgpHwJFlpij8Ey4MgV+okZn8cO3R/liQ1g==
X-Received: by 2002:a17:902:cec6:b0:2b2:49a7:a5ca with SMTP id
 d9443c01a7336-2b5f9e8f561mr281600595ad.5.1776951089177; 
 Thu, 23 Apr 2026 06:31:29 -0700 (PDT)
X-Received: by 2002:a17:902:cec6:b0:2b2:49a7:a5ca with SMTP id
 d9443c01a7336-2b5f9e8f561mr281599595ad.5.1776951088360; 
 Thu, 23 Apr 2026 06:31:28 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:31:27 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:39 +0530
Subject: [PATCH v2 10/13] media: iris: Add support to select core for dual
 core platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-10-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=13641;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=PdPE7KqUQFuwPsQRz26oiYLnLc9ew3D9O8MAtZ75eWw=;
 b=ImYzh5zI6yr2cxuvnsS3NP1ZxtpA4Gb5upNYrdl8KmojLsvNQS0KxwJWnSCqn0T4niPiCmIXd
 OmPsDqBaNvDCwc23rFgUnqkYj4LCtnAuz6yD325zsNO/VMxRMifTHN4
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfXz8Ym8T4lRCTC
 yyVs6Y+n/hCebirWHfMm5CSNM9uver555Nukx3JxgtzMsYAYdLpbm4WjWmo8UU00p/tZypN4Rlm
 sCM0JPJsATxjLK+avsTTQaMcjLWClbKqwOf31UI2gxXBgo8a8wczED/7a+uYD2VAFu/JIUvkObj
 LxkNY+62dappenlPUM7odpbe04j05i4RaaKlAyT0bsaKHZ21zr7gMp8o9QPvBBsBUolFKGbuWM6
 /iqjQgJOZJkZ6M7yVgvbVrBp90pPSb5LF0Ufse9XBq7521DyX4jb3m83xOdRZpApZ28uunMZDtx
 Otr3529GjeuU1XIh+B8Bfh0/Bw5V/ecnUqe5u/fpnhaAwnwseTY23L5L8FvTb2u8Ew9IIzYWWLK
 DC93ZKr3wrYGkVUAVJMeSBEfy/1B2FPpTJW25xrDgWpOD67foqaQZDt5RoSrf/Qcc5gBCtBjWQk
 RUPH82QdCgztI+XI39w==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69ea1f32 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=SR9mA3E-jA3Ceylw1tAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: hgm455ZNvl9ADfoQWn3r0nt26ukAYCuA
X-Proofpoint-ORIG-GUID: hgm455ZNvl9ADfoQWn3r0nt26ukAYCuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

On platforms with dual vcodec cores, select the hardware core for a
session based on current load. Assign the session to vcodec0 if its
MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
the selected core to firmware using the new HFI_PROP_CORE_ID property.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_common.c     | 10 +++
 drivers/media/platform/qcom/iris/iris_common.h     |  1 +
 drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
 drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 +++++
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
 drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
 .../platform/qcom/iris/iris_platform_common.h      |  1 +
 drivers/media/platform/qcom/iris/iris_power.c      | 11 ++-
 drivers/media/platform/qcom/iris/iris_utils.c      | 87 +++++++++++++++++-----
 drivers/media/platform/qcom/iris/iris_vb2.c        |  4 +
 drivers/media/platform/qcom/iris/iris_vidc.c       |  6 +-
 12 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
index 7f1c7fe144f7..3b3fc482e194 100644
--- a/drivers/media/platform/qcom/iris/iris_common.c
+++ b/drivers/media/platform/qcom/iris/iris_common.c
@@ -46,6 +46,16 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	inst->metadata_idx++;
 }
 
+int iris_set_core_id(struct iris_inst *inst)
+{
+	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
+
+	if (!inst->core->iris_platform_data->dual_core)
+		return 0;
+
+	return hfi_ops->session_set_core_id(inst, inst->core_id);
+}
+
 int iris_process_streamon_input(struct iris_inst *inst)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
diff --git a/drivers/media/platform/qcom/iris/iris_common.h b/drivers/media/platform/qcom/iris/iris_common.h
index b2a27b781c9a..34e32c60f768 100644
--- a/drivers/media/platform/qcom/iris/iris_common.h
+++ b/drivers/media/platform/qcom/iris/iris_common.h
@@ -11,6 +11,7 @@ struct iris_buffer;
 
 int iris_vb2_buffer_to_driver(struct vb2_buffer *vb2, struct iris_buffer *buf);
 void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf);
+int iris_set_core_id(struct iris_inst *inst);
 int iris_process_streamon_input(struct iris_inst *inst);
 int iris_process_streamon_output(struct iris_inst *inst);
 int iris_session_streamoff(struct iris_inst *inst, u32 plane);
diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index b396c8cf595e..54a8649841e4 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -30,6 +30,11 @@ enum domain_type {
 	DECODER	= BIT(1),
 };
 
+enum iris_vcodec_core_id {
+	IRIS_VCODEC0 = 1,
+	IRIS_VCODEC1,
+};
+
 /**
  * struct iris_core - holds core parameters valid for all instances
  *
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.h b/drivers/media/platform/qcom/iris/iris_hfi_common.h
index 3edb5ae582b4..fbaf852a6b99 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.h
@@ -124,6 +124,7 @@ struct iris_hfi_command_ops {
 	int (*session_drain)(struct iris_inst *inst, u32 plane);
 	int (*session_resume_drain)(struct iris_inst *inst, u32 plane);
 	int (*session_close)(struct iris_inst *inst);
+	int (*session_set_core_id)(struct iris_inst *inst, u32 core_id);
 };
 
 struct iris_hfi_response_ops {
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 30bfd90d423b..9d9fae587297 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -1300,6 +1300,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
 					inst_hfi_gen2->packet->size);
 }
 
+static int iris_hfi_gen2_set_core_id(struct iris_inst *inst, u32 core_id)
+{
+	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
+	u32 payload = core_id;
+
+	iris_hfi_gen2_packet_session_command(inst,
+					     HFI_PROP_CORE_ID,
+					     HFI_HOST_FLAGS_NONE,
+					     HFI_PORT_NONE,
+					     inst->session_id,
+					     HFI_PAYLOAD_U32,
+					     &payload,
+					     sizeof(u32));
+
+	return iris_hfi_queue_cmd_write(inst->core, inst_hfi_gen2->packet,
+					inst_hfi_gen2->packet->size);
+}
+
 static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
 	.sys_init = iris_hfi_gen2_sys_init,
 	.sys_image_version = iris_hfi_gen2_sys_image_version,
@@ -1317,6 +1335,7 @@ static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
 	.session_drain = iris_hfi_gen2_session_drain,
 	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
 	.session_close = iris_hfi_gen2_session_close,
+	.session_set_core_id = iris_hfi_gen2_set_core_id,
 };
 
 void iris_hfi_gen2_command_ops_init(struct iris_core *core)
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index cecf771c55dd..600e9dc07669 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -56,6 +56,7 @@
 #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
 #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
 #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
+#define HFI_PROP_CORE_ID			0x030001a9
 
 enum hfi_rate_control {
 	HFI_RC_VBR_CFR		= 0x00000000,
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 16965150f427..dd341ca5be57 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -37,6 +37,7 @@ struct iris_fmt {
  *
  * @list: used for attach an instance to the core
  * @core: pointer to core structure
+ * @core_id: specifies the hardware core on which the session runs
  * @session_id: id of current video session
  * @ctx_q_lock: lock to serialize queues related ioctls
  * @lock: lock to seralise forward and reverse threads
@@ -79,6 +80,7 @@ struct iris_fmt {
 struct iris_inst {
 	struct list_head		list;
 	struct iris_core		*core;
+	u32				core_id;
 	u32				session_id;
 	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
 	struct mutex			lock; /* lock to serialize forward and reverse threads */
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 8995136ad29e..502d7099085c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -258,6 +258,7 @@ struct iris_platform_data {
 	const struct tz_cp_config *tz_cp_config_data;
 	u32 tz_cp_config_data_size;
 	u32 core_arch;
+	bool dual_core;
 	u32 hw_response_timeout;
 	struct ubwc_config_data *ubwc_config;
 	u32 num_vpp_pipe;
diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
index 91aa21d4070e..0e116c63f529 100644
--- a/drivers/media/platform/qcom/iris/iris_power.c
+++ b/drivers/media/platform/qcom/iris/iris_power.c
@@ -77,9 +77,9 @@ static int iris_vote_interconnects(struct iris_inst *inst)
 
 static int iris_set_clocks(struct iris_inst *inst)
 {
+	u64 vcodec0_freq = 0, vcodec1_freq = 0;
 	struct iris_core *core = inst->core;
 	struct iris_inst *instance;
-	u64 freq = 0;
 	int ret;
 
 	mutex_lock(&core->lock);
@@ -87,11 +87,14 @@ static int iris_set_clocks(struct iris_inst *inst)
 		if (!instance->max_input_data_size)
 			continue;
 
-		freq += instance->power.min_freq;
+		if (instance->core_id == IRIS_VCODEC0)
+			vcodec0_freq += instance->power.min_freq;
+		else if (instance->core_id == IRIS_VCODEC1)
+			vcodec1_freq += instance->power.min_freq;
 	}
 
-	core->power.clk_freq = freq;
-	ret = iris_opp_set_rate(core->dev, freq);
+	core->power.clk_freq = vcodec0_freq > vcodec1_freq ? vcodec0_freq : vcodec1_freq;
+	ret = iris_opp_set_rate(core->dev, core->power.clk_freq);
 	mutex_unlock(&core->lock);
 
 	return ret;
diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
index cfc5b576ec56..1be4cfd7d9af 100644
--- a/drivers/media/platform/qcom/iris/iris_utils.c
+++ b/drivers/media/platform/qcom/iris/iris_utils.c
@@ -90,40 +90,87 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
 	return NULL;
 }
 
-int iris_check_core_mbpf(struct iris_inst *inst)
+static u32 iris_get_mbps(struct iris_inst *inst)
 {
-	struct iris_core *core = inst->core;
-	struct iris_inst *instance;
-	u32 total_mbpf = 0;
+	u32 fps = max(inst->frame_rate, inst->operating_rate);
+
+	return iris_get_mbpf(inst) * fps;
+}
+
+static void iris_get_core_load(struct iris_core *core, u32 *core_load, u32 *core_session, bool mbpf)
+{
+	bool dual_core = core->iris_platform_data->dual_core;
+	struct iris_inst *inst;
+	u32 load;
+
+	core_load[0] = 0;
+	core_load[1] = 0;
+	core_session[0] = 0;
+	core_session[1] = 0;
 
 	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list)
-		total_mbpf += iris_get_mbpf(instance);
+	list_for_each_entry(inst, &core->instances, list) {
+		if (mbpf)
+			load = iris_get_mbpf(inst);
+		else
+			load = iris_get_mbps(inst);
+
+		if (inst->core_id == IRIS_VCODEC0) {
+			core_load[0] += load;
+			core_session[0]++;
+		} else if (dual_core && inst->core_id == IRIS_VCODEC1) {
+			core_load[1] += load;
+			core_session[1]++;
+		}
+	}
 	mutex_unlock(&core->lock);
+}
+
+static int iris_select_core_id(struct iris_inst *inst, u32 *core_load, u32 *core_session,
+			       u32 max_load, u32 new_load)
+{
+	u32 max_session = inst->core->iris_platform_data->max_session_count;
+	bool dual_core = inst->core->iris_platform_data->dual_core;
+	u32 core_index;
+
+	core_index = (core_load[0] > core_load[1] && dual_core) ? 1 : 0;
+
+	if (core_session[core_index] >= max_session)
+		core_index = core_index == 0 && dual_core ? 1 : 0;
 
-	if (total_mbpf > core->iris_platform_data->max_core_mbpf)
+	if (core_session[core_index] >= max_session)
+		return -ENOMEM;
+
+	if (core_load[core_index] + new_load <= max_load)
+		inst->core_id = core_index == 0 ? IRIS_VCODEC0 : IRIS_VCODEC1;
+	else
 		return -ENOMEM;
 
 	return 0;
 }
 
-int iris_check_core_mbps(struct iris_inst *inst)
+int iris_check_core_mbpf(struct iris_inst *inst)
 {
-	struct iris_core *core = inst->core;
-	struct iris_inst *instance;
-	u32 total_mbps = 0, fps = 0;
+	u32 max_core_mbpf = inst->core->iris_platform_data->max_core_mbpf;
+	u32 core_mbpf[2], core_session[2], new_mbpf;
 
-	mutex_lock(&core->lock);
-	list_for_each_entry(instance, &core->instances, list) {
-		fps = max(instance->frame_rate, instance->operating_rate);
-		total_mbps += iris_get_mbpf(instance) * fps;
-	}
-	mutex_unlock(&core->lock);
+	inst->core_id = 0;
+	iris_get_core_load(inst->core, core_mbpf, core_session, true);
+	new_mbpf = iris_get_mbpf(inst);
 
-	if (total_mbps > core->iris_platform_data->max_core_mbps)
-		return -ENOMEM;
+	return iris_select_core_id(inst, core_mbpf, core_session, max_core_mbpf, new_mbpf);
+}
 
-	return 0;
+int iris_check_core_mbps(struct iris_inst *inst)
+{
+	u32 max_core_mbps = inst->core->iris_platform_data->max_core_mbps;
+	u32 core_mbps[2] = {0, 0}, core_session[2], new_mbps;
+
+	inst->core_id = 0;
+	iris_get_core_load(inst->core, core_mbps, core_session, false);
+	new_mbps = iris_get_mbps(inst);
+
+	return iris_select_core_id(inst, core_mbps, core_session, max_core_mbps, new_mbps);
 }
 
 bool is_rotation_90_or_270(struct iris_inst *inst)
diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
index bf0b8400996e..5a05f7d65501 100644
--- a/drivers/media/platform/qcom/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/iris/iris_vb2.c
@@ -176,6 +176,10 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto error;
 
+	ret = iris_set_core_id(inst);
+	if (ret)
+		goto error;
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
 		if (inst->domain == DECODER)
 			ret = iris_vdec_streamon_input(inst);
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index bd38d84c9cc7..eb167cede4c0 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -41,16 +41,20 @@ static void iris_v4l2_fh_deinit(struct iris_inst *inst, struct file *filp)
 
 static void iris_add_session(struct iris_inst *inst)
 {
+	u32 max_session_count = inst->core->iris_platform_data->max_session_count;
 	struct iris_core *core = inst->core;
 	struct iris_inst *iter;
 	u32 count = 0;
 
+	if (inst->core->iris_platform_data->dual_core)
+		max_session_count *= 2;
+
 	mutex_lock(&core->lock);
 
 	list_for_each_entry(iter, &core->instances, list)
 		count++;
 
-	if (count < core->iris_platform_data->max_session_count)
+	if (count < max_session_count)
 		list_add_tail(&inst->list, &core->instances);
 
 	mutex_unlock(&core->lock);

-- 
2.34.1

