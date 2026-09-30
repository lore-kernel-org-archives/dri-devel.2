Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD279CA5FAD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BA010F14A;
	Wed, 30 Sep 2026 02:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6Mg6RMW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B5610F145
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUWcX72JgicfPpR4oMJ21lUKMXspQZpVlX6LiCGIb3qQSjQTDXmNxpkIGFaIX1M4af/LjPjdKiKUTXapMNMOk88mHuxNKMQTpUGhP8GXtRdvBl3IvMMyyxvBHcPef4v9nwmyLGObP/H64RlXhAljFWOgta6F7/m/TVUxJ/oitjqjuAdIRHtkgiduaCnlZ39GexCpHd+Fqi8DppB9f8KEarnV7WfoDqWMVvB0ZSow1RCRyVe3CvVABfzzLkr44EhuieXwI6RYq+mrtMatM1jr7uN2m+fuUZS+32x+6EoTSsoF5BWEg2cnyuf9JxL2OnBVNHX7IkcfDD5DokpBhhaUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUFucnWHzvF/xpAM1BFZcVFsasAx37jmVqknwNlMyY0=;
 b=cq1pR7W8TaF9ugJQo1707ntzlI5noKPTYq0i+hU15ZdrunaK00v4aI9g6KKYBgcgGApgMJbb0IXHAEqoPonhbvfNQXq9WEZ7tr2dw/TDn+e8/aUITVA6VS4WcpDzZsLoLHCyCRqUk0rCs0y5MQUVwd5RRjX8yvv41nwJWj+WI5HRWDiP/j4xP/iFqdPDe5kNi9TG/gJZSqt6NzDCLV0i26RjCnKpihNCExtvPgALjwmsVwMriw15p1UVAduSzlOJcLv5xYoQgqGKUcK5YGRI33zqAn5WsjOmM82A/yTr4B/6ufTD3ziVh9nKuyJ9R8RGhpwGfq/GBTMSfrSgli9w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUFucnWHzvF/xpAM1BFZcVFsasAx37jmVqknwNlMyY0=;
 b=L6Mg6RMWz/ncmQsw3wyBu/IJMBkKhoPpgl4BGEjFhxxTIM71hmjgR+LJeNWSepMdX3g0jO4ul+nf7+IhQhsvhDBYLig2GLyIg1jzF5xXzLiUZj0bKFPhTcIrnXuIohppzCyQ0xtGzPDEWhUm5/88ubHHrxPHeacgbd8k364bWMt0iUMCyIr/Cp+Koeu18ZjB6sOQFwKDq0VBLCvlINRafMXOmTuqRZlkbCTy+VKk0Vb6Rv3iAUa7lPGUOzRR0cused4axGxUuq8ijJlz6XgRzlBq43KeNbvGPWDAIP/JoPaZYoWKWv8ZpEGgXQbCon0GIqon19cdK9Qp4XSu6oHD0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:53 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:53 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:58 +0900
