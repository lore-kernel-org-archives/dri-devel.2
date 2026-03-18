Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C80CFCD0A5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 04:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFF210E727;
	Wed, 18 Mar 2026 04:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IPPvaVml";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6FF10E727
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 04:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN1wRj69YXqyjQNiq2sq7cYOe30f7MKE4AcaeXmKLL34xY1fZKhdoL717566ikgU9Yoy8x0cRnNx27yTQvdD7HM/StnalOEKwvfQkSK+KobCt4Xu40KDdx3cGJbGbVVzSxT1sWcypxdFkp2qmBZpI4wkgfidaGFQ3CokVM2gOzTtsSmEvfwkbn24+m2lnRn2JkMdbtNrQ3QKaMU3XsIn7YZUoNJKKDzCiR0ygEs7GqP96qwEn/Agona0yx5j0v9WiwzaM+YyZ9Kpka6J/8dt1JazP4Cf54lY0vRtb3KfTzNY4PBf4adrz20YEfxmhwlZM09x+Xr0DCZ1oQLSkmjgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCflqQ8axjf2AKMeHhEGLdUe2L8rRz6OxxPqSRfYoQQ=;
 b=YOvy9QMlqjt3xhcLzXxYud0vca6KNJGE0wvXFdgjF4ECgXEdlX2qA9uWVyc/hIhMzKBF0M/dgl4o89o4UjRGx4kHmMjbDZiQSQKUROuzEBrY+mv74+rI5BWbBarzJ3VPvLqvqBx4hKKKJBi89nKltOyYJMPjFVN7nT0DR/JoAY0ZuDrWaqGB0t8bu7TGQfavTeD8Hzb6/4OemOrtdo8AQEjfCZ2sf20QJbvyHhaBZsi1K2D9CrWIfpFJQYDPJIS4dHM6mjvroITcAQVudMz2V5rgeYT6ORuh+k6zlqEamKJMUjEHkqUMp5kyJ4vwWw+KNuw8NsJbQcEnHPCcElU01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCflqQ8axjf2AKMeHhEGLdUe2L8rRz6OxxPqSRfYoQQ=;
 b=IPPvaVmlyTkVItmbgQhgVeeoS/jgDlOgCLYsmiic7ced7s0uTlGjdScrqFIkl/FpeJhLHHW9tAFn+eT0ud8kaYAaSTF+cTDbzusWOKgVFTPxONpc3xCSZspi2dAVVM1tihIhPLEkVh0zJPOoaREJW9RuhIiZ+ow5JwHWrC/Nj7IF9lu7mHldKfmeUhqPL8drSxmbSp4IY+G336vjpFsXHbBCmOWFhhfsj9FCUKHug5SSodWtC6ow9qMoARn7lp2AfDhEBxKhGv4kka4cbY/qu5/PiRYTarkvrdZFkmyf3nWW/g9aZRLfnE1TTmSVjC4dA9rkQSE/XapqInCp+tkoCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 04:07:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 04:07:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 13:07:13 +0900
