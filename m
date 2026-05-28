Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E45CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509B010F33E;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TQT4EZSq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TQT4EZSq";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A7B10F335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=uT3XmRc5/izL3S0szYisZeLORIkQ6tExE6f+kcK8TBlITBeM316PfLGK6QZx06qDSjJ02sn9NpYWGkchB6bl0Yucp0jq5DtQ9Xre3zMY+qqWzpH9tTAfyBbygAbyxsqxd1hAlHF+Cxh5abOcQH2XFB2swsZdL5kaGHpUZpQHrFqYrwZGLwDpIxM60hbcKzFUG/kjCUR3eiE1Yc0Kd05IP2WmHwrXOBfnZ+/zAKqpN49aqmzGChjWRsBqlm8cdL7mn+nG2zJf1OHP/MZO1wX7PaB0PoKSTghdxcgA3/dwOVOE1530bltzrE4ODvskBj/j1QFDHfUHvTtrF2GPZaEOiQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GGdxHBOa9r1LNad74mK2GtFm8dSCyrwLQCVWshe5Fk=;
 b=iOoGtU6YA1IZ38FrVdB/f6NAsCpuNxIkyloOWXrtkqgt3CPqTHZhRdFzKHt9Y7E59W52yhJfVVF0mcE5+lJzC9Ybkbfr7gRi1NLdsJZLEZNDmQ8YjtYks5WYLDNC4W3AlOuYjvOSP1oJkb1SiziBbpln9F4O/gRX3jkyq8Y3Mxu/uOlQhtLiu9/bO/mfAmQFa7a8MUVLJugyxpteJWDry+OjgxADjzyBku27nMTeg+BnH98YRvT4M4mnBdbjpEdiFNAcFI+bCH8RtVQk5sOZUyFmAvE6AlE1XFDkMrx5qJeUwXIBK1I7BF/WEfDiqNjEcwRizo4tT3GeUPw9y8F7Ag==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GGdxHBOa9r1LNad74mK2GtFm8dSCyrwLQCVWshe5Fk=;
 b=TQT4EZSqW3VHoe6rBqY6jhWq9LqlHCBYX6Wv1JZGF2IvAm9xqJsgxdXvCKKef9588NFzKLLncuzNyY4uWzkQv1jcBK/hscKEWAA1VTrcjBdYxu5RO0a66zSEVpTC9GWXYT0peiTuH3hVy7gD0HqqSXUWare0lyIafDG0MMI4j9g=
Received: from DU2P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::13)
 by VE1PR08MB5695.eurprd08.prod.outlook.com (2603:10a6:800:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:07:20 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::45) by DU2P250CA0008.outlook.office365.com
 (2603:10a6:10:231::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 15:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Thu, 28 May 2026 15:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVeHtTyu2GNvqrxO4kBQtKnb8RSDgcH1zrOiwMMC3l4/A8RBk8xmdWAk5Euwj1LuxCkh2xNYvoAXE7T33wOSXG17at+IQokIDPWqVioa7w8/QUTB0U4RW6az4E/labx5+SJ6+FR4Uj3XgttVljzdc4J5kDwJzAYt06JhoUoI+koaApt+SYXb4xY3zb2UBSva9jG5GEPem6L6qr9auqZBc8i7Jz30SJG3scWhW9DxsWFfk+9OoGZUWWd8sjjFs7NVisnCeQtu+CPtUx8ZNs7703r/IKCKG4dCnBCqFA0dHXiASqiET7LgUazLAZzTLIyarW/PnQ5nONYMDKrW2eytOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GGdxHBOa9r1LNad74mK2GtFm8dSCyrwLQCVWshe5Fk=;
 b=RwPjXBexdIE/RIePNfKN3cS9U7lUhrZbqi8LWwXiuUq8M42XvGrlmlikFauoZcYxqe916j5xfZDeiIiJra9YE6GuMcaB1dcjX22TTHqe/UEC1o4PrpJwtpVlT5Y4r8UQzSIe9ZjK/Ko/Q/hXC41Y/C7cS2Y/EQDVhizxbRsKYlaJgu3CFOgGomSO0DfUJ1jahbcxvGL6KolSs220w7OeOWTfTNdg+4CDM/3SqoEYGDAmqVHKRAGKsshJ+4Gln9s9xNRopI9Lq51atTk9IMdXMT3dljyVfDmMoAs9WX6beRZf3CdjoSOiF1QSBiWTMVuJYS0+3i5Ex7sjh5b6m4fa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GGdxHBOa9r1LNad74mK2GtFm8dSCyrwLQCVWshe5Fk=;
 b=TQT4EZSqW3VHoe6rBqY6jhWq9LqlHCBYX6Wv1JZGF2IvAm9xqJsgxdXvCKKef9588NFzKLLncuzNyY4uWzkQv1jcBK/hscKEWAA1VTrcjBdYxu5RO0a66zSEVpTC9GWXYT0peiTuH3hVy7gD0HqqSXUWare0lyIafDG0MMI4j9g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:16 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:16 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/18] drm/panthor: Route HW component PM through access
 windows
