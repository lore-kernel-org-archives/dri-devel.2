Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083C6CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFBB8989E;
	Tue, 13 Oct 2026 08:46:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5753710F61B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D45uVe173399
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tEMDLqN5fZ9ZGGYYJqvC0hdrVOQfVxW/wGFukiEhFuo=; b=ToK7AUuKKvprRMkK
 Bv20C+OO4z9VjXP53d0EasiU3syfGYuVdQIAu6Cs+vET01lakCnHdy/9ty0OOIf6
 P5KBN8sc4YG05TQ/wCzT8EKKgd0tTX3d47MrGMq1awbBCeVT96q3H3WJi+kNI/oM
 IwFvUHA8iOmGkI6tRPouEryP/+Hi+IgyqfGNyuUDbp3yb/qKkVRx7mhXUd0D+9H+
 z5qLeMYm7byIglSNIAsuBWcty6Ha5lB1pBsyMGfn6XRkqey8feHcArNZVwJIA/gf
 i+BJNoKh8ERbG5WPbsarFP5uLGRnrqs0+7j/Bh0pcH9kq48EudnCKvZ4Vbzyd9Qg
 geCm0Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqs266-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-88732460a55so2166445b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881180; x=1792485980;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tEMDLqN5fZ9ZGGYYJqvC0hdrVOQfVxW/wGFukiEhFuo=;
 b=cOXLhtKRfXaPyy61vC2bUUAsk3Otr+hTdFnJWJ51Jgk1TUgiUxTLvSaiJcAtYwvuRd
 vSawbTZuDCJ7gkBCvfXWXzrdq3GgQH9n/XnO4QLRuccXZymZF36ylrCSYitlEiCMBcid
 6wk5gaZlol05hcWcIrDd98PofhPkCUgSiRcEAkAD+UcnGCxkWADFqQYv9LfGM/TUgnfy
 HkUf2vl0/p0YaDP33gDSiOFTYQeS5wzOgLq8Sh38PDJIXx8PdaqXMBubm0gLZdsgyh3i
 MuynT4W6AdHRl77JF1/PI8Wi2SfS06v+E4GWiTmhz/VvRMpSwgQ6iT3koUBGBIWGaq4W
 r8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881180; x=1792485980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tEMDLqN5fZ9ZGGYYJqvC0hdrVOQfVxW/wGFukiEhFuo=;
 b=xAWjgVR0Ssv9tusi14jkFqEI3ZkWVRcDSM4YvE1A+2J/GLsaSoTwRiQJ85CPomJgcw
 rP0k1koHsadinStpTVQHf54fT7S06xKybDQGXcMZw8qJ6XyXovtw92lhZmB16ZfHsfV2
 A4alv4YZXIvEKm98ldX4TIy7aK9xOjx3ssVd6EndlFyfdPQJiIDqYsFblllvwO9HLGha
 iUQ7uFQ1LenIemwEm9EIMYZ8f19tZSC0wxNBD3CaLA/F8J8T55W1BxZjvBf5Ntfvwr4Z
 uhS4AcKk7m3VEoSHnbl5y9lBzz4HNrXPLovJfcj7ddfJ/qsIAXEvDe8S6tiy0X9eqA/v
 swHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/cyZlrGyn4TdIeVSEaBg0dpI+DspHxRSZf+dHOHRZWMgEqgeOhPulWlY6SelFESoJhC9JsLpT1fA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL7mHTbjaRc+N3misjKa4qQcxC8vBBHDGj4nRVf+Gkvlb4qACuy
 hiU2/+PM0D2w4kfZG2wYoOQX8M4pdroOLtTRBU1nVfoHIk9bSAoqNBGgjw6skOasQUlQew5XIU3
 Oao0Yols8bBECJo8yxZnC8o2qbD9cbQb2s8RvJK3OFJIZvnandcMhKzMIW4ivfFun9OLWFo0=
