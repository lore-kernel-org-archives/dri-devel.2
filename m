Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC54C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E4B210E1B6;
	Fri, 31 Jul 2026 15:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICTXIahp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kpv51tHx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF18B10E1B6
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:23:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VBjdGM4054636
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=hP+UiIP37vVlsHPiW4A3Bz7mZtvCicD82Nj
 BxVHIU5M=; b=ICTXIahpp4ddedo8ffQk6MVWQqi3gNLWCi2XqDbadlH7NDSwmf+
 kg8aYusEFYqzkGoJzgSniI8rDNg8NSKP1qQI+6RISztpKEwDe8T1Np56fzhuP1t8
 /uEsEUTvqj0I5UiTaJQudDn9M5bo+J6k4sV1W9+S7qYNZSTME9PvXDCl7s+7PwZA
 ujZuQ7na5qt3N4mb2exxyzbjd7EiGng+IdDP8v4gc/u/LouaWV2DNZOaIMSucUwi
 ueNtS2DZiRMRsl1sd8mrGWoa7+uSEs+AuGcL/Dwx5NlWAPq4MaFZLDScrTjWUiSZ
 2rSJsujTwgAqoA1pfgxRpZc2/FLoplFVO1g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru480tgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:23:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f39a46efd9so18010536d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785511427; x=1786116227;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hP+UiIP37vVlsHPiW4A3Bz7mZtvCicD82NjBxVHIU5M=;
 b=kpv51tHxdYQLcr5/UmEH+8N/Od52nyV4KKDvh8HBgGD4gcLwNxT5WYdcYv9PVdpT/J
 QUIBkVFmDT62ER0oWGvi5r5ueTesiYYi+7IU/Tm5yCK+d7rSUFo4cF5/dHLiPwEL8lcB
 GlobeY/keKJAbKRJUnYnVpDErQ0DA2y73MskaevzuG/67w4GPOHasPqY00bayzATmiqh
 JeSA7nolH7xmFU1kqsxtGZTNJsmST3eOgOVqBRXDI3rPV/QJxHc6He3JpZHg/RKO+2A2
 Jvh3CAJOjK238aLIuzGB6M+06K4kNvpuNnsjHhErasN0Z1fg2dIcMHVKlbnthCKWYRCg
 BUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511427; x=1786116227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hP+UiIP37vVlsHPiW4A3Bz7mZtvCicD82NjBxVHIU5M=;
 b=TVJlWGZN6TdcyX0fRo8ZigHpjhrIFxOFyy7G6VGCPNWx5IKAAGeC/GQ1e/VUh1bbzF
 vNcRgX+JNNnvj6hb/Fbb3vsEt6VBMAYOxO6tA1GI906GSrhQdwyV7ShRd3o/JvsR5CMD
 MzQhmF3osZKBokKHty3bdnhOohQ8UqUVbGSUPpyyj/H61+VIaIpxnjWnfTW+HkfQZfnT
 myfeK2vLy2VrGorhsywZUr77zEzG/p8U6Re5baw7NwdANvl+YpbV9+a7oCusc+LYkjMw
 6P1swJ7u9xXvbR1kiOVG6mqmX6DsiOyFYP6nd5dQDPbIZKLPJ9j78FQolFCK+ae2NnU6
 7c0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqgm8C6G9lLqSyfSeZLfMU3x9fg6JC+VI8pE7u1Jf3kkCUoEihlf+hVtmZ4/P63KzbHhf2GeWSQeIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEWHuIG6LtXNskbfZbA9aCG6oucl85J0yRfSAheZECOLM9AoYN
 Rb2Zmo089NyFy49WggxUPR/26AsO0THl8HikviM/h/+nhzWUkELeltLEUuQiI28/N8Szz9WXYVj
 KYwVt9/V6bwnZfoxGZeAhUySCljyphU6HtT2YPH9EqgvoUHONNq5qhVk87/flPF/8P0mCsl4=
X-Gm-Gg: AR+sD13W9rXlmZhpnRCynSmmxEnz1qJScN5gyGbBxlCeGBguHwsJDTC01i2Cd4RhDln
 Z3THytS8BxRALDrEvSmrRoxcdO5Q76f3+TgVql15zV0QaqfGoL/0DdhFiyS4rOVm5GoZdZ6wkVx
 rOC8OsMQ1mPxAcNieGaEG5Pue47QKAXNbadZJE5t4vhZS/J2VapPzViVs+3a5y7c6vFGMsOVYmR
 CL4Ovxwspxo7s7mdNQGDNmXCbuddTxeuWJ7+3Jfmzksvp+YRNlgC0NCYQL2/yhnvcYrg5OwjDGn
 SAjvjEL6erAdfHLg7PjHXcXGhUbDRq2nY0jO6qHfzyH0YREA1het3/c4vY/Xi3m8N4HSVwyGfQH
 oEUrUztCrFNJ9vH0TJcJ7XdIj1opnNVDVAM9+D5+H
