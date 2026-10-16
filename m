Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD98CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EE4112565;
	Fri, 16 Oct 2026 01:55:03 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD3A11255B
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 01:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCWPsZhimmJYtn8tJfKXmGRd4KUHo5zb6XvrZqe2D6QETQIWoga5lx4n0+9F6OM5Cw7XztRlr/gZZrGj56FhIsS4JNWQGM7wT9qt2694DUgq/lSpMahx2AZmVaGDDzr+JhIffDLndrR+qEML5fZrSzy80gEyzTT6JTMz9ds84kQwFRrTR0FGRvDhso0gF86KSTcNuWkmWpCSYvInri7amC1BAk9ccvMvuMILSYrNMYdXLrUq9VemM2j0tc5Bi61JQ+oQ6DWwoh99LRx+PyetWvaYhIdKtO/EIJsMHPUjU4zaVBY8TPNcH+6vaS0cXTH3b+HK1aTNLT6e83kUxRahpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqArHoE6VMX8QVlCmzkTM0sXYw+u0/uMKCJtkTJXhHs=;
 b=Ue2be5xSq6sBWtUzZs5nWLr4iUmQ5fB/Q5homLTX0iQLsy4y94HaZ7r04rHPNf2ayvjmqsDv2XZF+nOIPXID1K2N9jBoSO2+uuh5s4wT5j1/F1DrlRS1uxqjZS45kxv0vFQ+3xRA1w+GfdXIM1I0Psq3jAeIUltDp66uagJSewpzPT9Xnv9b4JmwFhQwRQDJQ7qS4TiOT6SrGV+pqQCeXFcyfclRy+60VWaWJLGHgrEh3r9kA8RUXIAltUSA9NUyl0Km1oPJPOW3cCsPwrB1uuo6JuC5VqAteYV9aM2WWQr++FPQ4JNN3UBnxSJzZqu/aJJ8KFumbxq99OjScrQxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqArHoE6VMX8QVlCmzkTM0sXYw+u0/uMKCJtkTJXhHs=;
 b=rFMfSX2p7x+v0uguDbre+JQCnqPNnHw+dVT0Nha1kSwo4fY/TFr9+eRQKU4NYyZRaPjTDUi9HBVKaxOQwRKenmjF13tDpC6iIi1/fs7Af6NtYtPDjmE08ruDquA5KW5UYl85wi2WdfUAXeA22KVHblN6OvALnL/w8DZrAPpifhhFZauK0iLPK9XhjytiN3en+DjRQJB7dynJZONC8cNXNWMVwvZNfWmOLQMelxeT7VA2XsLxRMQwHkVqtuiutQpueHO6Wbh6wU6godJsOEJQP40BDSwWWKWjD3WAErY7+2jy7bGcxaLKMgTcVjcdH4HOA2t9LKkGfrR2Jk0LN+tv+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA1PR12MB999230.namprd12.prod.outlook.com (2603:10b6:806:4de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 01:54:31 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 01:54:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 16 Oct 2026 10:53:43 +0900
Subject: [PATCH v4 7/7] gpu: nova-core: add NVKV GSP_INIT schemas
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-nvkv-v4-7-e8b92b91aa5b@nvidia.com>
References: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
In-Reply-To: <20261016-b4-nvkv-v4-0-e8b92b91aa5b@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::12) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA1PR12MB999230:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f0bbe0-203e-49be-a66d-08df2b286b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|10070799003|366016|376014|6133799003|18002099003|10067099003|22082099003|3023799007|13003099007|921020|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ym1deDi0Ui7jXtMY7y6h+i7+MxbMqaiZL/KEMuLwt4xAY0CJsAV9ymyPpHmmMeR6VMyrr0ivZmR6ldSJCBmi1nnubnoUk9R1wwzxpyCjeGFk5+vbomMxuCcmk1hMtJ1o89uvyrPQRSzpczCyzEplAf7jXLqVS36eaBEXcJOFPqzOv0nuO3ndTYRiXgEd2DHEYoaPXNQLeAaXO0s7/GcGaIhObIAYLUvosnYWmmg+wycfH5ftyotwPvQvYHTtztN3UopNYar+OYSLBtbrP9JGszFXK+ChqYNBxmtqoyAMXFykaLsInQgUJjtlHau9OCW5NGGUE0tZlF58jf87tqHMJuG3PHpSXOHeYVJKQHQC7M8RurMLetS6eF5uW6XtWtQgh5522gY0E790hBwOylFul+9NDtEtFiPe8d1hNZx3euR63C2EVVM5hnNy91prGeMxGhCirpJiyrGgTfGdaMkIgW16Me444DUvRQM0uP2pknSpY3+Ienhjz+I8o+7sGBRS+v42X5Hx0FpaAv5W1RV/2T5p/lWG/O+X6IwSt5rGu6p1DpfwtoxtzpCbJ4lj2noXkns/s+NLnUtA+cz49IIHgTi5JAr/RIxs5LPCxL9nW7Az99aj5Cj23S5BGk2kMLjDS6PTF0c8BpHgNP1dkDLMNHuluiUe5ooP7MxOW/71Bkp5p4kJNQvYzuthsS6Ls+v5DiOLpDWsirigwuk2h8frGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(10070799003)(366016)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(13003099007)(921020)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBsb3JOQk03d3VlcnEvOUQxQjJwbGlWQkFqam1mT1pzRXhWUHVNdnVPL09Y?=
 =?utf-8?B?aEltNE5meGgzejc2TFRPTzhoT2hWTUNDUVZGVUZEOG9HZU5laTlEMUl3Sjly?=
 =?utf-8?B?SkRqM0pLN2NjZzVYckpzd3U0V2RzdzE1NjhlRCtXWmtGaDZjbmxVTU5uUUdh?=
 =?utf-8?B?ZVB3QmlhSkRuUFBXQTZKU0lrR09OZ3pIcGFabnU2L1RJSkhmaUVIR0dyWjMw?=
 =?utf-8?B?Z0pDMEU0bVhaT1VlaUxvWHhmbVZ6bU8rZHRXcnpuOEcxL1QwempWdkFCWWpy?=
 =?utf-8?B?ZVI0Q0d1VlhzQlVNWUVUOEo5MFZmWXl5bjFGWS9MRnQybnhDTnBNQlF2K0Vw?=
 =?utf-8?B?YWRUMW1Vd3Z6eGlVRlVHcklLUnB0S2RpbndIb1ZWTTI0eVRxMlBVdFBrVWJK?=
 =?utf-8?B?UDVvRldyRGpOblNwVjY3VW5PeHp5RXZma2xleXJ3czBWYWtJNDFVNHNBYnpQ?=
 =?utf-8?B?am5yUWo2WmtJZUZZQklVUVpHakpQTU9SUWhZMWFBYk9EU1JWRzU3dVN1dlhi?=
 =?utf-8?B?VnFEVUZSeGNuRE9HeTcydjkvMTVaUlhOcmJraUFXQlNLOFQ4NGl0UWpuc3pi?=
 =?utf-8?B?dUN0ZUtUdVBrOGVqM0czenVibUYyeWJ5ZXRZUUJzM0I4Q0RNRFFhcUVqZmVt?=
 =?utf-8?B?Q01RV1pzTE9hSGRnd0xRVmd0allueGZiSzAyek1EMjBOOUphV1ZYdXJYaEFy?=
 =?utf-8?B?MVNqOW9YWXhZVHBobElLUHh5SnlkSVJ4NDU0eFp5N2ZxNzdpdHAzRXhLcmhJ?=
 =?utf-8?B?SW1pOVp6M0JPcHREczF2UFl2ZXJkNm9hb0hJaXJ3cjJnS0p6d1NsNG5jK2d3?=
 =?utf-8?B?Y1BCSkFjNWZ3K0k2eHExeGRDcW1KNWhwWUJXRi9TS0Z4ZkE2YzZTZ1pxSWRk?=
 =?utf-8?B?M2E3aHNVeCt2R3RFUytOY3RvcmhlNkxXWTNvODhWMjZ6M2pQa2I1Z01USUZo?=
 =?utf-8?B?MlFQREZaZmkxV3B1aUpVamllRytidFlvR2pMMEhmRGcxbnczZnpQUXlxRHhZ?=
 =?utf-8?B?Q3JDZlg2QjdtNkQ3aVZ5UVIzRFdtQUZPNEVncXN5RG1MaE1PTFF6dWpFSHMw?=
 =?utf-8?B?NW44OGZ0dG9DZHZJYmJNV2tXUTl0cWhwNjQ1dDJFQksvaUZKS3JOTG5rK2w1?=
 =?utf-8?B?QzZQK2FZNnBQalNuS3Y5QnhVcGREM2R1bytlSk5PRURhVGtrTVFxcUxIanpq?=
 =?utf-8?B?U1NwdENpaEVTaUM3Vjg5elU0bXplZzhRR3hkOHRPMU9CVy9KK2pHUHYyZWpF?=
 =?utf-8?B?NTFxZTdhNTZWVi9MS2x3NUk5clIrdVU4NHdmNUtVUXpLRTUzL3ZlMHdob1ky?=
 =?utf-8?B?M2dMZnNMdUZIM3AyUmQrOTlXU245SnJtWVVIM3A3bHdETkdWS3RDU3FGTkds?=
 =?utf-8?B?enBqT0xPZ1pYTnBvWW9MZ01aKzhNWmFlbG1OWWVQWXNlNC9FNTdnN3grS1pH?=
 =?utf-8?B?Ym5JcnRWRC9QbzA4U1Z3L0dKa2h4cVdodk10N1BaTkJVTXE4S2dYeEh2M1ZU?=
 =?utf-8?B?eFZ2SU1HSFdyTFYxUndYODRqTXBZZk1BNGdJalUwZlQyazNxVStWYlBicmw4?=
 =?utf-8?B?bVpQM0pvbFBGd3c2MEptWEExczhUQ0RKNEJlMXp5TEJZOU85am45Njl2cjI5?=
 =?utf-8?B?N1E1V1FvdjBYV2pDWllPdHNHVEhJUTdVanRpTUVLUzlZQXdJR1FYMEF3dUU3?=
 =?utf-8?B?aW9SQzE4U0ZtNkkzdzA5UnYzbWRHY2pqYkc0VE13SHA2RDhVenBqYXRUNVFw?=
 =?utf-8?B?ZkdIalhuM0RlVUFEN1lCN3F1VXR6MDlQVkQ4WWRlckx3bGVyWCtDdkh0Qm4r?=
 =?utf-8?B?My9IMXNieWZTY3RHZ3BsSXAwVXY5bUR2aUdjR2g5Z09UTDJLVmZLSGNIU1lC?=
 =?utf-8?B?ZEM1SHIwSVB0UHh5S0lBUTE2Y2l5V09DMTFqUTEzN3pwY3NuNTQ0RXBKUnRT?=
 =?utf-8?B?Umt5ZmttNWtGdE1ONWl3NksvMy9iNHQ0ckpVZDBKNWtFcFF3K2dSU1BIRDRp?=
 =?utf-8?B?dTdVbEJLMnNic0JQekJvUHltbG1WRitXNi84VzJrdDFVak1UR2diS2Y4ZmRL?=
 =?utf-8?B?SW50dFdQOWVYS2FwUUpLY0hsekNVTDU2cm5FL20yU3BtbXlvU01NUkI3VlRO?=
 =?utf-8?B?K3A4eEt5YlJHa0w2T1UrZlhDeGNRUWRCaEJRcHhTOVVHVjF3Rm1SUXZqempD?=
 =?utf-8?B?WkdQTUU0bEk3c1pWTHZteUd4ZXlYN0l6dXVrUU5yc3pWNDZmRTlleGhCeDdo?=
 =?utf-8?B?ZWhBN2d1UVJMb2E3bnQwdDJTRGRSWU5YelV6QW1TMjRXdU5Qa2RDUEVIZVFo?=
 =?utf-8?B?aks3MzN1SVFMbE1PK2NVenJYbUdwcGVjSDRqV1FFL29Ldno3eGREOVFEdXVo?=
 =?utf-8?Q?jVGu5SYBvo9+nBL9fX6ZJNj4yUU/Mswzv1SSHGBDHQe2E?=
