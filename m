Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C28CD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E1510F623;
	Fri,  1 May 2026 20:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBmgA1fB";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC4410F5FB
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5scdv/WKQd9y9ixPYzEGHoReGsRGxzfHAtM1vhKYhHiFaMh1dtwYMmYmlE3vTkcavMlGP7aR6fs+wOjA6DLFOle/peRY+BgLLPQmJp968HKc+KWTDugIU6BLQ29JsVi5+DB9aTGB0l0acL2Ek4fzVehGfcIszURpNFEMdzTyZNAwzmeiHVF1uYzCVrt2Mnt8Lzc9xtPgm/qHkOvCJ1GUj2XH+P1k+IRRJTvBV3XDHqVv3SskpoDKoEum8RLVs8GVZBch0n20LLazwF69kWnxilDdqWiqCd1pVb+7sjwE/o6PgHBMv7W5QuJNlVP/x8AJTwnocCNTFoaTIs+FzQ8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0txI5czU45l8odAMi6tHPNqLevB9sr1FQy3otwOg13M=;
 b=G2bcgkaWUjVtOQ2lFQaf19W48D4fd/Cya323piGI+n3U9qJFroowHEg0ichghNKXrUInkNzTnemiC29gX9HOQR09NuIDeITE5hwtKVnLj4ePU2tvGhic/GrH0xi7Z2NJJe2YwM4cE+rVxjrIyGtxFHqIdSHIwTE261JPWQ9Sp8VPdFzVLnxLPefYvLS6NNBiCsC82ZkU0SYMKEcnEA+FZwaT8vFhC4ah5zdIf9fJBt+z6GwysJ1r0Ty+SSw/pT4OhNOZeEtwJ7G8tSAWh49b6Ggg8HgK4AIML8x0zSEHVEfe0zC3luioWLQimQHz5Q5fNzy8XVbfhJCES/24nK903Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0txI5czU45l8odAMi6tHPNqLevB9sr1FQy3otwOg13M=;
 b=FBmgA1fBPJDg7sUCO0mQzXIZoF4aGUDd4KGC+QTHGsfX80AOuF0fQgMz5Ex+G7tlAX4hUGPRhxEyz6rC6jhDZq8FwEvNysRPFxIVF2xqpxH9PcYoCMrxVyxn5gvltiVx1v5TdaEUuplLUaMivnacSvZDyJ9ueiD8t/Jt1AdEJ9/HPDfQglur9aksSNiySUFa1eC6km058fo3lzjW2uIEY3YRAI9ZsTDPxlUhSyH32eVeejw+CQzbnumL3uKZvZJ7i53MuZ0mHUT0+w8UAAoKQ8hAhyDIOae066aat+9B2bTFZU06DiHifmT0RU/sMYyVLF5/GKvpms/+yEVx6YBsyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:58:36 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:36 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 2/7] gpu: nova-core: allocate PCI MSI vector during probe
