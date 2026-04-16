Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4974DF8D74E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C62810E8CD;
	Thu, 16 Apr 2026 14:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqjGIXZd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHtHWopE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4717C10E8CD
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:34 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GDqpIT2596395
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 olONKICAQIN5WecCXZoB05Va0xoXxi3BtToDJt2JvlU=; b=XqjGIXZdw6NKQMIj
 hSdPAXMczheOQYqH98Bq4weVCFDDFn4Zl9dpgUgwEA0k6WsX6U5CdxHcdpikXQ7I
 osU9HlveeflD3qM1vNr9ljKCejtLeubry2wpPTOPiclUymeC3eF06EVlH6SlR4jV
 1Uh5MPrhLPMk0lQIwaNs1LdmIlInNKAYvidiw08ZmneMzSWnRoroYB9Yg7kyLU3D
 0XeKNpgw4tok3ZAlx3r6RONqmRy3Rdn4RycrT99ZTnszi2EZVnOawonyeWfylSV5
 HCyH90Yqe4uIR75M6mt0P2Rk+k9EmjsU7XGSzRifJSks8W0s1UqK5vMDGjGdWEl2
 8ThZ0Q==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk11r824q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:33 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-644548b1dcfso12668872d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776348632; x=1776953432;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=olONKICAQIN5WecCXZoB05Va0xoXxi3BtToDJt2JvlU=;
 b=kHtHWopE7yKDo8SgoPJObKTla99ODf2HIBtgBToL15HQMgCHRKPbV/sKUW7xHdRg63
 dTshqvNvps/79WRBJxV9GsBXJFE3UWmpzFquIymLViX4steHu6cRMBs4jqrN3YYXT0Vn
 w+LJhDTCPWZEA4V2emTZTsMEIH6IGuDtwS5rLaD1/U7B+Vs/WaTLOz9PCYhzf8a5hoC+
 OlMUyBlkKb20yv8i6Mfqa5PFchxUoSYOGmjxR+2Y/nSUvJ7gKGIV8qDn+rjdQvSos3lA
 pb6awDTngjJRGo6aKQeeTiaZ7ZTbBdJOjpGHuqvMIIm0J6yJ2xq/jvp1F/yfJ19e1dOs
 N72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348632; x=1776953432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=olONKICAQIN5WecCXZoB05Va0xoXxi3BtToDJt2JvlU=;
 b=R7R+KdEgWg7qAEHaR+VmwtqIcb70hl1iuk74bAvvxwsGHJWpGKU+Y14PUog/GHlXWW
 mulPJvLKfR3c92Yz7J48ooLhZxNOYJhJJ/YsJEpS4TvoWaEyMpD490HsnzPV3YIGpgbo
 Qg4QfkD9QaP54716cjR7rCosNtA/4ZdbTnivPYmguwPQ2m2TYt08KQ65n5bY61IA1nvU
 oecbOGhfCLclruuJ28AOblLLR3IHEf2WVNlS5wtc22pBKVDNXiSjEms8ph7yxI2MIMPR
 tkZ4Pm4690q/NPm8YIVAxHkDod8yLWUjMUQ5rndMcsFx5GIM2gVAX45OiJ0UdO8Ophvg
 DvFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l5m0UOgA8xBL8g2dFX1u9Dkj/a8gMKgTRtW7EXxzxC9P7l9nECPncnrCVT5uS7j4bjgTwJgbFVhg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbR/sbLzEHvNbNAU4F3PnSBq124kUSXC4wlV6j6GFE8RhQL8PK
 Q4ML6VIVRLeT7kIY10QilEvZ3FoHiAo2gWwBrrqy0jEDq4rSLQjy9beK72QPEk7ln7c5c7cCVSZ
 Bgo45oUGs9iPd1PfFl+WssYIpFx+d9T85jOy9oNpSe9dz2sg73jI90RVRGxiFi56Rdo/7skE=
