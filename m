Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5304FCD0CD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE5B10E0BF;
	Wed, 18 Mar 2026 08:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MCD7E5KG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A961C10E71E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8oww7HgDezmqKZJLuPtuRysa//AFv2YweE5DOjx3IVr3acIIFy6Im1Mw28ZyCMRiOUJkMYBF8m0zsZqhVfyNOiMOr3poNHaDURL246zHMukeCAedJwTflkgM2JYkap7btpE+G3zsvi9YyL/Jkt377Yc7mDqpIY+ceJJOmCNzbDU9hSBsVTJgfk/zlwDH1Cr23lO1/acFRuZyAbZNSccEdS/TrLicx5YzuZVgzbZveIQrJAAOJ+qFUgOOGOdDu/amkgEOrWJ+nhsGUfJAKbBgtdAU3aQD4D7y6Y9uj6z2ZdYkGC7ZN2yoJSwlqV7+oVOg6l48OWk62mCbC6k9ml3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ICET08+z/xfhYq93A5/jUwsef65cXwQgzxW6cdtf4k=;
 b=oyVNrCxdFilgaei5FifUnFSoyJFSn3PmBErCSAS3hSeUAseeiGVDKvCSDz2GlnCAtApLswVsbX4cAYfp/oda6GPK3juSUUi7DKFPpiJ6ZIL9OVXetDk7w/MqcBqiHtXhit/Uama0O+toBFcb+L0prLM5b51+ec1BKn5Z9JBb/Irq6gN8iTS6WlbrlVHGxpiSsXTnoHs8JGWxhY/tCiBjENv57/YE7jVI+0PGTg6GBU++W0VXeiqaB5901x4YqoQlV8IpdsjR7QvRGo4W6SLQ6pKhze/jBMOvoHail9yIelajb94hJwazA+DnLhaekvE9jOnDFj4XTk3TZCbzEx1cAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ICET08+z/xfhYq93A5/jUwsef65cXwQgzxW6cdtf4k=;
 b=MCD7E5KGI4IO1oo5x7HUfTpPHK7ErGvBhOwLUg7MTmvzJHev94sSUWEjoKXdzfpHfkeRu/Blx4ybUqurby2DEtN0HeFk8TkdqPxrE5mhKD25X7U6/zQO8pDKguzUzFK7CgOjn0o4rKtb/Vw/7xbznNI1cG6ZceecVFTc5oPsm/e3Ng9BL0E8c0h/xCge9PrL/yihuLeN/s+CekNvobXcZlpH0SsKR7ePhsfG5jY7lSw7MGlrrpoo2BCrfXeoi+vTveDhzf1LSI3r2UkELkDT+rZBGHG1XnfTQx25JSa/HwySQf8sfIJEbNiGV9vmZ4V9EBTnB6/HsnDSK1aic671SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 18 Mar 2026 17:05:59 +0900
