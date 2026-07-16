Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4D0C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE07810F2D4;
	Thu, 16 Jul 2026 12:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+Kww1pD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WQOJiwni";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864BE10F2D3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBia972475287
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3y0IvySJBouPRgIKjp+IRovT+WNJHA9QwSsnhwUAWFA=; b=d+Kww1pDbw8BsEPL
 G38+XoN8euPnjzHPwfhBUXjniQCm2z1F09uU2lG/WiYjHy3Mk5sRVLfeFGQM/5j6
 Lw4nkGpegPpQ0y7OZMlJdbDwoAYBTLLYjSX2acswSGc0bo8IcC4r5McqdPshTD8k
 FF4NMAtEUlixWJA66e4PhyCEW03+LoyIERhx+EMuyLMjsiFItgkKItvZH3dj9ONp
 H32KgxRSdow0HZbKLEa7vnpMEHE1lrTE6yZy8TEA/YJxh9Oliyd9LyJTB+t24Pm9
 wzhbmi+D/HurAmNTeAM/fb8SuryK9TAq2ytVVl+cYR1oWcCsB1hME60a2ttblZXx
 wlWPZw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7sbxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:32:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so82484321cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205124; x=1784809924;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3y0IvySJBouPRgIKjp+IRovT+WNJHA9QwSsnhwUAWFA=;
 b=WQOJiwniqW9gy3o9AO/ZLfvlrPbIkACypR/jwkV+FFvWtECNFMhb8JCSjcyS6pq/mJ
 Mv09M38W65VCwiZGdpGyOVtB4kGha0Hpafu5uv1u5/Spp6EgOCndMOxgVNmUMxUq7sVz
 3hRX0LvLx7rX/GjOJ3pbBvsC4cyyTXPfS7V6lhCwAUvkkRJuU1Ix357rSCjsUDvuRlAQ
 QJ/BkjMwcULaAmIi0KVXx56Dg/qJJGTaSrJYZxzC3IbqyzeQZb559++dcd4k1AA2naX9
 oN79HkFOEc9FDESj9IPZXWjD8O9bEsEIdnp7MYsYrPQknFJ4OWjFwCnt5DrvKVbCVxDH
 RRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205124; x=1784809924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3y0IvySJBouPRgIKjp+IRovT+WNJHA9QwSsnhwUAWFA=;
 b=VgRdclXVrkYW9L5m1VV3AAew4P4Hn8jKgYO3v9hTtsDGCoMylYySDTLUwUd2aZENA2
 ljYUK4Qr0wOvcVu7/jEs2rp3Mg66EDUYnHY+l5+nK2P4ampnZnIIJiZo4aL8OG6bS69F
 emaJh50sbcqaQplOI4gsJLWH9MQQJ8vwLMoQAStvaa+1sigjd1Dwv/K0YelqGRK5mEcG
 wx1qYgMTRJk0s4pS8BFSjubgeCEwugor2gJvVvuPPYb7VY/KVWM47bHA1tPtBYDUrPvv
 Z5EY3Kd1ZIEN7UUwOzMYzVKox/e7cMBXaoNO8nwpWeJVHfkbTDd1s03jTl0/Lsm6waAz
 hUIg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMJJZSrvV6IlNNfXBzWc+ux1Aty6tsDDwLRt4co9+3+XAYKx8B8dBWxxiwkrQFxk6pIKjHYfITgfU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5FZzqes1uVJjEUK2bVbx4BBKbbKxSpq6J9y83Tb+S+OQ1wS6a
 yujGaHYK3cjQoE00iDr1PxRPL/8eEProVacrdaK8VgKidJcXNSCkCdfca9ThkL7CW0zOU30SzAi
 OLvSJoFREoCUugCPLp0GNPrlFLgjqJ8/GHWUbllaoM47AWw9jG+k+gBrO28IpZhtyUD8lbfU=
X-Gm-Gg: AfdE7ck1IGxapF/6C4fXfKFD46LZT/E8wsCveM3JjhbZFyJbyQx22vY+dHLMnujJAGn
 tbP2Z2x2JqunWXq8Os6c0EbKDazzM4D8gnPkdQl4W/E89G5xAkOkRz/Ndq+jjuLnBwVQaDHOQri
 AzXKawmxKuDKrqsDIFDKsCjfyD+xTfaj8h2HBFmRoduKpciKOH2BUlRnisqbj7vflZJsmha+fnR
 ezqE6CUrTWCZZBKAzxSpged2aOH++mUUKk8oY+0gslQ5q5atFaEiAHtVR4/Hg/bZmbGAJmr6CB3
 /XmJaPk8HOMywbyrcnajK04TJf6AgK+1MK61vtcwmbN6QVkhAX4/m2ue3t8B+uoQfFrFnymZz6V
 MzNs5YRG0M4cdtisiGBtCJvEaesM=
