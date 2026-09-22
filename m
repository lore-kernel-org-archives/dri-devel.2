Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C607C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D2A10EE53;
	Tue, 22 Sep 2026 20:47:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="plItAced";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="plItAced";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013058.outbound.protection.outlook.com
 [52.101.83.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8448210EE53
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:33 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EBuVYvVNO7FDiQQkhL9MLsy+E56DryyGmgfimsWfiCqmKo5v6TRGOsAXVfjctE8lft2vDhHBNLxbFp3jqpV3z2l2I9XbTTD7NEg+swhn/s7cSTeCQrCg9tyg3/K7k43ei67pgi0qFawax02tc211+/DDqbXPI88w3ek0Vn9ENPKX8IL1LvOs3Ivtx01kUW1NTMcQilTjYAPF5I7Q5Cx8h4/J0aVo9nV1TSS1K3j2ZGJVQrPURR6XhmTFQCi6gQTCO8FL61cxNvAE+8yPMV9aKhhjHrEC2hbAzNyNySYjF0ovutFehwTc3qE8O175px5IZ7juPadMMz/SfGBsSPrmIA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlJSwUJSWsbKbhjhq9Zr/UwId01rGUa8y1X9pQIEf8o=;
 b=MIXoI09Vp/RmOy46XV5lLBr/iH67SMft9xtJD1p66HZRS3Xkdg1F1M1SD/I7dUpTLRhIcQwANGRMxwTwq2W0iebnbbysgljutelijVzBcfO71Wkk1xtRJkbFsHjPaGcCEcdyFHyLehbkIE4hVmn8XqJvHCV87sw5+4Hibb8dQQ8eGohd3B/U+WyhWE9oZzLWlD/FwHg1oHDdeTC7c4HQAoRcAt4skPfp/E301H9PZeyX2SFJuBsFtO8OKaRb/sOhzVhQdNudCizVOnTU/tG1QsL8R1KSJe/BumbsjWW52Qca4N0caFvyVoC4/+KtzkyIZTXMu0Ro5YPrnWKfmGL03A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlJSwUJSWsbKbhjhq9Zr/UwId01rGUa8y1X9pQIEf8o=;
 b=plItAcedQ4Llw09XgepfSiuJx8GAqfUt9w28EW8duw5xAV567WWd/+n5F77gZi2a4hQDMLqxzNAIkTUnCqVNwMx2zHBd9yJZDWr4czPp7kGPK+Ct+/fwy0bdRijmXSraFN5K3owLB9ubqSScGewGzUJLVXRNk0qNWVJ583k/eA0=
Received: from AS4P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::12)
 by PA6PR08MB10444.eurprd08.prod.outlook.com (2603:10a6:102:3c7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:28 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::9e) by AS4P191CA0015.outlook.office365.com
 (2603:10a6:20b:5d5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4cYgwxj47JDUIjK/14bmh9GD7r5U+tz0eu/FYBqUGXfA5PPiR+Z5uSKOTPlRUkG9DQ6x77pHbOe/O9quaSlbvrhLWS7Uj1owtiOabWl0AcEepw403IIYlJ1uxQCYYqtusvU+FKD+pNDjRjhKIhipC3Q5I3shGqNT7WMSb9+DvUGUnyENJQsxoyZ/Fc/HrFNk0PxUycyGTsuFrn+H4DZHc5nSRQFGufZFt0zzUGQs8BmB+YwgqYg/G/B3wGQL1vOuVquk1S3SM4bUJB8nSx5OncvVNOOyeOAlUWFYTmGcu5NuhWOgiuhaOJqbFbgDzXbP9xoJMDlxxQuWkHg+obxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlJSwUJSWsbKbhjhq9Zr/UwId01rGUa8y1X9pQIEf8o=;
 b=qDIqc8sAr0q6i/qOG2tXzABd5STbrrXatLohrNOldNsadvSYvvybGNBOAkw92cE5ItZ1emWXMYaQshbAP8swde731FhzD4j59EbLy/dVtVE+6vlUn08SMY1zeyC/4l96DSJJuWXHlhDHAjZRlxp5iardKP47YNSsD8eg+TT3XgfxnrsxHEKbNSzFC/jtRaDOJE2wdGsOqYgJcQ3BdV0fVqi1wkuWOr17SfIVvJZKOLfCtiBseLJ0PEoN4o75z7cUn0ior2Fs9bsLdU9NE3ud4b9TP+SKvpTCYfBCzpKbIXvOcPmzdDAtGpxyMsZ5qI9Wgh22ZZt2QpoRFUYII8btgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlJSwUJSWsbKbhjhq9Zr/UwId01rGUa8y1X9pQIEf8o=;
 b=plItAcedQ4Llw09XgepfSiuJx8GAqfUt9w28EW8duw5xAV567WWd/+n5F77gZi2a4hQDMLqxzNAIkTUnCqVNwMx2zHBd9yJZDWr4czPp7kGPK+Ct+/fwy0bdRijmXSraFN5K3owLB9ubqSScGewGzUJLVXRNk0qNWVJ583k/eA0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:55 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:55 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 13/27] drm/panthor: Add AM_PARTITION_CONTROL support
