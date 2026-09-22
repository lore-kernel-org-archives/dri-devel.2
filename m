Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9EDC98309
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D44C10EE5B;
	Tue, 22 Sep 2026 20:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="IjSnJARH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IjSnJARH";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8309C10EE54
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:46 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ymLclv2mPGOzVcjhwEpHI8g2JkLnUjew0CFOmYc1IRgtCDpwY1hn/mEIs/6qhEZA9yuoTi7HEK2AqZ7z0cgikX5F+4FnSSnhoHOqItFoxEFpWdpoxNI18u8nFqQARzzvnqT9uzl4Pu3UBqxlfPsnad3+2/ReknlZyxN5+y+p2j8JeYQGqXO23ZgiKlc29jrGqIxjaa6j51VZU6t8OkALkJd9uUyKd9SvaOJ+0IaUQc7hIz7chF009MIs6th+0/I6+PP6icQMMDq9++oocCt3ZJfB6SxbX1tEBI7PDWMa3FQDlNeqc0+kUk9ZoNdAk/hZQ5WjB6qYZWZYs6D/K4MGMw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzeGUNMReTPebAjte1WClRekkaq00b78t92YFAi7B3E=;
 b=xyL0NiD8dEjCJbzK27SWxAqjdPKIrwrYwp/YLDrD3Nm56fYpp1asdyCVIXJzUMrkJA2ustjx2/lPLGeXW3hX1a9gQDvJ3B+lUhIgJku50VQ1zbzp+W4MDwOEJpukAFrgsG24wozkC18vvCQNeAo/3Zvpc5802XM12C6IgWr0sjhJP7lR5wQ/mEPgUF7jFyOnSmXk6JUyUiWKlaBr2gHGiQlh+ufTXxg/epbksgbAttQzONkFrpf8HvtuP7fWMSy72NxTYaAv1G1t1Vpmxvj+xvJOFZMSeNctC99gmdD2pgABAxpGryO/ThKFjvjECFg4XGM/Dkat0XoFFHBZ31Fg2w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzeGUNMReTPebAjte1WClRekkaq00b78t92YFAi7B3E=;
 b=IjSnJARHnY/Shq1k9Y09O8hsrVIoMqUGDiAquXA7ebjy42mzDasIpsN+R0zvBD65ot+0yL8q3r1q8AkhRsYAkToF2qNGFIFKcdB5D/XPruYaq+XvU2umEzIKq+OQouzw5Kdnv4ve9MS0fww4nEdr34L7jVTI7R54P9vgyOd3oWY=
Received: from GVZP280CA0089.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:275::9)
 by MI9PR08MB808160.eurprd08.prod.outlook.com (2603:10a6:290:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:41 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:150:275:cafe::82) by GVZP280CA0089.outlook.office365.com
 (2603:10a6:150:275::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9o4+qm422ADNRv9VQ7bJVyHJXp1lavDtsIofunPPWjLv07CdMyt1si9ep/SD/vD3/hJKj3JVo30pfj1ZXXX4WUHzdJgUlmB6HVsO4evxg+F/FQTOp+Ewx2F6/pFwJSGYImqpQv/2uSH0qshldIQuJ/lzpWAJeMya3gcX0A/sAKaJQRYqNQe83ICWuN2wkZGtl6JimLMs/shJNeYcQ8IeSgIlHZl5RrHwHYWVyNEWUX1WSrzmXVQbT4fd6zPuP9r5fLi2hs/ETy/4Jk+Jrwg4NtVJDNtM8DIKlsrecBac2/JgMePnhKd4Vcm0jhhfoTInl6E5ToiEBkmaQUKcBmpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzeGUNMReTPebAjte1WClRekkaq00b78t92YFAi7B3E=;
 b=aghjV1NyAO7bXL2MLrqsE1CqP3UxgeywbPEEAy8jQ9ttNmorz0SC+7B6NiJiiM95WGVmfruBGCEcMFPDmhuETNn3JptyKEMGLYY2qfYdI6MbBYrVzhLeRfX5SBfVk0hWxQsls3o8iSKHvchuj1/krAf/8Gh4zHKuUp0vlNu87lKt7O3A/1yXbOwucDFk1a7RdS+4NSmVXYdJLr1eWlT1dRX2qiBHP5aL8dza6Ewrxqo40MLCuix108tBHYkDEoFuEg2GsweOQ3gLcRl7DBkjV2vsYxChZR3bBXciFjlSt/5sAWAnXZZK/T1oxx4PhICOBmkEf5nQUiTuAC8ZLiH3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzeGUNMReTPebAjte1WClRekkaq00b78t92YFAi7B3E=;
 b=IjSnJARHnY/Shq1k9Y09O8hsrVIoMqUGDiAquXA7ebjy42mzDasIpsN+R0zvBD65ot+0yL8q3r1q8AkhRsYAkToF2qNGFIFKcdB5D/XPruYaq+XvU2umEzIKq+OQouzw5Kdnv4ve9MS0fww4nEdr34L7jVTI7R54P9vgyOd3oWY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:07 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:07 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 17/27] drm/panthor: Route arbitration events
