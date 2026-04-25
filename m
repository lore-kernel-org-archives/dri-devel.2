Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A65FF885A
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC5010E487;
	Sat, 25 Apr 2026 21:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nLt1zbCL";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011005.outbound.protection.outlook.com [52.101.57.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E72110E486
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ51Zw/wjXRCpd/fhbZPWK3SXFCCoRkPJvccShaI580NUiP2l2CkLqLJUZBSOAQKly+bqz3AE0igPPFgPbTrn/3KNIARGyyj4hXyPo9ex7MaY/hpOYuWJWZrpA5pC8KMFIJ8wb6aptygYgrXm5GfOajoMiBYGzwiLdbXae4vPZ62JDr4afpCPyexM+Dn8Lv/w/kcyOOgNgE1BCm3avTDXuzIt33Q2MRcNkUcHOCGiQa6csLMN5/jfce0LKmT6oBqGBpElq2+RP61PwoBeiJ70UaqamBrR/BhNwQPEWmDa38OntijjbHZYWCtscU+JpNPDZuaWTt+qbC3l6hSxR3WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVcm5snnlmNTLHRB6OoJWEohIKFlzpBU/9ir0qYBsPs=;
 b=Ez62sD+z/JXdJDRi/mrarrV7ecEWBvJXGcHLE2OtaAtonjPVYJSSx1LBKH6ne2An4vDep3XVJU3vTT+9XsTkE1EeCQYxB0PL9KFqESKc9sMl0Nq+5ACYps3j2NVH9Jaz7U0xz4MOowrEueC8qljGlDsZ74JuJVmskBndeBBvEzPy8ve8ofB6jyn/VUJM9WUJGHoTVKvC06YBcfIqZVbRXflMKJnoW1q1tM6gKxnnsGk6QR7+0EFC08z0k3dYgaMuIfTlP042+IogOEu+oc6CcNDKrUqfpqB1klq0wT1j2KL3KwVNbXC5H6YytQppdUk6waM3ouSoThmEaowdaIsUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVcm5snnlmNTLHRB6OoJWEohIKFlzpBU/9ir0qYBsPs=;
 b=nLt1zbCLTHoUP46GtbqVh6+M21XrQElp9QT0WBLhScjzvPu8gcjrqx9dcNz8NFXIEUDPjws6LNK07dLk2N4UB2lye59sJlskzj8SnjrYEZfQMorlR6UVe2sfQDBdOMaRO8BvZHwRV0E8vanDRUAYQYdVU1i/vlZ0YmuJ93T/xg92JqbMWPmaS9p3cf23pu30xynTjYojqLXd+VXJSQnkMl7DfsKZ24vKYocYnkk+LlxLkxg96Y3BjOHOKEF/36Mo196kynekZ5rRB3TRHtnXOslPiJsOo8JvgQoNvvJGH6A3lBjZUXpbG7bdRE4FKVpkuNCQT7Hppui7G4rQP2+WMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:13 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:13 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 02/22] gpu: nova-core: gsp: Extract usable FB region from
 GSP