Date: Thu, 28 May 2026 16:05:45 +0100
Message-ID: <20260528150546.3168527-18-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::17) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|DU6PEPF0000A7DF:EE_|VE1PR08MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 553644c5-1bb3-40d8-31b8-08debccad0fa
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 1qcWu6BTYuP/mUQ9FypLb+x3+DTdBXy+hyUvi7tKQyYFfkuZVm80kjPYp+5nTm06Ma6bAxKdfuUmyMI3Ver1hrQ6x4EZDLDnJt2uSOWuDNdz2sd2VNFYaR3RkaUWRcejTpDnGKUlsWV6QRHXrMVF1KlyDEekgoUVBmGByntoStEvSXRgDzbHyE/8/EDe+Ao3oblsATpK7U9YxHCuH/kEa1aXdmQuE68ORFE0N5saLIquAJKz7iCTO2WVdLblPFnsI7cLLs4/EMVYllvUwCe+ipCJG/n+WzW+JZ9ldccqAYFyxFyCOtyR8mj0VqsOIIVzyonjf2ePkdPvO9UzgRgIucLkv0vYITbjBwAzPNuCwpYCbf/NxeOdFl/ZtqhWjgDoPqxikFS3wjinfsMDVjG2gUZJ02N5pie+NaPFcm4+lS4cXLWSdlw9qVwq5b/eRurJGe/OlFyJ3ahLr4u4FvhVpJmkTTXzkgbp2B6Sa+ibYkLyqQEleby1lnTUGNMmEV2n71taN5pUDFeChmNFLaKa7/sY6WEGNGPOjKM4rY1k+cUWUQsbX75e7CyU8Hxgq9Zeo1LgDumOxWfpHjxFRCnc+rPZ+F/kowj2nKsIyrxkYcmxKRslG/RPMOSXnhXfwuXcu/gb1WjzbwQPgQ0/hJgL+MYQtjhPd82vZ0Cugsg+sCunHNQU9+YCo5zLs792pspx
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pAkyNCvFFxLXNhSXjnmJ/b0DOnV4N38Fjqllp+gWyzBlbj37hIpuZC1woP8do8TPOByzYFuRKKzg2+HwMNoPHqaCjTZJAD0dNGlTOC9cwv8LPDf/eyhnr/kju8gc9Ae7/61OdrvZv6LX4sQeP6G4lupvH7J+CZcB25G5Jw++BnrEztiL7f9C4NlktL9JBmYcM9nPg+GJOaV9sBdXPSWKX9HO7RrNHzZPn7b3eQnZ6QkkdEqnYMXF6dIjWugxV0/iiD5huPmebS2xHpG9fi81iqqFB+pt8phYcpmcjFiEAQgXPlY9dWC2nRKUYc/YMrJNgQVO1RhNGWH6D6SnoJ7llg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a0da8565-a961-47f2-0564-08debccaaab6
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|82310400026|36860700016|14060799003|376014|56012099006|18002099003|6133799003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: NL7ZL32DOmbXb/mxqTdrpvrtEdD3utuhG3mHw4E+01LbZfhDgbtE9Ql/akx68q76ZG25A9BhLsLQIFeEgSrW48XaNfE7a0XKEsIPb7xwIe0N3kt3p8k6K55RLXFqRp8c7l5hexov/j6NeGk60HLFwfA4am7iRB2OKv53l4NEnYEACmM7VX3sGcRpOxbKuVtKyQQ3Rob2d5QMnUYr30b8FUt6aRdtJNOXaR2ucivWaQaQSUcypQzzoL/Fn/y6Tb8BgRTE8sHEFjbsQGpy3Y2U1ICW9c4cTmZ9JyW8u3qB3Ph7IL/5zA4oW8fHf3PyvTtKfWN3PQkME8UyiWUM1NRQZvK8+SWgT3AiDqCjNIkbVkRMF9K2Sdw4g7lN33IiMOt+F//KaLmplgvixFCxVecPu/zLwYpAF/bJd111K5vBfSd0hrFzeWAdPfw8P2nZnjGooQueRHVHGQwPgxl6/7uTuUdwgiZzAKN1d/TbQvek14jDS3YWRQ/JxFjILfMC3OiMYg9o+2PoAy475kZseFn0vgdfl8xfnVM7GI0GpDWbEI3Y5A78CJk/OhYf9pQOwOOa/lJjsFrUlQqG3EMGF55s/AZmikGTl/v8PLKR44+rnz0Zn4gZxAISiaFS85QgREx5Gs6wfnJhA/EHzjd9gF51K1oOWe4NSjtv+h6vogPsQJ+al3mgL+pQ/8fpU2gaqpJs8WGWnpvjc0j169NqW65DkP8gWuyjjK4DwCGBR+izF8M=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700016)(14060799003)(376014)(56012099006)(18002099003)(6133799003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SYTRvR2lCYmuMVV+64P+eS+NilL2fR9+UP+a8hKVlXE6Oy/zTm8DXdN3LGnICvG4SyPP1DHojzHXAhkrbsn+rQ78JdZHJiM6mSTwroLljxR8u+HR174+KVEiyVYAjCluGA7x0ZZDZhs/8TmrOFsLFf9RsgC+E/V7RWXmMJ679B/kwS0B+7RZ7btTitWhKO0CAuQAcSZ85TLmYqrMw5R+bipFRuVUP7Ke6VbPrG3Byqan6F4n6PXjcKJAFj+8LVkKLZb4m4UUkdhtblckhxcCOnhbNpQbf+oU+xLC09v/zbaCvjudoAJA4fqXJY3bEMzLy0XLEzx8JiENb8jR4NNfezAJnuel3jNutdVMR2B+130kpuj+5s3/JmfftI/CyXmGG9EZQkOijG4HQs2utur9PnVyRjbQhfvpgebI7zZjc1QWUpYyv7h2gXjUjGWmgHsH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:20.7583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553644c5-1bb3-40d8-31b8-08debccad0fa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5695
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

