Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C47C98304
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16E110EE62;
	Tue, 22 Sep 2026 20:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LCHWR7VN";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LCHWR7VN";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC3510EE5F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:55 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zU0hTFMtJ9annmEy4FhXQUPkDDv4YeCHuqYkr21zpLC+4SMuJzg3RQn4f+d1zdLw0fs/pxJJTslLY3VZ1+vGQoV09wfyox8OP/NacDWp27tCk9tuH7VZmZD3ZaEI0ywJEwXtP0oOcsOc0QbrQ50DIg3sy8UYBva4vXDCPbQ2bwfbQYtKpNYEIB+5nb2KaYSX3QWwnYA/7vRvNyk1PyqryiuHbUuRRZYe4CF4Wy3/jx1ZK69ybLWjqflo0NWzVEvhq6/emPxJrym19I7QXguSXQ0lv6B17DKXv8XqvqD2LEapjJ5Wz1Kn0v7ZJttBbSv8emh7BNUWfzZsvjcNPZ2Zqg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UeYNoRfYQfkid8h1HObcVh9J7Etq4WOGznh1icA3vw=;
 b=Qx2DKgOzZLmwbtn0xH7HnZ9mylLHHGK7Xki60SBwhjM9bPLFi/CkjLqFvITOBGtMU3ogEK7pB/mNhOhcINPM+GT8RAdyl6AqmBSHstISWaQy6penZ3w0xSa0RMaTZkPOh6AapkEjKzxFVbJ7V3h14rHbDu4A08z/dGxMp4FPP870ebdPTdtY7ZccoTQpsOtHJM78b9djX0BDpnWJd2XUgy3cUgnk9al+Hx+jXQAVegbauKy8T+UPvhgdv+6CNUeZNvIU23oBBL+SauupqTy0ti75uORD02e2IhetvPeIp84VqhPEOr5lZ/29Ry4ttiXvxr4OcF35ey1fEJ4ldliEDQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UeYNoRfYQfkid8h1HObcVh9J7Etq4WOGznh1icA3vw=;
 b=LCHWR7VNvW8MEME0E+/rxOVaJJGN/IJQmk4rbX6s5DJOkV2aw8Z6GbQHBbgRmxyCL4mKTTnIDIBOpx6owY69Ldn3qTRV9gtrgePw6ujc2CURxtiJM6ca3rrBqmcbcn+HgWTndYJuUfL7oos8k1Y1j4QJbfcDxkG7LPGrJbEHSiU=
Received: from DU2PR04CA0307.eurprd04.prod.outlook.com (2603:10a6:10:2b5::12)
 by GVXPR08MB7896.eurprd08.prod.outlook.com (2603:10a6:150:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:49 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::24) by DU2PR04CA0307.outlook.office365.com
 (2603:10a6:10:2b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 20:47:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCi4V0HvG8uVX9HSBLvk227kqy/evqmX1rR1xEJtFeLUgfVR30Zw6ducDqdTkZ0CJxEfZKNSY7yh6hwW9AVtzL/QOLRRayyvbdLnwmK5Lrs9YPEv78gL+UKiIJa0fko3bBvtnmkExnWR8vkb6datXvxVUapvgZNX+C+nK4pyHLmBMzfPB2wJLJOv6I+cOLluBHmYoZ4d/Gl5gD2qlnHbDqwgOdXiRMczM96KcTnNbJlRePgmvoPjCTQYsWJf+QnvvdmGJ/zyjgqkSCKIsTizp4Ig1tuLcokAx2qyXXkI/BwEHH5cv86XaYNb82accFAYvfPrv34TuANLb5KkpVEc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UeYNoRfYQfkid8h1HObcVh9J7Etq4WOGznh1icA3vw=;
 b=aTAxd6BdXT9Es/sZfJLUyAWy+lRLRzUoNaZr9Xv/Ctm1w0GbrmcMjGbewc4KLJ+CJZxW4ZQbn/PsAx8yauKOMqVB1/xGKeGjKvoJayCg7uuZ3oNZOPv90FkH+qQJAgCL3I2Hg47jIQtKuGGY9DLJ0MRIvzlQO3GdFTbqBf9mAvpUP7FZULgZSLyWeIG6tJxscxsjbXr5EqXuERyD/aL928PxuW39H8ZWiVt49qX8m/s2y3jOakykPyu2hdN/sCLEzvjUgkD37H+FPmN36HfcHWmDiTy/vqfQuYUFntn1E37sYhljT78ZRmgIlJ2mxMbwjXigFY3BvhX2F0SqdI20tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UeYNoRfYQfkid8h1HObcVh9J7Etq4WOGznh1icA3vw=;
 b=LCHWR7VNvW8MEME0E+/rxOVaJJGN/IJQmk4rbX6s5DJOkV2aw8Z6GbQHBbgRmxyCL4mKTTnIDIBOpx6owY69Ldn3qTRV9gtrgePw6ujc2CURxtiJM6ca3rrBqmcbcn+HgWTndYJuUfL7oos8k1Y1j4QJbfcDxkG7LPGrJbEHSiU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:16 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:16 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 20/27] drm/panthor: Handle partition control
 INVALID_COMMAND interrupt