Date: Sat, 25 Apr 2026 17:14:34 -0400
Message-Id: <20260425211454.174696-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:930:a1::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d28ff87-97ae-4527-2254-08dea30fbd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 04ATaUTWyTCY4kCDoQhQFqdRunZ8tLpvUJvJ8nvsFYnfq2ecAIFK71knVW40kXEzBZmexAreL8A7t9fNIONYYYlTQbLanwgjEM6aeWT/UJCQJo89s47moCS3lBwcIxcld+sJ4gtxip3QSuQ+OZRfSWuIDvqvWhxYj7aXPsp9R8jjyLUsU1wrMd4fvbV9mhoHpgP0DJtn+siSCdU4EFZirq1wxKMKL8Dmg58J8hwsAXCb0P/pwT40mxXTSb8uYqc430OTnIRJXkuyDjSxxFOcG7zWSig7Qu/ZYD03D0I7Hidyv9NCy9EJGLhH8PQcjIikKPJBl3aian1NiUtq4nR7bnC/Ob2HunFrka5gT+Kvnhk8bxOWfJlEKpHM08+5JNiWQIRM5uknrCXjgORdCBHDtUun6KabVlS8sA8g2jtX3puFUfhoLGas4BOyYHTpOs6/1sQEpB6SW3vJySqnPm0LIHA0JcEgawaORWkOzjY4YSX5haj4I22ff5uexqTt70gni9uWXH2uElxcPyt0CFPQ4MTp6OI0IiZ+BjTASkK+Nuu2JbdzUWjMS0dYKx/rJs7bs34FvfdXR8zQhuZQm3qC1KmQVa44gYVMGU1r8pmYrF2V5yCao8SV4iMPHQzzXgcldfayeZN7qZaax97q6a2hJnNKpcf1C5DhLCaCpLh8U9Mxq3QnafoM25yWsplaqBXBmhihHUqq2LS/jX5hxutmYvYmWkFgv3drVWyJ8p5weiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZY5i0SOARtxiFdgNfUx14W4Mz/Z8fI02N9/9kY13DOVMzN0ZdscyOqdr1gv3?=
 =?us-ascii?Q?dn/T1ExwR6p+bODdgvdCR21p5cIDPDsB325W1vTizPVZlJlj5qNUp3vZd2eV?=
 =?us-ascii?Q?4zp/H138Z+oVTfDd4lTg9NEXO6cz8giE96ZKSsMHXoDgMOFF3mHL/Z9WSU1k?=
 =?us-ascii?Q?YP8yHmYkKzmzp+/+yh+s6g0dPgFwpSHZ7o/h1LBYSbMprmOmSqx6qaUNGDof?=
 =?us-ascii?Q?YyqyV8llYW0T1g7AdrBR6/fuKOT2+ik0aIQapW5c6cgEFTtCYPE9++KXahQN?=
 =?us-ascii?Q?tOsUkcnL+/2iKWB/+HSBPB5z3jvRrLte8c0nEddphr2dLIAYCHyCS+ZZRF6q?=
 =?us-ascii?Q?yrr367v9BwuLB0q7Rywq8hbiPzdDRvZyd8yKPK770AqaH8CV6Jdt4H30g9D/?=
 =?us-ascii?Q?MWr/aqsK2LRlhDQjo+CmtnhKxpv6gVQb6D1J08HxmhlmraFi/VDaQAxgjut/?=
 =?us-ascii?Q?xXM47gZylDNOUyj4SKn1qEC/aenFQ82NiazpSnVgUSq6++sz8FWhfhXN8wka?=
 =?us-ascii?Q?TsqFgQP3MVsRLeRANdigoZeUYtSaacqUspcM/S5+U87xP9+Ks7U4sgXe9913?=
 =?us-ascii?Q?Ff2beEFpxp3IYXXgEIr4q301DRJ2OrrYUHLg1FgoUCX3lWX++TilOhBrLy9O?=
 =?us-ascii?Q?robmOfpJ38f3A2ABfyDcZSohfcniKEwo7JiaL9ycWwMsGVSG7L3q2750rA2w?=
 =?us-ascii?Q?cKtfhhpGMpv2K1yd7x/MYvKnlufeNmnrMxiqC2hpryOsXyS71YIjre3hNWrl?=
 =?us-ascii?Q?TG7oXOXZUHpriryKKUKeMPDCO1Hd+m35jyoTdEBXo3tdVft0+LPQXzT9Hf9N?=
 =?us-ascii?Q?wQWdQIRZl5BMzfpqXeU+R9Rpbc7v3ZV067Qiy0/UD0jjAd49QcCym7TseTzZ?=
 =?us-ascii?Q?5nXOzvhyY1Wax4AvyRM4Y7IcLiyxwPKRne8etDdzHygHv62AZ31d0YBVBatG?=
 =?us-ascii?Q?QLXOdThLn8jBQ/k3oQk2RsZ3GlHXULHKJwS14yQDqFVe2Kfd5XLRt5J9rlPY?=
 =?us-ascii?Q?yu9ybk7yD0F1krexe5wj/iLEFgpYtnbhTItUBDJfAeLHsO33bFMWMJsmdRr5?=
 =?us-ascii?Q?K3fOxst6ALKYzN1Ea6SGlshTYa2v4S0KXb4YJtIJuKNybHXeF/ccn+kEI1qr?=
 =?us-ascii?Q?gqiNNoNNufKqm3mRfzXauJYDsBvXxMauoDzqwTQNUbmuVm2TmB4hrFueZhP1?=
 =?us-ascii?Q?1YXEoOyBGgyWuMb0+V+U7pVmLO1Ze0ifpGRYwmT65myu43NJLfk2g9irXkiF?=
 =?us-ascii?Q?45RgQNMvtNa/xPaG/3xGD0z2K0t2mxexrdSmBHdZrauqkNQZAaJkhCV3hQEY?=
 =?us-ascii?Q?flwQ5YjGZZs+bxkVziH8h1g3eoDyxgadAHZ6tSHtD0H4Zq8PDD3a4snVa4IO?=
 =?us-ascii?Q?xM8/XzdnbCYQR3VFA93ndT8Hh8H3eZ6DFCJV+KFtmj4TzwkIq8DnU10dqCiO?=
 =?us-ascii?Q?U6mB/JQ36PZ9W+XBDGIbJJOU7uH9Ii5k2HyCjPw5b+0A6H7HUzvKbpVusrEV?=
 =?us-ascii?Q?70mUAGoaD3vsNvNrFa2HaEXrL7PeR+ru6ZRfG4dWwSoYQ8Hfj2K3drp1anAr?=
 =?us-ascii?Q?7HXtCW1kqJuu29A74MmChfw9rDcBe4hQnyeU3R2U9WmK2NNeo5rtAOhapFOd?=
 =?us-ascii?Q?/FPcm49ha0Lmr3SKPr6QxZvxFYByG1o8376Va1DM6Cx3Z8PumHHVMuTZ534r?=
 =?us-ascii?Q?ZcPZZflTAYHg4t2nVmemsE5ToXEUiWOrfa8vqegtLkEoDScjvC4GbyDpSJFd?=
 =?us-ascii?Q?u7nBGt7UAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d28ff87-97ae-4527-2254-08dea30fbd79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:13.3168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGN8Ihvu/qx6CKX19/f7Lk6NL7msN9B1NMFDeQuUcjeMuvAwTiCKQ33wbMgJvmX8yVhaRI6pkLz2ROUrl8AYYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Add first_usable_fb_region() to GspStaticConfigInfo to extract the first
