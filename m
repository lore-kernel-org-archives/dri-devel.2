Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6657CA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE6910F136;
	Wed, 30 Sep 2026 02:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z9tGURJW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A24510F11C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 02:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebGhAiUsEywFmHkSRs7jLvJD8aMMVfHIVDv1Ek5J0bgGb+dGPwnQte4QA/hwIL0coCehN7gFdpwN8v+pG+VAMQICPmVMwK5j3GlnroiCP/AesCBUI+L0f39NYyjtZwmL0avR0zcdvA3PfE91RFaXJYY7TnMfVb6XZkp8Oxz2sXAPfEXoIGMTRsfx1vbQjqtjhN+GUbD9Y365kxX+0C9Zoevk7aUkidlWtgYu+BJFgaaBfgMN2CjLQd4omqVsdTTCXRXE+c5xwCr4aPtCUqz51rhNDcMLpPLjtxurENx/QkVZz2yEdvZcoq7Ox9MammMZoea9/0y+im1uksivQTlz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YtbUKc377qG17bT8z4QPM/Yq7iyKZdime++Sy7FNDk=;
 b=d088TF/65DtUi9grAfUOFIukn3KgOmop/SJjUxB7P4AFjoAPh6YywY3Vx0WDEFbnFn1utwYsiQBibg06qj5b1xR+KPIhipMtinzBK14B8fWuJdWvEkf5G1xVt/ETBqpzwlArlkfCUI6uczdwvzBfKTL3zYlhNT9NvkzdVsVfo5Zx58nD9mNWNtUka9RWDoKt/dxmzjd/bEi0FMW+Mmj5ZaWn4Gz0q7yWwRSxoWwRnWaYYwjwAeBNh3USeQz+Zg0RcWNkBInTyWZ+5RoHSJFtViFolJh9IsD28UQj1QJnhrQynvPKIVFSYhgY9FTsxGXpSn2jG2VYdZyOYruMCxlhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YtbUKc377qG17bT8z4QPM/Yq7iyKZdime++Sy7FNDk=;
 b=Z9tGURJW1QisauQwmn+KqwLhU/2SVaw1QVpRzh2dzieq8+IkJ3+7NiJFJu/re0Gy2LSa0G5kiPIVe2BngTHbP6ddCxOSSV6WMt7ZZcbYJD53wswXH2/4bxR+UJhT+I8oxZTsW9JuiiMIhh4xM5Q1d3mYcS3VKkBAegrbYDNC/8b6sUPaOEUPjqc+scWg57rEHwXxcHCS1CBicBeeF9SQ5Os8a2VsDzv/9tNeBGEAbrq7tn4fTd6fMz89AY9h/aBa30T0UXx5Oavu23Xor5tNtPhooc7FKHSrB+64YFk2wQHDiEhn4qTuNEr4K7+O95ACvetikhg5G4T1AJ7OOmJXlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 02:44:47 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 02:44:47 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 30 Sep 2026 11:42:56 +0900