Date: Tue, 22 Sep 2026 21:45:14 +0100
Message-ID: <20260922204535.2850094-21-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0665.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::16) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|DU2PEPF00028D12:EE_|GVXPR08MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: f340b994-9791-4073-418c-08df18eac39c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|5023799004|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: CSPJ6M8TMiC1RhOK1OqDah9p7aPhAxCib4BGhv2tWdl08XDeseo5fGAG0bLlnBmmvlXLzLQ1zcT9BokXC+eCWfPbDE+pCrqdy9/EoYwEXnL9H94P+rRH6hkKcO/D25wPFtbRTX1x458qgtnxqnyhp4YtfENxVowr8zH3LKCz8Y8/b58/yZRZHpRS7dEK6zS0d/e08Dxsc07Szsd1vDuaig8hEBfELmr92Or+MJUhsYNKyrj5chRspK+NTlebhy1581ku2ICCxgvmZDYx+NUvpPPRdxwDWBkmCQIvuoW0fyAGRxOocu+2e38uqIrnm1btAWlpXhNhyOe0XtZ/Cnv1fjEDL4BYK+Dk7/l/ewyO4LHsGhWc5J9bpTwJGcBfGysPVGiCDW3cvdIu/8PxrukmTSom01ktJtH3y8mRMSCa6aXBiQSfmHUwqzsP2pPU54b8wJVV6pUnU0xGYPKeWI7VJ45Xl/vyFa7DDNdblEXyNrFMs7O2flumnhalRz6TpUVoqVcfJ6QmxEZJtgckwMEsA0X/HDQ7h36CV1HbsfKgxvdXbQj8OnWTRj/aG/ud1y60JAw2erjn+dc5evAskHBBESDHF8fuGix0+8i8AQQWgjEqu9Wx3YJDYR475pvbgqMVNs7FQx1Dp1j8/m3mFaIOgE+Tykh11ragIwjgjvfnO3k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ro0HsC5xPausfD8L1WENiVIqrng1qeaV5C5RayPQwIcWYQaMJU8qNjEaTtY3QHHw+1GuHziIQ2nmRj6fyGmvVysJBGFoN/SZodi6+XJPJlWRAGDIEsSAmumTRKwOKBfdSEjX/9C77EM2grWiJc+6Zz1CwfNrxtZnR0FjlOyzmYhrNofuoNx7VGjJenVSvepe7YUixgquwDdwLNT49f2RFy6ss7ubOOffIBHF4ZVHYPgyFH/cR/gK3T1w0JoijiRD7/bRFMalhiUQZN0m4SCZi+ycwHEDs/yYVSGO5Wqhg1bsue18TU4LkucFr3mp3/KXr3qVIDEeDKPJMw4yN+Vj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1ec708c7-926a-4bc5-a199-08df18eaafa4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|36860700016|23010399003|376014|1800799024|35042699022|10067099003|56012099006|5023799004|3023799007|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: d8qYNHBseZEnzAV8stlHw0n2vYKocSODVUl3pIC07vf4Lf94yIe9L/URiYGcsZOOtZW+sVITChj0MS5hz1q4SqVqyTrt0OF4mTSIrnGPGpS7wJ4ySPxfUzl2/o9gX4QIfPPFUA5wEQL7AYcl81Lf3I5KiaqiF14btHkvq5JXruB4G4y1r8GXqTtGmKpfjyjuPzUC0dunAeOe8LLZDwXMUTERgZyP1d5TbnbIbhSUVECBQPRWuiAcwA6B45U+DOH53tkCb4V9tr8zUNQHs2ZGHxbrlmjVEyhq3QP4RLNZp2kKLcWc+gGPQu0TEnhOODlfVR3eRcr0O9wsjSe3SJBQB52YR6xslqIBZT1g2RhP5vhOMhfFhcuN4KroEAjQ2k3AATGQCDZK+JsfLvA3T4GG/43l8Zz1xe/SZ9aL2+6HFfSwk4+EJaPRGJxqD3oQzq2SKLFxUu8iyLCoQagFB4os4wqorkGzTUMnJvn2FFAEoww/x24x8ewLxLgAlkRhSOBpdbCSM2I5cEgAYRFIYQXylqbOhdqsWulyBabYumxxUODARnRsn6YjFsHm4hvIswrpPv6goYvEpQChC8fVcHs8xTZWbxEcEWRoaY29xjvOwpNBfb4KwVHSFD5RhU9NTGDBM6/f0JzenwWhU5Z4cDPT5IUr0urXFmag1fZvZC25RSUtAEE28n8Sc2kMxkzEPEtJxD2HIXw/ImAYs2uWubW7Rg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(35042699022)(10067099003)(56012099006)(5023799004)(3023799007)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BK7+4QBW3OLyzing8wIILs6KLx5Q5B2IfWpgXMGXOYK/FkTn9DFjPY07gDAW+Z2DEq0eXHBuwbAmYTVgLUoJzc87bMv+sluhyk6bXZaIs27hKbHLhGdjF4J8qKpMgbOTHvMFe1WFhR285InL6BlbXUGhbeE2adkS+RYWmasIOAHKg5mSy3IGnQrA8YuBLordaG79CM75FU/qL+YKCtTTojWlv5BhftRpKaE9fpUx4wONXiX2nxAYw7zvuRJGXtn50fufLb8wgDaK9rgN2Hn81PByfbPpiCE13DW42eYFEPLOOGdNnRjnCh8exmD8PqtqXZ5UavjrmYlU/aTwTYjeIf4fOtDvZLnixcrWFc0MBjFYtpJpu/Nc8Cxo00R792bYocMaLOzBuB/SzHuqmItqSNMKnwuFQys15l557BfqitXExy95tp9Z2lO/M9DFHg0i
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:49.1919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f340b994-9791-4073-418c-08df18eac39c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7896
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

