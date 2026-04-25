Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE9FF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF0D910E483;
	Sat, 25 Apr 2026 21:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBzTLY+B";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C08B10E201
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8Z11uusZhau0tzjdur9gYyKZLYug39bAIfLvZggifRZF/KFOQZVIfPThk3D3WEU8o5tEtS1WaoN+R6qWo/s1Nvl8yU8tlA4krrkVx4sXf++NUj7EGHd8aqbUjTzlyXz6F51m8Hove3j2s8iuEj5OUJXBsAZk5tRh09LfvN2lDkqz1JebUa68WikKohgc3BScJxqKdzYeL9S//DNLsFPrLo/+P4SBEmEiddEGd2nH807enveJun9FDA3tAbC6gmEh+JgwfavY4C38PlTf7ACy5Yh2KsSyDb18MHx7YNGMYel+FXFImY+Ava9zM5JUACXMQPvMbSjH3M58iGsTg5IUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n481Ew9f+6nwEEv386nbZrRTppm7/S4pyh292OP34Y=;
 b=LXvsZBBSD/zlA1/a/5z1ZvFNw0lmpwOQacUumQO/yW7sVMNHGv3jU7WGtSlddCAWNMCxmwYRfaOnYvAInPYfqOdOEJd12b6W2/Fqdk2jWrvsW0r6493s6YeffI7bbDDMzgVSEcE5wbKeA5NFcH+Hx6kmJ+Pxf8HR6QrwtEAoNM+uScastqd9tsvd0DhgObJ+WWE0d3istrqJ7lxvseOYzfXKFyRGI5CIr0rx7vFtXlK3PavXqt/Yodr6gnzK/VIsAC7Fli82fpRGBMZIu4TbPwbv5xxFyrj3ZQm2y7vuqKAb8GY2IyZPlgZPuXE/Jgv4nIxQBmnycSRkuv9hMdvd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n481Ew9f+6nwEEv386nbZrRTppm7/S4pyh292OP34Y=;
 b=NBzTLY+BRnvdmo6M6dhppDWDlJ+n1xVA/nuB3pEpRkksDZXMLGHfHyQ6RQYnq0uCR1VEC1mGuaZ5kWTBhrV8xDpb6uRLzP5svsLZDAT913UcQ+U93G10rQjLubZnEJxiaBxY0QwsyueEpvXZqXI25oRPm1Q/nMi+nvOwcMWhYn5nz8fgDHU+Oc044zoMQdbLhIS5X/u+E3D8BC1oIcUoXs17UY5rsB0K8PTM/HKkK+EtGNLsZYaLXlyZ8yTRdCBKSrJiHCIS/Gz2MuDYgopO75l3OhLNeL2QByJ1qCnC3QqnSlekKEttvmLeejn9DeLDlllAons+xHed9EjroMe79w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sat, 25 Apr
 2026 21:15:11 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:11 +0000
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
Subject: [PATCH v12 01/22] gpu: nova-core: gsp: Return GspStaticInfo from
 boot()
