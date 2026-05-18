Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F7BCD4F59
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBBC310E99D;
	Mon, 18 May 2026 18:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LArRec/p";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E3210E999
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:12:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/zhsBmySmSVmO6d+ITWDQUiVdY7I68XT56b6hKcddWBSag7PTltH2HbnPj6EhVXtN3++aNpb4PHXIvKdiNzJ0fuE+YHSHRe813zQ0Gl4faYg0sr2Y1Lzibhgu+7wRdNkhp9H5khOZ/g0bhpTNt4tUBtUcGs6RFLcrj1qVO9PRi7HxJmSaSBL0El1BiYfmNRviXVp5y4PLKhXJDJqia9hEQ6Qaq6wDuM/ta7Hfoe5Cr2avETWJxA0HKpt6EO5p9tSRJOeHT2Q/SdhLbBK8dmDLE/pLi2oLqIos6GCKlKBPSbf3dPHhmTC8FTNx8u3GPQ6Z5PuzTUuqLgdo1jL1U5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcajHinAfOnrwgy5k1yFRXYJ27gSReEHjCYtZpcCeLw=;
 b=XkicLDzjpiuB3hJ6Dt1obvnMKvU8cusp3oCMCKMquQmsjM4bsT5xtIDNrJmvR0tchyCsY1yGIXWtWysLY4utuWkGsuWnK7WscrqpThUpmTKILHuf9TWmsLVPjBkCKAg4IqZ6jZ4RIzB8zHE9cF/zU4cDaEG4ExQgYbjkFnzLKrzXVFEY49qrOocqsOMiqnPWA1ByrL1pZxJ01J+am0Un+OEYpbnOXFUibY7sBymcv4JEseuEErYcWmnwttheDGZQKRylz8KFpKrHyYRc78SkZ5DZ3y2b1M3eDS3aXKUlBKFjJrHAtN22Te4gPZkLGJk/RpJ+WCOQps5COOwkoa2XlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcajHinAfOnrwgy5k1yFRXYJ27gSReEHjCYtZpcCeLw=;
 b=LArRec/pRKhBnz6UC+rmAoGafgJCkNQqaOrbmKxVaq5v5+xHQu377dd5RSwV0IbqNqZIokvFFFPGfnGl67PyzS7C1dR4w6cyq7C5PUhmaRJkgAObk749tik/9PJbwyAveVgTG2pSIRHDJWPvFH2DtDXL4r/a2GRGi/1shsxqB9FiiUgPeTVzNDtCub0SfuuRJCwN/8YYEKCWLg7ohy5SAv4siD8yDa/guM7gNqDJAfhvp7rCU6Woz6g2omogeAeGIrpxAkpU+r003Q2Kz4x7dac+CzlNnkuctFN1emyRpSOrd2mGGwTCuAeGuAf249Za93aDnSQ5xPBuyOBWN189Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:11:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:11:53 +0000
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
Subject: [PATCH v1 14/16] gpu: nova-core: Add BAR1 aperture type and size
 constant
