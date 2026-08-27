Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7723C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A2910EEE6;
	Thu, 27 Aug 2026 07:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N7E69igB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE4D10EED9
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQg9FsxuehNkC3uWKAUYgnFl+7DbPQ0lTgv6KVSc/qC7ftaTDLSWcA8XcCsCpQC8mIbEClYh91MX5cjAbOOk2URBD8alPbnK/97mkWabjdUbqd3DzepVbD3/7/aPBcTmFaRXWCx43ZAaiEZuwwLFpQO4vzlqyqGUMPYoVt1pYbO1MjMO1ZHHpHN+5H8OPiH9ZjxFIx08pE71+6uzzK8WGtdkdGAHQ2VQo66xm8rhSgZT88WEbphqY0287oi6sFerxr8aWG1iPUfTDwL3fzF0U2AOaK5Dzz6FelFe8sdhShWOLSjaEu/0bZ9F301OK37gXxu46U5su3C77R3cdw0jdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOL9E1SWgCT5IO15duXo33pD+7Q1p3nml0jkmG8nymM=;
 b=KL1jwgoN0Awm0k9WK2jRiwDWsCGP2X2bNTzx/Ec2HqMOfhQTN/W7bS+AD/xbDNLStbz2HbhkRfWsxHPjPg8+5XcBNLWTCiE1XIOsPDDYStqAzpVDWlfE55KmtLICO4A4ODqyxLiwjgbujwnea4bHuE/xwa3LIpoRMGc2S9Gh3dV4CkZmlu0JyPIbyOjbrQeJ5aYyh11bEiS/cEANoeve3Arp4g46R18cr4ATDa7QgGTHCk8KNNeaS7t24n4NQ5cHozM0UazYGbqUkLsdLtlXQ30LA001niAlVUmKj+y8dbX44XARpP7kncj62dJamYYHSNM6QeinxHOKE7aS8d9Pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOL9E1SWgCT5IO15duXo33pD+7Q1p3nml0jkmG8nymM=;
 b=N7E69igBd6E9hnv9aT6d6aTgSQJeADPz35yAiw23XoK6Fsy0y9TMcY0g+MpA46RNdJleevxMDW7nzuSBAL10gok4D+Q9tZiTXgqNNt/2ZYg/DANeMb+EicI7qBeh4IQlF0awPdrflEpXUHVY7q9sFd6mhkD0SFRkw/akcRryQdQN61NwH6VYt7U/548aYyrhW0LRpyjUr4ye0HCK5rPPxDEAA7OItClTW8TeDE0vRX09VW1cnA8gKed8xGXr+3ah0ma604woOwUWsj4FKGwm5HFHaeIIvOPHgaq1prbrvKHKvYKewPvrd8vucODy21xe196YNs+GBN2EhEth799Pdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 07:31:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 07:31:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 16:28:40 +0900
