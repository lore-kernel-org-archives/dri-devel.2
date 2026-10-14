Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A46CCC6B24
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98BE10FB62;
	Wed, 14 Oct 2026 07:10:26 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BAD810FB63
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:10:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qSn9Do6i/VM86p9nHHHQeJwtftCIv2fOEQjLb4SHqCgdV2oB1NQjurTZF1mY/Q3z5f7N/3INqr4lDXNA1whVtOJ+7BS2ug8YA246SwfQmq6VX0neD/o+ivN+xrdcUg7Arp7eK9ECpPYj800i5ezeO7aTUUZglvDWjdyVuXqwl5xSnaj2ZIwlpDyKMYkzPvOTCO6aNBc1bm9WcRkkP0PT7PzCNiEYo/8+qlzhaSou4JtLlRMJtCaBz4qLc8w2o850RFQmXMCAbf3ti/IXRC3gk78SIGqygtFOVXXYklfjDcs7/gsH5L2EioTLrLn3BypxC7tPJGQKZC2hEjbwi9vaWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V05eNJLaDipj/3ayOgyrmMQAx+0KEYrJe3yeZ8M3sh8=;
 b=ohwh6ymmtQqKZA8uWHXeP9eGWfqzbyKOGySk6i7Tlq1K9tImlYJ+UcZ/b5d0U+Ogc8SgLseBVW6pND8D1vsv3hQMEEBc8QNt328bA2Ue9pjZjn/HhE8uvh20RMqWMa4KUbTMC21S3jmdZoOG4AKr0Lzdngo3u2pD2QxDpaNwHJfRu51IHIGF1NTxUJud8f/rbNneuMHl/tBAd+5QgMkajGVLuLhuaTNq4I910mqEC65Cg1wWxlrjTmVwMJcMFoE0eA68HAjSQulVvOVmUAVubusQ1o1gOTlMZBd7T9CVegg/6yOV2cac0uSZXfEcECFnyo2Ty9CWsLCkIiMPm2MXtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V05eNJLaDipj/3ayOgyrmMQAx+0KEYrJe3yeZ8M3sh8=;
 b=ISECmAyo2hjSSyXdbo4A0rH8qzPndJZNUT/jsil/3Tk61ZrwTNKt/56RpO7QYicTeg3+xMTwaRh3yEYZeRMk0LhfoplBLR0C1dQhL3ensYbLYHVxZa/Xkm65pXuOzdh3jobSbICoebSSYy6KT134TqZIxPpFJJpg1jqPtuH4exI=
