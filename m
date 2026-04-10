Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD95F459F7
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0429E10E9BC;
	Fri, 10 Apr 2026 16:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qpSzN/kC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qpSzN/kC";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D2E10E9BC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:47:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UswsXsvsbzpiRsiEaplD+bp7yYD8gd1LoOrMJ7uk2DUeBxmlCFaxv849mXDGBagywVxa2XodizThQmwJqPleTjErErlM90/4onHQ09oAO+oet5vQdJqab2/+X+Ad4EYUla4lDFWhQNApE2FViE0JgoFQHtAZtU2aQZQH53dEGJNSLziyr29hB+JrdctGz6U54KnLHRhUve1j29qocCPdGsKoRkuaP7yqvKyix6588xD70uVJACzpAWZFQAyyFFdyJMuLUZmX7nn40HSLc7r9HRP5WtJQw4qPiErZEFoEZ9XURuviW4C8i3PY/SGZ5rZGyXu48y/CXNvlk6UmfspUdQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYKbVN8JOcWYN1w/OaHBReUT63zAVcD2bLg65yPDNr4=;
 b=dHX2N7nLrIIMxOxSWtM+n8T8oSMZt/3Lr+wDF3QhuhBDicO6Wze/ym9HKtRZAsXostYvfOY/Qgk1NEwCUwvfe1pg8uC2cvdodsyyTlGBPgTmJ+gr1FujY+lsRBXvsv3tQLelSYym9ZnwRfzEVXDiJ1o5zMgP+IXRYVaJsKAeoMYE9FUSznEyK1Kt87KEI0HB/Ex+SIlwT1zINuZo8CWvZ/A+mn+1hvll+/lu/+LAAIRMevsUVy26nfxvT7EI0lACqsBhY7nrDr/d0jksKq4FGLOJhiSEsEcR+nDt97eQ/Fq0bOKmJ5U/W93blczbItOBN5BsEmUpv6UfifAzfsqhlA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYKbVN8JOcWYN1w/OaHBReUT63zAVcD2bLg65yPDNr4=;
 b=qpSzN/kCsEatldSw8tGqqOU4PrAZDjJ3mqDKv7ktvvZ8lBe4kPxrssIurSGtmHxmChTiCXwkxWmzImaqRzfhr7DMuEbK1/opPQt9pK583cTA2o2hZ4FYWuYfPcyZb73mJBA+hrDw50y6PXP2AyC11XDwgFeDLoJtd3bNc0z0wSQ=
Received: from DUZPR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::6) by DU5PR08MB10551.eurprd08.prod.outlook.com
 (2603:10a6:10:525::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Fri, 10 Apr
 2026 16:47:53 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::b1) by DUZPR01CA0113.outlook.office365.com
 (2603:10a6:10:4bb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 16:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via
 Frontend Transport; Fri, 10 Apr 2026 16:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjFWyzxj/B73BgslbbMevkKFgFxA8ctrAqBpE8NWHBNQh1RYmnkkGewnzRSjqJ0m2l9Kic2NxIqAZW5ZcLb0Bzu117DMTmujzwv7Xj55GwS/yIFSGyq5wkAJxdffitM/YKKqaS/HDWXClMTwMXMta+oqv101JbibM1aQOo5hopz2xo5aaqbJ5gNmtehnBBZGeF074hPp9VWwqb/zw9UsFKnRIcNXMI31Hy8HCXw9hvQxBNFQoEOmkn0uZH8S6LlFIFfEpqmmzDFiB9ZTj96eEmk28pAEDADioQHAZBSSwTa8fjGff4qc0t5W/hHFRneOgRe2ZZuBoyopzHiBwPQDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYKbVN8JOcWYN1w/OaHBReUT63zAVcD2bLg65yPDNr4=;
 b=uuBpqHOR1MXUJIQcaly0p61D73TWblQA8ldZ0+1QKOGxyQKe0d9OEErjDI6eGHJRTbkXBezJE5c9WHzTU6oDAC3SKsQEzu0lLJooeTzNPJ3SYf6waBXREX3xsqkJKwgUqkxbNQuDrsjQJop5U8CRKAzAynRVLuzNXepuKOIEA1AUsBnrG93FkRPGE/SCVLcQZyy7njZNHQutw6+YpLBER1DtLDxsuZq2G6vtySdLjK+6AIs0dLA/NenB0JfBqZGf8tOc7Na1jqfL2IoJq9TgVWc2WL2ouyCUW0sBEl+T8flp0bgRA9p8kFX5iA66E0M5BGPSEbS7QfFjVpuQGDQLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYKbVN8JOcWYN1w/OaHBReUT63zAVcD2bLg65yPDNr4=;
 b=qpSzN/kCsEatldSw8tGqqOU4PrAZDjJ3mqDKv7ktvvZ8lBe4kPxrssIurSGtmHxmChTiCXwkxWmzImaqRzfhr7DMuEbK1/opPQt9pK583cTA2o2hZ4FYWuYfPcyZb73mJBA+hrDw50y6PXP2AyC11XDwgFeDLoJtd3bNc0z0wSQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:45 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:45 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] drm/panthor: Replace cross-component register accesses
 with helpers