Date: Sat, 25 Apr 2026 17:14:33 -0400
Message-Id: <20260425211454.174696-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:930:45::15) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: a217bb57-8378-4c0f-104c-08dea30fbc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: suGphSDO+z03JBhBC35bSlTm2jxHV0V5CXNKT0qH1uGJqklcjgAqnpQxfcmfGnREm4XbmObDERYYE5kiyMCIiA2SQqZV15G/a32hKSC7Q5pSkplAvwxbBE5GP2JA6wMIYpBkL2WTc+SqOBN7PUqkuNur7qqvxze8Vn1QnIIOtq2vINcQ7UTQYKaUGCOLddiYLLE5rqh4w8jIGi3sD/Ro9L002k9qlxUNZKzPoHKHYCs+4kD08fngBJQ+NZ1J64VHlbiME9gTDPoObY1XliKajcpaIrVNV4fwZk8UnlxAUn93mMPnH4F+jEEVpYAZxM6cYEmgzDIkuv/xPH+QFlGnKV24ngDcSxW+DGENWlKfjBEJXljeBInjN5cHjHqdifHndL8sQiwZCp1BkmXAY9dEPjHGOo/Ah6T0q83GDGjVdAZKLuXS+72ruY2Txir5DAHTlKY0iLgTfwS8OzUmrYkrUOSuz1e0IW3mLGvImNvbKPtJ1f/iBI4CqvTxc7IrneRuCDbzOfTNMqjTz5csh86o2dD43uyuSZFmToveIDIZwtUqkekc3dyUfiAIXBnmOzyHUGaFI/5SD5xhCehrS7ElNH7lgHXCOJdXNUg5VSYRbuEcSJMwskROGe9Kbulad9zfS19aB9Bd4gGcHdMqrOcB2nGNyx5hgcEtLfq3nifx4PLikfFYjIuA9xqYXAoeSTEhw8vEozkBEBqvQaZ3569SXntoRUsZNubmfwI1Ek09T+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2F4v5DCk/TGtEl/ZqYLFMaFXT2FrlBmna6Fz7sPm7y85VbQdMIXmM9DzMBq?=
 =?us-ascii?Q?rPKYnLNmsKg3pOSHFoHKd6miZuLZ3/rq3FUuxW64nHsKqllgsRJmOR7FEuQI?=
 =?us-ascii?Q?TgszTF+Kmg87uq33cFUYbUYb/WCAoX/0Lxqfc85o6PVNNpRvYxQ3//ff6Nrz?=
 =?us-ascii?Q?VWbgzjFgYh1RdH3B76WkNXU9LauY4gCdBk39i7jl8kmFQxjp5KC8RaG5MPk2?=
 =?us-ascii?Q?c9qy6iuxtkBm3KMJyfHSGlEnuOlUaVXpwiH0n6ieg1txWc4QK5cqdsZEtrl1?=
 =?us-ascii?Q?2FwsrQ2efY7Ehee68cRqjPk0PcSMfc0ZwrbtJUKNbT1IdBRkrdCvk9I/YWJY?=
 =?us-ascii?Q?jX4DGuEbfOIu2HqSNyVHDfNECz8dCJPtXLJtpHtGok3xxEYIW67fFkvXGlqr?=
 =?us-ascii?Q?cTtWgDsOMchauCm3OFg+GQKCnbwXDp/lmTAZJqH6BDfd6zfBtwHZ5DjbNbot?=
 =?us-ascii?Q?r3qwvLYLCJgtQkMp6t1QKcnxfGE8WPEJtUNsPpWHItuhbBl6IeU/+pBspdoJ?=
 =?us-ascii?Q?YO4VlFTN+X/bxWvBYrzpqXaMcqcFkZj7lF3Rvxe/XXuhKcWcamD1kIO7YAxc?=
 =?us-ascii?Q?QnDCjQtEo+rSmRLINoP8/z03xIxQioEvMKFfSXbWFzZKadnviwhUp/NKg3vD?=
 =?us-ascii?Q?ED7/NXSY7WSZEczL0JmQ+56i1waTUg4DYDjerB2s7zHpZ82kZLgIfX7Ay3Mw?=
 =?us-ascii?Q?jyO8Cc0EqVcaQ97aD4D/VqG5nXVpre7i4VSk33x8PBP95H94MNYIrA5FTnoC?=
 =?us-ascii?Q?0Z+l9+ES6QXTs+EJ07kCA20Z0de1lp9jcHwhJa1hyA1gIOcnt2opNUXNniQf?=
 =?us-ascii?Q?2cfKbff77ATCYDToUjLaU7Xo7uunKVhe1OA3Y/hh6mJlqmie/weOM1BQ+Fwc?=
 =?us-ascii?Q?9gSWJ6dYlYp3unULXzphXBVT0L0FMjj2bw84Z5j6crn/qQIaXKvuq7AqWe5L?=
 =?us-ascii?Q?beEj4GJPdXtGpVkXE+WertIEwUnd55ncKxpNdEU40hpbgOo1nhP5nNKNNDGD?=
 =?us-ascii?Q?v7rbh8Z3t7a9R5KrVMvl3h1yq2qsIPxXViWRfqxg3JPEqvBWG3bIN+jhVeA8?=
 =?us-ascii?Q?59xyaH9jIH1GZgnheguGJdoTeUJe3TIYfmxTO6SS7Rg1ngmnSeX4R41hY//L?=
 =?us-ascii?Q?c/Ywvcoem84I+lVRNuUzz/YlKh3haNLhI4GPdTRaEvrLmF0F9oW6JQEsMv3u?=
 =?us-ascii?Q?VY9IL/DsUrTnlpwtqvZLGdmesrKVw+CbGg/YU18mvwI9s6A5919+7FcpS0Q6?=
 =?us-ascii?Q?4J7GRUb+xiSgIrolXxAZBLuK1zcgalilOyxfOA5MSf0tWsmttuSdP3WkLpTn?=
 =?us-ascii?Q?bauQmrbCh08llXzGT9UPVJjrZBqaJi7jpugudOawfVEgNATtmBI2bdwqw40L?=
 =?us-ascii?Q?cLcwP9/1vInEfCioozIRJL1GHpg5UbrCFJhqrbuwwyPgjmwPVs4tCgILLP/m?=
 =?us-ascii?Q?i5knNzNlCx16iHvGm96zXtGvIxNJMXC7z1RdbJu2rJOBzbRNaiLGwE/NxkYt?=
 =?us-ascii?Q?17B7EgvaxV/PB0dehg4M1HXrVunzmgzisaLooFgA5qomzcjT4PY5H6e5OlLS?=
 =?us-ascii?Q?TnNXfiiB1zr2GwWCCBEkds6e3bLH88Ml3t+TG1rMZFZmfQYPh+odvlZCjDmV?=
 =?us-ascii?Q?tdJ0+aQ0DJMDPG3mj7dX3yuHMH6UNKVrs/86DSMCIuAI8LndNbnVTfNXC5AU?=
 =?us-ascii?Q?TyeioSstxinyPjpJlmmyF9npNMRuVsfsUChPHk9W3jDa8DwPcxOjEmY9F3EN?=
 =?us-ascii?Q?AHqYqofbOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a217bb57-8378-4c0f-104c-08dea30fbc24
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:11.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUu/CDh+qXaf9qYVcOXKqxPtnGGmtdmNJglrSNXSgC72jGap1c4cf4H7Jl6GzVoH6fBJ8HA6+/SOzwMv68p1WA==
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

