Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6716ACA600D
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC77510FC6E;
	Thu,  8 Oct 2026 06:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="evcTkvsz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g7MjpC35";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32EC610FC6E
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:24:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984BRcM2895383
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eS4PvSA7/Ma74eWd/k9oJLAImFrqW7ASvtLawTHJBjs=; b=evcTkvszK+8U31jJ
 ku8eUG7knSKpAMWE8bRHO311PA3pCziQipIRWzLnodfqSvJuVFktYYKncxBzIvUl
 gLDEZe2LP5GWc/pkRBZpMNOjIu89q2JVzssEjgc0ApQsyAk3DHZZQOwIcympLD0b
 kVa7NVF1tAu8hqsGimVBWj/loMp2sXzFNEaQX4i76qj7ZBlpbUNMjHdYpxialLQY
 xxe5ArNsgIGZYnChYDd4PFHlrcX1A7LxL9mj8o/KRyYJEmAmZ29PJo5R/8mLWqgj
 DCDc8qFzEpAY+xLo22eEtuyXowfX++2XM7L7UcZ+9Sk41xe0qXQPuNbWtwDx21nS
 FdyBgQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sg912e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:24:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a47a81e70bso5063810a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791440667; x=1792045467;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eS4PvSA7/Ma74eWd/k9oJLAImFrqW7ASvtLawTHJBjs=;
 b=g7MjpC35zas90jISMWMwjI575L0HbIMDSYnsZPYzqIE4MkzqPEl1W+KQWyDnYz0CdX
 8plbKZbrxXaCcuhZXxhL8wYoawHowxnOAB65Uzl57psF28i/lFWugpVer5Y7L03zeXF6
 rMBW2RmuwKGU53y+L6MK+JFxHsaeS14uXxjj40oqyPe1I06XJBK2t6LFKyGMQYtr4on9
 SEm4bGRrclEihzSFRKRC1JG9ZoZ4tG9fRzlHMM6rzpNl4UsGaZL/rTttDOV+KEXPoc2v
 w33NyPIOtKA50FbP+qkoYYfrEgG4ks4m91ZVoM2G/qCsdvw4qK7w07o1P0uL6RZnhlCP
 /ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791440667; x=1792045467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eS4PvSA7/Ma74eWd/k9oJLAImFrqW7ASvtLawTHJBjs=;
 b=zTfxizXeHrMoGsbQL96Bn+3N4ncEO73cNq/YqrR3MKuyuh+0ODVU+uBovA1NZ3OJOg
 7Uxmz3qlZH+qD+TVoNg2HVsRG4xgVpB5F/WkAPk7oboQBhASzQseIo2ekkIMKiyN/vqo
 kAhpKAOD6NbnN3sNfN/HmQFKpJvetABkGqasAk4ROoN1o6KBD7TRR2WBAFmYl9t7oxRe
 HrHXKTxPFELEROVhGmgT3HoX0NKa84k2QeUH4LAkQW6ZDUSoFpi0qeXOfYgngqBfGpNE
 1yU/STmvi84+lbPXdOfSvfU6iOo0P05ZDYQqDXCvNxmhTJcgUCCGIuIrEMocGpbvbaO/
 qSXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNW24Lkpi4pVyMNB+eLkLEeBL1kl1Yz9VY1PUGYHu/SavwfBy15hVaXwBnUvQ5cSfHaaoScpvO+II=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIF5GVxBuZ1UAjh6qzCKdySUyUvfOYlfw/TkdBisTXXxTNdUN7C
 +epFyOQbbmzzChK3xu2n9PnRKzqW81kGkoaK2k7aaahQiUnISvyEyCwLMlXZIdTJA3OXj0At4a8
 Pjhr8lfUUYKXHb/otUVhHuhqcQh75DjTVu6y2Cs3+5F2CKrej6c2Fg4MS8/+z6QE0uE5Wz5Q=