Date: Fri, 10 Apr 2026 17:46:32 +0100
Message-ID: <20260410164637.549145-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::21) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|DU6PEPF00009527:EE_|DU5PR08MB10551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d61e2a8-753a-441b-c4b0-08de9720e894
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: 0/X00Ou0dmxPjldfhXjnPUpCsWrHnXvhAK0FdaY3iOO7Wy+K9pZDt784hrCVemPxV9HGs6YOTfnB6FwS1gkgwXWmY3gdgykoVxpgd3F6So+A5+0OmLS8PnYLNO3d4pyPm3QJZNLxc00qg3DPTQ4c1p/ZEdgopTn84z1ycmRS5nklKaxx2N0Vk+qStqaC/RL0ZVD3nP/ELF0UukdcVnnY8u45r7U134Uy0ktFrobYH1/k7907N02ON7V8fbzBuwsweEvctSUi/WDGB2f91rjI0sTE+fTlskI2XBiv7PGhYt7uZcK6td5F/t3W8jerfw0AiMMnrc88tBJbylVL7yiSmEB+Tjl3VI96cdh09BC+jVzud7rKPYIblO/HhcrvRm3MlEn+B0vtsaZXg46+mFbG4ScftsgzBKa0/rr2FRPONckfJl1mDwT2HxUilQg+tR3YOYS9o9b4mhgYfepBsfAyzvDN+brLDi8uhwqgj8uXQH8F8kxO1wRu6DEsuFmpCeFGqwWKDn7Dw6BKs9tfG4rFt7+Cgy1M7OblssXtiTYzcoY2LGvV5AUw4Bdg6+y4V0scRmcIBGREgoujyU5EOoOF11zcKfxurjzwRkkKyDxwhBJY06Agfonq6Du2oTjnbQ5/yylRY4b6L5rbQhFAzUHcY6+5U65RayNG0Hkt1hp31OVqaIydT6EmmGVImQUX8PsZaaRKZOrukfAuaAMWkL090QyEBoSQOEQ4iml5d/8lQXU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: wnhMo/m2oX8sViPR1szorW71zYfb4WYsynHtotMN78U8qSqSGxL20Z53bb8TjbaHuE8zUuLlYDpLVaX+nV12fCHPnVI+bzvCTLLhDej6RShv7OW4Si3Yita1CVO8Of5VlyJT0Od+i3yfIel03YEv4ohLEFtHr55GQKR4wAAFvBImjrLSgsIrAh7s0EChvLWAiht3dYiyb+42kdROVNCwlDfGqgiw7uXLBqedhV1aTW+ax+6yr/mivKHlT8F86JxSj8TY5k4IewiXz2zBwSxUmyHbBznIjhbnDjelVll7LtOrlj2utVpVKax+b3uFsJbMFlEi/GrgBomkvR5S2hN8Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 93e0c867-f68b-4574-41b3-08de9720c02e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|82310400026|36860700016|35042699022|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: oW42rO7dKI78OA5sluwRNHqFKSBdnIkl/sEqLzEMKLVMsR6Y3ZYJN0lz4Aetn3QOtrppbj0LCYXxQ9DpZZozb8663G0pyHrBDR/TqGBOQQaiSCN6bSPUDYBn5jZMrDNsjtzm1ZbW8NAIgBo5dLY1xsDWEUYC+6J4r9LhFs38/TOtJ7pB5LaD6worN4pPNsn791TrW1sejmvvWpva9E0hU1+ycN/w2Zj7tnsethYvmIvzEHvrrww00H0ob+pgDhvsZQMfuwKzrcB01oL/R8pkWTxhNA7rpuVdeW4Bi4eLS7uawnXf6uiBUhbrUl1HXNHL9uTyKOBDLieegE9TUUQ0mo/eRXA26HKs4JEde5xL9C4uaaX3f2C/0nLoWgiNpmunTwaqs1/xGl72R0uKMZrcleQ2c/KH/V0YOq7KmH3toZw8TriX6As/3JyPfFubeoesOwZZdllccO+L67+OSdB+kePWdtDjYGcTNQnHVi27vvayAiHI+McxcJ8dw4If8Bd7KpQineW4193G8YxXHKOYGThf51YiPoJ9G9r2CjuMG24qvPjKBF5b89MSfewCQ7DB6Pp8ziacXgNDWX0sryzCA0h8+z0txSz+6CLpyKYkh+HBTgFSNZa0VpzPOTiyTXxrAEgMKqZ0CnN2dviFqXr/bQ4Ff0VcsBlR4FbGsjw90gkaACAoIFk6KDUyl6sjdE1x0KyORp2RPtFXJztoYSrTIcKWP5Ek80Qtb6n9zfIbRJfhBJ/r7b0TmuVD96RVl5dOdZI4y1euXLAGZ5p3X5kwBw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(82310400026)(36860700016)(35042699022)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DhqdWKamfuzahYHJfROq4E+bGV+WGM+jztxhYvxzjRpJAF0fHOxuH044xjKLI+Mdln2+F9A3V0WLAkkubkcMlGc81xQnhC7bFlwuU6lg6hNyb3Z2lJ3ztavHrSOG3ohA9yKIKIxQh43BSM57OJW5cQ48vMTCrKG1oWlI4NDw8+zTwnOrt569NsvtlH6Z6zvBAswewMak0vS0n0NScEz5g/LqpXU/EyPTJylCWDEGeScZ7+HkHm0uV0bhtD8aHyTs2W/t5SsNoJjG3vojkQuH4e5C4kiANsgprABlo+1hUcgH835e6oN959+d+YMgn9lUtaCORQzGraTqIrgwVMw02bOjGdf6gTI9x6ETp9AImdCZJRhK1cDn0lrvCtSpW8jG4bTrNPGm11HaBSomRw3vraeEKO4b2WnPyHBDWJBv2prsvHEkI7LjDsuYIENcC2gz
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:52.8859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d61e2a8-753a-441b-c4b0-08de9720e894
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10551
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