Partition control commands have specific partition state requirements
to be valid. We cannot afford to wait for the states to complete
transitions before sending these commands as it would work against the
arbitration scheduler's goal of handling phase transitions as fast as
possible (i.e. in IRQ context).

Fortunately, the hardware raises INVALID_COMMAND interrupts in cases
where the partition state requirements are not met. In such cases, retry
commands when the partition state permits, and request scheduler
recovery when an open-window command encounters an inconsistent
assignment.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../panthor/arbitration/panthor_arbitration.h |   2 +
 .../arbitration/panthor_arbitration_drv.c     |  12 ++
 .../arbitration/panthor_arbitration_sched.c   |  10 ++
 .../arbitration/panthor_arbitration_sched.h   |   4 +
 .../arbitration/panthor_partition_control.c   | 108 ++++++++++++++++--
 5 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index e1d569158ac6c..53d64abb50379 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -75,4 +75,6 @@ int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 aw_id);
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id);
 
+int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index f44cd45ea342e..3cdf03f3f4879 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -298,6 +298,18 @@ int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 aw_id)
 	return panthor_partition_control_close_window(adev->pc[idx]);
 }
 
+int panthor_arbitration_notify_err(struct panthor_arbitration *adev, u8 aw_id)
+{
+	int idx = to_assigned_sched_idx(adev, aw_id);
+
+	if (idx < 0)
+		return idx;
+
+	panthor_arbitration_sched_reset(adev->sched[idx], aw_id);
+
+	return 0;
+}
+
 static int panthor_arbitration_probe(struct platform_device *pdev)
 {
 	struct panthor_arbitration *adev;
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
index 9e26b8f92b69a..df0785a80442c 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -729,3 +729,13 @@ void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *s
 
 	sched->disabled &= ~BIT(reason);
 }
