Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6E5C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D2310EB44;
	Tue, 22 Sep 2026 20:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="KeW11jEM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KeW11jEM";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013050.outbound.protection.outlook.com
 [52.101.83.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EB410EB44
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:12 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CosjThUJb+dwie6x/gFJ6Vgk6Zizrw7sRhzJH0nZC2cGmndzLR0Q1cQk4d4yxUQeFleoRTZAuenegkq4cs1ASDKda8BGTIb5eJz1X+cSiiw6MO/SUlrSo8VfWE6p9RxOM8Q5mS0Ovf8+de7xq9vAQExF+2EQK3y0tdY+HZaez8XB68qY2BnrJEIqBHMJyMobbPRyn2zlqSW2yPb5j/QNqr6EwrXknfxZlodUUwQexNvC1Ry4ph62Ace8HpcoP9s060HWTXTJZ4NexTU147qYF39j8532M8IxmJ9UYn0ZIU1qn96nLqtqhtKuSP6YfXZLhE96sp5d223s7EdSRZa2xQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woW4ky7LaTtybjJHws91sxpUMhAisHrZKc/3pKTju4o=;
 b=ZCB/dHozLN0jdKFfdz/LngmZB+LTO+OTuBoAbbXqTTrzaC3muFxOVP6XXpOKn0hrOQjas++H66htafKg9r6jv4yHcopxSIgea/U2BB479NZtjNgLHOd3kJO+pnJBBY8t1TyadDDktN7Q2bXhokZCPYipR4bxxL5rg18KpUG5ToNZG1bhC9I4Ehm5Y0qiJemRJDXZEZQCeBkHkqora8UogP9UVbT6M8yb440wypDjescZj2x0lrlnZBVvh21wSO2eURhoGiTcT4NeJzF4CvnJi5Z9Xj3cKHpZgf0sORMcFd96b75qqdwvlQ+moG+n7e6x/k9N91nmIEFTyNxG+qOrcA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woW4ky7LaTtybjJHws91sxpUMhAisHrZKc/3pKTju4o=;
 b=KeW11jEMyxM0eV5NHzURtOAGH/x/1f50bK6WItPFQuzQEedfpL09XcfjL8Vj2RaayOtoBdAb+GkBBBycKHqxlPpTm6ZrNHEhLWXQBajDBxqshlVpaiv3uyV4+muFHaZB8DgokJ8y3SYO75OTtFJ7Rf/Se6o+uSuvQ4R7eE+MTZ4=
Received: from AS4P189CA0056.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::26)
 by DB9PR08MB9491.eurprd08.prod.outlook.com (2603:10a6:10:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:06 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:20b:659:cafe::92) by AS4P189CA0056.outlook.office365.com
 (2603:10a6:20b:659::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8 via
 Frontend Transport; Tue, 22 Sep 2026 20:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJqLdySGdZQhDD6cr13XzctnkMss61mGApE8bkVHiFHtZr6QdpEa6N08IynhgtidDu6vWMY03WcWyPZzrWvSXAt3Q3UmH4l4FyWALpchspvnMIyKz2CBxjDlh72yf+aHWHbE9nfpkSLar8To5Si+/FRxSXTIohts5/Ohsp9p48v9JLtc1LpSdteyhnrOgxbynMpjMOGf61wINKpaVcEN3jui+cGLN15IQNfNhmqOuk2HhCQm/j7H5fFAUUPkgNVC0vdIh4TxtZHfw0fjW2TlX367tx5YwbUmcJ1FLR6CaSGAeF00JPzKoCxYsJP/B47B38A3lxIsu0NJvp4SGDtS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woW4ky7LaTtybjJHws91sxpUMhAisHrZKc/3pKTju4o=;
 b=es8c5+iEgbMPvlZCIc8lubXQi+qMujUJHmPd1AEf6PKvYzzhz1Uf75z1WmpTbQnEDFFRYtiOW4PcXEyorh5P1E3+OIp+AQDywLuBm2IwpL1cMlWO7gVWuf8wXdgdnB6gF9UqUF/6wdDkwHR7C6yFN4Te3Ucs/HS26uvnD5MOccJs523zd+l4ickJgCbNA0gthpXRT9mwHRB7D/yU9dnFCeUaxq12qf7gDDVLkuyU343ufenAVn3+Xw1p9uYjR1XDY1HxGmHlMkyHXEAD1w7rNDdfgLTDy1rPMyUKAwE/CBXLlJPUXWOIQRhk5+CA2Aychd2AQINeq4WZQ9zG3+P5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woW4ky7LaTtybjJHws91sxpUMhAisHrZKc/3pKTju4o=;
 b=KeW11jEMyxM0eV5NHzURtOAGH/x/1f50bK6WItPFQuzQEedfpL09XcfjL8Vj2RaayOtoBdAb+GkBBBycKHqxlPpTm6ZrNHEhLWXQBajDBxqshlVpaiv3uyV4+muFHaZB8DgokJ8y3SYO75OTtFJ7Rf/Se6o+uSuvQ4R7eE+MTZ4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:33 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:33 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v1 08/27] drm/panthor: Add Mali v15 hardware support
