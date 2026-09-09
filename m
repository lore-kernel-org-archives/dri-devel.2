Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D3DC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E29510EE7F;
	Wed,  9 Sep 2026 04:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFdi4aPf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4F010EE80
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+MH1O7Yi1sZKujudg80aZlcfumhig6AZuj5tILZy4Nv20ocMJ2+Kyp5nHtDLqwfqNoUMSAvRyKHv4Wng7hnunNwU6taq/+1AGmaOxQQgohoekEniDLw9CB69OfjEhoPQVxxnqgRYZKGfYJAAkcKpf9wXHelNn9QbnuaJ/5MpHOD//kYC/VkqPTn32eLtj2TG1ZFK3EXVvh/oND1qg0yALp2hbl3VoO99iRlfsb8vq1v7hcadX4QIGJaDnICrXE4VkhxltsLL1GGE6go7IaweqjVSJ4d1dqqXR25RwnBJcQsiCmacLBaAf/wZzI5Gw7mitw6njj/X1rQJSn2D1T9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq6PNDh30qXGFAhiOvrT9JLq0bhmSqC5EjeaLC+1qqw=;
 b=q+GHY3Vr/+/urt6sWV/uPFZrIxT9oc9RsuV4jxDbgDFzp3utBmBKElimX8/rmy97YLJ/d6s6Qzs44L1KCqeqD+ukKXSHGnWg/+nPiZscyf+yc7kRx/ANr9/mmNzQEUfMXZjGtAPQZvJ9zsCHZ/OavgDMLCDAUzJOop7qjQavr1X3i5M/AIb0i3RNeB94aLBNSYcKO6PoDCClvxmkQ8WtTx+qpWHS5OE8Tkz6gfHmS8s2ohGNhYJLIvkkv5erStO8cRSq6CduY7WDjp+YCUp+2px9qLujhCpte1ejGscCjP7wmzfelH2btZ8djPZ0BLIjv2lR8gHMqBhuvN2K7JSYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq6PNDh30qXGFAhiOvrT9JLq0bhmSqC5EjeaLC+1qqw=;
 b=RFdi4aPfajydgVY1GfE9X7JxIXRRze4hx/46M+AVfkTOyZgFejlxi0cmF7lq2kFru7cLBe9oxyWQDd0vLHXWVBJtcQd9+9QKgDzyemdUXjV9IOWuCfjvDWFY4BxWNYZKe25csSoBlaQYoyvtEIkNfMDO1rntyu9wBENRayokbb90HKMrxktSNIJNYyEa7MWdM1HR+HCI7SqugPXVYoro6bwOhMOKxwWlHmbZoTr05dZJwLnlFPebcXXTeiL4W53RdehhETUlBGcAqoQh03Jch3fH0N+paTkNmJ7CkpM/djVYC2OynXiZ/TRklfDUcBlAAPJ+8lZt2TW/Xk1fHEDGbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:00:14 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:00:14 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:43 +0900