X-Gm-Gg: AYBFou2HkOPWzDrVd7XgDSk/8lDysy9D9eMG3Hx/8UDH559P7FkoGPtJNHwC83f085r
 SB7nuXtDOCCDladU6/OBOsCErHMyaoTKR0j208V6LGiqyyBn39LzAGpURup8DNsif6N0Xhbi+RR
 RqmEUYvW1zhI5I0Syqi51At1Bu7C+qoGbbZQJThI7ZqxAK3Kuro59dCHjYemdI3xV5KAgHjxOpq
 GB5b11596+5c2Zvy2OfXXfrBbomziSgkhM3OwelJFxhHx57AK5eeIB6Kz9rOies9OBpE6Tyzyp5
 Wk2hE5WQcXDC4Q0Is+LQLnQ1DzDlJ4Ul39Lqi8YRYjY9g52YirqUwkqynRIZJYTH536/dbchdB/
 CoOqxHfQhfr3FwQ0FULdPEIZnyMtt
X-Received: by 2002:a17:90b:1811:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3a8a1bbf16dmr4105664a91.45.1791440666915; 
 Wed, 07 Oct 2026 23:24:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1811:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3a8a1bbf16dmr4105630a91.45.1791440666413; 
 Wed, 07 Oct 2026 23:24:26 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9ff7ab034sm2767618a91.4.2026.10.07.23.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 23:24:25 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 11:53:51 +0530
Subject: [PATCH v7 7/7] bus: mhi: Expose DDR training data via controller sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-sahara_protocol_new_v2-v7-7-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791440631; l=5210;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=XVetEM5Q2ug5nyBqvhNaS/084gMekcQG8SGiCqI6YvA=;
 b=XwGMCYWzlGTsjAzJeyIcI3VnMQ7Gv2772DSFZeD+o6JRTtp9YjGcLODcxasJ/NPHil0Hp/nRa
 XEkzdLU4MUSCax5CLl3/wd4fJbJlZHVoEzE2OFoKpXGO4EqpVFMmk6M
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: LoxfQCoj8_t3jYUN6M1ZRbPF9xLiUnKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfX+cyX+wP89iq5
 OnZ0MOl1bu0Sfe2g16UzUFY5qddEr1P2gTwBWvf/9GUkpx++VP2qcaq/m/jHnMg2WWT44EYJupS
 354+c5Pjmcq7bBXkHbzuMdG/WneL2Z4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfX6ktFuRg8+EtD
 +ITo3e0Ov4p3QzAUMg9NgFNN43dF1n+w2GSTCAMpHkUDTlRvfJ2pyrSQQIieJZd68PNbWDBXuw3
 cAWIUt+zvUJw0hS/NKVLuwBlbSKZEEwr8ga80Ck7+ICLRAH84/4a9QgQ6jW/StIalZ3bPyNZjUa
 TvPoCcC9PQpeec0s2QRZd9l6ElYGh89DB9wd7kKPoSIrzFGrVD2sFVi7aaW4tSkqtH9pT9J70Mn
 sQAmT0ZKRicI397I4jD+k10TuhcTiSyWPfSLiVygv76IXwAvvdlKmAQSzsVZy6e8/Vxncru9wgG
 5/GKlY2F1ozqMlJSSLwVAl8h9kYTYkrXcCgOQaTYx9VQBwHgGmd6Rxkzf8e1ENwccl2fKD83xYU
 edd3zytGlapQNZ2+yBw7b5vYDtnO5sJaN1rd4qfiOlu3FdiaW4maEI0kA8Z4CJDrR7w/m5eMFWv
 R+kqUzQ7lWnlLabNBxQ==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac7371b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=W7Sg6yURm1IBNJFiFuEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: LoxfQCoj8_t3jYUN6M1ZRbPF9xLiUnKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080025
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
index 11f65cbfa66b87cb6f144eb096f96773621978fa..2f2d18e4ed4da4ab023c8d68a5e69abad0480555 100644
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
@@ -1130,6 +1190,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 		return ret;
 	}
 
+	sahara_sysfs_create(mhi_dev);
+
 	return 0;
 }
 

-- 
2.34.1

