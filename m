Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C58C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0908E10E6DB;
	Tue, 22 Sep 2026 14:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9TXE5IL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NEwgiRN9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04CD10E4AC
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:26:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBPSO4269080
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3JmyIY24F8C8IjLYIdjk2C
 cyA3Gv3yLu4dprwtaTmUc=; b=L9TXE5ILrGfghJtT4xEjVDZ46ThrZG6E4LZKJz
 Qb111RfWQjBnUPu1kmmUBt8H+rSY27YEHBr6P3DQDl87g1khKR1btm4ffVHcjV1V
 2znmQ9mWEqHxP110CFao8fBrQlMWhp3fTDab5mHygGwsEUVpQTEx19DPLuQC8OZe
 koc2+2klIQ75MAbl0rMj0i1Y8WyRS/sXMa6NSFZauEwlxBPaU1NQEr5y1MsNawfo
 UpIfW9oe2PDG9IUi48OBeP7Gru+Bva854pKjcGqvvJD0WcnRUZlhN1HetxxUouiX
 QhmfB19BwKfz9wSzAMf9JOdTgcGGFZsUPzLzsPgG+QCj9O/Q==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbau70r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 14:26:08 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c9c3e00e8dso3584898e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790087168; x=1790691968;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3JmyIY24F8C8IjLYIdjk2CcyA3Gv3yLu4dprwtaTmUc=;
 b=NEwgiRN973PLGgQG+ea1QDFm6GFKGTWusmvf5Mgc+oVPuR3ee8esuUgiXEsDiRoATJ
 i48lQPHjjKc9M5gqzgcRTNMSYKA4STeGzyV0ZAVTAeN2TihSQatsVOfIvIKM7Rtxvv5G
 /QN8KbQyQf1f58+dqQfm68GtYutLLg9YwpdoNynd/OF+5i/OVkb8hej5Y/IL0Bl99YVg
 958A3uotwkCG63z3nten88lgSr9zs7uoV1yCnU8R0uhhQ61i0Uq0NoO/wBq2kq7YdM0e
 kDDK5JQWcjBqmw2dw9KKdxO33TuQf2GvH8Dpu6C4t0uQiXDx+y0tKdAK4wNZD2mZjO1Z
 kDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790087168; x=1790691968;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3JmyIY24F8C8IjLYIdjk2CcyA3Gv3yLu4dprwtaTmUc=;
 b=ICbn9a66bR1YKiMGdzfjPx5QCye7beeUcHbsBwbMZMnqG21fbU9s0BDgFA/34Ei00Q
 w2EtAHUqQiBxWqqltKYMh11B5dMUZ/1lrndCny5pWxktCuKZklsMe5pj9DP+8BmLD3TG
 XoY/4RlqRqQJ/GTOzzL4yF+M2ln3mXURNrKJbADu/WmVumz5WNg8OrMv8kMPsglf6f/u
 QZr/IQl/eJrSwOCeQcmfcYQlzWShWumJKul1VNJTcUiPzb9T1+LtmZyo8d4GuidP4uR8
 dy1xOxGIFEUXNfGyLZ7/qCkWhMUCc8+TGG3j9lyWVk3P3Zp528v/BK6cw44Far4fxEKl
 Kpwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlXxF/R74bjNlNm4p2GcHhWqhDEKI7xzLRj+mLCYzuF96Qr25MNoeioUZqKvkg52+Lj/NxR3Mm4Fw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQZKUk6zD4lozSamPa6FzD2fckTS13xIgRzZMvPNdFa7IcYKTP
 JBjWRmtT8z0I9sQKmlWjbrGDCk2GCjZLdxmj0VzGiPv5pvQtu/B73UMfSe7zIX0mQjbHj0PqnQl
 mmV6luLzH0etQpc7XgCLw0EJka35KxOhucXVGRgzujxrrr/dusDdZsaaqoTEMttAC3edhegA4FK
 PMlMQ=