X-Gm-Gg: AYBFou1dKNmmwH9Mvs3M3TztaQwNan0XlapXIqp6i52lvcl7FuxQjT3Oa2MCvvihr9m
 z4mfN01H9S9mMbSiRziOal1+Uh0hLaVpfrP3gVculMKVm6L/BnT71QPjBCAWW+TUrEczPOndazr
 tFNiPoCRAPdkRyZD/rtSpnj1eVLzWTXAtVndyKB0v/1ogRdar2TLeDFyy0pDo4Ap/jHHN089yVh
 hsnlqJJMTDK409sHaNNoCeypt+Q/iAnDxw53ive5QmZi8ZDohaoTkmAievZvmViJiNzY9DvWrSm
 TZk0nGtoA2y0ytBavvZosqiCNwWvpOWxLCKWJnrywVMggBox0qMAB5c+rO4q/m6G7qgOw0v0nnZ
 4NS4ZqyZGptk4+o1ns4r/1lHseEBk
X-Received: by 2002:a05:6a21:4598:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3e16bf4c2b2mr9630304637.78.1791881179851; 
 Tue, 13 Oct 2026 01:46:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:4598:b0:3dd:a197:cf2a with SMTP id
 adf61e73a8af0-3e16bf4c2b2mr9630279637.78.1791881179313; 
 Tue, 13 Oct 2026 01:46:19 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5384721a12.31.2026.10.13.01.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:46:19 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:15:38 +0530
Subject: [PATCH v9 7/7] bus: mhi: Expose DDR training data via controller sysfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-sahara_protocol_new_v2-v9-7-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791881139; l=5269;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=68D+ZsKS1NidI8QaJpqFgyA6M80R4nxiC7ber19l0Ek=;
 b=m2DDfLs2by6LxBIHhmbf4ndcQniRip7Q5gsIwBvBeAZ+C6RhEDcmdeJ5XhIthHvkq7Jac72k4
 C529vdY8Rc7AvXpHwQtfRxOgIxqLYGYukoKZ5q572KQDPFeOeS6Vmr1
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: x-sl9_4PI8h-IRsrg5h3lMx4shkbAgKP
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6acdefdc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=NePjL4a1hEawMabAjiMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXwDCYHMeP0npW
 Q/So9QfrEX5M+q1pXKoFvZosh+adujp1eU962TdtyeIbUyN5Yq4IWJPPx0OEi3y7PA4391buQ1T
 tlXH0T2JeIPveI9RFbT8OeBoVRBv0BE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX/s8+2Ns1hnzQ
 GHd6YGTmB/q6klFEm7AtTs8e5hsVl1AXj91SBdC07t9UeECMFZx5LGPT+BqDjHVEwI/eRV+YEjN
 CnKPbd/dwc23IHvXDky0A/HALCcQgAy1bz8nbykua97qP5Oj13Ah31/vTqOGRI3jjrJDZQ4zLUP
 apTyUuRvAqiq7QFHRirw2IrZXHmuO4GNWFej2vL2lKISpqwbGOhJ4NbJ6ta/dgvlyIKd/wIe7CT
 unOn7orVv7iKWri3pD4aQWlBBYj05Yr3kzAO1niICCbIvei3/HiWli5TdmB49Y+04FnuvqeJZdd
 4d9uEF/PnJvn57ptqZuamjeBoIdljYGKYEwyGZHJk6jitU96QEhrLfcmDxGF/3bbft9Sv0nhuF9
 +L8I9orsa8XyLzTNcvf6NNF3YgCQ7UGEgvspnyE0Dx7KNmf7SyotvVFLUjns6ZqFbfSrZzpC2k8
 h4v/VS787FgXRTlTo7w==
X-Proofpoint-ORIG-GUID: x-sl9_4PI8h-IRsrg5h3lMx4shkbAgKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130034
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
index aa684355b7a31674f81a43a3783d5c4158b824b1..be5318fc5e221d0c91fdd9c4b6c908ef1fa4e852 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -272,6 +272,67 @@ static struct sahara_cntrl_training_data *sahara_cntrl_training_get(struct devic
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
@@ -1129,6 +1190,8 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 		return ret;
 	}
 
+	sahara_sysfs_create(mhi_dev);
+
 	return 0;
 }
 

-- 
2.34.1

