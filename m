Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2909F1075261
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3FB10E870;
	Thu, 19 Mar 2026 06:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsLNHs4E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4Tt9rXy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7121610E868
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:23 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5XfpQ573909
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iiXrCv65t5Cfe7JS9CAoM+yCgarvykPh0XYvrPKdD3o=; b=YsLNHs4ESlAlVBun
 SQlyjD5zscJyYzZ7SvkeNmzOkYaKxSikbLg1ELzJJZTBiU+CnRu0Dx9bOa+N2KnG
 nCil+AlRj/yvaGwbkgjj6glQdR3T1c4k462uSVSibHHPGdCdcfmabwlZDOOYxMO7
 39pj0Y8ztpK4W/badPXfvDZxs2VxverZt2Mw4BmjpoztOT4e0GyUK+bsQl5QwmtM
 KwDA+Yl6es15EM1RIIkpRVffWm+vHCLZS6HzUpx/Er8VHY5Toq/KgqDVsnl+ZYDo
 G9fVCXHqEVcK7L+RjRr/lD9sG72Ov3sMYc4KH9xPW6m068gobAecuggJq98q07TV
 Whm45w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00ega2j8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ae3badc00dso6696565ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901942; x=1774506742;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iiXrCv65t5Cfe7JS9CAoM+yCgarvykPh0XYvrPKdD3o=;
 b=P4Tt9rXyuT1KqTLXAy/E4SgtzFT4gPuMm6LvKMXZLCmBco6xgLiISgd4qlIl6n5tAz
 esAvaLesBcUUhkZ0htlxBS7DurpQebwzwWOfcIbZoF52hHQDdpyRc36lKQ47L31NShon
 dcNJ2hYBt9+i3exxN9QEDt1nLHQi6PeiOKmuoq7ezP3DCtyT0rJUI5DCrkIS0AEu2kY6
 vWE1EujtAv8JoJrNOqjElafDTZfxlAlmgpR1qhiSfO56kh8RYj7qsMBfvd9A1K6VJ7xx
 0wjQQfRy3oZod566DE1E8HZ3MQQvJJ3yZtFBrPw553341xM55YgRG7hq90kPBxFjZkXz
 WmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901942; x=1774506742;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iiXrCv65t5Cfe7JS9CAoM+yCgarvykPh0XYvrPKdD3o=;
 b=pe47kQxAF7I+eoP9EDplqgg3bIETEDvSwsB31PCjyPqdcFcfrd2UYhAJUkLELGMOEM
 NJE2AlYQ/mu4AhgeG1ga2K4wBJdVUZm4coiAEurJ2wL4MGmcYccwzQ7TNUzx8KkaXcIT
 9kYVVPpxHIddLs/mqd3YOA5Q1igVRjoL3eM4SFUybrfisQ2X8lSLaTg6/EDRqSnANvzF
 Tatvm0/jPmuQiHd6KcKtZ074y47jEJLnlqhqUT0pCtgu4op7lFLdKyeOkEbykhsRQATf
 Pr2zOvp0Go6BrcGJhDy1cuES/kD3Vgi54ZyeMfNUi8vId54M8+yF9Wp/9VvBKYx3VSSW
 cxNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkz4M2TxiE3ZsTx40yTRivvXM4tMPhVzhtzHe/5+dRjmPfPrf4HdDJrIVHaHzQhfTRGtMBX8e+HwU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFcdtII+8pQL++pKSdykIMlZ+sFv4al/DbPBj0qo6IUd45XD7L
 jTM4l+jLksf1xlTfnb6DERZzkq7ccBIwsmk/pRnN7Zs0EQE0Cbf0esyAt14sVfPxzpJi1uAnnMX
 5oF134ZMSOLzsr1m5/EV9zpmtnRrT1kjqi0fYMrsHevkVB8ld+954QNR2EMGkv2MzCutY5vo=
X-Gm-Gg: ATEYQzyslJCg3JWT6ifnToUmCuT4qDvvwCoLpj9yBWknUGey5UaGPeNuyxBC03Uj0jG
 LkLgd0jF+4RnBUvJdqP4wiIMpqyhlp+RXYhsCEOzyllbccidx66LZ+Dj7gSoiYPzZhlCtP1awGt
 xZdh3O4QMxZPxA2EkxusgwRPc4Iu9/neUSE/zNnA5iFMWjI217WY3H+kKO4FZdy3ssjyGQS0AEF
 GktZSix5wzkGEGbtlwl2Njv+3Vhz6fDNWx9MvRRtdPuSrk9c/+0rdDWg4j+yabicia3vriSzTuU
 5d33e/0U/p93h2xNOXgnO/0kK4/rwHvPtiPd8M0/h5pSbC9gUKD1rRK1FyilC4RbvMXKU5RacEM
 gTuzBRj6E4XHE+axKtmjcYeM0arHkmYh44l4Q/t9m6xohXv3xutU=
X-Received: by 2002:a17:903:1a67:b0:2b0:5a4c:726a with SMTP id
 d9443c01a7336-2b06e41afc9mr57940055ad.43.1773901942230; 
 Wed, 18 Mar 2026 23:32:22 -0700 (PDT)
X-Received: by 2002:a17:903:1a67:b0:2b0:5a4c:726a with SMTP id
 d9443c01a7336-2b06e41afc9mr57939835ad.43.1773901941736; 
 Wed, 18 Mar 2026 23:32:21 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:32:21 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:48 +0530
