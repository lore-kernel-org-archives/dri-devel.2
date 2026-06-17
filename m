Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED76CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BF810EA23;
	Wed, 17 Jun 2026 14:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lrhl6xuZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E7410EA23
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAPp+pd0Lpkr908oh9hWyhOVX9dcUI4649OcqmXGAj6XMjGWPNcycn//oUCauZnZq4VcdewaREyDQ9vw9uRsXFEXqxBHCXJVEeRU5j5wB/EsR0FYkYC4wbJWzUwr7xjtb3wXwdnBWigcxu14V3FHAKd4QILxkTb7f2ZPbrwFhkDvdgwungvBiPR+GaERXNG1KLq5bs6gpIc0um2C6I4Xg7TlHE09ybgk9Vh2OyPAjivcHCwCS46pMEapRWRD5BlKC6R/ATEbqg797HczDWYV//Xgd5A6RS35kup4ZzJQew0CPcU5qaJl+Z5x4LKNzqCnmbYbMKyyhWk9P8Cjt54Uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3UL7PCGofsunCObr4Mn7o1sNrzibkqDOJyLroGfnyU=;
 b=rsrPXnf3wFpdYWZviYn4Cl7RGwEiJ4oFmDlRr7ucXfgxvley07iqZkUnorYRW4RdkLek1J8QAC3b1qMWIlXZCZP1XNjVUAIWelguCSQQYrZHlM1/A/AFKMHAPZ1nxrxvvHs+aXvnmZuFTitY4txlg1ZzIZm+cJPlNlFjx7C01V/mbCNCGuj6hZni7OSRnYZJV7mmwNu/8lwuBjrunNqG5D/xA1JphmTjHcL2Ccf1ZbUIp/wWhkqFl66LHDcmhLJ3QQFLyqE8+2G6bzQhtsJw80NuGWIQZa7WOaABfOBkr18eGvXio9Fd7ZWcCHnirXyVTvDwJRoxozlzsrsvCeTpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3UL7PCGofsunCObr4Mn7o1sNrzibkqDOJyLroGfnyU=;
 b=Lrhl6xuZPGzT221RL1GJLyXp0o1oOnKuO2X4nTLGlx1G5nkwKoBBp5KFcXw302MVYlLe5HhH5m0+ntMYvuilAcTsXhLyJeGckWsGgUcriscdM/sTHOJrEhbIC8qIivC4q/3ncfNiRugX9aDhy1NxMM+C/D7s4PoZJsH5lsSHh9kgEA6/qdlParPgywV5Vi6DiafUy5PPAPmoNUZ0lft8IjxA7IBrHPJKIgD1tDwFpHPHCUc67BvRKstaTa48LvWUCS9SobStm2Kespeo07yKcVtciK2GY0UoAZD2UddLgJIvH66WU54r9F9yBphrple+gQEF0p3guu1mZXOH06nfig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 14:03:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:03:05 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 23:02:33 +0900