Date: Fri,  1 May 2026 16:58:20 -0400
Message-Id: <20260501205825.73614-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::18) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e39279e-c550-4568-0eec-08dea7c4699b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mzYbqER/xnMo8NZHPdEswrOVK3eP9es4tJpI110O2XEwMfMJcpEHrpTtMju0ZlP34xbjaFa6w3gjn4bmI6Bfo55p+L53tegPrm5AKtwDxNs/vOV26rYEjr0bc608/5UVZmlpxtZg2nXwSVsuZXhT8SZqEfsHZX2UxfHviIRyFGlM0YCzwwKdfSUHhrcp5/7Br0HyN6pbyua9cq2jv6YYoayRXTvQ6gsmxHUfZghsfhhg3ZhTGyyEASSnk0lB7HVn8EKTEYPU0iZUVL30I++bl9UwaaIKCubUYw2TfFhZYvDRFJ6KCuxy5HEJkN3dEsrFyRh68KeUP+Q9L2eesZsjyTQYk+ujx5PlBoZXWCUgFlPtW7qrwyKnnItfX7hNT4GCgMf/jh5i4YrRuQjtfHMAsEQIi9G1lhVjiiSgaOEI2qOqslr2nJdSirWYlFgckjcub3xiBxe/Gm6dSofFgac23P0R/v98xOgrI1L/7ZGEjluRSO4dksTITth71JqXA90dqkwLKuOGZLnUSX/IWEmwdAk1ircEUWMkOERMi1UXWrQ5/gP4xAyyet3/2AeBjHFCvc8uwKseIPXHfKDQJ+O6GO7d6bdX+zHVRyADfcDQTYA8xlbTFu55sn7PuVYA0+INAY50GpdjJWMzA7uoPyAaH/+8oFD2R8AFZ5iPptqP9eQAoR7xRjsyft9axDsbjZtG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e+OuvvwFRa9MPq3EhLWBzwVDVYvHD85JFJrKm0uI/CC7qS+eGhOMsDDc6kxp?=
 =?us-ascii?Q?l9b7wFLVU2GmOQtA9gkNIRPCxB0wX40tcN9MblhwdJN4CPxIgShvMkMou4zD?=
 =?us-ascii?Q?GV0P6RsbeRpl2O1KZNjVZ337a9h9/aM6qIeEV8gR6HaS/Uvd1lfOSdkGIjfX?=
 =?us-ascii?Q?KRcfWc9xQFTaQFuvE9STOe9N+5PXn65ixs8Rkn0v5/H8ysq2q5LbXsHFaXkJ?=
 =?us-ascii?Q?Yqr2G2LRJ2+3RM2/GTRLr4YuwDurPV2CmyCqwbeeoGe9J5/GgwSMOEbtBr1v?=
 =?us-ascii?Q?OCNVLfRgosCs7Et50UzbwMrtsgBXJwaYtBro/ZqJU1Ma+mhkzFgXZFR+jW/+?=
 =?us-ascii?Q?opDqYsLygHD/itS5bQvht+gNZuN+O9sQG1RpApZ5Bm8E6neuH/ye+l6VOhlF?=
 =?us-ascii?Q?9i174D2tIr6/WQr8qx7kZ8vyB5UcxcO2bxlltHFet4HcmybJIg6BFs6R9EXG?=
 =?us-ascii?Q?TbvQRofIyz/hVJXUzD4i9qgNQaOpBE5L1fwbsM+i0NZxdyVzL89BzgmMwqRO?=
 =?us-ascii?Q?K3Rq/TYggKtrdDIvpjvVSimahmXv7tkD6tErO8FqquDITu+KzZADZa8VWDcl?=
 =?us-ascii?Q?vxHMYdJV5hzX6/F+n2lXhemFbbj3Ke3gd1QsqFu+fPKMejcYPtm45Ureei94?=
 =?us-ascii?Q?9MYpWOQ93urzoNBFYeQfFY1buz3mXGwISkvp9yqq7rVjCiqViernPV3c/lmt?=
 =?us-ascii?Q?fuTXZuIYJhrrMtksC8tbczlR3z5bjSQV35/39hN1InIhnbuLZ0xBCzbxL6wu?=
 =?us-ascii?Q?Z2DqM5vmgDiZ09eJ++ftN3cThkqR+K6dDhbcBkQXS7m74xCNWaJW9vmXuUjA?=
 =?us-ascii?Q?QdBNfFtEvfMFsa4gJj8WwjqARJSyKNn67yuCx4U4E/Q92DVebm3YM71Fyh7n?=
 =?us-ascii?Q?MEtDPNK+IeVX7ea19Rl11XEtQ5rboWNb2UQ5lHHshGVkzGUId8DczdQtSANg?=
 =?us-ascii?Q?42nIx0a/OQQcjdYm6B2avzYB2ArZJ5Gu0Lzops2vwlUkG7rA+MJNA83YH7ak?=
 =?us-ascii?Q?KsVSJaid4xvbMdj+CnulunP/cjuARV7/sQqEHtaiSqOP0zNg0nJERCMI2IPY?=
 =?us-ascii?Q?R1vop30N6jMqTVq/Zkp7LrxpDgN0jYmD1zHN/5kqESWVb9buDx+JI/rFr5LC?=
 =?us-ascii?Q?c/eFWB98rEoK1xKl0tL9KJETONNOhj3vEkayrVbKpbI8tkDIvrHzBVOps3z0?=
 =?us-ascii?Q?Ocn4BqJunG51A9beta6JVczPOcRzSAyOfRH+LDwZ2h48AgdFGKf/+UcUPhSF?=
 =?us-ascii?Q?XCjPbJfrw8WOlUNzAIAXuq4Jg89o4KRf8EnJW/fxTdWvbSwmoBhBjn86tSXK?=
 =?us-ascii?Q?a15YuF+EhSbG7Ds5S4d9Bv1baO9CnTJVk+GZhDYdzoMDwElsK+ZCdJ8CoC8K?=
 =?us-ascii?Q?CitldIZcZEx0eSMi2ciMayY6+tvEVnmqwppYacvY/zJvvq+zkOWCjtIQkuJw?=
 =?us-ascii?Q?9rCqK0kxAFsWRW9aHMyOdYVFIAZe1k+RvKdCsK+ElWjkffa28nkRE9GQig4C?=
 =?us-ascii?Q?TufESQev4MOfMf0QgyT1/s9bnTX326cOQ6yaqu4TRbVlIBU63GmTzfT5cvsR?=
 =?us-ascii?Q?pfQXUmbNaAZw8Vg5dD9DVkArMbbuw93ats9B+q9bP8qHDT0sKMcky2VoAF8n?=
 =?us-ascii?Q?dLOv4dR2Rej0WAofimZKJ6e2Y+UgFWdxb+tqrwJrSxwh6z0gqc4Yug5azKkw?=
 =?us-ascii?Q?ZYwdFhvB9MF5frhXpgcBLHgpxhFFQwUFU633YWGPOs8U3SVcCDlCljwQtmNy?=
 =?us-ascii?Q?u3ZjdQkaIg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e39279e-c550-4568-0eec-08dea7c4699b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:36.1448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Icrh+UXP7LeEljLS/9inrfLY1I/l8oXAnTJeRGyg3sW5CfA/e+K44iCJ9I/Xv5fBNzVMQxFcn8l36sOHyNbJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

