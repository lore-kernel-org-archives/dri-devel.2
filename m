Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D9FCD6E4B
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193A610F341;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="CoDpISwL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CoDpISwL";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013041.outbound.protection.outlook.com
 [52.101.83.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6FD10F32D
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xKJvlKV6+rnNS5Mrr83Q9pr93ncMl80mXtl5IShv9+021DnT9dRAn38vbf7e8zmewunFZYafZGDKpztez/pI+/YFsKMWO7lCbvm9sZkvl3OpGFJrtEKcwPxQvNFRmoDCFbME6Pkuc+hJA6pJ+FSgQYMtVXQzMquQwsNo6DuevCJvNXS3uwqcKCxqXdqE8lUetHV+mH8TY8H9gRmmj3XxMjRH3tKJgH4VM8sBBAJicMjWOKcm/I+GXJqk2BGBeHInLWrR7cdai0aMWrguimFKrt5O/eypD+vCPaFtEBnbAF/ZkYfOuiunYfQuza4BdMVl0gKfgw0OoaZZhwfdEgEA9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Qkc6+z1hvUJ2vKC4l6P0u7Bf0zI1lM78/E0DS0uB4=;
 b=WnHAe11m5fFSr+mps9ELoJCq7im/r/Kl9wO4TC96QqaR+8LS5rhdt/5/fSuN3gOkVs6Vf9eieQtXqS0Xo2AsHaSlcd9ttNX8nPmyqXRwt2vhA+rqFxt6M2L2bKQRULVAUcbBLyk3OVMBETaZ62uMLKdkwsJSVH9ewv8lpnkEgAY+v2CLRHVFvGnjphkUD9duWjkDGw+1YwJtlr0Fu2zO4Mfy2ST8GSqDIfvF5N8zFu75uMYwej4azOG1+ooXU70RDmgjVwSsFPvK7+ki7VIYmHnFeWuxzV7fGOma98XlR5hTste/O7TMXQRbGd35QABjvm9SQXe+enEP7DqvGTTkjw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Qkc6+z1hvUJ2vKC4l6P0u7Bf0zI1lM78/E0DS0uB4=;
 b=CoDpISwLFjqy+BxAglwJiUihNstEN0n2zdk4JNlXCC2HNqxTBLQrUwERvUJ2WgT5EXh5He9QdBvxMILYEvVej9a24e+Zb2ZlLPZR2iqB2rCRObA3lC2R0DRkeNQ9zwST1QyhqICnq+qBxjAUc/GrrQtllg1JCegnbOj2fBXkqso=
Received: from CWLP265CA0448.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::19)
 by AS8PR08MB10269.eurprd08.prod.outlook.com (2603:10a6:20b:63c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:07:07 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::f7) by CWLP265CA0448.outlook.office365.com
 (2603:10a6:400:1b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKA1pGhEO/ha+hnRD8XUh+AwUHN7CeVT9dsfzw8EZ8PSDj2qeLYX+84uiWPGsfyWwfShNVK3dosrrx75f7WrVLgp2d1bPOiqBhgVDHvp1giARwAJ0CbweGyDVrDblZVQ1CSYqB8Vws1g+y+mvDjfA3wngFM7/4lygmLN+UOlLlzSLjL/MJuP3BrzjqIM1/g7E5fnIHfBgwpmkhYeU3HzTxlpQUS/JDI8VlQ2gMmC7k4gKSykYRgWyqqKnkBDrurVbmGOI6ASQYwIC4SqMxvcm3ROOuBnE8iNNXRBJApMQtrfogs3M8SDdbtywyL9t8sBBNBAG0VXGdwkTRuRMkWsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9Qkc6+z1hvUJ2vKC4l6P0u7Bf0zI1lM78/E0DS0uB4=;
 b=qgWnhGj7WxIvXwclDD1MYXzz76MpPsH1LbaMOKVd76jVoEV0u8vGXSJ4MPWBG3M9iHGlxJWvBBJiwesH4u4lTWX1wLLPmSN9GzM8lH6znUJmoruOEWqit0n6AunSmc+M3e6u2D3xjXpHLdu8Jw9PFeyYk37zfuO9Ftq+s+On7pP+qYrhzkTZ6NWqptMs95ewrx9YRDwABESXyMlhCtHd8NCMygYPyTewhe25q4nF5IAzjWh7VDpV7XN0WlAyDQfW69cnlVwIllnq1HNOplgc87Bm78KKb9TzQf5N4O+AuHwFv7tqi4aXFdz/aVNH4AJ64Zwhdxa7XAp/1pkdJY0jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9Qkc6+z1hvUJ2vKC4l6P0u7Bf0zI1lM78/E0DS0uB4=;
 b=CoDpISwLFjqy+BxAglwJiUihNstEN0n2zdk4JNlXCC2HNqxTBLQrUwERvUJ2WgT5EXh5He9QdBvxMILYEvVej9a24e+Zb2ZlLPZR2iqB2rCRObA3lC2R0DRkeNQ9zwST1QyhqICnq+qBxjAUc/GrrQtllg1JCegnbOj2fBXkqso=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:04 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:04 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/18] drm/panthor: Skip devfreq when no OPP table is
 present
