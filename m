Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1742AC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6548010F09D;
	Thu, 27 Aug 2026 14:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="drx9p4j7";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F4710F0A2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtOfl4kSkxObgOAbAookegWT3qu7qM/jcpLhUthFezWxhOTey5aY11Y6A5NB+wyWR2sinbd6Pp9kCrQXQSR5luZOrt8PHhdg66HdipUDusQkPQG20MdMCrH1rj88eHuvGV/GasVAZxuasuqfAqGRbyOx4z0GvZ162BtQIi6zZPEqgHMHcyej8cgVpDr5EvSKJ56EJQ5BuK3ZQE5pAgHBe55daIhUCt3tAWHIXrlhTf/eEksf2gK2yh7oTtAFRypoXCyD3JGVF+Te2jvceBMSE2F8WoBUXYhsylWVufbt53PV/tQeVgxD9MmHKueKsGomPGkv9DVc/mEiCL/gJpr7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92XB1Q+nIEQR+GxRfpxYE7bMwehcsrctUqKMNXKw8rg=;
 b=joJNsLNM/qDRzbMWWGoif/LMmz+j5UPdnDehkCUQiPihlJZl496b6md8CWXe7mUwdfSzCwSNvfZhdG4+ndfqV/9Oka/VnlLRY7ydSCSJvnsqpu+5UikRsbI2UhUDjMdzngQy3Fyt4T8StcioDSl6Js8Vcy1oqNJNsOPM9jpuqaGUvviE7ZmB6rJV/+ZyfM/2MPwxwu0eYJEahsEWoS40vP+7oPH/sbbNbkplwg8jW47F7It+KiyUVUy62j7DW5IXPRwVq/hjLi/pYg4wlHzzDYN5HE/TeH6FOdYsHS509vbTAANWaevH/X1CrJUEhBlLbTWjLSG5Xk41rLt254d1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92XB1Q+nIEQR+GxRfpxYE7bMwehcsrctUqKMNXKw8rg=;
 b=drx9p4j7E+E328vwCD5eTi2qWpmbKt45ULLsWcZD0v+y9s4rRquLDOvs3yVPqOjxtFabsEU5sHgiJmsysakzAzbBR3HF6IXHQTHInzraQnClSgYAiRLYXd9a3p51QTt1lnYBKAAwtpcvvc6f5EbBcKI1+hrP62FfBHiX8rVoulxKL2I7gFd9WIIcWqO5sOq08Dkl5VTUDwvyPLbs5GlMzj21ckl5yInCqhC4rI8zNo+kT4xwt+m7uOt/jsRHnWk6GFZEmm7Ve3pBZWgmSlpCzbo/4uIk5hjWGUnXKlG86EzzcOlOQVXmRer0RymdqXdGdl9MBJJjgVXzYuG/h6SjZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 14:23:16 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:23:16 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 27 Aug 2026 23:12:57 +0900
