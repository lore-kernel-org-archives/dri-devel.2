Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18501C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6131F10E164;
	Wed,  5 Aug 2026 05:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IGgTf6wm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76FA10E164
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeSyGbi3vYyBG2/HHWM4GbamBV/y7DKpsLYFe4dWB4opMAzX4nyfAvW/np0wcPeny6raOoAaiyzfTwtiuVdltpLRwX/A4xnvZBN83kJMxhVKVQza4PN+y3WCeleG0XTpRpTWbUKTWJfxuPHsHTDQjvUuNXXPb83Q8n1YAXp84MrqeLG7YBGIGd7kIkfz1ia57eLKMEa97nRSbknfxjosnsPGtF6eRZmsdpGpmldjKY328deHz9nym09xn+Eyot7jmqaVjpp4AK5YDPMYBfRzh+/Mc0Wvp3H+TPJ4ln+uO5evuXivWWZqGIG3dd00gpzBvOGS4fBN8L60zZgYQnII6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1mf4Cdi40ZUuVzmgRGkwDNEXS/1Ve3zq0lI/pROj/k=;
 b=mFXZc81ArNlXqG5CJMpFHxyB/Yd8Bgduuy/SdU6wFYJSbYHIAgzJ+C+v1Qpg5rZhfwQu+e5D/RiesdNM59udCSZ6XG0UsFcvDdAYYha2TxkO1SXDUc0erIPZ+4Zi2sHpwTq+QOG2rMQgNvNUEbMBAwkoZNvrK+o941pPJSE7rDUqstVOeFZCjsl/Biqcx64rATX8vuaktGmqyYlTlSgaW3CTQ3NAq80AYRZtW/CpLD761UqANttD8ynth7Bzp12XWs+gDLSluP+1KIczYoAovqqwDl1CGPq2tSC5iCza7NmilgTiDJ5foTbDACT+kwDpfH8X38r7ljKPWiVDbEUvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1mf4Cdi40ZUuVzmgRGkwDNEXS/1Ve3zq0lI/pROj/k=;
 b=IGgTf6wmdSc9a7Iz6Zu3w7BpSQIDmHrhk85YTsaJQC0np2mtX8zqYnNG4M0LJ+63M0BrQTzD/QSwX5Y6TdqjYnA6kQU60be7Jx+GQBObysmBicqtpAm7Iwh/6phuRUYxymFbJ9Lla+tbKEVHNV54Z/zL+iBhGPXIujUn4q9sErNPVOiH02up2IgVpTYDnE93PPb+N5BwBYjtxU6zHCC6cE4dlREngCORs/01Umf14uLkTA/vciIggS6ybrz740Q5Sei6tvaO/FaIOOFufldQVKMBxpBmxB8o9s2zb3DtHT0pCDEsRdUdgrK9rj2wUNfUnECTaU70WsecsQZH6qZaZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 05:02:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 05:02:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 05 Aug 2026 14:01:46 +0900
