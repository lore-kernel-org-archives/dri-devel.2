Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B9CA9ECF
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079D410E05C;
	Sun, 11 Oct 2026 17:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="m2Rg0+p2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m2Rg0+p2";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A2A10E13E
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NVzG/UrIBWxYqCd9jvUuXzMv1B8MyKHdUh8aTruYS1Rd+vmkk2GJ4GX90FFWo/lQwg2Nm3pQxEy2JP+1gwGZKgcPMhvwZ5Q1Z0+p801OUzlvT+8AC1/tKcFN2KN+4EuzAFXesW8PWgO4DOiLYSh7jT1oWBlgIaFtwjG6wghUU9MHSaQKG3LjxxGkVDkK9WvgJ8qm0u2EPbrojR01pbYieMTLs9IazSY+I0QhaNGuTIyBrYiPuj/PA+Bz0NgpvPP/KTsWVa4mMFW/tAinuDDbLyxuO/XEAZb5K/X6BxHMuHNEWtuEmj09QmCtW/RLAzFW/eB5+qwrHPPqqz73CfRupw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWrE4oGreTl+RsedJ9GZ4lgPK4/7K8KIhxTi2A1g24g=;
 b=kNB9IgzFYBg3CB1o7OA3nh4DoRE/7LQdRuaO+2Xg2Es10Pr07tu7vcBNMBX/9I29peIuWfXBxs5X9tz60hTeuLw+783MHCk02tFjDxxEUwmZC6egox5ZURKP0utUZESgPEo08jTad3zqevPlincOI75B95B+fwRkfwuGe4QpRDoVt/A1AQXUQD63H4jYYeZcCgTXpbYAbxA566BC03Snv9vX4XRrIEA2OPy7h8bGGAwAX4AADrMlwtS9X9N1s9aSXUAaKPb119dYdaDEJcMLJvi0O99v6g4YMfXVw8ZamyEYWj4coiJvny7rkgb+VvfT7iBBxOOHRl5MQbVxcwukLA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWrE4oGreTl+RsedJ9GZ4lgPK4/7K8KIhxTi2A1g24g=;
 b=m2Rg0+p2mZyczOahJh8NLWwOP0xMYciJXYKcQyY5lcs6LeoAJRQ/8nBTrIkPzaqBfUO9VjpgYeeQHQX5+98yDW05n89opfjINdhNS88M5sEPVktMvPnQNN1PuETgdZstlZLJM6hIEKk3CnYXMf1wOs94FzLSJ0lSfHUtjmj1DNw=