Subject: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
In-Reply-To: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0316.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 93513646-fb14-4433-4c92-08de84a3ee7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A12IX1lc8M6oxq2RMwIoov0d0r6gKODERmBWnUGOiuB97Vh1RIVUtpy2jrKWu8OdD5BzAlYl1Jozan+GvAUXzsg8FgQ9QtHQ6iOIKqvKuuomLFb8mqmXc89EHTEz03P7EInAZEv5U31Vi7TyeYlziAPqp1YOOO4fp4mQFhjeRslsyH9CoZ0EQZVlgYI3dlHt9ZqkJ5lzEegs3PDruvide4QcFqDayvpp8CWs/FexbMhNO3W+cx5oGZdYS1/E3F0FAMu70psYUQGZPlZKiRVcYCAVwqLScoqYMKE9cPSnw+GuMeD7DTEuM5uopukcN1sTLwT8j5RUDI808Svx114tsL7MX1FTtxgIpBmDy3jwM0crU6P081TMHPUCmBUlfnn8lFNhmUJTrzsU1fJwNwntZLd7kS1G34HysKoyCqjVR2sLihirLD91PZbGwV08ff0fYfLjHyhJlhMVZlT9tk0l5Z2z4Qp6Ef4r23HMY+6iZCWb5xpGhDtt1ciAgVXht7VWtWjoR0XphTeuDIGk0yU6tC/7XKr9yXdHI/zCjyxoAn3xNmuZZ7zeLf6WH+jvL5rX7bWYkV3t/C/jEWYXFkmFpukKDJcIf88eLOuDTxx59Nzc+PYE6eZdbiw5I3F7eAltJ9qcHWn1A/c6NyAMIv24BFRgEc6cF8JfX/k5lqhApTYqcxPrVWiAvz0Xc+cErXXpdfT0yWGxIKW4YSe1F/mN4UuBURO6KL+nn6GtHknmkJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpVLzUxT3V4VmVPcGJyY0w4VmhKZFM3bkQwNGJiUUd2SDdicGJXUktkWE5E?=
 =?utf-8?B?WnJlMUVkbXF1Ti92NnZNK2diZTIyNU84Ri9VdEZjNnBwMFhTV1hiWTZheGZK?=
 =?utf-8?B?SC9Ka0lNSFgwZUVCL3BCb1VrRmFLdDk5OXBCU1JpQVBYbUQ2b1BYaWZLZ3p2?=
 =?utf-8?B?a3pKS0tkMU01bFJXaG1mM01sQzUrbnB5RHhZZDQ0SWVEZ1R4ZkhYMFhLVFl0?=
 =?utf-8?B?QjJLWVVEb0o5cmZ2ZWx1ZXU4c2pYaDc5Uy9YVUVQVkcyWHowRElKQmtBZFdz?=
 =?utf-8?B?bzVVUlVZOEdCeGdkcDZTY1Z3UmZUcm9jaUV4U01zNysreTVqRm5pbHRwV2JF?=
 =?utf-8?B?alJuUnBhNEdVdEJGbGk3ZjVTTXdiTUlLM0FuL3BYTGdnQnc1VjZWM3V4L0Rp?=
 =?utf-8?B?NlhzTlhKWU1EY3dRZ1ltbmN1ZkFva3NBNmJjZ3NqTytPd3ZHeGxVY1E3WUls?=
 =?utf-8?B?NU9YZzlTelpqbXpBZkZGcG9wWjNWS2Y3OTVYUFFkUDluOUUxTFVCa0l2Zlpy?=
 =?utf-8?B?bXNIVkhJRTA4VENpd0dpbzdmSDlhOFc4ZWpCUE8rcFM1TExPeVFqRTl4N09I?=
 =?utf-8?B?ZzVhK1RSWmRNVUpoRnlaQlFHMVRUUDQ5emdCZm16emZBcFNWNW9IZkV3WnBB?=
 =?utf-8?B?MHFqZnJDZHBsdmZ1V2RMRTlqd2tISkUzWDBjUkVwS3BSRDhxSkhiaTZ4cHJT?=
 =?utf-8?B?WWlRYkdVejJpeFlkNE0zSE1aUE1NWjZLQktTUzVsQ3pabmxJeDl0Z05DWDNC?=
 =?utf-8?B?STF2ZTVPSWRuUytSZXBuVGY4blRrTzJTekFseVlRRTFVWGlZYzFzQkxxc01Z?=
 =?utf-8?B?Smp5N3YxSWVUWkppL0lRQnh3S0U4SkVwdGsrUHFlOXd6Y1pQLzFOc0lRZHgr?=
 =?utf-8?B?TVdMaGFJUWZGcUVhVEJqS3RmckNCa0RSYk91Z3pGTm9WYlV3TmtKWUNPaWhM?=
 =?utf-8?B?Q1JUVjI1b2ZTTlROSEdoTHl1Z2phM3A5c01OeE9UM1VqcXFqWkh6b3EwVWEv?=
 =?utf-8?B?VENHNXlWQzVZc2k4aGNOK2tTdUdTTlMzd2tybkV6NUI0bTdnNWZIWmVBeFNL?=
 =?utf-8?B?OTdWeVNrT3pxelEydGV5RmM0b3JJWU80ZEhhYTRjMXZhemxnd1RRWldBL291?=
 =?utf-8?B?YkZDU09ZbjZRS3pOblN4RWVRcTBnRXo5S0kwMU9JaWUyVU9vMktDL3RuOUhn?=
 =?utf-8?B?UGo5cEpUTlJ3VXFxMjdiWFVxWmRTTktwd0FUMHFqOXFiRmxxOWVTa25Pc3JC?=
 =?utf-8?B?SjQrdUkzUWczTlFPa1NpZ3orTVFLVDl4dnFYVlI0SkVoSmZNcklBM0FMbDN1?=
 =?utf-8?B?cHZEbTYrZkM5eVZzWnN1ZTZrbXNNRVZEYm1peVhjRFBvdEp6L1hlb1dsU3Vo?=
 =?utf-8?B?Q1pIYWpVM0FRNWpqNkU1SG01a2RZcTQ4NVNYWTNrcnRQMkJHYmJvUWd2Y0Js?=
 =?utf-8?B?L0RNR3NSRnZJK0dPWTl0UTZuNFB6UURiYWhpYk5yRU5tSC9qNll2elZsTHQz?=
 =?utf-8?B?cDJYRmg2QWRmSlNmOHllNkFybE5RVTRpTFpHNitKQk1WVmdkM2RiYkFkYWky?=
 =?utf-8?B?UVJlYmRIWXowa2wyMVhBNHNLbS96QW1nakxmT3cwS1VBZlJIWGQzU1pncUdz?=
 =?utf-8?B?TEV2dXJaZGx0a2xlTEJVTDMzZVpwcVVnRHRZTFBsUGg1QURFdnlFYk9MblE1?=
 =?utf-8?B?NnB5NmZ4b1d3U1lIYVJ6VmRrN3N0VERISTErSUxZUTdvblB0MGRQUm51bytn?=
 =?utf-8?B?VUJLMXd2TzJMbVpVYkJQOXdrdUpzVkgrWGZJeTdNRmIzRGFWOEE0WDErejc2?=
 =?utf-8?B?dlVqdVlQcnRsUFhlRDFSZ05qNW9mSk1Cb1Q2N3gyeW1SNk1vYVJoV01PVGdI?=
 =?utf-8?B?ZVhLVUZ5K2dBTlM0Yko2Rnh6RDkzK0Zac1l4L3g4cUNjdGF5ckZLc1ZrMEFS?=
 =?utf-8?B?U0N4YTQ3Z3FwOCtHclI0ZTRpV3VYNUk2SWY0ZlVCaWc3RENrQndxV2NDZmV1?=
 =?utf-8?B?ZDlzbGFWSzhkbGhSWjJhY0ZQL0liaU9GQXNtQWJ5dUNRR05oVkdiL2JDV2l1?=
 =?utf-8?B?RHZkUXZ3ZE9QbXUvWUVTS2xDU2FVZHpQVkM5N1IyS2lGaDNrY2JVSS9QVTg2?=
 =?utf-8?B?ZnIzcFhJazFMRER5YTJHRjQxTitsOTVuRmU2WEdEeDhYUmtyNWZwK1o1LzYw?=
 =?utf-8?B?QnViZFoyZU9LTVBZSjFsblVjYlA0Vld6ZHRPb3VMMGt3cjNZTWYzR2hodith?=
 =?utf-8?B?akVGZjNxcTBDeGxSUnFUNUN4SzY0dUJ4VC81ekw2VWxGTWF4UEQ5M1ZObkF0?=
 =?utf-8?B?dThLNmhRcFI2TjVKTXdOV3B1dld0T0N4aVd4Z2Z3dUoyYUw1SlN3cU9GYmI2?=
 =?utf-8?Q?y6zjbJOYGDyUZRbjFgARhq4w+gll8k88DeIvQpQLjh3uB?=