X-Gm-Gg: AYBFou2+85LOrNf+Mf+ayNw9Ee07JbEsjwokjvCzY0z+Rjv+WefIlmI5A33waA3IGH+
 lcciZcaVZwTvNGg8gYXuPtX4mtHkrUo+a7ZVXoUE69fzxrxaIBdKPb7rxCnDf2C79Dpnk/VQYga
 ztIDi2LQncjjN0EdiWM7N+35b8mtZwNJyezN7F1+KEh0/dHXcW7I8qlrcPYhKzVMwDSbm8G4Dyr
 yvZvrFfdQzwkDfO7/KnClDTuwwAJbgpTpiDKvFWFTkOj8LsqK/Mr2oqjHgNV23zeTV5TGpw8C3G
 pKtwrj34erZRJj9l6+fD3HdnJIULO2ZzrnGZV0mLMFVhC8UaXZsp/ro2tc+mx09lxl2gtG9FITq
 AGul9O8q2bzVk5gHOuBbLFuvIJv0=
X-Received: by 2002:a05:6122:54d:b0:5c9:c60e:5cf6 with SMTP id
 71dfb90a1353d-5c9c60e60e2mr7043205e0c.20.1790087167805; 
 Tue, 22 Sep 2026 07:26:07 -0700 (PDT)
X-Received: by 2002:a05:6122:54d:b0:5c9:c60e:5cf6 with SMTP id
 71dfb90a1353d-5c9c60e60e2mr7043154e0c.20.1790087167349; 
 Tue, 22 Sep 2026 07:26:07 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46d688asm614388e87.41.2026.09.22.07.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:26:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 16:25:55 +0200
Subject: [PATCH] drm/xe/i2c: use device_create_managed_software_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-xe-i2c-reapply-swnode-unreg-v1-1-1bdda5d44701@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPKPsmoC/x3MywqDMBBG4VeRWTuggynaVyku1PzagRLDhHpBf
 PeGLr+zOBclmCLRs7jIsGnSNWTUZUHTewgLWH02SSWPqhPhIxeZ2DDE+Dk57WH14G8wLNyibkf
 XiGu6mfIhGmY9/vdXf98/XF2JlG0AAAA=
X-Change-ID: 20260922-xe-i2c-reapply-swnode-unreg-8e18b542549f
To: Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 brgl@kernel.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3382;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=co3KpfoXOkXb/GRzLv0HTKkjb6m7GSuIDVBu/y3ylZs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqso/3M9Q1bwkAONX0kl1pQtLkBocI0y7XUIR+s
 JeDqG1uqXWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarKP9wAKCRAFnS7L/zaE
 w8kRD/4w51oJV/PMNpaz/cY99CqRk6WnZW/zyXjeHh3A+QbmnwZ3iRJjyrxrCo5GaN1HUHbcmg3
 ncI1ahrXVIKpzsnyheuO3Je6kurUYMjhWTVrSmbsECulli8banZTbxwXVlPqsw3azIQaQazKpX5
 PBtOYC4fqXsiLJJw6UqSDw1uTt5b4WY/7F9zqyzVN5mt/KwNZfIrp6xqVrs41Ua9968RNi71KoC
 Yfjufhegd0zskwkOoMy8UEDeqJVRya4l91kxnaYdJCJFnavE4+G30cHGVh4vbPWnHzwKN7ooM5K
 ZUPkiYWJjmC5J+ckMFvc+tXMFnBGAGZFjzEKZCKK5GlQ74CgdDFKtzdyYUsWMy9JtZoETgPmKNY
 L0thHzQ5+QC56u4OVnVXpnv+muWWaXMG/wkOW4VxwtGNOXL57g7tAHpuIMpj+3JDVps7y0aKtnZ
 VH3hvoTWM2UonrN0rGW/f0xugJHc3lIvhq2jDUsKmj9MGm87My27zN+5a/VXq0fUzuepvo6dtzb
 sDk7fi05AewueXZh8DxYlX3AS3mroloCBRUtJ/QL/9E82YiIZa/YX7dgWap+SetEDOugWPwEh7X
 OlKp1K07+V/02gX03ulPC5iGGtj4ddea4zgqKL0P4FNSYzGQUO9D5/s0GE0Eq6uaFf2X8WYwvwr
 PKjY17MBC8f3bxA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIxMCBTYWx0ZWRfX+CkBXHddFOaa
 4beONVZe3SMDZFjv4z7bDBFUsujfVshPBk59TYRlEcIUNGWnifFlCDC4+QyhQGUQGZ4tF+u5DDd
 51Sd17AIsBiqXrfwAP/ZyABkjKzjZcyaI5UZE3UI5evPNcWeMA2tLqc6UKhiNv1lFTQ5ro3oA2o
 t5JHpCb4i3cQT5vPZeYlbjdug/uQhVHp2uMNxXfWAuLzgLq8xc2DDhsc0pPTqVka/Hh/HdS2olm
 I0zP3wvBuyIBnglILoK1ziUFHlu1CFbk8R3pMRErAdrW7V4nCN29WqzcnVuMoONRg7D+ZnzaV1F
 zgN8PKQCxYftDau3KT1a8evD+yEhCcGunchve26oChEtqQg2jGQ3TqDGSFqhzyIAc/RaykueIdY
 eDNxMpUSbq8Xst6sPeKd7ICkOkpTdUwLIWusQ4bYHi2NeOj63+Wds6wuPi46gdSViF+c7qGshas
 ZtPdsCL+X/loPdsgKLw==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab29000 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=cHgwpQrU5eHkzXlFMnEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIxMCBTYWx0ZWRfX/czXtMrBzf0y
 9IUNlfVmD3CeHdlpkeXrcxWxiQDgQMtsm+gCGG/f8L73c3aYRCb4RujeGZGHX8afarL8AtPOmSr
 mvaqGcQnHxhTg3Jo2d3r1fAosKtPvGI=