Subject: [PATCH 1/2] gpu: nova-core: convert to kernel bitfield macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-nova-bitfield-v1-1-ec10c6772666@nvidia.com>
References: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
In-Reply-To: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bccf4c-6a25-4b15-c56a-08decc7926d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|10070799003|1800799024|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iWEzBUbAeoGTeAwRnzu5aC63BAB7YnI3DIcz1lW3dvsUfl/FItRDBm4d5VRahQhs+EaOLvnoD6DfLHAFYChAHAOrmrGU/5PoGNT8jEBT030uEIH1Ok/4S6ByWNGqKfgz2JpkVC+8c1q4FCETC9R6nPwwnbzOK7bUqTQRVcTMQQ/72Aoz4I9ZbyM39XPYbuYvFAiDo7EHprMH2WdUWeag5G0pe6q2KekET3hpyzzd5AVQoKnu2rd539EZn936H9CCyk6K/o2Olro0gKfXQG/YHxxgaAcg48YYbzmdvgenKs+Z+lxTF/1rCHlVYZNqhn4i0uqfcgntJSEF/5RMSJ/fzi0ZUyC4TbtzCnQUOhFSh9tchxNxrbabSsEAiNjGEbTDZvG7YHUZvxaW/nz7WQ8Z8IfDjlQEGXnE+CByAi17yIi4eLbezeAvK14oT+L1hRxTBJsB5Xvh3sXSZK4KCpyCV7PRpTR2PJaMH6JJCw2sCrhISMmA0pBzqKqA9ve6o0LTeL8RZGmMBgTSm4X9s4AeHnd1FbQhkT3BbQfPGXBMW3fUPzuPZIFoCTQhmgY7LPwoHCZlevJnzzFI1J5NgQ6XqilY013dqzUGV87xMARw4GX1YEe/ZniZ8tv8UwM10ecbYglNPkFZOox9A0U3caOlCYfszMQMCslayWGsXZAwxsxtPvElOZlWrfIo2YskGP6pFgcb/+AxgQmWQ+eG6NuKU1ZDP3hOkTEhTu5qHEPdMPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(10070799003)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0tTMTFJODg1SUl6WnlhT0NTYm93WUkrWjR5VSt2cERVVDFHcWFsWmdXeC9C?=
 =?utf-8?B?blc2Q2JHemF1SjBVTTllL05kaGh4Um1KbGRuZTljU28xb0U0NmZ6MnJDSDZJ?=
 =?utf-8?B?YVpLVERPV3ZLMkhBenkxTGFYQXB4U20weXNKWE1kT1Y2UWp3eGI0YlowMlhx?=
 =?utf-8?B?bWFINGx4Yi9aVkpKUE5SbEl6dTlpSnRnSWRDRWQ0eHlSb3YyWFZBbm9kQ0pV?=
 =?utf-8?B?eE5SK29HU1VhaVBtUlN5SzJucmsxR1hRV2Y2SWZxcmtEbzczM0NrdmNwSXVX?=
 =?utf-8?B?bldHd0czcFU5ZDVFSFBGWGRYK2pzWEptUlJac29icFI5aEFKVVhzdHlGTHZl?=
 =?utf-8?B?UVFBQW9tR015eDdTTE8zd1g5dTZXUFVGOXo0dWZBWFp6ZWNEdkw5anc3VzlE?=
 =?utf-8?B?dG1tekJqUktubXVVQmdtRnhMcExOUzltYjBkVmw0NG9VbDFFVmcrKzJmUmxR?=
 =?utf-8?B?YUVqOHJpcXV3N1JwTEErbVovZysrR1NBbWlkYnFyMnI3M2lKeENhQS9pWUI2?=
 =?utf-8?B?MGlLMDlwbWVoRHdQTHUzMkpzZkNseVpocVJuL0VLS3EydXV6ZGNmZHFMNGdh?=
 =?utf-8?B?WHFZQWh2Ym9GOWE0TFZSemUrN001aGpSWW5uY0FYZWVMdDdmd0p4SnZWZ1BD?=
 =?utf-8?B?amcvTFJhZ2d4Nm5lejVnc3pOQnphdzJNOEEzeFh3UXBrMTF2MUZDOGl4U1NO?=
 =?utf-8?B?dmdWTUdRRjJOKzRPR1NsRmNlWUU4dml0RDZ5elNLT1N3SUg5ZjZLTWIwUnQ2?=
 =?utf-8?B?WnRDdTc4NVdGSi8yazQ3OXA4OEUwVlBJVjJoSWIxQjVPZkNjUkh3bVNrNXdO?=
 =?utf-8?B?OS9VUXI2VDRaMUI1S0wxZDBhVzlJM25SejZWeEd5Rmc5d1lFTURvWmhiNXBP?=
 =?utf-8?B?dnBzVm11N1pWczBkUnVrNkJDa29RQzlGOCtUdlN5NU92bmc2ZTFjQmp6UWVh?=
 =?utf-8?B?VGY4T2hGYVVIQjc5QWQwODdheHhGZUhMRzFxY0tnOXdOMm9EbEFrbVFsNENJ?=
 =?utf-8?B?SlYvUTlRSDczbTBUbWFEeEdhMlVzZkhrcGJ0Mm1ycWdYdkhHRmVjZThRbkl3?=
 =?utf-8?B?T0E2NkhsWHM2QTJldWFOZEEvbDdRaUM3L3NuYXFIQUN6NXFFQTlCN0U2YjRw?=
 =?utf-8?B?UjFHaDVWUzhFd3lNczJheHdyVGQ4Y2hHQmpKeXk5aDVLaTRJRTE3enJwN2cx?=
 =?utf-8?B?eWJ6bmlLRTBPYXg2UWhvUjIrY29tV2VkMU16OHQwakowb3lrb3JGblJNSVRu?=
 =?utf-8?B?c3FlN3Faa2ZaVVA3NXM5anZ6dVhqWU9rS1BPNXdaQTUyQ1Q1ZHBpckJsTHJ4?=
 =?utf-8?B?ZjAveE5LUW1qMTVmVUFVYzl3MEE0SS9SMzFkSUpOYUlEanN6di9iQnM1YTRF?=
 =?utf-8?B?SFdJbDVKWUJYdGVHbG8wa0ptMzQxc3hCN0ZUQ2lSMEFXM3BybmRGQ3dqM3JU?=
 =?utf-8?B?eldrYnViamhQT3JVWFhjTDhpVmZ2NWJ2cGZkZDhQNmgzQnVsOTdSbkdoSDU3?=
 =?utf-8?B?bWs1dCtzUTUveFNnNVE1eSsyVGhaQnU2bS9LTmM3Z3c3RlJPUlZmNVBuQng5?=
 =?utf-8?B?b2NYTkVvVGRreXBoMG1ESEIrRitieVg2NE44MjdYdGhKanpQM2VGN05BTlN3?=
 =?utf-8?B?RTJ4TE8wUk0rV2VqYkhnZ1EybXJTZWZuT29Vd25SZG0rRUF4Q0V6QXdQb1R6?=
 =?utf-8?B?OVE5ekNNbEdCaDdYaUhIamhFb21WWmVhaVNGek43VXZ2L2RaV0tlMHhEUWta?=
 =?utf-8?B?dUxLdTgyd0l5S2tGS0ZvSHo5UTlBQWxlOS92RGgrVGcxL2taUUJSU2R2VjJW?=
 =?utf-8?B?KythRVM5S0YvQlZXeVh5S3JMMVVEajRLNlhoNGJSTENsLy82dXZmM2FlRGZ1?=
 =?utf-8?B?SnNyb3NFQXVyZmpmb0EwTDRQMWo0S1VQdlBlN01BN1Y5cG1YT2lNdC9BdENS?=
 =?utf-8?B?SC8vNEUyZU4wTFFycUZiVElqcUtkdW5zQnFYY0xsUGRLQ3VhTGdGTTVuYmhH?=
 =?utf-8?B?aXVVU0JkTFJVSEowL29IMXpBTXlya0NsdjFEbWZOa3htRFYvNnFFUVRxWGE0?=
 =?utf-8?B?RXVUbml4MlVLYlpjY3AvWFMzdERWSmVacHl6OUNnV0ZEeDR4YXJHbSs1Ukh5?=
 =?utf-8?B?d2NPaFcxWnZ4Q01YbDI3VGtybVllY2FuTGl5eTQrTGkxZnlobEtuemJscTha?=
 =?utf-8?B?L3I0ZjZ6aWFJTVdQcWJmOEQ3TE90Q2MvWHZTNWhveUpEc2h2RjA3ejIyY1Rx?=
 =?utf-8?B?LzIxNVZJYVJyWEY0dm5admxZVWdSQ0NwekE2VU90citrMEphK1BhQkdndGtm?=
 =?utf-8?B?N3Bkb1EwK0dwYlZjdi9pQWFzeFpJZ0tPbjRId1NhVjF3SUVKemN3MVNkaTQ5?=
 =?utf-8?Q?ADsORteGf9s2Acp0qNIEyIblCMnlRoDofG7hE62xau9Yd?=