Make access-window resume and suspend own GPU access when AW support is
present, while keeping the direct HW component PM path for older GPUs.

Handle WINDOW_CLOSED and arbiter restart events, defer post-yield
cleanup to workqueue context, and make panthor_device_resume_and_get()
ensure that GPU access is obtained before callers touch hardware.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_aw.c     | 182 ++++++++++++++++++++---
 drivers/gpu/drm/panthor/panthor_aw.h     |   8 +-
 drivers/gpu/drm/panthor/panthor_device.c |   6 +-
 drivers/gpu/drm/panthor/panthor_device.h |  16 +-
 4 files changed, 187 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 146907a3098d..7c7637a8a9f1 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -77,6 +77,9 @@ struct panthor_aw {
 
 	/** @msg_retry_work: Work to resend messages */
 	struct work_struct msg_retry_work;
+
+	/** @post_yield_work: Work to yield the GPU */
+	struct work_struct post_yield_work;
 };
 
 static bool panthor_aw_is_open(struct panthor_aw *aw)
@@ -118,6 +121,52 @@ static int panthor_aw_state_wait_transition(struct panthor_aw *aw, u32 timeout_m
 		timeout_ms);
 }
 
+static void panthor_aw_post_yield_work(struct work_struct *work)
+{
+	struct panthor_aw *aw =
+		container_of(work, struct panthor_aw, post_yield_work);
+	struct panthor_device *ptdev = aw->ptdev;
+	struct device *dev = ptdev->base.dev;
+	int ret;
+
+	/* Something else has progressed the state to READY. */
+	if (atomic_read(&aw->state) != PANTHOR_AW_STATE_GPU_STOPPED)
+		return;
+
+	/*
+	 * Ensure in-progress resume is completed and prevent future RPM suspend
+	 * to keep the clocks turned on when accessing HW registers.
+	 */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	ret = panthor_device_suspend_hw_components(ptdev);
+	if (ret)
+		dev_warn(dev, "Failed to suspend hardware components.");
+
+	panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+
+	/*
+	 * schedule an immediate tick to re-evaluate if there is any additional
+	 * work. This will request access to the GPU again and if the driver has
+	 * gone idle, it will yield GPU access via the runtime suspend path.
+	 */
+	panthor_sched_resume(ptdev);
+
+	pm_runtime_put_noidle(dev);
+}
+
+static bool panthor_aw_schedule_post_yield_work(struct panthor_aw *aw)
+{
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+				     PANTHOR_AW_STATE_GPU_STOPPED)) {
+		queue_work(aw->wq, &aw->post_yield_work);
+		return true;
+	}
+
+	return false;
+}
+
 static void panthor_aw_msg_retry_work(struct work_struct *work)
 {
 	struct panthor_aw *aw =
@@ -166,7 +215,9 @@ static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 message)
 
 		panthor_aw_send_msg(aw, reply);
 