Date: Tue, 22 Sep 2026 21:45:02 +0100
Message-ID: <20260922204535.2850094-9-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0031.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::10) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|DU6PEPF0000A7E1:EE_|DB9PR08MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fc26f5-ffe4-42a2-ada0-08df18eaa9c9
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 4C1e28Up49Bn4yB4RpvSBNpGrsE3vnjBe2v5dEDDVIypErYB2UwAMHCAIGp+iU4NeDYIx9oco8vOAntcwQtcV03t5eeclfW4YVCdVhP60r0Q3DvIjsxi4Bu7JBxdd30WEstxlwHcKW84u1WqewCYdYHb9dVV4kXA9cxad4VCvKcmaaMhQEiVXtaL5ukke4g1JYazFzQDz6hmDqfI0xzlsPYOmNXExgLxrd+nD9UpQVl/PlzZtldcdcVawaMPkh4xmXgFGQRZRMgv5tYnyfWO57ugZCITowRH4Gd93T0JL58eE5bOSPWi5H4C5EfDJTHCCrvC8zAdKua5uomoSAFIO8lDH7TCAIlwF6U6L1LTe0zWT1lIWz8acHeWyfW5PLwM/8i54ltj5hP1o3kAzlrOB4V4OsGdGZD+MgBlVAZsqr4Q7mZ32r6JWkoPn2lTrfzhP8U4FMMu5gXJLfld2K15Y0QzaAji+OS2AIk+lFwLj7v/6K1+uImHXyOQ+u1RM72kSxbSP+weCEIDQqhsaQjlkIt71hVFuZ+Zl+0v4mihA5IvhIPkzBdCTkkNhhVE1fe67QHcnYjFOtx9T81oJEh2zpKLj8uf/WQC9cjcFk1b476+xrPrwFofckj62wBk6P8yd+b27md4EJTD/nj/6L+Pjj9IQRy40ke1lXJJVBCiTSs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ax3TQhiOHUf/CNGjZOPAP1DaGjYro9tIngFutNolKWCBssEhpFl2sxM17K9c3lQwfSPZVIdgmtOK/flMvwjZ6aRXeL021LUpgbZTYrkYgHSbDKQZbo1m2amJAHNfdD45gHc2OuEX/bwKzKB0xMbEBacjrYGVRiGsTkQJjvnwMuvm2JfcGjtFqhjbrZDC7NhVmyMwsJAee1/dyTeL91aRmw6y3yumWMhgBzdoMWPQwfYG6iQ6if6GcfzOUT9PaNyF7+/tVn0zNeKy7OUJ4zLjFO6ki4PcJ1HuJWO7yCR7HpX8LLj87ePMjIlgQb/0QCTZ+TWWBNANJImFmRmvrCSZQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 445aee5e-57a2-4ec0-7df0-08df18ea9651
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|23010399003|36860700016|82310400026|1800799024|376014|35042699022|7416014|10067099003|6133799003|3023799007|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5OUtRmoXVz01zbzkO0w9hQHTDssh2jq5LYi3M7Vd6VyGQlz/NtpysWhOflETCdKE2Z7FrT873jdsU1lt9hgX8JXvsf8t9mjQ32JElL3wFrCYkcLm/u5hqfpZcmseFayeX5aHywx+a0dfm2//+i3ZrUt6oijuWnWn02MrDqp0uobMr0/SFZM51+Z7+r414I97AirvTWgDRwfF2NPZr8FaQ8QSy2NYciwailsKUfz74YHqi6i5+vRTs/1LvMQC2XqbLF/qiVJKRzD1/4lXARRJH9qLeBy6qX2yMZgV+txAsasE63pTIdw6tTjcVocdjMIMl64gag0EKbI6k1+u/LvdJTxAS0MsFhKi1xkAl2WIeqoXAAqZfiwIEI8QaRtaJr6GVyywA2Y6nSIge8d4lzE8fkXYyFr4ERqOn21CWc4yLyGxZWzABnkMAeRs8bnT8HYqkuYbfOOXq7jUWKjRoa7+ZpYQq3vVKx6Z+0qbfRSHo4SrNIalVDVLw8NQJuQUctq+tbAtza7y35p1WRQXTAlepSz0MUJVBvv0u+qujxZe+eHa+kCpL/Ygh/cdl3F5ipZG0zmslM4zIifMUQOZ0756TcNJL9JQEMCXUZD0bU+O0eagrkh11q7maLqDrRsFftFuapZk4JQbHnsI9kthaT425YvhzY/IF8zEblbRpk86G6pb1PaxFS0eusklILf1bsj13LuUxR6yZJ+QrwomSglcVA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(35042699022)(7416014)(10067099003)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BKWmiO1lSNIkjsuRrfxm5dPLbYtNqmBf1hFLFQmLEHgeub0nZswy6DpmeBH1bMlNCh8IL9xC0IDSreArZ5HhXVfka6u8NrKni7zEb4zVqJ215SprbpPNxgYKxZAmwxp9rh4Bd9Ci0fzvCRh4UKz+N/Pa+9V+Lhl09xeMGTEdu+j1CoMD/pm5zStHs2J+ODUXcLV74xXHE3wiKG2mtE4Wjbrbhoe1cOjm275edNyw9RWaK9VCBLCIKQsqKdT0fIb58LzYsw9mJUNecoV7Igw9ArE8ZU2/t+x6xgJVcqHw8d6gWfbkIvtyA+JbS98AsnMN5Ah1rxhTOAOT/3SwWFVbWvAazN0X5T6/byc0zF8kUJ/r3+7z9g1/HrSMyK6ESDa/nRR2c9Kga8imVT6xBfgDEhOF1XTYO1nmWE9WXwYytIz8c/czrKUUUAo9w+y1KG3D
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:05.8720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fc26f5-ffe4-42a2-ada0-08df18eaa9c9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9491
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