X-MS-Exchange-AntiSpam-MessageData-1: RI4XsnXLtfFzQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bccf4c-6a25-4b15-c56a-08decc7926d8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:03:04.9823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGkzDCIix3CqLcVYgWq/4Y4Y2Zb3XM9dSUlXI/rVkJ4cMLtM7UefUnzGtOjgNJ1qrxpIkiEwarJTqzhEuVtKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

Replace uses of the Nova-local `bitfield!` macro with the kernel one.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fsp.rs       |  8 +++-
 drivers/gpu/nova-core/gsp/fw.rs    | 11 ++---
 drivers/gpu/nova-core/mctp.rs      | 86 +++++++++++++++++++-------------------
 drivers/gpu/nova-core/nova_core.rs |  3 --
 4 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index d949c03dd304..e8becf11a321 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -11,6 +11,7 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
+    num::TryIntoBounded,
     prelude::*,
     ptr::{
         Alignable,
@@ -297,7 +298,12 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device, bar: Bar0<'_>, msg: &M) ->
             return Err(EIO);
         }
 
-        if command_nvdm_type != u8::from(M::NVDM_TYPE).into() {
+        if command_nvdm_type
+            .try_into_bounded()
+            .ok_or(EINVAL)
+            .and_then(NvdmType::try_from)?
+            != M::NVDM_TYPE
+        {
             dev_err!(
                 dev,
                 "Expected NVDM type {:?} in reply, got {:#x}\n",
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..5a8392b33b4a 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,6 +10,7 @@
 use core::ops::Range;
 
 use kernel::{
+    bitfield,
     dma::Coherent,
     prelude::*,
     ptr::{
@@ -742,8 +743,8 @@ unsafe impl AsBytes for MsgqRxHeader {}
 
 bitfield! {
     struct MsgHeaderVersion(u32) {
-        31:24 major as u8;
-        23:16 minor as u8;
+        31:24 major;
+        23:16 minor;
     }
 }
 
@@ -752,9 +753,9 @@ impl MsgHeaderVersion {
     const MINOR_TOT: u8 = 0;
 
     fn new() -> Self {
-        Self::default()
-            .set_major(Self::MAJOR_TOT)
-            .set_minor(Self::MINOR_TOT)
+        Self::zeroed()
+            .with_major(Self::MAJOR_TOT)
+            .with_minor(Self::MINOR_TOT)
     }
 }
 
diff --git a/drivers/gpu/nova-core/mctp.rs b/drivers/gpu/nova-core/mctp.rs
index 482786e07bc7..acc2abbd4b0c 100644
--- a/drivers/gpu/nova-core/mctp.rs
+++ b/drivers/gpu/nova-core/mctp.rs
@@ -7,55 +7,51 @@
 //! Data Model) messages between the kernel driver and GPU firmware processors
 //! such as FSP and GSP.
 
-use kernel::pci::Vendor;
+use kernel::{
+    bitfield,
+    pci::Vendor,
+    prelude::*, //
+};
 
-/// NVDM message type identifiers carried over MCTP.
-#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
-#[repr(u8)]
-pub(crate) enum NvdmType {
-    #[default]
-    /// Chain of Trust boot message.
-    Cot = 0x14,
-    /// FSP command response.
-    FspResponse = 0x15,
-}
+use crate::{
+    bounded_enum,
+    num, //
+};
 
-impl TryFrom<u8> for NvdmType {
-    type Error = u8;
-
-    fn try_from(value: u8) -> Result<Self, Self::Error> {
-        match value {
-            x if x == u8::from(Self::Cot) => Ok(Self::Cot),
-            x if x == u8::from(Self::FspResponse) => Ok(Self::FspResponse),
-            _ => Err(value),
-        }
-    }
-}
-
-impl From<NvdmType> for u8 {
-    fn from(value: NvdmType) -> Self {
-        value as u8
+bounded_enum! {
+    /// NVDM message type identifiers carried over MCTP.
+    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+    pub(crate) enum NvdmType with TryFrom<Bounded<u32, 8>> {
+        /// Chain of Trust boot message.
+        Cot = 0x14,
+        /// FSP command response.
+        FspResponse = 0x15,
     }
 }
 
 bitfield! {
-    pub(crate) struct MctpHeader(u32), "MCTP transport header for NVIDIA firmware messages." {
-        31:31 som as bool, "Start-of-message bit.";
-        30:30 eom as bool, "End-of-message bit.";
-        29:28 seq as u8, "Packet sequence number.";
-        23:16 seid as u8, "Source endpoint ID.";
+    /// MCTP transport header for NVIDIA firmware messages.
+    pub(crate) struct MctpHeader(u32) {
+        /// Start-of-message bit.
+        31:31 som;
+        /// End-of-message bit.
+        30:30 eom;
+        /// Packet sequence number.
+        29:28 seq;
+        /// Source endpoint ID.
+        23:16 seid;
     }
 }
 
 impl MctpHeader {
     /// Builds a single-packet MCTP header (`SOM=1`, `EOM=1`, `SEQ=0`, `SEID=0`).
     pub(crate) fn single_packet() -> Self {
-        Self::default().set_som(true).set_eom(true)
+        Self::zeroed().with_som(true).with_eom(true)
     }
 
     /// Returns whether this is a complete single-packet message (`SOM=1` and `EOM=1`).
     pub(crate) fn is_single_packet(self) -> bool {
-        self.som() && self.eom()
+        self.som().into_bool() && self.eom().into_bool()
     }
 }
 
@@ -63,26 +59,30 @@ pub(crate) fn is_single_packet(self) -> bool {
 const MSG_TYPE_VENDOR_PCI: u8 = 0x7e;
 
 bitfield! {
-    pub(crate) struct NvdmHeader(u32), "NVIDIA Vendor-Defined Message header over MCTP." {
-        31:24 nvdm_type as u8 ?=> NvdmType, "NVDM message type.";
-        23:8 vendor_id as u16, "PCI vendor ID.";
-        6:0 msg_type as u8, "MCTP vendor-defined message type.";
+    /// NVIDIA Vendor-Defined Message header over MCTP.
+    pub(crate) struct NvdmHeader(u32) {
+        /// NVDM message type.
+        31:24 nvdm_type ?=> NvdmType;
+        /// PCI vendor ID.
+        23:8 vendor_id;
+        /// MCTP vendor-defined message type.
+        6:0 msg_type;
     }
 }
 
 impl NvdmHeader {
     /// Builds an NVDM header for the given message type.
     pub(crate) fn new(nvdm_type: NvdmType) -> Self {
-        Self::default()
-            .set_msg_type(MSG_TYPE_VENDOR_PCI)
-            .set_vendor_id(Vendor::NVIDIA.as_raw())
-            .set_nvdm_type(nvdm_type)
+        Self::zeroed()
+            .with_const_msg_type::<{ num::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+            .with_vendor_id(Vendor::NVIDIA.as_raw())
+            .with_nvdm_type(nvdm_type)
     }
 
     /// Validates this header against the expected NVIDIA NVDM format and type.
     pub(crate) fn validate(self, expected_type: NvdmType) -> bool {
-        self.msg_type() == MSG_TYPE_VENDOR_PCI
-            && self.vendor_id() == Vendor::NVIDIA.as_raw()
+        u8::from(self.msg_type()) == MSG_TYPE_VENDOR_PCI
+            && u16::from(self.vendor_id()) == Vendor::NVIDIA.as_raw()
             && matches!(self.nvdm_type(), Ok(nvdm_type) if nvdm_type == expected_type)
     }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 735b8e17c6b6..a61406ba5c0b 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -10,9 +10,6 @@
     InPlaceModule, //
 };
 
-#[macro_use]
-mod bitfield;
-
 mod driver;
 mod falcon;
 mod fb;

-- 
2.54.0

