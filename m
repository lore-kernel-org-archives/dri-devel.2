Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE877CD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6609310F327;
	Thu, 28 May 2026 15:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iIPAN0Zn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iIPAN0Zn";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB46210F324
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:04 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CIjK7Q0e4vUTPflX1Sm2MLWIXLq+xLSgZUtUq1JSHgt7NtBLGY/hLiJl9fVHb6QLapdecn7p4sf97pSgQx9U9XU/Z1M8/xDiilr0hU6/w8EEJeThNxtx1XsSJeFmq2s+bLdA7Z5EqeA297zWFA44X/xwq5Db6L01UIOoD4aQACidl60jJeSUDmj2zqRUorbRFChRmiXVm5AODDq3XslVborIGs/uZIHK2dzicjjStq2AgSe/YaTqBGbtQuqjLUIITh94OtDRdT2O2yALIPJtRy5Rj4l1r8TxkXvOiN7XrTOCo8XQIrrshRAGFPfQG0cmcm1VR+LKU/undOH7IjMTuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5yEfcRfOcL4cwGlyS8gwoplwDQ/pb0/5zcF4KocOSI=;
 b=iaDAyiXZn8C13iGLTLmhI5FpikhS5u6S0jXnGDRQTgje/l2Q9DSRedna9NRLgozHesXhUpJ/WS43ItpvvsDJPhX1uvhj23QLWhhk+l+S5uaSic6eP0RCmv8eX0zsS4SVuuvFhrkC82BGRDVR6j1sVGoE2TR0OKYbxP3aGOdmKGEwNl1wJ3ppi8R1tfLDAaFV6lmnxTbOQvqtIbN8qQUuX9UfCWrPUZbpZGQOyeYybXnjpMeonJbUwEcPZelSVSXKoLq5R/toIdFYN3hfrZZ0d4e7A+EHZa8OtGNNH1lJebjcn0lGjWypVClQCDhy76tDIvT9yic7yncFpjO0DveNJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5yEfcRfOcL4cwGlyS8gwoplwDQ/pb0/5zcF4KocOSI=;
 b=iIPAN0ZnF/FoIplxRb1cKncAjBYMwNYhtcmLfx8wbEi7e7266lvo1uiAsPnDKnUjELpmiojn795KTqtiIUfcNXvI4ndljH/Re59NBAuhzOv/udkyH5TBjZD/6HSuZCDKjuVuQvVD7lrmKXDEIVSJJGFd4XhhWsxA0MX/AkbRhE8=
Received: from DU2P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::21)
 by VI0PR08MB10684.eurprd08.prod.outlook.com (2603:10a6:800:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:07:00 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::5b) by DU2P250CA0016.outlook.office365.com
 (2603:10a6:10:231::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:06:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Thu, 28 May 2026 15:06:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2oJKow0EaHn3fFNhMT0j2vf23eRuBzFLm1KqzPhWOevm5/NGXM16ERctc9JNLEvSc3Wb4IgUAo5doIrcT9Bn/QM7Vj1hSXthK8+Sdh6BM+6ovZDYdXAI7Y4AEQhX4zlrhrFE8HjVwf4g7Rz+qxPB+zDaVKYztrKtP53QToAtffTP/CDtg7yhbhH6y6W3vyHL0VzJN9wjKtTyPfJiMbAgLyoLv3D7nlSVC0F1fXrgqhzfzAtWjVEyJUKjOLmZ7E4u0zWcITRO2tDG0QBj3dWYNIgsKsfxKyDEEojHCEXx5onT7B7ioi4bZa70KzmGWsyDyDwWdVNRFaXUH8LnzJJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5yEfcRfOcL4cwGlyS8gwoplwDQ/pb0/5zcF4KocOSI=;
 b=lazCvwBcwi6cawey8F3XIbNI+tafignggHUt0iV5Tf0HtMVqVuPsgWoj1qpq1fl4TWQkVDPjySAGI9SHBTyX63NldxtElYyo2D2c8jXugQDmBygMqZRYJIPQoqh8xTtF9mJrvzYovOtwpy6KaUznrK2l1QSqsnFaVtFCRR0XsJTkKczXv09x70o3g9vAjbqAqws18eLK5wAkw/NQumL8BhIRpp4CTGeowNWmp4XuMo1mIFjb+TWi35qVrnDmfgYHz4tQDCzplRxhKEq6so6V4wYDff4w1acZbbNxP7dNJk82cmc4nacxIAqxoI+y5AyysY+85UbNO8bRUgORRnWLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5yEfcRfOcL4cwGlyS8gwoplwDQ/pb0/5zcF4KocOSI=;
 b=iIPAN0ZnF/FoIplxRb1cKncAjBYMwNYhtcmLfx8wbEi7e7266lvo1uiAsPnDKnUjELpmiojn795KTqtiIUfcNXvI4ndljH/Re59NBAuhzOv/udkyH5TBjZD/6HSuZCDKjuVuQvVD7lrmKXDEIVSJJGFd4XhhWsxA0MX/AkbRhE8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:05:55 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:05:55 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/18] drm/panthor: Ignore -EOPNOTSUPP for shader-present
 nvmem lookup