Received: from AS9PR0301CA0018.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::20) by VI1PR08MB5311.eurprd08.prod.outlook.com
 (2603:10a6:803:13a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.6; Wed, 14 Oct
 2026 07:10:07 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:20b:468:cafe::28) by AS9PR0301CA0018.outlook.office365.com
 (2603:10a6:20b:468::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 07:10:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000052.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.0
 via Frontend Transport; Wed, 14 Oct 2026 07:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dds9PvJYirb6aJX8uI+G8W+JiX8TNqM0tim8jCVk9SvTvewGVrBZ+HS5OskfRD1BYbTgyyGYukkON//Xko+vYcHM6BfBLduy06ta69rQUpIm9emGm06wy3Xzyf46pfHomDv9B1jpnwBRpw7VrQiGQ2VlK7njDUi9BuSIKXuLGJUSve2TZao7P8bbhT3ehXgWgM+qR8TM//wzTluumncoC0AOHKwM77KkNL69YI26GTj112P9lgNfKHG3ZTHRpokWpU41jvpvVxKQ/RrgvvWhOYuq5lwvj2a1yQIvZgefWQsSHnlAjaDV6GSvupvA8WQDcj1aZPIzM8veheFt/hcauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V05eNJLaDipj/3ayOgyrmMQAx+0KEYrJe3yeZ8M3sh8=;
 b=IGYfHc7mADjkIizmZtGDStvkKbtapMargZNw34BwBCLYyO07EJeqCb+jMRLzwWOVfNVo2M4nc/dbE/6lcxys6E6tJLPU/bjvNUALPxf/papOHtZ4+5yXcY8Hkc9RhY7m6WWLSmNphVbhttvAPXocXGDTUGBjqnX9F4IyskWk2CUnikBwPpL2WL5YSIWrxyaSVwMXBlUteIHkHKImQEL87QLmFcyhxqNjB0VTehmNt8kZ0RhYwBcr5Op2QLgNCrlj5bWQCBbIwMWtk6ZQBJH2KWKos/jQ3JOb2LV2V/64X06kK0xeU29lA7NhOodbt9XAGjGmKoGAb5d+O+jxLts9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V05eNJLaDipj/3ayOgyrmMQAx+0KEYrJe3yeZ8M3sh8=;
 b=ISECmAyo2hjSSyXdbo4A0rH8qzPndJZNUT/jsil/3Tk61ZrwTNKt/56RpO7QYicTeg3+xMTwaRh3yEYZeRMk0LhfoplBLR0C1dQhL3ensYbLYHVxZa/Xkm65pXuOzdh3jobSbICoebSSYy6KT134TqZIxPpFJJpg1jqPtuH4exI=
Received: from AM9P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::34)
 by PAVPR08MB9745.eurprd08.prod.outlook.com (2603:10a6:102:31c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Wed, 14 Oct
 2026 07:09:32 +0000
Received: from AM2PEPF00070CF9.eurprd02.prod.outlook.com
 (2603:10a6:20b:21f:cafe::7c) by AM9P195CA0029.outlook.office365.com
 (2603:10a6:20b:21f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 07:09:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 172.205.89.229) smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 AM2PEPF00070CF9.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 07:09:32 +0000
Received: from AZ-NEU-EX03.Arm.com (10.240.25.137) by AZ-NEU-EX04.Arm.com
 (10.240.25.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 14 Oct
 2026 07:09:28 +0000
Received: from e144443.oslo.arm.com (10.42.65.142) by mail.arm.com
 (10.240.25.137) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Wed, 14 Oct 2026 07:09:27 +0000
From: Erik Faye-Lund <erik.faye-lund@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chia-I Wu <olvaffe@gmail.com>, Karunika Choo
 <karunika.choo@arm.com>
CC: Erik Faye-Lund <erik.faye-lund@arm.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/panthor: fix immortalis condition
Date: Wed, 14 Oct 2026 09:09:01 +0200
Message-ID: <20261014070902.169273-1-erik.faye-lund@arm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF9:EE_|PAVPR08MB9745:EE_|AM7PEPF00000052:EE_|VI1PR08MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: ad60fb6a-ee46-42d6-df82-08df29c22d5e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|921020|261009221227099003|10067099003|18002099003|6133799003|13003099007|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: HZ7tqRhLsTPlzVgHQG3GGEabQWwKjXwT1X4s5T9uN0JeT4a8PtJ7evt/55hRRxHjbC6HhjRFDzv5WpBad/TN+hvDyYMRJ204RokEfd4jbLPP0DorbxQyruA/2g6CDrStTnsXo6faKF+fLqYdnUW7MQ9TTG/JNQLH39U5JuXvYeeWJRhf4e6XwprxX35Bajn/9AWORXDqBR4+qg9Lqp7HTYn6WKj+TQE+NlHdtW5NGsiijNnPvNkDweq4hkj87LBXS0KZYwzcOoV1k883GVi92eCgfHm2JV54EB1XpFoxeg4behQaacXjZxyjPXobzqDXxxQ6uY70LMT1MxDx5+vIahLi6wdjmTKx4hoht6Gzti+bvWevRNDuc59kDibfaEHSywMpssYQV476d3RCnJE5q9H/nbrItlQ3JTFx2in/mzCFoVNvAfw2yPpYUa6s1FBTrUnR1eGqBQCMVcbrP80RBGKwglUyPR0ijAlRR2Ej/Bofq5N5h6eDwW2x9LgfYwPQG2uxg/px44dpVL5pcTskys8VejRmrUK7DxF4xC7YasnWFwEPv9F6SguM8wl4VXf2KuyKjyfBCnM5LBsDvCXjmvBR+fz6PZSBIPMJNe3XcGzd/XACNge/IV2iNgddz+40p/FQ3LEGV0nMXmgIvBBrbTthdBJBI+fvrcQ8htqNZ8D9ebqT1K6kl3IHMoQ94jdoai8YzjrbpxgYVPoUSK1lDIrjoGb/UMy0eM68iBdoMwANco6T2NGYY0CuzVqlOWAU
X-Forefront-Antispam-Report-Untrusted: CIP:172.205.89.229; CTRY:IE; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:nebula.arm.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(921020)(261009221227099003)(10067099003)(18002099003)(6133799003)(13003099007)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: D5vo+F7ZHffcXBM6K2U3Xx5ND7O3EJOTs7kUbLC6phy0C0o009FTpPVukU4VImxcZNPdNOWu65mRZ4arros37ifDbithx4tu1ASpM3R+/npmfBS69JnJxCvnx4l7SA3uFoC57kd1fzvIDTewIkzTWZalCE8Ne1O5MBWKAy2CqETXlPEHaCAfhLS/RQhNEuU2W/8On+hYdUOjJ/8WdkTvvCI/IviGNeMibGNLwOaOWmnhm7n9S4LWB6Czl57Zo7iAg7+B5WjcDQqU2oltJqmsHM+qDvjXIGG5rF5RpiD9hfHBRXlTSpsxSGTE/nmjxAmzThx2mabVhFI0BsjTfxM/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9745
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 50ae6d8a-6f16-4b44-eca2-08df29c2187f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|1800799024|23010399003|36860700016|14060799003|82310400026|921020|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: s16lDGfxvvEa8LqEZSjDoOT3SxZALjNhVulpuFeHM0ZvoOTPFRn47c0JCNLQ/JSWDfSVrZGoACHxL7fFbuevBbGtby7tylMyGKVLuIY0rcPcwPlNFsaLn7p432x4z1QoE/8A85Sw+4u7XaWM6Lntjubbnv6hV1jXal/SfYUUuUsGC4SRsYIgUdSzvIbhQ9ufipV8OG6W2H/X0lO7RZJyA7PGjpbAaeLcbBJxEXGp1yptMMkifnszdFlr2uaYWRo4DEiY7u7H4P3afnCe/9w4JNj/orPkvqmMaqyErFeWZCjZJzAI198finPwZ3rDwzWn3Vmijijd0pidVsrGRFTtpwBxUopEX5wVLyrN4o/ovdQHHlwRehBWHqzMe/FYVE25c294eieoWTzXin/KvM6HbJ5/Y6ORgtZfbt+UtJpCsRJsAB80ovFLl2SkOI4mG/Nn8N+kqy1mDpYAd3a7OtJEAdNOqr4Zd9b9Dobn5tNBrpd6QX8EXanVe5MaIA82T/09LdGLdLnsX3XlijhMga/D18Lae30UgepBN4vgy1otL/SX5w0ktJL0lGfQmVesQCz+e2lPK4ztm//A6ZnNy1usgFuI2+OMAPVt/vF1i9F2/ivvVAoKEJRtNKNpTozxTIlIS+5uHlvO5wvmZcaeRq0H1z7jxXiDZC3g0GayJqM3GaZ1x9/BW96SKPaXFg98q8pTWZ3XH8UR3WrnGjyyNW95lFQ1yMTNjWe37EdJhC52lUYuyVemLXMfnt+9D9C65bjg
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(1800799024)(23010399003)(36860700016)(14060799003)(82310400026)(921020)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y7UswPbwFc7igPYZxF0WmgsixmZ6UvihmrJhgEQxAQowNKBQH0uLEGMOhrsk7m22grCMf1eEYMq/dBMkfY5faeV/XwEE262J9Dvw9wujGRcky+/LgcyaBKz/1SVoo0Kt1R+FhV5nG1nTVD11T5LbO20+uHuVu1urgMCRzcudMJyw+oAfnrl9WvC1NeMtU0jSaJMgww56xFV529IOv+ygDZL+br++MmtoaklDPI5hsnfsVSq3+dRyjyCJAPuJ1GZkjWNWqm03MhQXD7bCU059KbMNCj3crNh5D959RKktllyw3/1qXhj0fwg0kbXLOB0rnrwQXW9T/FEPb/NC3rIcqn1SRodB1+DTlNWf5mZFsTT0S09K7Uqr6eHOVQE3Fygu2iOImAyGzErp72FdLP+CYIZ61mDLX0c83wqN0WH3UpEEAkFWTR2SN0gvGrEVnien
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:10:07.0592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad60fb6a-ee46-42d6-df82-08df29c22d5e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5311
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

Exactly 10 cores is also valid for an Immortalis configuration,
according to the public documentation:

https://support.arm.com/compute-ip/immortalis-g715

So let's report this G715 with 10 cores as Immortalis as well, as long
as it supports the ray-intersection feature. This matches what we do for
more recent GPUs as well.

Fixes: 3b1dc21d6d80 ("drm/panthor: Add support for Mali-Gx15 family of GPUs")
Signed-off-by: Erik Faye-Lund <erik.faye-lund@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes since v1:
- Fixed typo in subject.
- Added missing SoB line.
- Applied Reviewed-by tags.

 drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 7e315708ca7c..ea1e222ef121 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -136,7 +136,7 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 	case GPU_PROD_ID_MAKE(10, 7):
 		return "Mali-G610";
 	case GPU_PROD_ID_MAKE(11, 2):
-		if (shader_core_count > 10 && ray_intersection)
+		if (shader_core_count >= 10 && ray_intersection)
 			return "Mali-G715-Immortalis";
 		else if (shader_core_count >= 7)
 			return "Mali-G715";
-- 
2.47.3

