Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6094ECD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F6310EF0B;
	Wed, 13 May 2026 15:05:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jjREzhdY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ni9Gc4Sg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB4510E5F5
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:27 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D8rL3J4082617
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zZ7Vcm/EN9v/uD2FdliZJtDXsSCe0ecblDQ1EGsR2pc=; b=jjREzhdYcb6VMRDW
 G+ocrXt1WcQle1bA+brk7Wxm8ClbOhn7+U3wGMUH+OVNAWgEK0s9k7/u23yLWp/T
 RVym+iK3PAoAVY78FwDOnqD7wWCFFGjHeUPdjAV31HymQdLGvgV91zbeR3NQfuvR
 gvTe7EdwlaQ64Wsg+NTGYeCRfVD2x9TbMXeP6z3neJDaPulHTS03/P6Z/VUKCMxy
 R6Ax7yoRrxQMEZAHP3L4dMRoZG+NtCir+YYAxH/VyC1TqNePT8M01ohXuN7ZUzu+
 hxjjVC4doAGWcN//vEKlSY0Hi8A9QpX+j6bK3ON3+5/WdTFC/J/+iIzKg91Se2vR
 9eaM9g==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p6e1edt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:26 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-43013bffd49so16792610fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778684726; x=1779289526;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zZ7Vcm/EN9v/uD2FdliZJtDXsSCe0ecblDQ1EGsR2pc=;
 b=Ni9Gc4SgoNe6EVQPb7rT0r28QYOjnnZ2C8ur3qLeyBOmaAk5/rEMy5vz0iAoqHgLt7
 3tG3p7WTftPvek7qtQa1J8vzJ+AFvkXgaW/p5qhXRSA18XJf58qluLaKnS4gHWCswmqq
 xnxWfQ2G552qysZjqWO6mqjcXESJqIhU8g1joYo3C0rcZKWaA+llLPgC8OrjBcBibAcl
 ZjW7yTlKkYptNJRky1Yn5e7uy4Y1LhUnfnpIH0Wdj5kG6fBpAojaT88/Ety2PgnL4auj
 SQAqhuo2oNZoMMVIHHuF7WLJQw0QrK1hI52na+Rt/VTA1wKNRO5TzYWAd+rB69L9kqH7
 jZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684726; x=1779289526;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zZ7Vcm/EN9v/uD2FdliZJtDXsSCe0ecblDQ1EGsR2pc=;
 b=rg9zNtKoQws4MD1lJ9+zNky4S/6O9pS/KStJwGBy/Z9yjduWRRkvlqysPrEGU9K302
 ulo5MTNwkb+uKF70pbwG4bMUKj2drOkfBwmGFX0EX3qc21egq784/ob1905bMtYqjPTj
 ud5/nZZs4ZuJLfNW0OatHYr+IJzUNsHuR76eoE0JtZlHTvVxGexTNG/FXVtG53LfunqS
 S+uz2DubkjHfQcqO8ZvrKIoQ8m/2tmtLtzPJe5H4bdQuXyEzi3X80gEuFlkafkibygtH
 2bk+utJVrfafiLilWLe0b1ymDahykkEs63C7POtrr6xQUK833THma1lM956zODMQUxAt
 iWog==
X-Forwarded-Encrypted: i=1;
 AFNElJ9j0HHo9GOZJrLAKdiiPKH8JBCiTkQEjwjjOuO7hM7o5XH7cIsmZrXIUf1KBMs4EEbCrCdvk+qpZZk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAYy/gHG7B1Bl/8bU0efVOkg8oJrb8Sk1vhI+CzNYmMqP4yzB2
 LieodFji9uZPmGk9kSeGUxVRucVTYt5kg/10T+lRd0Ebnhboe4ho8AyfxRcZ7RaS2zE5rzdxWns
 s7GMS+jKyH7aE69UG2GkkDRoI/8ugbyeLfqiZlHKV0kq0Rz94ZWcmvn9i8jshtVBwNbct4Yw=
X-Gm-Gg: Acq92OE+j+yNxhFasxZYC/cGy31CciijWkTMB3Uau7LRt/gEm9POJmKjURfA7GQmGS2
 /sjhxANYDijEeN45ELajEBv5ktKTflu4LNqcFTWWQwqJDcTuV0ndHVe7WEb2dV+wnF40S0Whkvu
 jxCIlw4QKRfZ/8k69prBVFwKWgOZ1VcwyvBLRjxb2ai8C1zSwykOeZxfONLbfk8cQcMhr1EK4A5
 OqpmamnmV8Ztmu6M1x0qsuUqX6uaU5Tm5wFDKqxUPfgSu7nXu4d70hi7OjgicY+SZDN/0CzBGEI
 O6Y4JQI6nHElGgBZ8Oq0M1+y+8FAnKo6Gkq7M9gAaoyfHRwZq3gKU8sDpBY7LmuzoBIaetNZD4E
 pHeqeV59aOkBSFYrm4ADUC+lZjON42yMOjsXVNJUBibEqIx+P2Q==