Stop reaching into other components' registers directly and route those
operations through the component that owns them.

Move the timestamp/coherency helpers into panthor_gpu, add a doorbell
helper, and update call sites accordingly. This keeps register knowledge
local to each block and avoids spreading cross-component register
accesses across the driver.

This is a preparatory cleanup for using per-component iomem bases.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 27 ----------------
 drivers/gpu/drm/panthor/panthor_drv.c    |  7 ++---
 drivers/gpu/drm/panthor/panthor_fw.c     | 15 ++++++---
 drivers/gpu/drm/panthor/panthor_fw.h     |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c    | 40 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu.h    |  6 ++++
 drivers/gpu/drm/panthor/panthor_pwr.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c  |  2 +-
 8 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index f876b13492ae..bd417d6ae8c0 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -22,38 +22,11 @@
 #include "panthor_fw_regs.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
-#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_pwr.h"
 #include "panthor_sched.h"
 
-static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
-{
-	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
-	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
-	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
-
-	/* Start with no coherency, and update it if the device is flagged coherent. */
-	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
-	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
-
-	if (!ptdev->coherent)
-		return 0;
-
-	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
-	 * ACE protocol has never been supported for command stream frontend GPUs.
-	 */
-	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
-		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
-		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
-		return 0;
-	}
-
-	drm_err(&ptdev->base, "Coherency not supported by the device");
-	return -ENOTSUPP;
-}
-
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e63210b01e6e..8cd39e6c3f5c 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -34,7 +34,6 @@
 #include "panthor_fw.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
-#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
 #include "panthor_sched.h"
@@ -839,7 +838,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
-		arg->timestamp_offset = gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+		arg->timestamp_offset = panthor_gpu_get_timestap_offset(ptdev);
 	else
 		arg->timestamp_offset = 0;
 
