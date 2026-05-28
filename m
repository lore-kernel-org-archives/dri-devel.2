Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B266CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028DE10F33F;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XacbGUlL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XacbGUlL";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC41E10F335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=V+XDKxZ9jgqz0ARL6ejOo+gcUvOQdS7dukWZGs4YGHVXFL9OTwt9do9kFUd2znhzwYlbmSLSocXQvYfcStOYTCDeEQJGEsHeADSL7PioieRdg1KoZBhgODrDkMtnOTuCqOQbouZE9NIQaKzUVDWK7p2Ek2kH1Wjg4YUXbyqHcT5aLhjoklg0iUzbYiwXGewy4BHmidaEB8IE/ny/vDD6Iy7B3ZVJT6R/lHfcXCZ+b+qO70+onU0hiOsSPSGi0FU4gL22oAqUdbRcxu1TtX8HMKKSrZnaVsOeUjkmzQAJZRnRrb3hxlj6p+sAdWlHaMsSivDH9yvS8l1CQWHoHKgGsw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHP2FktcKcg1brfPRDbaQZ9x9GedExf7CLqejjt0ILY=;
 b=ukmKDGdQ56JMVnQOiGhxnEHpyUVBd+I6AbFguXHEKc4hcoMN0lpBQwjdRe70rJdHjKnk/0qQAusAaxkzkJ2Ip9eCFEyxuOpPp9lhJDjRe5mq9Ts01Qv5ai0DhEdGJneDxNdKi3A6dQ9TB07hd51I9CZQ8Pi/EdFnmOK76po/10QoVnzTf8gujHnKoahXI+waxA4pEffX1dcvJJX6EiyXfNhzO9iacrWS7N3OYJOiaPFNV1FO8GpAnQYwuUNmHv3qeqntA4xv+GjB7p1R2FvsPxIUZ2B0/tx/OgJ5oUFLkBlFrCwCPALYFXC23Hz8fwz6l1HJVGu8PVSdHDKnc0aafg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHP2FktcKcg1brfPRDbaQZ9x9GedExf7CLqejjt0ILY=;
 b=XacbGUlLbcWk6J72tZqG1gwMv/QT3lTvZEXPnVrbojgDTgZWCBwdSn39gRrfjrdjOLJ4NHC4vV5BLSK1ym3G1MseVjvjOjoKipSx8SVgjLusa5Z/EeLUGta0DECMrgJWibC3n5ekofL5IuAG7osAxDkEddi/P5SY/0sdilLxBA4=
Received: from AS4P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::19)
 by AS2PR08MB8781.eurprd08.prod.outlook.com (2603:10a6:20b:5f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:07:12 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::64) by AS4P191CA0023.outlook.office365.com
 (2603:10a6:20b:5d9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 15:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJam984jbMz62PdbaQ0mmRjf8hmsq+OvppxVZJfkDZ9n6grXFBJj7Qi+2uXv+TNw6tgLZpJyRgxlfdyqOX06QHNfoYOnkh4aCfIIh4OkSZgUoa72apQyxS3jjsR70plSsZwzd9tp+JeeqhaOmy+t+WWG39QHFpm+o7jpkwXO+JNWOcVccED558gIsNFGjiWwodAkkLiH7ZVzHx2V9McZLiBkfA1h2W0Lobe9Ki064o/y+TniJvJIoAbJF3mAZbvvHXCFEWkUpGgalRckT55ymm1kQM/pqvf8GVj8icwWC0BJXMy63CEelIiOpkax0eDVRZc6qxJ7AC2VPyEc8yQM1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHP2FktcKcg1brfPRDbaQZ9x9GedExf7CLqejjt0ILY=;
 b=agTryW9RwQAdS5mBkQen1r00nDdIdsR+rIOQl6+gBpDj2mNdiPgfqLclgoAI1U/G3rqK8mm7096MTdfnSna/joyCEM1DrAfLIw19uk8S5KmHHEQ9zGM3oLVggIGmgHzx+O+v2IFkh6rIyL2ipPqNwxnvN/Utpaz0S8LPlSWXNIKtczURDSDMcFdsgIPV95Y+wJCk7HMhe9zt6EmWdBuI9Olk8lIhnyI9QxCDq5f1GitxYPAyhLo7xIsBznFzLUhPrSVBuoeRPMSXJQ72MgRSTEST3aA15ojXrGIdPjhqHGLQ16gnCShV+Kr1jABBwNSjTFHqZUwFYNdjiJZxLju/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHP2FktcKcg1brfPRDbaQZ9x9GedExf7CLqejjt0ILY=;
 b=XacbGUlLbcWk6J72tZqG1gwMv/QT3lTvZEXPnVrbojgDTgZWCBwdSn39gRrfjrdjOLJ4NHC4vV5BLSK1ym3G1MseVjvjOjoKipSx8SVgjLusa5Z/EeLUGta0DECMrgJWibC3n5ekofL5IuAG7osAxDkEddi/P5SY/0sdilLxBA4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:07 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:07 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/18] drm/panthor: Add AM_PARTITION_CONTROL support