Subject: [PATCH 1/8] gpu: nova-core: convert PMC registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-b4-nova-register-v1-1-22a358aa4c63@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fe00bd-c790-4cd6-94cf-08de84c53865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /WC8cMOwsdP7zyQbdqgOevOYhn3bSalqvaUB8ozU0bUzJwqOuUoUbi9GIGvry5/NQhMNW5hKUiPj9vJ3PVGrByDLFgG529eOkMtbLHjPg0e/YjA3zOF0rj2oP4E9JHGjq257QbEhEJMi7S/HmUS8VY3BqHxtTvi87ijEW6u2sUXvPlOlB0xQIw1RKpi2k4k8UzA3PIO57E4jqion1MvVB/U5CyIEp9KFeki8068dxzP6ekPo38ZXya2TviFmsw3dgPRBkzzL5ty1fCAb+qN5Ca0A/cZ2AQ/XeRFH9nf4aYDD+HwsBoGf/H5EVIP3K1hbvx/+dcz0HMJhK9bsxSgNX1QDtSYcp2o6fqaqXizpJPZwstqS0TiPODpO5y5CMdnj6pSz4hQcHcz7PiHcCMNo0s83wW1KssTIl+uijo437AuBntPrdAUvhDRKyIucfrQoNkGa7NjpTVmHMhtrHKe/HhYSHfu1I5ZhsNCKRIG4sMtoeRHkaPnEH47mK2sv3WnismnocX/c16zi2NNKVEYntRxGhePeotcgmuZOCnTr5WU2qh59wAvbZfxIvTWoEuMH7XfKbsbxWXRFEkP6xDCaz6x7SAftb9To9pWpFDyAj1mYsN6oeZyF9kklz08iHeddTTA2ShZukTb7A2sZRNpzqNUmmPrzRMkWVAsEvyHaS2h9a5kcqs6Mj0/8M0UmeKJViivOAmg0B6deYJQbazMByKlk/4B5XrTwipJ210taX9Nt+VdL4ILfjExG2/dCGS+MGpQ+Pra8uGCLv4fVWu694w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9tSnBHV2xEb2V3YWxEWFVadDY2Zk1nRE1Id2NVQkNEaTBmYzJqbmJubnRC?=
 =?utf-8?B?Q29nTFZnVFd5UDFGN0p6ak5NNU9SanBvdGdhT3F0SklteTlVMjBvWXA2akE5?=
 =?utf-8?B?T2NxV2h2eDFwaldZTGNRUmI2ZHVKUkMwbWJ1cEhHSlV6RlVFODhkTU4yQ2JI?=
 =?utf-8?B?WTB5UC8vOFU3Z0NxZWV4aE5UNEVTeDNvU2Myd2Q1ajErY2ZXejIxcjhhSkMr?=
 =?utf-8?B?MkF0eFFWMUNUaGZtTlhOMGpNdnFGb1BiZ0Y4UkQ4UWJwMGwzKzJDRnFabmRS?=
 =?utf-8?B?OVRsRHVhUXRxSHJzeklTMlFRMFYvMDh6RWJNbEpZV1JrM0dOZFhyNm1Oa2xW?=
 =?utf-8?B?NHlmNnBZd29OUHp6d09RdUdzR0xFMTZDM3lMQkRxK3VCZHJsVkVBbE14NVNx?=
 =?utf-8?B?NnRpR0p2Uk9jNG82YzloQjJWdVE3Wi9iSFNsVmVpTXJsRTdoVDFNNjVmbFF6?=
 =?utf-8?B?WjBxMlVPQStCc3cySjFySWpNUUgrQ25QcjJlRlovYk5BMmZMU0Zhc1Q4NGxs?=
 =?utf-8?B?MEpneGw4eCtDa1lpZTUzLzNRbVUzV2VFSWZmZkpnTVhVWlFINGZiRnVnK0l4?=
 =?utf-8?B?c0h6L2dMY3FWWFo1R0xJQ05DUzIxVzdyazlIK3p3R2g0UW1yUHIxR2swRDBT?=
 =?utf-8?B?WDhWdFRBWFVNbDVvS2J1Qy8yUjFlTGNPbnBpRFJkSS8yWVJoei9pTVdLd3Y5?=
 =?utf-8?B?cmQxZzRsS1RBUk9zR1dHOUExaDhBSFRYU1FiQUM3amZBNFpyNXg1S0xiZG1O?=
 =?utf-8?B?RUlYMXdxeEM4TTRZdTJVVVpOZ0tWZ3RMYzZVTnlLVndZUTJISVd3Uk5JaUdu?=
 =?utf-8?B?akQ0Y3EybFExTnJZbDhLNFBHN3BRdkJjMEN0WDA0dkpUNUV5ajMzRERTZ0tl?=
 =?utf-8?B?TzUrOUkzK3BwUnk4SFQxVXJqbVQ4YTd4anZzQjU3MmQ5aDcrbUNhekhuWFJK?=
 =?utf-8?B?N3RVNDRGb0FGanRNWUZGNEdScnBscXo1Vk9qL0NTR3pjWjlnK21kajU3akZw?=
 =?utf-8?B?VmpmSjNzVVpEOUZ5QXlqRlVwN0pOeE1CdDZieHAxRmc4akVTcmRpWXZrTWlm?=
 =?utf-8?B?REFuZUlXU1JQcy82dXVobWJpNkZ2My9XbUU1RnBrWXQ4MENWeFJ3M1Z3RG5S?=
 =?utf-8?B?RGdONEF6T2tMckpWNDcyeitQbmVJc2R0NmE5ZGIzK0MwbHFCaWdhb2FpVG5z?=
 =?utf-8?B?SFJBdzVnOGZOUlRwanhxUXl2VXpLclBlRTNWZWkxZytmc1oraGE5OWlqM3Vi?=
 =?utf-8?B?NUVEbGU3cVVkSzR2OFo4ckwybjQ3NVZLdEFiV3h0b2JoQUFpeHRrREYwSHg5?=
 =?utf-8?B?MStiU2FFaTFMWFkybk9FQmFQdFdBZ0tNdWpkUnpGWjB3L3gwQUpzRkRZckpR?=
 =?utf-8?B?NlJ5alNZZTgyNjF6UE5LRHZwTStSeGU5R2FYQmlETW1wNUc2Q25WeU9sdWJY?=
 =?utf-8?B?bnNiUC9PQUdsek5uNVRnR0hIdmJRRklJc0p5aXhPb2swNWdwREJMUGJya0sw?=
 =?utf-8?B?SmxveTdrYTZkeTUydE1aQ05IOTRSa2xtd1l2UjZQWHBMQys0ci82QmhMZFFF?=
 =?utf-8?B?RGQ4VzFyaXZzeW5RTmRYZGdVcUZLQVZvVjdkdHR3WWFvaUhTdTVpREt4SW5r?=
 =?utf-8?B?anhjeGZ0ZTFzalBJMjlrbkZEMXhIbFFSVkJpUUVDOHp2aWh3VUg1aU1sOERM?=
 =?utf-8?B?MUhyTW12V0NPZUR2bUlCVjVxSXFxZHJTVUJoNDVNVUNMcXVMQ004RXE2TUdB?=
 =?utf-8?B?Y2FsZWhkTGttckp3MUZOUEpoamtLTHdOU1ZtNVVQRVRIWE9ISXQxRDJGd3pt?=
 =?utf-8?B?Ym51NkEzT3JLZnR5Y3VIK2pVMkRDVnNnS0dROHE3ZlBaSUl0REhvdmtFd0pw?=
 =?utf-8?B?Zys4SGNGRVpWNytrS3FaWGtkMW56dmp4UUdrY1RValZsZDdTK2YvajJNUW1k?=
 =?utf-8?B?S3NiN0FTY05zUTRGVU9jQ1I4d1JIUzBHMUtKUmZ4cXlXS0ZZZENtME1sSWFs?=
 =?utf-8?B?ZUUyTWNRU2ZTdE0xTm94MnNJS3lNUmd0Q0oxTEJHL3ZQdkNPWS9BNWJMYWNh?=
 =?utf-8?B?WExNSXc4NGtNNWNlMWtqS0xZM2VlT3FkcE9Zb2dBWFk1T3R1VHFVZ3dZdTR2?=
 =?utf-8?B?UVRVL2lvbytTd0x0eGVVMVg4aVJtMGJkQ09UOE4wbGlOdjh6RXhwYUdVZzh3?=
 =?utf-8?B?c0JnNnh1b1VVWmNLRkNITFRIK1dLa3dFSUNxS09lV0lnU2JVS3JCVmREeXp6?=
 =?utf-8?B?TGtReVIwWklQbXIzek95My9XV0N6K1RMbmdPS3JESWNtOGI1RFZSZmd1ZzEv?=
 =?utf-8?B?T2ZGU3Q5U1NabitFQk1SSXlNY3BBcmxCUTlwRXhlaEpTUEtyT1FzbC91dU5k?=
 =?utf-8?Q?dIuH7vy2vb9LgCkVhh1RK4loquK7T2IoRTf9q8cxrF1oT?=