X-Received: by 2002:a4a:e649:0:b0:694:96ea:dc7c with SMTP id
 006d021491bc7-69b6788d9fbmr3446729eaf.38.1778684725992; 
 Wed, 13 May 2026 08:05:25 -0700 (PDT)
X-Received: by 2002:a4a:e649:0:b0:694:96ea:dc7c with SMTP id
 006d021491bc7-69b6788d9fbmr3446719eaf.38.1778684725508; 
 Wed, 13 May 2026 08:05:25 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:63ec:4acc:c4f6:423])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm43216455e9.34.2026.05.13.08.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:05:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:04:50 +0200
Subject: [PATCH v6 3/6] drm/xe/i2c: use device_create_managed_software_node()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-swnode-remove-on-dev-unreg-v6-3-f9c58939df27@oss.qualcomm.com>
References: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
In-Reply-To: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3054;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=r5CorKpog6XK7Xw7AuHmiWjyB7Vw/HEf5JCJbVrapGo=;
 b=owEBbAKT/ZANAwAKAQWdLsv/NoTDAcsmYgBqBJMmq9JW0v7kRFlCKa3cQX1e7fyvU+j31gEFo
 GPWtnshMziJAjIEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagSTJgAKCRAFnS7L/zaE
 w0kcD/j2A0ewkNS2bCevVPmTc7c9OKJ+dLjh+eBcqW93BRugn0nF19BZeEPkdpJ4d8JfXxJOl2R
 0yRABxbWvBbxIAvu5Ciq0Q/lk32XMa6eIgh9i+LRRwbdDc7j4i3L8TQVUz1e/OtOJI3UuAEx8Hf
 5IW8XAZDv2Unf9peA+4En+gRC9RdwpQ1GRG49SGchp6jLdr64eWzMpf1kz8WQQbuTfZGPcq2ZRT
 9WmLXhdT8d7rwlOPBCkaQADhzAcNNOJDAdv+PPXi6P7nH0NObPzaYPBiSbKG/c1fo3OZT6hTDUI
 f2TMra/TKercmXMDbU96CPWQJunrpCUNvQsvD0y9yWpDo3F5S4yE2vjeYQBd3EdBOCcHtEHjX40
 TVsIMjUcQbKJAQdGI0Q8UP5BQoCYOGn1rUFBqRQROZ2D4UOyLzAiPQHqN6sKbAvHrT8xSxUOrRi
 IvDG2wJbh0FzEW4RtFzrEqwBiOotHHKQ03U8da25RuETsDGT/vEMmw1/Ua4JuNVPtC7DIsJvVWB
 zCtYAHUcHDnJ3CP7KR/wIJFcozrxpsLv8fX745KgB25rR8Zlg5i19BqJhRlEOLoIJg6pbkzXepT
 WLDnxY0wJWesAgedGNBSuY2MBYkfToT7EPADVSY9o30rdCXsBTr4c5QeYu4cGDyVAbq92CJVCDU
 9ZFoM9pKhvtc4
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: GRU5BTrsP5LMq9vevWaidzAHRewGxssu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1NCBTYWx0ZWRfX//t7edL9RtjM
 SzO4tsiyfyupZiatweFY5lRfdbCxeI6pVwfFjhXFq57uWFGEbjJf5WFzj9x/j5jhcOFHP24etY4
 VY94Hbqn7HXK/wWRYvVxcGu3HH3be6hr8nIraU81DcUcvyA7XhFW3XwSuzPQ4lUsk9DXIJwjyij
 cqngsIATCgFXG7kvZN0zeTVSrinp3cvxQDh/rFjVS9HAsghE7qWQGCxr8qO887NfnDFvuszLWwt
 mK0wTO+TDLtV/MyOKe1/H1kYR6igNmVFKpubZF1DBwHY8E5j0y+L05qSZE6kt44IfrJD5+DuLnu
 rjlXll4SqFV0YzJOZUDwRbYfe18SeKLDv2rhl02gFSdG5PF488xfusB1HShh/Kvx9egKjc3o6ZB
 9FNBsfRKaaE74TKW5wT8R0cMMM9imaa2upQZssIgRQBcRTDmx8iqGFtTeSvsVDWGY1H757tN6+s
 pEKxdTzo8Hd460c917w==
X-Proofpoint-GUID: GRU5BTrsP5LMq9vevWaidzAHRewGxssu
X-Authority-Analysis: v=2.4 cv=Wukb99fv c=1 sm=1 tr=0 ts=6a049336 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=CQ4qV2wi1td1G5PDrAEA:9 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130154
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
index 706783863d07d66b4685005d6649b3cd143ecc3b..5b0026bdb1c609bac12cfa1453c685846f3b731b 100644
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
-	pdev->dev.fwnode = fwnode;
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

