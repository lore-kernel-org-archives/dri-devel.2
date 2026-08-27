Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64143C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9235110EF14;
	Thu, 27 Aug 2026 08:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XLyKfxOY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010028.outbound.protection.outlook.com
 [40.93.198.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5251B10E3C8
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVle2ANurgKgqfHprrIKnhqqu3GJ8IlgeY8gixSdImbbjA+864+K1YGIqILo75JehQFMSFjWk5QZLNufjX5mEbbuHpd+bNOzoIf3YmTYUnkd+wS6ZmkLsGYf+GYnMVb3M461aG0J+0M1UyV9gG21kESPwUjRsnnlNZYShxE4EzBLxyXqC4M7igpXr0KpxyzWRbKxjYkhkzubx/aqBJ/8OLhkF/U8m/h3+Jp/6Tf02vNoNwzslRdA7vzmm4f1lOn2PU8QODPrk5OGSH1p7oqMrGybuh9Rvo89c3/dcobQbvkJDrNNd81YoBSTF7k/98D36vEma/7Oi2sJt0HQt9f9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXZzEB1H83FqJAgguKXFF78FGyNwpUhRjgkG9hjDGx8=;
 b=L8nMS0NXAVcEIUr36JueSOr7+59yleUO4FpfJvTDAIiNzbjuM9wyGFhS5LWKGsyr0LPj2ChYAg2RJ3F7DsHBqBs/45/GN2YJa76zNd8qXoB3wS9R/goywXxr1l8MQtQQULmHeLB7GJ0CIf0IiVtNAF5oysLbsQm3H8UYIdBgKfCzmj1GJOPg3ztgaP3dCSKd2enZ6uOy5FeoryXyb1pAOSLcxSrCjGmki2HVVXQXlCnwBUOsv/K+cmBj5YKvpQRonORtlECyxJTDWan0wwhXtr9C/ZytzQA8qHq0kQiAxgeSLYVCjr4RQ0Xob+ET0Bq6Khcj1leTQSej1lIRZmdsBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXZzEB1H83FqJAgguKXFF78FGyNwpUhRjgkG9hjDGx8=;
 b=XLyKfxOYxP71WKnjI1SIQjGhzXAv/YxRYw7xDCrvYUJQnRQAA3DcqHx4JTQvPFm5eHtbD2qdoH+RzLWWmZqqZRMULnilHD8FVuZpiewsYkruY4+kJeR+TK+CwlQ9yho4cKj6Hazm4++eFf0jg5qmdZC/e7Bs+7J+8oKw/1nQQGWrZb5oHCHOKow7Bub8e2/FhHVF39qAkEVTRoPJPmlWZJnjnor6zT7HWmrszb2WN+JAvBXdsExIV72XKAgNhYXnSHQd4xprhpJhW5qfs7/43WM1KbemAwaTDpMhvruN5CshACVFQgES9qI9/xh8dOXaIgUEVjcW8L8TITzLAekz5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL1PR12MB5729.namprd12.prod.outlook.com (2603:10b6:208:384::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 08:52:27 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 08:52:27 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 17:51:47 +0900
Subject: [PATCH v3 06/10] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-pramin-split-v3-6-24b24d7afc52@nvidia.com>
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0201.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL1PR12MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e215a75-1d1b-4517-f35c-08df04188577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: P/oeMRgrN5sJM2jaqPAZoGDL7WAzg2EQLnWR8wTVfcJuTmPnEZVu0xvSVEeqHqDPpEJOn4Gh6T+j57MqXKwH4EEE9IpEwnA4eLXZy6PCCVnLl1oK+kKP2NwkqaBo3sDpadRHUGC6bcNfMFGA4qTDDQFCmQcKMWZWxQpLqfPwCN0WjiQWG2uhrR8RQF/g4nOzyQ5NV5z0jP6XSTNXgiU66UNkcoGbqLN7B6ch77ZKHBpUyDkbaKCd1lVMEcWbdbZWW6XIxOn2FC+rkuHVKIccwDrDBBa/JgdajOfJcsp3gK0ch7vDFAumXH7pK1Y2XsWqakfqwkshxREqa4BbyRFSGIKlQa9geTxmOP2RaSmH+jH1GZdh6Aw1njCWCbdFpUaq/Y1Furdx1ICvG9lgls82yYwbFXJ+cbXaUEke41qIcvKhlF3vw/x1QkbvfffO9noHylEikc31N8MB3K3depSceSHB4Dlma4tcwEqL/LhYm11C9TxC12tGRDtv8mL9qSVqYHE9QWQLv4gIODz6wiUtKVfeOoKXvFo9L3Nypn7FAabiafCx8wrjqaf4Laosf+lMpPtzqvF9RiJ25WWwbl+N95ej615HDerHqyzoNc5TgrRpYqiwIDqXjZAcp8KKg6LVjrkDFDlDMVtKehbCx+egawwsMMlTRbPVZWQn//dDIAQQuSwaR8QeUSdY2qscEd1cNZSmlCQUAQP3wan6vD9D6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEkwMWdPY25nR1p1K3pNS2x2MCtBNk1udGN3R2tTSDRaL0M3MUE3UHZhaHlz?=
 =?utf-8?B?ZnhLamRJODRVR2x5QitVWVZUL1NUWXMwN1Zmc2pxUzhUN29CbkpocCtWcGVs?=
 =?utf-8?B?dTBNQ2pDR3NZK2pMN25sUVZ3Nzg0NkVTNUhXTE9tWHRqNlFEb2ZjYmhTYzBw?=
 =?utf-8?B?MkhHMUk3S0R3S2p4WW1PalB6UlYxd1ZXRkN3ZGViWGMxQkxqTy8vRFVZZnRL?=
 =?utf-8?B?azNmS29hdjhYZUxJQXlZaEY2c01zN0gvTEZkeG4zZlV6dmQ3cVNCRllsRWtq?=
 =?utf-8?B?clBPMUZwdTBQUmdGWWNtQ0ptNmdkL28velcyVFc2emQ2aVhuUitTd3hDYVpw?=
 =?utf-8?B?cVc4M3AzKzdoNEYvbFAwUVUyNGt6cVVQOFZCUTQyUldnNy9NL285Q29nUnRV?=
 =?utf-8?B?OENJRWJacnlKd2tweEI4Q2p0NmNGNjBhR0VIdnhOZVM3TnZ6QVVVZHZFWkRn?=
 =?utf-8?B?UDM0eE5Td2RRQ0VCSXBFSlNFZnVjRENtQWp3Y01LYWozREZLSUpxeUM3QW9Y?=
 =?utf-8?B?czZOZlRKQkZGYkhQTHdOdVJGSk5ETithWTBDZ2JscE94R0FSWlltdEl4ZTZo?=
 =?utf-8?B?a3NFd1lxUWhrSlBKQWpzZmVVeEplSWhDTmYvREJhbG4weEN2b2MrN2JkRWN2?=
 =?utf-8?B?eUFFV3BZTWhXL0hTa2EzTW9YRmgvejZrejg4aXFlVFpOZFdOZmxYRVRKK0k3?=
 =?utf-8?B?cWwvSlprZEVRa05aTkJ6STlHVEsyMnYzbVN0VXluOHdmVmlHTktFdFNEU2RB?=
 =?utf-8?B?bFd5eUZMWUJlUWtyT1VxWlBITGNQTmFaUHJRa3NEeW9mcGh6SjE1ZU90UERJ?=
 =?utf-8?B?aSt6aXhod3BjelNQR1FiYWUwTWEvays2YUVDQ2VFNFl5amlvUDNUQVM0ODF1?=
 =?utf-8?B?bmdCTUlDUmh4SnZwei81cjhLOFpsOWw5NUlSYWxRUTgwLzhiSWI0dmdwQlZY?=
 =?utf-8?B?bGtWT3hNU1VubFk3OG9CVmdCZHVFMEdCUHpDT3RTSHFNcnpnMVFZdFd6WVVq?=
 =?utf-8?B?eTN5QmVqRjhYT1RtQVlsdUZDZHRxV05tOWQwQ2o2dkU0N2lRaDUxMk9wT3c0?=
 =?utf-8?B?MXhoM2pGMDluSjVacVlyVmxpSDNXbHFHVnNZTmNkWk45Nyt6U3VUeFhHdTdx?=
 =?utf-8?B?ZWtHVjZ2WVNpUk15UUc4cThOQUpJSlRIZXE2aWQ2Mk1rL05PRHh4QWRlNGpU?=
 =?utf-8?B?MnNPTGJqNkY1bStkdDR0QUtvZzRveUhCWGhnd2V1WkNOTUZNK1ppa1lqUU45?=
 =?utf-8?B?U2lhTkxvM2ZjZENndXdxSm5LYk9iMDR5ME52L29ORG9ldXdKY2oxeFJwNGsw?=
 =?utf-8?B?dXp6UlhyM2JGNjZHVEt5MmpjUUE2MDhCTlNJU3FwODFVS1IzNWd1dGVaR0h0?=
 =?utf-8?B?c2JkK203UDJkYlV6Ym9Dd3BUVjdxcEwyRVRNcEptYUFjdzFrVWMwWThabFNE?=
 =?utf-8?B?a2hPWHNlMlltWXBlQlgwNEV0S2hpVS9MTUdiSlUySXc4WnhEaDdnbEtmYita?=
 =?utf-8?B?cTlVdnRkeERmRmJ3dHZWR1UwWFRORU9XQjN6VFdRUWh4bjlsMitXdHZod2tZ?=
 =?utf-8?B?cFp5eCtuelFNZm5tWStoME13RVk5MW1BNmFVZExMeGlGYVhtcjRpN2dRZGFt?=
 =?utf-8?B?OW52VUNtU3pHZVQwZTdEVnB3djk1bUxnYzVYRmZUcWN5bHVGU3kxWkdWMTRt?=
 =?utf-8?B?dnVQREpwcm1ybWt0R1FnWk5DdkJETkVKME41TktBMXdKcjM4a0s0OFVqMDdL?=
 =?utf-8?B?Mm1xcGVYQlBlU2Z0MHNTTk9jbWxFelY4d1lzYTRYV3ZTT0JpMDRXQ2dQQURC?=
 =?utf-8?B?MmM2RDU2cGV6clN4MmFZcDZmUEVxSDhqLzVlN0pxVk03d01FZDErZE1UMEsx?=
 =?utf-8?B?aGd6MkZKYk83cTNORXd3K0RyOGF5Sm1BWm96VFJpSms0UG5RRE42Tyt4SFpv?=
 =?utf-8?B?MGNqQkltUjhJSW9Oa2V6OHZXQUNrK2Qwd2tPdnVyREdqWGdZWlh4UVdrWldQ?=
 =?utf-8?B?enJQZG9WazdScGRkK2lYUXIzNkc2SE9hcW9rMlk1c2lGRUhXWFEwS0c1aStQ?=
 =?utf-8?B?ZXN3V3NXWHA1MkxCOXNiU2QxZks0V1N4WnY1VFdISS9pVXptMkVqcjJ5N3BT?=
 =?utf-8?B?S0dEOVBJdk1FMXZuQzB0UCtBcFU0QnR6cXcrTHdrWXNIeVJyOG9HeS9FSGI2?=
 =?utf-8?B?UHN5OE1RRjB3SkJ2eHEwSVE3Q0hneFd3c0xOelVydklQMFU0cTd3RGowKzFQ?=
 =?utf-8?B?anQrYkZXNjE3aDhPM3hNbHJjeVBpTXNoazNOOWtrcHI1MzZQTFVhUzdYZEFi?=
 =?utf-8?B?emtLZzZKVXVpRUx3ak55SGUrYUxCZnY3NGV4ZkMvNkt6dWhpVXhjR2JRd2Iw?=
 =?utf-8?Q?7ESHDzSZAxUbOmK9UxMfZHLAYVhSDm/40h0nEuWgtu7oE?=
X-MS-Exchange-AntiSpam-MessageData-1: uKUzy1GXl5QbyA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e215a75-1d1b-4517-f35c-08df04188577
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 08:52:27.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sShZ7ieuCWybK/5xuNrHBodO+LLKBs3rTz7sihjpXeoexo+0Lyj0JBYuoXTnGKXQa9q6zd7+lz9mTDuhdQZvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5729
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

From: Joel Fernandes <joelagnelf@nvidia.com>

PRAMIN apertures are a crucial mechanism for direct CPU read/write to
VRAM. Add a `Pramin` manager whose `window_at()` returns a typed MMIO
view of VRAM through the 1 MiB PRAMIN aperture in BAR0, validating the
view against the VRAM region and repositioning the window as needed for
the accessed address.

A view borrows `Pramin` mutably, so the window cannot move while
the view is in use, and it inserts an ordering point on Drop.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: split the registers and HAL into the two preceding patches]
[ecourtney: rebase w.r.t. Bar0 lifetime changes and register projections]
[ecourtney: drop the window guard and mutex, use &mut self]
[ecourtney: position at init to avoid reads, reposition in window_offset]
[ecourtney: return typed MMIO views instead of read/write accessors]
[ecourtney: insert an ordering read when a view drops]
[ecourtney: declare the window location, drop the doc examples]
[ecourtney: add the copyright header, doc and naming cleanups]
[ecourtney: the pramin module is mm-internal]
Co-developed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        |   1 +
 drivers/gpu/nova-core/mm/pramin.rs | 178 +++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 07dce4ce2473..ef5b1cad56c3 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -20,6 +20,7 @@
 };
 
 mod hal;