Subject: [PATCH 05/16] gpu: nova-core: mm: pagetable: Add PdeOps trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-5-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0071.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 38360d87-26f1-4a79-ee5b-08df0e26d9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hrgrg/PSLDQlcSMiFWLxH2aU0lP6Qf9OKmPNf2F1AyDPjElDtFKFp6uRE6YF3IC+d7kY8VC0rdosc1Mn0wUrO2kIsohvZholkB+Qw03NHTNkpMaKXiLJjAFX9msVnJHZo6tpKfm6LAvOLmzRmDDIex7VHdGlXvYLftaXavK/dcheT6mosjjYwBF/NUUykcvGwQi+wDSomiiCXGnxKmj+uf9V6wLAxpKskZzzj5QjsCu/Q4glWJRBevkoLR0aFoiY2oiVE3YPs4pyZyeh/LhpZ90eRDuS7+2RHnwxAag8QV+eegXEgrsSp1cKNP+0zzGapVLN+5jKPQXUZ0DR53WPkTmmhIiAsLcImt/HSQRVFAv/P8xc655LoQfucAUStn08I6g/XsuM7D1t2lwV9x7Q/5f6fHtZR4IZqy+WLX03PdCJLSK/8zafR38b0uDcB7Qi9RmKGGgkYvU8IMfjYsAATJH1W3ybqlaUSCmDNou4GnqrDZtjb3blOiFf+2KehSaNwzBu6lv0/cKGjbdgERuZRNXXUCIZFahk3YT6Qtcu8RtSgYEziAuiMTu48mt8g7jHh0r0UUzAHEGyNCjSj5K/RP6JTBlaiqDRkXKb9AhK3lPsRrsZ1Lg0fSa1QN07Ye2sSgruU/Q8/ORSjyEYj9Is8XwheqI97KA3WUgRmub3/vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGd3V0hwU2VGYzJHdHdyTG5scUR4djltZWZBZ05IdTFzYXR0RndHYi9oKzFY?=
 =?utf-8?B?WStLMUs4YkVFZC9pMlpETGtBVHN6UUs0NTFJVm0vWXM4M2hKYjc4UXVnd3dW?=
 =?utf-8?B?b2N4cnNqamRLT3praFpqZ1J5SGhNWlVsYnU4N0cveW94SGF0SkI0OU5SVmVh?=
 =?utf-8?B?aU1saHJXUnFyMmlmUWp1L2VSOTBwMHJlemxKM2tjZ3pkZ2JwdG1hTDdQMXd2?=
 =?utf-8?B?VVgrandTSm1TMUxIRE80d1NmeEM4Z1RZMy9udjdiaFpkL0NWbHBrZ1UwSS94?=
 =?utf-8?B?ZDIvVFFIaVNLKzVtRm91MTUxUmNIQlM0aFd1VkRVaFdLTUVpUHIxTG1sdzBk?=
 =?utf-8?B?eVFwdXg4WUQ0VGZtbGJJNDJPMDVxZUV2OU1CaEtwREFZOGE1djk1N1plYTlT?=
 =?utf-8?B?TTZXcVI0a0w4amtaRlNqRXJkZ2xGUGpMdENsSnZEcjVYV09LV3VpY3V6aVFG?=
 =?utf-8?B?WXRvSGVCaFl3d2ZwdktHTE9lUkpWYzJvZ2lyWWtqUEJPRHU0c3VBcDNBY0Yz?=
 =?utf-8?B?RHhIcGN2TUVvcXNwWllyVkZaTlhZcERwTytlVnVuRURnTERPSG9LcU0vL3I0?=
 =?utf-8?B?b2pKUENxL0VPb2NwUktzVFljK2pTa0xrUTRpeWtpWmJVTFFHQ0pMUDNNK1FK?=
 =?utf-8?B?Z2kySGhtTlRUcnJBZ0NQUnBuZnpVNHBkTzdJUFNKV1h1MlhhMVp5alZucUdy?=
 =?utf-8?B?Q2J5R1RmTy9kTDQyYjd3T3NLb2svOFhEYSttRDJlVFJCd1BjQ3E4NHIwZFUy?=
 =?utf-8?B?NkM5KzNKVzZHNW5aVm1FNy9UdHZKSnRVMFRseU4vNzdRVmhLdzZ5aHc3MTNQ?=
 =?utf-8?B?SmxNTlh0NmZ0RDNwSXNJYkVwV1pQcS9UY0xQYmNXREJZK0VHT1pheXpZY09R?=
 =?utf-8?B?amJ0aVl5SndhZ054K0IxWjRBS3QzWXpJczU1ZVhyUHdLd3hPNm9Gd1hFMXFN?=
 =?utf-8?B?V1JSdTF6SXBaNDNDY0djZjJ6alNPWEJXa2xFam1EZTVacjNpZUNpbElFcVRz?=
 =?utf-8?B?WTFVK2prK0lRdlNLNFJmN1JFa0VPaEdiYnZEK0ErMEp5bzltZzZIbnI0dDVJ?=
 =?utf-8?B?SkVvZTExOE91TllmNDk3bE5HV0NEMkN2anF5TmxpNGwwSk5kem0rWVVNN2Jp?=
 =?utf-8?B?RkhLbHpJS3N6eS9BVHhLRnpjaTUzUEl6QkJsYmFvUllMTHVPejJpUHdVN0Zt?=
 =?utf-8?B?MDRXT3pWRnA5MHFydnpKN0FaVjV1VjFud2ZEeldXVEowS2JiZW9pV2M3Y1lI?=
 =?utf-8?B?VlBwUWl2RVhsVXZKR0JwcmN3RlZKaHBoenFjSmkwTjU0OVowaEdXOHNNQlVI?=
 =?utf-8?B?TTFJQm52ZEw3MG1JYzNBdnlvN24wK3FDQlJ1SjdFbFpUQzA3aFJ2NU1hU2I2?=
 =?utf-8?B?OTVsSlF5VHI1YlU2VWw3azhsdjQ4ZlMvanE3N0I0a242ZzdpTWMwdk0rYURD?=
 =?utf-8?B?UkVKRUI5YXFtQW5Jd204NWJIZ01ERzYvaHFxakwrREhHY25mL0RaOUpnT2Fs?=
 =?utf-8?B?Z2l5OUllbE1ZSmExZkp1WWVMdUxDKzB0RjBYRzBiLzNDeGFXc2tVUlhYMnd3?=
 =?utf-8?B?VXFyRjBVY2duQ0FEb0RlOWNJd2ZEVW5jUHhlb21ONUdOSWJpT1BIaWFlbjd1?=
 =?utf-8?B?WXAycGFGek9UbEI5Q3dYcFIyWlR0Rk1XNkg5R1VwTE04dXJacld6SEZQNko3?=
 =?utf-8?B?akdGRVk3eWN6QTQwVGtUNFFnZG80T3Z0ck8xQmgzM2FNQkt0bS90ZVZYUTk3?=
 =?utf-8?B?UXBtUmY5NWQ2NGxKZStVOFdrbnFEY1FYTytuS2FWOG5GbytqU2hpR3dZSlJB?=
 =?utf-8?B?NnBnbEQvc2FINml0SWcvRUFLVjBSUTNVeXVJSmh0aWxJL25UampoZFYzc29y?=
 =?utf-8?B?bnVra1hKUi9sRU5XOUNscW1oekVNaGhVcGpFb1RwczY4RDRGUm1GbDBieTVu?=
 =?utf-8?B?amlJSnJxRFNyUG5rSWVhcy9vcU5sdkpBV1lMRTV6Z1lOaWtNek9SeTR4RFk2?=
 =?utf-8?B?SVpPTXpFd21ROGxKalVwM1RoNUZkQ0xPNU8yL3JscHM4dEJONzlTQ2ZUZVJp?=
 =?utf-8?B?c2VrSkIwVmRMZ29FNGFJa0lveS9uTTM1QVhxTllKSU8yQkVYMTdSWE1nMTZ5?=
 =?utf-8?B?ZGVEMXdLQXdqVVA4UEw5ODZOOGs3YUh3dW9wY0lSaExqNlU1MUxaaTUxMzNY?=
 =?utf-8?B?ektiVnVQazRScXBmbzVUU0RqK1JabFNObnVWQXp6ZlJHeTZmb2htK1VLT25Q?=
 =?utf-8?B?LzNNOG40cnRuNVZhazIvNzR2NDFPKzhlK1V5ZnUrRjdrelNkcEtKRnpndW5Y?=
 =?utf-8?B?YWdYS21XK05DYi9PcTc0QUFkM0ZObDhHZG45U2lsK2owVjJnRzYvcTRCMkVt?=
 =?utf-8?Q?h/0Yv5xgDBDpVPC19YkNfzwzaXr7hzyv7lgNwg19aiIyq?=
