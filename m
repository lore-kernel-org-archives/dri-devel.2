Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52717CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18DA10E653;
	Mon, 12 Oct 2026 18:18:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9773E10E653
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:47 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHugQY2722710
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Kob68wC/vc0CfoybXsR+8YcXmWpEwtZguxE0zOu4xE=; b=EStGBjCodd9FAh4m
 bPsTOibAtmpubqjgoz0cfp5wjfMBuzOGviTM+Rmebo+ODGP7bS7cQqYwyJpX2sLd
 /4bNHmmFB+tlnh87XwuDfjS7t6N9h71ePUsCjqXxrXOfZvoMGTYCtWEd/0VkqpE+
 UJqMYBBvB3yt7Hq5MooLEuqTENBW0MrUob0uvf8lnS2Eid0gbYtonkanr6rJCoBp
 nwDRe2R+4nIwqUO6jb/8Wc5KYZOaUBN32U5JWWQMM0n76WLp6HutqXqsgVtRSmvX
 dFoh24twaI9gYzoAJ106nESWQZmVfDzncpbjCD7cbsRQOmEe6Sx4utpW7A9bPQMa
 Ygk02w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w070h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3592749a017so1800755eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791829126; x=1792433926;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Kob68wC/vc0CfoybXsR+8YcXmWpEwtZguxE0zOu4xE=;
 b=drqBfA2zXLC3JCe1be2pZsl1JjLQwpjD/BNbKiK7OJxrUyxx2As8nxuW9q3EUYwmnh
 2+EgEZIJw/02rH9BaKkfqA+8MyCK4vUo2YF6GE6SzDMnJr/oOwmaU6vyPzVvTJUeSW+b
 WyKlEqZL3iURxBaJyoDIT0BjMHM8tjToiL3NWdGHwrKmHTrwmc6KUuNBjsdTj8sVlhvc
 q4QxjaduDgaAFBtQLeQjtO9SVi6WRLz4yEn2xHvazz0LZmrC1ndwdQdKkB3Xgi+MRCvn
 /XFa5KB3bNikMDa3iOktpc3ooF+onzEPnhnIB6D+xNVTX/bwbNHKh1a/W30Zm7WTR4sx
 nrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791829126; x=1792433926;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Kob68wC/vc0CfoybXsR+8YcXmWpEwtZguxE0zOu4xE=;
 b=ahy7zFCeTzZE7c8MZgnIGu6qWATEbqj8p7pRD90Og6Xd9YBHwD+Y5PIOtnEYqXg++a
 NEzJEf1WCs9uPlKfK38liPtfGXWo8RbhU2AGtlevMKRVcIS4d6kUpOENkc8XRqPbXmrq
 mswmIryBuRqJ5+XPUY1ydZPs7JgsTMwmnlJGKcwTvDpdK+LJVIRFVhNGxEY2IGH1Y0qL
 AFsvi7gxiHwTmis0QOMMfN/9ecWSlg80KOsMiFiuPyyJABkKLNR6zTss6FB6I8emDr5C
 cMCfhAvR3ECQ44O3GJy/JE/kWL29UbX+7LyF20tqemK19Wi96NRaZCOVDw+hGEcQdLPO
 v1LA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW6OxtzhhA2qG9ubGiAg2Rw6v5Dsk9Z8EZDUWa6h5of+bJKe0rqq5ALiCTntqw68wgYsxgYGJw5A0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjA3B/lIAkxNh0zRpE782MjLKvFCHk5Gu8K85z7195NnofYexF
 ntdW47OHFZybXAy737awp+S4NSyq46ZCHFl5NFcb2ZaXKk4KX95klO1TPyrc9X9ZQqyTfP7e05G
 C/j9dmiUNwozKfhOaI9aKWgCCsUtQVc3Hh0AlRSgpqo5mbYZAeM8FtREiOutcYoUm6Qo52uQLsf
 JDGGo=