+mod pramin;
 mod regs;
 
 /// Physical VRAM address in GPU video memory.
diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
new file mode 100644
index 000000000000..20be3fc471ba
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Utilities for accessing VRAM through the PRAMIN window.
+
+use core::ops::Range;
+
+use kernel::{
+    io::{
+        io_project,
+        register,
+        register::OffsetLoc,
+        Io,
+        Mmio, //
+    },
+    prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
+    sizes::{
+        SZ_1M,
+        SZ_64K, //
+    },
+};
+
+use crate::{
+    driver::{
+        Bar0,
+        NovaRegisters, //
+    },
+    gpu::Chipset,
+    mm::{
+        hal::{
+            self,
+            MmHal, //
+        },
+        VramAddress, //
+    },
+    num::IntoSafeCast, //
+};
+
+/// Size of the PRAMIN window (1 MiB).
+const WINDOW_SIZE: usize = SZ_1M;
+
+/// The PRAMIN window, which is a 1 MiB window into VRAM at a fixed BAR0 offset.
+#[derive(FromBytes, IntoBytes)]
+struct PraminWindow([u8; WINDOW_SIZE]);
+
+register! {
+    base: NovaRegisters;
+
+    /// Location of the window inside BAR0.
+    PRAMIN: PraminWindow @ 0x700000;
+}
+
+/// Owner of the PRAMIN window state.
+///
+/// [`Pramin::window_at()`] repositions the window as needed and returns a typed MMIO view into
+/// it, holding the manager borrowed for the lifetime of the view.
+pub(super) struct Pramin<'gpu> {
+    bar: Bar0<'gpu>,
+    hal: &'static dyn MmHal,
+    /// MMIO view of the PRAMIN window in BAR0.
+    window: Mmio<'gpu, PraminWindow>,
+    /// VRAM range to keep the PRAMIN window inside.
+    vram_range: Range<VramAddress>,
+    /// Cached window position.
+    window_range: Range<VramAddress>,
+}
+
+/// Typed view of VRAM through the PRAMIN window.
+///
+/// Inserts an ordering point after previous writes through the window on drop. Views returned
+/// by [`PraminAccess::view()`] cannot outlive this access, so the ordering point covers every
+/// write made through them.
+pub(super) struct PraminAccess<'a, T>
+where
+    T: FromBytes + IntoBytes,
+{
+    view: Mmio<'a, T>,
+}
+
+impl<T> PraminAccess<'_, T>
+where
+    T: FromBytes + IntoBytes,
+{
+    /// Returns the MMIO view of the accessed location.
+    pub(super) fn view(&self) -> Mmio<'_, T> {
+        self.view
+    }
+}
+
+impl<T> Drop for PraminAccess<'_, T>
+where
+    T: FromBytes + IntoBytes,
+{
+    fn drop(&mut self) {
+        // Insert an ordering point after previous writes through this window.
+        self.view.cast::<u8>().read_val();
+    }
+}
+
+impl<'gpu> Pramin<'gpu> {
+    /// Alignment required by the PRAMIN window.
+    const BASE_ALIGN: Alignment = Alignment::new::<SZ_64K>();
+
+    /// Creates the window manager for the given VRAM region.
+    pub(super) fn new(
+        bar: Bar0<'gpu>,
+        chipset: Chipset,
+        vram_range: Range<VramAddress>,
+    ) -> Result<Self> {
+        let hal = hal::mm_hal(chipset);
+        let window = io_project!(bar, build: PRAMIN);
+        let base = vram_range.start.align_down(Self::BASE_ALIGN);
+        let window_range = Self::window_range(base)?;
+        hal.write_pramin_window_base(bar, base)?;
+
+        Ok(Self {
+            bar,
+            hal,
+            window,
+            vram_range,
+            window_range,
+        })
+    }
+
+    /// Returns the VRAM range a window based at `base` exposes.
+    fn window_range(base: VramAddress) -> Result<Range<VramAddress>> {
+        let end = base
+            .checked_add(WINDOW_SIZE.into_safe_cast())
+            .ok_or(EINVAL)?;
+        Ok(base..end)
+    }
+
+    /// Check the window covers `len` bytes at `addr`, moving it if needed.
+    ///
+    /// Returns the window offset at which to perform the access.
+    fn window_offset(&mut self, addr: VramAddress, len: usize) -> Result<usize> {
+        let end = addr.checked_add(len.into_safe_cast()).ok_or(EINVAL)?;
+
+        let inside = |r: &Range<VramAddress>| r.contains(&addr) && end <= r.end;
+        if !inside(&self.vram_range) {
+            return Err(EINVAL);
+        }
+
+        // Reposition the window if the access falls outside it.
+        if !inside(&self.window_range) {
+            let base = addr.align_down(Self::BASE_ALIGN);
+            let window_range = Self::window_range(base)?;
+            if !inside(&window_range) {
+                return Err(EINVAL);
+            }
+            self.hal.write_pramin_window_base(self.bar, base)?;
+            self.window_range = window_range;
+        }
+
+        Ok((addr - self.window_range.start).into_safe_cast())
+    }
+
+    /// Return a typed MMIO view of a `T` at `vram_addr`.
+    ///
+    /// Returns an error if `vram_addr` is not aligned to `T`'s alignment, or if
+    /// a `T` at `vram_addr` does not fit within the VRAM region.
+    pub(super) fn window_at<'a, T>(
+        &'a mut self,
+        vram_addr: VramAddress,
+    ) -> Result<PraminAccess<'a, T>>
+    where
+        T: FromBytes + IntoBytes,
+    {
+        let offset = self.window_offset(vram_addr, size_of::<T>())?;
+        let view = io_project!(self.window, try: OffsetLoc::new(offset));
+
+        Ok(PraminAccess { view })
+    }
+}

-- 
2.55.0

