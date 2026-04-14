Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA97AF9D0DA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAAC10E63C;
	Tue, 14 Apr 2026 17:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TegUvhl1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWOyTXSl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6000B10E63C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:32:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EC7Apb280857
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tDoElzImC55GhbsOnTnYubuG5j8YWefLUiY
 xQ7/dKxc=; b=TegUvhl17fE7uyfmoVq2ExAQn6ImTXFyAhFcfv6HJPiuC7HFvSp
 MbkKBrPwPeA97wikC1acn6tKTJD7Vm6ienEJN9Ce9G3fJp5UjnQG4IHjrghb/b/h
 cGAuTkI5N9z2vp/p0Xkb1+FP1ecKMhLD1kN/1JW8z79NagwrJ9j/5UVoIYB3Bdr3
 +V5W7rBDICvdtt/F6RkqvAL9RB7RdhMdeMb+7kLrHRTX0wYQb64eYl9z7ev4zzAn
 Cr1S6RpOzYmvdLtAm+tsJIcEcodGohEA4dyN6rdLeBFdRX2UlteTHog07yXNrbxo
 lYW7T99tWgP1PUE1IImiJ3aV1S7YkSjIeZA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vkufe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:32:52 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56f52dcdc90so2133569e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776187972; x=1776792772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tDoElzImC55GhbsOnTnYubuG5j8YWefLUiYxQ7/dKxc=;
 b=LWOyTXSlVA6KiWu98f8mK8H2VS9YhS6yVoDIcgYCzDtfv+1RmoIneDGh6Io9SAWZtY
 DM6FkXN265dC3MBPimUM/OvFyemf6ODW2dBt4IhwK2h4O1n7bnNPgTNbjfa9HE6vfild
 SubxJD5U5DzfGNzXMXG0P9aqnmz31BVa0Hp3pihdPpxxFxZbXqPLRCDtNokh3LOXtzeA
 IEurGi6xh0cJQAt/idM4V3M+YF+dwuM24R2no7jAmV7P+HY4zSjgFN2dfhyrXYRUThyy
 S+673maI8DKqWthmLWAe+LGNF8JE1NK7Nj7CBeJIbCH43B/jGczoYvRoWtwMHqetvJbd
 /6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776187972; x=1776792772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDoElzImC55GhbsOnTnYubuG5j8YWefLUiYxQ7/dKxc=;
 b=rtQZGaawUgGaW5jnwlSEVMM0W4jTEx6wM9Ke2sMSekZkAS+mo46wX3ArQS0sxIbpBk
 S1mtSJAnvCtIfYeXsIaXvwS2PRb7F5bMNUOGRb+eGw1weOThpZANgFlGm7vzLHiSAQJo
 y8PH/XCSDgbbB6YXs8GwCbftOHxN5V4lmR3s7aC96EC08TRT3p+Mm00fx5fo1+Uj36GT
 1IhcaGvGm0BSRLF9dOXziaNLQSCHkbDhkWDLRxDehFLmVlVmqJ0dBQVHUj49C6s7XY1q
 4UPvqz5C6TFdkFmYPuMCvLPz6oA3e+u+5XecxEL1I7JiALZkko13my9/VOKi4KHiynvL
 wgOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85VXaZZy5fcqsEP1gfenCcfkKpUPLES0QDHcFOspA6eQJkAjmDxLajDcCQDyAmur6C2Xv+qpqlw7Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKID4vWOAJsXK79Ehugi7fwbWQeqJTlGNbR/LX0QL8D9L+rgVK
 ozW6v5uEp0wazy6HlJ3Zw3NgFSs/Xec0imRnAybpd8b1WcXk57C84Y3uwWFk7zIzK9K3+w8k+Uc
 oykKUaaQzuosGkg1SP4eqTtTlRvc5VVfchnTJu0+7zX0r/b5DhEjbar2idTUkQmp7zryqhAM=
