Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AABC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9279010EE65;
	Tue, 22 Sep 2026 20:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JGihnI4u";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JGihnI4u";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2135010EE70
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:48:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BRV5a23pIK4T3p0Jy6DM3Jt8i6M7f+6jX91ELA7wkxA3PYnFQphWFcuDnVRuubwdLu4RWHp74FqOrxYujLMhzfrc2Bdg43yn04HFI9AZQdSXp24IY8DfgiFu5VGkbGW7BZGSeR5/QDxT5wRZf1v0gnVVe0ZLJMiEnFUUkDA+KhNCCzhJF43VzZ6eYXOA3fmgqK53/33vM7pEGDzme8m3jwBB04iBPfsJmObdiRqMnUw4XVwmmJuAj4mvAsEYAdGm4lMPbeepITEmbXxeS8ww7WoEeP5mBaTCXL8H10Is61yLqvYvViyQewRMSy2c0ovKa0I2hVCZ+8QK2pC+KZ/MIA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8zpUBCs6S8jyxcO+TkPNfL83hLMkh2nufCCILC9MDs=;
 b=Tf3/6TN6PfFz7r3bFZyFoa0ys+g7vbe1RDMfZ1Pomloo6CXN9eeGAsTu9gWedTrDy2RxkHSomutWE95WGf3sjAmJXCzobMrcjQ2Dm375mKIeEj0XQKHEGBJEQX6bpHLdWCoh/5P4AeBAvdzMe6e/jod7sSuc5EwnY9z3QMiE47Yhgw1w5+FM5JtdrvtD7uDFuAGOpJxpc2XSzbcSrkIaRVIx00R/wxmo3rntaet5ikw/bWF+NYx0hKPiD3uKSN/MqoJu4/EPa8XUSt2LMGrbOUvvVLl4ULUgPa1XvlxkcyTnl0F7KUoFyrtgm+3y/JsKvhacfbJe/EqMlB9TQtE7cA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8zpUBCs6S8jyxcO+TkPNfL83hLMkh2nufCCILC9MDs=;
 b=JGihnI4uaD8kLQNqcgC1F9Cwb4B0++bglpbh1rdNznbDpNl9hgcfheJ7YfQ8DAJ3iXt0SeiXV2lCuZ8bte494+5LIPKhKFMtn8RiLkR0VlmVGwnUvuIyTcWmulV112MQSwVG0qgRRqZMBbdsysyEYio7QWJmUp1Es70yIX7ZHaU=
