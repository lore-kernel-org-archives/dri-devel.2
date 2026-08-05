Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BA0C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4A710ECAF;
	Wed,  5 Aug 2026 05:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TTuBRhln";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D0010ECBD
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fenOgNkyApiPj1RF7esuX0cGBHKzN5VSbA2YNeHA92KUoZcFo9wc7oqLbLc9mlNeilN8hGsvIQJUF3UlgmuGjrkUfgjxCPnJrtCgjtHmGJ4bbVu8QCg9XXY3PUHsLWSHObzWRoYfyw7lYsUSl5ZKQGmJL4Z4jag2BUVLtHQe7y29TJIg3ce4milqq5n+7W/nXo4eKclMxiqKhKasoYoX0BhhaECtzu/9zGXyXgNRuhgIK0nRR9n0hMIY0JyNMNzGac8+RSrIsICDfZ6N50NbAkfUNx88jrqBR2NFx4sRsriMjMrOD+ceouXV53PegFtC6qX2eyBcKCNcrv5gwjWcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySLHY1auqKK2L0EotcEpJEtnXPUV7Lv3gQcIpvXHnXc=;
 b=qpZcTLC5Y90FyHeQyxSVjDuHVuvOf2c4KG3qa/XY8m1LyW3wXLV1mCMtOpwzX8EtYZqP9XL1bI8bhUmSxhg3zI8fG1Qp6KHH/v6EK6iDZ4zUcmbUBipDwEenWIhVqprxKqHuPshZUQZCLTWAPs8Fp1ui6VHbV09gqpCLMUm2lJgppMQKOo0qTF6NZdd7RMtYIPFT3t3hlvzNK8g1cp+HZtld3f5A2IZCWkNYALFEVOYXcX5q+AjR7/8HXVii0Mgf6oyzQ/V685ChVKNPXtklLWhHCH0stZmMEaRDYq/B9E/Zqk+pcBT+SjYaMp0GHwgUSBDFkRgg8H+b2LxNw+9Jdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySLHY1auqKK2L0EotcEpJEtnXPUV7Lv3gQcIpvXHnXc=;
 b=TTuBRhlnOc3hOi4JCmQ7O9kq8uuKMZqhkgLy8SS5eIjnYkkuY4Ha6l4cMgtTVIPMfur1PbN46dCvUM5rDk0Pv2Z/cR5N/7wrBgcHuvD/TfI6kGR6F7ooViLxMfLPmXvqEgmnCZkf/fKj5MOVLL2GYpSRwFPz4SFXN2Rl5D4clayNwGbHw1wdy+4qn1obfpq8JDsBmWr9fgpcgapWB/DMoAlAR4erFqeUYxnDZsUZe/yW3lTpT6hyBOMQTK+CCVqbCmZtJs7x2xXiuFRGx9csRZPRKtV2WarwkKAdhpjaCwJxJiU2NWKpoVUhVMZOEvhdFWMpX27P4GoGWWH1ADhSQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:27 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:51 +0900