X-Gm-Gg: AeBDiesp06PpokWwAHfQILTJI87QGpSOebAhy0TE8fykP4dJ966ZXGsc0yYoJTcCye2
 6aljJandO5mZghE2E3zvXF/qCee9m9YSuqphCzs+uUwE7n+JxUo0okX8iAqkvFzKXz1wAnatc7X
 3fWh0kjC9orKPxTimiFbN7rmZy5/7AD56J0Fo/JYtGSeup+0PQPTYzotqRwZpY915sdkuydQSla
 Odbqw+XPzlkQSHCLiuHGFGR9enh2ndJ7EHh7TSBOVSbT3HuEbXp536zKHrHbJmBDlC4I7joY4Zr
 +EYz3m+gmDLNpqRoPFP4OippimX3Z2OioJBt1BxgMBFhVRfpK/MVLEPX1jBstZYUNGlSTBIppis
 NSZtJvc5RtKu34fS27ikvlThLUjlQOknwbw0sDqODXOJdaoOjxFHJPFy+IQ/bAA==
X-Received: by 2002:a05:6123:52:b0:56b:7484:39b with SMTP id
 71dfb90a1353d-56f3bb67233mr8324035e0c.4.1776187971633; 
 Tue, 14 Apr 2026 10:32:51 -0700 (PDT)
X-Received: by 2002:a05:6123:52:b0:56b:7484:39b with SMTP id
 71dfb90a1353d-56f3bb67233mr8324021e0c.4.1776187971187; 
 Tue, 14 Apr 2026 10:32:51 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6718f52c111sm1289110a12.18.2026.04.14.10.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:32:50 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Ruikai Peng <ruikai@pwno.io>
Subject: [PATCH] accel/qaic: Address potential out-of-bounds read in
 resp_worker()
Date: Tue, 14 Apr 2026 19:32:49 +0200
Message-ID: <20260414173249.3672053-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: icECw1kjSUFUZmqDxvj5osq5fmTEM6X4
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69de7a44 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=BcBWGRYXcgCxByWW27IA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: icECw1kjSUFUZmqDxvj5osq5fmTEM6X4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2NCBTYWx0ZWRfX8yQJMSvG7bqd
 E2cs92LUsr7JVxDuUR30/vyQjsg3r9122fvXOwAktw0beQlz+DuU41LGZwPm/GzedNbxqgvi+tj
 F/6ppcxusTPS5LWZfdDneQ1hpQ1TilA3oko6vjp5hAPD+tJrd3Job3J0+YE6OtjTSRVTuoI3QZO
 ZzCVTQ//dTy89lg6MYju9t4/mvEKwodkjk82efM6GvbK77pNPURqRgvwLZUzFIdNHH99CIhckum
 /0HulHUa7wLdbgLhUku6S2f8NzQkFn84exL8D2FpGSK6I+QOq4p6Gd4JD4ylS+RqXMJU7vOkdsu
 aQXWUqL5mVkY97QldCv2sZ4TbEA4ah9+A70ICZkO07h0MegTcsVe7iPwZC8BG8DY7AwgS1Tnz5j
 rP/2bsEK+Mr+l5ha2fNEfkxeJjEekcVnTOE5p1WD+1SZxlUbSJoIrE6TKp6WncVSWJK5HElNRdl
 Bz0RIbAKBukaGe9n7oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140164
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

Although 'commit 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the
owner went away")' fixes the scenario it was intended for by walking the
message and only decoding QAIC_TRANS_DEACTIVATE_FROM_DEV, if present, it
skipped over the bounds checking code that is included in decode_message().
This could lead to issues such as reading past the slab allocation's end,
infinite loops or kernel panics. For those issues to happen, a malformed
wire message is needed to be sent from the device.

Instead of duplicating the bounds checking code already present in
decode_message(), use the function inside resp_worker().

