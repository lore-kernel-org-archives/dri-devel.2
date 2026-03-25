Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC02B103A9A1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D6C10E6B3;
	Wed, 25 Mar 2026 02:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbGieoZi";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334A510E6B1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5FRJVoOk6gbiyYx/3ojm8WdtjTzNthRbdagE6Rx60tmUHvWy7kOemNCQyLRRT5xhIvsiI08k7PQRgcnWvCWd5qmcvPpQh2oT7IYvPUJxyrBjlfAVa6HogzdIM9vdV3eDsk4I82ECURf3dsbz3jpj6w/MkZcilsBIi/+r7LKWvlqpJ7XXfIMCvR2cGg2VbePz8O2AWfQ6o18b6yOEeElX7PgRZ3CXI9uK+r/f/R68M1b1gXaJ6sv3ib/GMuAgDNyTDh/V/Os/2vp7HIn+uBDzQyFsgZtvlVGcWbsOMRM22VGGXIrGC/7a8kBDuzdNzZ9EbdwBdjd+n9k7wUiaVqAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i87tw0CP6+DwVTbX2oaTNDcsDo/zBdPZfdbSy8ffZRY=;
 b=iJRnih/iKdJxd6xRu39tw681ykSsfNvRYLi9roFhL0o5nnHC2TkT22XQ6mxKP0MKBUnRN8N372lOepx3+a+z26wL5in7FRtcM/J6f3GuJ1PStfopWc3KrlfHlDLu30jZTl/hfFOwsaQlmOAkzchIC+d97IBjmGkdTNTTVZQ819B+Oour/zlYMp+HK95VBuzMmY8GJZVaj8HfZ6gAndOIkVA8o+1IpnjulxK+5x4PsSKzqAju8+iu81Y9k9ouwjhPtypzW3LoZYm4jPayAd/G4lT947VGlojh75HRf5U4+RVE2L4op85Bd/J6eB56ikbEW8VEutxd/fldZs3PpatCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i87tw0CP6+DwVTbX2oaTNDcsDo/zBdPZfdbSy8ffZRY=;
 b=MbGieoZiSuOyyFkR5Yw/L/rW0v2VxchcB6RxqUZOi5tCZuka8FMOX7Ori0ytavObYdUwrvW9h+81DnFJd9gtJYNc57/ryYVbprlMmgpzYunfSgxUEFSvIWpjDkPbAKGx2vFQFFXfM6IRwIuRyIpp3S5Rm8RLZ0TVbhLFg0cO/d01BbK0zl/K4iZuEQh49hqCNZofypNlHQGOkKaXMREDgksPWdiQJG4wgUVrI5TvNUv7caNnfBdnE+vAllTTDE5Yv6xlH1m2/6/B5xYSpj6VgCJDy7xa83sROo92GM7tzPq7dhqN7z5yvc5W5xllEOFqvKWk0lvRToWdXSbXwyRsMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:43 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:15 +0900
