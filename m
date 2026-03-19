Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553521075262
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AB510E865;
	Thu, 19 Mar 2026 06:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Whn166aW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SP1weg93";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07BF210E865
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5XIQQ3573640
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iImuO6SGxaLTCiAHgKuG3rSRhW0OgS17DvZFF+54V/Y=; b=Whn166aWF+XL6yG7
 FGBOscb6eQy7j9Si80EhSoVjfzaM0FEkgX2cWAxkFlVNumEzhyPzOM9CmzWdG1qA
 MZQQI3LX3k7bg9IChdDCQsLasLxF2SAcluNgscqujtiG4IxilP9rK0D11/49d8DL
 ty21gWcNCSyy+9ULXhqcCZKLtXUj22qbjv+ag9nO1PJOjF/notp8RB1I6Jr9FqO6
 cvRjn7Ex3O4eiegBLvHEkL4HhMZ6bxxYMIuZi6XeL7dvhczmWEwLGX5SWZHZw/Px
 uthjzhpknujr7XrPFNiCdVRPrBSlIMs7ySDYLOtD2q3kpdEYSwPE2dzw+XFhxCGR
 DvBxRw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d083r8ndr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0554888cfso10560585ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901925; x=1774506725;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iImuO6SGxaLTCiAHgKuG3rSRhW0OgS17DvZFF+54V/Y=;
 b=SP1weg93FM8Iw28EzMnAy6Wefpq+8UWPopEhANi1u7MGzVA+ISs1ZM5lZDzLMPQnQw
 Y1/ppZnf6fIy7632XZErO8aVUFlyiNgATRppfdUqk3RaRfUrcotk3tlvQ8PCSsObPHcl
 7iKR3FptX8bwhdfPbQik+xivWvY3m7pJhNALjo0VEaB1eAzhA1qFvgZ+K1s/Wht3Cxjf
 ZPLYViqXSeCi/3jKcQwDNWIoXxn6VyNmwjd5cxc5/oH6kCKWzpwHTU4NY69++NVnzuII
 KdaVTMbEbN1390Vf/IjGRoVF7UUfoMQx8EjYSdmwXM9JoKao7dYgHFk8nyNHaJsCskNd
 w9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901925; x=1774506725;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iImuO6SGxaLTCiAHgKuG3rSRhW0OgS17DvZFF+54V/Y=;
 b=rzSxuLhn6NtGBdvut85R0yjfWIy3gNhfY2+Zy19nU/CbuVOt+qp8mI4fFxwbTpi7c3
 DYsFWYTtMFqzbphICsgN5cDjuZNACfG+Sok2DLApTDFrWHt5zpC/vY6pvAf0cAvhOohB
 uMhdkm8TRIFmBZAvzPUN7IR/c9+zirjW9yJYZjvv2sxz7zv8+OaWCIUrS7nDuMs0RuVr
 H2Z5VJyaJTAIqN/DrOlV6XNhEeSmHHGcF+gfCPITzmD522tp4yjTHsx42xQZuImN/XlG
 jEQCEDbL+O8QVV6lBevZu2h6jw6ViShoKGykijlE6GXPVPUWKRFn4UBlQTfpTmEV2Y25
 aDDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkkOSc5nuOzat4gIiGwqh8zj6AuA6ZgvwKrE5Z8mryrSDJ80OHHocsEPN0y4jdkEviAuQev/TPlzY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgEKF261mg4JX/TqvNduzdK/LfGq/Oc3EHEZA5brsB4a2Va8QS
 r/gF6CfOkfe1ApUr8Q4rfXLZ1ErBZPixiiUUhXGKCb0GLQmuMwQTPO2+teueiQhyILKqzVrbJ5s
 G5vYCHO526YinfpPhCLfl/wII91A9Eo8TiLOnxWX9NdlqtDR/L7eJ9AVLgu1OVOQbq/XPhXo=
X-Gm-Gg: ATEYQzwFfTdX32SA6/onsKI9cMsWZsgUlGtcxjt6frDAz8PmY1NfQvuY5U5PHDFzCPc
 WbCcDFm5Zdda6RpUSPYjftATpK2JLLPLBmlG2yJ1tW3ODECv2ovsSoXKaU53VBYoQXWxWOX4jt/
 +8esnhPbLNlCnwLRy0LFt3b77K6g6F76lt9KFAN7HRTrUFoGiPa7rBGhr2G4ZoKUYaoiV/aIQgF
 Rczpj2Bbmwkmnn0ygbHVP+ryQ75hGg+H8EzidnFREFdy4bJ4XcVpU7GqPOBBjxg9frb5qwml5Ox
 Srcud5tE8f5rFIG2yI0xiAEG9pkZOLgycBNrxKqFfdxEUtCPaVwrtg6rBB6pWIo7SuYn1fqKOLC
 64YJO6Z//V1ZkAk38hZTT7cYWLYFFPqEVT39saHmxNMCy8Y1+ujg=
X-Received: by 2002:a17:902:f547:b0:2b0:7177:d5e5 with SMTP id
 d9443c01a7336-2b07177dc04mr45425195ad.43.1773901924715; 
 Wed, 18 Mar 2026 23:32:04 -0700 (PDT)
X-Received: by 2002:a17:902:f547:b0:2b0:7177:d5e5 with SMTP id
 d9443c01a7336-2b07177dc04mr45425075ad.43.1773901924217; 
 Wed, 18 Mar 2026 23:32:04 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:32:03 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:44 +0530