Reported-by: Ruikai Peng <ruikai@pwno.io>
Fixes: 2feec5ae5df7 ("accel/qaic: Handle DBC deactivation if the owner went away")
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_control.c | 48 ++++++++++++++++---------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index b21e6b5b3a10..818a77adde2a 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -1075,11 +1075,13 @@ static int decode_status(struct qaic_device *qdev, void *trans, struct manage_ms
 
 static int decode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 			  struct wire_msg *msg, struct ioctl_resources *resources,
-			  struct qaic_user *usr)
+			  struct qaic_user *usr, bool orphaned_deactivate)
 {
+	u32 msg_hdr_count = le32_to_cpu(msg->hdr.count);
 	u32 msg_hdr_len = le32_to_cpu(msg->hdr.len);
 	struct wire_trans_hdr *trans_hdr;
 	u32 msg_len = 0;
+	int trans_type;
 	int ret;
 	int i;
 
@@ -1089,13 +1091,15 @@ static int decode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 		return -EINVAL;
 	}
 
-	user_msg->len = 0;
-	user_msg->count = le32_to_cpu(msg->hdr.count);
+	if (user_msg) {
+		user_msg->len = 0;
+		user_msg->count = msg_hdr_count;
+	}
 
 	trace_qaic_manage_dbg(qdev->qddev, "Number of transaction to decode is %llu.",
-			      user_msg->count);
+			      msg_hdr_count);
 
-	for (i = 0; i < user_msg->count; ++i) {
+	for (i = 0; i < msg_hdr_count; ++i) {
 		u32 hdr_len;
 
 		if (msg_len > msg_hdr_len - sizeof(*trans_hdr))
@@ -1110,7 +1114,20 @@ static int decode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 		trace_qaic_manage_dbg(qdev->qddev, "Decoding transaction %llu.",
 				      le32_to_cpu(trans_hdr->type));
 
-		switch (le32_to_cpu(trans_hdr->type)) {
+		trans_type = le32_to_cpu(trans_hdr->type);
+		/*
+		 * orphaned_deactivate is the case where a deactivate response
+		 * is received from the device after the user owning the DBC,
+		 * and the message requesting deactivation, has gone away.
+		 * In this case, only process QAIC_TRANS_DEACTIVATE_FROM_DEV
+		 * transaction and skip the others.
+		 */
+		if (orphaned_deactivate && trans_type != QAIC_TRANS_DEACTIVATE_FROM_DEV) {
+			msg_len += hdr_len;
+			continue;
+		}
+
+		switch (trans_type) {
 		case QAIC_TRANS_PASSTHROUGH_FROM_DEV:
 			ret = decode_passthrough(qdev, trans_hdr, user_msg, &msg_len);
 			break;
@@ -1430,7 +1447,7 @@ static int qaic_manage(struct qaic_device *qdev, struct qaic_user *usr, struct m
 		goto dma_cont_failed;
 	}
 
-	ret = decode_message(qdev, user_msg, rsp, &resources, usr);
+	ret = decode_message(qdev, user_msg, rsp, &resources, usr, false);
 
 dma_cont_failed:
 	free_dbc_buf(qdev, &resources);
@@ -1607,22 +1624,7 @@ static void resp_worker(struct work_struct *work)
 		 * response to the QAIC_TRANS_TERMINATE_TO_DEV transaction,
 		 * otherwise, the user can issue an soc_reset to the device.
 		 */
-		u32 msg_count = le32_to_cpu(msg->hdr.count);
-		u32 msg_len = le32_to_cpu(msg->hdr.len);
-		u32 len = 0;
-		int j;
-
-		for (j = 0; j < msg_count && len < msg_len; ++j) {
-			struct wire_trans_hdr *trans_hdr;
-
-			trans_hdr = (struct wire_trans_hdr *)(msg->data + len);
-			if (le32_to_cpu(trans_hdr->type) == QAIC_TRANS_DEACTIVATE_FROM_DEV) {
-				if (decode_deactivate(qdev, trans_hdr, &len, NULL))
-					len += le32_to_cpu(trans_hdr->len);
-			} else {
-				len += le32_to_cpu(trans_hdr->len);
-			}
-		}
+		decode_message(qdev, NULL, msg, NULL, NULL, true);
 		/* request must have timed out, drop packet */
 		trace_qaic_manage(NULL, "Packet dropped.", -ETIME);
 		kfree(msg);
-- 
2.43.0