Date: Tue, 22 Sep 2026 21:45:11 +0100
Message-ID: <20260922204535.2850094-18-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::12) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|WA1PEPF000099CE:EE_|MI9PR08MB808160:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bb45fb-796c-4d0c-4e8e-08df18eabe64
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: sPA6xk/4j0p/z4MaMG/65yXDheGKiStfG0LsYMDgqjcXgP4WG6oQ8g2FJaijXwuAyTXV5PH6bx4VwVeNPyL+WhSIcwq5eajKfzmH81wpPL/bkhuh+aAhZlW4XIOK+X2MmMnt0hpxfwCPjIk36FFfonef3AYiUCbyB6XDFbMWPga2TjIxmQMNU7dbhbm/ERepnHc0skrbZigOX6rk1neNODsj5ObVq/zlFfV/sV79jg4qCXBYGTI8xQ43PdPa/D0+BCXVnFPiSucJMG0T007MStMLIEqqlyYL3u7ERrES75lheAD+Z2FqWPurLJvarbViuDa4iu9YtGdBZ0AVqjTCyGdg7wDwCvLX2EYI1kJxku1vC1pqD/M6/n/p+w86kOfOXYYF5a++9HhAzSqF0e64gn1MhxqX7lxko1rNXpD6VwQc0VIXLtWnQYXhaaJC1yqeUMHgiqx+CuMtFg0gmeXFMlJUpeUx3ZAn5vzfs2I3bhRh4RwSIZ5dVS6THyZ2mLlzvCFl08rXzbGog37RPM+1X23HWxRa2WttnVSYsVqkF5Xw1riBwKgqDeI4acI8K8ihwXVSjwH8e3F155UIOnfs/qlhGGiZ5uPOBoCmtTtkaKxcXcojAo9z5E876+GVfonIX34ljTLGVPLaZ/XXeil7G8C9Tip9i1XVPbEUNBoCQ40=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: N6AR9ORcn5cgyegUi7i62lUqqOJKMl/UWR61ojWkIzh2lh5eDoKnTD1VyKcpZ+1P35TdVFt2k/FlZ3STpv0GoQxksq5r43+DooKcAdLY/QjGw5Hsi8y/E4HAFAYC0KsX//ikiF5jrR3sKYJWaaBmfEQVhcBPe+mu9DhiigBBeO6V/gUvJzyze2a7rxvth+6YnRW//9hqw7/5tCzwdwJ01wB8MJ3jNhJMV5/9C+o3aBdWw+WSSBSNcTgSTKgD/c1bgooXBYeKHmkGdWl4AVFjV2mbezWP4E2F3EVe07ESNCaloyWi+oJ076sNm4/k/BawC0IkEbf3Wxyf2HHmmzNSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e4b60a06-fce2-4784-e37d-08df18eaaa6c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|82310400026|36860700016|14060799003|23010399003|376014|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KaNr1YnVLcxl6a9PaDrdM7UZ7+eLM92RRSm6hh4b2NLkp47VBQvf5Tl+3OJ1V91X+w/CDcBaYTSUbN6hcDRXnDxDkNIZVyraniqx+588soQeIe0W5ZTjR2RaBXI62h9L+bToOFKdUrZsU49909Q8mqtHDWiN8k+ILPbFAZ+uvDObWaxlknQku9PeEYOyT/t2hAKQP6DsCfO/l7aGqwptP06ra5ZEwyx+Yy3u9qVzm9UvYNtilmZDZUWijQHY9UuYVJQH1VMwiUS81jIZxFQ2v2WpqIUJkesHZjF1Sjo9ZZ8h3kHSIgUqcK5Wxk2SvVYjfDK0oHNTc7clS+ctzUvHoTWBb37ZHrV3D2sMwAOoxiLvsUk2aWPmQKMAGToj0ZrwVLF/P8wJ+D3XhKI+EB5l//kVMILctVgJtnz2w7+SBbR54ibFRhlGOiqBWGQh1vZbe7OIapPWBa92niW7BNR0aUk0hDZP+QShp4ILsXBfQERJz7i+56YA5ik9Vie5r2sejngab3s7Kew8h9ZYc9koglQD8fyEU5q9pbFBYIJtSLHc2ao8Vq+FGH7U1OSTwcL8+GCkclO/yCPxgVV1OoynqMYdnazAWJn6sdy1HhELVs20NinTRc/SKmaMUDVMv+R7lw1Cy4evuI6c55FFvudBMH3oTDDre8GaiIHYXdJgmIUmsAzcYb1ptxqNXW8RoBPFppB+BFpO/w0A4ta7g/S21g==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(82310400026)(36860700016)(14060799003)(23010399003)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yBJxXovWswbj5SMk1VXfCYN8ByXhVcoJy0bANnpIlTfKwUufXwG9ZbugwQ401ufxtyDZcSlH/jUYYHYGgpJjVwsDfsvsnaGAqxRrLFJUeoa67Ek7dga0C5tP9cQ4i1pfajeK9aJsaBJpUniSTGulRSeelulZ4F9MCh0OQod7itGHEFVUs/1V8tWRE6FmZyhDCYignHm2LvJu+Oyxe4/PAw9qcElC3hUDMyZl+R8muUoZwkO04J77V11IFfboynY7GTrn6ZzFejBd84BKVhID+lmXNszAunQ0TU3E+MJN/vFpHjPEG5AZSBDRFlXikxQ99XxPvwAdqikjw/xQ75zzhLAkBJ0onIwXG8s2XWBRSVGFUKXHWogacRwepV/WDixb0w9eelDoiTBXFT/nLp4OJzkawl/7OiRCWga+XfxUGzs4lFbiRlWq6FVO7vYHqUVx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:40.3500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bb45fb-796c-4d0c-4e8e-08df18eabe64
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB808160
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