Date: Thu, 28 May 2026 16:05:36 +0100
Message-ID: <20260528150546.3168527-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0052.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::27) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AMS0EPF0000019D:EE_|AS8PR08MB10269:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c29a824-17c0-44f7-f573-08debccac8d2
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 37+sS3rU4KmLvhtuN7Jd9q8+CcuOOsn0StHTJv6K8EwQ7UXm3ha+cdeW6bngKJ0RY1BLpMyogyH07dcoLFqkEaZTFAqBnsmMnGg2oeXAsKidBaxgkRs5B2Rk8wK7d7PyV1tLXvLEZsIFnVYmMPXqUUn6kOTc3Q4CbekwjQAYmBsPz0WBuzLbbcgT4o56O931mv5jBsgGBF+5Urit9suVMVWi/DY7YZQL8V9XhpMIHOuc27SC/pTswHMRIdR1fD4ZQXXrG7eyd/vLWAk10OglLUTD0uXowbpOHZWQAEjTo7YxOz71M5CqQ5H6oPbzhF03KVyU3Q896elwJRRELFSjkgzbTzMrA8ZKuWF0/BybQJipw8e1yXCzNGLv9f2TGh+slhxplaTyT13ZVC6rX9wjgxXECjIawmzOZiIK0f5e9/ABdhWtPclUn0y4ZNUDGfiJVs4kwy8EcNvwCUf7AJJLIzVwVXmwGGm5tOK4sSLGdGQ1z1ZJnBWH4vOF5Yto/bfv1MbQkQbvmeP7nf0l0hdOK/7nLTM5ZkBeJNIR3iBcJ/A/G/6v1W2E5KKKZgj8m90C6iic+HXM+0aPRC4a4xQL+VepgviqecxEgvVOFuKARVop4zZbzY9g9wwTHAwJQFQlC9XmPbSBu1Uc6QJfhkSDU24zSC+940vBNt1kbVhjTVNmEXMmkWNnKlbiIq28Fc6f
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: eYJA4WtPDlEJglmJq1MY7JD9wHGtapb2U70wlUVUI80TBdpsJRPmYzz2MgZNW7ece8yzBHyqn34bLjoOk67Ie/zSxR8FlVDF9e197ckuh1GN6B5BiLIligiXD//CHpHx9QfQkcCPPp86JMKKLQes1AOBg+nCG212tTQSNmTnvAveGwFsIMixerVFhN8wxL2lSHqm3/M1uoQBQOEv7h7UMv/o5Wfm1mn0vATx/idJzyErdqCeI2LSHhRTQDTPfhNQcuGcyQ79cDm9TuekVCyC2bXkYkgitTxMDGtb0Tyc6zFyc0giKNe9UXwoV7gxG/c4BIh4qFMqe7X8WDvUZljU2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4b40c98c-ce07-4196-7f79-08debccaa350
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|36860700016|35042699022|82310400026|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6V2M1+WfpzyIgbok+0BXGe/qW9H+tlkbLk8xWuj2hNhT5nJgtsbvzKYToHz87OMT8QwE7Tq0eUtK3IhqUAA6e+dWTruAGCoWYNxV/BGXaMfQcVWZ1FmDp/7V6dB/+yeW1WbXmn442zjTVJaIYFtMVWpY+7pCHPgPJJ3U264VJb5G6Q8l89t+0ZUGGGBaD6SQxP4IL7QQkCFMTr2XCFnQsXZT2vSkcZTbUHxHWzj3VRVmoyEQOm4vJTYfX2egjnOTQnLST3DSiG7IZtDhz/EfG+JF4IbPXEFcuMRGoPF3TIekUw/HIG+/E20Rd0grEecpim8tcuuQ4GUhle38pca41YWh3UjAlj8HHlpk5y0EkAKFZfB3Zcy53YgzXHBSJwBixu3dmjYNizC/9AYXD33v0YAVQVd+hN/TeE/gxTEGbdNMMGMiLMWun2IHpgUDYs3u004XgHakn37GkqzS7sxAO3xpH4ikkp2RudnK3QwaWM58ghR3qPffILWrPOhX/AZNappxAHuuEZj1BjCDVyOYA5J1lLqGUYMrrpDmDa9TgxHK3hbZ9w0jdq6O+dAxCKOq4F8tYZ9k6RLO1TZ0SrXt2XIg9rMQIoxlisCmloHGP0cUDHolbeTCaVltc1x7w86wlkCxulaZml3ME4ehOZ5tQueq4VF0MwrQ5nYHnX5yRrlRobGPPyb/WoL1XzLN5KAdhFSgJFRqIgIyqwSgH8VW88L072m9YK6XnexSDR2jyns=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(36860700016)(35042699022)(82310400026)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sN9B8CUwhdKEA8QjYxrcwV2/l8H9a5mnEhb1euELLvjIrRz3/tBHBt2rawzGY3Bb1QNqBbppUXw+VRGs1E4lJYQMuTnyODghwP9rtsOEaFd9P4/DFgbJjxUiRQvuYnFh5NyEHb+7GOcnzyXAbJUrgwlvYiqupF23e9kXqEqyxwP09mLhuJQQbgY3IgZHlIgaXfFto0wjCbWVgF6/qt/dx+d5hYve7LxEEWSCvztxlHYoi7VRT3uEueumAKQWL+mhT95GvhjDm4TLXavzKDDEEVeWE5aLHABJBeRlDWV0CVmf793Hs9jx+6+8KBiirUxAxvBDXcum80iFL+eFBDAoNozQ44p3+t9abDQxMvrGRQIPoaRyS8V5x4dCgXGZEeSZBF7xRuH+2UiDL/p3S4c6Bnu2dHCkk4ofBQoQxgupctStbFv9Yp42IQyDsXe+3z0D
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:07.0953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c29a824-17c0-44f7-f573-08debccac8d2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10269
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

On Mali v15 AM systems, frequency scaling is handled outside panthor by
the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.

Make panthor_devfreq_init() return early when operating-points-v2 is
absent, and guard the devfreq helper paths against a missing devfreq
instance.

This keeps devfreq enabled for existing platforms while allowing v15 AM
systems to probe without a local devfreq setup.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4af..c3252ce54437 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -148,6 +148,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	unsigned long freq = ULONG_MAX;
 	int ret;
 
+	if (!device_property_read_bool(ptdev->base.dev, "operating-points-v2"))
+		return 0;
+
 	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
 	if (!pdevfreq)
 		return -ENOMEM;
@@ -267,7 +270,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	panthor_devfreq_reset(pdevfreq);
@@ -279,7 +282,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
 {
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
@@ -290,7 +293,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -306,7 +309,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
 	unsigned long irqflags;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return;
 
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
@@ -323,7 +326,7 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 	unsigned long freq = 0;
 	int ret;
 
-	if (!pdevfreq->devfreq)
+	if (!pdevfreq || !pdevfreq->devfreq)
 		return 0;
 
 	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
-- 
2.43.0