Received: from PAZP264CA0079.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::18)
 by VI0PR08MB11018.eurprd08.prod.outlook.com (2603:10a6:800:253::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:40:15 +0000
Received: from MA3PEPF00000405.eurprd04.prod.outlook.com
 (2603:10a6:102:1fa:cafe::7a) by PAZP264CA0079.outlook.office365.com
 (2603:10a6:102:1fa::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 17:40:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MA3PEPF00000405.mail.protection.outlook.com (10.167.241.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgfOO0pmQsnNFQOS5NDK4DfE6IVwk7Nt45KVh/O0yueuKKlHBjL58Ig+vthF1QiYEUjaz1ChL6DSowvEAV1RwCpmTV2SsuK4L4HN9Pus6xFM5c2Uv9zyHVVMo5KltvdkGrnLe5Sc92bVREYI2x4sDaLNSNd3a1fS0h5oS8+KAySRlT0ecYDxIkuPvxPZmeqTnfImPKGsLuWRlcxqxC0hXNEXG0UTf6/aqOOC1IXOtp+om1RxSshysYAHpAiU+tQea4QAtfMeQDWJ96DhWrdrfz5h8k6WrtPFM49uklR0jJrTNxEkpHZ4AMG79Gf+BOiNbhwLcW+L3h69XCGD4yzbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWrE4oGreTl+RsedJ9GZ4lgPK4/7K8KIhxTi2A1g24g=;
 b=XBRDIQx9LKJoBlNwIghME5jCyzCHOMqBmMqZ+J7WjgS34wc0i9kh6zWJEunaWNv9/yEroQy9xuHe9PfUQrMdSDVzyT+wFcIjyrZu1trrC1ulRZcgrDx8eXV/6rZIM09wVIfFD/yfVDpTqHDO0Ov2kyVb9FIiQFP9b0nbVuiPkGS2pCrEPhYpLyL5TBtdKH5Oz2Od8wTtaQpVQREvIVDZYAQw/buaVSj2+/wk2AfZZ+8+sbgmZ/aDtKb/J5HFhaf88QxNVe9d2BIRwEwE2D9guHG1COxuCXsyOZQdyRVog2D2JIJZZEiXMMR/9jyzcLq9K1jrLA57No5J5AbwcfHdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWrE4oGreTl+RsedJ9GZ4lgPK4/7K8KIhxTi2A1g24g=;
 b=m2Rg0+p2mZyczOahJh8NLWwOP0xMYciJXYKcQyY5lcs6LeoAJRQ/8nBTrIkPzaqBfUO9VjpgYeeQHQX5+98yDW05n89opfjINdhNS88M5sEPVktMvPnQNN1PuETgdZstlZLJM6hIEKk3CnYXMf1wOs94FzLSJ0lSfHUtjmj1DNw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:42 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:42 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:49 +0100
Subject: [PATCH v7 2/8] drm/panthor: Add register definitions for perf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-2-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
In-Reply-To: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|MA3PEPF00000405:EE_|VI0PR08MB11018:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ec4c75-3611-4eee-90b7-08df27beb559
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|22082099003|18002099003|3023799007|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: iJogYTJW41I5Bus0kFWZ1WoMGLl/b0Fe1BEvpollgyRWFxwhf8f5SvqPLZaGgR94XvkqKEj4+Tfb2JV+6oAk1u773t9cI0IHYOFqDuhUTDttrVshKWq+7sk9VFVlteKfOX+/5qTo8AXKa61YraGTsHlnJP47zWuRSc3UHeJrtL81xZPBiutoInbHsAI8uxCLmIXeWOaSe2sVg/vNzdKVMWc9OCEF3xw0TUq2scqwQAZfHvMUBU5uAWD3xGg3PoRTF+zEwvm2UGXi9ujt5SfGjwS7mTYwAWfwrHR7wasOy60CI8Q1mVKGZ8mpORrVskXqxW394zUbPzDYYhM3XKtnxWPJrckFS9OjhpeLzL5i/jQvpo5na1pK3X9nzsgDrcg+LCCmUrZicY7Wy/4IebBFjvrxxPV3VfhiXp0ufP4d94l/9acoVv13KvOZSIKiRt6E7deIh4zniQT7qZRcHDuaUCQG/xribRAcfiL8lXJ7yrYGESeMneGkVndOOCViCXrmMigYqqbaTX2PsfxLCJCxLc32EBYGsh6KgUOyZMfqLuwclK5G8n9IiqvdKZrrm6rGCg6PsC3TKsMfiKM7rCINqr+LeLCFviL0I52cAiaL2PDDQ4k4i2lupUr/cV+E8lzVKq3fU6Uhtnw91KpRCSPch67vaex0iZHXuhvKk05EOzUCzNY1Q313BTDvV5dx//7lei5VKNdbOBYK3FrrqkgPwQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: c3m5/9fe+POCgkywh19cfE4wyV7elaYZvr/vvHkEL+aYbYJhU1ecQC8EZcWDQoasdXeXIJYfW4Ohn+4c8cENzKpGhVaUdtYg1WGZGRXjkDmVrYJmsMu7BasG+esoLztIpyOxTvBA7qWb1Sk3lvjzBUiySpUjH+hR5oo5ee8M8uAD6f9DzSV/0urNGFGXMDHKb4WyWLWd+RIvkEMkGBr5tnTfT0CRgc3ZCDVHu1lnvU8ANhiT+7GNKa0+2W66KYeqZ4hUoU9xNcPWdDXB7YC9r07YAriANqVj1ypwhJX26usaC7T1Pnno4JL18Z0H7oZUrkLwUF1mi89icnSCiT1DHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 93a852f2-dacf-468c-35b6-08df27bea1db
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|7416014|376014|82310400026|14060799003|35042699022|10067099003|3023799007|261009223027099003|921020|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: jnwsBBOrsnuzomWTzfn8SQjSwZZkTZOfjzzqJ9WdOJZFE8Ipm+cjftzdrYmd6WZLAQx/g08p8rMlub6KXgIF0fVbVOlpZJdbGfBBfJoPr2CwUI4VAtR7aevvwptzA3xFfASU/4/vodE0x8vgTXrSmvQJtYRxnLJkud7SFa6Zto6lH84QEsFb+SoFkq9OnylcMm8mAiih4LEUGzEF2QdYPaU+8R/z6fgP0x4YpEiP/DWTC9f3LGkss4ovRss6UgFIyxEgMNRxrQYJ57d4adXZZbESIBnkxjC49TsoocsR7CXXlA/5MrJfcUtROlcuZvpbfhm1SDjjRPCQQPi4XbTrq70G2h6XVi4MjputFuAVmaFKEWNfqOZUuGNStxRwANoI62x5Ov01KhV3yB/QoFBKN3b3VXfBxz6U8BfBm0yt1gqiUdxKrUbJHio7akM3V085PK5vkxV4ZH/A5x3k4+KZPQsSKEHg2aEbJmc6qurTrknCIBf8NJwNLJJ+sr/m5te0gWUQyMXQIY+4IsCKFhGIjusd47Lkaxbny59TSHv1i+CYt8h0jxmf6lqJ5PMBVYJ/LV4UdPGGNuAn6rkrmHjym+omMy/K4H4JlvPugYIvKv40D3QJiKRZoHkbtUXhVvFzsnziwOIiVh4CvM9NqRr97kRJOpeHYfoHUbIgNfqdGL37LaGXxyCkTVnWhnOJRBlrg0oO08Gji6/BEJ/Qnel6+rAn5V8+U4hUftX7MIAmcaNgzBnyft+04ZF842a0Mc0x
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(376014)(82310400026)(14060799003)(35042699022)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0dPzloicBc0m56JLD6myvdwtm2AqM9g6qTomVt+ZAeQdN9cRgL4QXhv4YJD27QUFC3IHTpFtVDi6UtZbqxbclGLHlARGYVFipHy3Xo6rUCNFZh4FywMJepBClxyhLd5uMjMDwHjuybLtluHZGAnILmMBwPRDDrJsvNSnLz7JDe4gzWGMkaQVWJ/9Pk6d5/Zc7Dnh/4BTT15NsnyzpQD0GBgjdYzsA+NdslBAyouxdKEHkLweUsOmiZ1Z/z6WvK63mDFJQ6DJKHevNaGbLTli1TFYTgmQbwjUIVdrRIfCiM/RyOmg2YL0BLrCQLgXHrC1V37alFCelrOTb7eH0kPRHyY8vjGw0HCK6LlwsyAOTgLb9p4nH6yXBuD4pS02qJu8Ld+EI8pG6EBufJhDuFd09O+NowZzOn+uMqYi3ai1dFIYO/FPY02wp7LpD4E/AFc/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:14.7948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ec4c75-3611-4eee-90b7-08df27beb559
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11018
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

The perfcnt_size register, needed to size the FW-side ring buffer, is
comprised out of two fields, FIRMWARE_SIZE and HARDWARE_SIZE, indicating
the size of the corresponding components of a single sample. The total
size of a single sample in that ring buffer is the sum of the two.

The perfcnt_config register configures the size of the ring buffer, the
counter set requested by the user, and whether the optional metadata block
is required.

For newer FW revisions, the perfcnt_features register reports the
presence of an optional metadata block.

GPUs with arch major 11 or greater also report the number of performance
counters in a single counter block via the GPU_PRFCNT_FEATURES.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.h       | 9 ++++++++-
 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index a99a9b6f4825..124e2b40b15f 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -198,8 +198,12 @@ struct panthor_fw_global_control_iface {
 	u32 output_va;
 	u32 group_num;
 	u32 group_stride;
+#define GLB_PERFCNT_FW_SIZE(x) ((((x) >> 16) << 8))
+#define GLB_PERFCNT_HW_SIZE(x) (((x) & GENMASK(15, 0)) << 8)
 	u32 perfcnt_size;
 	u32 instr_features;
+#define PERFCNT_FEATURES_MD_SIZE(x) (((x) & GENMASK(3, 0)) << 8)
+	u32 perfcnt_features;
 };
 
 struct panthor_fw_global_input_iface {
@@ -208,7 +212,7 @@ struct panthor_fw_global_input_iface {
 #define GLB_CFG_ALLOC_EN			BIT(2)
 #define GLB_CFG_POWEROFF_TIMER			BIT(3)
 #define GLB_PROTM_ENTER				BIT(4)
-#define GLB_PERFCNT_EN				BIT(5)
+#define GLB_PERFCNT_ENABLE			BIT(5)
 #define GLB_PERFCNT_SAMPLE			BIT(6)
 #define GLB_COUNTER_EN				BIT(7)
 #define GLB_PING				BIT(8)
@@ -248,6 +252,9 @@ struct panthor_fw_global_input_iface {
 	u64 perfcnt_base;
 	u32 perfcnt_extract;
 	u32 reserved3[3];
+#define GLB_PERFCNT_CONFIG_SIZE(x) ((x) & GENMASK(7, 0))
+#define GLB_PERFCNT_CONFIG_SET(x) (((x) & GENMASK(1, 0)) << 8)
+#define GLB_PERFCNT_METADATA_ENABLE BIT(10)
 	u32 perfcnt_config;
 	u32 perfcnt_csg_select;
 	u32 perfcnt_fw_enable;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 4c5b953796e4..2f0877068e44 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -23,6 +23,7 @@
 #define GPU_TILER_FEATURES				0xC
 #define GPU_MEM_FEATURES				0x10
 #define   GROUPS_L2_COHERENT				BIT(0)
+#define   GPU_MEM_FEATURES_L2_SLICES(x)			((((x) & GENMASK(11, 8)) >> 8) + 1)
 
 #define GPU_MMU_FEATURES				0x14
 #define  GPU_MMU_FEATURES_VA_BITS(x)			((x) & GENMASK(7, 0))
@@ -69,6 +70,9 @@
 #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
 #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
 
+#define GPU_PRFCNT_FEATURES				0x68
+#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
+
 #define GPU_TIMESTAMP_OFFSET				0x88
 #define GPU_CYCLE_COUNT					0x90
 #define GPU_TIMESTAMP					0x98

-- 
2.43.0

