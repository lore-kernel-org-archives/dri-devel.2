Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DC5C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD0C10EA2D;
	Mon, 13 Jul 2026 15:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOCC5f0U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AuA9hfUv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B2B610EA27
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:24 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF88K51887847
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8K0JIquvs3cxPSyDd9QX1UWRoa9KdPTnlm5VgT6UzpA=; b=BOCC5f0UeMABLuQp
 /DeFIlYIp1dkCmGgfkTYCYsNLEXzLx+6TaIqcIl515s8AIhWOFmrK9qi5YidC9/X
 J+Mx6zXNaWuvsy2Bn2EHvCBTcZIpE02rGregTh/MoZCdrCvM8pyWnHjD783DGi7E
 cWhX2PYM657cnGCMBOgo8ib2BjV+PYoA7fWe0Fll+9vg+5IqqxbdqOv6WSyoCS6q
 IIn+jNGjhhGYHZSJBU3pmPDyhVWdDlWW0lXDnYYdY/RlALFZHPlMksAG38ypUR5Q
 Sh+B4eCOI5LK9plwzUpJzI8p23QZPidPEXC01VfV8MfImK8kp6kidUu642NJHS9R
 wq9bpw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavschd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so64189041cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783955543; x=1784560343;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8K0JIquvs3cxPSyDd9QX1UWRoa9KdPTnlm5VgT6UzpA=;
 b=AuA9hfUv5m+yZ+LBKXETtXDN8eNIEG3cd4FHz8YgdPPzxSpy/1/EGtCnSQMUKlqzaH
 gSRPMAcESkAV1LxIZk0Y3j7MEfoJSeeY/zqa/wV1sN0OvnBismrMiP8DAMunEktZtHkb
 ckX+3RLUV5YHZCbM6nMcKGFi65OwI48swQS2NAAh+Nggh8im+RZ70bhXRW+sMls3gVt+
 s65a8MMqgsPLar4UEGBQlc+kjdSC5zuY4NgZACmlddSz+XY2qQ8V3823f7gDpWb+GwFh
 IPB0m3bC88rIV12wNyZ/cIld0NCnKj7DnZj3SR5/WQCZXLhs0AP6PIMf7IiVz/e4uerM
 AIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955543; x=1784560343;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8K0JIquvs3cxPSyDd9QX1UWRoa9KdPTnlm5VgT6UzpA=;
 b=dJHe1cmC7L2g5fGam9i+L35xbgWsm+YviG6OUmpYhLpE2JlKMpond9mNCOSSmgXHDQ
 79XiBffe/9fuZxjtIJadumSWiW5QBYXZUnYJcO0Q0Vkyfi8RKPZOrIscWSiqQdjgZvtT
 QDgm8FpGSq22kLPrCR9xBLE4YeYK2dsSFjrZnOmO+P5XgMwBpcdqA9Rm0MBCrSzSOQ92
 RoeGdJtKnOwE5MDYe+oBQMOafR1pyNvjn+sOqtL1dSdshZHGevVw/x4Lp5qp0Gy7DF8A
 lh01Ah7lkWSvi0W9tlTOKvuqKYSDzYNToJZRJ5kRqY/fpI/Oi0iAvGQ9cMzyy3MmN6cO
 PMtg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9M3O/Hx+muJanSOVKTTZ441EzjONn5zbRTAug5WMeULRqMqx1Nbip1bGj8BnWKNyGZ2VIW3kZKuQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK/pvQNcPKerivEdYPbaR0FasLz8Afmh+GZmg3nuwAy1gyC0OH
 t3U2H7sFLdhkDvl6YKpL4Wl0XNJPz6kk8LZmsK27CvYXUg9xLDX5nmojk9X32U/oKPy9v2h4LsI
 J3mnuP/vIWsvRbh0Zltsl1WyTYz3TKJ0sqs0b6AWR/76dcqq18Sp4JVlFgUUH0LuyFW7bbAc=