Subject: [PATCH v2 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0136.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::20) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2737a562-b14e-422e-d7ef-08df0446bc35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|18002099003|22082099003|3023799007|13003099007|6133799003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: qIe8eKZzCzmxbs+WZft/aMf1lQfef4BwBF3HZOCPJp6m231Kk5cDowbyGpVaum/K3WZ+g+/kOGNyC9PKpuz3Ops+gqvXu4fYV5jd6ikizFHk8MNnBsNgtn+AEunZKtATkqY0mzGPXBPBsXWK4mEHP6zBSrcFYNw8ssw/ptPsyxE3kcGBuGJtjZyjR16HdSmGfJveL9F1fLnRducfJ0CxadeLCDdLgkOXzsGd5et/UB8hNHhN5eMe8wmVKrmbDW5m7KqYMrl6qx+daekX0mHkdunhiGzoMaaSdXcMX0zohcvLzXPSQ/ZCcygb6W+XzwbExw6C2tKxlSY0kpuNXXVnScYGUhFjS1d+uWkGQdNN79PzYFurgBlkX7xhReZS8Gt14YDjAW3K5qOiuueR244mErh12kuiyJr9LzkwYeiEBQWNlIiNEyB0rosU50Hjq1O0X9Im9W3sTewzxrzlQj4p8Hbbs6X3K63u7oQmzcNurgAvAIDb/J0pavJCJzQ1l7wcCIuf7tlK/YEVyig0/11cDlYXqh1SFehq09K8kQf9YAzwCiyzrwwsFmD9gzk8o2/VDKCVwhkvaQROptVqhzOdzGwgmEx+Lqr7zYMP9zr9Amd9xaRbsCMmis9ASJeLNZaJy3P2jyLv2hP3HOIyxmHkoeP4iKuSWCI7MYlla4Tmg4MHfgKSvg4j5fqHsclHILqs2FvSitQuvOh+rgZLbIwFXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(13003099007)(6133799003)(11063799006)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUlFTmZ3Z25OTGZuUGNqTUFnTXJOMm1tSXVtWjc2aERHRHFGK2ZxdFpXTGpm?=
 =?utf-8?B?bHduSm0yNDRFTVAvZGxjMmY4dnFicVVYYzdFcEdEdmt0WWFGOGxKMjFUdjc0?=
 =?utf-8?B?R3J5K3l5TDFyQVhsa0s2enl2YWdyS3MwaTVuOXpVdkw1NUFlT1BmNzZ1aXFW?=
 =?utf-8?B?V0pYWHlFV25BQzNtVlh0L2ljUUNOQ0F5TTZ5WGp4NUpoY2RDUEhsUE13WnRR?=
 =?utf-8?B?OTZ5Mm1kRSsxQzJ4QXprRjFPdzNUS0N0NDRPcFUzTU5jZzlWc1BKTG9xd1dv?=
 =?utf-8?B?SVhLa1VsSjJ1VkhvWVcxU3hBNXBKQ0dqZVFwcDR5ZEpNaUlqSEJhOW5RS2dt?=
 =?utf-8?B?akMwWklEMDVkaFVSblJ0RE1qUUc3em5yOVVERGZpS2hxMjAvMVRNY3FwWmM0?=
 =?utf-8?B?Y1ZmaWhXbnZRamxZa005Y09PZEpPWjR2MFdCMXZKSGVWUmtKbjFjenNTK3Ju?=
 =?utf-8?B?ckFNeWpaQkovdzNlMTlESUZUelN6TGRvUUR5ZHlzclYvL2pZeWIyYlhQQWhl?=
 =?utf-8?B?SVQ3MG9HY0V6UVhFd2MvZjMxVGNUaW0wa2llS0NZYjlKL2FKeEgySUN3UTBq?=
 =?utf-8?B?ZURxOEdoTjNETkgxaHlJRFM2NUlrTm03dUNVMGUvY05OTEE2WHZHdnlSVFda?=
 =?utf-8?B?Y2Rxc29wYTIzTFREUW9UVWFYc1NCMkRvVmdjMTlGbTNYWlB2SGNmYy93Tncx?=
 =?utf-8?B?VzI1Z0lycFViV3AvNmpVbVJnVjA2ZGRqZ2dFRW5GTlJuK29kMDVaUnVURGhX?=
 =?utf-8?B?WHpEREJBNDlyTzhoNktEdHhka09Ndi9FaUdsMDhBRG01TDh0NkoybnZ1KzM1?=
 =?utf-8?B?am1waThlUlE1ZGYxelExZ3RzSXhJa3YrVGM2Vi83NXowOWlySHI5TjlQcm5Q?=
 =?utf-8?B?MEhzK3lsMEV0dCtYWlN4KzJXWjJ0SS9rWjRCb1haZkkzNWdiVlkwc09UcStN?=
 =?utf-8?B?OUxMUkhCZVNGZllmZzJjMFNYdmhUT1lNTWJHek1BUHFKNTIrOWxWcUZNenFD?=
 =?utf-8?B?c1pFanVIMm4wZkw4S3lvaGNOREh1ckhQMFlldHdDOFo1b0JJVG8zMExYYStv?=
 =?utf-8?B?VmFpa2RaM0RVb0FlSFFjbGtGZEx2eGNTZmloRUhBMkgyT09GMzVGM2JWU3Fo?=
 =?utf-8?B?NUd1by9yZFVyQzBtSDRLV2ZxaTBHNzFQZENTR2RRc3VDb201K1BXbllwYTZW?=
 =?utf-8?B?SWNXR2pNSnlKVTRTYUxxbWI5QmVjQ0pTZkt6T1A1T2hHTkxGdFRXSEp6bTBk?=
 =?utf-8?B?VmhXQTZkZEJFUXl4aWp3MXQ1dEZpUlB5MXpYYnMybGI2ZWlWWitWUG5MNXBt?=
 =?utf-8?B?aU1seVJPZUFzL2Q2SmtaMFU5aTI4NW5Qd08vbDF4WHByb3JYejM0SmxhWEJu?=
 =?utf-8?B?dTZsbnNpMjVSWlF5aTYvaUhpT1YzRmdTcU5aYmpmbkUyZUFRb1dyYURuRGty?=
 =?utf-8?B?UURGWm9BeGI5c1dpTEhwaHphYi85eWw4a1dtbHhrZWNzYkUwNWsrNmF4UTJ1?=
 =?utf-8?B?OFhxR1NxVkJEWkNud1V3ZU9jWVFHWURLOEJJeERPOTJTNEpiT1YvNXhtMmp0?=
 =?utf-8?B?elBZSlR0TGw1Y1I2OWxlV0d1dUFRcy9uaGlPTGxwdE1hTXRkbWgxWXAzQnhy?=
 =?utf-8?B?VDBHYURDTUppSlJxOW1uMnVmeUh5QTVvY0lhSnFGa1Q0REVIeXdRQ09Zb2Vw?=
 =?utf-8?B?Nmk3T0FRUGxXN1hLL2ZQUDlBTy80OXcyWTlkeXFXNE9KV2RNUUtaWGJkSkp3?=
 =?utf-8?B?a2xIemRiMU4xbkVQOXYyZTZqcGcxeXNnSW9KemV4OW53U3dibzZHa2xZSVlp?=
 =?utf-8?B?bGJxc2NxZExSR1pTd2hXTE4zamcxUnlxdWFaSndFdng2amduOHFaSm1Jb2I4?=
 =?utf-8?B?WVRnYTdZYzZBNWFaQ2dCVFcwSDBPOUFpbzk2S2dQV0ZLSjR4RStMSTlJSnpB?=
 =?utf-8?B?NVVvSElxdkVQNVdpNHdxcmV3ZjV5ODZ0NU81UmVFQndiQUpaUHdDZk9RaTlz?=
 =?utf-8?B?VkFrSHZ1SlFNbEU2NHIxQlVQbjFGblJ4YnNtNmtuby9GSkI0Wk4xN1laejJm?=
 =?utf-8?B?QVU4WU9mZGQrWDdLQ0FQTnQxR0ovVlVaVWpZNGZsd0M0emxmNFU2alpua0Jo?=
 =?utf-8?B?UTBmNTlhQUN6ZmZITW01SGVOTW9Nb1BCemg4OXF0alVFZis2cDJnejMxK1RO?=
 =?utf-8?B?Y1EvTGYrWFN4V1lQTWtmS3BlZWxnMHY2MTlPOXloUi9Ic3hpcFUvK1MzN21v?=
 =?utf-8?B?Qlc1WEQ3ckpHMGtZZVY2RjRyU3l6Q2pBcmtNRzdYK2orcHFFOVg4Z0lKQWk3?=
 =?utf-8?B?b1FzZTNxU2JMV2wrbHBVTjg5bllXVVE2SDFZRkhDbVhPUXZKTFRHREg5R0Jn?=
 =?utf-8?Q?gP1konEcA9aPc5gvCg/Kmcjd9f+QRcj54VRJYbmV+4yHf?=