Subject: [PATCH v8 12/12] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-chid-v8-12-bc74c77d0214@nvidia.com>
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
In-Reply-To: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0357.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a99f2a5-ea69-433d-208a-08df040d2735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iz2g8aEgNzT+AAU0xH4wKybug45UosGlz0XeO/0Kg0HKroX1FuDJ2WVSCvYc4lzBDhpdMtXIYbsUb4CS+dEoWSy5DSrwp2GwY297zpWTNkbIIeu5dCuVdkIToj5W9vD+lyVvS8eMHKl6cz6US1P7Wjp1Lr9dhMSfvFMjX4nkRSdXKXDpZZH2nGma+fTOD1LUfZWNSUqDz149rjW3om1GKV3oGYTAlvpD5BU+5vKvSfOlCRkDQRaCI0OopeMVJPEaX7p7M4G6u1DB92S+JttDnuESZ9quSI2I0nSD11/hXPkFWJUsJylrB1hRYzk3kyhveCb+owPeynsmOXZWHtxFVCtCRTkncTyryDJS+h8NYLSvQaUt5dpg762BeLKAZ9OaExoXXxkeFvg88sdqykIXgc7E2/yA3GP93dBZLCtOrRjOsllUYCs9kYKW+BciDX4yhunwwC1DtKMM0PwfX7posusjmZ9kHwjki5hZFOZN5GrX4EqukvL26B8WcSbYXwSW1K+SCoBXvhpJ9vBODon0LCjDdhVObDDhyuUiTsiVcMto19klYM05XR48hOl9SoGjLuT76mtxLkknIWh/n7ycyOuTlAb3TapbnMHvBw4K1LaupVIvhpKQbF0Ftc70VWyNYIE0Ot57Me/G+dnphzrGLCnJ0fT7uIb5kUM2YdRhZL3ZkG3mh6B1Wa9IY6V8rQhU69H+34yCXkREJgyVX3sNsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnBGK1hsY1ZNd0JaTi9HSy9xV0NnNXVmT1FCbWkra2p6UVR6MjZ2a2tzWEVC?=
 =?utf-8?B?eURPenhlcS9TMGQwVFlsNWgzRTByMmFqckg2LzZtY1dwMVZoeisxa0VlM2xt?=
 =?utf-8?B?eXNNOU1vT0NMTE53YWhSRitWeTZ0d2N2MUN1SXJ0WVZzcDBXOURyd0VBdjRX?=
 =?utf-8?B?TUVMTkNadWMwZEVON3pwcEI2SDJ3SkJWTDZkQWhIMEpiYW9qV1BOSllEZWN1?=
 =?utf-8?B?UCt6Y3h5VGNxN1FkTGxLN1RybEFjWWwvOVJRTnJKQzB3U29vOXczWDJuSUNW?=
 =?utf-8?B?bWtnTVU5VzF2NlNmWkllM0dPZnRtQndtaUIycjE2VkZZNWhJYjBhL0E2dFVX?=
 =?utf-8?B?VE5LeXduOXl2SFRQcXBHeHZSRVNtU1dpTy81eldWVzIyNmxmTUJWbURoOGJZ?=
 =?utf-8?B?TXgzem1tN29aenhmeVRYOXFCOWVaLy82VDdvZmpqZmJjYU1hOUFLOG1Vc1dQ?=
 =?utf-8?B?OTluNENtKzY3cHBSZGJuekJWTE5XdFkzbjM1RGt1UWZadG1VYjRLYXNnYjY2?=
 =?utf-8?B?Z2RJRnhkQXlmRFNneXh5N0VXSmwvTFdQSXVVMWd4b1NTNTZzZW1OMlEvZmdD?=
 =?utf-8?B?dWxaL091NTF1UHZvN0FmM2l2bmVHcFQ4UUxIYm1TSVlUTWdMTk04MkRoOWh4?=
 =?utf-8?B?V1QxUVRHN2Y3MmNLOCt5bW13UE9rM3N4dkIyME0xNkNTY2xCZWxxRUVnbURP?=
 =?utf-8?B?WWpGaVl5U01lNy95Mi9SV3k5Zi9ETG5LZXN5RGFNZDlSdnB0b0JPaEwyd1Nu?=
 =?utf-8?B?d3RRSHJrbnhtVDl1eXB3T3RoOC9sQWVyalBMaDRCWHZiSFIxMit2a0JLM1hm?=
 =?utf-8?B?LzJ2c1ljVnlKMFppYm1mamNobkxXU1VYRjRwbWJEYVNLanE5RkhpV3oyUVZB?=
 =?utf-8?B?aVIxUWU3NWhYYldkZ2NKaGpnU2NPU2FxREJ2eThZbGYwVWwyazhPOXB0TEFW?=
 =?utf-8?B?Nkd3TDdJdHdERitzc2dYUTFVdEdUeThpWnRpeVQ2WU92K3FkR3ExRittSldv?=
 =?utf-8?B?S2hkWXo4eHFkelFuVEluZS82VVRoZmptdW9YNzQ1MUlDb3A2NG1hbFBETklt?=
 =?utf-8?B?a2hBeFpXQXpOeUZlaC8zc2ZaWmFyYjlrQlBEMktnbjVCbkg1RmhGNVNMQ1NB?=
 =?utf-8?B?T3ljdWs5MWkxcmR3Ty80L0hUalc0djQrMHJkeEpDQU5iUWJaeXVJODJEczVM?=
 =?utf-8?B?TWRXL0VlaGk5aWVERGxhZ05vWEZvRVd5d09VVXE5a3pISTY5MjZuZEs4S3E1?=
 =?utf-8?B?blZ4Z1pIR2NlN1JUd285Q0gvYTFuSEpCRE4yUitUT1o4NDNQRXBGanlrMzJI?=
 =?utf-8?B?OTZza0puZDJNclhxYUZWM2k2WTcrdDlqMG9LTnJoNXUvT0g3YmlyV0oxdGdC?=
 =?utf-8?B?Z2FwQ2VQSWEzbjdBRkZLajR4RnBiM0N6Z1lDQnV4Wm5rYWhZY051Q0NWcnRG?=
 =?utf-8?B?dWt6bG4yY0lHdHM2bGpRWitnS0ZydFEvSzlrVUROQStHVVpKYmtmTkVRdmRQ?=
 =?utf-8?B?bHR3VU4yS3RTWmFHb1B3VHh5bHI1dXZudUd1eGpZaWd6d0VrM1JPWmFOckZv?=
 =?utf-8?B?ZnRpMjZKa2QxZDJLT3JvUFUxM1NYQ1RYVTBQTDU2MjNqeWFTM3IwK3l3VjE3?=
 =?utf-8?B?NE5rMTBpQ0w3dTlJTHVGbGM3TlY4Q3AveEl1VDcwdDl3Z3VybTlrV2V6dTVh?=
 =?utf-8?B?aW1lUVRocmI0YVZTODlPWUw3eXJETzdIV3duVzdFR05NdEluU0NXRmM2RGVL?=
 =?utf-8?B?MzREL2w5d21sTmI3V2wxTVVLR3hhTTZyVnpHQzJySE80ZHByMkdGemNWcnJG?=
 =?utf-8?B?SEJ3dG9DeHYrTThUSDBnT3FuYXhNMWhJVmlqN0ROeWMyWWFsWitDN0hVS1lU?=
 =?utf-8?B?MktGUm9RYlkwY2JwSEM5dCsvS1BNVkNaSUw0Y3NudFRaeE1BK1kvdU1UNXR5?=
 =?utf-8?B?UHA4SHFiYUdnOWcvRHRubjZSdDF1TWRaSWRxZTdvVlZLc1JKWnlKVFRZNHp2?=
 =?utf-8?B?OVNmYXl2L2RPaWJvTGJwcVNRZTM5MkNydlBjclF2a1RLRDVuZTM2V3hXblln?=
 =?utf-8?B?SW5ZQUlYYXo0ZkhNV1p0RFRxVjVrSENSZHoreGtHTGdLdEZpY2cyRkpRR0tx?=
 =?utf-8?B?dUt4VTVITEQ3UzRnWHRxSjBhZTh1bzl4STRPNU1vR1Noa2RMSUlRazBUNDdK?=
 =?utf-8?B?dXprc0VsS05HM015Z1J1NW9XVjlOd1c1RnFwOVloaUkyQzdaMTB1eW1CalY2?=
 =?utf-8?B?QkFmKzN2dE9WSEZqc3JKdTFFS2U5aUtGeVpXUU10L0pnWTJXRTE1WU9mZ3RL?=
 =?utf-8?B?NUdUakRNVXo4dEg0Uzd2cGdWRTA2T0RrODZ2REx5ZWpBMUdNWWNOWGpwbnJG?=
 =?utf-8?Q?bJisJ/MaNMYrQYSPrME4ZHNS/j5vCwU1eeg6uXxzwq0rs?=
X-MS-Exchange-AntiSpam-MessageData-1: PAMNC3piAteBwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a99f2a5-ea69-433d-208a-08df040d2735
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:31:05.0245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i54WwGmfm+bW8hk7Re046983AnCQHIjtGPldHlQ57tN+yOqP/MtFVvxCuu8BupULblK9BH23R4KPdaVF1SlZ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342
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
index 42a4cd7971fa..66ea697a89f8 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -33,6 +33,8 @@
     vgpu::VgpuManager, //
 };
 
+#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(dead_code))]
+mod channel;
 mod hal;
 
 macro_rules! define_chipset {
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