Subject: [PATCH v4 8/9] bus: mhi: Expose DDR training data via controller sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-8-47ad79308762@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=3311;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=zLHdxvYlh3SgJM3zwdFzuQdChe4Q/8MyqXYe5cHG93o=;
 b=E912BIRgk2tIUK4/M4i8++DPEcAM8x+0kS4yuwICPrM81yr9VdRFAzP87se9p2qP1rqiZUxb4
 9ZzAK2xR+g5DkO5ycJfNGU8vhWZhLd/M+V0j9MwRw2DwL6pPFoJCvz0
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Authority-Analysis: v=2.4 cv=MMNtWcZl c=1 sm=1 tr=0 ts=69bb9876 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=9mPLix8uEUeM4unapbcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: eUUVa8LBSMm0pxA_qOma3dwou4nw5CD2
X-Proofpoint-GUID: eUUVa8LBSMm0pxA_qOma3dwou4nw5CD2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfXyUC/CAUI97SS
 UxnVqRx8jP5b10ZyzrZLnUkAgKZEZpcrOkl73B4E0LfIJZwtpMXQk/lpyjv8a/tl0TWjyy6QPky
 JcftvWKs98rOhWYHkqScwGHA47KGF3x0OzVbj4tKWKlmbUCMxOQVWTHj8havoLXJblGk22br8ps
 h/EoFNzZtlup4P00YhMQLJg0MqSh/qjTWY1+s3cQ5bReXBg5t/83K8OU+74ynpQna8JojdZUAU0
 +pcxnDbYYh4P+4kgtVf9AenXBiaJEOBkaR+yMwoljRUJacEsOk34yckNzXk1PA9rNVyVB0hNlzl
 X0abX5JMkAs+rEeqNujlVm7ODOoFikAA1xtw/glK89kPTdnwDxRu7D+WWMeERjm11hJ2Q/Spv4c
 pBiT4wWRmX63HmfmUNsbDD6uqk5sLj4Wp1VZPaXGzlRxNaIVVgsku71xtptST39eL7eHbyah/zU
 4OE9bb7fIRONmkpgMQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
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

DDR training data captured during Sahara command mode needs to be
accessible to userspace so it can be persisted and reused on subsequent
boots. Currently, the training data is stored internally in the driver
but has no external visibility once the sahara channel is torn down.

Expose the captured DDR training data via a read-only binary sysfs
attribute on the MHI controller device. The sysfs file is created under
the controller node, allowing userspace to read the training data even
after the sahara channel device has been removed.

The sysfs attribute reads directly from controller-scoped storage and
relies on device managed resources for cleanup when the controller
device is destroyed. No explicit sysfs removal is required, avoiding
lifetime dependencies on the Sahara channel device.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/sahara/sahara.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
index c88f1220199ac4373d3552167870c19a0d5f23b9..b7208738df10fc3c3895acd46873412818dc1730 100644
--- a/drivers/bus/mhi/sahara/sahara.c
+++ b/drivers/bus/mhi/sahara/sahara.c
@@ -415,6 +415,73 @@ static struct sahara_ctrl_trng_data *sahara_ctrl_trng_get(struct device *dev)
 	return ct;
 }
 
+static ssize_t ddr_training_data_read(struct file *filp, struct kobject *kobj,
+				      const struct bin_attribute *attr, char *buf,
+				      loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sahara_ctrl_trng_data *ct;
+	size_t available;
+
+	ct = sahara_ctrl_trng_get(dev);
+	if (!ct)
+		return -ENODEV;
+
+	mutex_lock(&ct->lock);
+
+	/* No data yet or offset past end */
+	if (!ct->data || offset >= ct->size) {
+		mutex_unlock(&ct->lock);
+		return 0;
+	}
+
+	available = ct->size - offset;
+	count = min(count, available);
+	memcpy(buf, (u8 *)ct->data + offset, count);
+
+	mutex_unlock(&ct->lock);
+
+	return count;
+}
+
+static const struct bin_attribute ddr_training_data_attr = {
+	.attr = {
+		.name = "ddr_training_data",
+		.mode = 0444,
+	},
+	.read = ddr_training_data_read,
+};
+
+static void sahara_sysfs_devres_release(struct device *dev, void *res)
+{
+	device_remove_bin_file(dev, &ddr_training_data_attr);
+}
+
+static void sahara_sysfs_create(struct mhi_device *mhi_dev)
+{
+	struct device *dev = &mhi_dev->mhi_cntrl->mhi_dev->dev;
+	void *cookie;
+	int ret;
+
+	if (devres_find(dev, sahara_sysfs_devres_release, NULL, NULL))
+		return;
+
+	ret = device_create_bin_file(dev, &ddr_training_data_attr);
+	if (ret) {
+		dev_warn(&mhi_dev->dev,
+			 "Failed to create DDR training sysfs node (%d)\n", ret);
+		return;
+	}
+
+	cookie = devres_alloc(sahara_sysfs_devres_release, 1, GFP_KERNEL);
+	if (!cookie) {
+		device_remove_bin_file(dev, &ddr_training_data_attr);
+		return;
+	}
+
+	devres_add(dev, cookie);
+}
+
 static int sahara_find_image(struct sahara_context *context, u32 image_id)
 {
 	char *fw_path;
@@ -1272,6 +1339,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 		return ret;
 	}
 
+	sahara_sysfs_create(mhi_dev);
+
 	return 0;
 }
 

-- 
2.34.1