X-Gm-Gg: AfdE7cm9P7YE8VVPqiTi1wxZd2PtcvOS9VJ/7sEwcvxgzoD17PRJVLl0phgcMIWzRaf
 spJMgJ/SO6TY+7EMzJsG5n3AmyOFwBADmM9bODuopvDrSCozccK+y0aJ0Oc+jZYcvL2DwNs/Aq+
 +oOz9FAj6px62rsF+J3X4DaOX9i9YEutJFghlr2/vuyoLO5PflXcd3KVU/rQZ26W4GiFjYDcheT
 RG42hz95Wg8UAdTptjTv4OT1sG5q6pN1C7dm43aXhwvavZGpjDfCmQ5Xny2RnjX9bh/dN70BDu9
 jIDmKoswGZfew0od28E5IokUs/ewGxKHMFCehJc58gjEWAnT0GIeWNYrj1OuKPhE3bnqGGHHBuu
 RwJ1lqGPk37+osn/LMPFAmgx6A/gn6PEbmTVK6PD1
X-Received: by 2002:a05:622a:10d:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-51cbf162a37mr95302391cf.34.1783955542519; 
 Mon, 13 Jul 2026 08:12:22 -0700 (PDT)
X-Received: by 2002:a05:622a:10d:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-51cbf162a37mr95301891cf.34.1783955541957; 
 Mon, 13 Jul 2026 08:12:21 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm87956664f8f.27.2026.07.13.08.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:12:20 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 17:11:58 +0200
Subject: [PATCH v7 2/4] drm/xe/i2c: use device_create_managed_software_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-swnode-remove-on-dev-unreg-v7-2-6d6bc448427a@oss.qualcomm.com>
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
In-Reply-To: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
To: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: brgl@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3069;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=K59bsZsPg0oBc3El4NBYgpsIGFNwewCJ8H6R3I7pL30=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVQBLHe90K6lVmtYl/c5igcZli7qp/jrWQWKZt
 nDmast6tViJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalUASwAKCRAFnS7L/zaE
 w9u+D/4rljpC3ahmszRx6QX+sN3PBN42YyT4ut7PwFuo5riz9VlF1xvazJvVY3hozqhuIWxlOtz
 Md9ESdszzAvd9ry6gerI0QURYd5Pu5ZufD/2fJZ9Yh1Q2OjnICBZwmsXuGHtPoyVIPA62doZmCH
 gYMnwWXUrh2G2HXZeszXq7/yrbuOnVW4FiHd4InX54iZ93wcck8ACxvX/WpPc72TFr1kCt19TEi
 ld3BMRR3Cl97tXhUGsYr+KbkCpELBTJHGZ28dquEd5M2BZDM0fGeWCQB3xSjOs8zwHfX4FX0U22
 XQfGMhYnOW75lAO3QEXIhEIPwivnWn7kh11TxvdB9iCVaV0d74Zs3GSk+4yWHQhfsxveaH04iGA
 Qgc6B43zyL5o5/J0FsRTf75X7Jv8YZdJ7W9Oe3uIBSEvEfp8eFOg3CoU5Wr4D5MlElEfXWRL1ai
 jv3K3ciVTZavQ0G8xTkbynioZLTaCO4zzExp2fpoXB3d/z57DwM9OL0pKQkcdeoumhu0QmU5t/h
 e9o30diob7Dq12Bt00bW4YM2eV2iJXSDVDfwTT7HOXfQG7J52fmMQA5lgIkrc8XxCIGW6q0Z1n/
 gL6qtyzAXt5Mfpu0NyYdZSunKhyhX3z6Q4PLn76W3B0Gy3XZV1LObT4A65zPrhge4y9XbO8uOG0
 wNfJxiV0NV2rJiw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: vt1x-SSkBIA_G9e_ekP_y88U2tOs3muX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfXzFk8PtVWQKZV
 daNCACqdMa1GGE8zbB1zjpvF1STqG9JGwk3tBldQNysHt6zYnhApWsHy0sU4fAnAfpfT+a9n1ZX
 32qyiiPvBW9i+/kezfvIMr86iiuC7Ek9VisybSCFRegd/fgN2jrVOf2vl5H+6aa+F6/j98b1gsk
 5XdFD7IXMa/ACHYuua1QtqQZ8LefZSXm2xp1WzYP8ayoqJzN7ZR/icIVkv1EeO/ZM/KfCRaJCMi
 sNk+DgbwhcWCgXwNEE61pC6M5wfp6LNTynEMR0QB4Z6H4sYFD6CI42z3CjzfeQE1hhe6KF8rgBV
 EGn/SopKNmQvwryq3i2J5J2pnfTbaCIlM/BIYzhiLiH2mwY+eNGoG+IeNmEIjp9fsZhb0iVLH4S
 kOlcXi3+hqqSPZGraQJ8y/HzsWcejWzuJmqIe01orJbepS3kLeeFuFHM5QLHTY7lQ60Q2T7u7Um
 K4DEfVplzpJDHfcWiGw==