Date: Thu, 28 May 2026 16:05:29 +0100
Message-ID: <20260528150546.3168527-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::8) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DU6PEPF0000A7DF:EE_|VI0PR08MB10684:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fd499e-27d6-4730-03a0-08debccac416
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: wZELnWjoQqJYioLshouAJBtEY1eaqBp/Sir4jtUsnUFgXe8dUx7Ooow8pF14OjERa+8vdN8Q2BFvzj5CJI/EK7yVabv7mYnkTmamfZqekQR9EcBhoESD+uZ/bMqmMiWrEV2riHO7R033AOZs9Jz/SaO2n+1iQdez8EKl1YOBsFsh9zji82MrIkCjX5fBM+FOCKHX2PNPwoaS+u+Pe0aAzizidEvX1sBi74WeKdkNqJI3GyYv52KqcZnEEXr6J7fF8VyQjarxaE+k/zbnbTMuzT7oYvH21n5Okn9s5dENmp8VmLvCJZdP6Ot9fU9821mdkgtMCet0son+zKpbCSGflichCVn7aTC9/89w1MempBlB+gsruTkygmq0PqyRtrWnaA/fXYUT6MsSPwKXTiOA8GLQc6IP/V+Xv71SQvOYT3EgmgawSHaYDlwCLh+rnj8hIHV1p61iPNmqQi/3Cu9KyszsZ/XuzWG7UWu6UBMIfKHdciGEDxZvvtVCj57H7EZuVHcHviJksp3MFv34WODo2r7ceZe4rWTf4GBDrVLkJ1gCl8h1UCPyKBs1zln0aIEpUE7FAvoqKxhW2vajBVGiXwU7f6vOHg6YpO86TemyZeF0qYVjEtRhyk/9B64Qzjb5EzcQs4KUQRiPwNlQ87Au/iLcFL9l2+pCDrzTVzxyhT6dpWYbbjZ5OoHdngjGL2Qd
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YA+NWDTjeBppUe3FZ/D3OlbViganzeVws9bhSXHgp6ugtpyoac34Z4lUP4ajAV87Geho5VMSzAQilAs0+WXAjd8dfMMhul1QNKhxpnYcwzP2KNKGsSGye25b3eI22P7iSWH5Ilj+am4FrTwfq7dDphSnwBJsAtxFBIzoTAnnbXg0+1ScQUQCdIZg4EBBm2tp+mAuGvHfWmA9Q6LXLTtcEtJm+zELqDBfoh53MQZumQ9ahQfUG5jtbDwmlxUJVunk9RSSJsYC2oRMi50ukkxJybOSymIFu19AQc3MKPXtMOB3At4zztNwwd+iQO4NUTHD0RNy+UYhkz2YhbIzb3SlpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6fb9319-ac0e-46f6-59cc-08debcca9dc3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|14060799003|1800799024|35042699022|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: N0hVULT+DQT3ANRL7yLwjGkujmIGXnwOB5NhwA6yyxuDyZgivtpFaxPmBSHkrWuf0nG4z6pwPcZDKBhofS9sFSzUsLx1UZgKDk7M9NyQe7ENmZ9LM6d8DpiMS9Zgx7DHPoR449y0KiHNeUmL12W39/YWIzSc1yTk+Nc8cCt/Z6wX0uZ9GOHp6Vh95LxW6k4GVLAIeq8lQxw4k6q2nUa39T460LvX4rfHUCeePUmZn1GH/zpsvJRA9VwAOwg33Hx9TR4azDpnOogWYLjYKTgs1doPPXHmqiko/ie3XAt6Dox1WQ3bCFg9TexKOeSYUlWbi/ixZACsR46GcAlsSYwfxOv0NBrB+0Cbin4FD6yPUE3xX9S4Roz/c797DmNso8br3v8k4/sAyuyrTuWl826CLMqqJflVxTTJP5DDn+eMGVQQeHgt02j6j9Wn4fTTtJTvtiT9tS4Dp05EIs9Z5anjQnUFxKv7k74bHyPRp/uxTSKFfTE/EJtkRpmq0abtfnL3E5OQXrOUdo/6xXzc8qs6Rq7RPCj0vfbQ4UMBnSEXmsGGaZwxvZXf9pW+hs74zVbgmTQ0s5+mpQd6t57V+ucaZ/mT7oVwF25/zTa68WPGJUrcUFmMNo3gacBe244tctatUmCg3jC6ZkzLPrGL29ybN17H2qMgZZ2dTS/Zv6CkruwDHE6uHtiyX6xlCokqFNoOMNsU5URYhoI/fviXt5svwJrQO4ieuJTZjA6Q/o00UWY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(14060799003)(1800799024)(35042699022)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xqdbKo2OPA/WKw59fgkAaK7uoMqAzWCdj1ahcDNPanhINJLMNxv+T0JEZzfKEWyW+utFgC+8Zu44Jngy09Vh5kD2IAgLYf5W4Ut9zbGJ59QKUjsx0ie6ikiQVDjw23hJ8ZwhnrKc8WNfsgjWqiREb4W394YFFNWv/IqiiXCfub2bKeWZZ21UAMlcMIBlFenctAWCwx5n1NmBFFo8w1Mywt5m/WW7jCG4LHy2uzgXROMFsX4N/SBQ1tzehaein9UdXuS4Z+IMEC+kHTcdq4LRjWHhd1nCF1f8I6U000fnili9KAqcjqKWCPWlEDev71m68zGPmSM6lIHx4oLASThyiTH9IpGdwmbLTV9ziWsXyr8vX2Y5ECClnBkkm7n6Bsr8FOJFQYaHvv0Me0BHGBYNC05rcjsSFMrlNOuB62eCVLvdYEO93qgSLLwebLDt7wc2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:06:59.1400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fd499e-27d6-4730-03a0-08debccac416
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10684
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

When CONFIG_NVMEM is disabled, reading the optional "shader-present"
nvmem cell can return -EOPNOTSUPP.

Treat this the same as the cell being absent so panthor can continue
probing on platforms that do not provide shader-present fuses through
nvmem.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 7e315708ca7c..4c96573b649a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 					      &contents);
 	if (!ret)
 		ptdev->gpu_info.shader_present = contents;
-	else if (ret == -ENOENT)
+	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
 		return 0;
 	else
 		return dev_err_probe(ptdev->base.dev, ret,
-- 
2.43.0