+
+void panthor_arbitration_sched_reset(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id != sched->active_aw_id)
+		return;
+
+	arb_sched_queue_work(sched, &sched->reset_work);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
index 803a405964a4e..ba43cc19f0eff 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -6,6 +6,8 @@
 
 #include <linux/types.h>
 
+#include "panthor_arbitration.h"
+
 struct panthor_arbitration;
 struct panthor_arbitration_sched;
 
@@ -35,6 +37,8 @@ void panthor_arbitration_sched_disable_set(struct panthor_arbitration_sched *sch
 void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *sched,
 					     enum panthor_arb_sched_disable_reason reason);
 
+void panthor_arbitration_sched_reset(struct panthor_arbitration_sched *sched, u8 aw_id);
+
 int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id);
 int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id);
 int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
index 95c26015cb637..446f77fc67891 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -28,6 +28,7 @@
 
 #define AM_PART_COMMAND				0x100
 #define   AM_PART_SET_COMMAND(x)		FIELD_PREP(GENMASK(7, 0), x)
+#define   AM_PART_GET_COMMAND(x)		FIELD_GET(GENMASK(7, 0), x)
 #define     PART_CMD_YIELD_IDLE			0x10
 #define     PART_CMD_YIELD_NOW			0x11
 #define     PART_CMD_CLOSE_WINDOW		0x20
@@ -40,6 +41,15 @@
 #define PART_REG_POLL_SLEEP_US			10
 #define PART_STATE_TRANSITION_TIMEOUT_US	5000000
 
+/** struct panthor_partition_cmd - Partition command data */
+struct panthor_partition_cmd {
+	/** @cmd: AM_PARTITION_COMMAND value */
+	u32 cmd;
+
+	/** @aw_id: AW ID the command was sent for */
+	int aw_id;
+};
+
 /**
  * struct panthor_partition_control - Partition control data
  */
@@ -64,6 +74,9 @@ struct panthor_partition_control {
 
 	/** @closing: synchronous closing of the partition */
 	bool closing;
+
+	/** @last_cmd: Last sent command */
+	struct panthor_partition_cmd last_cmd;
 };
 
 static void partition_irq_suspend(struct panthor_partition_control *pc)
@@ -101,18 +114,45 @@ static int partition_state_wait(struct panthor_partition_control *pc, u32 state)
 					false, pc);
 }
 