X-MS-Exchange-AntiSpam-MessageData-1: Sw01u9/K8U3+Dg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f0bbe0-203e-49be-a66d-08df2b286b8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 01:54:31.4207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjUkwemIRqiUUkZ9M8snXlkybeyywzKgLQC6s/WbcSVQ6ogsX/VuV2NeBZxpN6tBfIT75MeBDGNVGNtvGm3auA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999230
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

Add the first user of NVKV encode/decode which is the request and
response for GSP init. Later patches will support GMCAPI in `Cmdq` and
use these messages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 157 ++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/nvkv.rs        |   2 -
 drivers/gpu/nova-core/gsp/nvkv/decode.rs |   1 -
 drivers/gpu/nova-core/gsp/nvkv/encode.rs |   2 +-
 4 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 567c56fbbfe3..88111aec3ddb 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -4,6 +4,8 @@
 use core::ops::Range;
 
 use kernel::{
+    alloc::ArrayVec,
+    bitfield,
     device,
     pci,
     prelude::*,
@@ -15,7 +17,19 @@
 
 use crate::{
     gpu::Chipset,
-    gsp::GSP_PAGE_SIZE,
+    gsp::{
+        nvkv::{
+            nvkv_decode,
+            nvkv_encode,
+            Accumulated,
+            Encodable,
+            Encoder,
+            Key,
+            Required,
+            TruncatingArray, //
+        },
+        GSP_PAGE_SIZE, //
+    },
     num::IntoSafeCast, //
 };
 
@@ -245,3 +259,144 @@ unsafe impl AsBytes for UnloadingGuestDriver {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for UnloadingGuestDriver {}
+
+/// The host CPU architecture.
+#[derive(Clone, Copy)]
+enum HostArch {
+    None = 0,
+    X86_64 = 1,
+    Ppc64le = 2,
+    Arm = 3,
+    Aarch64 = 4,
+    Riscv64 = 5,
+}
+
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros once
+// they land.
+impl TryFrom<u32> for HostArch {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self> {
+        match value {
+            0 => Ok(Self::None),
+            1 => Ok(Self::X86_64),
+            2 => Ok(Self::Ppc64le),
+            3 => Ok(Self::Arm),
+            4 => Ok(Self::Aarch64),
+            5 => Ok(Self::Riscv64),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<HostArch> for u32 {
+    fn from(value: HostArch) -> Self {
+        value as u32
+    }
+}
+
+nvkv_encode! {
+    /// A GSP registry entry.
+    struct RegKey {
+        key_name: Key<&'static [u8], 0x3070>,
+        key_value: Key<u32, 0x3071>,
+    }
+}
+
+impl Encodable for KVVec<RegKey> {
+    fn encode(&self, encoder: &mut Encoder) -> Result {
+        for regkey in self {
+            regkey.encode(encoder)?;
+        }
+        Ok(())
+    }
+}
+
+nvkv_encode! {
+    /// SR-IOV virtual function information.
+    struct VfInfo {
+        total_vfs: Key<u32, 0x0080>,
+        first_vf_offset: Key<u32, 0x0081>,
+        flags: Key<u64, 0x1003>,
+        first_bar0_address: Key<u64, 0x1050>,
+        first_bar1_address: Key<u64, 0x1051>,
+        first_bar2_address: Key<u64, 0x1052>,
+    }
+}
+
+nvkv_encode! {
+    /// Payload of the `GSP_INIT` command.
+    // TODO: expect() doesn't work here before rustc 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[allow(dead_code)]
+    struct GspInitRequest {
+        pci_device_id: Key<u32, 0x0001>,
+        pci_sub_device_id: Key<u32, 0x0002>,
+        pci_revision_id: Key<u32, 0x0003>,
+        pci_config_mirror_base: Key<u32, 0x0010>,
+        pci_config_mirror_size: Key<u32, 0x0011>,
+        host_arch: Key<HostArch, 0x0070, u32>,
+        bus_device_func: Key<u64, 0x1020>,
+        regkeys: KVVec<RegKey>,
+        vf_info: Option<VfInfo>,
+    }
+}
+
+// Decode:
+
+// Should decode with UnknownKeyPolicy::Ignore.
+nvkv_decode! {
+    /// Schema for the `GSP_INIT` response.
+    // TODO: expect() doesn't work here before rustc 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[allow(dead_code)]
+    struct GspInitResponseSchema => GspInitResponse {
+        gpu_name: TruncatingArray<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, 0x2000>,
+        fb_regions: Accumulated<FbRegionSchema>,
+        bar1_pde_base: Required<Key<u64, 0x1020>>,
+        vmmu_segment_size: Key<u64, 0x1050>,
+    }
+}
+
+/// Payload of the `GSP_INIT` response.
+// TODO: expect() doesn't work here before rustc 1.97.0
+// https://github.com/rust-lang/rust/pull/154377
+#[allow(dead_code)]
+struct GspInitResponse {
+    gpu_name: ArrayVec<u8, { Self::MAX_GPU_NAME_LEN }>,
+    fb_regions: KVVec<FbRegion>,
+    bar1_pde_base: u64,
+    vmmu_segment_size: u64,
+}
+
+impl GspInitResponse {
+    const MAX_GPU_NAME_LEN: usize = 64;
+}
+
+nvkv_decode! {
+    /// Schema for one FB region of the `GSP_INIT` response.
+    struct FbRegionSchema => FbRegion {
+        base: Required<Key<u64, 0x1011>>,
+        limit: Required<Key<u64, 0x1012>>,
+        flags: Required<Key<FbRegionFlags, 0x0012, u32>>,
+        tag: Required<Key<u32, 0x0013>>,
+    }
+}
+
+bitfield! {
+    /// FB region attribute flags.
+    #[derive(Default)]
+    struct FbRegionFlags(u32) {
+        0:0 support_compressed => bool;
+        1:1 support_iso => bool;
+        2:2 protected => bool;
+    }
+}
+
+/// One FB memory region.
+struct FbRegion {
+    base: u64,
+    limit: u64,
+    flags: FbRegionFlags,
+    tag: u32,
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 9a4f3e40f811..8b10de9b48c8 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,8 +9,6 @@
 //! speaking, the function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0,
 //! b"some gpu") naturally maps to storing a &str with the GPU name.
 
-#![cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_imports))]
-
 use core::{
     marker::PhantomData,
     ops::{
diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
index 43693cb4d31c..7637be89ea31 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
@@ -60,7 +60,6 @@
 ///     }
 /// }
 /// ```
-#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
 macro_rules! nvkv_decode {
     // A schema which doesn't borrow from the stream. The macro uses a generic lifetime for the
     // [`Visit`] implementation but not for the struct itself. This allows omitting the unused
diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
index 64b4ea46d59c..b40aff41196e 100644
--- a/drivers/gpu/nova-core/gsp/nvkv/encode.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
@@ -38,7 +38,6 @@ pub(crate) trait Encodable {
 ///     }
 /// }
 /// ```
-#[cfg_attr(not(CONFIG_KUNIT = "y"), expect(unused_macros))]
 macro_rules! nvkv_encode {
     (
         $(#[$attr:meta])*
@@ -65,6 +64,7 @@ fn encode(&self, encoder: &mut $crate::gsp::nvkv::Encoder) -> ::kernel::error::R
         }
     };
 }
+pub(crate) use nvkv_encode;
 
 impl<const KEY_ID: KeyId> Encodable for IndexedKey<u32, KEY_ID> {
     fn encode(&self, encoder: &mut Encoder) -> Result {

-- 
2.56.0