Date: Mon, 18 May 2026 14:11:23 -0400
Message-Id: <20260518181126.2493572-15-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518181126.2493572-1-joelagnelf@nvidia.com>
References: <20260518181126.2493572-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 29722ee5-4a47-4ced-559e-08deb508ef7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|11063799003|22082099003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: uwonbllLSrP1fkqEO0mZgyiX2q86IsllNP0Lq/kdpfVt1Aa1gR04ARhRjj+3CdYdU2rkpLA1kJCWwDiqCeWMbdWqc6xs3vmKvpOwUCgki66oM9ji9Io5RJvWen9HfQ9+PMk/T4nWuYKSKSDA3ZyUuYc6HYrghYKl2/Rhl/iqsKT55Fq3/QPtextJRSTBPIXwJpisPErDnb2PTVROW1ZBNjFbWG+dEH6hFJemT347IgF4FGISquBvUw4sJMNULA7e6zexzMp+zROuwpNWR21kaYFAyZaP3M6oH+MwsPKKis37PMg5irPJsg7PjzrY9VBXK2M13b4VbOK/DnqvT3l7PFqH98LEzzuZlb7+RvFaCiPHTFuv2ZDCbBZBGeeUkb/Kb2z0dVQMjjPmW6iun5olswIsag30Gn4OrNg5lHzyq+WmDrGWvNODM4yr5njxtetnMphdimZjNJwW8+X12h6VIdwY6QodKggO/qA7XIslCKSpHaN4gP8FBVOWzVzdi4UO4KSsGLLHqzlCNkjF5cn2j25e4mr61PyCa2ct8QXmpmZzRmxaVwYk8ob8iomgNgz5RB/TCdBMfkb/V71KW1CGxZwB9EnvkJ9XIuNTExCedBlScf3OzITcAS0Y83zGV6oHoVar3688yr7AvSna/3wtpYtK1KuST/uU3fp869ncD9rGyYjOmf5RkDEGUlxsWn4T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(22082099003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmhdPCmmPaYezkypZv1nLeB7eIz916MJbHIim9VhH9GQuvz0Q/jZKn34QTvP?=
 =?us-ascii?Q?eJs+PzMoKAVhfS+cRGhj9TFsscSijtdafP8vEKPbI8bYyhFLezjqgnQN0p9g?=
 =?us-ascii?Q?6MJ+9VGR9dVg6dlmfJ0U/Z/ajyxrYF5vvRIvgatTd4QsNqLDDE3hUIMFMlaB?=
 =?us-ascii?Q?sk/LzlAGKr3Yb8kZgzW4fOjABcjZM9XSL7XXSVCcVqQFRKDPeKQztugMsB9w?=
 =?us-ascii?Q?q4YXvyKN7zKYew0BRgn3QHP4eE7evjOAPYekH90AVeawixRxgZIGol1Suu4G?=
 =?us-ascii?Q?kSd88x8agb0nVWQ09kRynFVW8kv7LRRXiiSREHK+ot0afARLh2WbGXgVhX0Y?=
 =?us-ascii?Q?cchFVYjmYgeEHu1pKo/1UtP17gac/J4iSfyXNIY7wxD23a8XbaMKnjzSL5MP?=
 =?us-ascii?Q?hAX6K/LWipZozn//qtSkWiTADIenW7JacTqyuXE8O2LBxWJpHcAPTULdd72P?=
 =?us-ascii?Q?y6yRxk64Xig53ODDVERGq1J9MzTJD9jvLhJv79v/ymyZ5t8BECIv4GWFXeZH?=
 =?us-ascii?Q?RwOFOGnRwGkTxcg9pYBtJcdLPeg8jmRncS0uxS5srWKPK1KHbF/bO4FsjgOO?=
 =?us-ascii?Q?+C29IV+eVpj0J0dNzaHwNnPWUy1ZlXyIE2/jG3uoiwcDKThBt2OezAyfmPOb?=
 =?us-ascii?Q?37qkFO1nHKKYtJ/Rg7zwDMLQkQUPTwr0G5EQo1s9nbjc86A3ud73BFbWTpu+?=
 =?us-ascii?Q?c8cOjuLrgmCij9QbF17Vgxk8jOM5szTq5+Dbnn46wDUQMxxnNuFuJjLvq88m?=
 =?us-ascii?Q?bqFGAOAJXHdlbgpvWf8n0qeQHeqUsJFaO52nSzwmIZlxPfmPKiP9RFL0wVT7?=
 =?us-ascii?Q?4gDr/rDc1Zmjv88d+RSaI0tAJBaAGa78vw9KfRCevl44q9Y34DPr+7lWbCdN?=
 =?us-ascii?Q?4pKDX+U/3bHbtAMyrnDpJtxpeIZMVbEzoSJtqvxPelF77vrJ0LVf2qhJL0Q6?=
 =?us-ascii?Q?mHkIZMf65vD7OeZ7Z1PNyQ+16H73VT//elkOVZ6ZKapXtuAsfNWRnXMrTU9/?=
 =?us-ascii?Q?0HTWOmVdNANczuqczAduG0cO4wyR/vB+RCY63iZK8UNwEfwDOtpHHXoE9d84?=
 =?us-ascii?Q?71bf3oCTym+96uxn9SOy+gThulDwK3QAwY70esIwPU/6R6I5+qAy2h1i1g6G?=
 =?us-ascii?Q?3hj+yvplKbD+SpXEX2iNRdT4hK5I3/eLaN8uCq43larEjm6XBkPrCd4PkNlA?=
 =?us-ascii?Q?UL5uDyG82CsZtVdjWqKY6DVZdaD6hpufVCfrzqzM1vx6yFZYLspcT5oXJ0iu?=
 =?us-ascii?Q?4IB5k713q8tlKImWyFK3Kuak0aIV9UToTdS/UOoXp4aCwCbqZu3YKjIpitM/?=
 =?us-ascii?Q?zQqKRh2J60FCS4O7jnYalwfBji1SNSMbaQQHsCBex34yq9DghddGZM1KYOaP?=
 =?us-ascii?Q?osJPqzjJBIsfEx77sS/een1MdahEHIpsSGwsHxFgPsywF6Clhdfs1XBAuiKs?=
 =?us-ascii?Q?J6rf/5zZRwSWgKAyLUNt5wWpXIkKJyLbUhYbtFp6x+omVhA4wJFuwT0vLpqq?=
 =?us-ascii?Q?SbicXZIGwxtjEOfHgxBgLBRQVZlXFjwJRQwdglMQdhQ//axrioCNSCgIOn8a?=
 =?us-ascii?Q?X953FOv8WeNKnES8cfEwMzJ3OrEarbKOahtr0PPK8SxniFlpL/ptLosIPgTm?=
 =?us-ascii?Q?X1k0SRnpdqHXGB6iNX5/GhbADFGJ701TsyXAljEWlHH0i4rmIP/VEVF3zl8W?=
 =?us-ascii?Q?kymjjV7dR9iyZWs0AHR/acJ7PFFqwWMLqBTRkpqQ7/WfXNbnuCCQixjbeFJg?=
 =?us-ascii?Q?TYQ8a+v/xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29722ee5-4a47-4ced-559e-08deb508ef7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:11:51.6670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UrA5dCe/nZHTtphY9SEKAlFVyz0skIJWIPTVGeZgSpLk9Oj+Ar9/msBoCBk2WofsVC5gWNxfZx9EGt270M4Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

Add BAR1_SIZE constant and Bar1 type alias for the 256MB BAR1 aperture.
These are prerequisites for BAR1 memory access functionality.

Co-developed-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs          | 2 ++
 drivers/gpu/nova-core/gsp/commands.rs    | 4 ++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 77746d6949d7..b14d4b599783 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -47,6 +47,8 @@ pub(crate) struct NovaCore {
 const GPU_DMA_BITS: u32 = 47;
 
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+#[expect(dead_code)]
+pub(crate) type Bar1 = pci::Bar;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 5abd7950320b..bee7539eff60 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -193,6 +193,9 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    /// BAR1 Page Directory Entry base address.
+    #[expect(dead_code)]
+    pub(crate) bar1_pde_base: u64,
     /// Usable FB (VRAM) region for driver memory allocation.
     pub(crate) usable_fb_region: Range<u64>,
     /// End of VRAM.
@@ -212,6 +215,7 @@ fn read(
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            bar1_pde_base: msg.bar1_pde_base(),
             usable_fb_region: msg.usable_fb_regions_iter().next().ok_or(ENODEV)?,
             total_fb_end,
         })
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index ea663079d95c..13418b494a73 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -127,6 +127,14 @@ impl GspStaticConfigInfo {
         self.0.gpuNameString
     }
 
+    /// Returns the BAR1 Page Directory Entry base address.
+    ///
+    /// This is the root page table address for BAR1 virtual memory,
+    /// set up by GSP-RM firmware.
+    pub(crate) fn bar1_pde_base(&self) -> u64 {
+        self.0.bar1PdeBase
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,
-- 
2.34.1