+static inline void
+partition_command_write_untracked(struct panthor_partition_control *pc, u32 cmd)
+{
+	gpu_write(pc->iomem, AM_PART_COMMAND, cmd);
+}
+
+static void partition_command_write(struct panthor_partition_control *pc,
+				    u32 cmd, int aw_id)
+{
+	lockdep_assert_held(&pc->lock);
+
+	partition_command_write_untracked(pc, cmd);
+
+	pc->last_cmd.cmd = cmd;
+	pc->last_cmd.aw_id = aw_id;
+}
+
 static int yield_now(struct panthor_partition_control *pc)
 {
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
+	guard(spinlock_irqsave)(&pc->lock);
+
+	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW),
+				pc->current_aw);
 
 	return 0;
 }
 
 static int yield_idle(struct panthor_partition_control *pc)
 {
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
+	guard(spinlock_irqsave)(&pc->lock);
+
+	/*
+	 * This is a notification to yield the GPU once FW is idle. It is not
+	 * a command that must succeed. Nothing of note is lost if the command
+	 * fails apart from some minor scheduling optimisation losses. We can
+	 * skip tracking this command.
+	 */
+	partition_command_write_untracked(
+		pc, AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
 
 	return 0;
 }
@@ -127,8 +167,8 @@ static int window_close(struct panthor_partition_control *pc)
 
 	pc->closing = true;
 
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
+	partition_command_write(pc, AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW),
+				pc->current_aw);
 
 	return 0;
 }
@@ -153,8 +193,8 @@ static int window_open(struct panthor_partition_control *pc, u8 aw_id)
 
 	guard(spinlock_irqsave)(&pc->lock);
 
-	gpu_write(pc->iomem, AM_PART_COMMAND,
-		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id));
+	partition_command_write(pc, (AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) |
+				     AM_PART_SET_WINDOW(aw_id)), aw_id);
 
 	pc->current_aw = aw_id;
 
@@ -166,6 +206,8 @@ static void partition_handle_reset_done(struct panthor_partition_control *pc)
 	bool notify_stopped = false;
 	int aw_id;
 
+	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_RESET_DONE);
+
 	scoped_guard(spinlock_irqsave, &pc->lock) {
 		aw_id = pc->current_aw;
 		pc->current_aw = -1;
@@ -181,6 +223,52 @@ static void partition_handle_reset_done(struct panthor_partition_control *pc)
 		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
 }
 
+static void partition_handle_invalid_cmd(struct panthor_partition_control *pc)
+{
+	bool on_err = false;
+	int aw_id;
+
+	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, PART_INVALID_COMMAND);
+
+	scoped_guard(spinlock_irqsave, &pc->lock) {
+		if (!pc->last_cmd.cmd)
+			return;
+
+		if (pc->last_cmd.aw_id < 0)
+			return;
+
+		if (pc->last_cmd.aw_id != pc->current_aw)
+			return;
+
+		switch (AM_PART_GET_COMMAND(pc->last_cmd.cmd)) {
+		case PART_CMD_YIELD_NOW:
+		case PART_CMD_CLOSE_WINDOW:
+			if (partition_state_get(pc) == PART_STATE_WINDOW_OPEN) {
+				partition_command_write_untracked(pc, pc->last_cmd.cmd);
+				return;
+			}
+			break;
+		case PART_CMD_OPEN_WINDOW:
+			if (partition_state_get(pc) == PART_STATE_RESET) {
+				partition_command_write_untracked(pc, pc->last_cmd.cmd);
+				return;
+			} else if (partition_aw_get(pc) == pc->last_cmd.aw_id) {
+				return;
+			}
+
+			on_err = true;
+			aw_id = pc->last_cmd.aw_id;
+
+			break;
+		default:
+			return;
+		}
+	}
+
+	if (on_err)
+		panthor_arbitration_notify_err(dev_get_drvdata(pc->dev), aw_id);
+}
+
 static irqreturn_t partition_irq_raw_handler(int irq, void *data)
 {
 	struct panthor_partition_control *pc = data;
@@ -194,9 +282,7 @@ static irqreturn_t partition_irq_raw_handler(int irq, void *data)
 		partition_handle_reset_done(pc);
 
 	if (status & PART_INVALID_COMMAND)
-		dev_warn(pc->dev, "%s: Invalid command", pc->name);
-
-	gpu_write(pc->iomem, AM_PART_IRQ_CLEAR, status);
+		partition_handle_invalid_cmd(pc);
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0