Date: Thu, 28 May 2026 16:05:38 +0100
Message-ID: <20260528150546.3168527-11-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::13) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AM3PEPF0000A79C:EE_|AS2PR08MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b95228-06b8-49e7-2bc5-08debccacabe
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info-Original: BShVTFKG5hy0dm1ez+mkzfdzMxfsNYZfHLx05COzp299/WyUtruXXW0JzvpV1OXVRvjMJ+mp2+8EikItWqy7ieDFYY3W4mxRP6y+i6O0nHLMVfQ7Yb5aKaN2I83LmFeubE89kN7Vz6FVN0A60/9hU8dbmKRM9qW8zrlcXpd0cs/yX49A+6W5w2oniZ1PiRIvdAGCFnw5P+rsKJCOAS9ynsH85Gi26pXbqEKygyCB+qSwtSN+5RAEAMoln7QNK3QA/Z6h6/WKhjyo5rKUTykbwVxatUYdHp1f+hoMe4qjBeMgAclo9B/Zez3s4s5T4+uEqc8DZRqLQ1HeWeUozUnsCws9i+VBV3t7aGq5RXerjzgkcym01Lk4jRW3QfaivWdTdo1wZRorkHzV2QsQRxfxRvBPetoVoG0yegFV5d08WjpUw7l/i18bKDOwZo7Gqcm8kBuOI30fQ5RIV04x+7fB/o75jJ2SltbRfKYjNyZr+DBPIThYcLfugbuixFEMd7h9KvOET+kA3535mXU8kTIY7aYrCzjI8sB5wtZ0CjmSDdVmiHWnw9ZzabxnZLv7csaXulrQztBhFNGyvYZQ8iPM71ZAtt5bJdCwaVWAndRUFHCksLWuzwP/7Npy74cDuP7yQGjN0ZtXmWYmzGyqpGr+MHGoOKm883xGGaXqyfip+EQulSq8y/Gve3rVEXxDwmat
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: XWVnLFD6l/H1z+B7EnN+J+W8n8GfUku7kb7uWY2aMZf9gQOcUUIxEAwkSuZFB40pTPF5fwVbIOZGlb4HnaklI/sgERE/h7gn2cWD2d8QxDncL47P+I3+dqeJ4AD6RUz6RizXwq6cbE24LPwLGilwnKvQh5O/LPvbtNfeqAOXIzINzKnEaOpctbH1ltCATdPlUS6B1fUe8PXjX/hpDbQfJcMaYjzBmx8lQYcbwhQTQ52CZaWT1+v/jaS6owONYlrau6pKtIrVKfJ8NaQ4JlHIz1toEACObxK0vyMWmpaG8g1t7K6G/MwcQ+vnM8QnWYUAjmSZSRwZBdCpPqx1R5L9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0daaf1bd-cdd1-4f8c-b052-08debccaa4f4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|82310400026|14060799003|376014|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: cYqd5XZAo//f5BD+hs/FXKMgIzs7PiExH3naphwYYSfGkLfsGxgplTc2/Wsx4ZtdamD++G4b/LS5nLW/AmR5KdHmJJcPBVWKZRgia/XlFAssdYCQRSRwyKb+I7qIitHtdlIZP7qadUWWg2ihrhmxj2s07xUri6TboGcb2k4mID4/q+thjwZcMm4I9RgtaVNnxzA5R7wsVXBLYW4d0bQDfUOCesW4qkBIV9QqMDcwWvxIKOSVfZy9EpzRJzAkYA0fo0UfsZn7dY7rOKu9KWz+IiN1/b4ukE4/tMMo/qYhpb6zZB5zMqhCCilkyOny/VNu+V/3OvcG//aYc8zLVqxnXZQ+/uI8ssRBKIJr+C1UvpDf/AXqMAEhvMJ4jfuCNwdeD88xhWH+vs2T08+CpCRfH8HSaElE5J/JObSXkKJScoLCSn030MNOlNP/EcR/3XLyr413UfCAOEocvee2rvniGxNd4C2c0bIGY9JwygRxYaPbgmcLYx+OhKTVVfX+XER8SVNtlcwN0J2gDLUwUENDl99aHVd//Fn+IVgBFSCKwvVLftZGwsY/bySj+cwL8EGWU2lfYmCYnHSvYgjHNM7N79xokTFFksY9kIEUfn7WrrBafyxgXQks9l/wsTWwK5UkhJv82b9mrs4t6tCHTPynmm4SWI08bd5Kpnl1R/Rq8m7laMKxXBD4LUsI+WtQCza/8AzXNWltWui0BBgYceOQAJJMNtgaQBD2ouH+CzGFgFQ=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: es5pBrP/e83uQdyReukZ4OgMH6hv2EdMrGvpzK+ejKlsZw04mwpOI+oL9n+RuDf8MTOhct+H56gJxq/RHkL3FbIYiMyXSUvMa2Il99mNyxoi4ooGI63Tge8ZoSjQNZC6PeAPE/wRe0MyDR2h3AIu+I392CnS7uU75VMwAIfE07kyd91/iVGfuR74OrC4OINlhBHwk/ctAJ0pefoDOlwsbA3ltx+jEuxi8Lzx5yyF86hDs6LzwQFdUSanWnKYIa4s1/yrOdrinsWIJjlF0ciD2mjksIRsGu/JnTR12mG/fsgqefrnGsUHLwSNVujKMhAngFUi1MtlwJKuAvXQeZYjyHyimv/TFhUc/d/ilJvTHXbVB8CP2vnpFTrAC3w4VORjtBfgfAGiIx7TtF9TnLau+peCc9ZUKSZEmXpqdeHUuGkXUH+RtZKPURwbeOO6ofoT
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:10.3092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b95228-06b8-49e7-2bc5-08debccacabe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8781
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