X-Received: by 2002:a05:622a:181f:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-52b4c573309mr31730501cf.11.1785511427180; 
 Fri, 31 Jul 2026 08:23:47 -0700 (PDT)
X-Received: by 2002:a05:622a:181f:b0:516:7a83:8c37 with SMTP id
 d75a77b69052e-52b4c573309mr31729731cf.11.1785511426638; 
 Fri, 31 Jul 2026 08:23:46 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd44e9f0bsm161730366b.43.2026.07.31.08.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:23:45 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 ruikai@pwno.io, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2] accel/qaic: Address potential out-of-bounds read in
 resp_worker()
Date: Fri, 31 Jul 2026 17:23:44 +0200
Message-ID: <20260731152344.1905882-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IJsyzAvG c=1 sm=1 tr=0 ts=6a6cbe03 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=MDliM5Vup59QY3ksz7UA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX0+eYmHy66oNK
 OMBmceAnnckGn3O7eylUlhTeo8ct8ZE4Ae4USL/jdO97kHOxQoPiAJnuOMhTovPkpc3AHHs0j6P
 ewPbIGRCmvO7IByMnWmyLrfPKjTlAUc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfXznfDwr8O/KcR
 QtFMkJBmvh4ULzMq/H+hsKI9qizQNSVucqccdMDooUWMRa/ZSzbofdq0SuwwPpPSEcR562B5lrq
 Ajp4u7vZ7JVGUJK/hpFY6tYATOVNnc+8p6Ra3Y/fWZvemmFWJcGhUy6kvPZwMOwqywOap5XnfmT
 MPAEOXmF1wEYAXcSM5u45ahnDAjCDuA3naE3oPON03eycY8oDS2/9jkDIdULrKomWyUCNKQggQ8
 JZqpYpRnWC5vb4WK+EC57e1TfljQ51MzY8BlrXLhDS1Ha/qMSVfAJ007vPxc6SMi7+d7VyFVCcp
 5NJ2jG1R0i4jNu3WAXOyEzBVcd4uJt9w9nKhUCZ05XN6tQLSUz1j/sMiQaTTkT9j5fjpmNnIRx7
 LdB3LBsCeNQaagRbk/7GURmxn+kidu8a33Q/x4cx3RkCDE0uSKG9Y1QZmJFxY9JJMuNP5xdRZVo
 BWLqT8S2r5KNVEqEtug==
X-Proofpoint-GUID: W9K6a56GJ2tpF08e1izbCoZoc_jTTHkR
X-Proofpoint-ORIG-GUID: W9K6a56GJ2tpF08e1izbCoZoc_jTTHkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116
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
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
Changes in V2:
- Remove references to tracepoints that are not upstreamed yet, which
  caused merge conflicts
- Link to V1: https://lore.kernel.org/all/20260414173249.3672053-1-youssef.abdulrahman@oss.qualcomm.com
---
 drivers/accel/qaic/qaic_control.c | 46 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index bb94d3556904..ecbafab7187c 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -963,11 +963,13 @@ static int decode_status(struct qaic_device *qdev, void *trans, struct manage_ms
 
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
 
@@ -975,10 +977,12 @@ static int decode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 	    msg_hdr_len > QAIC_MANAGE_MAX_MSG_LENGTH)
 		return -EINVAL;
 
-	user_msg->len = 0;
-	user_msg->count = le32_to_cpu(msg->hdr.count);
+	if (user_msg) {
+		user_msg->len = 0;
+		user_msg->count = msg_hdr_count;
+	}
 
-	for (i = 0; i < user_msg->count; ++i) {
+	for (i = 0; i < msg_hdr_count; ++i) {
 		u32 hdr_len;
 
 		if (msg_len > msg_hdr_len - sizeof(*trans_hdr))
@@ -990,7 +994,20 @@ static int decode_message(struct qaic_device *qdev, struct manage_msg *user_msg,
 		    size_add(msg_len, hdr_len) > msg_hdr_len)
 			return -EINVAL;
 
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
@@ -1281,7 +1298,7 @@ static int qaic_manage(struct qaic_device *qdev, struct qaic_user *usr, struct m
 		goto dma_cont_failed;
 	}
 
-	ret = decode_message(qdev, user_msg, rsp, &resources, usr);
+	ret = decode_message(qdev, user_msg, rsp, &resources, usr, false);
 
 dma_cont_failed:
 	free_dbc_buf(qdev, &resources);
@@ -1446,22 +1463,7 @@ static void resp_worker(struct work_struct *work)
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
 		kfree(msg);
 	}
-- 
2.43.0