-		/* TODO: Handle AW restart */
+		/* Arbiter was restarted. Window is no longer granted access. */
+		if (panthor_aw_schedule_post_yield_work(aw))
+			drm_info(&ptdev->base, "Arbiter was restarted, yielding GPU");
 	}
 
 	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_INIT, PANTHOR_AW_STATE_READY);
@@ -192,6 +243,38 @@ static void panthor_aw_handle_message(struct panthor_aw *aw)
 		drm_warn(&ptdev->base, "Unsupported msg id (0x%x)", msg_id);
 }
 
+static void panthor_aw_handle_window_closed(struct panthor_aw *aw)
+{
+	struct panthor_device *ptdev = aw->ptdev;
+
+	/* Ignore this WINDOW_CLOSED as part of reset operation. */
+	if (panthor_device_reset_is_pending(ptdev))
+		return;
+
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_STOPPED ||
+	    atomic_read(&aw->state) == PANTHOR_AW_STATE_READY ||
+	    atomic_read(&aw->state) == PANTHOR_AW_STATE_INIT) {
+		drm_warn(&ptdev->base, "Unexpected WINDOW_CLOSED received");
+		return;
+	}
+
+	/*
+	 * Window may have been closed immediately after opening.
+	 * Setting state back to READY will prevent WINDOW_OPENDED from
+	 * mistakenly transitioning the state to GRANTED.
+	 */
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+				     PANTHOR_AW_STATE_READY))
+		return;
+
+	/* Triggerred from messaged-based yield. Unblock its wait */
+	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_STOPPED_IDLE,
+				     PANTHOR_AW_STATE_READY))
+		return;
+
+	panthor_aw_schedule_post_yield_work(aw);
+}
+
 static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 {
 	struct panthor_irq *pirq = data;
@@ -211,7 +294,9 @@ static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)
 	if (status & WINDOW_IRQ_MESSAGE)
 		panthor_aw_handle_message(aw);
 
-	/* TODO: handle WINDOW_CLOSED*/
+	if (status & WINDOW_IRQ_WINDOW_CLOSED)
+		panthor_aw_handle_window_closed(aw);
+
 
 	if ((status & WINDOW_IRQ_WINDOW_OPENED) && panthor_aw_is_open(aw))
 		panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
