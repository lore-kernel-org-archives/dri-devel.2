Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297A2CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507CD10F33B;
	Thu, 28 May 2026 15:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="T+FdPUkC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T+FdPUkC";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013038.outbound.protection.outlook.com
 [40.107.162.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7B010F320
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 15:07:19 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fjnQmSyOLAM8p2ODHj9ku1lwk/OV1nbiLnH8QoTN9KQZ+BbF5PMyxybLeyvQwbjl1APN+TkYfS+TdR3BQfbLQT9rpYu+A678G6Zsul8IIMQpwYwqWIdXQS8vPbD9x06GlFzhmU1cFY06wKl57Fr16NS4uenXBner6NPJKHttzQuP8KKWLfF1iBlgj5ShjLzGgOBjnKJEvZHSn5P+s01f6zGJG1IJNeROnIPG4esa95Aim7JQ6tzrufRhcgMqd/doMvGtUiL2wJ9Dv5wKOI/5piKrSMq9RfIOTv1O7Vbqh/vhXGmh+e+dv/fgvcL/puMoBIYPg1o6l1ot7fCjhSa6CQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv06PwZpcdOvWwvgaOF4y1FMW1A65mXUf2yzjRjiQZQ=;
 b=V72vryUb4BEXTEh4mqjmNYvkTgfuB0A623dgTTE9YLvQkoqO5POCI1uqBjuMaEwDxmR2+ZpF7gEneJkBaDwJ3twRSyBqmg56/FSDlgxfQHHgLUMe6/UqVOyvxs/psHxuvOQSWrNReEKUEnFmqD5Zvjz8FP6S2N1l5ybUjlsEDpUJwiPT3SqsYSB53CDSnaJGG1Hb8EsCkv+cWFZ8GCxJ7jQa6tX/fgpijXyHeffBsWhYjyfsahee5pTOs47vfZmMBWBykKtHwEm6iOxGpTddRPk6HgRvoutjwzn4mQuC7E53IV6oe/L++mLO2AFsUNY1xKbMe5tVFZ2RFueJov5BkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv06PwZpcdOvWwvgaOF4y1FMW1A65mXUf2yzjRjiQZQ=;
 b=T+FdPUkCsmSi17IzS3R1JuHa7U8UuU2cItdjQwE94vLGjivk9dpxFroWYUfkvv4xXWDJKfs/OMEaiR6gPQTwnezhuKRCV2+4YgKdeQWdoH8n28IO39dNEewBOzbWl3e6wDShr0lgqe2eQEJRfz9ZlKIrRcI667MqV02RAJzK8qA=
Received: from AS4P192CA0042.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::21)
 by FRZPR08MB11902.eurprd08.prod.outlook.com (2603:10a6:d10:1c9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:07:16 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::5b) by AS4P192CA0042.outlook.office365.com
 (2603:10a6:20b:658::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 15:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 15:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMSDnJjLlriPjXOGGjMPfAmwVCwQckkwsLSjdYfcJIdgw9xtUhWzJ+lwoWSBSux9KlcyNXOu1O6TmJ5gM/hG3JTY3k1h+8VZRfRxBk7f0qMqX6EsApUh94OFhn7MAISf5dHwx0QdZh81OhABhfKTgOeZ+TfuMsvO1Tc6mdRLvEeeC3aLkt6hvcY1Zudlp3wIV6w4ZEOQlPz3T2L+ZQ7W33YpkMjxAoiMRgm6hEGN5Q3cftyjt3UW+rDk3Pwj+fAI/RtsBbCVvt9jjRPzrJxgsXzdPDXiIzVrwPJWeAN8mhGtYDE8VVj8ZdSxhob06CayVzfj9tG4LWEvACIAk0+08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv06PwZpcdOvWwvgaOF4y1FMW1A65mXUf2yzjRjiQZQ=;
 b=gxcyWHM2Pmp3YC62pQgQpTPQ/DTpIMgVkrvMkZJOQ+qeiYxpslcPH5c2ScrYl5A/qjoOr6/YlRxKZYQGHBx/n1pjSPMC6CsUsszUgn4y7vk0phvZsA3AK56dA4p1H4qyXMLeHg0WJIH6pIrscp/o1inls0SDWdrJoweYOoEV1ZG2p4C2IWW61zWsWEhH9hreD0EOe8I/ssPmzxBGZCZLRmANM/iP9zB8WZs/J4OG0TQuW//job04y+iJ92K12HcxJZbs8pp6sIhsQXJk6q7DGLyt1hIA+K6ilmrnfmIJ1HRz0Sj6fOCOrXlWSbH5Z221nGj81gVBCcWNTi1sYOSfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv06PwZpcdOvWwvgaOF4y1FMW1A65mXUf2yzjRjiQZQ=;
 b=T+FdPUkCsmSi17IzS3R1JuHa7U8UuU2cItdjQwE94vLGjivk9dpxFroWYUfkvv4xXWDJKfs/OMEaiR6gPQTwnezhuKRCV2+4YgKdeQWdoH8n28IO39dNEewBOzbWl3e6wDShr0lgqe2eQEJRfz9ZlKIrRcI667MqV02RAJzK8qA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU2PR08MB10015.eurprd08.prod.outlook.com
 (2603:10a6:10:49f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 15:06:11 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:06:11 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/18] drm/panthor: Add arbitration scheduler
Date: Thu, 28 May 2026 16:05:41 +0100
Message-ID: <20260528150546.3168527-14-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528150546.3168527-1-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0217.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU2PR08MB10015:EE_|AM3PEPF0000A78F:EE_|FRZPR08MB11902:EE_
X-MS-Office365-Filtering-Correlation-Id: 655c554e-15b0-4794-e147-08debccace45
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info-Original: /lPowMs+jk98GxZESe0kmfkkOOCzghNsSnU3CvLj8mOAMVhsr7rbW/J0HFAMwzKg1h8FTNsyar4iBKWaJmhFRDGREd1WFPz4ZCHXCWPrCuqby1qSmJC7uq9/sfnWtmJHmb5efMrbEz3Adagss6i6Rullpcom17wHYcZRRcKkpB3k+uhsBbW8yMZA3fD6NOKSBtkEeH+pYgi6I8r+kehHkR5nFZPCpZPWdNARCGLAUzK1Y0066pOWgaMqR/HwERNw7XNOUm/ElNnnpYryhbuTVKZc7jdI3wqUP60P+AWjw9pUXlHd/cvyjFBcs/KI/0mIPMMcw+yBSTqPiHcgcIc+H5jcN6QcX/+ByGSEOwIjtHXeZ65zmcZxI3j4btkjQreNzLht7pwqtKQM1w1JctoEo4qJrQ71w8+HIBzhAgYfc4S4pnKj6MjsSB+qzBPnGno5sZmX6ms7VrqvZe45Lz1q9lAxuEwZ9H1OSQcN8kv7qpvGBwu9STuPvL2wkU5kYucfXe3BsGmvZvp3vv11lD8EQArq/gJinGuEmLQCMEJ6zOazJkF/dY+PP6Hy5kLSZZBMNIbPmX90nzaZ1Vsg5PIJOyCu9+oyBN6GOu00eDihV2yL4IOAvq8Kg2kDbbCT6+UuFKTen85hr7vUigoxE4n9u1d+esVzwFEy6n5tJbNJwfkATr4pKQOg1oaMfPC9Dklu
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: op/0YrdHOXxHS+3Vc/8HIBpemMXJimvgzqO5+CUv9MaWiYh24HPd9zcmnFxRtjgHX3wUs5h9FCvjH4zXc7DimHifRkIlG6JlaSr6ZsVFSFlGz50OnEZoLDOa1Gbsw13xE3+XKouiX+8m6H/5vibaa01bNWvXQdebj6LPkA0eT9fW9qiscfAxjgy64anv1Po+htGwXawmXkUFnapspz1VFccRAIJqEfl9wvF5oNeEbtCI0Ykfzh3t65j4E5N9EvSlBVmAF4x39DUxeSFe2GNpjBlkhpeeeNQ8QdYhkiZ7r4K6ZkQOuC0wABK08h15Eg99HgcRmm6bMG9px3FWT/B+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 14d81013-4ce8-4e0f-b77e-08debccaa76f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|35042699022|14060799003|376014|1800799024|6133799003|5023799004|11063799006|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: sgW7J/kTrsAzdstt2ShcGkbT03NfWu4nNr8NKCp+37l6gQZZxr85mkAG8Gr7OTft6YcsrT+0v8QWXzh2MfJf1Tq5riXJmHPdf8NWjdj0dfl64o0OVb/u2lbq+kmXoaUkeVIb8J+chtKAd9SOYbK5Su0ydvP6PKzEZ1htNYcR4Xa+Qq421ow7PAnKSe7B4FYTpQGy9RU+NbUHodn/JtSW/q0hQQzbmFrdqWMqddO2kOhhvVxYcOnJ0JtQY3K/NWLNGgGpaeoDkcJcNefVdR4dCe+gy0FChyQ3uvIkvjSk6QrHUPFqpXCVqMJQLhZFHL7XBss4d3bJeM7woneJ/YTDiwCQ07HGk8dJBt+bEj3+pZjpeiBIYzkajVDZ3fHd6DNRyjWsBwkq2DMAThY7SOWA/tDYLjb8R/2dOUn3SNeqo514jOM+zHSjTJD9tjq2t6RFO0y3pF19sgyVXnGA6YOmzmzzDMMCmOzaWVwGzo0AclqEmwFMuV53hDq/hdlBskGhAvmR4SQUXz6SIPcxYb2J5KbPBZD7iezzcSEF9Fnen92ltAneDXy8+g9sCpcHQygIgza7EKueFKjaS9JXIGaegxbm+oH1URcuHbzJtCXG/9WXRlQ9SWvGy+5F2PSz+5ta9B0FM6da/y/N+DGpkj/sPJmVMs54ztA+2zwDJ0B3agcM2kWHL+noEzNR+WStym13pgaCb20+zTWupdwy2LbnAJij5L7be1CdPBXq02vtXxc=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(35042699022)(14060799003)(376014)(1800799024)(6133799003)(5023799004)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A5f18iaG75S35sgIsaTJ1IBau+SsuN4p3ft/7bzf6ac3jCh2EQUNCsBmhPDuMxdyYpiyTAKiC1FvhNutVsURGReKMLcXpveY0tlpWlo5JD3Wm+QHfZOSctD88FzMXwfM9kwcoE98xOssn8yMEVyEbSrzC8tMQL+kq+RekmS0CAUZD3V+XysupKTWOGnX7xWrkD4FelOW/RhiNBrBU0VW79YvD2X23f87ctzlvCZ9gSkzpFNF0JMekfvizR4p3JNXv6HXXYfxnRkPPraNI4a9Kf6YYohy/SZyOL8K37ZdMbXHkZEGTLtyxJfIcZ1qHiAd84rBWkwlCJYbQZFgS98SsVoFP5MTDhfQ1N6j/M9+ji3cKaqWA6ynu3Ofa3n6EdgxpKRhITnB2PI6+UZyHlBWeoIyFlrakrG6quyyo+vDA2DrTTXWaLWQzRXE5ErWvARc
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:07:16.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 655c554e-15b0-4794-e147-08debccace45
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11902
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

Add a per-partition arbitration scheduler that queues access-window GPU
requests, grants the active window, asks it to stop when its lease
expires, and force-closes it if it does not yield in time.

Use ordered workqueues and hrtimers for grant/stop sequencing, with
module parameters controlling grant and yield timeouts.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/arbitration/Makefile  |   1 +
 .../panthor/arbitration/panthor_arbitration.h |   4 +
 .../arbitration/panthor_arbitration_drv.c     |  17 +
 .../arbitration/panthor_arbitration_sched.c   | 692 ++++++++++++++++++
 .../arbitration/panthor_arbitration_sched.h   |  25 +
 5 files changed, 739 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h

diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
index 0ea5b70d524a..83be25341ba0 100644
--- a/drivers/gpu/drm/panthor/arbitration/Makefile
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
 panthor_arbitration-y := \
 	panthor_arbitration_drv.o \
+	panthor_arbitration_sched.o \
 	panthor_partition_control.o \
 	panthor_resource_group.o
 
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 38c8f8674a02..0bc683e6a71d 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -5,6 +5,7 @@
 #define __PANTHOR_ARBITRATION_H__
 
 struct device;
+struct panthor_arbitration_sched;
 struct panthor_partition_control;
 struct panthor_resource_group;
 
@@ -24,6 +25,9 @@ struct panthor_arbitration {
 
 	/** @rg: Pointer array to resource group data */
 	struct panthor_resource_group *rg[AM_ARB_MAX_RG_COUNT];
+
+	/** @shed: Pointer to scheduler data. 1 sched per partition */
+	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
 };
 
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index ac395b89b483..5cdefd9ed5c9 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 
 #include "panthor_arbitration.h"
+#include "panthor_arbitration_sched.h"
 #include "panthor_partition_control.h"
 #include "panthor_resource_group.h"
 
@@ -19,6 +20,10 @@ static int panthor_arbitration_runtime_suspend(struct device *dev)
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = panthor_arbitration_sched_suspend(adev);
+	if (ret)
+		return ret;
+
 	ret = panthor_partition_control_suspend(adev);
 	if (ret)
 		return ret;
@@ -43,6 +48,10 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = panthor_arbitration_sched_resume(adev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -79,6 +88,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_term_partition;
 
+	ret = panthor_arbitration_sched_init(adev);
+	if (ret)
+		goto err_term_resgroup;
+
 	pm_runtime_set_autosuspend_delay(dev, PANTHOR_PM_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
@@ -86,6 +99,9 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_term_resgroup:
+	panthor_resource_group_term(adev);
+
 err_term_partition:
 	panthor_partition_control_term(adev);
 
@@ -106,6 +122,7 @@ static void panthor_arbitration_remove(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_suspended;
 
+	panthor_arbitration_sched_term(adev);
 	panthor_resource_group_term(adev);
 	panthor_partition_control_term(adev);
 
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
new file mode 100644
index 000000000000..a6c5efee7b8d
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/types.h>
+#include <linux/time.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_arbitration_sched.h"
+#include "panthor_resource_group.h"
+
+static u64 grant_timeout_us = 1 * USEC_PER_SEC;
+static u64 yield_timeout_us = 1 * USEC_PER_SEC;
+
+module_param(grant_timeout_us, ullong, 0664);
+MODULE_PARM_DESC(grant_timeout_us, "Time the GPU will be granted to the AW in microseconds.");
+
+module_param(yield_timeout_us, ullong, 0664);
+MODULE_PARM_DESC(yield_timeout_us, "Time, in microseconds, within which the AW must yeild the GPU.");
+
+enum arbitration_sched_phase {
+	ARB_SCHED_PHASE_IDLE = 0,
+	ARB_SCHED_PHASE_GRANTING,
+	ARB_SCHED_PHASE_GRANTED,
+	ARB_SCHED_PHASE_STOPPING,
+	ARB_SCHED_PHASE_LOST,
+};
+
+struct panthor_arbitration_timer {
+	/** @timer: High-resolution timer */
+	struct hrtimer timer;
+
+	/** @epoch: The lease generation for which the timer was triggered */
+	u32 epoch;
+};
+
+struct panthor_arbitration_work {
+	/** @work: Work struct */
+	struct work_struct work;
+
+	/** @aw_id: Window for which the work was queued */
+	u8 aw_id;
+
+	/** @epoch: The lease generation for which the work was queued */
+	u32 epoch;
+};
+
+struct panthor_arbitration_sched {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @name: Scheduler indentifying name */
+	char *name;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+
+	/** @lock: Protects scheduler state */
+	spinlock_t lock;
+
+	/** @queue: Pending request FIFO */
+	DECLARE_KFIFO(queue, u8, 16);
+
+	/** @queued_mask: Mask of currently queued AWs */
+	DECLARE_BITMAP(queued_mask, AM_ARB_MAX_AW_COUNT);
+
+	/** @active_aw_id: Currently active AW. Can be -1 */
+	s8 active_aw_id;
+
+	/** @phase: Current scheduling phase */
+	enum arbitration_sched_phase phase;
+
+	/** @epoch: Current active lease generation */
+	u32 epoch;
+
+	/** @wq: Scheduler workqueue to dispatch events */
+	struct workqueue_struct *wq;
+
+	/** @grant_work: Work to grant the GPU to the AW */
+	struct panthor_arbitration_work grant_work;
+
+	/** @stop_work: Work to hard-close the AW */
+	struct panthor_arbitration_work stop_work;
+
+	/** @close_work: Work to hard-close the AW */
+	struct panthor_arbitration_work close_work;
+
+	/** @grant_timer: Timer to indicate grant window has lapsed */
+	struct panthor_arbitration_timer grant_timer;
+
+	/** @stop_timer: Timer to indicate yield window has lapsed */
+	struct panthor_arbitration_timer stop_timer;
+
+	/** @disabled: Scheduler disabled. No further scheduling can happen */
+	bool disabled;
+
+	/**
+	 * @grant_previously_expired: Grant period previously expired but was
+	 * not asked to stop
+	 */
+	bool grant_previously_expired;
+};
+
+static inline struct panthor_arbitration *
+to_adev(struct panthor_arbitration_sched *sched)
+{
+	return dev_get_drvdata(sched->dev);
+}
+
+static inline struct panthor_arbitration_work *to_work(struct work_struct *w)
+{
+	return container_of(w, struct panthor_arbitration_work, work);
+}
+
+static bool arb_sched_phase_reached(struct panthor_arbitration_sched *sched,
+				    enum arbitration_sched_phase phase)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return sched->phase == phase;
+}
+
+/**
+ * sched_wait_phase - Wait for scheduler to enter a phase
+ *
+ * This method is not IRQ safe as it sleeps.
+ */
+static int arb_sched_wait_phase(struct panthor_arbitration_sched *sched,
+				enum arbitration_sched_phase phase,
+				u64 timeout_us)
+{
+	if (!wait_event_timeout(
+		    sched->waitqueue, arb_sched_phase_reached(sched, phase),
+		    usecs_to_jiffies(timeout_us))) {
+
+		if (!arb_sched_phase_reached(sched, phase))
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void arb_sched_disable(struct panthor_arbitration_sched *sched)
+{
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		sched->disabled = true;
+
+	hrtimer_cancel(&sched->grant_timer.timer);
+}
+
+static void arb_sched_enable(struct panthor_arbitration_sched *sched)
+{
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		sched->disabled = false;
+}
+
+static void arb_sched_queue_work(struct panthor_arbitration_sched *sched,
+				 struct panthor_arbitration_work *work)
+{
+	lockdep_assert_held(&sched->lock);
+
+	work->aw_id = sched->active_aw_id;
+	work->epoch = sched->epoch;
+	queue_work(sched->wq, &work->work);
+}
+
+static void arb_sched_request_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->phase != ARB_SCHED_PHASE_GRANTED)
+		return;
+
+	if (sched->active_aw_id < 0)
+		return;
+
+	/*
+	 * In the event of a single requesting AW, let it continue to
+	 * lease the GPU until another request comes in.
+	 */
+	if (!sched->disabled && kfifo_is_empty(&sched->queue)) {
+		sched->grant_previously_expired = true;
+		return;
+	}
+
+	sched->phase = ARB_SCHED_PHASE_STOPPING;
+	arb_sched_queue_work(sched, &sched->stop_work);
+
+	wake_up_all(&sched->waitqueue);
+}
+
+static void arb_sched_request_stop(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	arb_sched_request_stop_locked(sched);
+}
+
+static void arb_sched_force_close_locked(struct panthor_arbitration_sched *sched)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->phase == ARB_SCHED_PHASE_IDLE ||
+	    sched->phase == ARB_SCHED_PHASE_LOST)
+		return;
+
+	if (sched->active_aw_id < 0)
+		return;
+
+	sched->phase = ARB_SCHED_PHASE_LOST;
+
+	arb_sched_queue_work(sched, &sched->close_work);
+
+	wake_up_all(&sched->waitqueue);
+}
+
+static void arb_sched_force_close(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	arb_sched_force_close_locked(sched);
+}
+
+static int arb_sched_next_locked(struct panthor_arbitration_sched *sched)
+{
+	u8 aw_id;
+
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->disabled)
+		return 0;
+
+	/* already have a running aw */
+	if (sched->active_aw_id >= 0)
+		return 0;
+
+	/* nothing to schedule */
+	if (kfifo_is_empty(&sched->queue))
+		return 0;
+
+	if (!kfifo_get(&sched->queue, &aw_id)) {
+		dev_warn(sched->dev, "%s: queue unexpectedly empty",
+				sched->name);
+		return -EINVAL;
+	}
+
+	clear_bit(aw_id, sched->queued_mask);
+
+	sched->active_aw_id = aw_id;
+	sched->epoch++;
+	sched->phase = ARB_SCHED_PHASE_GRANTING;
+
+	arb_sched_queue_work(sched, &sched->grant_work);
+
+	wake_up_all(&sched->waitqueue);
+
+	return 0;
+}
+
+static int arb_sched_next(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return arb_sched_next_locked(sched);
+}
+
+static void arb_sched_reset(struct panthor_arbitration_sched *sched,
+				    u32 epoch, u8 aw_id)
+{
+	scoped_guard(spinlock_irqsave, &sched->lock) {
+		if (sched->epoch != epoch)
+			return;
+
+		if (sched->active_aw_id != aw_id)
+			return;
+
+		dev_warn(sched->dev, "%s: scheduler reset. active_aw=%u",
+			 sched->name, sched->active_aw_id);
+
+		sched->epoch++;
+		sched->active_aw_id = -1;
+		sched->phase = ARB_SCHED_PHASE_IDLE;
+		sched->grant_previously_expired = false;
+
+		wake_up_all(&sched->waitqueue);
+	}
+
+	hrtimer_cancel(&sched->grant_timer.timer);
+	hrtimer_cancel(&sched->stop_timer.timer);
+
+	arb_sched_next(sched);
+}
+
+static void arb_sched_grant_work(struct work_struct *work)
+{
+	struct panthor_arbitration_work *w = to_work(work);
+	struct panthor_arbitration_sched *sched =
+		container_of(w, struct panthor_arbitration_sched, grant_work);
+	int ret;
+	u32 epoch;
+	u8 aw_id;
+
+	scoped_guard(spinlock_irqsave, &sched->lock) {
+		if (sched->epoch != w->epoch)
+			return;
+
+		if (sched->active_aw_id != w->aw_id)
+			return;
+
+		epoch = sched->epoch;
+		aw_id = sched->active_aw_id;
+	}
+
+	ret = panthor_arbitration_on_grant(to_adev(sched), aw_id);
+	if (!ret) {
+		guard(spinlock_irqsave)(&sched->lock);
+
+		if (sched->phase != ARB_SCHED_PHASE_GRANTING) {
+			dev_warn(sched->dev, "%s: Grant ACKED when not granting",
+				 sched->name);
+			return;
+		}
+
+		if (sched->active_aw_id != aw_id)
+			return;
+
+		if (sched->disabled) {
+			sched->phase = ARB_SCHED_PHASE_STOPPING;
+			arb_sched_queue_work(sched, &sched->stop_work);
+		} else {
+			sched->phase = ARB_SCHED_PHASE_GRANTED;
+
+			sched->grant_timer.epoch = sched->epoch;
+			hrtimer_start(&sched->grant_timer.timer,
+				      us_to_ktime(grant_timeout_us),
+				      HRTIMER_MODE_REL);
+		}
+
+		wake_up_all(&sched->waitqueue);
+	} else {
+		dev_err(sched->dev, "%s: Failed to grant access to AW%u",
+			sched->name, aw_id);
+
+		arb_sched_reset(sched, epoch, aw_id);
+	}
+}
+
+static void arb_sched_stop_work(struct work_struct *work)
+{
+	struct panthor_arbitration_work *w = to_work(work);
+	struct panthor_arbitration_sched *sched =
+		container_of(w, struct panthor_arbitration_sched, stop_work);
+	int ret;
+	u32 epoch;
+	u8 aw_id;
+
+	scoped_guard(spinlock_irqsave, &sched->lock) {
+		if (sched->epoch != w->epoch)
+			return;
+
+		if (sched->active_aw_id != w->aw_id)
+			return;
+
+		epoch = sched->epoch;
+		aw_id = sched->active_aw_id;
+	}
+
+	ret = panthor_arbitration_on_stop(to_adev(sched), aw_id);
+	if (!ret) {
+		guard(spinlock_irqsave)(&sched->lock);
+
+		if (sched->phase != ARB_SCHED_PHASE_STOPPING) {
+			dev_warn(sched->dev, "%s: Stop ACKED when not yielding",
+				 sched->name);
+			return;
+		}
+
+		if (sched->active_aw_id != aw_id)
+			return;
+
+		sched->stop_timer.epoch = sched->epoch;
+		hrtimer_start(&sched->stop_timer.timer,
+			      us_to_ktime(yield_timeout_us), HRTIMER_MODE_REL);
+	} else {
+		dev_err(sched->dev, "%s: Failed to send yield to AW%u",
+			sched->name, aw_id);
+
+		arb_sched_reset(sched, epoch, aw_id);
+	}
+}
+
+static void arb_sched_close_work(struct work_struct *work)
+{
+	struct panthor_arbitration_work *w = to_work(work);
+	struct panthor_arbitration_sched *sched =
+		container_of(w, struct panthor_arbitration_sched, close_work);
+	int ret;
+	u32 epoch;
+	u8 aw_id;
+
+	scoped_guard(spinlock_irqsave, &sched->lock) {
+		if (sched->epoch != w->epoch)
+			return;
+
+		if (sched->active_aw_id != w->aw_id)
+			return;
+
+		epoch = sched->epoch;
+		aw_id = sched->active_aw_id;
+	}
+
+	ret = panthor_arbitration_on_close(to_adev(sched), w->aw_id);
+	if (ret) {
+		dev_err(sched->dev, "%s: Failed to close AW%u",
+			sched->name, aw_id);
+		arb_sched_reset(sched, epoch, aw_id);
+	} else {
+		panthor_arbitration_sched_on_stopped(sched, w->aw_id);
+	}
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_stop_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, stop_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (sched->epoch != atmr->epoch)
+		return HRTIMER_NORESTART;
+
+	dev_warn(sched->dev,
+		 "%s: AW%d failed to stop in time. Force closing...",
+		 sched->name, sched->active_aw_id);
+	arb_sched_force_close_locked(sched);
+
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_grant_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, grant_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (sched->epoch != atmr->epoch)
+		return HRTIMER_NORESTART;
+
+	arb_sched_request_stop_locked(sched);
+
+	return HRTIMER_NORESTART;
+}
+
+int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (test_bit(aw_id, sched->queued_mask) ||
+	    (sched->active_aw_id == aw_id &&
+	     sched->phase != ARB_SCHED_PHASE_STOPPING)) {
+		dev_warn(sched->dev, "%s: AW%u already in request queue.",
+			 sched->name, aw_id);
+		return -EEXIST;
+	}
+
+	/* Always put onto queue */
+	kfifo_put(&sched->queue, aw_id);
+	set_bit(aw_id, sched->queued_mask);
+
+	/* Already have running or pending, exit. */
+	if (sched->active_aw_id >= 0) {
+		/*
+		 * Grant timer for the current AW has previously expired,
+		 * request it to yield the GPU.
+		 */
+		if (sched->grant_previously_expired)
+			arb_sched_request_stop_locked(sched);
+
+		return 0;
+	}
+
+	return arb_sched_next_locked(sched);
+}
+
+int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (sched->active_aw_id != aw_id)
+		return 0;
+
+	if (sched->phase != ARB_SCHED_PHASE_GRANTED)
+		return 0;
+
+	sched->phase = ARB_SCHED_PHASE_STOPPING;
+	arb_sched_queue_work(sched, &sched->close_work);
+
+	return 0;
+}
+
+int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (sched->phase == ARB_SCHED_PHASE_IDLE)
+		return 0;
+
+	if (sched->active_aw_id != aw_id)
+		return 0;
+
+	/* retire old lease */
+	sched->epoch++;
+
+	sched->grant_previously_expired = false;
+	sched->active_aw_id = -1;
+	sched->phase = ARB_SCHED_PHASE_IDLE;
+
+	wake_up_all(&sched->waitqueue);
+
+	return arb_sched_next_locked(sched);
+}
+
+static void arbitration_sched_term(struct panthor_arbitration_sched *sched)
+{
+	WARN_ON(panthor_arbitration_sched_stop(sched));
+
+	disable_work_sync(&sched->grant_work.work);
+	disable_work_sync(&sched->stop_work.work);
+	disable_work_sync(&sched->close_work.work);
+}
+
+static int arbitration_sched_init(struct panthor_arbitration *adev, int i)
+{
+	struct device *dev = adev->dev;
+	struct panthor_arbitration_sched *sched;
+
+	sched = devm_kzalloc(dev, sizeof(*sched), GFP_KERNEL);
+	if (!sched)
+		return -ENOMEM;
+
+	sched->name = devm_kasprintf(dev, GFP_KERNEL, "sched%d", i);
+	sched->dev = dev;
+
+	sched->wq = devm_alloc_ordered_workqueue(dev, "%s-wq", 0, sched->name);
+	if (!sched->wq)
+		return -ENOMEM;
+
+	INIT_WORK(&sched->grant_work.work, arb_sched_grant_work);
+	INIT_WORK(&sched->stop_work.work, arb_sched_stop_work);
+	INIT_WORK(&sched->close_work.work, arb_sched_close_work);
+
+	init_waitqueue_head(&sched->waitqueue);
+
+	spin_lock_init(&sched->lock);
+	INIT_KFIFO(sched->queue);
+	sched->active_aw_id = -1;
+	sched->phase = ARB_SCHED_PHASE_IDLE;
+
+	hrtimer_setup(&sched->grant_timer.timer,
+		      panthor_arbitration_sched_on_grant_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&sched->stop_timer.timer,
+		      panthor_arbitration_sched_on_stop_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	adev->sched[i] = sched;
+
+	return 0;
+}
+
+void panthor_arbitration_sched_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		arbitration_sched_term(sched);
+	}
+}
+
+int panthor_arbitration_sched_init(struct panthor_arbitration *adev)
+{
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		int ret = arbitration_sched_init(adev, i);
+
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
+int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+		int ret;
+
+		if (!sched)
+			continue;
+
+		ret = panthor_arbitration_sched_stop(sched);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int panthor_arbitration_sched_resume(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+		int ret;
+
+		if (!sched)
+			continue;
+
+		ret = panthor_arbitration_sched_start(sched);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * panthor_arbitration_sched_stop - Stop active aw and pause scheduler
+ *
+ * This method is not IRQ safe as it waits for on_stopped() to be called.
+ */
+int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	arb_sched_disable(sched);
+
+	arb_sched_request_stop(sched);
+
+	/*
+	 * Provisionally waiting for up to 2x yield_timeout, but path may
+	 * include time taken for panthor_arbitration_on_grant() to complete
+	 * if sched_request_stop() is called while in the GRANTING state.
+	 *
+	 * Realistically, if granting takes more than yield_timeout, HW is in
+	 * bad state either way. Best continue and stop the scheduler.
+	 */
+	ret = arb_sched_wait_phase(sched, ARB_SCHED_PHASE_IDLE,
+				   grant_timeout_us + yield_timeout_us);
+	if (ret)
+		arb_sched_force_close(sched);
+
+	/* Should no longer have any further activity. Cancel timer. */
+	hrtimer_cancel(&sched->stop_timer.timer);
+	flush_workqueue(sched->wq);
+
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		if (sched->phase == ARB_SCHED_PHASE_IDLE)
+			return 0;
+
+	return ret;
+}
+
+int panthor_arbitration_sched_start(struct panthor_arbitration_sched *sched)
+{
+	arb_sched_enable(sched);
+
+	return arb_sched_next(sched);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
new file mode 100644
index 000000000000..4625b36f4ce6
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_ARBITRATION_SCHED_H__
+#define __PANTHOR_ARBITRATION_SCHED_H__
+
+#include <linux/types.h>
+
+struct panthor_arbitration;
+struct panthor_arbitration_sched;
+
+int panthor_arbitration_sched_init(struct panthor_arbitration *adev);
+void panthor_arbitration_sched_term(struct panthor_arbitration *adev);
+
+int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev);
+int panthor_arbitration_sched_resume(struct panthor_arbitration *adev);
+
+int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sched);
+int panthor_arbitration_sched_start(struct panthor_arbitration_sched *sched);
+
+int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id);
+int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id);
+int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id);
+
+#endif
-- 
2.43.0

