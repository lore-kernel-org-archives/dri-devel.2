Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483F210F1C0;
	Thu, 13 Aug 2026 07:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V4INhXgO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC7810F1AC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:36:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edZ28uPa4WiN4PqYAOeJ+qIsbNyyfpEc3QSWuc21ATVLQMy6VOJI9Y/FWSZmjWgxLtidCv7jr+HPO6G3dvZ/Zo3S1VR/Il2tOqaA+KNx2LTHTzUD5I5Xz2u9GexvKdZzoMR1M4lhZyeYpG+guxIYVy16lfEKr6jWhbwOaZGv9CgAjf8uVYmSVCRBkjCAVKCYE5wHBkugQKr6b+yaKlge0HSuG+GYHOLUM46VcoL7E1kxHGtlaNTV/HE9XWaAVdWzaWvjrVSnTyjnyXX27mQgPCoheAxEXcJU1n6gNBdZDqOwY4WqljA2r9mE51x83dOrV+JDSI85FDOuE1WJIwV87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+C+8ezKuS/MzZS1Ucmtx43nVNFN/Bu/DAqSI6+h97U=;
 b=ORCTQTfPLEaLnBppE4FvhRNR1GJovPqf5wnv9D2oGWLgLLtUEd25H78OUD8C/2aOZ6MCq2b1mqwFwXltHZ4Dn7m1SkaEn1rI5EDYMOTTGLIaxk3ox9vtkUSbIyfZz2RFNrkC0ltRl/CqnksKYLDtC4LSEje2ugkpWVjBwk0+8fC74GP9PCDcyl5+/Zn3jzK7GtUHpUrx9xFe/zTkL3e7uwv1d9qfSgPvq3eZbSsNgwrc4X/8cPpTPsjZUurvUU0Dd5mFQ4FHSMjtvJxYRubxue1XnRsJ+ud95z9zYC18X1CsPNAUe1ytScQsdpO9dC5vBvWx0zCJega/6Mg421UtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+C+8ezKuS/MzZS1Ucmtx43nVNFN/Bu/DAqSI6+h97U=;
 b=V4INhXgOwUWqhPJyHhP2cWn2JSvS/XwGu+eZNvIVqH3XOQF7ud8i6OEi1isDV/uiyba1XMBwW0vZIO3yhyYwLAYXqJ55L+Xu1RbmcEy/PHv6oKECMCtan8JmIGKEJuYVcT8b3AjE+jBv1sU73J6L4+W4Awte8XJFczcNFWZTHYDk2xiI/mKioJtGZEX3t4rfI7+2xlTTVoqfnoXkNW+7ZTM1W9AhZZL57zVrTjifwPUGl+6MGh53SEYppN8q3kCqvE3qRIdhJ6l9cak+W27J28M9+91Ktzo07tjeEy7PU+LKuVOwxX1IQLgxwJMTdekO1+iRz5v0BHZuMTC4/UFd2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:35:04 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:35:04 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:31 +0900