X-Proofpoint-ORIG-GUID: oUhaGSoU0jos14mI8ZQkEP9u2E_AoojP
X-Proofpoint-GUID: oUhaGSoU0jos14mI8ZQkEP9u2E_AoojP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220210
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
This patch exists in mainline as commit fc90ce2d ("drm/xe/i2c: use
device_create_managed_software_node()") but the code got silently
overwritten by merge commit cc467969646b ("Merge drm/drm-next into
drm-xe-next"). It should be reapplied.
---
 drivers/gpu/drm/xe/xe_i2c.c | 22 ++++++++--------------
 drivers/gpu/drm/xe/xe_i2c.h |  1 -
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 51ca9fb73b708317c5dd8613d0ba060b8dc2028e..f4f3819882897f7f19a7bd3043a936e3c7eec553 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -111,14 +111,9 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 {
 	struct pci_dev *pci = to_pci_dev(i2c->drm_dev);
 	struct platform_device *pdev;
-	struct fwnode_handle *fwnode;
 	int ret;
 	u32 id;
 
-	fwnode = fwnode_create_software_node(xe_i2c_adapter_properties, NULL);
-	if (IS_ERR(fwnode))
-		return PTR_ERR(fwnode);
-
 	id = (pci_domain_nr(pci->bus) << 16) | pci_dev_id(pci);
 
 	/*
@@ -128,14 +123,16 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 	 * platform_device_register_full() is done.
 	 */
 	pdev = platform_device_alloc(adapter_name, id);
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
 
 	pdev->dev.parent = i2c->drm_dev;
-	pdev->dev.fwnode = fwnode;
-	i2c->adapter_node = fwnode;
 	i2c->pdev = pdev;
 
 	ret = platform_device_add(pdev);
@@ -146,8 +143,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 
 err_pdev_put:
 	platform_device_put(pdev);
-err_fwnode_remove:
-	fwnode_remove_software_node(fwnode);
 
 	return ret;
 }
@@ -155,7 +150,6 @@ static int xe_i2c_register_adapter(struct xe_i2c *i2c)
 static void xe_i2c_unregister_adapter(struct xe_i2c *i2c)
 {
 	platform_device_unregister(i2c->pdev);
-	fwnode_remove_software_node(i2c->adapter_node);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index d63adacfefe71b3ae695987f104f978959a7e2c5..5969054a6b6b3f184857defd4ad3f6489f05aca0 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -33,7 +33,6 @@ struct xe_i2c_endpoint {
 };
 
 struct xe_i2c {
-	struct fwnode_handle *adapter_node;
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];

---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260922-xe-i2c-reapply-swnode-unreg-8e18b542549f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