Subject: [PATCH 04/12] gpu: nova-core: mm: Add VramAddress type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-4-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 6811de76-4945-40de-7317-08def2b4c07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|3023799007|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eOqZ5+vuoNis/pU3f/cvgYYoJzgKXRDS6jn1C+vlFOkC1kWNDavNSRO7GREVAz7fLxLg4QpQIx7p/pnU66396iPW3O4+HzHhfWQXXdp9zuC6BZvTzWlVbhj9X2fO8K0EjXBmFooUF9hUMEc3xspjLfdhsAK++hQbtk8xlSxZRxRGsAaQ2nxhaVF73vFU36pOlzHCUgqxzhjAThmOa6X/CaIM/3TdcJH/U0aop4GSTI9pmXbdbGKEkLKllpr1fqBo88yEHrZ64md9sbqUgN0eU4jaoZrqtIQSNNjxJgZVJ8T7aRMCryJUZtqa3jrat7eMCE5GNyInx+XK/UK2hkwQ9R3M1B5NQNeuZ2uQVfAXZFu5EHmfQkACCxhBt85tmr7vxyjMvOrmQWTo3cgbo20RwuX6vR7tL/mHX0XqmafiJc/2nYv+ivxbIKfL6XHoDdIg4lB4ThFTUGTM43kWblheEn2dc0sDZua/Tz/y3x+IfJ/NDTe1OIi2IwbGbLqhuiYsZxQ/op0jOp/B61ZUwmI/1iM3oPrBNruj8r3k6ec/EvLwT04eKM6GQ9yKg2X9I3wbW6cTpnv6ZqT6gfZ+bBOVTD2T7GX3Y5b8X0S6htBNzb+gdOuuMj92nWC+djhC8H0EFElocc6DyxKR4sq3XaPW2TcgscVRIzG6Xao9BWKeARGxGXxRuhoDmQkh4ayhYozlhMN0bfIMcqiUWknUpb6ZMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFPcWp6Vys2bzBScUVJd0xjblhINHFsMkJySHp3M1lqMlpKTVBDeW9MRXNj?=
 =?utf-8?B?bG52aFFBRmNoajl4WUxZTStnRjN0NytabzNLcmxiS3RPOGw2d3R6TjlQdWNj?=
 =?utf-8?B?aGduQ21QWnkrS3l1bHdnZEp3RXU3SXRNeFlYNkIrT1k4TGtySnNKS2R3alZM?=
 =?utf-8?B?OUhQeWlLbFNiMEpXK2lUYk55TFJCNnVDUmhtRUFwTFJtamdYejI1bWJNREd5?=
 =?utf-8?B?Z0J0bDZYYWFmdUpGVEdJazBZOVVCSGVDSWR1RlRBdG11YjJzZ2N6NUIxbVBw?=
 =?utf-8?B?VTJSZFBoU1ZhK0xETHQ5citlQ1FDSTY1Q0ZxMCtCRmxiSHlXYVZsbm1NMkZZ?=
 =?utf-8?B?VlA5WWFlNHN5OGpBenp1VytDUzIzazFUaDJDZWUxdzB2eDNKb1k1N3Z3aDBX?=
 =?utf-8?B?OXVSZzVzS2JXdUFDaUFzczA0ZFB1UGVsSmZGOUNINlNkV29vMWhmVTdFVmg2?=
 =?utf-8?B?TituYStpKzNMeENIa1plYm9qSm5Wd0Nvdk5VbkFvcklKMmNxVU5aQWhOMG1Y?=
 =?utf-8?B?bXJGR3ZNbGVHK1RTb1NiZHpDU0Zyc1FGM1BGSXdvM0xXa05WNjkyZlVBZytq?=
 =?utf-8?B?azk5eHVOdmdEcXBkS1JVaVA0TkNnd0hXZktOTlMzcTh0SjR3eDh2VFFlTmtl?=
 =?utf-8?B?Tk8yTmIwOVBuYngrUGpvby9rQ0FuSTVGeDJrQmRqSGNkSGtxcFRYRzVRSW1l?=
 =?utf-8?B?ODdTVG80djZuV3REeW9BSkRLMHdKWEFzWlB5VXkzNm9LYU5sUmtUT1NXQW1Q?=
 =?utf-8?B?WklyZG1XQndZQ0ZNM2ExUEFBWHJLUml1TDBMRTNialN6MGNHZkFYVmIvM1Z2?=
 =?utf-8?B?YVpkOHJtTzQ0OHNnMFRyR1dsN1c3NlQycDhqQ2J2RGFoREpDdm96OENtek5U?=
 =?utf-8?B?RU8xSWRrRk1rakJqMjQ4bHpjd0d2allSSzlMRWxCdHFTUEgxS050MWc3dTVa?=
 =?utf-8?B?b1ZjaUUzODRQS1cyQ1ZERmwwUUJIdEFnM2ZRY056a0toU3lrS3E2ZlRsMVJa?=
 =?utf-8?B?am5UOElocXEvWUxPRHBQMEZXYXNZVzlqWmpJc3RENVJ5T1dlL3F4Y3VldzFT?=
 =?utf-8?B?RlJCM2lwUkNCZUd5RXcwb2w2WEEzUzBRY1VtVy9FdHMwTzE2TVFhUG84NUhh?=
 =?utf-8?B?M3YvQ0g4NEtTKzR6U3BRdEt5cjkxNWQ3QmVaSUx0VWVZQlMvVXJpR0NTUjdO?=
 =?utf-8?B?T0JFdEcwSGtYdHEyNEo3QTlOUkJHR3owQ1kyMnlnRGVaSFgzdVNldzNtbzQ4?=
 =?utf-8?B?SHhUckFMcmVzZG9ZQkRJRko3WitURFBEMWFzVk1aSjNlcFcxQktKRDg2cXVj?=
 =?utf-8?B?U3NubWhvRVhpMTYyUFMzc25wTUcvVnhxK21WMnp4VnBLRnUrOC9jNjdsVkFP?=
 =?utf-8?B?ZTZFelRIeVlNV0FaSjFRdU10NEJBT3UvdE9hd1QzLzZQc1hUS3JBQVBnWjVz?=
 =?utf-8?B?YnR4WnNWMEtPY3pObmhvdlFlZ29kWTVmdTRkU1hsZFlsNG14OHZxT3FndXVM?=
 =?utf-8?B?Q1hiRU1CeFdEMEtVU0Y0RXU2NysySVRhSnNrQkNFSGdvQmxVbmRUZXJ4aGNB?=
 =?utf-8?B?ZmNoanQ3U1R5SE1BNlNJNkVsWGE4bTFLTmR2R1NwTTFQc2JGcG5nMkpKVkkw?=
 =?utf-8?B?Rm43dzBWNkJXeXpKUWo5UmV5bzZnUDEyN1BkTTVsOGltYXZmdWdBSXM3eTlY?=
 =?utf-8?B?a3Q2dnRWVzBuaUhrQzEwZ1I5NUFnNERWOEUwcnFlSHJWRzFRMWE2SWtPdVJ6?=
 =?utf-8?B?TzdBNmMvUUIzajV6Ymd6TUh1U0wxUEJBREtQY2liL0tadmpoKzlnbzNKTXpk?=
 =?utf-8?B?L2FBUVlsd0wvRzIvRllBckZsc2VYNkpYN09jODRoY1llcjFaY21GbnNUTVpn?=
 =?utf-8?B?SlQ3eUo5d21LSkZXc25XQ004RWMyTkdpaTJlN0UvR3FKaVZxYlVTU1YrYk9q?=
 =?utf-8?B?bkFkR21XeFRFUmhXakJIZ2padFVMSTdISGVLMjRjbGxjR0NDdW1EcmplczJL?=
 =?utf-8?B?RTV0cENLdE1vSGtlNjlQSXV0dVRkV05lTWdqV1RYd0YzL3Nzb1BzOFNYMURG?=
 =?utf-8?B?SWhVOXZsRGsrS3BCUkEwc1F3MTdQTEt3TFMySTBPVEdibFFMb1Rrb2FIbVlX?=
 =?utf-8?B?Q3M3bU9tK1B3U2wvSGVZUmV6S2NkRjVMRlR4aEk3VUJ2S1B1bTgvamZhMEVs?=
 =?utf-8?B?WjdmRTZwZDMwV2M2bVA5aEJPRUYvYXlIbXlJVFJUWnloTWhRV0hKK1pIUmRu?=
 =?utf-8?B?R0JTczZCR0RvK2h6cGVuMnI2ZWdGVnRpRDF2bnNyTVpCMGV1TnVKUEx3Mm1N?=
 =?utf-8?B?NEpiWmtvQituM0dzdDZvcDRpdnRUNmZNS0J4OWRuZ1kvZnNwanRSbm1mUVAx?=
 =?utf-8?Q?PUBG3N2G1X36o1WxSxVG0NjfEYrVb/gjDggq/2R8szgoy?=