@@ -264,6 +349,7 @@ static int panthor_request_aw_irq(struct panthor_device *ptdev,
 
 static int panthor_aw_request(struct panthor_aw *aw)
 {
+	struct panthor_device *ptdev = aw->ptdev;
 	int ret;
 
 again:
@@ -271,6 +357,9 @@ static int panthor_aw_request(struct panthor_aw *aw)
 	case PANTHOR_AW_STATE_GPU_GRANTED:
 		return 0;
 
+	case PANTHOR_AW_STATE_GPU_STOPPED:
+		return -EAGAIN;
+
 	case PANTHOR_AW_STATE_READY:
 		break;
 
@@ -278,14 +367,22 @@ static int panthor_aw_request(struct panthor_aw *aw)
 		panthor_aw_handshake_init(aw);
 		ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
 					    PANTHOR_AW_HANDSHAKE_TIMEOUT_MS);
-		if (ret)
+		if (ret) {
+			drm_err(&ptdev->base,
+				"Timed out waiting for handshake to complete");
 			return ret;
+		}
+
 		goto again;
 	default:
 		ret = panthor_aw_state_wait_transition(
 			aw, PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
-		if (ret)
+		if (ret) {
+			drm_err(&ptdev->base,
+				"Timed out waiting for AW state transition");
 			return ret;
+		}
+
 		goto again;
 	}
 
@@ -295,15 +392,20 @@ static int panthor_aw_request(struct panthor_aw *aw)
 
 	panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
 
-	/* Wait for GPU to be granted */
-	ret = panthor_aw_state_wait(aw, PANTHOR_AW_STATE_GPU_GRANTED,
-				    PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS);
+	ret = panthor_aw_wait_cond(
+		aw, atomic_read(&aw->state) != PANTHOR_AW_STATE_GPU_REQUEST,
+		PANTHOR_AW_GPU_REQUEST_TIMEOUT_MS);
 	if (ret) {
-		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+		if (!panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
+					      PANTHOR_AW_STATE_READY))
+			goto again;
+
+		drm_err(&ptdev->base,
+				"Timed out waiting for AW GPU to be granted");
 		return ret;
 	}
 
-	return 0;
+	goto again;
 }
 
 static int panthor_aw_yield(struct panthor_aw *aw)
@@ -335,6 +437,7 @@ int panthor_aw_init(struct panthor_device *ptdev)
 	aw->iomem = ptdev->iomem;
 
 	INIT_WORK(&aw->msg_retry_work, panthor_aw_msg_retry_work);
+	INIT_WORK(&aw->post_yield_work, panthor_aw_post_yield_work);
 
 	init_waitqueue_head(&aw->waitqueue);
 	atomic_set(&aw->state, PANTHOR_AW_STATE_INIT);
@@ -367,6 +470,7 @@ void panthor_aw_unplug(struct panthor_device *ptdev)
 		return;
 
 	disable_work_sync(&aw->msg_retry_work);
+	disable_work_sync(&aw->post_yield_work);
 
 	panthor_aw_irq_suspend(&aw->irq);
 }
@@ -376,17 +480,48 @@ int panthor_aw_resume(struct panthor_device *ptdev)
 	struct panthor_aw *aw = ptdev->aw;
 	int ret;
 
+	/* resume hw components directly if AW is not supported */
 	if (!aw)
-		return 0;
+		return panthor_device_resume_hw_components(ptdev);
 
 	panthor_aw_irq_resume(&aw->irq);
 
+again:
 	ret = panthor_aw_request(aw);
+	if (ret)
+		goto err_out;
+
+	ret = panthor_device_resume_hw_components(ptdev);
 	if (ret) {
-		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
+		/* Yield GPU access if HW components failed to resume */
+		if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
+					     PANTHOR_AW_STATE_STOPPED_IDLE)) {
+			/*
+			 * If failure is caused by WINDOW_CLOSED and the IRQ is
+			 * handled after this condition, AW may emit a rogue
+			 * idle event that will be ignored by the arbitration
+			 * scheduler. WINDOW_CLOSED handler will then transition
+			 * the state back to READY.
+			 */
+			panthor_aw_yield(aw);
+		}
+
 		goto err_out;
 	}
 
+	/*
+	 * WINDOW_CLOSED won the race. post_yield_work owns component cleanup
+	 * and will transition state to READY after this PM transition is
+	 * complete.
+	 */
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_STOPPED) {
+		ret = -EAGAIN;
+		goto err_out;
+	}
+
+	if (atomic_read(&aw->state) != PANTHOR_AW_STATE_GPU_GRANTED)
+		goto again;
+
 	return 0;
 
 err_out:
@@ -401,20 +536,33 @@ int panthor_aw_suspend(struct panthor_device *ptdev)
 
 	/* suspend hw components directly if AW is not supported */
 	if (!aw)
-		return 0;
+		return panthor_device_suspend_hw_components(ptdev);
 
 	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_READY)
 		goto out_irq_suspend;
 
+	if (atomic_read(&aw->state) == PANTHOR_AW_STATE_GPU_GRANTED) {
+		ret = panthor_device_suspend_hw_components(ptdev);
+		if (ret)
+			goto out_irq_suspend;
+	}
+
 	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
-		PANTHOR_AW_STATE_GPU_STOPPED))
+		PANTHOR_AW_STATE_STOPPED_IDLE)) {
 		ret = panthor_aw_yield(aw);
-	else
-		ret = panthor_aw_state_wait(
-			aw, PANTHOR_AW_STATE_READY,
-			PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
+		if (ret)
+			panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
+	}
 
 out_irq_suspend:
 	panthor_aw_irq_suspend(&aw->irq);
 	return ret;
 }
+
+int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev)
+{
+	if (!ptdev->aw)
+		return 0;
+
+	return panthor_aw_resume(ptdev);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index c2b89caa87c4..7a46a1e18093 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -24,10 +24,10 @@ enum aw_states {
 	/** @PANTHOR_AW_STATE_GPU_GRANTED: AW is granted GPU access. */
 	PANTHOR_AW_STATE_GPU_GRANTED,
 
-	/** @PANTHOR_AW_STATE_GPU_STOP: AW is requested to stop GPU access. */
-	PANTHOR_AW_STATE_GPU_STOP,
+	/** @PANTHOR_AW_STATE_STOPPED_IDLE: AW has stopped GPU access. */
+	PANTHOR_AW_STATE_STOPPED_IDLE,
 
-	/** @PANTHOR_AW_STATE_GPU_STOPPED: AW has stopped GPU access. */
+	/** @PANTHOR_AW_STATE_GPU_STOPPED: Window was closed, cleanup required. */
 	PANTHOR_AW_STATE_GPU_STOPPED,
 };
 
@@ -39,4 +39,6 @@ int panthor_aw_resume(struct panthor_device *ptdev);
 
 int panthor_aw_suspend(struct panthor_device *ptdev);
 
+int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index a8aedbee7c97..441fe89d2e0a 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -570,11 +570,11 @@ int panthor_device_resume(struct device *dev)
 			atomic_set(&ptdev->reset.pending, 0);
 		}
 
-		ret = panthor_device_resume_hw_components(ptdev);
+		ret = panthor_aw_resume(ptdev);
 		if (ret && ptdev->reset.fast) {
 			drm_err(&ptdev->base, "Fast reset failed, trying a slow reset");
 			ptdev->reset.fast = false;
-			ret = panthor_device_resume_hw_components(ptdev);
+			ret = panthor_aw_resume(ptdev);
 		}
 
 		if (!ret)
@@ -643,7 +643,7 @@ int panthor_device_suspend(struct device *dev)
 		 * The end of the reset will happen in the resume path though.
 		 */
 		panthor_sched_suspend(ptdev);
-		panthor_device_suspend_hw_components(ptdev);
+		panthor_aw_suspend(ptdev);
 		drm_dev_exit(cookie);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index d7beb7165577..d01456637f4c 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -18,6 +18,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+#include "panthor_aw.h"
+
 struct panthor_aw;
 struct panthor_csf;
 struct panthor_csf_ctx;
@@ -464,8 +466,18 @@ static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 	 * succeeded. Given resume errors are not expected, this is probably
 	 * something we can live with.
 	 */
-	if (ret && atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
-		pm_runtime_set_suspended(ptdev->base.dev);
+	if (ret) {
+		if (atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) == 1)
+			pm_runtime_set_suspended(ptdev->base.dev);
+
+		return ret;
+	}
+
+	ret = panthor_aw_ensure_gpu_access(ptdev);
+	if (ret) {
+		pm_runtime_put_autosuspend(ptdev->base.dev);
+		return ret;
+	}
 
 	return ret;
 }
-- 
2.43.0