Allocate a single PCI MSI interrupt vector in the probe path.

Try MSI/MSI-X first. If that fails (possible in broken VFIO setups),
fall back to INTx with a dev_warn so the issue is visible in dmesg.
The allocation is devres-managed and automatically freed on unbind.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs       |  7 +++++++
 drivers/gpu/nova-core/irq.rs       | 25 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs |  1 +
 3 files changed, 33 insertions(+)
 create mode 100644 drivers/gpu/nova-core/irq.rs

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 659f6a24ee13..3ac9cb106bfd 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -11,6 +11,8 @@
     sync::Arc, //
 };
 
+use crate::irq;
+
 use crate::{
     bounded_enum,
     driver::Bar0,
@@ -293,6 +295,11 @@ pub(crate) fn new<'a>(
 
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
 
+            // Allocate a PCI interrupt vector.
+            _: {
+                let _irq_vector = irq::alloc_vector(pdev)?;
+            },
+
             bar: devres_bar,
         })
     }
diff --git a/drivers/gpu/nova-core/irq.rs b/drivers/gpu/nova-core/irq.rs
new file mode 100644
index 000000000000..3a2a40519f11
--- /dev/null
+++ b/drivers/gpu/nova-core/irq.rs
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    device::Bound,
+    pci::{
+        self,
+        IrqType,
+        IrqTypes, //
+    },
+    prelude::*,
+};
+
+pub(crate) fn alloc_vector(pdev: &pci::Device<Bound>) -> Result<pci::IrqVector<'_>> {
+    let msi_types = IrqTypes::default().with(IrqType::Msi).with(IrqType::MsiX);
+
+    let irq_vectors = match pdev.alloc_irq_vectors(1, 1, msi_types) {
+        Ok(vecs) => vecs,
+        Err(_) => {
+            dev_warn!(pdev.as_ref(), "MSI not available, falling back to INTx\n");
+            pdev.alloc_irq_vectors(1, 1, IrqTypes::default().with(IrqType::Intx))?
+        }
+    };
+
+    Ok(*irq_vectors.start())
+}
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 3a609f6937e4..837aa2d36a0e 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -19,6 +19,7 @@
 mod firmware;
 mod gpu;
 mod gsp;
+mod irq;
 #[macro_use]
 mod num;
 mod regs;
-- 
2.34.1