X-Gm-Gg: AYBFou2dIxQaHwX5zw7CaXHbn+wirh+EBQEQYZrrQyOcQIzHCpuyEH3iccdm/k05hm8
 +ARrD0ul6B8wpumfmfWETuSNDKIR5xoFU3pxFXQAKRHRPHlnX+Dd2AZflHnJO/DP3PWc5tpoaSV
 Px1OVG93I1OfQhJ7thoqSW/mONDk26nz8UVEMNZ2FmUNcGTmZGukaTG25nD7MVu4vyFHxJKbU5r
 stDZa13ivQhNBwmFx3wqhqaAHY5+bzWZ1ShGARofmXmsFDW/ieZfp4BVIMkaAOf+Lz06Gv5mQbY
 db09PP1xxSaJD3ttscvR8VmD/PeA2MumnylewmrIMhxFLBFCHkVkOBs2mOHFjAvQszcv49WDp93
 voknAQ4eg2A1EOkY+h28aQTv09wit
X-Received: by 2002:a05:7300:c87:b0:33e:61ab:8309 with SMTP id
 5a478bee46e88-3537b291a93mr20292611eec.23.1791829125359; 
 Mon, 12 Oct 2026 11:18:45 -0700 (PDT)
X-Received: by 2002:a05:7300:c87:b0:33e:61ab:8309 with SMTP id
 5a478bee46e88-3537b291a93mr20292580eec.23.1791829124783; 
 Mon, 12 Oct 2026 11:18:44 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm22827311eec.31.2026.10.12.11.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:18:44 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:48:05 +0530
Subject: [PATCH v8 7/7] bus: mhi: Expose DDR training data via controller sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-sahara_protocol_new_v2-v8-7-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791829086; l=5269;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=biCTKkk9cWwd98gBnjAIhfURZEagU2QQtk7DUdBFB1g=;
 b=rNpcIcoT6p3dUnSxv/tKEOCWAlWVtheh7cYYCU9K6GOgg6t4DyK90xgIrBJrCYfXNMOEguhvw
 v7VzamcyOC8DU1fJQMMd3Gu4CvV3DyLKOcnfVQ+lfHBL6pJl8tuhOL0
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: dsb5QMOFhW_B3gbWxtByCYv5NeY06p8N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX1xKMfPGLDhCR
 wzoDxjGbbfQq0JU166F8Eu3f6XrXTcCIYOs2re+hSes6x4SIxTKiJ8trhUn+emYQ5zzsF26IYbG
 4wNrmIKjtqzws+lE98nglqJEEU5TkXUz+1xh0hyUeI5dNvv1n9hTPb/1QUOF2gm8sgNEaQGKkNs
 oaQbenMhCOzjJgUnv5vivn7CKUDoJe2NDPx3mpC37fvTYf/VoUIyLEucoEr8N7zV6z8qaFdfDht
 2UypXMzqvgEUA0nnEUEZbouuE9u4LbHtcn6Am/ke2p2uhRN3ELp5675Ii9aup4BT8qdZoWF26xH
 i9Co49dsi2o+key4pdNwvHcWK6FqlV6JgFHxVAlz/Rpn0okWIN4+lgtfHmSCPyRZnrYGfELcC8f
 gqs6abthJkpPTLtSyFP+YpubZkgGZ29yWB/MC2ULvmyYn59BFP1BSSjQUXQcbPehp66PRO5L1Rg
 JBKz/7+P5ngdF8nwB1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX/eFj+1PGTbwf
 fLifJA9ySypunJL6JMny5ZX3aCRjGEfCSieCh1OW2uPCuNDZaI7uL1cwq9PRnKefVZF3Vce5gnO
 BHd9VMlnneVrVW5Hp16cX/CeQxyCXA8=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acd2486 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=NePjL4a1hEawMabAjiMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: dsb5QMOFhW_B3gbWxtByCYv5NeY06p8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120072
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
but has no external visibility once the Sahara channel is torn down.

