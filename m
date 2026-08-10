Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98CDC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64C2F10E895;
	Mon, 10 Aug 2026 13:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TYNGvh6r";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7820A10E894
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7xu0nBljICknhsk0XLKFwWSbUgMNRO0Vzfqg9NNXX4T3Pv0CJ5V3aE24bgIIElehv8249pLhDCpR9QPyg4K48XH+fJYzXACpmxZx8KXcXI4YgCdgTBl8Hyta9F4EFT3D/avOXl2gHmk0Ek7EXUhQOHTwG1Vx1dCng1W4Q5FsEx+Bsqs8gkgzNb2NXzo49gtRKeVl8ZZ7T65NSRqUcCscPnFkjuM5nYG1C17TIOVuszKlSehyLJJllt2eU69lJj3qoAfJLEN5SCnfYoZ5GIO6YJC2ssrn08Hu2UjcqU4BqcFkVMorLEqlEkYpeHEa/VPklftl2RkTjiylB4t5iChpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrhQCq9TfB6+BQJFSUUUFXtQ5C7LOiyKKboARNboz4I=;
 b=xObvC7xaCWzj9TLc9wrkj+TMYyIPFqiuYmgr3wr4SyGL1V0OY+kUkCqYY+D1pMn0JENgL8fshYcuLiu+5eM78oz3OOa2tOqPyxX1gX8VmhJ/QQPY7ehgDkc27NJr5tdPqINndxE3W1/z5zwl4Y4Nkd2wBGLLgoyUn4eWgyhd5HZVc3rHBbTIMW7fVpsAqGMYKbBK2qEeb4Rk3mv1S7AE7R2Ih/5u2H3anLRXw69sa+Rzo5we9wQDHZwQZJxrQwMN4CXTFtfjjowXhPEMLXkeBlLGayg6Bkv1j4OFwE3zw+E5dXqZoZ61Mlb1LMZUD/8XsJVefbaD/gzUowdtrMVMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrhQCq9TfB6+BQJFSUUUFXtQ5C7LOiyKKboARNboz4I=;
 b=TYNGvh6r9SQRYPrtpnB+pSKkTQvWexWm+sMiQQNH5knnK7/pGTP/GjOXSFyivUiLr+IJ4OHB0M1T/9iU/XD6BfbMLAL37AZ6XNK2DrnMumB3T/xcNENdsjLOZztvEQh0AJHyfuSYD/UtYXTunCnxcpDPOKpBiukuK6f8Q9lkxc8q6MDhqIP2TkxURDUoup9Uz9kcXHvKKJ1pEJM2qExEZu+FLh7V6FbbwMKBr0aendrkkJ/bYBmKQToneuZb1Jj9j5DCOPvg/JRgBHokEq1Sfy0E/v2KPleyhLkgrWEpdy6Aez+HW+/UwkySYNQu7J/AkEV+/eiBV8cu7rNKo9SD8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:58:15 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:58:15 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 10 Aug 2026 22:55:31 +0900