Wire the resource-group, scheduler, and partition-control blocks
together. Resource-group messages now feed request and idle events into
the scheduler, while partition RESET_DONE from a YIELD_DONE or
CLOSE_WINDOW reports the active access window as stopped.

Add the arbiter-to-window callbacks used by the scheduler to grant,
yield, and close partition windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Notify arbitration scheduler when RESET_DONE completes due to
  close_window, as well as due to yield by Panthor FW.

 .../panthor/arbitration/panthor_arbitration.h |  6 ++++
 .../arbitration/panthor_arbitration_drv.c     | 28 +++++++++++++++++--
 .../arbitration/panthor_partition_control.c   |  9 ++++++
 .../arbitration/panthor_resource_group.c      |  4 +--
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index eeae8219b2894..149221333eb1e 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -50,6 +50,12 @@ int panthor_arbitration_parse_resource(struct device *dev,
 				       const struct fwnode_handle *child,
 				       struct panthor_arbitration_resource *res);
 
+/* AW to Arbiter events */
+int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id);
+
+/* Arbiter to AW events */
 int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 2d0c8d95f1abd..723cf605e16a3 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -95,20 +95,42 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	return 0;
 }
 
+/* AW to Arbiter events */
+int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
+}
+
+int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_idle(adev->sched[0], aw_id);
+}
+
+int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_stopped(adev->sched[0], aw_id);
+}
+
 /* Arbiter to AW events */
 int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id)
 {
-	return 0;
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_open_window(adev->pc[0], aw_id);
 }
 
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id)
 {
-	return 0;
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_yield_now(adev->pc[0]);
 }
 
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id)
 {
-	return 0;
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_close_window(adev->pc[0]);
 }
 
 static int panthor_arbitration_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
index e6fbf5e58b51a..95c26015cb637 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -163,13 +163,22 @@ static int window_open(struct panthor_partition_control *pc, u8 aw_id)
 
 static void partition_handle_reset_done(struct panthor_partition_control *pc)
 {
+	bool notify_stopped = false;
+	int aw_id;
+
 	scoped_guard(spinlock_irqsave, &pc->lock) {
+		aw_id = pc->current_aw;
 		pc->current_aw = -1;
 
 		/* RESET_DONE from CLOSE_WINDOW */
 		if (pc->closing)
 			pc->closing = false;
+		if (aw_id >= 0)
+			notify_stopped = true;
 	}
+
+	if (notify_stopped)
+		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
 }
 
 static irqreturn_t partition_irq_raw_handler(int irq, void *data)
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
index 9bdd0876dd457..ba345233c7db2 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
@@ -140,10 +140,10 @@ static void rg_handle_message(struct panthor_resource_group *rg, u8 aw_id,
 		rg_respond_to_handshake(rg, aw_id, message);
 		break;
 	case VM_ARB_GPU_REQUEST:
-		/* TODO: on_request */
+		panthor_arbitration_on_request(dev_get_drvdata(rg->dev), aw_id);
 		break;
 	case VM_ARB_GPU_STOPPED:
-		/* TODO: on_idle */
+		panthor_arbitration_on_idle(dev_get_drvdata(rg->dev), aw_id);
 		break;
 	default:
 		dev_warn(rg->dev, "Invalid message (0x%llx)", message);
-- 
2.43.0