Subject: [PATCH v9 9/9] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-9-0d6cca376cff@nvidia.com>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6a4e59-7ec5-4944-dd5a-08df1e9cce66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4ucqQvjIysaAyAokhXI5UMmL1cliKs/EwcWBIlG25CD7nLI5DrpssdAVqp14jTWdChIhaNbgJU6fjHlVfReeYvV75YER5O6Yv3UOdNP3qwSl4nq3k+RJm3T8+rGy+F3OJoh3VByn6G334Q5wXqLdei+pLBa2FLHhNE/hL/QCziN2vEBYuAgPUk8Ed6CUvmAKxlwCltFh67fXoJi+q6zuiupWXIfrXFjtI3Cgsv5hFaFW6XEgsomIefYFiKVsLEcta/Lt0w17wy7XXKu2NlRcJwKso2ibpOzOjfwrb3SdefZ2W0k9MG5ZNQnSej3c1OJxuREShaJqrpl8ru0L9uYub70m1EeMhChtdYOox+zHvayd5CFYrmK+uEfgo+kdQYWuTbEhiozbcdCrUoJ3PYPiIUoR4n71mg0K1DofbVC86RFuU/KrtAnBq7+e89rsqcuvd242Iq+zFz0m1L/qVQo10tBFU0xUzLoW9oVGVQVlTmQdPPVi8zFWUcM7QNUhmAf/YnO/4df0AEEx2pnqwXQin6ER7a5reNoXojCjkOLv6+0uozWORpcw78XHBz9g0CrEJ8nymzFbgD6lM65x1Y2sqS1OB06rbBVcVYdTgb/ter8Ex7XgcWTMqMcTb00ojZ6bPIccnzzH+4cqTikxw0ihXAG25e/f1qid9GJMxmtSm20hGiQ4ZhEunRNr5xdg6UogtaREsdGoFJR365Ss1Btt1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVg1bUp1NDV1UHliaW05SEVaWkUyRkppVlhhcGt3Uk16bXlsdUJxYklYVklO?=
 =?utf-8?B?d2VieUR6K1NMY0dWcE11MlAweXFtOWFKaW5QeHJhTTNUQjRWbmFKbHpiMHlH?=
 =?utf-8?B?QTNMMmp5a1hiWXlNZEVEak1ReXpOdU8rcjg4QVdYeWM1dlQ4RmpBV1AydERo?=
 =?utf-8?B?V3VjVTVZVU85alVKcCtRYlp5ekthd0tsbWVkK084OTRYSDMvMlVYazg2ZzJy?=
 =?utf-8?B?SFpsdTdiQjJ0YzI2NC9uSk5XbVg4VEk0QkczaTlqNzdoSXNuVnAyMEg4VUVu?=
 =?utf-8?B?OFdsbjVuUzlLdDhsR0Y4MU9wT3NoZno4SzVRUU5zeE1iNGhiR1dNakczTTVW?=
 =?utf-8?B?M3JTUnBFdDZDMGxKSEpsWUxhWjJVYmlwVFF0MjcyaHAraFRHZnBIVWxEcUNF?=
 =?utf-8?B?cVZEbUkyNjBEN2hxUHlWL0NDcG9nMzh1UjlYRHkvaGJyR0VuWG45K1MxV0xL?=
 =?utf-8?B?VytIN3ZwUk81TmV6aXdsR2Q5MTRyRGlsUmQ3eXQ3dDFJWFhzd05WZVhvUnE2?=
 =?utf-8?B?SHFsVWk3cEcxT1VDYVpBVm9uaDFNeHN5aDdCYzRGLy83Mmp0ejQ1T21TNnZY?=
 =?utf-8?B?NHVYZUZwK0VpSEtITUZDbzFrR1ErRStrSHJCUDdVZmgwK3BOY3JxQm9JMHNr?=
 =?utf-8?B?cjlscTRBb0Z3dnc1MTUrTG91Qm55YndVNGV1eWg2Q0dTTjFvZ3k3MFVMWTdD?=
 =?utf-8?B?M2hXOFZiK0RWQ283MnlIREoyWklMK2N1WEN4ZFZESTVXNDIxbklXVXBDbEVR?=
 =?utf-8?B?Q1p2a2VhZ3NQYjVxRjZLMlo4K1lKcko0UTB0Mi9ZSHBkYWVSVEJMSEo1bEg5?=
 =?utf-8?B?ZVZRamY2SCs2QXZWNVF1RHdEZHN6a1Z0VlZoemhoUTVCN0dScXU0TmkydUJo?=
 =?utf-8?B?WlNldHNQR2xUa2FpS2FQR1dNb1FQZWhSY2crLzhLcXU0c1JPSTNFM2dFTVNW?=
 =?utf-8?B?UC9TaWMrSVZwVURLblFWVXh0YXFnK0dzZGV4UmlnRHptdk9UTzZZaEs0UUQx?=
 =?utf-8?B?VVE1dFkrbDI4Y1BkbWtrZjNyaC91ckNoZGl0N24wRXRQRENVQmQrNTlManpL?=
 =?utf-8?B?b2pxd3BCbEJMTjdsTnZRZUtTa3dzSjJQdVViYWNyNTVpNE1kbjA1Q2JQbFoy?=
 =?utf-8?B?bzl1RkhFMUFZREtqZDZPbjhxbUhwL2ZXZTFpL1dCQnhJMUFGTFAvcTFCTktU?=
 =?utf-8?B?dDdRVUJFbmhBYk9nV3h3bnB3RlY3NzNxUGR0My82UWJ3RGNOMG5MSUJqOHVD?=
 =?utf-8?B?NGJ6OFlmcVZGcnBTL2ZzNjA2T2NuZ1VqVERRRGIyR3dLK2lxUHBUMlFYTUpD?=
 =?utf-8?B?WEw5dEtkSVl2S0ZQSDJ0QmpKNWdOZjY4Y0tZZnlmZm1qSU9vVTc5UUxPMFRa?=
 =?utf-8?B?SWdPTS9LSXZrQUZHd1FlckczNFFCZk1LMGRHcFQxdFNOYmFSLy9ydW9FMTUv?=
 =?utf-8?B?TVZhdE13MTlucHJaOFYwZS9iR21jamVlOHNpMWh2cWxiZCtlUmxqSTEwVFk2?=
 =?utf-8?B?UkxUZlA1TUZYSDVuSnQyeHRsUzRnZHFTRnJTYnlBdlY0Uk5pRkFzMG1BbVpJ?=
 =?utf-8?B?QWlWS0FtRTRPRXFQRWVrTDZMYzZPMG9zK2lhMjJYYmwxSFlQazNYcXl4eDdj?=
 =?utf-8?B?V2xZWTFyRjNGajc4eENWMXNLbDgrSnZYSzMwaGNnbTFEcElRMklIMnB4Rzl2?=
 =?utf-8?B?MU1QRmVRajEveXBFdzJ3c3Z3Wi9MamtCaXZwTTdzV2tUUjR6L01pN0FRR2p4?=
 =?utf-8?B?NFdlcURaUTJ1Mk9ac1ZuQlpRbCt5ODAzTFpJY1I4cHVZRk5ta1pvQmNyeTkw?=
 =?utf-8?B?ZFo0TWVmais5MzRJazk5NGxydmZUYnlXQk5URXZVUzNBZE14T1pERDg4T0VP?=
 =?utf-8?B?V25jR1hCeS9nVWxncE5uVW9pTlN0NXNUajZRY2s3ejh5MDBrbUV3eU9qNGdk?=
 =?utf-8?B?WlJzdVpBYnNHemtlK0pPcW0vVFJyaXl0NlRXMWxDdjJVeS9JVlVibGphN3FW?=
 =?utf-8?B?OXhNUDVzNjMxTkJ0QnY0cXRjUVYvZlBlWDFRMkQ5NW1HajlVY0hKRmhQWHFv?=
 =?utf-8?B?UVBPYXA0SnF2R1JZOEVhblB1M2VUNnNvcWlBSTRTWEwzNEtQNTJrcWRzaUFr?=
 =?utf-8?B?U01rSDlTWTFjMVR1VUVoaldOUnFYNmZiNHQrWXFLQWpjTy93QkNRNnV1SVUz?=
 =?utf-8?B?VDN4QVgrQkptclRHZlZJOHlJQjNxS09sbGFWV1VmdjFTVVM0K1ZYK3B5SWFh?=
 =?utf-8?B?YjhZWU9kdjc4b0g5NGoweThhZWtKd1VENmZQVDlxNEZJVnVicXR4bXhqVUla?=
 =?utf-8?B?M2Z2OVpBenJaRTVhcHVaWkRmY29LZCtET3BnT084aC91bDdVK0IyM09MRlVD?=
 =?utf-8?Q?oQTTSTjF+kfCxB7t8C4+iOr4WwQNCfcZU/GtGbhj8dL8K?=