Refactor the GSP boot function to return GetGspStaticInfoReply.

This enables access required for memory management initialization to:
- bar1_pde_base: BAR1 page directory base.
- bar2_pde_base: BAR2 page directory base.
- usable memory regions in video memory.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Cc: Nikola Djukic <ndjukic@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs      |  8 ++++++--
 drivers/gpu/nova-core/gsp/boot.rs | 12 ++++++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..f2a8915a1ff4 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -21,7 +21,10 @@
     },
     fb::SysmemFlush,
     gfw,
-    gsp::Gsp,
+    gsp::{
+        commands::GetGspStaticInfoReply,
+        Gsp, //
+    },
     regs,
 };
 
@@ -238,6 +241,7 @@ pub(crate) struct Gpu {
     /// GSP runtime data. Temporarily an empty placeholder.
     #[pin]
     gsp: Gsp,
+    gsp_static_info: GetGspStaticInfoReply,
 }
 
 impl Gpu {
@@ -269,7 +273,7 @@ pub(crate) fn new<'a>(
 
             gsp <- Gsp::new(pdev),
 
-            _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
+            gsp_static_info: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
 
             bar: devres_bar,
         })
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 6f707b3d1a54..51593b16fc57 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -33,7 +33,10 @@
     },
     gpu::Chipset,
     gsp::{
-        commands,
+        commands::{
+            self,
+            GetGspStaticInfoReply, //
+        },
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -145,7 +148,7 @@ pub(crate) fn boot(
         chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
         sec2_falcon: &Falcon<Sec2>,
-    ) -> Result {
+    ) -> Result<GetGspStaticInfoReply> {
         let dev = pdev.as_ref();
 
         let bios = Vbios::new(dev, bar)?;
@@ -229,12 +232,13 @@ pub(crate) fn boot(
         commands::wait_gsp_init_done(&self.cmdq)?;
 
         // Obtain and display basic GPU information.
-        let info = commands::get_gsp_info(&self.cmdq, bar)?;
+        let info = commands::get_gsp_info(&self.cmdq, bar)
+            .inspect_err(|e| dev_err!(pdev, "Failed to obtain GSP static info ({:?})\n", e))?;
         match info.gpu_name() {
             Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
         }
 
-        Ok(())
+        Ok(info)
     }
 }
-- 
2.34.1