Subject: [PATCH v4 02/10] gpu: nova-core: convert PMC registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-2-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
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
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: f81a0070-eb8d-42ac-e051-08de8a18bfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ChuIcITufuVEPnq2NfTReUmKip1Bm2zUl7r7PujGpgrJ86AkDhTxlnsnb/g3mrZVeAJrd44ZQtC/q6ct7vFWfIKj1C0+EzXkoXvV0qZC0EiV0ho8b+PMj7S7lfjaSxaCG2kedgY7DknpmdXLGVPkchL7AtjvkXvEMFaWINeZExf++BAG3XbBFvCOh5J/jztkqJNWyCf28+SgvuFaR0XfLAaQr4UmscX9FG0wrJcNIMTmZ8hALCLcfuO/0Qxy372JSFot8X/UQSkSj0MC37qnTn41pFFpf+AFi4bHkv24kDf9/xqnolYXpG7cdWbsjI+Zg7cGiIQvEuEWUcQGXeiUUrfgaNOFTlEk0z4rCkuk8HM0zESiLwwb7AXedDCZKScHg1+8aZ71+vR9yq3aIbSiH6BzYg6vdilKnPfRtbTwaO8n96Z5tZvzFlae4XX9Deq6m4OomejvypY4FqTMWFvtodZ3i8Fl7Kfu8OC/5qwJckMX6cGD8/gVD1pYrJCjZhVmYuH7x4DGq9F+WV13maTKLE6ColTMjnLmu76SHBQdNODAZWGoucC6rF5JFWrrYDVhLwJDwOPrgfj/Iyq2T8cJNLKTMVQxBr2wMeZANcmXLKNXpEJlGmhOFLfQaX0I4BL66W1QEVSXAScq1qj85nrypQ1XMzgDJbWRQ63foVDq0lRecywPsRTBhoPSu3MSqr6HxFpR655mstpLVCi+s2ohQettbo9Xw3RMJqyk20FNRdVCz/H/UbrneO800QxrgeCz6rZikmkL5NnCCv+iRURj+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZEQVlYcE5NUzJUR3ZQTDZUOEJzazVqWjJzcC8vanVPbXlpOThqTmxHOGZl?=
 =?utf-8?B?b05pVWxZdkp1RHUvajFDQU40dS9JZ3RLOURYZk92aDA5VjBkamYzMVgwYTFX?=
 =?utf-8?B?WkVaTEVuQklLV0JNUlBVQURJMUkyMXkzYkFyc1BZeE12ZFhVMjA0VG1xdjdo?=
 =?utf-8?B?RXRmWVY3R0p5QzV6SWY2Uk9DKzJtNk1vVVJBL291cnp5NWs3U3BaUitCUFIx?=
 =?utf-8?B?d0JFdFJpYXY5N05nMW5BaWJ6QytNVnFtS3hzZEVJMmU2V2x1OFV5U2VMbEpw?=
 =?utf-8?B?bmFFL2d1ZmZCdW9UK1V3ejFucW9reUdaSXp6bmE1YkJkcFVsN3pidTZ2V0hJ?=
 =?utf-8?B?ZjVjdjZnblRhelJ2WmU1L1djRndNNS9tbmRBdzJpS3ZUcnFkU1Z0UDVQRTNL?=
 =?utf-8?B?bUFCVXZjUDNFLzN1YjdOMlJhL1R2NzRSZHRxK2ZUL1E1T3o5bnlRWGZWMFkx?=
 =?utf-8?B?YXV0aUhwQlhmeWpjNG55RFEvdE5mc202SWVPYTBsRWdnZ1c0dXlCSjhqeU0y?=
 =?utf-8?B?dWI2ZENGcjBOUEttL0hlcDFQcWh4cWhNYnJjdXE3NUg0SjlWeDFQSUFIRGVz?=
 =?utf-8?B?NnVRbmV1WSt5L01acCtIU3ZwaTYxTHBzMnhRY3ZaNkVYT01tNkRXRE1LaDNB?=
 =?utf-8?B?VkFzeit6eWp3ZG5KdG5sM3ZONmtQMzdhbkRydXdscTh2bTVTU1pIbjFpZVl1?=
 =?utf-8?B?SVZURTdQMWFsN3JLV09lVEh2TWZWcDRZeTg0R2NlSklGdExmVEhUMGY3N1RX?=
 =?utf-8?B?L2RFejQ2NERoUC9JcEhnaEVUM3BRQmRvajVoTjlMVW5UdHBOdnZnQTFOOUE5?=
 =?utf-8?B?bHJnNWlqRUw5eDR2SkZiOXFaRW45RldwMHczd1R6RXYrVW51SFB4dHE5bDBw?=
 =?utf-8?B?ZlJYZ1I0aWNMdnZGTkRqUmI0MGhBakpXZWdNWDVwNWJHNEdTUUNwWGduaGlJ?=
 =?utf-8?B?cm13T3Rya3dZSFdxcDFGTUtEU0N4Tlk1VHpDS280TEl1WU80NlNnRVZ1R1M5?=
 =?utf-8?B?WUpPRWpiNjdETzRMZEFobnNnUlJuNURiYWRUdFFkbWRQOVQ4SjFhT05PUGc1?=
 =?utf-8?B?Wkg1SEpXYkxEK2ZRUGFZV05rYlB6T2lPUGVOUVdSMXU5cUtJZHpkNnpuS2lX?=
 =?utf-8?B?RVlOM1U4Qm9ERTF1bTR6NHBLWkF0S0crQ0s1ODYvNU1EQjNsQVpmZUltQnJP?=
 =?utf-8?B?WDk2bitpNnJCUmNUdE5ZeFg4a1NWanNIQVNDS3dMQlFYRnpjREtuYUxoVVZu?=
 =?utf-8?B?Z1hJQ1dSaGhHZGphTVBHbmhzSk9LR1BVUXNaM3pmMkNTckhOYjQ1RG5NYVVD?=
 =?utf-8?B?aDNWaHVScFpnQ2hrTU1FUFJ5QW80NGZtQXk2WmdtdjRvQ3hHNUdwKzkvZ2xO?=
 =?utf-8?B?cFUrelU0K0MzMXErY0tQcERFVXVXdHZQQnpLVWxFWDd1R0VVNHVZV1phY3Z3?=
 =?utf-8?B?eUFJTllQMUZsOHU2SGRtbmwvNnlIVmp5MFZkSnpvTmlINU1SRmM4S0o1RnA2?=
 =?utf-8?B?M1pjQ0hPdDFZYXlhQXAyejUwbnpwZjlYOTUyMUd5UkFhUmFhMHI4Y3Iwa0Fa?=
 =?utf-8?B?VUpqdTF3QXUxKzZ3aE53Zlg0YzUzWWwzR0VocnF5Z3pJaXlOY2hCVHBxNHVS?=
 =?utf-8?B?MVBPWEdwSEJUUWtyQzBjdm4wUkJVL2s3LzM4VEZsZUhCeTI1SXhMT24vaW9k?=
 =?utf-8?B?Yy9rLzNyNTZ5K2oxVGpZVldueU1qZGhsU00rMnFrTGxML1VKV2tSVCs2eEFI?=
 =?utf-8?B?S2VKaVR4VDRhSWtMMGZHdnVtRFc0NTZRMm9aUmlEUFcwTmxQQkFLa1lsM29E?=
 =?utf-8?B?c3R0enpUbHFrNUlzNDZwL3BEWmtqdThQZlMyc0czT0w1OEY4endIazdWTlEy?=
 =?utf-8?B?SjM3NU9ZY0NNVWl3aGpPK2x2K2hoQURpSWJNVTVOT2J4N2lRditZdWIxT1lX?=
 =?utf-8?B?ckRBQk00ZlFMM3dKSXBLdDR1MUsxSzlFMmczUXpKUlgwc1I5aUpFWFgzV2Nu?=
 =?utf-8?B?WmJDTFMzN25rSmJwRCsrcHFqTmFXR01QU2ZDczF4VjRFbFFsSVR2dGZPVWtt?=
 =?utf-8?B?QmY2eDIzdldwdllWeUpyOXcrSFhTL28zd1RSV21LVkRaVHVFQnJRVGdld21W?=
 =?utf-8?B?Z1RNcjdmMnl2Uzl5OXBxNEZJc1ozRjJpa1pWbUlhdHBOSHFRZ1hPRFRqV3gw?=
 =?utf-8?B?K0QrRXpjWFhBZ3QzUlNZVkxNbStmMzkwN0lneU5oeGRQQkhPVTZ3d2JibkR4?=
 =?utf-8?B?ME9ISGpxM2xLWkRnWEx1THQxbXNxVHZSdlFwMEFWa1U1c0JYLzRaUXJEQ0NR?=
 =?utf-8?B?RmlYY1pjRVIxQ2pyYy8yNTRoSWd6c0k2QUUyZFhrT0wzTDc4cGE1VFJKV0oy?=
 =?utf-8?Q?Mq+USSzg3goloXjOJEsNrYagbUt3R4bxyw2mhUkHRAQDy?=