X-MS-Exchange-AntiSpam-MessageData-1: /Y1xekYY8rtMww==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38360d87-26f1-4a79-ee5b-08df0e26d9f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:00:13.9822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4lW3mBGYqrK+KVwgttuntSOpmyMyIyZr3zNSmO+272RlxkW5GxeJqT69d+Y7wMw/KpVXh2ryP8Qdq10eMYIcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

Introduce a trait for GPU Page Directory Entries
(PDEs). Default `read()`/`write()` helpers via a `Pramin` are
provided.

The forthcoming MMU v2, v3 PDE structs will each implement `PdeOps`,
allowing the later page-table walker and mapper to call PDE operations.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: replace PraminWindow accesses with typed MMIO views]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm/pagetable.rs | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-core/mm/pagetable.rs
index a23370b4b62d..14436fa6adf0 100644
--- a/drivers/gpu/nova-core/mm/pagetable.rs
+++ b/drivers/gpu/nova-core/mm/pagetable.rs
@@ -128,6 +128,47 @@ fn write(&self, pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result {
     }
 }
 
+/// Operations on Page Directory Entries (`PDE`s).
+pub(super) trait PdeOps: Copy + core::fmt::Debug + Into<u64> {
+    /// Create a `PDE` from a raw `u64` value.
+    fn from_raw(val: u64) -> Self;
+
+    /// Create a valid `PDE` pointing to a page table in the given aperture.
+    fn new(aperture: AperturePde, table_pfn: Pfn) -> Self;
+
+    /// Create an invalid `PDE`.
+    fn invalid() -> Self;
+
+    /// Check if this `PDE` is valid.
+    fn is_valid(&self) -> bool;
+
+    /// Get the memory aperture of this `PDE`.
+    fn aperture(&self) -> AperturePde;
+
+    /// Get the VRAM address of the page table.
+    fn table_vram_address(&self) -> VramAddress;
+
+    /// Read a `PDE` from VRAM.
+    fn read(pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result<Self> {
+        let val = pramin.window_at::<u64>(addr)?.view().read_val();
+        Ok(Self::from_raw(val))
+    }
+
+    /// Write this `PDE` to VRAM.
+    fn write(&self, pramin: &mut pramin::Pramin<'_>, addr: VramAddress) -> Result {
+        pramin
+            .window_at::<u64>(addr)?
+            .view()
+            .write_val((*self).into());
+        Ok(())
+    }
+
+    /// Check if this `PDE` is valid and points to video memory.
+    fn is_valid_vram(&self) -> bool {
+        self.is_valid() && self.aperture() == AperturePde::VideoMemory
+    }
+}
+
 /// Memory aperture for Page Table Entries (`PTE`s).
 ///
 /// Determines which memory region the `PTE` points to.

-- 
2.55.0