X-MS-Exchange-AntiSpam-MessageData-1: IVLNw5HDscES/A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fe00bd-c790-4cd6-94cf-08de84c53865
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:12.7639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0rInH981O2UH1zgNLdFDbOWzE4RKe3aAFEnh7fRniv6uSeg3/5vDYJ4NzdlCiIXoqqxK+uKQlZcYCVvAND4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Convert all PMC registers to use the kernel's register macro and update
the code accordingly.

nova-core's registers have some constant properties (like a 32-bit size
and a crate visibility), so introduce the `nv_reg` macro to shorten
their declaration.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs |  7 ++--
 drivers/gpu/nova-core/gpu.rs    | 37 ++++++++++-----------
 drivers/gpu/nova-core/regs.rs   | 73 +++++++++++++++++++++++++++++++----------
 3 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 7097a206ec3c..4721865f59d9 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -13,7 +13,10 @@
         DmaAddress,
         DmaMask, //
     },
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout, //
+        Io,
+    },
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -532,7 +535,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.hal.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
             .write(bar, &E::ID);
 
         Ok(())
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8579d632e717..d81abc7de3d7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,6 +4,8 @@
     device,
     devres::Devres,
     fmt,
+    io::Io,
+    num::Bounded,
     pci,
     prelude::*,
     sync::Arc, //