X-Gm-Gg: AeBDieucbcCII6nI7GNiFel2bLLQVW4FVKhC+QiaLI3QPDko57D/HbWvREtJCbAhpXd
 yQXbFhc9gFSewN61Q8EHcHKg1B99UyB2vZbmfvXLU4I+HcBohyiNTN9+BSK3EnFxfLl9C8dGm5Q
 mMnQGSse/CVGmkzq4jdgD46bUxQMJIx2ezj4i1bx22nPjGJKV5zJxVqKqJMiKiRydoM0jyXBBMs
 AlV1pV5bI64C7lFAxpTAimaGCVx0TeFc32KrjhzDZ2N7x0IdfYKRKydNPf3M6EaLYAiGHuL7l3h
 WYPQdmeSC8jwQIDlSUqWc8ncv532+fJPvw2XXRaneEIt580nxsxKEZ/KDf9DsgdIQNPCdlD4Wrr
 flqBY1FB4CkAAGDOma1e0PNVrjKKhy1sUOEWu97cj6ruc40PZ6J8=
X-Received: by 2002:a53:cf05:0:b0:650:4aec:29fa with SMTP id
 956f58d0204a3-65198b734cbmr16936295d50.38.1776348632100; 
 Thu, 16 Apr 2026 07:10:32 -0700 (PDT)
X-Received: by 2002:a53:cf05:0:b0:650:4aec:29fa with SMTP id
 956f58d0204a3-65198b734cbmr16936245d50.38.1776348631578; 
 Thu, 16 Apr 2026 07:10:31 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-652e47ba4a3sm2084691d50.17.2026.04.16.07.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:10:31 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 19:39:48 +0530
Subject: [PATCH v5 7/7] bus: mhi: Expose DDR training data via controller sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-sahara_protocol_new_v2-v5-7-6aebf005e4ba@oss.qualcomm.com>
References: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
In-Reply-To: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776348592; l=5329;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=ED34D8b+KIsBJGlgWYmYp+bxz9nF9W6dhG3Lu+L8T+Y=;
 b=wr3vSGs78JSxGrL9+BaCDjQaV430OdwRmfmRxGfEA18NdKlc7cPBYHUMyREr7q9wjEQydgh2n
 fowGZKpD2eLBYkBvWD8gp2LTGudSo2ECATeMbqaMDKsHQlDphB0Yaf9
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNiBTYWx0ZWRfXyx1UGMsl2Imd
 pgrWsv/dMquNAWOmoS3JrN8DZItK/2R3FGWb9VoZ80H1e8+3MeK75Fq3lzWPHdIaZA3tU5cOWXy
 4sBXth9hNaIL+GYB6I6f1co45zdeWAthN5wbjqHxCsJKdmiRXgS5F2njLF8GagIMmIcsk69WD9e
 GHQqE3eTg1XxEQHG8Zm/ZCQY/GlAdwd9w9vjkX3ocFqnOL5uS8CDsF8eIZFDno685VodmehWKut
 L11DnjiR+T3v4PtV1cJfuATXHpJnr+hUgOLi9Hkz0b/61jnUemTksQI1zfyRCi+FTDVTUbtDAYw
 goSTnGla1ESlnSDPA/4B10OuXitFzOL3X8yMUfXbaTx1a7ZUZhzeYcQaiYH2CoQUPGFa5ZSMSBI
 gCcYCuOn1zG/mxyq/y2G63fxgS8f8LuL9oryIn4J/ej97mPTrxob9o7qfpPbwHSu1HrIkGV1Nek
 yfG/V36yTSMomwTKcHg==
X-Authority-Analysis: v=2.4 cv=ZPznX37b c=1 sm=1 tr=0 ts=69e0edd9 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6t33SRJ6vQwVIDTtI9kA:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-ORIG-GUID: qbPr61-Rpyyz3ZrHRcVIdodgG_sOvR4J
X-Proofpoint-GUID: qbPr61-Rpyyz3ZrHRcVIdodgG_sOvR4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160136
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
 .../ABI/testing/sysfs-bus-mhi-ddr_training_data    | 19 ++++++
 drivers/bus/mhi/host/clients/sahara/sahara.c       | 69 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

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
index 07bc743aa061dd2fa85638067d494562152474e3..fef5dc1d8884133397d204f23361584fd1d9b075 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -273,6 +273,73 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
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
@@ -1131,6 +1198,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 		return ret;
 	}
 
+	sahara_sysfs_create(mhi_dev);
+
 	return 0;
 }
 

-- 
2.34.1