Subject: [PATCH v2 09/12] docs: gpu: nova-core: Document the PRAMIN
 aperture mechanism
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pramin-split-v2-9-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce2e68b-9110-4053-a2ae-08def6e76c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: LDWkmRxoBB3ZIhe6Hv69I6E2jFGe2FAintHcMI0DfVHUUCfAKvzezjNEkZrGCHuQeJSJjHpbXMuVifKFXV6tz5tES7Vt2lYWv8MSmylmtSw9uFi9IR1A8c+u2LKhZhrJ1wf8oKqFyAUTaN4bxUhWH+ppsIpVCcI6Y/4yZLDEVZcldxluMVyXB+osdzr6BSbXRHG6oIahwOShNUxJSViOdJ7Yz38C35NWE0Hy0hfV+n0DR+mjtvjl5Vb2VZ54lSDXRG6g6x/MV+yLLeT5paInM2BxWQfD++T2PuXUhtP8ievHCVaZm6s4AWy2Rss7aLINxI5wymloeUZTc1ntQCBfpMN7/p9MtCGibi1cV2jGsmUkjFDFNNczQbKxndg6ADIyQqlKlVVg65rnGhmkjQZePYyf1zisQFz5pw4nPeZHuhMGuXfjVcYcHJiMx1AMX0Tec91gywEO+gz111TPuf7NtuClkk39Ob/BNjKaIxvpFUf7T8NmLADj01OljtUirfXCUK298gtaJOnRO2fu1U3vL8K8+xcOA8BuSN7dirEsubt9YI14AYETjuZKEozYSI2S+8S+2GegQmeAN5Xoma2DeJrgwH0ryo9arHI6fLzCbnUPdh9y3CQFhK4piOo4C70NTUqzP/Mqn0x1I8Gnu5m9+1OR2sC3+OkdrDF/itUKfqspmkTUmImBiGzGFAwCzuBWff34vaVXx4gY7aGYaZzRIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVUTyt5Q0lrT0ZWTC9FdjMxYVFwYTV1SzVOa1ZkaS9sM2ZyTUcxeG5KbmVR?=
 =?utf-8?B?dVRzUjFKekxkdnNPaTYxSFpuSGgzQ0xhVVJsZmVpakFTSStuVFl2VDV0alFh?=
 =?utf-8?B?ckJkc1R6cUVTTUhEUlk3UEVpM3VhZjlKbmhNSDA3SVZueFBYYW1XVXBqUTFt?=
 =?utf-8?B?Z1liRUI5b2VUdXM3c1ZsaGhVd0U0eENiN0JMQU1wTEcxYWwzaFVmbThaRmZ1?=
 =?utf-8?B?eVZKendrdWR1dGxCTDNqN3Zld3BHRktxQmNNWk9wemlVQnNIanJOVWdFOGlu?=
 =?utf-8?B?bkJiaysvdVQ3aW9xVWxWMGhjcnFlSlVhaktZUjVYMUhVb2kxNGJKSnU2R3BH?=
 =?utf-8?B?RzRmZEtBbGZHMlg3K3RQSXBidkN5ZWJiNkdGMlpmeC80b2NEbzFva1dOTWpZ?=
 =?utf-8?B?SlpxbW8wWnYrWU1ySTRWbG53TEc2elFsdE9LVFpxOGJPR3pLUmdFeXRyd2ZR?=
 =?utf-8?B?bit4UFhtOFZVU2UyYys1Qm81RVZLYlM3UWIzTDI2emd0ZHJXWlJFb0V0QW96?=
 =?utf-8?B?dTdhVkZueXhTVWgxOXZaM0p6MXRFd2NMNmZ0M1VtN0d0dCtxYTZKS1hoL0Nn?=
 =?utf-8?B?L2ZGYkxLNXRrY0ZRaHBiaFJObC94bVg1UHhrYUx1dWpCWHBjb000Z2xrMkdH?=
 =?utf-8?B?ZjRSeWwvbnNUT1dLQUlNM1hMdXR6bUluL1NKQVMxeE42aS8zUm9nUVFUbTBk?=
 =?utf-8?B?bEJKaTZYS0EzaFNqTkdmdmFTV1krSGQ0dGp6ZnpaMEpDS0FHR1k2NTE2c3U0?=
 =?utf-8?B?cFlVblJNMTl4enU5ZFg1Z3BCL0JFU0ZOcnp1bUJQdDZMVFd2VTBVMks2aExX?=
 =?utf-8?B?ejlVWVJ5NlJJU1BacEVCK0JBVy94Wm9CMDRYejZRZ1RXWnNxbFAwVXFpSHBp?=
 =?utf-8?B?NGVJNlBRLzI5Qjk5cHV5RXBLR1FaY0pzVmFPRnFUYWxkMG9relV2YTBMSGVE?=
 =?utf-8?B?VlRyZTlkdlkwZEhaV2lQMU4xM1YvcDBzRW4yVFVIc3lXWEhjWXZIOTdtamJh?=
 =?utf-8?B?b3FHQlNwMTRIOVZPR1VoQWJzejNPeHJPMitVSDBhNUhXdUNVd3lxeTZBR2pS?=
 =?utf-8?B?aVNRVHZDWldhRVJRWUt4WUhzSnhkVkpCd3ZhZU0wTjdwSE1hYUNIc3cwc1NE?=
 =?utf-8?B?WVJXdXgyRlRnWVFuUXdFaWZ4UXVic1VBWHRndWhxcDdvOXg0OUpMNU93T29U?=
 =?utf-8?B?M28wK01hM0xOcTlSYmRtSE9yQTkwd1RBNTcvM3dkRkNuT3FnblE1NGI4Yk1D?=
 =?utf-8?B?bVROeEJlYVIyRFgrU29ra05QZzJFSlBQMk9RRGN2WXl2VksxM2JQUHVUTlFm?=
 =?utf-8?B?S2FxQXU0KzI2OGRwQ2dyUWtvYS9oVks1NGRTLzJBWWJwSXk5L080aVhRUG5H?=
 =?utf-8?B?ODA3bEVIK29aUzlwTnhvM3lXc1VDRzVzYnREc04wdkFMZmlSY1BxWkN4Qk9S?=
 =?utf-8?B?TjY2eitCNkZFd1pteXFTQkpaRElDbnJJNTNPWm0vMHFtalZGTXRJMjdyMnFX?=
 =?utf-8?B?TWN4ZVlRdXdEVjIrSlQ4VGQzUDV0VVYxZDBjMDRJdDhIRHMrQjBNVjVISkZ4?=
 =?utf-8?B?cXYwOTJReS9LMW41Qy9EdU5rNVhPY3R1NXBQcEtqUThkcU1RMlYwRFVwMFJz?=
 =?utf-8?B?Uis0ZC9Mbzl0Rjc0MTgrMWNPRlJhNS9sTEs5T25RYWswcCtzMS9xT2sxUXJF?=
 =?utf-8?B?TWNWRytIYWNlRHNRNm1hS1FYamgyZ1JxYU9aUzZEdnZ0b1JYaVd5MVI5ekZx?=
 =?utf-8?B?OEkyUExaQnhvdlltTUs5WkFpWWRmTmttZEV1UGpuMy9sMklGWEhhQlprNGFn?=
 =?utf-8?B?clhJdU5pSHRQQzlQVTMzQzc5dDNIQWpUdjBYWXhPd0FlamZaZmQyZXVvdGVU?=
 =?utf-8?B?T05vaTg0c0JUKzV2TkZxWmhWMEJucHN4VG1aWXk4WG1UdDc4cGNSdzJZYmVa?=
 =?utf-8?B?TENkVE9QbVZONks5OWk3YVJkTzdZQWxNaTdRaGluY3d2eGQwSUxheTlHdzEy?=
 =?utf-8?B?NlI3SUlDemhvY3lSTzh6SjIydWlwNFVHdElyYlNoN09DZVVic3BON0Z1K09E?=
 =?utf-8?B?UUdCeXh5ZFhDZldOYWVBeTVBTVFvZUMyc0hLMTArVWRmbStjTGV2VTRFdDJm?=
 =?utf-8?B?L0tzQWphSjFvbzBpYlJFTER4WTY3SjJDcTc5TnpqVWI0czlReW9XZCtEakox?=
 =?utf-8?B?YTMxQTR3YkdQU2N3QXIzVnB6Z3hKWUpROGo0bU1UQmVDbmt6dzE3aVE4dU1E?=
 =?utf-8?B?S1ZXOTZxUEJQVmVZR0RVL2lobDRyUi9teElXTHduNU9rZmtrai8rVno0MmJj?=
 =?utf-8?B?WCtGeUVpZXpKc1ZmSnJjcy93WTAxUHBVTitXTEpkakVqRTRRVmFTWExMU2pU?=
 =?utf-8?Q?1HPtHqA5fnzIIOKWcjVKAUUP5VLk9jJ/daAvZ9DetGFnh?=
