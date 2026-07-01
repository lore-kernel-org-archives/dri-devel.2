Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD5C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D54E10EEBE;
	Wed,  1 Jul 2026 10:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEs6ogGG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/QJnANG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AA210EEBE
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:38:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A98u5674097
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ok+6fNf56WQpIHo1nYgzH/b5G92QcDwfXWueRnDPmYA=; b=aEs6ogGGQDI74RO/
 lRblGrlJ+2OeazJFLlUe+c44as9KDJvck6imiu0lQHDBWfm2IQyJosWij8m2Mizo
 GE9DvpzYy5FdSuPaYc9UaaV6dh9CWfjTJwRkpz4bVhHIqwTleNU3wSvVzmCVGd8l
 pupHFbqm3H9fGUE9EzjwK160C0hiRWLiuFzGQQ9Rw6ilImQgPfjY6vAfpzzwyPyA
 fAD531S9z3di9k3RX+keHKw5am3xfo1kf9MRqfMfDDn7/dOkve1mkA2D8omnuVoS
 hoxA9OH5EI/hbC4nvfbQJjTTK0cUUujvbG4jfjyZ5veoz7Nb+sza9Va9oFdO6Bt1
 Dtu9jQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f502urbq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:38:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37fccad2b01so852859a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902299; x=1783507099;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ok+6fNf56WQpIHo1nYgzH/b5G92QcDwfXWueRnDPmYA=;
 b=a/QJnANGgsBfv9i3MQVLVbQTb/kF9PHX2a/m9NHJsOsRyzabYsU/wnUFwPu+OasMRE
 pyjDfkhsN3UpB0mSLmub6KikxTlq7Mq01TxeFohCXYEcmdcFQiK9sjTDyhc5MztaNI8h
 ur2EoEfq3ykj9qe7znlFizPVQowYg5qDeHkb7Nk/VRftBs8MzMKeEUaNPQX7lYvWuBL5
 EDATYK+oIRS/A8uA1BUiY4bFMLDEfHWdthgnQg1opq3GXjPtqGQ+xbuUnm4mxJi5ggMh
 0qgB7ZEfmGhJLbLgM0zucuE943mrg8p4RxAx9RRGr/A8S+mdXDi1HlURT7Z47ymNZyT3
 WiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902299; x=1783507099;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ok+6fNf56WQpIHo1nYgzH/b5G92QcDwfXWueRnDPmYA=;
 b=rOWPpQWBe8JvSrbjCVFS40O3jbIsKCHQisXjfI13lxX1JgG8UvbzGk9u3oXNVGoV9R
 +yi8RQVdI+vdFwOv3EaA8C7J+ga1UWbj65wwkiQSznPYQ90cErCaZS/B7PpoTWsE/OTv
 ButCL1ubxUQgYBMOBT+f/iIYzdIFPoKxkrMHc1SF7mOY3bUVaxH7ofefE8fyJCA90O5i
 aMRa2kJfspDADPBiaV5MudAPnL26FalfV3xBp0rQQgVJntEN+emeoNJe/OdXiu9CJ5E3
 zHWk/TaM1+DPXpT0LdF7gVXiWca1VBFQfJ6h1JdxWMV+/wagrIU6IhM1v0KIewSIRbRl
 Oagg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2+QooDPGsvhGWlJxdKoAydtf6fVXnVT/GcEI1fbFQMnZwfwiIjKPMy5VpK0W/xRY4j62fx1FMXfg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKPTFbf6qxCraA00AnzLd4K8DDJ2NBTI26X6z7g0rKhwm3QpIo
 fdgPNYfKz372/MBHEV4vqozK9KZ5K77MCvC6Sz34XKFN0cfmSBnMwnkNRyLuxjm/3AUIusLhu3M
 e1tWN7XnfsGGdvAIhnYc0UKGVVQCxl0KzoEc3GMWJkqqSLsg3IAqXO7cgRQyL3nHvHI5QHNc=