Subject: [PATCH v9 7/9] rust: id_pool: add contiguous ID reservation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-chid-v9-7-0d6cca376cff@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: a226f496-d7ae-4646-aa5c-08df1e9cca7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|7416014|376014|1800799024|366016|10067099003|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uprty2VNOQdiu8Q5uxX1qd2EqcUmEywxJVRx+0AM99aCQeuouzvEZGNemkMa80/50V4Yrztvgk0kjEMJ4uWT48DgrhsKwxKFcbUu+8qtETMkn8LYZk/qx0YPCtNVL4V1N2JQycS+YeTPsqIQzv5bbjSwBn1M5Gx6ysZzxkolOjQsRZutIU0Y8SjQJN1zj5acuVMf4PLRy+Mt0gHePzw03ln9MlpfvDF51B01cGA9zPKvURSd2IXQdECmWk5Fb/3Xj6UCiA6bSI8bhX+mC0WwmodY1CX5eNuLPI8axfLMBtwqGObyjYAnrmCeoDn5jov1iTMrJiNT1yl9TgpKCRtzf9HaXeUX2/IQt+iVIsM3tmSuDXqHeFfjjjlwoWZZAWjoabfKLUtEAAsbAcZXmQjlpGYn46Y0BCOe/CrupHPHe0DfgljhhgdaGUegPtEE8Rlj4xSNBpTMUnhP5tz9OjJ7Bug55znHL6eryz2qXtIqlrPOv/Nab1QDB2JJUfHXb6Ivqm5p/3fu1WvemVSMgufDPNxQOPNVty5+NWtBqI4LaWWlp2oyANMk0cxwKVPdB2rz4liHWxtkQ527+C2tWgMpd7Nxk+kv1jMhTxnxmmPnmgig+tsFtuvl8+WbCW982lhn4s7JkIIil0RyclFywie8Zv7YtMjsfTXkVHLIm/r3EqnKA1kph0U8wH8fa3YEeu46pa8FnyBK9Z77/SPHuhA9nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(921020)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWdzNFg5MTRMRjRyTTNTdHBhNlJpQkRxM25QYnllK3NtMGVKR1EyOWJRam42?=
 =?utf-8?B?YWt3R0xUT3NqZWdjWHlac3c0aURBakppQjc2bkV0MEZDeUdZNUI4YW8vZnV0?=
 =?utf-8?B?d0Y0QXJVb3BvdmpyZ045aWpwZU1NbFphV0dmN2pidWFmdE1TekVjaHo3K0FI?=
 =?utf-8?B?bE1ySVFVUWw3bmlySjljdEdXZkw4ZUQ1Wmp4eWdaeHFjUTBjd1N2bmp6bjNy?=
 =?utf-8?B?OXJ0OWsxYUcwNjBjWVI5bGczbjJqb29WVGJKbDJOdVNYQTFGMEc0S1Q1Q1Bq?=
 =?utf-8?B?S3VQWExuMXpOTEhyZ3JhQlNKRDlCNFFqakU5M05XV3NSLzljNVJrK3R2LzRa?=
 =?utf-8?B?enhyRGtVRUpyMlNEeG8rNFVIK1pzNWViWnFGMTBBeE12d1pBNDQzdFdCVjF6?=
 =?utf-8?B?Mi9LWVpZUW5Fb2MzTVdrcHZBb21BM1ZRcUtqcHFxSnJrTFdrUWlHMUl1cTRY?=
 =?utf-8?B?WU9yamk1TUtDVjhxSW4xakFTL2dzN2tKWXFKVzdjcVVLK0w5NU5FS2Q0T3RX?=
 =?utf-8?B?VTJjM2w1Q092bXhmZDJNVHd3dC9aeXVLTlBkbTJRakR6TmdKTWNBTkVBemQ5?=
 =?utf-8?B?R05CRXhnVFNZbHd1cUo4RFdGNm5FT0pMWkhzSnJ0SEh4cDcyZjFWN3lYR3hp?=
 =?utf-8?B?WkxoMTczaXdrT1NJOFNtNzFDMVVLeWZQcmI1bitlRUFkQkJjQWFJak5Mc2ZC?=
 =?utf-8?B?TmxGRU1pV1MvdTk0M0ZWc29rejI2bFlyRmc3YkMwQXZRMEVxWDF6RHZrdk5B?=
 =?utf-8?B?UWMwYnUwamlPd1VueXh0SHUvV2w2NE9kS1A4NW4yWFRYR1ZoRmtzeVBGeE9P?=
 =?utf-8?B?SzFNckUva2xhQlhOTHlIRWZNL1Q1Ny9kdVhxRU5oNmw1QjAvVVgzZ1ZrcXpI?=
 =?utf-8?B?QytNaFd2cEpEdFBOZTRiMXd0VTBCRWlxQmhyYUc4RHNOM0d1MHZxRWs2ZlFB?=
 =?utf-8?B?K3EvcVY1bkhYZERiaTkyOVRjaHRnM2U1akM2VFFvOFJUU0NJUlFFOWlSQi9N?=
 =?utf-8?B?YlZTVmlEK0c2WXVaREFidEh6YWw2M0ZaVTA1VW1DSUpkQ3VudE5Jb1gzaXZX?=
 =?utf-8?B?K0hjOUZzR3Q0OUdpQ2YrR3lFVzNaVkhBN1crK1FvbkJQb1ZHd1FaWHJRcVZs?=
 =?utf-8?B?SE5KVmxCUDA4Q3krWjQrRWZqeUxwZzBSL1JwbWtabW1BWU04V0w1T1BxN0R6?=
 =?utf-8?B?UGtyWUw1Um1HN3VJK2FQdHFVM2dsc1lQT2wyV2F0aE5oZ2dzdEVYUDMxQWJ3?=
 =?utf-8?B?RldMbVlCZmcweE5EWEkxQUhhOEo5eVQ3a2VncnNJenMyWjhIRW1KR1hDZXlq?=
 =?utf-8?B?ZHB2TEVaTGFmVHBpSG1wWUNPMHZKVHpOT0N2MlNZcEQ4RUxpM1dpMngvN3hw?=
 =?utf-8?B?eTd1MGhvdjk0aGJEbytaWmt6aE5HRW5ScGdabnFpV1I4UWdIWTltd1RZS01W?=
 =?utf-8?B?U05xNkVodHFGZi9vZmt3L3REU2JkSk82MEtYQ0krdzlQQ2tPUTB3cFBNZFh1?=
 =?utf-8?B?WDdSY3N1ZENXOXQyNXNaS3c2U0Jra1phWC80SitLZ3BBNVRXV3Zodm5xYUJL?=
 =?utf-8?B?Wm5RWjVpSDNwalUxc2x4bUhGYk90R0xDd29zMzI1SHpBeXZlT0Z4YXJ3WEhr?=
 =?utf-8?B?OTlhZlNpNzRrdDVFQ3lGdUdVckRrWXZvN0VPTnJoZW55RFh1R3QwdmhSbzhH?=
 =?utf-8?B?OFNwdzh0amtSWHZ0QzBNM0NqVWFHOENybmk4NURWTzREOGRCZTNiZmxqR1lS?=
 =?utf-8?B?YnROZDdSamNTckxGYjN5YllnazA3UXF1aGRNVk1URHNVTVdNUU41dzhER2VI?=
 =?utf-8?B?VnVZTkFmSFhuUXgzeC9ZdG5XMWVvQU9XKzh1RWtiYmFlcWZUNjc3RUJ4UGtC?=
 =?utf-8?B?TTNvNm40S25TYzJGY09ZUzh0cE8zYmVVTVkrbHZIYkN2TXdtT3FEMkFhMzBX?=
 =?utf-8?B?bjRKcjk3ZzRBb3RWelB6UTZhTVFpQlhFcEZ1cmNBQ3pyMWU3RVlOeEh3bEt5?=
 =?utf-8?B?N0hDQ2Y3aXd2b0NYcitFTzEwb0hWMGVJdG5sdXAxOVBPNmxEeVJiTFJyZExC?=
 =?utf-8?B?ZjFrS2lJdnZqY1pkZjVFUjVIMEhnclhiaGRobXZmUGt4bmpRWExSdGlEaVJM?=
 =?utf-8?B?S3FuWGhLS2kxQ0NiVDB2a0RPY1VHY1pJRHhscnc0UHpnb3JnbWp1NTZBSWNL?=
 =?utf-8?B?ZmczVHhieSsvZ1BNT0EvQXFmbHltUmQwbVY0V3BaSEZDY25xZ3BvKy95M0hE?=
 =?utf-8?B?YldRaXNFc2pQOXZjcXRvNXIyYXlQVUhQdTFsYUpCRDVMRVBUbzJlbjBFNm93?=
 =?utf-8?B?MnlpT1dhcjgzd2RtK3NSeU9ScFlrcGhnSDF5QUd3Smd2bHl5blRHdEsxUTJk?=
 =?utf-8?Q?IZiOCYkE8MAOXh/FRifmuRobU4jPicxfh7n4YPYo7nu0y?=