Mali v15 AM GPUs expose AM_PARTITION_CONTROL blocks to manage partition
access windows.

Add a panthor arbitration platform driver and wire it into Kconfig and
the panthor build. The driver maps pcN partition-control resources,
handles RESET_DONE and INVALID_COMMAND interrupts, and provides helpers
to open, close and yield partition access windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/Kconfig               |   7 +
 drivers/gpu/drm/panthor/Makefile              |   1 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |  15 +
 .../panthor/arbitration/panthor_arbitration.h |  24 ++
 .../arbitration/panthor_arbitration_drv.c     | 127 ++++++
 .../arbitration/panthor_partition_control.c   | 381 ++++++++++++++++++
 .../arbitration/panthor_partition_control.h   |  27 ++
 7 files changed, 582 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/Makefile
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index da6b9bc1c67b..55b9b80f45d1 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -27,3 +27,10 @@ config DRM_PANTHOR_SYSTEM
 	depends on OF
 	help
 	  Driver for GPU-wide configuration of Arm Mali 5th Gen AM GPUs.
+
+config DRM_PANTHOR_ARBITRATION
+	tristate "HW-assisted virtualization for Mali 5th Gen AM GPUs"
+	depends on DRM_PANTHOR
+	depends on OF
+	help
+	  HW-assisted virtualization driver for Mali 5th Gen AM GPUs.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 488a5e03efbc..5d4d0ae64952 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -15,5 +15,6 @@ panthor-y := \
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
 obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += system/
+obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += arbitration/
 
 CFLAGS_panthor_gpu.o := -I$(src)
diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
new file mode 100644
index 000000000000..5d5b2b8d84bc
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0 OR MIT
+# Copyright 2026 ARM Limited. All rights reserved.
+
+obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
+panthor_arbitration-y := \
+	panthor_arbitration_drv.o \
+	panthor_partition_control.o
+
+INCLUDES = \
+	-I$(src)/..
+
+ccflags-y += $(INCLUDES)
+subdir-ccflags-y += $(INCLUDES)
+
+
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
new file mode 100644
index 000000000000..5e35ae8463c4
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_ARBITRATION_H__
+#define __PANTHOR_ARBITRATION_H__
+
+struct device;
+struct panthor_partition_control;
+
+#define AM_ARB_MAX_PC_COUNT			1
+#define AM_ARB_MAX_AW_COUNT			16
+
+/**
+ * struct panthor_arbitration - Arbitration device
+ */
+struct panthor_arbitration {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @pc: Pointer array to partition control data */
+	struct panthor_partition_control *pc[AM_ARB_MAX_PC_COUNT];
+};
+
+#endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
new file mode 100644
index 000000000000..07a566168e6a
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_partition_control.h"
+
+#define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
+
+static int panthor_arbitration_runtime_suspend(struct device *dev)
+{
+	struct panthor_arbitration *adev = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = panthor_partition_control_suspend(adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int panthor_arbitration_runtime_resume(struct device *dev)
+{
+	struct panthor_arbitration *adev = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = panthor_partition_control_resume(adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int panthor_arbitration_probe(struct platform_device *pdev)
+{
+	struct panthor_arbitration *adev;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (!pdev)
+		return -EINVAL;
+
+	adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->dev = dev;
+
+	dev_set_drvdata(dev, adev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = panthor_partition_control_init(adev);
+	if (ret)
+		goto err_out;
+
+	pm_runtime_set_autosuspend_delay(dev, PANTHOR_PM_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_out:
+	pm_runtime_put_noidle(dev);
+	return ret;
+}
+
+static void panthor_arbitration_remove(struct platform_device *pdev)
+{
+	struct panthor_arbitration *adev = platform_get_drvdata(pdev);
+	int ret;
+
+	if (!adev)
+		return;
+
+	ret = pm_runtime_resume_and_get(adev->dev);
+	if (ret < 0)
+		goto out_suspended;
+
+	panthor_partition_control_term(adev);
+
+	pm_runtime_put_noidle(adev->dev);
+
+out_suspended:
+	pm_runtime_set_suspended(adev->dev);
+}
+
+static const struct dev_pm_ops panthor_arbitration_pm_ops = {
+	.resume = pm_runtime_force_resume,
+	.suspend = pm_runtime_force_suspend,
+	.runtime_resume = panthor_arbitration_runtime_resume,
+	.runtime_suspend = panthor_arbitration_runtime_suspend,
+};
+
+static const struct of_device_id panthor_arbitration_of_match[] = {
+	{ .compatible = "arm,mali-gen5-am-arbitration" },
+	{ /* Sentinel */ },
+};
+
+static struct platform_driver panthor_arbitration_driver = {
+	.probe = panthor_arbitration_probe,
+	.remove = panthor_arbitration_remove,
+	.driver = {
+		.name = "panthor-arbitration",
+		.of_match_table = panthor_arbitration_of_match,
+		.pm = pm_ptr(&panthor_arbitration_pm_ops),
+	},
+};
+
+module_platform_driver(panthor_arbitration_driver);
+
+MODULE_AUTHOR("ARM Ltd.");
+MODULE_DESCRIPTION("Panthor HW-assisted virtualization Driver");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
new file mode 100644
index 000000000000..f4bad839610d
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/iopoll.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_device_io.h"
+#include "panthor_partition_control.h"
+
+#define AM_PART_IRQ_RAWSTAT			0x40
+#define AM_PART_IRQ_CLEAR			0x44
+#define AM_PART_IRQ_MASK			0x48
+#define AM_PART_IRQ_STATUS			0x4C
+#define   PART_RESET_DONE			BIT(3)
+#define   PART_INVALID_COMMAND			BIT(6)
+
+#define AM_PART_STATE				0x60
+#define   AM_PART_STATE_GET(x)			FIELD_GET(GENMASK(11, 8), x)
+#define     PART_STATE_RESET			0
+#define     PART_STATE_WINDOW_OPENING		1
+#define     PART_STATE_WINDOW_OPEN		7
+#define     PART_STATE_WINDOW_CLOSED		8
+#define   AM_PART_STATE_WINDOW_GET(x)		FIELD_GET(GENMASK(15, 12), x)
+
+#define AM_PART_COMMAND				0x100
+#define   AM_PART_SET_COMMAND(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define     PART_CMD_YIELD_IDLE			0x10
+#define     PART_CMD_YIELD_NOW			0x11
+#define     PART_CMD_CLOSE_WINDOW		0x20
+#define     PART_CMD_OPEN_WINDOW		0x21
+#define   AM_PART_SET_WINDOW(x)			FIELD_PREP(GENMASK(11, 8), x)
+
+#define PART_CONTROL_IRQ_MASK \
+	(PART_RESET_DONE | PART_INVALID_COMMAND)
+
+#define PART_REG_POLL_SLEEP_US			10
+#define PART_STATE_TRANSITION_TIMEOUT_US	5000000
+
+/**
+ * struct panthor_partition_control - Partition control data
+ */
+struct panthor_partition_control {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @name: Resource name */
+	char *name;
+
+	/** @iomem: CPU mapping of the partition control IOMEM region */
+	void __iomem *iomem;
+
+	/** @irq: IRQ number */
+	int irq;
+
+	/** @lock: Proctects partition control state data */
+	spinlock_t lock;
+
+	/** @current_aw: currently open access window */
+	int current_aw;
+
+	/** @closing: synchronous closing of the partition */
+	bool closing;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+};
+
+static void partition_irq_suspend(struct panthor_partition_control *pc)
+{
+	gpu_write(pc->iomem, AM_PART_IRQ_MASK, 0);
+}
+
+static void partition_irq_resume(struct panthor_partition_control *pc)
+{
+	gpu_write(pc->iomem, AM_PART_IRQ_MASK, PART_CONTROL_IRQ_MASK);
+}
+
+static u32 partition_state_get(struct panthor_partition_control *pc)
+{
+	const u32 state = gpu_read(pc->iomem, AM_PART_STATE);
+
+	return AM_PART_STATE_GET(state);
+}
+
+static u8 partition_aw_get(struct panthor_partition_control *pc)
+{
+	const u32 state = gpu_read(pc->iomem, AM_PART_STATE);
+
+	return AM_PART_STATE_WINDOW_GET(state);
+}
+
+static int partition_state_wait(struct panthor_partition_control *pc, u32 state)
+{
+	u32 partition_state;
+
+	return read_poll_timeout_atomic(partition_state_get, partition_state,
+					partition_state == state,
+					PART_REG_POLL_SLEEP_US,
+					PART_STATE_TRANSITION_TIMEOUT_US,
+					false, pc);
+}
+
+static int partition_state_wait_transition(struct panthor_partition_control *pc)
+{
+	int ret;
+
+again:
+	switch (partition_state_get(pc)) {
+	case PART_STATE_WINDOW_CLOSED:
+		ret = partition_state_wait(pc, PART_STATE_RESET);
+		if (ret)
+			return ret;
+		goto again;
+	case PART_STATE_WINDOW_OPENING:
+		ret = partition_state_wait(pc, PART_STATE_WINDOW_OPEN);
+		if (ret)
+			return ret;
+		goto again;
+	case PART_STATE_RESET:
+	case PART_STATE_WINDOW_OPEN:
+		return 0;
+	default:
+		dev_err(pc->dev, "%s: Unknown state %u", pc->name,
+			partition_state_get(pc));
+		return -EINVAL;
+	}
+}
+
+static int yield_now(struct panthor_partition_control *pc)
+{
+	int ret;
+
+	ret = partition_state_wait_transition(pc);
+	if (ret)
+		return ret;
+
+	/* Partition already reset, nothing to yield */
+	if (partition_state_get(pc) == PART_STATE_RESET)
+		return 0;
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
+
+	return 0;
+}
+
+static int window_close(struct panthor_partition_control *pc)
+{
+	int ret;
+
+	ret = partition_state_wait_transition(pc);
+	if (ret)
+		return ret;
+
+	/* Partition already closed. */
+	if (partition_state_get(pc) == PART_STATE_RESET)
+		return 0;
+
+	scoped_guard(spinlock_irqsave, &pc->lock)
+		pc->closing = true;
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
+
+	/*
+	 * Wait for RESET_DONE interrupt to clear pc->closing. Prevents stale
+	 * RESET_DONE from being misinterpreted as RESET_DONE due to YIELD_DONE.
+	 */
+	if (!wait_event_timeout(
+		    pc->waitqueue, !pc->closing,
+		    usecs_to_jiffies(PART_STATE_TRANSITION_TIMEOUT_US))) {
+		if (pc->closing) {
+			dev_err(pc->dev,
+				"%s: Timed out waiting for partition to close: %d",
+				pc->name, ret);
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int window_open(struct panthor_partition_control *pc, u8 aw_id)
+{
+	int ret;
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	ret = partition_state_wait_transition(pc);
+	if (ret)
+		return ret;
+
+	if (partition_state_get(pc) == PART_STATE_WINDOW_OPEN) {
+		dev_warn(pc->dev,
+			 "%s: Window opem for %u Failed. Already opened. aw=%u, state=%u",
+			 pc->name, aw_id, partition_aw_get(pc),
+			 partition_state_get(pc));
+		return 0;
+	}
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id));
+
+	ret = partition_state_wait(pc, PART_STATE_WINDOW_OPEN);
+	if (ret) {
+		dev_err(pc->dev, "%s: Timed out waiting for partition to open: %d",
+			pc->name, ret);
+		return ret;
+	}
+
+	scoped_guard(spinlock_irqsave, &pc->lock)
+		pc->current_aw = aw_id;
+
+	return 0;
+}
+
+static void partition_handle_reset_done(struct panthor_partition_control *pc)
+{
+	scoped_guard(spinlock_irqsave, &pc->lock) {
+		pc->current_aw = -1;
+
+		/* RESET_DONE from CLOSE_WINDOW */
+		if (pc->closing)
+			pc->closing = false;
+	}
+
+	wake_up_all(&pc->waitqueue);
+}
+
+static irqreturn_t partition_irq_raw_handler(int irq, void *data)
+{
+	struct panthor_partition_control *pc = data;
+	u32 status;
+
+	status = gpu_read(pc->iomem, AM_PART_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & PART_RESET_DONE)
+		partition_handle_reset_done(pc);
+
+	if (status & PART_INVALID_COMMAND)
+		dev_warn(pc->dev, "%s: Invalid command", pc->name);
+
+	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, status);
+
+	return IRQ_HANDLED;
+}
+
+int panthor_partition_control_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_partition_control *pc = adev->pc[i];
+
+		if (!pc)
+			continue;
+
+		partition_irq_suspend(pc);
+	}
+
+	return 0;
+}
+
+int panthor_partition_control_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_partition_control *pc = adev->pc[i];
+
+		if (!pc)
+			continue;
+
+		partition_irq_resume(pc);
+	}
+
+	return 0;
+}
+
+void panthor_partition_control_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_partition_control *pc = adev->pc[i];
+
+		if (!pc)
+			continue;
+
+		if (!WARN_ON(window_close(pc)))
+			WARN_ON(partition_state_wait(pc, PART_STATE_RESET));
+
+		partition_irq_suspend(pc);
+	}
+}
+
+static int partition_control_init(struct panthor_arbitration *adev, int i)
+{
+	struct device *dev = adev->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct panthor_partition_control *pc;
+	struct resource *res;
+	void __iomem *iomem;
+	char *name;
+	int irq;
+	int ret;
+
+	if (i >= AM_ARB_MAX_PC_COUNT)
+		return -EINVAL;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "pc%d", i);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res) {
+		devm_kfree(dev, name);
+		return -ENODEV;
+	}
+
+	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	iomem = devm_ioremap_resource(dev, res);
+	if (IS_ERR(iomem)) {
+		return dev_err_probe(dev, PTR_ERR(iomem),
+				     "%s: Failed to ioremap", name);
+	}
+
+	pc->name = name;
+	pc->dev = dev;
+	pc->iomem = iomem;
+
+	init_waitqueue_head(&pc->waitqueue);
+	spin_lock_init(&pc->lock);
+	pc->current_aw = -1;
+
+	adev->pc[i] = pc;
+
+	irq = platform_get_irq_byname(pdev, name);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(
+		dev, irq, partition_irq_raw_handler, IRQF_SHARED,
+		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), pc);
+	if (ret)
+		return ret;
+
+	partition_irq_resume(pc);
+
+	return 0;
+}
+
+int panthor_partition_control_init(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		int ret = partition_control_init(adev, i);
+		if (ret == -ENODEV)
+			continue;
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int panthor_partition_control_open_window(struct panthor_partition_control *pc, u8 aw_id)
+{
+	return window_open(pc, aw_id);
+}
+
+int panthor_partition_control_close_window(struct panthor_partition_control *pc)
+{
+	return window_close(pc);
+}
+
+int panthor_partition_control_yield_now(struct panthor_partition_control *pc)
+{
+	return yield_now(pc);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
new file mode 100644
index 000000000000..bd935de04137
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_PARTITION_CONTROL_H__
+#define __PANTHOR_PARTITION_CONTROL_H__
+
+#include <linux/types.h>
+
+struct device;
+struct panthor_arbitration;
+struct panthor_partition_control;
+
+int panthor_partition_control_init(struct panthor_arbitration *adev);
+
+void panthor_partition_control_term(struct panthor_arbitration *adev);
+
+int panthor_partition_control_suspend(struct panthor_arbitration *adev);
+
+int panthor_partition_control_resume(struct panthor_arbitration *adev);
+
+int panthor_partition_control_open_window(struct panthor_partition_control *pc, u8 aw_id);
+
+int panthor_partition_control_close_window(struct panthor_partition_control *pc);
+
+int panthor_partition_control_yield_now(struct panthor_partition_control *pc);
+
+#endif
-- 
2.43.0