Subject: [PATCH v2 2/3] rust: dma: rename dma_handle to dma_address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-falcon-dma-projections-v2-2-4cc9f3f13ee9@nvidia.com>
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
In-Reply-To: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ef30a3-5ed4-49e2-d4cf-08def2aeb083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|7416014|1800799024|366016|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 27IbXhjYEpc84zG9yKOwuaKO7T2QygXeWFommG2NOqRhCuESQAMtv+rqY6of5+NAt+MB9qTM54tyVuvrDI9EuoIok457GqSYU5JK2EU70tmlNvjsnLLPZgCT+OmfDrh9d879wKEJ8QYsUekMVBTsNBPg0AhudZypRhtWcjjra6S6AbglaoTCFsMYpkQ2a3Qqptq1vNhi2XNTDmkVMZ0ZQN8/DZOR4TGEuvqgV4bR7uUBtaLVElamuekF92QjwnUtVxlMvlP3ENd0syxWJ821ImjBSUfk7shnTSJxpLfifHVly3Ciw5pDr0AzaItF0ArEqmgkZmrw0NsC7JOyh3xuRkSLtF/kWu0kgSYZhOgJJ7Bq3smpz9+DQflxRxGLnHAfXGfPdQsGqbj6Z0gXpEX0OOaYejdwZ77YchlXUXIZDOsqvwDB/JUppvmIydbab5dsAOPwjtldjJcaHt27WVqLs4yPedtDFMiwhnNutTKwF+eQioASzSBPn72EZxQkdpFxwKq14NiYb32PhinrIf8K/Q3LslCfbqi5yGB4NLM5IJ5rX2OpNl+wCXz/uTghKqS6SZZytVFbXRhw3d5lQ85glWdi71Vz9urWa2DlcaVZa5sIF4OdSJOUFSsTlj/fISoTke1JkAtwfei1pDZiLETjT0zb4csNeSOpSUtUxcNsWMk76KTkWeMg3xcdBYDdOh96DeOpnJAe4HY2smlg2adH7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(7416014)(1800799024)(366016)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhEUTk3UUx5bGI3Ris2dkNUaFlTbk85bnhreXgvUytsdjl0d2gremNJalFV?=
 =?utf-8?B?SFRwTUNJblNPbW9nMFNHRm8vM3ZDZHZBRHd2QUM1WDRwd0ZtUUlsT1U3MEkw?=
 =?utf-8?B?akduQUhPUDBnUEFhT2RjQnBNanhkQ2FzZjlOMjNqN2NwWlNmQm5vaGdGQ0gw?=
 =?utf-8?B?SlFHdkVLZVo4ZEQzRUtZZ1hteUJjWlg5QkFuYW44U0NYQjhraXYxYTlWWVZ1?=
 =?utf-8?B?QS94eDNuWXVmeStkVFZiYmhDQU5yeUFoQVpmby9uaC9mYTYreTJTcUhXNlpx?=
 =?utf-8?B?bSswTkwzTDc0NlpxWnlTNVhaM0R1aStmVC9jMW1MN09Ea2svNktUYVhyclR6?=
 =?utf-8?B?WXNRejJPMUZLMzArQWJ0cXgyUWRXaHdUV21NRW9FTXRPNE1aY25WaXI5ZitI?=
 =?utf-8?B?S2dEOFhwaW85blJaeFNNN25zRGhWKzBXZ1ZjcEJicjJJTTN3NHQrZUxOMUhw?=
 =?utf-8?B?T0hXcCsrN2N5V1JtN3I4RlA0NEcxOVFxMTFkVVRLZlVrUmdhb0NtaURndG40?=
 =?utf-8?B?UVZIM200QVNFSFBzZFBkWXlNelNQbmVNeVhCRmJkbjRtOFdIakdGUkZaYjFN?=
 =?utf-8?B?TG43dTNIKzVpSXJoR0tzdVpZRGF5bnluOXJNL2cveEx6VjFFR0xrZFZkOThU?=
 =?utf-8?B?dU1pdjlSSU9McU9LUnlBZzZ6aTVXR0VONHRiMDBLRTVMVGhrRFl3cU9zYUVx?=
 =?utf-8?B?Vnl3WEpDaTBwT01NVlQvUFFkczlXNThySXpFQ1dYc2k4ZFBJMjc4M3ZPTnNu?=
 =?utf-8?B?UitSWFhabWRjSVFSN3Q4dk9QTitwdmY0SXhDd0hKYVEvTFlrUHF6UGdxVEFl?=
 =?utf-8?B?Mjd4bVpUU0lDNStaQ3c1K2FrTjh4b2JCazViVDRtaGxVL0dDVlR3WmJ5TkxY?=
 =?utf-8?B?TkVVWU9TMmNpQWYvWmFIMUtYVERIdGJ5ellPekZRQ3JwSThTdUI0WHhSaERx?=
 =?utf-8?B?dTNCRHg0Qms3MVVCTnpKTXNrR1dqbVZLSy80ZTZBUDBTRHg5WHdaSkd4ZE1j?=
 =?utf-8?B?ZVZlb2E1WDMvSUoreVFlRWhDL2dvU2dCcFJKNElyRkNickgxY2FsV3lpb3Y0?=
 =?utf-8?B?ZjdEOTY0VjhnK09RT00xMFJWRzd3TEtyOGRMU0E1Mm8xQnFCZXJxYzVtOTgx?=
 =?utf-8?B?M21jWm82MjVDN0ZldTh3YXpLZDhGR3FIUjV5WTM0MTlOc3BKZHBpQnQ1bmlP?=
 =?utf-8?B?QVRWT0lvRHE4enVPYjhyVU5JOFkxakhoY1Z3OWpWcTRTd2VKeGRzRTVkWHRX?=
 =?utf-8?B?ZEswUnVMUE1WbUw4TU9nREsrUkdRdlhTNUNJNFlhcXJnYmtpcHhzenNobzZz?=
 =?utf-8?B?dmhUNTVvNE1qSHVJNEY5YjhwelZOVTlhT1FQV082bWo2ajlmaXhsRkFkbTVk?=
 =?utf-8?B?NWhDWm14U3hzUnFVdDVadGF3VHJLYi82TTZ1VEhZa0JQOXorZlZCbVYrWXMz?=
 =?utf-8?B?Vi9HSklEQUM5bTRUU1ZNY1c0NlFTTm9tZ0xiTWIwOS9XWFo2TldnWTE3Qjdn?=
 =?utf-8?B?dVE2RG5hQzNVOE5McHJoa0hYNS9wVUljenFQcloyU3NjWk1sNVpuUHYvREV0?=
 =?utf-8?B?VVdEZjlFaGZjbzUrc01kaDNEeitVSHVNWmR2RFMrNWhYN3pYUnFZdkFUd2dB?=
 =?utf-8?B?SytnbmlJOFpvNXVNM0R0N0JUOEJMMDlTWHBBQlpuTVBBcnRMdmdveENLdzFP?=
 =?utf-8?B?K281K3prQUYzd0NKUngzb1JmZlExaXd2aUh6cWplWG95MmY2SGF5a25pUXFp?=
 =?utf-8?B?b1JsbTlkMHpROWZXYVpTMGRjbzJjY0M2TmREbGVZTWc2dnlORHQ4T25hanE4?=
 =?utf-8?B?N2pXSURMVHozeEdaWTJPbEh4L1hOZldSUFpRU09DZDUzOE4yQXNWbkpHQ0Qx?=
 =?utf-8?B?dFRxVVBkSExuWmZUVi9GMTRZR0ZxRnBFNkJCZ1lIOXdYNHRhd1JheHYwSWVt?=
 =?utf-8?B?QjEvZTZabEorTzB4U1ZVTWJlallPR2tPaWFBYUQ3N2EwZGUyVktKMFdvbEQ4?=
 =?utf-8?B?SDkvYzBJSWhQR05QV0hyUmdvNHArRFZWdEF6dE5hU3VydHJ0elhtYWprWFpX?=
 =?utf-8?B?ek5HN1FKMm94STNub0lyd2ZuWjJCOG13T2lQZ21pYklydHRFQ3dLVVc5MThv?=
 =?utf-8?B?Z1pFSDNWNDV5c2dpd1NQWnFvTTA3TzlrdW1YbWdTYktMRFRYYVh3VmdyMlVD?=
 =?utf-8?B?dzYrcEFhVXRBbVVHU1dqaS9BanB0SnV3YVRhQmdJUDFFQnJ0TWh1NXZoZDd1?=
 =?utf-8?B?L05QY3hPU0plT1AvRU9qQThyR2hkK1VTT1hKT0xQYUVEWCtXSUNWVVc5WUYy?=
 =?utf-8?B?bE9FUTV6QzZSSzBIT1krUS9TbStJWXJVcXByY1FMYm1sQ2lyckU1c0ppN1FL?=
 =?utf-8?Q?aHcybzhFgrbnCwGhxTFralX19hU8zPeV9MW9Q6wDwe0Pt?=