X-MS-Exchange-AntiSpam-MessageData-1: YewaKKkb3EYaHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6811de76-4945-40de-7317-08def2b4c07c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:27.1471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7v3O5DOzsjkBdo6xtzGmwkaudV0n1p2utdiVw9/5GQMujrDlN30F8yccFTo8HQbYtFRgTP3WIBPrmchdLnooNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Add the `VramAddress` type representing a physical address in VRAM. Also
add an arithmetic helper, comparison, and operator overloads which are
required in later patches for address arithmetic.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: create mm.rs here, squashing in the arithmetic patch]
[ecourtney: splice the two commit bodies]
[ecourtney: drop the Pfn fields, open-coding what bitfield! generated]
[ecourtney: drop align_down and the IntoVramOffset/IntoVramRange traits]
[ecourtney: make checked_add() const over a plain u64, derive the ordering]
[ecourtney: doc wording, header, import, and signature cleanups]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs        | 60 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |  1 +
 2 files changed, 61 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
new file mode 100644
index 000000000000..dcd5e5e919bf
--- /dev/null
+++ b/drivers/gpu/nova-core/mm.rs
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Memory management subsystems.
+
+#![expect(dead_code)]
+
+use core::{
+    fmt::LowerHex,
+    ops, //
+};
+
+use kernel::fmt;
+
+/// Physical VRAM address in GPU video memory.
+#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
+#[repr(transparent)]
+pub(crate) struct VramAddress(u64);
+
+impl VramAddress {
+    /// Creates an address from a raw value.
+    pub(crate) const fn from_raw(addr: u64) -> Self {
+        Self(addr)
+    }
+
+    /// Returns the address as a raw value.
+    pub(crate) const fn into_raw(self) -> u64 {
+        self.0
+    }
+
+    /// Adds `rhs` to this address, returning [`None`] on overflow.
+    pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
+        match self.into_raw().checked_add(rhs) {
+            Some(addr) => Some(Self::from_raw(addr)),
+            None => None,
+        }
+    }
+}
+
+impl LowerHex for VramAddress {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        LowerHex::fmt(&self.into_raw(), f)
+    }
+}
+
+impl ops::Add<u64> for VramAddress {
+    type Output = Self;
+
+    fn add(self, rhs: u64) -> Self::Output {
+        Self::from_raw(self.into_raw() + rhs)
+    }
+}
+
+impl ops::Sub for VramAddress {
+    type Output = u64;
+
+    fn sub(self, rhs: Self) -> Self::Output {
+        self.into_raw() - rhs.into_raw()
+    }
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 35a8b1214b0e..8f59cfa97017 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -18,6 +18,7 @@
 mod gpu;
 mod gsp;
 mod mctp;
+mod mm;
 #[macro_use]
 mod num;
 mod regs;

-- 
2.55.0