X-MS-Exchange-AntiSpam-MessageData-1: ltqvg34YTpGpOQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6a4e59-7ec5-4944-dd5a-08df1e9cce66
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:53.7623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjnSESzOjJwg//Se/1n4+TIqdT8gwDwLywkYrk5bK3hD4O7HWOsWB7tGGaunRiZT72neiUI7hMtSVhN1NMYzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Add `ChannelIdPool` which adds automatic tracking and releasing of
channel IDs on top of `IdPool`. This is necessary for apportioning
ranges of channel IDs to be used in e.g. vGPU.

Channel IDs are allocated as a contiguous sequence with a specific
length and sometimes a specific alignment [1] for vGPU. The ID space is
small (limited to 2048) and allocation is not on a hot path, so a
bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
single ID within a range, not a contiguous sequence) or a maple tree
(where aligned allocation needs an alloc_range()+erase() retry loop that
essentially reimplements bitmap_find_next_zero_area()) [2]. It is
also faster than maple tree [3].

Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvidia.com/ # [1]
Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/ # [2]
Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com/ # [3]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs         |   2 +
 drivers/gpu/nova-core/gpu/channel.rs | 198 +++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fb6f8a86a503..0571d7c9fcd3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -47,6 +47,8 @@
     vgpu::VgpuManager, //
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 mod regs;
 
diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core/gpu/channel.rs
new file mode 100644
index 000000000000..485efaba059d
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Channel ID allocation.
+
+use core::{
+    num::NonZero,
+    ops::{
+        Deref,
+        Range, //
+    }, //
+};
+
+use kernel::{
+    id_pool::IdPool,
+    prelude::*,
+    ptr::Alignment,
+    sync::{
+        new_mutex,
+        Mutex, //
+    }, //
+};
+
+/// Pool for tracking reservations of channel IDs.
+#[pin_data]
+pub(crate) struct ChannelIdPool {
+    #[pin]
+    inner: Mutex<IdPool>,
+}
+
+impl ChannelIdPool {
+    /// Creates a pool managing `num_chids` channel IDs.
+    pub(crate) fn new(num_chids: NonZero<usize>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            inner <- new_mutex!(IdPool::with_capacity(num_chids.get(), GFP_KERNEL)?),
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn reserve_ids(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdReservation<'_>> {
+        let mut ids = self.inner.lock();
+        let range = ids.reserve_ids(0, count, align).ok_or(ENOSPC)?;
+        Ok(ChannelIdReservation { pool: self, range })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID reservation is released immediately when unused"]
+pub(crate) struct ChannelIdReservation<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdReservation<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_ids(&self.range);
+    }
+}
+
+impl Deref for ChannelIdReservation<'_> {
+    type Target = Range<usize>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.range
+    }
+}
+
+#[kunit_tests(nova_core_channel)]
+mod tests {
+    use super::*;
+    use kernel::sizes::SizeConstants;
+
+    #[test]
+    fn chid_reservation() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(2048)), GFP_KERNEL)?;
+
+        let first = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(
+            first_start,
+            pool.reserve_ids(cv!(48), Alignment::SZ_1)?.start
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_drop() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(8)), GFP_KERNEL)?;
+
+        let a = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        let c = pool.reserve_ids(cv!(2), Alignment::SZ_1)?;
+        assert_eq!(0, a.start);
+        assert_eq!(3, b.start);
+        assert_eq!(6, c.start);
+
+        drop(b);
+
+        // Only have space for 3 IDs right now.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_1).map(|_| ())
+        );
+        let b = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(3, b.start);
+
+        drop(a);
+        drop(c);
+        drop(b);
+
+        // Everything was dropped so the pool should be empty.
+        assert_eq!(0, pool.reserve_ids(cv!(8), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(4)), GFP_KERNEL)?;
+
+        {
+            let a = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let c = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            let d = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.reserve_ids(cv!(1), Alignment::SZ_1).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.reserve_ids(cv!(4), Alignment::SZ_1)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(5), Alignment::SZ_1).map(|_| ())
+        );
+
+        let head = pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(2), Alignment::SZ_1).map(|_| ())
+        );
+        assert_eq!(3, pool.reserve_ids(cv!(1), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_reservation_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(cv!(16)), GFP_KERNEL)?;
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.reserve_ids(cv!(4), Alignment::SZ_4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.reserve_ids(cv!(1), Alignment::SZ_1)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.reserve_ids(cv!(8), Alignment::SZ_8)?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(4), Alignment::SZ_4).map(|_| ())
+        );
+        assert_eq!(
+            Err(ENOSPC),
+            pool.reserve_ids(cv!(1), Alignment::SZ_32).map(|_| ())
+        );
+
+        assert_eq!(2, pool.reserve_ids(cv!(2), Alignment::SZ_1)?.start);
+        Ok(())
+    }
+}

-- 
2.55.0