X-MS-Exchange-AntiSpam-MessageData-1: CJxe7LMmeqMe3w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ef30a3-5ed4-49e2-d4cf-08def2aeb083
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:02:03.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnfC+TNLa9Upi3o1zszrMTF3iZOGlRVHw7V4Rb3u0KZcanpz8/XssAasi5p3ibEPcS6IEH5O2Ja5lRuUb3LPAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

The `dma_handle` naming is inherited from the C API, but what this
really describes is the device DMA address; everything named
`dma_handle` is actually a `dma_addr_t`.

This naming introduces some confusion on the Rust API side, as handles
are supposed to be opaque tokens, yet we were doing address computation
on values returned by `dma_handle`.

Rename `dma_handle` to `dma_address` while nova-core is still its only
user.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/all/DK75LUA4NLGI.3P29AIZQE20V2@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    |  8 +--
 drivers/gpu/nova-core/fb.rs                        |  4 +-
 drivers/gpu/nova-core/firmware/booter.rs           |  8 ++-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  4 +-
 drivers/gpu/nova-core/firmware/gsp.rs              |  6 +-
 drivers/gpu/nova-core/fsp.rs                       |  6 +-
 drivers/gpu/nova-core/gsp.rs                       |  2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs                  |  8 +--
 drivers/gpu/nova-core/gsp/fw.rs                    | 10 ++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |  2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |  8 ++-
 drivers/gpu/nova-core/gsp/sequencer.rs             |  8 +--
 rust/kernel/dma.rs                                 | 70 +++++++++++-----------
 13 files changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index cd05985f5ee6..a281d316ebfd 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -499,7 +499,7 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         Ok(())
     }
 