@@ -854,7 +853,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 		query_start_time = 0;
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
-		arg->current_timestamp = gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+		arg->current_timestamp = panthor_gpu_get_timestap(ptdev);
 	else
 		arg->current_timestamp = 0;
 
@@ -870,7 +869,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
-		arg->cycle_count = gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+		arg->cycle_count = panthor_gpu_get_cycle_count(ptdev);
 	else
 		arg->cycle_count = 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4704275b9c8f..1c13a4884201 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1054,7 +1054,7 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 			       GLB_CFG_POWEROFF_TIMER |
 			       GLB_CFG_PROGRESS_TIMER);
 
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 
 	/* Kick the watchdog. */
 	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
@@ -1156,7 +1156,7 @@ static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
 	else
 		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
 
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 }
 
 static bool panthor_fw_wait_mcu_halted(struct panthor_device *ptdev)
@@ -1400,6 +1400,11 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
 	return ret;
 }
 
+void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id)
+{
+	gpu_write(ptdev->iomem, CSF_DOORBELL(doorbell_id), 1);
+}
+
 /**
  * panthor_fw_ring_csg_doorbells() - Ring command stream group doorbells.
  * @ptdev: Device.
@@ -1413,8 +1418,8 @@ void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_mask)
 {
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
-	panthor_fw_toggle_reqs(glb_iface, doorbell_req, doorbell_ack, csg_mask);
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_toggle_reqs(glb_iface, doorbell_req, doorbell_ack, csg_mask);\
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 }
 
 static void panthor_fw_ping_work(struct work_struct *work)
@@ -1429,7 +1434,7 @@ static void panthor_fw_ping_work(struct work_struct *work)
 		return;
 
 	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 
 	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PING, &acked, 100);
 	if (ret) {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index fbdc21469ba3..a99a9b6f4825 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -500,6 +500,7 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_id, u32 req_m
 int panthor_fw_glb_wait_acks(struct panthor_device *ptdev, u32 req_mask, u32 *acked,
 			     u32 timeout_ms);
 
+void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id);
 void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_slot);
 
 struct panthor_kernel_bo *
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index fecc30747acf..ef0aca2b7532 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -427,3 +427,43 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 	panthor_hw_l2_power_on(ptdev);
 }
 
+u64 panthor_gpu_get_timestap(struct panthor_device *ptdev)
+{
+	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+}
+
+u64 panthor_gpu_get_timestap_offset(struct panthor_device *ptdev)
+{
+	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+}
+
+u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
+{
+	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+}
+
+int panthor_gpu_coherency_init(struct panthor_device *ptdev)
+{
+	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
+	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
+	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
+
+	/* Start with no coherency, and update it if the device is flagged coherent. */
+	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
+	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+
+	if (!ptdev->coherent)
+		return 0;
+
+	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
+	 * ACE protocol has never been supported for command stream frontend GPUs.
+	 */
+	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
+		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
+		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
+		return 0;
+	}
+
+	drm_err(&ptdev->base, "Coherency not supported by the device");
+	return -ENOTSUPP;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index 12c263a39928..c22378e5ce48 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -54,4 +54,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev);
 void panthor_gpu_power_changed_off(struct panthor_device *ptdev);
 int panthor_gpu_power_changed_on(struct panthor_device *ptdev);
 
+u64 panthor_gpu_get_timestap(struct panthor_device *ptdev);
+u64 panthor_gpu_get_timestap_offset(struct panthor_device *ptdev);
+u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
+
+int panthor_gpu_coherency_init(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 306592ff2227..aafb0c5c7d23 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -199,7 +199,7 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 
 static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 {
-	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", gpu_read64(ptdev->iomem, GPU_FEATURES));
+	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
 	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
 	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
 	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 70b8a22b3ed7..60e7b4e20a13 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3373,7 +3373,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 		if (resume_tick)
 			sched_resume_tick(ptdev);
 
-		gpu_write(ptdev->iomem, CSF_DOORBELL(queue->doorbell_id), 1);
+		panthor_fw_ring_doorbell(ptdev, queue->doorbell_id);
 		if (!sched->pm.has_ref &&
 		    !(group->blocked_queues & BIT(job->queue_idx))) {
 			pm_runtime_get(ptdev->base.dev);
-- 
2.43.0