X-MS-Exchange-AntiSpam-MessageData-1: Au8WngoquzT0aw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93513646-fb14-4433-4c92-08de84a3ee7a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:07:55.1269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf7i9+6wo0iuIeSjwBiCDsxaZXdkKoG1INwzy4eP46aV1LVYixFpsUGaNcOBs4tk3yY8tFdQ7pyrhZKTCVrDJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

Wrap `Cmdq`'s mutable state in a new struct `CmdqInner` and wrap that in
a Mutex. This lets `Cmdq` methods take &self instead of &mut self, which
lets required commands be sent e.g. while unloading the driver.

The mutex is held over both send and receive in `send_command` to make
sure that it doesn't get the reply of some other command that could have
been sent just beforehand.

Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Tested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      |   8 +-
 drivers/gpu/nova-core/gsp/cmdq.rs      | 170 +++++++++++++++++++--------------
 drivers/gpu/nova-core/gsp/commands.rs  |   4 +-
 drivers/gpu/nova-core/gsp/sequencer.rs |   2 +-
 4 files changed, 107 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index ffc478b33640..5e73bd769dcc 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -137,7 +137,7 @@ fn run_fwsec_frts(
     ///
     /// Upon return, the GSP is up and running, and its runtime object given as return value.
     pub(crate) fn boot(
-        mut self: Pin<&mut Self>,
+        self: Pin<&mut Self>,
         pdev: &pci::Device<device::Bound>,
         bar: &Bar0,
         chipset: Chipset,
@@ -223,13 +223,13 @@ pub(crate) fn boot(
             dev: pdev.as_ref().into(),
             bar,
         };
-        GspSequencer::run(&mut self.cmdq, seq_params)?;
+        GspSequencer::run(&self.cmdq, seq_params)?;
 
         // Wait until GSP is fully initialized.
-        commands::wait_gsp_init_done(&mut self.cmdq)?;
+        commands::wait_gsp_init_done(&self.cmdq)?;
 
         // Obtain and display basic GPU information.
-        let info = commands::get_gsp_info(&mut self.cmdq, bar)?;
+        let info = commands::get_gsp_info(&self.cmdq, bar)?;
         match info.gpu_name() {
             Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 86ff9a3d1732..d36a62ba1c60 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -12,8 +12,12 @@
     },
     dma_write,
     io::poll::read_poll_timeout,
+    new_mutex,
     prelude::*,
-    sync::aref::ARef,
+    sync::{
+        aref::ARef,
+        Mutex, //
+    },
     time::Delta,
     transmute::{
         AsBytes,
@@ -448,12 +452,9 @@ struct GspMessage<'a> {
 /// area.
 #[pin_data]
 pub(crate) struct Cmdq {
-    /// Device this command queue belongs to.
-    dev: ARef<device::Device>,
-    /// Current command sequence number.
-    seq: u32,
-    /// Memory area shared with the GSP for communicating commands and messages.
-    gsp_mem: DmaGspMem,
+    /// Inner mutex-protected state.
+    #[pin]
+    inner: Mutex<CmdqInner>,
 }
 
 impl Cmdq {
@@ -473,18 +474,17 @@ impl Cmdq {
     /// Number of page table entries for the GSP shared region.
     pub(crate) const NUM_PTES: usize = size_of::<GspMem>() >> GSP_PAGE_SHIFT;
 
-    /// Timeout for waiting for space on the command queue.
-    const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
-
     /// Default timeout for receiving a message from the GSP.
     pub(super) const RECEIVE_TIMEOUT: Delta = Delta::from_secs(5);
 
     /// Creates a new command queue for `dev`.
     pub(crate) fn new(dev: &device::Device<device::Bound>) -> impl PinInit<Self, Error> + '_ {
         try_pin_init!(Self {
-            gsp_mem: DmaGspMem::new(dev)?,
-            dev: dev.into(),
-            seq: 0,
+            inner <- new_mutex!(CmdqInner {
+                dev: dev.into(),
+                gsp_mem: DmaGspMem::new(dev)?,
+                seq: 0,
+            }),
         })
     }
 
@@ -508,6 +508,89 @@ fn notify_gsp(bar: &Bar0) {
             .write(bar);
     }
 
+    /// Sends `command` to the GSP and waits for the reply.
+    ///
+    /// Messages with non-matching function codes are silently consumed until the expected reply
+    /// arrives.
+    ///
+    /// The queue is locked for the entire send+receive cycle to ensure that no other command can
+    /// be interleaved.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply is
+    ///   not received within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command and reply initializers are propagated as-is.
+    pub(crate) fn send_command<M>(&self, bar: &Bar0, command: M) -> Result<M::Reply>
+    where
+        M: CommandToGsp,
+        M::Reply: MessageFromGsp,
+        Error: From<M::InitError>,
+        Error: From<<M::Reply as MessageFromGsp>::InitError>,
+    {
+        let mut inner = self.inner.lock();
+        inner.send_command(bar, command)?;
+
+        loop {
+            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
+                Ok(reply) => break Ok(reply),
+                Err(ERANGE) => continue,
+                Err(e) => break Err(e),
+            }
+        }
+    }
+
+    /// Sends `command` to the GSP without waiting for a reply.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if space does not become available within the timeout.
+    /// - `EIO` if the variable payload requested by the command has not been entirely
+    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    ///
+    /// Error codes returned by the command initializers are propagated as-is.
+    pub(crate) fn send_command_no_wait<M>(&self, bar: &Bar0, command: M) -> Result
+    where
+        M: CommandToGsp<Reply = NoReply>,
+        Error: From<M::InitError>,
+    {
+        self.inner.lock().send_command(bar, command)
+    }
+
+    /// Receive a message from the GSP.
+    ///
+    /// See [`CmdqInner::receive_msg`] for details.
+    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        self.inner.lock().receive_msg(timeout)
+    }
+
+    /// Returns the DMA handle of the command queue's shared memory region.
+    pub(crate) fn dma_handle(&self) -> DmaAddress {
+        self.inner.lock().gsp_mem.0.dma_handle()
+    }
+}
+
+/// Inner mutex protected state of [`Cmdq`].
+struct CmdqInner {
+    /// Device this command queue belongs to.
+    dev: ARef<device::Device>,
+    /// Current command sequence number.
+    seq: u32,
+    /// Memory area shared with the GSP for communicating commands and messages.
+    gsp_mem: DmaGspMem,
+}
+
+impl CmdqInner {
+    /// Timeout for waiting for space on the command queue.
+    const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
+
     /// Sends `command` to the GSP, without splitting it.
     ///
     /// # Errors
@@ -588,7 +671,7 @@ fn send_single_command<M>(&mut self, bar: &Bar0, command: M) -> Result
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command_internal<M>(&mut self, bar: &Bar0, command: M) -> Result
+    fn send_command<M>(&mut self, bar: &Bar0, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
@@ -608,54 +691,6 @@ fn send_command_internal<M>(&mut self, bar: &Bar0, command: M) -> Result
         }
     }
 
-    /// Sends `command` to the GSP and waits for the reply.
-    ///
-    /// Messages with non-matching function codes are silently consumed until the expected reply
-    /// arrives.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply is
-    ///   not received within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
-    ///
-    /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&mut self, bar: &Bar0, command: M) -> Result<M::Reply>
-    where
-        M: CommandToGsp,
-        M::Reply: MessageFromGsp,
-        Error: From<M::InitError>,
-        Error: From<<M::Reply as MessageFromGsp>::InitError>,
-    {
-        self.send_command_internal(bar, command)?;
-
-        loop {
-            match self.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
-                Ok(reply) => break Ok(reply),
-                Err(ERANGE) => continue,
-                Err(e) => break Err(e),
-            }
-        }
-    }
-
-    /// Sends `command` to the GSP without waiting for a reply.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
-    ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command_no_wait<M>(&mut self, bar: &Bar0, command: M) -> Result
-    where
-        M: CommandToGsp<Reply = NoReply>,
-        Error: From<M::InitError>,
-    {
-        self.send_command_internal(bar, command)
-    }
-
     /// Wait for a message to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