-    /// Perform a DMA write according to `load_offsets` from `dma_handle` into the falcon's
+    /// Perform a DMA write according to `load_offsets` from `dma_obj` into the falcon's
     /// `target_mem`.
     ///
     /// `sec` is set if the loaded firmware is expected to run in secure mode.
@@ -514,14 +514,14 @@ fn dma_wr(
         // For IMEM, we want to use the start offset as a virtual address tag for each page, since
         // code addresses in the firmware (and the boot vector) are virtual.
         //
-        // For DMEM we can fold the start offset into the DMA handle.
+        // For DMEM we can fold the start offset into the DMA address.
         let (src_start, dma_start) = match target_mem {
             FalconMem::ImemSecure | FalconMem::ImemNonSecure => {
-                (load_offsets.src_start, dma_obj.dma_handle())
+                (load_offsets.src_start, dma_obj.dma_address())
             }
             FalconMem::Dmem => (
                 0,
-                dma_obj.dma_handle() + DmaAddress::from(load_offsets.src_start),
+                dma_obj.dma_address() + DmaAddress::from(load_offsets.src_start),
             ),
         };
         if dma_start % DmaAddress::from(DMA_LEN) > 0 {
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 9e475efb1150..e7ed19a61c1a 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -61,7 +61,7 @@ pub(crate) fn register(
     ) -> Result<Self> {
         let page = CoherentHandle::alloc(dev, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
 
-        hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_handle())?;
+        hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_address())?;
 
         Ok(Self {
             chipset,
@@ -76,7 +76,7 @@ impl Drop for SysmemFlush<'_> {
     fn drop(&mut self) {
         let hal = hal::fb_hal(self.chipset);
 
-        if hal.read_sysmem_flush_page(self.bar) == self.page.dma_handle() {
+        if hal.read_sysmem_flush_page(self.bar) == self.page.dma_address() {
             let _ = hal.write_sysmem_flush_page(self.bar, 0).inspect_err(|e| {
                 dev_warn!(
                     &self.device,
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index acb7f4d8a532..972618e5eafe 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -405,9 +405,11 @@ pub(crate) fn run<T>(
     ) -> Result {
         sec2_falcon.reset()?;
         sec2_falcon.load(self)?;
-        let wpr_handle = wpr_meta.dma_handle();
-        let (mbox0, mbox1) =
-            sec2_falcon.boot(Some(wpr_handle as u32), Some((wpr_handle >> 32) as u32))?;
+        let wpr_dma_address = wpr_meta.dma_address();
+        let (mbox0, mbox1) = sec2_falcon.boot(
+            Some(wpr_dma_address as u32),
+            Some((wpr_dma_address >> 32) as u32),
+        )?;
         dev_dbg!(dev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
 
         if mbox0 != 0 {
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index d9fafd2eea5b..c4a327af9ac7 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -230,7 +230,7 @@ pub(crate) fn new(
                 reserved: [0; 4],
                 signature: [0; 4],
                 ctx_dma: FALCON_DMAIDX_PHYS_SYS_NCOH,
-                code_dma_base: firmware_dma.dma_handle(),
+                code_dma_base: firmware_dma.dma_address(),
                 // `dst_start` is also valid as the source offset since the firmware DMA object is
                 // a mirror image of the target IMEM layout.
                 non_sec_code_off: imem_ns.dst_start,
@@ -242,7 +242,7 @@ pub(crate) fn new(
                 code_entry_point: 0,
                 // Start of data section is the added padding + the DMEM `src_start` field.
                 data_dma_base: firmware_dma
-                    .dma_handle()
+                    .dma_address()
                     .checked_add(u64::from_safe_cast(align_padding))
                     .and_then(|offset| offset.checked_add(dmem.src_start.into()))
                     .ok_or(EOVERFLOW)?,
diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 99a302bae567..97977f27d74b 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -161,9 +161,9 @@ pub(crate) fn new<'a>(
         })
     }
 
-    /// Returns the DMA handle of the radix3 level 0 page table.
-    pub(crate) fn radix3_dma_handle(&self) -> DmaAddress {
-        self.level0.dma_handle()
+    /// Returns the DMA address of the radix3 level 0 page table.
+    pub(crate) fn radix3_dma_address(&self) -> DmaAddress {
+        self.level0.dma_address()
     }
 }
 
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ba4544210e40..1721a8387636 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -287,12 +287,12 @@ fn new<'a>(
         .chain(move |msg| {
             msg.cot.version = version;
             msg.cot.size = size;
-            msg.cot.gsp_fmc_sysmem_offset = fsp_fw.fmc_image.dma_handle();
+            msg.cot.gsp_fmc_sysmem_offset = fsp_fw.fmc_image.dma_address();
             msg.cot.frts_vidmem_offset = frts_vidmem_offset;
             msg.cot.frts_vidmem_size = frts_size;
             // frts_sysmem_* are left at zero because this path places FRTS in vidmem. The sysmem
             // fields point to an FRTS buffer in sysmem instead, for systems without VRAM.
-            msg.cot.gsp_boot_args_sysmem_offset = args.fmc_boot_params.dma_handle();
+            msg.cot.gsp_boot_args_sysmem_offset = args.fmc_boot_params.dma_address();
             msg.cot.sigs = *fsp_fw.fmc_sigs;
 
             Ok(())
@@ -353,7 +353,7 @@ pub(crate) fn new(
         libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
         resume: bool,
     ) -> Result<Self> {
-        let init = GspFmcBootParams::new(wpr_meta.dma_handle(), libos.dma_handle());
+        let init = GspFmcBootParams::new(wpr_meta.dma_address(), libos.dma_address());
 
         Ok(Self {
             chipset,
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index b403dc3515a5..13f361406a6c 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -122,7 +122,7 @@ impl LogBuffer {
     fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
 
-        let start_addr = obj.0.dma_handle();
+        let start_addr = obj.0.dma_address();
 
         let pte_view = io_project!(
             obj.0,
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index cd844fe48f05..f0f28b6ded7a 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -243,7 +243,7 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
         let gsp_mem: Coherent<_> = gsp_mem.into();
-        PteArray::init(io_project!(gsp_mem, .ptes), gsp_mem.dma_handle())?;
+        PteArray::init(io_project!(gsp_mem, .ptes), gsp_mem.dma_address())?;
 
         Ok(Self(gsp_mem))
     }
@@ -487,8 +487,8 @@ pub(crate) struct Cmdq {
     /// Inner mutex-protected state.
     #[pin]
     inner: Mutex<CmdqInner>,
-    /// DMA handle of the command queue's shared memory region.
-    pub(super) dma_handle: DmaAddress,
+    /// DMA address of the command queue's shared memory region.
+    pub(super) dma_addr: DmaAddress,
 }
 
 impl Cmdq {
@@ -517,7 +517,7 @@ pub(crate) fn new(dev: &device::Device<device::Bound>) -> impl PinInit<Self, Err
             let gsp_mem = DmaGspMem::new(dev)?;
 
             Ok(try_pin_init!(Self {
-                dma_handle: gsp_mem.0.dma_handle(),
+                dma_addr: gsp_mem.0.dma_address(),
                 inner <- new_mutex!(CmdqInner {
                     dev: dev.into(),
                     gsp_mem,
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 6e8e7d822ef1..a237db74cad5 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -183,16 +183,16 @@ pub(crate) fn new<'a>(
             // CAST: we want to store the bits of `GSP_FW_WPR_META_MAGIC` unmodified.
             magic: bindings::GSP_FW_WPR_META_MAGIC as u64,
             revision: u64::from(bindings::GSP_FW_WPR_META_REVISION),
-            sysmemAddrOfRadix3Elf: gsp_firmware.radix3_dma_handle(),
+            sysmemAddrOfRadix3Elf: gsp_firmware.radix3_dma_address(),
             sizeOfRadix3Elf: u64::from_safe_cast(gsp_firmware.size),
-            sysmemAddrOfBootloader: gsp_firmware.bootloader.ucode.dma_handle(),
+            sysmemAddrOfBootloader: gsp_firmware.bootloader.ucode.dma_address(),
             sizeOfBootloader: u64::from_safe_cast(gsp_firmware.bootloader.ucode.size()),
             bootloaderCodeOffset: u64::from(gsp_firmware.bootloader.code_offset),
             bootloaderDataOffset: u64::from(gsp_firmware.bootloader.data_offset),
             bootloaderManifestOffset: u64::from(gsp_firmware.bootloader.manifest_offset),
             __bindgen_anon_1: GspFwWprMetaBootResumeInfo {
                 __bindgen_anon_1: GspFwWprMetaBootInfo {
-                    sysmemAddrOfSignature: gsp_firmware.signatures.dma_handle(),
+                    sysmemAddrOfSignature: gsp_firmware.signatures.dma_address(),
                     sizeOfSignature: u64::from_safe_cast(gsp_firmware.signatures.size()),
                 },
             },
@@ -635,7 +635,7 @@ fn id8(name: &str) -> u64 {
 
         let init_inner = init!(bindings::LibosMemoryRegionInitArgument {
             id8: id8(name),
-            pa: obj.dma_handle(),
+            pa: obj.dma_address(),
             size: num::usize_as_u64(obj.size()),
             kind: num::u32_into_u8::<
                 { bindings::LibosMemoryRegionKind_LIBOS_MEMORY_REGION_CONTIGUOUS },
@@ -901,7 +901,7 @@ impl MessageQueueInitArguments {
     /// Creates a new init arguments structure for `cmdq`.
     fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
         init!(MessageQueueInitArguments {
-            sharedMemPhysAddr: cmdq.dma_handle,
+            sharedMemPhysAddr: cmdq.dma_addr,
             pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
             cmdQueueOffset: num::usize_as_u64(Cmdq::CMDQ_OFFSET),
             statQueueOffset: num::usize_as_u64(Cmdq::STATQ_OFFSET),
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 22b60f9233de..8e219a0cb164 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -63,7 +63,7 @@ fn lockdown_released_or_error(
         // boot. If the address is still there, keep polling rather than treating it as an error.
         // Any other non-zero mailbox0 value is a GSP-FMC error code.
         if self.mbox0 != 0 {
-            return self.combined_addr() != fmc_boot_params.dma_handle();
+            return self.combined_addr() != fmc_boot_params.dma_address();
         }
 
         !gsp_falcon.riscv_branch_privilege_lockdown()
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 03133f723faf..26ac1adba1bf 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -286,9 +286,11 @@ fn boot(
         }
 
         gsp_falcon.reset()?;
-        let libos_handle = gsp.libos.dma_handle();
-        let (mbox0, mbox1) =
-            gsp_falcon.boot(Some(libos_handle as u32), Some((libos_handle >> 32) as u32))?;
+        let libos_dma_address = gsp.libos.dma_address();
+        let (mbox0, mbox1) = gsp_falcon.boot(
+            Some(libos_dma_address as u32),
+            Some((libos_dma_address >> 32) as u32),
+        )?;
         dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
 
         dev_dbg!(
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 5e1ec7e59ab0..bcad1421953a 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -234,12 +234,12 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
                 // Reset the GSP to prepare it for resuming.
                 seq.gsp_falcon.reset()?;
 
-                let libos_dma_handle = seq.libos.dma_handle();
+                let libos_dma_address = seq.libos.dma_address();
 
-                // Write the libOS DMA handle to GSP mailboxes.
+                // Write the libOS DMA address to GSP mailboxes.
                 seq.gsp_falcon.write_mailboxes(
-                    Some(libos_dma_handle as u32),
-                    Some((libos_dma_handle >> 32) as u32),
+                    Some(libos_dma_address as u32),
+                    Some((libos_dma_address >> 32) as u32),
                 );
 
                 // Start the SEC2 falcon which will trigger GSP-RM to resume on the GSP.
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index e275f2562a5b..4258ff7ff525 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -585,7 +585,7 @@ fn from(value: CoherentBox<T>) -> Self {
 /// # Invariants
 ///
 /// - For the lifetime of an instance of [`Coherent`], the `cpu_addr` is a valid pointer
-///   to an allocated region of coherent memory and `dma_handle` is the DMA address base of the
+///   to an allocated region of coherent memory and `dma_addr` is the DMA address base of the
 ///   region.
 /// - The size in bytes of the allocation is equal to size information via pointer.
 // TODO
@@ -602,7 +602,7 @@ fn from(value: CoherentBox<T>) -> Self {
 // entire `Coherent` including the allocated memory itself.
 pub struct Coherent<T: KnownSize + ?Sized> {
     dev: ARef<device::Device>,
-    dma_handle: DmaAddress,
+    dma_addr: DmaAddress,
     cpu_addr: NonNull<T>,
     dma_attrs: Attrs,
 }
@@ -627,11 +627,10 @@ pub fn as_mut_ptr(&self) -> *mut T {
         self.cpu_addr.as_ptr()
     }
 
-    /// Returns a DMA handle which may be given to the device as the DMA address base of
-    /// the region.
+    /// Returns a DMA address which may be given to the device as the base of the region.
     #[inline]
-    pub fn dma_handle(&self) -> DmaAddress {
-        self.dma_handle
+    pub fn dma_address(&self) -> DmaAddress {
+        self.dma_addr
     }
 
     /// Returns a reference to the data in the region.
@@ -678,13 +677,13 @@ fn alloc_with_attrs(
             );
         }
 
-        let mut dma_handle = 0;
+        let mut dma_addr = 0;
         // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
         let addr = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
                 core::mem::size_of::<T>(),
-                &mut dma_handle,
+                &mut dma_addr,
                 gfp_flags.as_raw(),
                 dma_attrs.as_raw(),
             )
@@ -696,7 +695,7 @@ fn alloc_with_attrs(
         // - We also hold a refcounted reference to the device.
         Ok(Self {
             dev: dev.into(),
-            dma_handle,
+            dma_addr,
             cpu_addr,
             dma_attrs,
         })
@@ -795,13 +794,13 @@ fn alloc_slice_with_attrs(
         }
 
         let size = core::mem::size_of::<T>().checked_mul(len).ok_or(ENOMEM)?;
-        let mut dma_handle = 0;
+        let mut dma_addr = 0;
         // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
         let addr = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
                 size,
-                &mut dma_handle,
+                &mut dma_addr,
                 gfp_flags.as_raw(),
                 dma_attrs.as_raw(),
             )
@@ -813,7 +812,7 @@ fn alloc_slice_with_attrs(
         // - We also hold a refcounted reference to the device.
         Ok(Coherent {
             dev: dev.into(),
-            dma_handle,
+            dma_addr,
             cpu_addr,
             dma_attrs,
         })
@@ -927,14 +926,14 @@ impl<T: KnownSize + ?Sized> Drop for Coherent<T> {
     fn drop(&mut self) {
         let size = T::size(self.cpu_addr.as_ptr());
         // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
-        // The cpu address, and the dma handle are valid due to the type invariants on
+        // The cpu address, and the dma address are valid due to the type invariants on
         // `Coherent`.
         unsafe {
             bindings::dma_free_attrs(
                 self.dev.as_raw(),
                 size,
                 self.cpu_addr.as_ptr().cast(),
-                self.dma_handle,
+                self.dma_addr,
                 self.dma_attrs.as_raw(),
             )
         }
@@ -989,13 +988,13 @@ fn write_to_slice(
 ///
 /// - `cpu_handle` holds the opaque handle returned by `dma_alloc_attrs` with
 ///   `DMA_ATTR_NO_KERNEL_MAPPING` set, and is only valid for passing back to `dma_free_attrs`.
-/// - `dma_handle` is the corresponding bus address for device DMA.
+/// - `dma_addr` is the corresponding bus address for device DMA.
 /// - `size` is the allocation size in bytes as passed to `dma_alloc_attrs`.
 /// - `dma_attrs` contains the attributes used for the allocation, always including
 ///   `DMA_ATTR_NO_KERNEL_MAPPING`.
 pub struct CoherentHandle {
     dev: ARef<device::Device>,
-    dma_handle: DmaAddress,
+    dma_addr: DmaAddress,
     cpu_handle: NonNull<c_void>,
     size: usize,
     dma_attrs: Attrs,
@@ -1019,13 +1018,13 @@ pub fn alloc_with_attrs(
         }
 
         let dma_attrs = dma_attrs | Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
-        let mut dma_handle = 0;
+        let mut dma_addr = 0;
         // SAFETY: `dev.as_raw()` is valid by the type invariant on `device::Device`.
         let cpu_handle = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
                 size,
-                &mut dma_handle,
+                &mut dma_addr,
                 gfp_flags.as_raw(),
                 dma_attrs.as_raw(),
             )
@@ -1034,11 +1033,11 @@ pub fn alloc_with_attrs(
         let cpu_handle = NonNull::new(cpu_handle).ok_or(ENOMEM)?;
 
         // INVARIANT: `cpu_handle` is the opaque handle from a successful `dma_alloc_attrs` call
-        // with `DMA_ATTR_NO_KERNEL_MAPPING`, `dma_handle` is the corresponding DMA address,
+        // with `DMA_ATTR_NO_KERNEL_MAPPING`, `dma_addr` is the corresponding DMA address,
         // and we hold a refcounted reference to the device.
         Ok(Self {
             dev: dev.into(),
-            dma_handle,
+            dma_addr,
             cpu_handle,
             size,
             dma_attrs,
@@ -1055,12 +1054,12 @@ pub fn alloc(
         Self::alloc_with_attrs(dev, size, gfp_flags, Attrs(0))
     }
 
-    /// Returns the DMA handle for this allocation.
+    /// Returns the DMA address for this allocation.
     ///
     /// This address can be programmed into device hardware for DMA access.
     #[inline]
-    pub fn dma_handle(&self) -> DmaAddress {
-        self.dma_handle
+    pub fn dma_address(&self) -> DmaAddress {
+        self.dma_addr
     }
 
     /// Returns the size in bytes of this allocation.
@@ -1079,28 +1078,29 @@ fn drop(&mut self) {
                 self.dev.as_raw(),
                 self.size,
                 self.cpu_handle.as_ptr(),
-                self.dma_handle,
+                self.dma_addr,
                 self.dma_attrs.as_raw(),
             )
         }
     }
 }
 
-// SAFETY: `CoherentHandle` only holds a device reference, a DMA handle, an opaque CPU handle,
+// SAFETY: `CoherentHandle` only holds a device reference, a DMA address, an opaque CPU handle,
 // and a size. None of these are tied to a specific thread.
 unsafe impl Send for CoherentHandle {}
 
 // SAFETY: `CoherentHandle` provides no CPU access to the underlying allocation. The only
-// operations on `&CoherentHandle` are reading the DMA handle and size, both of which are
+// operations on `&CoherentHandle` are reading the DMA address and size, both of which are
 // plain `Copy` values.
 unsafe impl Sync for CoherentHandle {}
 
 /// View type for `Coherent`.
 ///
-/// This is same as [`SysMem`] but with additional information that allows handing out a DMA handle.
+/// This is same as [`SysMem`] but with additional information that allows handing out a DMA
+/// address.
 pub struct CoherentView<'a, T: ?Sized> {
     cpu_addr: SysMem<'a, T>,
-    dma_handle: DmaAddress,
+    dma_addr: DmaAddress,
 }
 
 impl<T: ?Sized> Copy for CoherentView<'_, T> {}
@@ -1112,16 +1112,16 @@ fn clone(&self) -> Self {
 }
 
 impl<'a, T: ?Sized> CoherentView<'a, T> {
-    /// Erase the DMA handle information and obtain a [`SysMem`] view of the same memory region.
+    /// Erase the DMA address information and obtain a [`SysMem`] view of the same memory region.
     #[inline]
     pub fn as_sys_mem(self) -> SysMem<'a, T> {
         self.cpu_addr
     }
 
-    /// Returns a DMA handle which may be given to the device as the DMA address base of the region.
+    /// Returns the DMA address which may be given to the device as base of the region.
     #[inline]
-    pub fn dma_handle(self) -> DmaAddress {
-        self.dma_handle
+    pub fn dma_address(self) -> DmaAddress {
+        self.dma_addr
     }
 
     /// Returns a reference to the data in the region.
@@ -1174,9 +1174,9 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     ) -> Self::View<'a, U> {
         let offset = ptr.addr() - view.cpu_addr.as_ptr().addr();
         // CAST: The offset DMA address can never overflow.
-        let dma_handle = view.dma_handle + offset as DmaAddress;
+        let dma_addr = view.dma_addr + offset as DmaAddress;
         CoherentView {
-            dma_handle,
+            dma_addr,
             // SAFETY: Per safety requirement.
             cpu_addr: unsafe { SysMemBackend::project_view(view.cpu_addr, ptr) },
         }
@@ -1241,7 +1241,7 @@ fn as_view(self) -> CoherentView<'a, Self::Target> {
         CoherentView {
             // SAFETY: `cpu_addr` is valid and aligned kernel accessible memory.
             cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
-            dma_handle: self.dma_handle,
+            dma_addr: self.dma_addr,
         }
     }
 }

-- 
2.55.0