X-Received: by 2002:a05:622a:5c0b:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-51cbf24a901mr225501991cf.39.1784205124018; 
 Thu, 16 Jul 2026 05:32:04 -0700 (PDT)
X-Received: by 2002:a05:622a:5c0b:b0:51c:7d0:7ed7 with SMTP id
 d75a77b69052e-51cbf24a901mr225501391cf.39.1784205123470; 
 Thu, 16 Jul 2026 05:32:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:76f:d108:485:5b34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm23766635f8f.33.2026.07.16.05.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:32:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 14:31:38 +0200
Subject: [PATCH v8 3/5] drm/xe/i2c: use device_create_managed_software_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-swnode-remove-on-dev-unreg-v8-3-5c2b8cc38c28@oss.qualcomm.com>
References: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
In-Reply-To: <20260716-swnode-remove-on-dev-unreg-v8-0-5c2b8cc38c28@oss.qualcomm.com>
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3182;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=N9AP3SYxejXwZhikmnovuItOtHN2XBZf83KApz5NXJs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWM84B4CZo/dOB2syOtU64FTk1R5pO8s/CZfq9
 KDb7tFbYReJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaljPOAAKCRAFnS7L/zaE
 w4uvD/4unAYN6h4orRS4Qx06lB5hF5W4abKelOlO+kea/N2ACPE1RjvtENYOim1DuqF1YYahceW
 0o/eeFpQVa+J5C3TuanVNe/pFfVPQGJmYinHXmdyzRT5OOFOkXtXB/TaFB0VNm3/sTYZQEtHTVE
 LdTtmW9sv43I978VkwcnpTqLvYd4mpgDTc40WpsbyRQCOkfb53h0gEroKzx9BRon86KnLiE3IJc
 wzoFo4yUOgEC6Lk/93fRpgaiBUN4wn2mzTTOGfE90abwQKNwh6U/Di0mGXnZOrMH3WW4Z7O0YHB
 woTuI6jlG9jzMJ3S+Bbr742Zyhwc7kxNA0aCmoKHkXF4bgYsTE+unyMIif8MQgP6/MhqLzuIfCR
 QLUxvf1+Ck6LtuSGuSFed5i9NiN5S7FJhgNh9qjOLlQP3LG/E2QsGaJkLNNOV/p2bbwXPlnU4+2
 lm17JZs9+5gQfVQ22itFzbErCzxV2THEmdjnCtkDI3vhjBwUsFCHMGlEY3iW9y7Azb8N7i8/JHL
 LSlPUnEdU9c0iBZj1AkO3Uedtoeuu1cv8T8WPgW41si1nD3+e28cK6HNkQXjPjs/Sb9/1lukAOV
 w+EKBHvo4kOcfVX/PdQwR5zepm2AhvHCXWSPOLnsUplcyLGcF4SjUxw+1pCmZqGuMgtrp1phMVD
 rKvLJIPfewBDYjg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX24I9KskAUoac
 l/osO+UqV+Itobr18TTlKuOGMffsgIFNY8lSsQcxGXFkFiPghfqTKztR+zuE4m/WjUjIDfcoZVY
 iGsBTto9Ik4H8y8Vq5Rp8EnAFAveN7A=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58cf44 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=djUoAwcJM79xP0FpthAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXwKVqZ7RElm7a
 /SkDKhOfAWyrjZ+9sYqd8iCh8F6a4ipFKFCX3xEwakrot3ExdFJQWVu7ynke/I+C5vNXF+hfgR5
 Si8VUZKsyJp0weZGK3RWpeBNibotKxFQCAHcrrGHl3bQLYWC9iXPg5k3XwGtZ32pflf+nCV7vEX
 08adIQSX1JAp4NiteTwugfiRCsNP8x7jmH44qR5wILPBIYGWHntPKHFMxaKpSqNe834bb0QQD2P
 6Oet5H6J7sqam1cX2/Q5OpvxQHnK8GAk2K9MBGmzf1yAPLGmlIW+I6ZW1njmCNASlA4NI5gx5KM
 74tnzWpg452yUqKXli8vY59WTq1lSAIU+hEaJ/9gkkUx7pUYrDjxFN9A9uhpalYc8AVm7q+xbYU
 Ld2dQtEiyPjFLSUpbzCtgoJ0zlZ9bzsASnFLyx6Eg3VTo2sZRS5+WbIchocsEOV9ArnMQUKey5l
 b3q8qukeVhpMYMi8+mQ==
X-Proofpoint-ORIG-GUID: 3tKHRFx9-sQ-6QiNjr5dw2eyV6CoZiSx
X-Proofpoint-GUID: 3tKHRFx9-sQ-6QiNjr5dw2eyV6CoZiSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160129
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
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