Subject: [PATCH v4 4/9] bus: mhi: Centralize firmware image table selection
 at probe time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-4-47ad79308762@oss.qualcomm.com>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=3898;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=D9kJlDoQ6LGAQMXZQh6rystru1KGUPI8NHA/TRw7+VQ=;
 b=vr6s4lpUaWr2T9TkXlD+KdE+YQxiqHW3dkYcMsoUITH9JLmrkM1V1VinIAHZ1bzHa8OPBMlFX
 aLXDFnx7Qz7DIK4WvzLkJn0afD+UwqZPiaiR3bpdRalFoHWK91wWibP
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: qZBxnbCtN7_1hEBN0AwMKkz8NeGNKf2o
X-Proofpoint-ORIG-GUID: qZBxnbCtN7_1hEBN0AwMKkz8NeGNKf2o
X-Authority-Analysis: v=2.4 cv=ApTjHe9P c=1 sm=1 tr=0 ts=69bb9865 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hNMuCp7LqqrRSepR2eAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfX+iOAZiweKlXt
 LllyEdJECTz6ydJIUV7rSSMg3hJKNEbU6tySBrWufOcfB4U2gDVCqsTurv0FLdTld3187axVQk2
 wrlnFeuRwsqG9yL4TNz6hyws4nTevdPYvXSp3UZ3TiG9ECOYlsrvDHh106axRSBNNtirliomhEW
 BrgDaUak7YSyYxeqBvXaLpS+tAddiDVbIHpAaYuUVEBQTfC5MizP8T/B70xzW5eYUgEIdNNUOdh
 HSBVJKbfG3kSm6nAw1FFAHraTZgDZ43TAjitdQEKp1nWE5VkIL4+gJYU6FWUt0bTrrRddCuDX2F
 eP8nRgFXL9GPNMTHMJq8JX3jDOPopozy5RvdChol9/VG2LKfjeCb1GjFLv5Q1CPLznd7YSVi8p8
 TTDDYynsafRJ6cIURDmOS5kgFv6g3Zw0X2/Ak2m64UQpA3vXY8SxlyWPRKr1PXaxYKJRWLmF043
 0/32/5fUakcuNsFaagQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190049
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

The Sahara driver currently selects firmware image tables using
scattered, device specific conditionals in the probe path, making the
logic harder to  follow and extend.

Refactor firmware image table selection into a single, explicit probe-time
mechanism by introducing a variant table that captures device matching,
firmware image tables, firmware folder names, and streaming behavior in
one place.

This centralizes device specific decisions, simplifies the probe logic,
and avoids ad-hoc conditionals while preserving the existing behavior for
all supported AIC devices.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/sahara/sahara.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
index e3499977e7c6b53bc624a8eb00d0636f2ea63307..8f1c0d72066c0cf80c09d78bfc51df2e482133b9 100644
--- a/drivers/bus/mhi/sahara/sahara.c
+++ b/drivers/bus/mhi/sahara/sahara.c
@@ -180,6 +180,16 @@ struct sahara_context {
 	u32				read_data_length;
 	bool				is_mem_dump_mode;
 	bool				non_streaming;
+	const char			*fw_folder;
+};
+
+struct sahara_variant {
+	const char *match;
+	bool match_is_chan;
+	const char * const *image_table;
+	size_t table_size;
+	const char *fw_folder;
+	bool non_streaming;
 };
 
 static const char * const aic100_image_table[] = {
@@ -224,11 +234,50 @@ static const char * const aic200_image_table[] = {
 	[78] = "qcom/aic200/pvs.bin",
 };
 
+static const struct sahara_variant sahara_variants[] = {
+	{
+		.match = "AIC100",
+		.match_is_chan = false,
+		.image_table = aic100_image_table,
+		.table_size = ARRAY_SIZE(aic100_image_table),
+		.fw_folder = "aic100",
+		.non_streaming = true,
+	},
+	{
+		.match = "AIC200",
+		.match_is_chan = false,
+		.image_table = aic200_image_table,
+		.table_size = ARRAY_SIZE(aic200_image_table),
+		.fw_folder = "aic200",
+		.non_streaming = false,
+	}
+};
+
 static bool is_streaming(struct sahara_context *context)
 {
 	return !context->non_streaming;
 }
 
+static const struct sahara_variant *sahara_select_variant(struct mhi_device *mhi_dev,
+							  const struct mhi_device_id *id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sahara_variants); i++) {
+		const struct sahara_variant *v = &sahara_variants[i];
+
+		if (v->match_is_chan) {
+			if (id && id->chan && !strcmp(id->chan, v->match))
+				return v;
+		} else {
+			if (mhi_dev->mhi_cntrl && mhi_dev->mhi_cntrl->name &&
+			    !strcmp(mhi_dev->mhi_cntrl->name, v->match))
+				return v;
+		}
+	}
+	return NULL;
+}
+
 static int sahara_find_image(struct sahara_context *context, u32 image_id)
 {
 	int ret;
@@ -797,6 +846,7 @@ static void sahara_read_data_processing(struct work_struct *work)
 
 static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_id *id)
 {
+	const struct sahara_variant *variant;
 	struct sahara_context *context;
 	int ret;
 	int i;
@@ -809,14 +859,14 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 	if (!context->rx)
 		return -ENOMEM;
 
-	if (!strcmp(mhi_dev->mhi_cntrl->name, "AIC200")) {
-		context->image_table = aic200_image_table;
-		context->table_size = ARRAY_SIZE(aic200_image_table);
-	} else {
-		context->image_table = aic100_image_table;
-		context->table_size = ARRAY_SIZE(aic100_image_table);
-		context->non_streaming = true;
-	}
+	variant = sahara_select_variant(mhi_dev, id);
+	if (!variant)
+		return -ENODEV;
+
+	context->image_table = variant->image_table;
+	context->table_size = variant->table_size;
+	context->non_streaming = variant->non_streaming;
+	context->fw_folder = variant->fw_folder;
 
 	/*
 	 * There are two firmware implementations for READ_DATA handling.

-- 
2.34.1