@@ -129,24 +131,18 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 /// Enum representation of the GPU generation.
-///
-/// TODO: remove the `Default` trait implementation, and the `#[default]`
-/// attribute, once the register!() macro (which creates Architecture items) no
-/// longer requires it for read-only fields.
-#[derive(fmt::Debug, Default, Copy, Clone)]
-#[repr(u8)]
+#[derive(fmt::Debug, Copy, Clone)]
 pub(crate) enum Architecture {
-    #[default]
     Turing = 0x16,
     Ampere = 0x17,
     Ada = 0x19,
 }
 
-impl TryFrom<u8> for Architecture {
+impl TryFrom<Bounded<u32, 6>> for Architecture {
     type Error = Error;
 
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
+    fn try_from(value: Bounded<u32, 6>) -> Result<Self> {
+        match u8::from(value) {
             0x16 => Ok(Self::Turing),
             0x17 => Ok(Self::Ampere),
             0x19 => Ok(Self::Ada),
@@ -155,23 +151,26 @@ fn try_from(value: u8) -> Result<Self> {
     }
 }
 
-impl From<Architecture> for u8 {
+impl From<Architecture> for Bounded<u32, 6> {
     fn from(value: Architecture) -> Self {
-        // CAST: `Architecture` is `repr(u8)`, so this cast is always lossless.
-        value as u8
+        match value {
+            Architecture::Turing => Bounded::<u32, 6>::new::<0x16>(),
+            Architecture::Ampere => Bounded::<u32, 6>::new::<0x17>(),
+            Architecture::Ada => Bounded::<u32, 6>::new::<0x19>(),
+        }
     }
 }
 
 pub(crate) struct Revision {
-    major: u8,
-    minor: u8,
+    major: Bounded<u8, 4>,
+    minor: Bounded<u8, 4>,
 }
 
 impl From<regs::NV_PMC_BOOT_42> for Revision {
     fn from(boot0: regs::NV_PMC_BOOT_42) -> Self {
         Self {
-            major: boot0.major_revision(),
-            minor: boot0.minor_revision(),
+            major: boot0.major_revision().cast(),
+            minor: boot0.minor_revision().cast(),
         }
     }
 }
@@ -208,13 +207,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Result<Spec> {
         //     from an earlier (pre-Fermi) era, and then using boot42 to precisely identify the GPU.
         //     Somewhere in the Rubin timeframe, boot0 will no longer have space to add new GPU IDs.
 
-        let boot0 = regs::NV_PMC_BOOT_0::read(bar);
+        let boot0 = bar.read(regs::NV_PMC_BOOT_0);
 
         if boot0.is_older_than_fermi() {
             return Err(ENODEV);
         }
 
-        let boot42 = regs::NV_PMC_BOOT_42::read(bar);
+        let boot42 = bar.read(regs::NV_PMC_BOOT_42);
         Spec::try_from(boot42).inspect_err(|_| {
             dev_err!(dev, "Unsupported chipset: {}\n", boot42);
         })
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 53f412f0ca32..62c2065e63ef 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -35,20 +35,64 @@
     num::FromSafeCast,
 };
 
+// All nova-core registers are 32-bit and `pub(crate)`. Wrap the `register!` macro to avoid
+// repeating this information for every register.
+macro_rules! nv_reg {
+    (
+        $(
+            $(#[$attr:meta])* $name:ident $([ $size:expr $(, stride = $stride:expr)? ])?
+                $(@ $offset:literal)?
+                $(@ $base:ident + $base_offset:literal)?
+                $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
+            $(, $comment:literal)? { $($fields:tt)* }
+        )*
+    )=> {
+        $(
+        ::kernel::io::register!(
+            @reg $(#[$attr])* pub(crate) $name(u32) $([$size $(, stride = $stride)?])?
+                $(@ $offset)?
+                $(@ $base + $base_offset)?
+                $(=> $alias $(+ $alias_offset)? $([$alias_idx])? )?
+            $(, $comment)? { $($fields)* }
+        );
+        )*
+    };
+}
+
 // PMC
 
-register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
-});
+nv_reg! {
+    /// Basic revision information about the GPU.
+    NV_PMC_BOOT_0 @ 0x00000000 {
+        /// Minor revision of the chip.
+        3:0     minor_revision;
+        /// Major revision of the chip.
+        7:4     major_revision;
+        /// MSB of the architecture.
+        8:8     architecture_1;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// Lower bits of the architecture.
+        28:24   architecture_0;
+    }
+
+    /// Extended architecture information.
+    NV_PMC_BOOT_42 @ 0x00000a00 {
+        /// Minor revision of the chip.
+        15:12   minor_revision;
+        /// Major revision of the chip.
+        19:16   major_revision;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// Architecture value.
+        29:24   architecture ?=> Architecture;
+    }
+}
 
 impl NV_PMC_BOOT_0 {
     pub(crate) fn is_older_than_fermi(self) -> bool {
         // From https://github.com/NVIDIA/open-gpu-doc/tree/master/manuals :
-        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u8 = 0xc;
+        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u32 = 0xc;
 
         // Older chips left arch1 zeroed out. That, combined with an arch0 value that is less than
         // GF100, means "older than Fermi".
@@ -56,13 +100,6 @@ pub(crate) fn is_older_than_fermi(self) -> bool {
     }
 }
 
-register!(NV_PMC_BOOT_42 @ 0x00000a00, "Extended architecture information" {
-    15:12   minor_revision as u8, "Minor revision of the chip";
-    19:16   major_revision as u8, "Major revision of the chip";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    29:24   architecture as u8 ?=> Architecture, "Architecture value";
-});
-
 impl NV_PMC_BOOT_42 {
     /// Combines `architecture` and `implementation` to obtain a code unique to the chipset.
     pub(crate) fn chipset(self) -> Result<Chipset> {
@@ -76,8 +113,8 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
     /// Returns the raw architecture value from the register.
     fn architecture_raw(self) -> u8 {
-        ((self.0 >> Self::ARCHITECTURE_RANGE.start()) & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1))
-            as u8
+        ((self.inner >> Self::ARCHITECTURE_RANGE.start())
+            & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1)) as u8
     }
 }
 
@@ -86,7 +123,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
         write!(
             f,
             "boot42 = 0x{:08x} (architecture 0x{:x}, implementation 0x{:x})",
-            self.0,
+            self.inner,
             self.architecture_raw(),
             self.implementation()
         )

-- 
2.53.0