X-MS-Exchange-AntiSpam-MessageData-1: 57C1JA6szDLF3w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a226f496-d7ae-4646-aa5c-08df1e9cca7d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 02:44:47.1861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2WjtipSZ9Jw+BvsTJ+8kvYhYkuL1iiPaVoUn2MzNDbhp5CwBAgy3/WEhQbw9CY5huDxDXZTv7/XktK5Xzy93g==
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

Add `IdPool::reserve_ids` which allocates a contiguous range with the
given offset, count, and alignment.

Reviewed-by: Burak Emir <burak.emir@gmail.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 384753fe0e44..06a4c71c4c6c 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -4,8 +4,14 @@
 
 //! Rust API for an ID pool backed by a [`BitmapVec`].
 
+use core::{
+    num::NonZero,
+    ops::Range, //
+};
+
 use crate::alloc::{AllocError, Flags};
 use crate::bitmap::BitmapVec;
+use crate::ptr::Alignment;
 
 /// Represents a dynamic ID pool backed by a [`BitmapVec`].
 ///
@@ -240,6 +246,32 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
     pub fn release_id(&mut self, id: usize) {
         self.map.clear_bit(id);
     }
+
+    /// Reserves a contiguous area of `count` IDs at or after `offset`.
+    ///
+    /// The start of the returned area is a multiple of `align`.
+    ///
+    /// Returns the reserved range upon success, or [`None`] if no such area could be found.
+    #[inline]
+    #[must_use]
+    pub fn reserve_ids(
+        &mut self,
+        offset: usize,
+        count: NonZero<usize>,
+        align: Alignment,
+    ) -> Option<Range<usize>> {
+        let start = self.map.next_zero_area(offset, count, align)?;
+        self.map.set(start, count);
+        Some(start..start + count.get())
+    }
+
+    /// Releases a contiguous area of IDs.
+    #[inline]
+    pub fn release_ids(&mut self, range: &Range<usize>) {
+        if let Some(nbits) = NonZero::new(range.len()) {
+            self.map.clear(range.start, nbits);
+        }
+    }
 }
 
 /// Represents an unused id in an [`IdPool`].

-- 
2.55.0