X-MS-Exchange-AntiSpam-MessageData-1: uHYhTzwhwWHmNQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce2e68b-9110-4053-a2ae-08def6e76c7d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:58:15.4266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iifkAREE9hExfNWFPE6AIjCPr0pofQ6n4ES64JgXuQIgj4VqPHNwlgY+237ARQ68TI2zQ1hgpXLZb4LxsnBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8208
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

Add documentation for the PRAMIN aperture mechanism used by nova-core
for direct VRAM access.

Nova only uses TARGET=VRAM for VRAM access. The SYS_MEM target values
are documented for completeness but not used by the driver.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: fix the TARGET encodings, KiB/MiB units, wording nits]
[ecourtney: wrap at 80 columns]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 Documentation/gpu/nova/core/pramin.rst | 128 +++++++++++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst       |   1 +
 2 files changed, 129 insertions(+)

diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nova/core/pramin.rst
new file mode 100644
index 000000000000..f50b052d73ba
--- /dev/null
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+PRAMIN aperture mechanism
+=========================
+
+.. note::
+   The following description is approximate and current as of the Ampere
+   family. It may change for future generations and is intended to assist in
+   understanding the driver code.
+
+Introduction
+============
+
+PRAMIN is a hardware aperture mechanism that provides CPU access to GPU Video
+RAM (VRAM) before the GPU's Memory Management Unit (MMU) and page tables are
+initialized. This 1 MiB sliding window, located at a fixed offset within BAR0,
+is essential for setting up page tables and other critical GPU data structures
+without relying on the GPU's MMU.
+
+Architecture Overview
+=====================
+
+The PRAMIN aperture mechanism is logically implemented by the GPU's PBUS (PCIe
+Bus Controller Unit) and provides a CPU-accessible window into VRAM through the
+PCIe interface::
+
+    +-----------------+    PCIe     +------------------------------+
+    |      CPU        |<----------->|           GPU                |
+    +-----------------+             |                              |
+                                    |  +----------------------+    |
+                                    |  |       PBUS           |    |
+                                    |  |  (Bus Controller)    |    |
+                                    |  |                      |    |
+                                    |  |  +--------------+ <------------ [1]
+                                    |  |  |   PRAMIN     |    |    |
+                                    |  |  |   Window     |    |    |
+                                    |  |  |   (1 MiB)    |    |    |
+                                    |  |  +--------------+    |    |
+                                    |  |         |            |    |
+                                    |  +---------|------------+    |
+                                    |            |                 |
+                                    |            v                 |
+                                    |  +----------------------+ <------- [2]
+                                    |  |       VRAM           |    |
+                                    |  |    (Several GiB)     |    |
+                                    |  |                      |    |
+                                    |  |   FB[0x0000000000]   |    |
+                                    |  |          ...         |    |
+                                    |  |   FB[0xFFFFFFFFFF]   |    |
+                                    |  +----------------------+    |
+                                    +------------------------------+
+
+    [1] Window starts at BAR0 + 0x700000.
+    [2] Program PRAMIN to any 64 KiB-aligned VRAM boundary.
+
+PBUS is responsible for, among other things, handling MMIO
+accesses to the BAR registers.
+
+PRAMIN Window Operation
+=======================
+
+The PRAMIN window provides a 1 MiB sliding aperture that can be repositioned
+over the entire VRAM address space using the ``NV_PBUS_BAR0_WINDOW`` register.
+
+Window Control Mechanism
+-------------------------
+
+::
+
+    NV_PBUS_BAR0_WINDOW Register (0x1700):
+    +-------+--------+--------------------------------------+
+    | 31:26 | 25:24  |               23:0                   |
+    | RSVD  | TARGET |            BASE_ADDR                 |
+    |       |        |        (bits 39:16 of VRAM address)  |
+    +-------+--------+--------------------------------------+
+
+    The 24-bit BASE_ADDR field encodes bits [39:16] of the target VRAM address,
+    providing 40-bit (1 TiB) address space coverage with 64 KiB alignment.
+
+    TARGET field (bits 25:24):
+    - 0x0: VRAM (Video Memory)
+    - 0x1: Reserved (unused)
+    - 0x2: SYS_MEM_COH (Coherent System Memory)
+    - 0x3: SYS_MEM_NONCOH (Non-coherent System Memory)
+
+.. note::
+   Nova only uses TARGET=VRAM (0x0) for video memory access. The SYS_MEM
+   target values are documented here for hardware completeness but are
+   not used by the driver.
+
+64 KiB Alignment Requirement
+----------------------------
+
+The PRAMIN window must be aligned to 64 KiB boundaries in VRAM. This is enforced
+by the ``BASE_ADDR`` field representing bits [39:16] of the target address::
+
+    VRAM Address Calculation:
+    actual_vram_addr = (BASE_ADDR << 16) + pramin_offset
+    Where:
+    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+    - pramin_offset: 20-bit offset within the PRAMIN window [0x00000-0xFFFFF]
+
+    Example Window Positioning:
+    +---------------------------------------------------------+
+    |                    VRAM Space                           |
+    |                                                         |
+    |  0x0000000000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0x00000FFFFF +-----------------+                       |
+    |                                                         |
+    |       |              ^                                  |
+    |       |              | Window can slide                 |
+    |       v              | to any 64 KiB-aligned boundary   |
+    |                                                         |
+    |  0x0123400000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0x01234FFFFF +-----------------+                       |
+    |                                                         |
+    |                       ...                               |
+    |                                                         |
+    |  0xFFFFF00000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0xFFFFFFFFFF +-----------------+                       |
+    +---------------------------------------------------------+
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index 2afa58e8f08d..59b206238498 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -34,3 +34,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/fwsec
    core/falcon
    core/tlv
+   core/pramin

-- 
2.55.0