Date: Tue, 22 Sep 2026 21:45:07 +0100
Message-ID: <20260922204535.2850094-14-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|DB1PEPF000509F6:EE_|PA6PR08MB10444:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1fe265-a4a3-4cbb-31ce-08df18eab6be
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: SSKH1DK6ZwDtnL/Df30hBY/dEqs5GXjpqHdbdLPrvVpByyY+a2XGkB1yGvgog0b3L+1YB7YkYb0ruo72rEguRqTkuc9p3Jh3Z7wlQ+HirJ9FY4cDod4Iiykr0J1Gus4wDu8jG5JIH2sCDB6Yr9Kl0mRwhAunLEnhR1ESTBKMKK72rulqk3xEU1xDW6A0ys8EULKVvi/knpP7LlfBl8+l9z4QDiPKdokdKSaJ65/vXKl/7ofKQFI3PEH2FBEQ/brAME1eLArV2qSl/DEQ2jlkCURm3GsapWLqI9a8+nzF9pL+z++04veQYMSWhxt/NbqDX+SYbAaewzHMRGHmVmq35TPmQiNP6G0viJw/NNLeywqIEqsRv6OkJOehfjvzgV4vz25jbbc6TlW81Nj/VZoFdo4qeY6gb1FODhEfXCOOhwIKRvZC3zlifknxwTeYwcKYU3BNUI81g/95/dcbAyJlJUV62HEFYH3HkqcSdZ2sy9AZ03Fcir7hhXyKesmADIjNJi9NXRvVnMYTEJm7Q4Pu+a84Qbv05+O6AWKFLvz5j25+Dx9PRY/qtuxKOx4ug0cpEobnRm2L/S+mtzIn44Agm8Vlx3JtgWhhj8sfa5pVcVJskYG2Uo967rPEFv/t2hrP8KwuCeqjbhwHlZRBU/cgM1rnA/77fGEpyjoICm1Ejd8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: moxw2egnduObJ/VbiK38XCZxCC/lr+Xh2FY8e1bkmuJIcuu92IzeEto8c+IbCHXtnr7qbodHTFGySnYwwbVLLsBM1HHPiHlAKZ2bxDXwX9zGzY+7K9pOwvpiUgHT5+NQwUanz/HxUSBkcf5nfyZ9v05mwMzxsJ8moltKhZDRfIy22Jl31EmA6EOxpxQr8ksMsUoT+px7eQ0ziAbQvHmFlcYJJl8HiKGDs7Vi4BB1BcMQpjfuiCp7tLK2kB+pdMSlVJ9MqycBMHk4sUxwA7gRlaN8leeRZ4kznjJeIlrPp3hKMXBqa/LboXerlpRB/2pWUlaG/Ded8MN5JjdbrYpfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6ecaf20f-c6f4-4a12-3bdf-08df18eaa347
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|35042699022|82310400026|14060799003|23010399003|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L++be7Tk3z9Tm7OisdKdSpUbJMl86ZaDddgcDWp31nto4lSGYlR3MBGd23yHH8ntEj1pUSffUI2dyfzhdJ7nQeg0XO3L/ABJO6z1ZpZ8WVuYgClIt3hAYw6FwsHT9th5TSSGwgqAEXxCeQ/Cjac0tJWxXKPCYouQ2avivzTJUCNh7Ric1924jP+vxtQoJcTuY7CWgxuASG7GO+ClILtfcMMKE/yhTRYePaZTjQuAz7wEHAaDqYqJ2+fPlmPo8xhG4UlBZtwuxUcF+UaoSCNi8lWXK8aSFInWYC6O9smZ5x+dwEX7OgsWlaNV1a6maQzq0oLfO0kuF0aur2kH3sGDKOiLg5y3/gCJj7bzyFn0ABFBkthMzGWGvclbubRvg1KRA6PahmcZGLYDO/m6Y3SldKMOLmOwZ/SQEcYr2qKWZ8p+NFrk1Dh2QKfnRC/gXHPE46XP+EocYy6d+sClG0eFfJXf+OjjrEw+hjuQeWiYJeUDYIcAOdJk5wnl/sAvyPMfB/PowiLrFPv746eQHtTrMya82yB2uSMGTNivQwXnoqtNz+cMr1wWzuGmsOp1Geg98DXJbFS4eh1y23xIaMp5yJXVMdqg5SUoU4McloMOgBZd3ZOAg6sK9tC8kh9aqdwSoAi3sgo5xWUq3C89PMiObWdqHQh9bhAbHu18pt0Bbt+lRNLwc83Ho/HXrPF762gGDZP/PzpXHs3JG35ZYGEm6Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(35042699022)(82310400026)(14060799003)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IgJV//jNneCS1qrvztE2dynMvjFS7MWG2nrclesYJbGef825cm/rP3P8fHGfJ2rJyRnYipogENmvHFm2rc5a5QnPMcwVIUjYxmNIZoBCLT6OkVi9rleE7LF/Qy+Jfe/sS4L9AB5sXAard8wKuU/AipLsTpeTKIZjTjG80EyGsP08cdQ9EqTqZqkvrbq8zzj+vOjgpEQ1crgDHcGSgdgOayz1vxuDQvTh52VgVjpb0b4aEf8lpEhhqZzPK/OReuDkcC3xgUeUxjG2lKrDW0Jy7cKWEYopCtGf1DTZpbvZDcoZnhw/oIuG9DfUXqcuFgiZ5jlq2KxKFF3sVraxMCNxRU/vPOWeSehX+qEb0Cm1wf2x+XQL9c5JYtdvkcE7XWpRFvZgxGrVluhyilpegD8Rm5eurCWxzZNnoZKqxLVNUK4i1Hh6cUSKZ9yF7mZAaVer
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:27.6138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1fe265-a4a3-4cbb-31ce-08df18eab6be
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10444
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
the panthor build. The driver maps partition-control registers and
interrupts described by DT child nodes. It also provides helpers to
open, close, and yield partition access windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Updated DT structure and accompanying parsing to handle child nodes
  instead of named platform resources.