@@ -691,7 +726,7 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
 
         dev_dbg!(
-            self.dev,
+            &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
             header.sequence(),
             header.function(),
@@ -726,7 +761,7 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         ])) != 0
         {
             dev_err!(
-                self.dev,
+                &self.dev,
                 "GSP RPC: receive: Call {} - bad checksum\n",
                 header.sequence()
             );
@@ -755,7 +790,7 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
     /// - `ERANGE` if the message had a recognized but non-matching function code.
     ///
     /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
+    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
@@ -791,9 +826,4 @@ pub(crate) fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Resul
 
         result
     }
-
-    /// Returns the DMA handle of the command queue's shared memory region.
-    pub(crate) fn dma_handle(&self) -> DmaAddress {
-        self.gsp_mem.0.dma_handle()
-    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 77054c92fcc2..c89c7b57a751 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -165,7 +165,7 @@ fn read(
 }
 
 /// Waits for GSP initialization to complete.
-pub(crate) fn wait_gsp_init_done(cmdq: &mut Cmdq) -> Result {
+pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
     loop {
         match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
             Ok(_) => break Ok(()),
@@ -234,6 +234,6 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
 }
 
 /// Send the [`GetGspInfo`] command and awaits for its reply.
-pub(crate) fn get_gsp_info(cmdq: &mut Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
+pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
     cmdq.send_command(bar, GetGspStaticInfo)
 }
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index ce2b3bb05d22..474e4c8021db 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -356,7 +356,7 @@ pub(crate) struct GspSequencerParams<'a> {
 }
 
 impl<'a> GspSequencer<'a> {
-    pub(crate) fn run(cmdq: &mut Cmdq, params: GspSequencerParams<'a>) -> Result {
+    pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
         let seq_info = loop {
             match cmdq.receive_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
                 Ok(seq_info) => break seq_info,

-- 
2.53.0