X-MS-Exchange-AntiSpam-MessageData-1: HZH9DGKY6403Jg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81a0070-eb8d-42ac-e051-08de8a18bfbd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:43.5604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsjKLP8u49bnSZzm3L6UUJAK5fD8v/WtGBXpp/BILION5P3eZl8jxXK3RHsrI4cJ0eZmyIXzCt8+3QUPVT4bEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs |  7 ++++--
 drivers/gpu/nova-core/gpu.rs    | 53 +++++++++++++----------------------------
 drivers/gpu/nova-core/regs.rs   | 50 ++++++++++++++++++++++++--------------
 3 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 5bf8da8760bf..123de6c55b45 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -13,7 +13,10 @@
         DmaAddress,
         DmaMask, //
     },
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        Io, //
+    },
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -531,7 +534,7 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.hal.reset_wait_mem_scrubbing(bar)?;
 
         regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(regs::NV_PMC_BOOT_0::read(bar).into())
+            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
             .write(bar, &E::ID);
 
         Ok(())
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8579d632e717..0f6fe9a1b955 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -4,12 +4,15 @@
     device,
     devres::Devres,
     fmt,
+    io::Io,
+    num::Bounded,
     pci,
     prelude::*,
     sync::Arc, //
 };
 
 use crate::{
+    bounded_enum,
     driver::Bar0,
     falcon::{
         gsp::Gsp as GspFalcon,
@@ -128,50 +131,26 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-/// Enum representation of the GPU generation.
-///
-/// TODO: remove the `Default` trait implementation, and the `#[default]`
-/// attribute, once the register!() macro (which creates Architecture items) no
-/// longer requires it for read-only fields.
-#[derive(fmt::Debug, Default, Copy, Clone)]
-#[repr(u8)]
-pub(crate) enum Architecture {
-    #[default]
-    Turing = 0x16,
-    Ampere = 0x17,
-    Ada = 0x19,
-}
-
-impl TryFrom<u8> for Architecture {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
-            0x16 => Ok(Self::Turing),
-            0x17 => Ok(Self::Ampere),
-            0x19 => Ok(Self::Ada),
-            _ => Err(ENODEV),
-        }
-    }
-}
-
-impl From<Architecture> for u8 {
-    fn from(value: Architecture) -> Self {
-        // CAST: `Architecture` is `repr(u8)`, so this cast is always lossless.
-        value as u8
+bounded_enum! {
+    /// Enum representation of the GPU generation.
+    #[derive(fmt::Debug, Copy, Clone)]
+    pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
+        Turing = 0x16,
+        Ampere = 0x17,
+        Ada = 0x19,
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
@@ -208,13 +187,13 @@ fn new(dev: &device::Device, bar: &Bar0) -> Result<Spec> {
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
index 53f412f0ca32..58fb807605dd 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -8,6 +8,7 @@
 pub(crate) mod macros;
 
 use kernel::{
+    io,
     prelude::*,
     time, //
 };
@@ -37,18 +38,38 @@
 
 // PMC
 
-register!(NV_PMC_BOOT_0 @ 0x00000000, "Basic revision information about the GPU" {
-    3:0     minor_revision as u8, "Minor revision of the chip";
-    7:4     major_revision as u8, "Major revision of the chip";
-    8:8     architecture_1 as u8, "MSB of the architecture";
-    23:20   implementation as u8, "Implementation version of the architecture";
-    28:24   architecture_0 as u8, "Lower bits of the architecture";
-});
+io::register! {
+    /// Basic revision information about the GPU.
+    pub(crate) NV_PMC_BOOT_0(u32) @ 0x00000000 {
+        /// Lower bits of the architecture.
+        28:24   architecture_0;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// MSB of the architecture.
+        8:8     architecture_1;
+        /// Major revision of the chip.
+        7:4     major_revision;
+        /// Minor revision of the chip.
+        3:0     minor_revision;
+    }
+
+    /// Extended architecture information.
+    pub(crate) NV_PMC_BOOT_42(u32) @ 0x00000a00 {
+        /// Architecture value.
+        29:24   architecture ?=> Architecture;
+        /// Implementation version of the architecture.
+        23:20   implementation;
+        /// Major revision of the chip.
+        19:16   major_revision;
+        /// Minor revision of the chip.
+        15:12   minor_revision;
+    }
+}
 
 impl NV_PMC_BOOT_0 {
     pub(crate) fn is_older_than_fermi(self) -> bool {
         // From https://github.com/NVIDIA/open-gpu-doc/tree/master/manuals :
-        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u8 = 0xc;
+        const NV_PMC_BOOT_0_ARCHITECTURE_GF100: u32 = 0xc;
 
         // Older chips left arch1 zeroed out. That, combined with an arch0 value that is less than
         // GF100, means "older than Fermi".
@@ -56,13 +77,6 @@ pub(crate) fn is_older_than_fermi(self) -> bool {
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
@@ -76,8 +90,8 @@ pub(crate) fn chipset(self) -> Result<Chipset> {
 
     /// Returns the raw architecture value from the register.
     fn architecture_raw(self) -> u8 {
-        ((self.0 >> Self::ARCHITECTURE_RANGE.start()) & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1))
-            as u8
+        ((self.into_raw() >> Self::ARCHITECTURE_RANGE.start())
+            & ((1 << Self::ARCHITECTURE_RANGE.len()) - 1)) as u8
     }
 }
 
@@ -86,7 +100,7 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
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