Subject: [PATCH v6 7/7] gpu: nova-core: add ChannelIdPool
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-7-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
In-Reply-To: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9de338-8f3a-422f-c220-08def90d63e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yCz4h4aD62o5ac+8oNiz+edwCNowk+6ZcTczDYFUFeP3ocp8q4cTGiMglGJLK1qZpmehsq0jjWrNERZumS4ORfa+CcOGIBsLFDaWQFtAuPw9N+WjaNY/GXPiZR6+ClZ8LaCaQqbtHV9ZfMVMC2GOhmEqWI7Is+PnPe/Smpzq7yKEdl6mmZFI85urVlDxNDgthfDM2aqFK5wveXBwaud206TQ5C/Gv7EeJ3+HEo/dVc2sjzMXTK1hIW++KU3SbmAJ9ta4FXe8OmW/EJFx94Yp4la2ZH899DtW2a8S1XzNBWAzoY/Aq/Sf+uh4X3+4Bypj81oi4OOJwph07KNs6jhc8lNF7/CJfLzqyPtfm5UTCSHjs4nbZHy/ni5JjPfVTMo+xvvLaWA52G1zB/UxAJiXcF6t+NmCOlP6IkKx3E5KD0N4ERCgIwObTzb7pXrjzniSmu9VUS70h+eEXNKqCgawGEpBcUSYu1muRbDInLhqiIZwetyzLf9TNo8HiUcf7oTG3LwPFQme2Hp5eW/3lrvEYQxxgdtzYYvOVpWhWnzlpfRPLdQi66OJoi+M4xQj3UjHKMnatL0YGcQOImpVgWh8E73rgnTpPcXAxZywuQhkPB1eGacoo7gWDnbjIR90BhBZiyvG7bbqaDjFktnclf5oL+y/JvSn9F9iLtg3HSwXC1Ru77w2SqepnrOaGJYpRjNpxuscx/vTsODQJwZ7I9M8iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmd6TlB2TFZ0TVVzSW40UHhKQy9ldkVVaHZrZlEwMzJRRExNTnpSV1RPbyto?=
 =?utf-8?B?MSszbWZ0anhPU3JuMWNZZitINTN0N3M4Rjdjbk5HZTVwbUNtdXVaelBiUTQ5?=
 =?utf-8?B?d3RjNDlRVHArSFYrUEl5VitWK3BpMFQxbTVhSTc5OUtHaEIwcmJvK3ZKQkF3?=
 =?utf-8?B?QnkvRG9vTGxGNm5UcVY5VlNmUnlVeDBnYkhZUUhMRzFnbm5VTWtSZ1phSU5h?=
 =?utf-8?B?Vk5aNUNzb1pIK3BiVEZ4Y05ZZUY2V3h2aUE2UUxKSDArVXNqZzN6Mm5waDVF?=
 =?utf-8?B?cVIzSXpLcmM2cVFONi8vb0ZicHozVFd0OVVtTXdEbWRlWXpFb0JPV0FtS3U4?=
 =?utf-8?B?L1FZTWYvSmwvMERUbjdUaHFicDc4RUZlbHA5ZElPSWM1VjJNK1BTT1A1Y3hG?=
 =?utf-8?B?bit5MVRFdjZrY0k4V1BiSW9UeXhJNFQvWHB4SGhWRUdvRHpLTGxYZjhjSVpP?=
 =?utf-8?B?MjNmUXVNc2VTUEZjN3R5M1ltNWFOV09EOHJnR0tvUEQxcGM5UktaQXprUnNE?=
 =?utf-8?B?MTVtTFRKaFhrcDN1bjVscTRUTnhCb2hLT3dGVlpucEQ0UDUvUTlnV0pqR1ox?=
 =?utf-8?B?OUJNRGJINEgyeUJPNFpISFhIOXhQOFpDaWZTZVU5QThkNDM0cnZQdTZjbThO?=
 =?utf-8?B?QzBoSmJQZ3F4bHJRdDdycElNbUI2NzNRa0VWYnd3SDdTWVJLWU5LcVA5Rmlv?=
 =?utf-8?B?VDhFcDZhNnI5YytGNWZ2SVJPVFNkSGpOSkg0bEg2azcwaUVGNkpCZUw5RzBa?=
 =?utf-8?B?SkNTbU54RHIvS1p2bEh6VWtNNTFtWUF3bERteWhzeUt0TkdDOUdiTUxWbGhW?=
 =?utf-8?B?L1NUUUhaSUxpQzFGNWNwYzFYbjB6TEZZN0QzZXh3d1VaakdtaFRvYlhybVY4?=
 =?utf-8?B?ZTZiVlVpSFlvOXFPb3FXMmNrcTJ6U2VESkZyWmZMQ1ZPeE5LMGFqbW9pOUxO?=
 =?utf-8?B?SnNCTDZVQktTOHkrTFMzWWFXRmk0Vjgyc3JXRGJ6VEljbW5ZdUEzVW00Rmxz?=
 =?utf-8?B?YzZBclpabzQzN09SWE1ZT1l5b3pJUENpRnNLcnM1NFVvUUx2M0JFOVJ2bFVY?=
 =?utf-8?B?cW1RZno2TlRPR2ZCZXhnVjQyVmhRTy9hd0JnUnNVdGQzRUNoaUpIcWFwNTFq?=
 =?utf-8?B?RW1jbGdtRlh0VnhlZm5UTklaNldUOGUwVXVZVkpjM3dHOCt6UWNGeHVEVXNN?=
 =?utf-8?B?WXFZK1lhb3JadVFsYktwL251U2RqeE4zb2h4aFA0ckVRbk5EcWtQZlpGQzhN?=
 =?utf-8?B?ckVyWkJWTFhDNEZDanM2VjZJVlRydjgzcWN4UmVCQkVhYXp0ZVNWQjNnNjlH?=
 =?utf-8?B?cFd4YmRqeVdtYnI4Rmd3cTFjSnVqQzlVRFZJcUdVMFJaeFlTOXVtWURGRG5V?=
 =?utf-8?B?RVA2cS9zREUwbDE1a2xXQkJsZW04bWlKcG9DSFNMUnBlcHhqUHFKRVBCa3ZX?=
 =?utf-8?B?elRwVHY3L0RJUTVST1IxS1Y5b3VJeTBXNzZvQ0FvamlJeitldG9kYzl3cUF1?=
 =?utf-8?B?bHAwWkp3YkVhZGFSbTJzMXMvMFFPcUthbEhvUW1TVnVsd0VmcWVmZEQrZy9r?=
 =?utf-8?B?bnRrSk1IRTJWQ2IxV3UzVTdMek1sS0NzNHZYcmlJcnljVGd5WlVhYmRKK0hO?=
 =?utf-8?B?cFNtbWFtT09qVG5mWDVLd21oMmNYOEZCQmp4SmZadnB0dHRhZUNjWm5VUllw?=
 =?utf-8?B?aG05cG1mVURibkc3L0FTQjFsTXBaREFoMnhSOTNJMEtzM2F2c1ZyZTJEOFpw?=
 =?utf-8?B?VTdLUko2ZmN5OEx2VVgwNXpVNVpQUm9uUE50dzBKTDBoQnR0SmRnV3NmSHNu?=
 =?utf-8?B?Um9xVmQ5OHBBVm1lQkZ5Y3BKU3lNZm41T2dCMkcyT1J0TC9jTXBsNFBKSGRZ?=
 =?utf-8?B?am0xMjRPb3E3OTdUZHZ1MEFLdmZiejdJWHhyZUZqUjBIZVZYcHdycCswZ0Ev?=
 =?utf-8?B?THhPVG1TU25iMzJHcnV4MDh3WXAvcHcvZU1OaWRVYk9zbnZjeWhZQk1MeUEw?=
 =?utf-8?B?M1pkUy9xcHJhZ3lmdXBOdHJVdmIyUTlvcmFHV09EUGFUNnZtRTQ4Qk90aHBH?=
 =?utf-8?B?S1h4UmtzQUs0aVJiZ3JJQ1VBb3N6WGRpc21sek5pUXY3VUNSV1N1aVNUTHRi?=
 =?utf-8?B?NnBZL21LRlNyM2UwSmt2cUpXQUo3SVVxU21DTUlIekt4NnRFUDJYNHYwWFZ6?=
 =?utf-8?B?NmdqU0haMHNXZ1RCcGp4WDJUYXA5OC8zcTUxdDVEczVrbHNvMmUrWUxMU01X?=
 =?utf-8?B?YmFCaURXQ3VVcHVsUEZtdStVWGQxV1NIMHA1ejdNVVRwNWRWTE42YzhPRU1p?=
 =?utf-8?B?NWlHcUo2cTFvbFJDdFptdVFyT3JOTVR4QW9JZHI4ZjRleVhXVHhGazdFVGpQ?=
 =?utf-8?Q?WTcLcDBATojFXWWGGJ047RVRAaTudn83gk1BixxVJHBY8?=