usable FB region from GSP's fbRegionInfoParams. Usable regions are those
that are not reserved or protected.

The extracted region is stored in GetGspStaticInfoReply and exposed as
usable_fb_region field for use by the memory subsystem.

Cc: Nikola Djukic <ndjukic@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gsp/commands.rs    | 11 ++++--
 drivers/gpu/nova-core/gsp/fw/commands.rs | 45 +++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..d18abd8b5f04 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -4,6 +4,7 @@
     array,
     convert::Infallible,
     ffi::FromBytesUntilNulError,
+    ops::Range,
     str::Utf8Error, //
 };
 
@@ -189,15 +190,18 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
     }
 }
 
-/// The reply from the GSP to the [`GetGspInfo`] command.
+/// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// Usable FB (VRAM) region for driver memory allocation.
+    #[expect(dead_code)]
+    pub(crate) usable_fb_region: Range<u64>,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Message = GspStaticConfigInfo;
-    type InitError = Infallible;
+    type InitError = Error;
 
     fn read(
         msg: &Self::Message,
@@ -205,6 +209,7 @@ fn read(
     ) -> Result<Self, Self::InitError> {
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            usable_fb_region: msg.first_usable_fb_region().ok_or(ENODEV)?,
         })
     }
 }
@@ -233,7 +238,7 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
     }
 }
 
-/// Send the [`GetGspInfo`] command and awaits for its reply.
+/// Send the [`GetGspStaticInfo`] command and awaits for its reply.
 pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
     cmdq.send_command(bar, GetGspStaticInfo)
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..a34d29280430 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use core::ops::Range;
+
 use kernel::{
     device,
     pci,
@@ -10,7 +12,10 @@
     }, //
 };
 
-use crate::gsp::GSP_PAGE_SIZE;
+use crate::{
+    gsp::GSP_PAGE_SIZE,
+    num::IntoSafeCast, //
+};
 
 use super::bindings;
 
@@ -121,6 +126,44 @@ impl GspStaticConfigInfo {
     pub(crate) fn gpu_name_str(&self) -> [u8; 64] {
         self.0.gpuNameString
     }
+
+    /// Returns an iterator over valid FB regions from GSP firmware data.
+    fn fb_regions(
+        &self,
+    ) -> impl Iterator<Item = &bindings::NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO> {
+        let fb_info = &self.0.fbRegionInfoParams;
+        fb_info
+            .fbRegion
+            .iter()
+            .take(fb_info.numFBRegions.into_safe_cast())
+            .filter(|reg| reg.limit >= reg.base)
+    }
+
+    /// Extracts the first usable FB region from GSP firmware data.
+    ///
+    /// Returns the first region suitable for driver memory allocation as a [`Range<u64>`].
+    /// Usable regions are those that satisfy all the following properties:
+    /// - Are not reserved for firmware internal use.
+    /// - Are not protected (hardware-enforced access restrictions).
+    /// - Support compression (can use GPU memory compression for bandwidth).
+    /// - Support ISO (isochronous memory for display requiring guaranteed bandwidth).
+    ///
+    /// TODO: Multiple discontinuous usable regions of RAM are possible in
+    /// special cases. We need to support it.
+    pub(crate) fn first_usable_fb_region(&self) -> Option<Range<u64>> {
+        self.fb_regions().find_map(|reg| {
+            // Filter: not reserved, not protected, supports compression and ISO.
+            if reg.reserved == 0
+                && reg.bProtected == 0
+                && reg.supportCompressed != 0
+                && reg.supportISO != 0
+            {
+                reg.limit.checked_add(1).map(|end| reg.base..end)
+            } else {
+                None
+            }
+        })
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
-- 
2.34.1