Received: from AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::36)
 by AM0PR08MB5379.eurprd08.prod.outlook.com (2603:10a6:208:182::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:48:12 +0000
Received: from CPH1EPF00000529.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::43) by AM0PR10CA0026.outlook.office365.com
 (2603:10a6:208:17c::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:48:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000529.mail.protection.outlook.com (10.167.241.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4773R0AdhXvrMOoYkMGZr55HCIzg0H3f3oYFqWrqXj9L6VbBL0fXSacYfX45SJ2FQnZ7fJuPwoxYmO2FAS7M2TFAQ1sCyLMAHURUigEkElftGyg6Qr8rtp5Xl0CwqP+h/ZGL3Y7e/dXEgDqGczO0lplGVum19jFfQli8n8FW3EEcznyJs2LGujFE7fzdYFIms0Sqph7NUk6GjSW4Z4x88VwG5zC9v4+AaSXMakBsxccU+u8iTc14ZPdzyW1BJYO7/+ZRVV4UIwGQb/4IvFf95XT8HbvRKP4r8c34o4/ATpuFuq6K/baqbh5W9w4puEQkyP3j4JQ9tJj127BVPvxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8zpUBCs6S8jyxcO+TkPNfL83hLMkh2nufCCILC9MDs=;
 b=XKVpu/TlsLhwB8R5RDt+S4bSyVEoR3HC0sXfazmRDIT4OiY/b3pDJ/WHYu1VlOPIH2izj27bnIJI8fOVfQq04tLTtx5RxtNsYJg5Gd/FE30Z4KkI0/tvU6/Ikg30AHAAKEI16//CZfD/fIS51vgdtT0GpyNUrAiUdL/KO7O+L2uuq5mWjQbWTbxHfqNhVfRXrB4Hh405AC4xoN8WKOcwqyWPYyoRqLZTHYwr2YCHwjcjcgtmJU15LmZ6wj4ZNw3ftrq3jZEl6JJYIdsDD5rMDWSItinMYRp5uoQBTZ/UQ1am5bF+j0IwTlhx594A2QijXQw0AO0fhXIElCpY5hXO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8zpUBCs6S8jyxcO+TkPNfL83hLMkh2nufCCILC9MDs=;
 b=JGihnI4uaD8kLQNqcgC1F9Cwb4B0++bglpbh1rdNznbDpNl9hgcfheJ7YfQ8DAJ3iXt0SeiXV2lCuZ8bte494+5LIPKhKFMtn8RiLkR0VlmVGwnUvuIyTcWmulV112MQSwVG0qgRRqZMBbdsysyEYio7QWJmUp1Es70yIX7ZHaU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:39 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:39 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 27/27] drm/panthor: Release GPU access immediately for
 out-of-band grants
Date: Tue, 22 Sep 2026 21:45:21 +0100
Message-ID: <20260922204535.2850094-28-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|CPH1EPF00000529:EE_|AM0PR08MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfdfc75-c74b-4f2c-490b-08df18ead125
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: ARVTS+Oh5C2X+Kspq/LbErMPYYnYs4rSXNBtJ0/WATIOEux++m0SyrUWaCjk/v9FPqOucrORJOBvcZ5Ndqo9eOTDwrX/u1SfrkIvA18A5MxJFQFjTGCrouseJmlpDbod2W//yelnyObqT2bOtNhjke1S4QHTsZ06vMhYlaLJ5WWgwcLPnqGBluL0WUygQHE9eDzxprwgqPcTB28VU8+LdKynAXWY18byRlCrAuQwVE57wdO4HdTUM5Aw+IxUdYunq7/S9AXAtfagdTtTUZWDu7VzrrhsjcE6UoX4LEVD9z4juiWvvn6kKvOohk5YEEWBRkNgXjSYPBkodR7UOnY//VPrKrXDO6KqFSc3CtRyzrV1OT2uGdaTNA79+yc/UZv/7jMdbpp2KBaXrLO2GcV7r0lIpNvN22HUHMTdpx56v02GpWE9MQ7xgdH+i44/J2UvrSQqhTZqjoeyNPnKsYIwfIZ3aLYlZGyUbYkCv5SQGSUnqsndvPaaAwpsgOJBRGGdnAnS47KcjLxepqlPPRCMGfh9cyRAZ8G98c9fiqLfQUu5/vqQ2XdyFqrCS6faML87G8aVR9p8s2Nv5xgtpf0IxTVbdK0Sjs7Bf95Nmkfu7O4Uj3oZVNcdcaichaoPD+Oeqpz544utqM5/RNoKhsEdEOlx6Eg3d45zFN/noOpucn8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NGeujvef9AnoQ/Qt316lwO+MzkP2eBhZsB4zvSTBWTZGNAgCZa/3mzOAGOJbQSoVEW0fx2HDSMiz0UHdpMWbBL/5BnBcoOJraPS/zjcDf657PnrmgaPPTZDRlH5I/FXGIOAmkUDRy7lhSK1FY0odKadK/os2W7kMgplGhj/cVY3An5VD56rDIPaVKKPAdNsq1bgtJ4c+cvdDaPEoRX/uzWyMyL9xIC9kyqESoWiXQmAxvPeRR8ymHvWuVhA1bKGmf5tUNIkig8VWmTCqC67mhKdBipLiTJvG49V830c3NhH39gGBiDdmylJGNkUSru66SZPW6q5yGSZ224RTRccxtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 551aad8f-bd10-449e-c439-08df18eabd7d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|1800799024|82310400026|14060799003|23010399003|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TiXaTp0jcaxg1xUr2Yqv2LPTMSxjvqzlIohLMugy3qzUt0u6dYolnvcjYdrdLy0yadhMIQiahSRmG4bzKOmrXpTD/DURpHZqiMIY1m46O9aJ3Zj8lMNoOh5pnlQua5UmTp2DuISA3v/BizgkjI7xPn9QW6jvW3/9HdFn98krbjMfudJBcxEtdl0r3niItSncomT7ZGvgj0pAxrP0bVK4zBLwt3UMreMjDAY2ffG0r5hNtfcSwy5VrphljsuR8OoNlvZQp7+XaSk+Qs6+n6l9KksP5Ad1BOmseG1kVJcrdV4JoM/Mgre3asM0zvsldTz1NXpmFyc+tRUY+k3t6dQyZaQmoQIvyVjM24JOQPi0S3tLCDmQXOvgTKa5PqudiXng+JuiFC9b3x9W+DSpSJFPnFg+OmEGKo/r/+EGNOeW8eJL9BUaTH1BbqKSg4DLPoK5EctOX5yUFIYebSqu40qncL+SUubQ2hTvH1mkEEV14HL4audQkKvKwQwFih3dynHlESnBooPAXEVYZ86e1FqfZ+cSVdbGtLx5Xin3B1EL/Pfofux6CwGXFQgVz6XZPcu7+PqekZ4LmgkR4AU6ORWzvZ4ivY4B3Nj+eBIV20ZPJnKnjYmljiHLKnpI3jpo8BKusvDETx36Yw9gG0V9KCn/n0RkHSn6DOPQzmRluCcpb7nWj4j+rA5Ji0W4l/nsg9Kl0GMbO+vGjpCOAnTiM2dDYQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(1800799024)(82310400026)(14060799003)(23010399003)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: py13uNyHhi9+u2JrcyfN+k2rqnirz+x+OofzkQUAUR1AU1Ms9WvN+JASwvM12T7dmAzE/O5lx4PIwjZfpUWGrbdOMhmbVaEZwq3NlNiksukQiQJ0Tbjnp1you5Pz2sAMdpFxuHPt/75cosMVPBX9VvaB7yWiw2oWbz3/YTWKdDQVobbAKpAtzO6adlbyFFs0QnOuihrkFMojHkPV+qLXnhxd7WwHFQPfh38dxVWQQZB8pMmd6p9yFXRA2Z8CGvoTBAIpuhMCOtHnvCylbidvUNt27rw5fpoN1x2YQNgtqeH/RNblHazqz38MIzIexUjdtR8esMNW/6B7vEUDUOlKhpehgw9/Z9DLNS8iVsglUtwK6HuepSws6D5Sesz6hUfHN0cpMqBTaKztK02mbdQmXuaIH0hZ9H4mXl0foB6/xBNWp2KnXqTRTSenkETYn+B0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:48:11.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfdfc75-c74b-4f2c-490b-08df18ead125
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5379
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

A late grant can arrive after the request has timed out and the access
window has returned to READY. Report GPU_STOPPED so the arbiter can
release the unused grant.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_aw.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 7ef13db4acf50..27787c0b2f3a2 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -282,8 +282,13 @@ static void panthor_aw_handle_window_opened(struct panthor_aw *aw)
 		return;
 
 	/* Window opened due to GPU_REQUEST */
-	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
-				     PANTHOR_AW_STATE_GPU_GRANTED);
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+				     PANTHOR_AW_STATE_GPU_GRANTED))
+		return;
+
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_READY,
+				     PANTHOR_AW_STATE_STOPPED_IDLE))
+		panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);
 }
 
 static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
-- 
2.43.0