X-MS-Exchange-AntiSpam-MessageData-1: pMHn6fWqNaEo1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2737a562-b14e-422e-d7ef-08df0446bc35
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:23:16.3124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbwPyx4ji7W7CfZRRZsbY/h3GMKZHyxPW1aOKnFsFYAt55K+ldjuenFapE0mC88TXPYipBrvMqbBG8r2HuRUEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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
response for GSP init. For now this is exercised via unit tests. Later
patches will support GMCAPI in `Cmdq` and use these messages.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 350 +++++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/nvkv.rs        |   3 -
 2 files changed, 350 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..25ac1e8e7785 100644
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
@@ -19,6 +21,19 @@
     num::IntoSafeCast, //
 };
 
+use crate::gsp::nvkv::{
+    nvkv_decode,
+    nvkv_encode,
+    Accumulated,
+    Array,
+    DecoderValue,
+    Encodable,
+    Encoder,
+    Key,
+    KeyId,
+    Required, //
+};
+
 use super::bindings;
 
 /// Payload of the `GspSetSystemInfo` command.
@@ -217,3 +232,338 @@ unsafe impl AsBytes for UnloadingGuestDriver {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for UnloadingGuestDriver {}
+
+/// The host CPU architecture.
+#[derive(Clone, Copy)]
+pub(crate) enum HostArch {
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
+        key_name: Key<&'static [u8], { Self::REGKEY_NAME_KEY }>,
+        key_value: Key<u32, { Self::REGKEY_VALUE_U32_KEY }>,
+    }
+}
+
+impl RegKey {
+    // Define the Key IDs read/written by GSP.
+    const REGKEY_NAME_KEY: KeyId = 0x3070;
+    const REGKEY_VALUE_U32_KEY: KeyId = 0x3071;
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
+        total_vfs: Key<u32, { Self::VF_TOTAL_VFS_KEY }>,
+        first_vf_offset: Key<u32, { Self::VF_FIRST_VF_OFFSET_KEY }>,
+        flags: Key<u64, { Self::VF_FLAGS_KEY }>,
+        first_bar0_address: Key<u64, { Self::VF_FIRST_BAR0_ADDRESS_KEY }>,
+        first_bar1_address: Key<u64, { Self::VF_FIRST_BAR1_ADDRESS_KEY }>,
+        first_bar2_address: Key<u64, { Self::VF_FIRST_BAR2_ADDRESS_KEY }>,
+    }
+}
+
+impl VfInfo {
+    // Define the Key IDs read/written by GSP.
+    const VF_TOTAL_VFS_KEY: KeyId = 0x0080;
+    const VF_FIRST_VF_OFFSET_KEY: KeyId = 0x0081;
+    const VF_FLAGS_KEY: KeyId = 0x1003;
+    const VF_FIRST_BAR0_ADDRESS_KEY: KeyId = 0x1050;
+    const VF_FIRST_BAR1_ADDRESS_KEY: KeyId = 0x1051;
+    const VF_FIRST_BAR2_ADDRESS_KEY: KeyId = 0x1052;
+}
+
+nvkv_encode! {
+    /// Payload of the `GSP_INIT` command.
+    // TODO: expect() doesn't work here due to Self:: reference, fixed in 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
+    struct GspInitRequest {
+        pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
+        pci_sub_device_id: Key<u32, { Self::PCI_SUBDEVICE_ID_KEY }>,
+        pci_revision_id: Key<u32, { Self::PCI_REVISION_ID_KEY }>,
+        pci_config_mirror_base: Key<u32, { Self::PCI_CONFIG_MIRROR_BASE_KEY }>,
+        pci_config_mirror_size: Key<u32, { Self::PCI_CONFIG_MIRROR_SIZE_KEY }>,
+        host_arch: Key<HostArch, { Self::HOST_ARCH_KEY }, u32>,
+        bus_device_func: Key<u64, { Self::NV_DOMAIN_BUS_DEVICE_FUNC_KEY }>,
+        regkeys: KVVec<RegKey>,
+        vf_info: Option<VfInfo>,
+    }
+}
+
+impl GspInitRequest {
+    // Define the Key IDs read/written by GSP.
+    const PCI_DEVICE_ID_KEY: KeyId = 0x0001;
+    const PCI_SUBDEVICE_ID_KEY: KeyId = 0x0002;
+    const PCI_REVISION_ID_KEY: KeyId = 0x0003;
+    const PCI_CONFIG_MIRROR_BASE_KEY: KeyId = 0x0010;
+    const PCI_CONFIG_MIRROR_SIZE_KEY: KeyId = 0x0011;
+    const HOST_ARCH_KEY: KeyId = 0x0070;
+    const NV_DOMAIN_BUS_DEVICE_FUNC_KEY: KeyId = 0x1020;
+}
+
+// Decode:
+
+// Should decode with UnknownKeyPolicy::Ignore.
+nvkv_decode! {
+    /// Schema for the `GSP_INIT` response.
+    // TODO: expect() doesn't work here due to Self:: reference, fixed in 1.97.0
+    // https://github.com/rust-lang/rust/pull/154377
+    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
+    struct GspInitResponseSchema => GspInitResponse {
+        gpu_name:
+            Array<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, { Self::GPU_NAME_STRING_KEY }>,
+        fb_regions: Accumulated<FbRegionSchema>,
+        bar1_pde_base: Required<u64, { Self::BAR1_PDE_BASE_KEY }>,
+        vmmu_segment_size: Key<u64, { Self::VMMU_SEGMENT_SIZE_KEY }>,
+    }
+}
+
+impl GspInitResponseSchema {
+    // Define the Key IDs read/written by GSP.
+    const GPU_NAME_STRING_KEY: KeyId = 0x2000;
+    const BAR1_PDE_BASE_KEY: KeyId = 0x1020;
+    const VMMU_SEGMENT_SIZE_KEY: KeyId = 0x1050;
+}
+
+/// Payload of the `GSP_INIT` response.
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
+        base: Required<u64, { Self::BASE_KEY }>,
+        limit: Required<u64, { Self::LIMIT_KEY }>,
+        flags: Required<FbRegionFlags, { Self::FLAGS_KEY }>,
+        tag: Required<u32, { Self::TAG_KEY }>,
+    }
+}
+
+impl FbRegionSchema {
+    // Define the Key IDs read/written by GSP.
+    const BASE_KEY: KeyId = 0x1011;
+    const LIMIT_KEY: KeyId = 0x1012;
+    const FLAGS_KEY: KeyId = 0x0012;
+    const TAG_KEY: KeyId = 0x0013;
+}
+
+bitfield! {
+    /// FB region attribute flags.
+    struct FbRegionFlags(u32) {
+        0:0 support_compressed => bool;
+        1:1 support_iso => bool;
+        2:2 protected => bool;
+    }
+}
+
+impl TryFrom<DecoderValue<'_>> for FbRegionFlags {
+    type Error = Error;
+
+    fn try_from(value: DecoderValue<'_>) -> Result<Self> {
+        if let DecoderValue::Scalar32(v) = value {
+            Ok(v.into())
+        } else {
+            Err(EINVAL)
+        }
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
+
+#[kunit_tests(nova_core_fw_commands)]
+mod tests {
+    use crate::gsp::nvkv::{
+        Decoder,
+        Index,
+        UnknownKeyPolicy, //
+    };
+
+    use super::*;
+
+    // Tests that `GspInitRequest` encodes correctly.
+    #[test]
+    fn gsp_init_request() -> Result {
+        let mut encoder = Encoder::new();
+
+        let mut regkeys = KVVec::new();
+        regkeys.push(
+            RegKey {
+                key_name: b"test_key\0".into(),
+                key_value: 0xdead_beef.into(),
+            },
+            GFP_KERNEL,
+        )?;
+
+        let gsp_init = GspInitRequest {
+            pci_device_id: 45.into(),
+            pci_sub_device_id: 67.into(),
+            pci_revision_id: 3.into(),
+            pci_config_mirror_base: 0x1234_5678.into(),
+            pci_config_mirror_size: 0x1000.into(),
+            host_arch: HostArch::Aarch64.into(),
+            bus_device_func: 0x0001_0203_0405_0607.into(),
+            regkeys,
+            vf_info: Some(VfInfo {
+                total_vfs: 8.into(),
+                first_vf_offset: 1.into(),
+                flags: 0x7.into(),
+                first_bar0_address: 0x1000_0000.into(),
+                first_bar1_address: 0x2000_0000.into(),
+                first_bar2_address: 0x3000_0000.into(),
+            }),
+        };
+
+        gsp_init.encode(&mut encoder)?;
+        let encoded = encoder.finish();
+        assert_eq!(encoded.len(), 22);
+
+        Ok(())
+    }
+
+    // Tests that FB region decoding fails when required keys are missing.
+    #[test]
+    fn decode_fb_region_missing_required_fails() -> Result {
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, Index::new::<0>(), 0x1000_0000)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Ignore);
+        let mut schema = FbRegionSchema::default();
+        let init = decoder.decode(&mut schema)?;
+        assert!(KBox::try_init(init, GFP_KERNEL).is_err());
+
+        Ok(())
+    }
+
+    // Tests that a minimal and a full `GSP_INIT` response decode correctly.
+    #[test]
+    fn gsp_init_response() -> Result {
+        let name = b"test name\0";
+        const BAR1_PDE_BASE: u64 = 0xdead_0000;
+        const FB_REGION0_BASE: u64 = 0x1000_0000;
+        const FB_REGION0_LIMIT: u64 = 0x1fff_ffff;
+        const FB_REGION0_FLAGS: u32 = 0x7;
+        const FB_REGION0_TAG: u32 = 0;
+        const FB_REGION1_BASE: u64 = 0x2000_0000;
+        const FB_REGION1_LIMIT: u64 = 0x2fff_ffff;
+        const FB_REGION1_FLAGS: u32 = 0x3;
+        const FB_REGION1_TAG: u32 = 1;
+        const VMMU_SEGMENT_SIZE: u64 = 0x0200_0000;
+
+        type Resp = GspInitResponseSchema;
+
+        let index0 = Index::new::<0>();
+        let index1 = Index::new::<1>();
+
+        // A minimal response: only the BAR1 PDE base, so the FB region list stays empty.
+        let mut encoder = Encoder::new();
+        encoder.encode_u64(Resp::BAR1_PDE_BASE_KEY, index0, BAR1_PDE_BASE)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Ignore);
+        let mut schema = Resp::default();
+        let response = KBox::try_init(decoder.decode(&mut schema)?, GFP_KERNEL)?;
+        assert_eq!(response.bar1_pde_base, BAR1_PDE_BASE);
+        assert!(response.fb_regions.is_empty());
+
+        // A full response.
+        let mut encoder = Encoder::new();
+        encoder.encode_array8(Resp::GPU_NAME_STRING_KEY, index0, name)?;
+        encoder.encode_u64(Resp::BAR1_PDE_BASE_KEY, index0, BAR1_PDE_BASE)?;
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, index0, FB_REGION0_BASE)?;
+        encoder.encode_u64(FbRegionSchema::LIMIT_KEY, index0, FB_REGION0_LIMIT)?;
+        encoder.encode_u32(FbRegionSchema::FLAGS_KEY, index0, FB_REGION0_FLAGS)?;
+        encoder.encode_u32(FbRegionSchema::TAG_KEY, index0, FB_REGION0_TAG)?;
+
+        // Test that this unrelated key can safely interleave.
+        encoder.encode_u64(Resp::VMMU_SEGMENT_SIZE_KEY, index0, VMMU_SEGMENT_SIZE)?;
+
+        encoder.encode_u64(FbRegionSchema::BASE_KEY, index1, FB_REGION1_BASE)?;
+        encoder.encode_u64(FbRegionSchema::LIMIT_KEY, index1, FB_REGION1_LIMIT)?;
+        encoder.encode_u32(FbRegionSchema::FLAGS_KEY, index1, FB_REGION1_FLAGS)?;
+        encoder.encode_u32(FbRegionSchema::TAG_KEY, index1, FB_REGION1_TAG)?;
+        let data = encoder.finish();
+
+        let decoder = Decoder::new(&data, UnknownKeyPolicy::Error);
+        let mut schema = Resp::default();
+        let response = KBox::try_init(decoder.decode(&mut schema)?, GFP_KERNEL)?;
+
+        assert_eq!(&*response.gpu_name, &name[..]);
+        assert_eq!(response.bar1_pde_base, BAR1_PDE_BASE);
+        assert_eq!(response.fb_regions.len(), 2);
+
+        let fb_region0 = &response.fb_regions[0];
+        assert_eq!(fb_region0.base, FB_REGION0_BASE);
+        assert_eq!(fb_region0.limit, FB_REGION0_LIMIT);
+        assert_eq!(fb_region0.flags.into_raw(), FB_REGION0_FLAGS);
+        assert!(fb_region0.flags.support_compressed());
+        assert!(fb_region0.flags.support_iso());
+        assert!(fb_region0.flags.protected());
+        assert_eq!(fb_region0.tag, FB_REGION0_TAG);
+
+        let fb_region1 = &response.fb_regions[1];
+        assert_eq!(fb_region1.base, FB_REGION1_BASE);
+        assert_eq!(fb_region1.limit, FB_REGION1_LIMIT);
+        assert_eq!(fb_region1.flags.into_raw(), FB_REGION1_FLAGS);
+        assert_eq!(fb_region1.tag, FB_REGION1_TAG);
+
+        assert_eq!(response.vmmu_segment_size, VMMU_SEGMENT_SIZE);
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gsp/nvkv.rs
index 7d58ca91cbc3..e7a9549919fb 100644
--- a/drivers/gpu/nova-core/gsp/nvkv.rs
+++ b/drivers/gpu/nova-core/gsp/nvkv.rs
@@ -9,9 +9,6 @@
 //! function calls will map to some struct - for example, f(GPU_NAME_STRING_KEY, 0, b"some gpu")
 //! naturally maps to storing a &str with the GPU name.
 
-#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
-#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
-
 use core::marker::PhantomData;
 use core::ops::{
     Deref,

-- 
2.55.0