Expose the captured DDR training data via a read-only binary sysfs
attribute on the MHI controller device:

/sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data

The sysfs read callback serves data directly from controller scoped storage
and protects access with the controller training data lock. The attribute
lifetime is tied to the controller device via devres, allowing the data to
remain readable after Sahara channel teardown and ensuring automatic
cleanup when controller device is removed.

Userspace flow:
1. For each controller device, userspace reads the ddr_training_data sysfs
   attribute.
2. If the read returns non-zero data, userspace persists it using a
   serial specific filename (for example, mdmddr_0x<serial_no>.mbn).
3. On subsequent boots, the Sahara driver attempts to load this serial
   specific DDR training image before falling back to the default
   training image, restoring DDR calibration data and avoiding retraining.

Add ABI documentation for the DDR training data sysfs attribute exposed by
Sahara MHI driver.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 .../ABI/testing/sysfs-bus-mhi-ddr_training_data    | 19 +++++++
 drivers/bus/mhi/host/clients/sahara/sahara.c       | 63 ++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
new file mode 100644
index 0000000000000000000000000000000000000000..810b487b5a5fdba133d81255f9879844e3938a10
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-mhi-ddr_training_data
@@ -0,0 +1,19 @@
+What:                   /sys/bus/mhi/devices/<mhi-cntrl>/ddr_training_data
+
+Date:                   March 2026
+
+Contact:                Kishore Batta <kishore.batta@oss.qualcomm.com>
+
+Description:            Contains the DDR training data for the Qualcomm device
+                        connected. MHI driver populates different controller
+                        nodes for each device. The DDR training data is exposed
+                        to userspace to read and save the training data file to
+                        the filesystem. In the subsequent boot up of the device,
+                        the training data is restored from host to device
+                        optimizing the boot up time of the device.
+
+Usage:                  Example for reading DDR training data:
+                        cat /sys/bus/mhi/devices/mhi0/ddr_training_data
+
+Permissions:            The file permissions are set to 0444 allowing read
+                        access.
diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
index e7a6289b11a72d5dda008d6107eff6b4f9b67519..db6fb966fd93c9fef82e5599b7133299e1a4c337 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -273,6 +273,67 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
 	return ct;
 }
 
+static ssize_t ddr_training_data_read(struct file *filp, struct kobject *kobj,
+				      const struct bin_attribute *attr, char *buf,
+				      loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sahara_cntrl_training_data *ct;
+	size_t available;
+
+	ct = sahara_cntrl_training_get(dev);
+	if (!ct)
+		return -ENODEV;
+
+	mutex_lock(&ct->lock);
+
+	/* No complete data yet or offset past end */
+	if (!ct->data || ct->receiving || ct->copied != ct->size ||
+	    offset >= ct->size) {
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
+static BIN_ATTR_RO(ddr_training_data, 0);
+
+static void sahara_sysfs_devres_release(struct device *dev, void *res)
+{
+	device_remove_bin_file(dev, &bin_attr_ddr_training_data);
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
+	ret = device_create_bin_file(dev, &bin_attr_ddr_training_data);
+	if (ret) {
+		dev_warn(&mhi_dev->dev,
+			 "Failed to create DDR training sysfs node (%d)\n", ret);
+		return;
+	}
+
+	cookie = devres_alloc(sahara_sysfs_devres_release, 1, GFP_KERNEL);
+	if (!cookie) {
+		device_remove_bin_file(dev, &bin_attr_ddr_training_data);
+		return;
+	}
+
+	devres_add(dev, cookie);
+}
+
 static int sahara_find_image(struct sahara_context *context, u32 image_id)
 {
 	char *fw_path;
@@ -1130,6 +1191,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 		return ret;
 	}
 
+	sahara_sysfs_create(mhi_dev);
+
 	return 0;
 }
 

-- 
2.34.1