X-Proofpoint-ORIG-GUID: vt1x-SSkBIA_G9e_ekP_y88U2tOs3muX
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a550057 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=CQ4qV2wi1td1G5PDrAEA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX9M6YXnqmLASC
 o/GxSVEqtjOz10TbThS4FOSOad5BbdRepAVCXcBl60GYuKKzIkB6D6f73Zok2eiVFIjUU5x9hWC
 52yzw8Dp+qN5LQHfHhB+4/2AhQmXG/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130158
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

This driver intentionally uses the fine-grained approach to creating
platform devices. It assigns a software node as the primary firmware
node of the device it creates. Ahead of improving the reference counting
of platform device software nodes, switch to using
device_create_managed_software_node(). This way, we create a dynamic
software node whose life-time is tied to the device to which it's
assigned.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
 drivers/gpu/drm/xe/xe_i2c.h |  1 -
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 3d80eafb9a1318996d10db11e14af4cfde07ba55..af6e973e5e68125a9c006bb646447ca6e377a6e6 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -93,13 +93,8 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 {
 	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
 	struct platform_device *pdev;
-	struct fwnode_handle *fwnode;
 	int ret;
 
-	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
-	if (IS_ERR(fwnode))
-		return PTR_ERR(fwnode);
-
 	/*
 	 * Not using platform_device_register_full() here because we don't have
 	 * a handle to the platform_device before it returns. xe_i2c_notifier()
@@ -107,10 +102,14 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	 * platform_device_register_full() is done.
 	 */
 	pdev = platform_device_alloc(adapter_name, pci_dev_id(pci));
-	if (!pdev) {
-		ret = -ENOMEM;
-		goto err_fwnode_remove;
-	}
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = device_create_managed_software_node(&pdev->dev,
+						  xe_i2c_adapter_properties,
+						  NULL);
+	if (ret)
+		goto err_pdev_put;
 
 	if (i2c->adapter_irq) {
 		struct resource res;
@@ -123,8 +122,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	}
 
 	pdev->dev.parent = i2c->drm_dev;
-	platform_device_set_fwnode(pdev, fwnode);
-	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 
 	ret = platform_device_add(pdev);
@@ -135,8 +132,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 
 err_pdev_put:
 	platform_device_put(pdev);
-err_fwnode_remove:
-	fwnode_remove_software_node(fwnode);
 
 	return ret;
 }
@@ -144,7 +139,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
 {
 	platform_device_unregister(i2c->pdev);
-	fwnode_remove_software_node(i2c->adapter_node);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index 425d8160835f4648891ff75f2a9c06284241710e..b28229f056c5a664e1d41dc0cc1978782fe1c2f1 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -30,7 +30,6 @@ struct xe_i2c_endpoint {
 };
 
 struct xe_i2c {
-	struct fwnode_handle *adapter_node;
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];

-- 
2.47.3