X-MS-Exchange-AntiSpam-MessageData-1: ywi5vfQi6d9AWw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9de338-8f3a-422f-c220-08def90d63e6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:35:04.0264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmsspNy8zuqG0gKXMWPjQHn5swTaLO61pm4bGTOoLe9JfmmDu9N6Ur5vH1I0qWA7ujnF1+OENqoYKpcK9Die2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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
 drivers/gpu/nova-core/gpu/channel.rs | 201 +++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)

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
index 000000000000..520436c6f6f2
--- /dev/null
+++ b/drivers/gpu/nova-core/gpu/channel.rs
@@ -0,0 +1,201 @@
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
+            inner <- new_mutex!(IdPool::with_capacity(num_chids, GFP_KERNEL)?),
+        })
+    }
+
+    /// Reserves a contiguous area of `count` channel IDs starting at a multiple of `align`,
+    /// returning a guard that releases the area on drop.
+    pub(crate) fn alloc_area(
+        &self,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Result<ChannelIdArea<'_>> {
+        let mut ids = self.inner.lock();
+        let range = ids.alloc_area(0, count, align).ok_or(ENOSPC)?;
+        Ok(ChannelIdArea { pool: self, range })
+    }
+}
+
+/// A reserved contiguous area of channel IDs.
+///
+/// Releases the whole area back to its [`ChannelIdPool`] when dropped. Releasing locks a
+/// sleeping [`Mutex`], so the area must be dropped in a context that is allowed to sleep.
+#[must_use = "the channel ID area is released immediately when unused"]
+pub(crate) struct ChannelIdArea<'a> {
+    pool: &'a ChannelIdPool,
+    range: Range<usize>,
+}
+
+impl Drop for ChannelIdArea<'_> {
+    fn drop(&mut self) {
+        self.pool.inner.lock().release_area(&self.range);
+    }
+}
+
+impl Deref for ChannelIdArea<'_> {
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
+
+    const fn nz<const N: usize>() -> NonZero<usize> {
+        const { NonZero::new(N).unwrap() }
+    }
+
+    #[test]
+    fn chid_area() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz::<2048>()), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        let first = pool.alloc_area(nz::<48>(), unaligned)?;
+        assert_eq!(0, first.start);
+        assert_eq!(48, first.len());
+        assert_eq!(48, first.end);
+
+        let second = pool.alloc_area(nz::<48>(), unaligned)?;
+        assert!(first.end <= second.start || second.end <= first.start);
+
+        let first_start = first.start;
+        drop(first);
+        assert_eq!(first_start, pool.alloc_area(nz::<48>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_area_drop() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz::<8>()), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        let a = pool.alloc_area(nz::<3>(), unaligned)?;
+        let b = pool.alloc_area(nz::<3>(), unaligned)?;
+        let c = pool.alloc_area(nz::<2>(), unaligned)?;
+        assert_eq!(0, a.start);
+        assert_eq!(3, b.start);
+        assert_eq!(6, c.start);
+
+        drop(b);
+
+        // Only have space for 3 IDs right now.
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<4>(), unaligned).map(|_| ())
+        );
+        let b = pool.alloc_area(nz::<3>(), unaligned)?;
+        assert_eq!(3, b.start);
+
+        drop(a);
+        drop(c);
+        drop(b);
+
+        // Everything was dropped so the pool should be empty.
+        assert_eq!(0, pool.alloc_area(nz::<8>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_bounded_by_num_chids() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz::<4>()), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+
+        {
+            let a = pool.alloc_area(nz::<1>(), unaligned)?;
+            let b = pool.alloc_area(nz::<1>(), unaligned)?;
+            let c = pool.alloc_area(nz::<1>(), unaligned)?;
+            let d = pool.alloc_area(nz::<1>(), unaligned)?;
+            assert_eq!(0, a.start);
+            assert_eq!(1, b.start);
+            assert_eq!(2, c.start);
+            assert_eq!(3, d.start);
+            assert_eq!(
+                Err(ENOSPC),
+                pool.alloc_area(nz::<1>(), unaligned).map(|_| ())
+            );
+        }
+
+        assert_eq!(0, pool.alloc_area(nz::<4>(), unaligned)?.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<5>(), unaligned).map(|_| ())
+        );
+
+        let head = pool.alloc_area(nz::<3>(), unaligned)?;
+        assert_eq!(0, head.start);
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<2>(), unaligned).map(|_| ())
+        );
+        assert_eq!(3, pool.alloc_area(nz::<1>(), unaligned)?.start);
+        Ok(())
+    }
+
+    #[test]
+    fn chid_area_aligned() -> Result {
+        let pool = KBox::pin_init(ChannelIdPool::new(nz::<16>()), GFP_KERNEL)?;
+        let unaligned = Alignment::new::<1>();
+        let align4 = Alignment::new::<4>();
+
+        // Alloc 0 so the first fit for the next area is unaligned.
+        let pad = pool.alloc_area(nz::<1>(), unaligned)?;
+        assert_eq!(0, pad.start);
+
+        let a = pool.alloc_area(nz::<4>(), align4)?;
+        assert_eq!(4, a.start);
+
+        // The area skipped over by the aligned allocation should still be available.
+        let b = pool.alloc_area(nz::<1>(), unaligned)?;
+        assert_eq!(1, b.start);
+
+        let c = pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
+        assert_eq!(8, c.start);
+
+        // Only 2 IDs left.
+        assert_eq!(Err(ENOSPC), pool.alloc_area(nz::<4>(), align4).map(|_| ()));
+        assert_eq!(
+            Err(ENOSPC),
+            pool.alloc_area(nz::<1>(), Alignment::new::<32>())
+                .map(|_| ())
+        );
+
+        assert_eq!(2, pool.alloc_area(nz::<2>(), unaligned)?.start);
+        Ok(())
+    }
+}

-- 
2.55.0