- Add child device population/depopulation.
- Remove blocking waits on partition open, close and yield operations.
- Adds YIELD_IDLE helper.

 drivers/gpu/drm/panthor/Kconfig               |  10 +
 drivers/gpu/drm/panthor/Makefile              |   1 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |  13 +
 .../panthor/arbitration/panthor_arbitration.h |  40 +++
 .../arbitration/panthor_arbitration_drv.c     | 174 +++++++++
 .../arbitration/panthor_partition_control.c   | 333 ++++++++++++++++++
 .../arbitration/panthor_partition_control.h   |  29 ++
 7 files changed, 600 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/arbitration/Makefile
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index e17c93035e8b7..04b11b933290e 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -30,3 +30,13 @@ config DRM_PANTHOR_SYSTEM
 	  AM GPUs. This block provides GPU-wide control outside the main GPU
 	  register window, including reset handling and management of shared
 	  clock and regulator resources.
+
+config DRM_PANTHOR_ARBITRATION
+	tristate "HW-assisted virtualization for Mali 5th Gen AM GPUs"
+	depends on DRM_PANTHOR
+	depends on OF
+	help
+	  Enable support for the arbitration blocks found on Arm Mali 5th Gen
+	  AM GPUs. These blocks manage partition controls, resource groups and
+	  access-window scheduling, allowing multiple access windows to share
+	  GPU resources under hardware-assisted arbitration.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index 488a5e03efbc4..5d4d0ae64952e 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -15,5 +15,6 @@ panthor-y := \
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
 obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += system/
+obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += arbitration/
 
 CFLAGS_panthor_gpu.o := -I$(src)
diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
new file mode 100644
index 0000000000000..b0b6b2e3edf8d
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -0,0 +1,13 @@
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
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
new file mode 100644
index 0000000000000..26950e47852dd
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_ARBITRATION_H__
+#define __PANTHOR_ARBITRATION_H__
+
+#include <linux/ioport.h>
+#include <linux/fwnode.h>
+
+struct device;
+struct panthor_partition_control;
+
+#define AM_ARB_MAX_PC_COUNT			1
+#define AM_ARB_MAX_AW_COUNT			16
+
+/** struct panthor_arbitration_resource - Arbitration resource */
+struct panthor_arbitration_resource {
+	/** @res: resource parsed from child 'reg' property */
+	struct resource res;
+
+	/** @id: id parsed from child 'arm,id' property */
+	u32 id;
+};
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
+int panthor_arbitration_parse_resource(struct device *dev,
+				       const struct fwnode_handle *child,
+				       struct panthor_arbitration_resource *res);
+
+#endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
new file mode 100644
index 0000000000000..09342245a47d1
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/types.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_partition_control.h"
+
+#define PANTHOR_PM_AUTOSUSPEND_DELAY_MS 100
+
+#define DT_ID					"arm,id"
+
+int panthor_arbitration_parse_resource(struct device *dev,
+				       const struct fwnode_handle *child,
+				       struct panthor_arbitration_resource *res)
+{
+	const char *name;
+	int ret;
+
+	if (!child || !res)
+		return -EINVAL;
+
+	name = fwnode_get_name(child);
+
+	if (of_address_to_resource(to_of_node(child), 0, &res->res)) {
+		dev_warn(dev, "Missing 'reg' property in %s", name);
+		return -ENODEV;
+	}
+
+	if (!fwnode_property_present(child, DT_ID)) {
+		dev_warn(dev, "Missing '%s' property in %s@%llx", DT_ID, name,
+			 res->res.start);
+		return -ENODEV;
+	}
+
+	ret = fwnode_property_read_u32(child, DT_ID, &res->id);
+	if (ret) {
+		dev_warn(dev, "Malformed '%s' property in %s@%llx", DT_ID, name,
+			 res->res.start);
+		return -ENODEV;
+	}
+
+	return 0;
+}
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
+		goto err_term_pc;
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_depopulate;
+
+	pm_runtime_set_autosuspend_delay(dev, PANTHOR_PM_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+
+err_depopulate:
+	of_platform_depopulate(dev);
+
+err_term_pc:
+	panthor_partition_control_term(adev);
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
+		dev_warn(adev->dev, "failed to resume during remove: %d", ret);
+
+	of_platform_depopulate(adev->dev);
+
+	if (ret >= 0) {
+		panthor_partition_control_term(adev);
+		pm_runtime_put_noidle(adev->dev);
+	}
+
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
index 0000000000000..e6fbf5e58b51a
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
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
+static int yield_now(struct panthor_partition_control *pc)
+{
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_YIELD_NOW));
+
+	return 0;
+}
+
+static int yield_idle(struct panthor_partition_control *pc)
+{
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_YIELD_IDLE));
+
+	return 0;
+}
+
+static int window_close(struct panthor_partition_control *pc)
+{
+	/* Partition already closed. */
+	if (partition_state_get(pc) == PART_STATE_RESET)
+		return 1;
+
+	guard(spinlock_irqsave)(&pc->lock);
+
+	pc->closing = true;
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_CLOSE_WINDOW));
+
+	return 0;
+}
+
+static int window_open(struct panthor_partition_control *pc, u8 aw_id)
+{
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (partition_state_get(pc) == PART_STATE_WINDOW_OPEN) {
+		u8 cur_aw = partition_aw_get(pc);
+
+		if (cur_aw == aw_id)
+			return 0;
+
+		dev_warn(pc->dev,
+			 "%s: OPEN_WINDOW(%u): Already opened for aw=%u, state=%u. Closing...",
+			 pc->name, aw_id, cur_aw, partition_state_get(pc));
+
+		window_close(pc);
+	}
+
+	guard(spinlock_irqsave)(&pc->lock);
+
+	gpu_write(pc->iomem, AM_PART_COMMAND,
+		  AM_PART_SET_COMMAND(PART_CMD_OPEN_WINDOW) | AM_PART_SET_WINDOW(aw_id));
+
+	pc->current_aw = aw_id;
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
+		if (!WARN_ON(window_close(pc) < 0))
+			WARN_ON(partition_state_wait(pc, PART_STATE_RESET));
+
+		partition_irq_suspend(pc);
+	}
+}
+
+static int partition_control_init(struct panthor_arbitration *adev,
+				   const struct fwnode_handle *child)
+{
+	struct panthor_arbitration_resource res;
+	struct panthor_partition_control *pc;
+	struct device *dev = adev->dev;
+	struct irq_data *irqdata;
+	void __iomem *iomem;
+	u32 irq_flags = 0;
+	char *name;
+	int irq;
+	int ret;
+
+	ret = panthor_arbitration_parse_resource(dev, child, &res);
+	if (ret)
+		return ret;
+
+	if (res.id >= AM_ARB_MAX_PC_COUNT)
+		return -ENODEV;
+
+	if (adev->pc[res.id])
+		return dev_warn_probe(dev, -ENODEV, "partition@%llx: id (%u) already present",
+				      res.res.start, res.id);
+
+	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "pc%d", res.id);
+
+	iomem = devm_ioremap_resource(dev, &res.res);
+	if (IS_ERR(iomem))
+		return dev_err_probe(dev, PTR_ERR(iomem), "%s: Failed to ioremap", name);
+
+	pc->name = name;
+	pc->dev = dev;
+	pc->iomem = iomem;
+
+	spin_lock_init(&pc->lock);
+	pc->current_aw = -1;
+
+	irq = fwnode_irq_get(child, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "%s: Failed to get IRQ", name);
+
+	irqdata = irq_get_irq_data(irq);
+	if (irqdata)
+		irq_flags = irqd_get_trigger_type(irqdata);
+
+	ret = devm_request_irq(
+		dev, irq, partition_irq_raw_handler, irq_flags | IRQF_SHARED,
+		devm_kasprintf(dev, GFP_KERNEL, "panthor-%s-irq", name), pc);
+	if (ret)
+		return ret;
+
+	adev->pc[res.id] = pc;
+
+	partition_irq_resume(pc);
+
+	return 0;
+}
+
+int panthor_partition_control_init(struct panthor_arbitration *adev)
+{
+	device_for_each_named_child_node_scoped(adev->dev, child, "partition") {
+		int ret = partition_control_init(adev, child);
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
+
+int panthor_partition_control_yield_idle(struct panthor_partition_control *pc)
+{
+	return yield_idle(pc);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
new file mode 100644
index 0000000000000..9a688d7bbdb1f
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.h
@@ -0,0 +1,29 @@
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
+int panthor_partition_control_yield_idle(struct panthor_partition_control *pc);
+
+#endif
-- 
2.43.0