Add the panthor hardware description for Mali v15 GPUs and hook it into
device matching.

This includes the v15 register map and product identification needed to
populate the GPU information exposed by the driver and its uAPI.

Add compatibility string for v15 GPUs.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- make COHERENCY_FEATURES register read use cached gpu_info values.
- Added Mali-G2 name variants and NX aware model identification.
- fix premature reading of l2_features gpu_info field during
  panthor_hw_info_init().
- build as_present using GENMASK.

 drivers/gpu/drm/panthor/panthor_drv.c         |  1 +
 drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c         |  3 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   | 25 +++++
 drivers/gpu/drm/panthor/panthor_gpu_regs.h    |  1 +
 drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 98 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
 include/uapi/drm/panthor_drm.h                | 10 +-
 9 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 8cdba0c1a14b9..3fe9f96f7755e 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1886,6 +1886,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
+	{ .compatible = "arm,mali-gen5-am" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 679ea1d233d53..1449d9a66302e 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1563,3 +1563,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index d6534fabc682e..e6e970e9b59d3 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -499,8 +499,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
-		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
+	if ((ptdev->gpu_info.coherency_features & GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
index e6bfe1fe2c68a..c4d0cb2fca92d 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -16,4 +16,29 @@
 #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
 #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
 
+#define DISCOVER_REVIDR					0x8
+#define DISCOVER_GPU_FEATURES				0x20
+#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
+#define   GPU_FEATURES_SIMD_STATE			BIT(1)
+#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
+#define   GPU_FEATURES_NX				BIT(4)
+#define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
+#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
+#define DISCOVER_MCU_FEATURES				0x40
+#define DISCOVER_PRFCNT_FEATURES			0x50
+#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
+#define DISCOVER_DOORBELL_FEATURES			0x60
+#define DISCOVER_MEM_FEATURES				0x100
+#define DISCOVER_MMU_FEATURES				0x108
+#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
+#define DISCOVER_AMBA_FEATURES				0x120
+
+#define DISCOVER_L2_FEATURES				0x128
+#define DISCOVER_TILER_FEATURES				0x200
+#define DISCOVER_CORE_FEATURES				0x300
+#define DISCOVER_THREAD_FEATURES			0x320
+#define DISCOVER_THREAD_MAX_THREADS			0x330
+#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
+#define DISCOVER_TEXTURE_FEATURES			0x360
+
 #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 753df87009901..60819c4ace428 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -65,6 +65,7 @@
 
 #define GPU_FEATURES					0x60
 #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
+#define   GPU_FEATURES_NX				BIT(4)
 #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
 
 #define GPU_TIMESTAMP_OFFSET				0x88
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e91..afb7d68abc874 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -11,6 +11,7 @@
 #include "panthor_gem.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 
 /*
@@ -105,7 +106,7 @@ struct panthor_heap_pool {
 
 static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
 {
-	u32 l2_features = ptdev->gpu_info.l2_features;
+	u64 l2_features = panthor_hw_get_l2_features(ptdev);
 	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
 
 	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 13090ff6db7b5..9d539f5f80158 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 
@@ -74,6 +75,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 	},
 };
 
+static struct panthor_hw panthor_hw_arch_v15 = {
+	.ops = {
+		.soft_reset = panthor_pwr_reset_soft,
+		.l2_power_off = panthor_pwr_l2_power_off,
+		.l2_power_on = panthor_pwr_l2_power_on,
+	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x3000,
+		},
+		.mcu_control = {
+			.offset = 0x3100,
+		},
+		.pwr_control = {
+			.offset = 0x3800,
+		},
+		.mmu_as_control = {
+			.offset = 0x2800,
+			.stride = 0x80,
+		},
+	},
+};
+
 static struct panthor_hw_entry panthor_hw_match[] = {
 	{
 		.arch_min = 10,
@@ -85,6 +109,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
 		.arch_max = 14,
 		.hwdev = &panthor_hw_arch_v14,
 	},
+	{
+		.arch_min = 15,
+		.arch_max = 15,
+		.hwdev = &panthor_hw_arch_v15,
+	}
 };
 
 static int panthor_hw_set_power_tracing(struct device *dev, void *data)
@@ -152,8 +181,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 						gpu_id->prod_major);
 	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
 					 GPU_FEATURES_RAY_INTERSECTION);
+	const bool neural_present = !!(ptdev->gpu_info.gpu_features &
+				       GPU_FEATURES_NX);
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
 
+
 	switch (product_id) {
 	case GPU_PROD_ID_MAKE(10, 2):
 		return "Mali-G710";
@@ -196,6 +228,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 		return "Mali-G1-Premium";
 	case GPU_PROD_ID_MAKE(14, 3):
 		return "Mali-G1-Pro";
+	case GPU_PROD_ID_MAKE(15, 0):
+		return "Mali-G2-Ultra-NX";
+	case GPU_PROD_ID_MAKE(15, 1):
+		if (neural_present)
+			return "Mali-G2-Premium-NX";
+
+		return "Mali-G2-Premium";
+	case GPU_PROD_ID_MAKE(15, 3):
+		if (neural_present)
+			return "Mali-G2-Pro-NX";
+
+		return "Mali-G2-Pro";
 	}
 
 	return "(Unknown Mali GPU)";
@@ -219,7 +263,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 	return 0;
 }
 
-static int panthor_gpu_info_init(struct panthor_device *ptdev)
+static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -260,12 +304,55 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
 		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
 	}
+}
+
+static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
+{
+	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
+	u64 texture_features;
+
+	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
+	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
+
+	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
+	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
+	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
+
+	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
+	ptdev->gpu_info.thread_num_active_granularity =
+		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
+
+	/* The upper 32-bits of following registers do not contain any information (yet) */
+	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
+	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
+	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
+	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
+
+	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
+	ptdev->gpu_info.as_present = GENMASK(
+		MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features) - 1, 0);
+
+	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
+	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
+	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
+}
+
+static int panthor_gpu_info_init(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		panthor_gpu_info_v15_init(ptdev);
+	else
+		panthor_gpu_info_v10_init(ptdev);
 
 	return overload_shader_present(ptdev);
 }
 
 static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
+	u64 l2_features;
 	u32 major, minor, status;
 	int ret;
 
@@ -273,18 +360,23 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	l2_features = ptdev->gpu_info.l2_features;
+
 	major = ptdev->gpu_id.ver_major;
 	minor = ptdev->gpu_id.ver_minor;
 	status = ptdev->gpu_id.ver_status;
 
+	if (panthor_hw_has_gpu_discover(ptdev))
+		l2_features = ptdev->gpu_info.l2_features_wide;
+
 	drm_info(&ptdev->base,
 		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
 		 get_gpu_model_name(ptdev), ptdev->gpu_id.prod_major,
 		 major, minor, status);
 
 	drm_info(&ptdev->base,
-		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
-		 ptdev->gpu_info.l2_features,
+		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
+		 l2_features,
 		 ptdev->gpu_info.tiler_features,
 		 ptdev->gpu_info.mem_features,
 		 ptdev->gpu_info.mmu_features,
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 68627f0df7f95..48232254fef97 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -88,4 +88,17 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 	return ptdev->gpu_id.arch_major >= 14;
 }
 
+static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
+{
+	return ptdev->gpu_id.arch_major >= 15;
+}
+
+static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		return ptdev->gpu_info.l2_features_wide;
+
+	return ptdev->gpu_info.l2_features;
+}
+
 #endif /* __PANTHOR_HW_H__ */
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 843a0b40e1d36..5c75dda5f0ae7 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -371,8 +371,8 @@ struct drm_panthor_gpu_info {
 	/** @core_features: Used to discriminate core variants when they exist. */
 	__u32 core_features;
 
-	/** @pad: MBZ. */
-	__u32 pad;
+	/** @thread_num_active_granularity: Granularity of number of active threads */
+	__u32 thread_num_active_granularity;
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
@@ -389,6 +389,12 @@ struct drm_panthor_gpu_info {
 #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
+
+	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
+	__u64 gpu_rev_wide;
+
+	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
+	__u64 l2_features_wide;
 };
 
 /**
-- 
2.43.0