X-Gm-Gg: AfdE7cm95sXK4BqnKQXfO1sbwH0I+Qu7zQOrWmMAryPY1qmyaM5Yc89PXeQEQF9Qjuk
 iZ5O9gm0QoGo8YtWeHHeW0yq91nfW3cg+YAfqcKyyY8UJnoC2ZR8+3WKpQtGfvD0YsMZr1+W3jE
 LwMjC/BszdHai2Wh4h78/1vfU6ZWV9SD1zAzIOXOQF4m0KCxh007a6pwIeOcRb06YAP4q0FiiZX
 /uDN1sJkAC/ee5gEDSk5WmGvHLyzlqWVZdtCVeoq+Zwy9RA0Vc36uc2O9srj+3XJeS+5Y9jK+gg
 6VhOhjf4affAdiNm9QWG/w04uXGbTT5A0STyvZQfz+aGLZEsjvKSmPptj3OhyhLFSYFSY5Hm/hO
 pRd9gdfZKVD9wxqZpNlnDS747pVzOt/jKUYsHkK2x
X-Received: by 2002:a17:90b:17cd:b0:36b:9c4a:e05d with SMTP id
 98e67ed59e1d1-380ba9455b4mr221621a91.17.1782902298747; 
 Wed, 01 Jul 2026 03:38:18 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:36b:9c4a:e05d with SMTP id
 98e67ed59e1d1-380ba9455b4mr221594a91.17.1782902298250; 
 Wed, 01 Jul 2026 03:38:18 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095bc8a2asm765251a91.0.2026.07.01.03.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:38:17 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 16:07:41 +0530
Subject: [PATCH v6 7/7] bus: mhi: Expose DDR training data via controller sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782902263; l=5210;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=Jan+rO3lHREsYWShXbf2aFwmvonRIbh7Bu+veXE/AIU=;
 b=1aIjX2/TG/4sjfrA0UmBKYhS7juF931y5uK7Gq7FUFa9jfohXouXcnQFh9yaSzTv8NA4fWyk3
 +pWLVc+XgmyD6NA7Aks92EyaC86mt609EWMML0n5d2hWDNfOuI52pJL
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX3kKXXEdjTMoK
 VZYvfH/FoC+rAW1ntlMK3pM2552hkoyN1B58IX5FVzgmrg9wNW+EZMSsm1gYWJFhCx3ExC3wpB4
 NQci9lajADn+mznXMTc2+B02pZKnvSw=
X-Proofpoint-GUID: 4C5pDSFy2LgdDf3bm9BDByUK4UFIs4Q_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfXwjaJ17Vq5EV6
 uvB+A+kxbTlWFCciEbzaQTf6IJ0lJCvg/oLVXj4RSSDhmkF6SQgYVELp55qG+rmV99GyOlkMqWf
 Jy/0lFoq2HQfBpZOSusiPCg82D6rRFlMuuKj4LkBaS0D0kjilDF2uBuvn8OduBH2WZDfVwyWV3+
 dYNu8qV12itjG5GTeyACKrEeuxofL9Cro/MxIxU3aTGKGKeAfA8H9IzuxKgN8k2xmwBn18eeQyc
 RJCMKEGXODdCH3hs2dOKSKbj9zeJE1syMRfJR7LYDpTVz5u4lEVj7ftr7RdNT8HZFSZKeo/h0U/
 HLlwo6IhGvqkf52ADYqcCyrAxGv+r9czacviXFpthqnRpw56S+uRinGf7xMP9jQHzHggRyzhZRG
 7+B261/P6UC2kbGuX4V2ur6XLtGne7irtBsvM/0ZqtuTD+xpNtX3tLYco6nl8gjmEHO1/UGdiph
 Dv7YmO47FOfYROS5qGw==
X-Proofpoint-ORIG-GUID: 4C5pDSFy2LgdDf3bm9BDByUK4UFIs4Q_
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a44ee1b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6t33SRJ6vQwVIDTtI9kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010111
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
 drivers/bus/mhi/host/clients/sahara/sahara.c       | 62 ++++++++++++++++++++++
 2 files changed, 81 insertions(+)

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
index 07bc743aa061dd2fa85638067d494562152474e3..72ac751c302a98448b5756c9feb438647bd0ce4b 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -273,6 +273,66 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
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
@@ -1131,6 +1191,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 		return ret;
 	}
 
+	sahara_sysfs_create(mhi_dev);
+
 	return 0;
 }
 

-- 
2.34.1

