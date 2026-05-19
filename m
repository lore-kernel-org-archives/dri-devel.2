Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED64FCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F6FE10EA32;
	Tue, 19 May 2026 02:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9cGwOFL";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A660810EA32
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avsxzLWc8/7Zl6V/wvc98acITQD47xRK74EahgmGVtC5YCWDnLq2PmQSsyey78bXeEF9v//uGbPdLmjVVqqtkHyk0OyZuxqHmXIs7XWKY2Pb/pTK5VXBWRh6t4jXC7J2vGoaoMkLnPqPYuGdaeRSgqFxRBwvxT9E6/6n8fIpDpABc2N1adx5GNDdXRO0vvEJ4zcYbj0jkYEMX4kOivfFPqRqHzoMi1EN1xjdtLi3WiVCoRFSp4ebwOlwSOrD+6gwz1Dzd5AOEugyoHTXD5pnhAovxlrtsmJ2ghrnbmnIiHDItoAvTt8STwvyFTbUrQATNnJwTQaw+3wnIWsqIMJfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjFd3qJXmIYrvzPX9z+rR9B2zhOhpwOF5prDRpaEmHc=;
 b=FJlU7RzwWZX8lQsIDFZ2a0tKsWMZx75sYWOt9S3XVeZ3t+9U6oq361BCUv4b8NCG8Whq1/Eshj7b7DcLXGM1A8iDuu23xlmJilOrRRnI3t/IabVPhR9h/ac+7ptjFJvFErN6QE/+lBbG3rIg/fSiJjoq9TuseZjDlbzx3CBM3KEOGCUw8SkQCv5zCdP85K5u8oiavmBC9K8WYMf2WRUB6r+Jyh5NnKWJKY1yK0bFC9qLSfcyoODZWPbuhTyerjRpM2RX0OgvKbBn/DjFBhzuCKg7o9AsGem+ZdrY/h+T/TPZc8IlE5rV+C0ZXDqEAW2E6tnZZ2SUSX6Z1DKiOu+nhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjFd3qJXmIYrvzPX9z+rR9B2zhOhpwOF5prDRpaEmHc=;
 b=P9cGwOFLN5U2yRxadGv3/ExLi1u65MOqzfQg0QF+hhZBE01hYhppNz+jDEfsok3Kokfm6OAEHZHJ/gsChkFTqYwrfGkdXwAD0nXf3ul8/XetKx6MS4W/RqD83zJCccA/OCSwN8g6rWBun9m+GdDpXNPkP+jlG0w28bt6wsd28aOSuaURpnwzYbEcgg02CsKmTW4bvA83T7ucLp8eb9Fa76KGxytVoCJBDgOUSZHPaUM4qc+wMNqBy+ZqcYfyCFG6IDOgqKhz+ivaruKilXFYfYqV7nMOpGuYnqpWPwzhUSxuhFagElz6+9V6M1xZeCFuJzGYqM5c4YNRJhUWAFnA8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:57:11 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:57:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:14 +0900
Subject: [PATCH v4 20/20] gpu: nova-core: vbios: move constants and
 functions to be associated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-20-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4073ff4f-65f4-4a8e-5c0b-08deb55251d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: f18mJUNGUjyoTXWsd8j9HyvQAodioK/eR04KZ0Uy6PEdAoZbF1yR671Gw6hee5K4eYjH2VORaofPQ7P37afLPdzIxSbhxUm2ikBMsysJKyrZ0QWryPYoZERSX7726fAgoA4LBW4F41vMP3YF0RAd/TR9MzAatpJqO/y1ox/L1K+MvX1TsAsHrBMIkFc3QgsOrD7p9w8ifZMQeA0Mba6NdC0ms66+aWT2cXT/AF3Tmn/F8Qgh5kxiwZAqQ6czu9axVpO1Tr48CJt45FnHAMBR2BecHUv520qixxwAxMOSfOw5DraeAJECseixWpyNrAoMPEc3aCkwiIuUoXDXxumVvhxP0m0vYKZIxbaPXFRPmAuwem0xXoJ9yPNCyhU+g+2HXFdVNWDP6Q0Qa8eHVzi5px3eW1nujy1JCLEEsOf8sW4ji11F7EaKGuLOVQjFjX0P0mtS4v7WTD/qqajSZSe31yjFuo1RJQ92YQJrZOg1h9bosD74MLMlouSjVp/lX5zx/mnYx03cBhxA8+5Ym0edqOD8Juln0EgNe8MlQv8G0M7wD4lYqTIe2ACjELHCx9vdulViFbPAgIOO6KkZPOxMzARBrF5d4ntbpstDprm9L43R1e9+rGOPpOhxDkUhrupUkZKpwbpMhpE9QdV6/LgzeBSWG8bQaiDSv3E0zrsJRokpwB/4eIrVMD+zgl1JMWkf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5ic1pna0p0OGNGQmlGOWtsV3dpTVVNRXlCNmtlS0ZNZ3V6eG9GL3ZBNGNz?=
 =?utf-8?B?d3pyb3FtdWR1SUxaMWR0ejlnWThMRUF5a05mSzgzSnJtbFJtRWlWQSsxc0JY?=
 =?utf-8?B?eFFYQno2UUVQVEROQXFZMUtpVVpsZ0ozU2NkQWc1bnRsUEx3SXgwZkUzK3RC?=
 =?utf-8?B?ZkpxNGE5cjZxS2VyQU1PWFlaa0EyeU9WSW1BSTh3bVFRQmdRcEg1YTV4UGhE?=
 =?utf-8?B?TTN3dGhZcGhMYU9hYzlJR2lQak16WHhjS3hONnJncXVZUWVtZzZPYnBOT3Fy?=
 =?utf-8?B?R0dvaCtrTWRBUzk5ZEcvWW9OdmRPM1dqYVZDd0NmdTZSWnF0WlVCMlgrWDRG?=
 =?utf-8?B?emxhcUM2MEtPOXpqMVV5WXZNTVRnSTBSSEpRdFJhKzZWS1g4UU1SQkg3TkJo?=
 =?utf-8?B?NUxXN09HdDFQaXV2SDZtMzk2a1k3azA1S3JLV3B4Wk9TTHcxLzhsTjdtaUVZ?=
 =?utf-8?B?Tnp0MkdJVjVnZXVWTmU2RXhmZ1JQU2o3NDU2R0g1MmM1NGovSFBtVEFQcU9L?=
 =?utf-8?B?aHBaMkl2K0VQU2JSbWh1TEErSCtIQytzQ3YySG9zbWRzeXBiRnFwTCtCSmVt?=
 =?utf-8?B?c2c4ZytnYXZSdnF0V09rUlphcGFBR2ozdVd1dmtYWUpUU1VURURZRktKZlZa?=
 =?utf-8?B?QmhMMVYwTzhnT2pUc1FndHlTSk0xSVdBbmc3SkZnbncwL2lZSDc2TmM5RFpk?=
 =?utf-8?B?Z2VUb1hvellIUFBIUmpMNlo4dzAwamlRNTdYVExTVlc2cUdWUVRDS29rSm1T?=
 =?utf-8?B?T1ljVy9TaFN2bUF5Sm1OdEdXeU1LOTFZalJjalhtbzVuZUxKc1BmbVo1QnNu?=
 =?utf-8?B?NUpsZ2t1emc4OVBQa0pVUTRlY3Fwai8yMHZ1UW5yU1htTFlTQUw1OG9tNkR4?=
 =?utf-8?B?aGEwM05VN2QzTjNZcXM5elpML3FCcDVIRE9UUmh2RVYvZHFJQ28wTFhYWU4x?=
 =?utf-8?B?NXVUckRhVFlUZC9KYmxqeGRFU1hRaTBLWER0SHN1UzFzaWJWeE9CZFloaFBB?=
 =?utf-8?B?K0hFVHNSWlNtSHl0YktySWcxc1hQTXZVdFRRbnp3UllrVnlsaDlqVkM4MEdu?=
 =?utf-8?B?SVpmZkpIWDhORXJ0NE1qcXc2VkdkNlNrQlJKeVNTYlE2LzV2NXBXZ005QXFZ?=
 =?utf-8?B?Wk44MmtnRDlpRE1pOHdMTkZmb25vVzZQRkxpMXRwVGFpMDRZVEQweTg2UWlW?=
 =?utf-8?B?bVl6QW1NaHZSQjZOQzF1TWNiaFJ6dmU4d2cvNFhtUGxsRm81MjF5aUhmNjFD?=
 =?utf-8?B?RHA2RkNYRzhaTTdVTXF0OXJlcHhpMlZxV1F6d2tUM0xGRE9SbnN1K0RIZVp3?=
 =?utf-8?B?U2Vrd20zanVLWEtkTmYvSEtEQVkrTTNwR0ljR1M5cUt5T0ZjZnlmSmJkUWZ6?=
 =?utf-8?B?Tm5ocEt3Q01yUjE1YjdzcjdNbzE0ZzIwYlQ0UzI5dXJIemdHNkNUSFVLS1g5?=
 =?utf-8?B?UmZ5QURyVjNNNFZ0ZFQ4WlA2NGxjLys1SzUrbmkrOWZqdDJOSGxvYjFweFh1?=
 =?utf-8?B?aUpPL1hYRGFJY1cxTE5PMzVUaThQVi9Hd0pucFZrMU9rSitHbEV5YUhSakNC?=
 =?utf-8?B?UVZuejRKcjlaN3FQelVFNncwM2tvRDlGc3U5OUZKOFVxcUdYRW9nV1c5UFRt?=
 =?utf-8?B?MjROemt0YkFpSUU1T0M5SGFuSlUwR0pGVU5FSkRmWXJzUlBaZDVKMzJueDVF?=
 =?utf-8?B?UUxyV3o5bitYUUxtYU95ajJ2NkpQUmo0cFpVNnVuZ3J5RHhJbFBLbmdWa2xW?=
 =?utf-8?B?Zjl2UWIrQzVWZEVKQ0V0d2RFZVIvcjVwcjJmNC9Bbi9lNzFDQkZuY2hOczVD?=
 =?utf-8?B?YTgvSlAwNFJBQkRhMjY0Z3ptUUw4M295MnBMMFZpMGZ2QkU3ZlE3TTVrdTR1?=
 =?utf-8?B?RllxYVB5SDlsVGhwRUNiQzdLU2pDNW9FS3NEd0dWZGxlZzRkWWc3eWMzRnZM?=
 =?utf-8?B?ZHVqcExmRnp3RjgyUy9jemtuaDI0dWo4OXhCTndMNnl0bTBBd1hvbGZiQytL?=
 =?utf-8?B?NnpwVEI3UFlPdlVBSDVUdVpMenNLYUhwQXRyZ0o4djVzcVp2WGpIWXRHZUtQ?=
 =?utf-8?B?OXcvbU5jSm50QWdpVjRPSjFIV3RYblg4Y2RUdUlMTUphM28yS3EyOVdzS1Rh?=
 =?utf-8?B?MU5vUkxIelpvTENwWUJNUEl5MXFvSjZvU2tpOVRPa1hPTFFQZnlZbUMyUEVQ?=
 =?utf-8?B?ZkVWM200cmZpYmFyVXgwS0h2WjM3czhOUnN4bjJpdGszVWQ0WWFhY2xLZVlK?=
 =?utf-8?B?MVoyLzZldGpUYy9GdSt6UzhicDhxYmZ1Nnh4cVBxSW12NERkdnBSOGhnV2FN?=
 =?utf-8?B?Wk1kNEVKZE9GLzJNOVRnRkM3NUM4T2tJalNKcnRiaklPdUpkeXRFeUx5dHhN?=
 =?utf-8?Q?Pw0BUykPuOtBuFzKXmuEtZpylWVcJt6qhepNpjLq0+pjo?=
X-MS-Exchange-AntiSpam-MessageData-1: 4Hmlj3qg1fRzJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4073ff4f-65f4-4a8e-5c0b-08deb55251d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:57:10.9808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7Redj5z3XP0FuFb7+Ivf5BoSeRt/a7FX/4/mROQ70cZXZva4dAAu4MtHone/YT92S3/iQSJci+f/7s1Mz7VCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Move constants and functions to be inside the impls of the types they
are related to. This makes it more obvious what each type and value is
for.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 Documentation/gpu/nova/core/vbios.rst |   2 +-
 drivers/gpu/nova-core/vbios.rs        | 185 +++++++++++++++++-----------------
 2 files changed, 96 insertions(+), 91 deletions(-)

diff --git a/Documentation/gpu/nova/core/vbios.rst b/Documentation/gpu/nova/core/vbios.rst
index a4fe63422ede..9d3379ccfb30 100644
--- a/Documentation/gpu/nova/core/vbios.rst
+++ b/Documentation/gpu/nova/core/vbios.rst
@@ -232,7 +232,7 @@ Falcon data in the VBIOS which contains the PMU lookup table. This lookup table
 used to find the required Falcon ucode based on an application ID.
 
 The location of the PMU lookup table is found by scanning the BIT (`BIOS Information Table`_)
-tokens for a token with the id `BIT_TOKEN_ID_FALCON_DATA` (0x70) which indicates the
+tokens for a token with the Falcon data token id (0x70) which indicates the
 offset of the same from the start of the VBIOS image. Unfortunately, the offset
 does not account for the EFI image located between the PciAt and FwSec images.
 The `vbios.rs` code compensates for this with appropriate arithmetic.
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 9cc2f008bbfb..07b5235faff8 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -27,16 +27,6 @@
     num::FromSafeCast,
 };
 
-/// The offset of the VBIOS ROM in the BAR0 space.
-const ROM_OFFSET: usize = 0x300000;
-/// The maximum length of the VBIOS ROM to scan into.
-const BIOS_MAX_SCAN_LEN: usize = 0x100000;
-/// The size to read ahead when parsing initial BIOS image headers.
-const BIOS_READ_AHEAD_SIZE: usize = 1024;
-/// The bit in the last image indicator byte for the PCI Data Structure that
-/// indicates the last image. Bit 0-6 are reserved, bit 7 is last image bit.
-const LAST_IMAGE_BIT_MASK: u8 = 0x80;
-
 /// BIOS Image Type from PCI Data Structure code_type field.
 #[derive(Debug, Clone, Copy, PartialEq, Eq)]
 #[repr(u8)]
@@ -65,14 +55,6 @@ fn try_from(code: u8) -> Result<Self> {
     }
 }
 
-// PMU lookup table entry types. Used to locate PMU table entries
-// in the Fwsec image, corresponding to falcon ucodes.
-#[expect(dead_code)]
-const FALCON_UCODE_ENTRY_APPID_FIRMWARE_SEC_LIC: u8 = 0x05;
-#[expect(dead_code)]
-const FALCON_UCODE_ENTRY_APPID_FWSEC_DBG: u8 = 0x45;
-const FALCON_UCODE_ENTRY_APPID_FWSEC_PROD: u8 = 0x85;
-
 /// Vbios Reader for constructing the VBIOS data.
 struct VbiosIterator<'a> {
     dev: &'a device::Device,
@@ -110,73 +92,79 @@ struct VbiosIterator<'a> {
     }
 }
 
-/// Return the byte offset where the PCI Expansion ROM images begin in the GPU's ROM.
-///
-/// The GPU's ROM may begin with an Init-from-ROM (IFR) header that precedes
-/// the PCI Expansion ROM images (VBIOS).  When present, the PROM shadow
-/// method must parse this header to determine the offset where the PCI ROM
-/// images actually begin, and adjust all subsequent reads accordingly.
-///
-/// On most GPUs this is not needed because the IFR microcode has already
-/// applied the ROM offset so that PROM reads transparently skip the header.
-/// On GA100, for some reason, the IFR offset is not applied to PROM
-/// reads.  Therefore, the search for the PCI expansion must skip the IFR
-/// header, if found.
-fn vbios_rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
-    /// IFR signature.
-    const NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE: u32 = u32::from_le_bytes(*b"NVGI");
-    /// ROM directory signature.
-    const NV_ROM_DIRECTORY_IDENTIFIER: u32 = u32::from_le_bytes(*b"RFRD");
-    /// Offset of the NV_PMGR_ROM_ADDR_OFFSET register in IFR Extended section.
-    const IFR_SW_EXT_ROM_ADDR_OFFSET: usize = 4;
-    /// Size of Redundant Firmware Flash Status section.
-    const RFW_FLASH_STATUS_SIZE: usize = SZ_4K;
-    /// Offset in the ROM Directory of the PCI Option ROM offset
-    const PCI_OPTION_ROM_OFFSET: usize = 8;
-
-    let signature = bar0.read(NV_PBUS_IFR_FMT_FIXED0).signature();
-
-    if signature == NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE {
-        let fixed1 = bar0.read(NV_PBUS_IFR_FMT_FIXED1);
-
-        match fixed1.version() {
-            1 | 2 => {
-                let fixed_data_size = usize::from(fixed1.fixed_data_size());
-                let pmgr_rom_addr_offset = fixed_data_size + IFR_SW_EXT_ROM_ADDR_OFFSET;
-                bar0.try_read32(ROM_OFFSET + pmgr_rom_addr_offset)
-                    .map(usize::from_safe_cast)
-            }
-            3 => {
-                let fixed2 = bar0.read(NV_PBUS_IFR_FMT_FIXED2);
-                let total_data_size = usize::from(fixed2.total_data_size());
-                let flash_status_offset =
-                    usize::from_safe_cast(bar0.try_read32(ROM_OFFSET + total_data_size)?);
-                let dir_offset = flash_status_offset + RFW_FLASH_STATUS_SIZE;
-                let dir_sig = bar0.try_read32(ROM_OFFSET + dir_offset)?;
-                if dir_sig != NV_ROM_DIRECTORY_IDENTIFIER {
-                    dev_err!(dev, "could not find IFR ROM directory\n");
-                    return Err(EINVAL);
-                }
-                bar0.try_read32(ROM_OFFSET + dir_offset + PCI_OPTION_ROM_OFFSET)
-                    .map(usize::from_safe_cast)
-            }
-            _ => {
-                dev_err!(dev, "unsupported IFR header version {}\n", fixed1.version());
-                Err(EINVAL)
-            }
-        }
-    } else {
-        Ok(0)
-    }
-}
-
 impl<'a> VbiosIterator<'a> {
+    /// The offset of the VBIOS ROM in the BAR0 space.
+    const ROM_OFFSET: usize = 0x300000;
+    /// The maximum length of the VBIOS ROM to scan into.
+    const BIOS_MAX_SCAN_LEN: usize = 0x100000;
+    /// The size to read ahead when parsing initial BIOS image headers.
+    const BIOS_READ_AHEAD_SIZE: usize = 1024;
+
+    /// Return the byte offset where the PCI Expansion ROM images begin in the GPU's ROM.
+    ///
+    /// The GPU's ROM may begin with an Init-from-ROM (IFR) header that precedes the PCI Expansion
+    /// ROM images (VBIOS). When present, the PROM shadow method must parse this header to determine
+    /// the offset where the PCI ROM images actually begin, and adjust all subsequent reads
+    /// accordingly.
+    ///
+    /// On most GPUs this is not needed because the IFR microcode has already applied the ROM offset
+    /// so that PROM reads transparently skip the header. On GA100, for some reason, the IFR offset
+    /// is not applied to PROM reads. Therefore, the search for the PCI expansion must skip the IFR
+    /// header, if found.
+    fn rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
+        /// IFR signature.
+        const NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE: u32 = u32::from_le_bytes(*b"NVGI");
+        /// ROM directory signature.
+        const NV_ROM_DIRECTORY_IDENTIFIER: u32 = u32::from_le_bytes(*b"RFRD");
+        /// Offset of the NV_PMGR_ROM_ADDR_OFFSET register in IFR Extended section.
+        const IFR_SW_EXT_ROM_ADDR_OFFSET: usize = 4;
+        /// Size of Redundant Firmware Flash Status section.
+        const RFW_FLASH_STATUS_SIZE: usize = SZ_4K;
+        /// Offset in the ROM Directory of the PCI Option ROM offset.
+        const PCI_OPTION_ROM_OFFSET: usize = 8;
+
+        let signature = bar0.read(NV_PBUS_IFR_FMT_FIXED0).signature();
+
+        if signature == NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE {
+            let fixed1 = bar0.read(NV_PBUS_IFR_FMT_FIXED1);
+
+            match fixed1.version() {
+                1 | 2 => {
+                    let fixed_data_size = usize::from(fixed1.fixed_data_size());
+                    let pmgr_rom_addr_offset = fixed_data_size + IFR_SW_EXT_ROM_ADDR_OFFSET;
+                    bar0.try_read32(Self::ROM_OFFSET + pmgr_rom_addr_offset)
+                        .map(usize::from_safe_cast)
+                }
+                3 => {
+                    let fixed2 = bar0.read(NV_PBUS_IFR_FMT_FIXED2);
+                    let total_data_size = usize::from(fixed2.total_data_size());
+                    let flash_status_offset =
+                        usize::from_safe_cast(bar0.try_read32(Self::ROM_OFFSET + total_data_size)?);
+                    let dir_offset = flash_status_offset + RFW_FLASH_STATUS_SIZE;
+                    let dir_sig = bar0.try_read32(Self::ROM_OFFSET + dir_offset)?;
+                    if dir_sig != NV_ROM_DIRECTORY_IDENTIFIER {
+                        dev_err!(dev, "could not find IFR ROM directory\n");
+                        return Err(EINVAL);
+                    }
+                    bar0.try_read32(Self::ROM_OFFSET + dir_offset + PCI_OPTION_ROM_OFFSET)
+                        .map(usize::from_safe_cast)
+                }
+                _ => {
+                    dev_err!(dev, "unsupported IFR header version {}\n", fixed1.version());
+                    Err(EINVAL)
+                }
+            }
+        } else {
+            Ok(0)
+        }
+    }
+
     fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
         Ok(Self {
             dev,
             bar0,
             data: KVec::new(),
-            current_offset: vbios_rom_offset(dev, bar0)?,
+            current_offset: Self::rom_offset(dev, bar0)?,
             last_found: false,
         })
     }
@@ -186,7 +174,7 @@ fn read_more(&mut self, len: usize) -> Result {
         let start = self.data.len();
         let end = start + len;
 
-        if end > BIOS_MAX_SCAN_LEN {
+        if end > Self::BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit.\n");
             return Err(EINVAL);
         }
@@ -205,7 +193,7 @@ fn read_more(&mut self, len: usize) -> Result {
         // Read ROM data bytes and push directly to `data`.
         for addr in (start..end).step_by(core::mem::size_of::<u32>()) {
             // Read 32-bit word from the VBIOS ROM
-            let word = self.bar0.try_read32(ROM_OFFSET + addr)?;
+            let word = self.bar0.try_read32(Self::ROM_OFFSET + addr)?;
 
             // Convert the `u32` to a 4 byte array and push each byte.
             word.to_ne_bytes()
@@ -267,7 +255,7 @@ fn next(&mut self) -> Option<Self::Item> {
             return None;
         }
 
-        if self.current_offset >= BIOS_MAX_SCAN_LEN {
+        if self.current_offset >= Self::BIOS_MAX_SCAN_LEN {
             dev_err!(self.dev, "Error: exceeded BIOS scan limit, stopping scan\n");
             return None;
         }
@@ -275,7 +263,7 @@ fn next(&mut self) -> Option<Self::Item> {
         // Parse image headers first to get image size.
         let image_size = match self.read_bios_image_at_offset(
             self.current_offset,
-            BIOS_READ_AHEAD_SIZE,
+            Self::BIOS_READ_AHEAD_SIZE,
             "parse initial BIOS image headers",
         ) {
             Ok(image) => image.image_size_bytes(),
@@ -416,6 +404,9 @@ struct PcirStruct {
 unsafe impl FromBytes for PcirStruct {}
 
 impl PcirStruct {
+    /// The bit in `last_image` that indicates the last image.
+    const LAST_IMAGE_BIT_MASK: u8 = 0x80;
+
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
         let (pcir, _) = PcirStruct::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
 
@@ -439,7 +430,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
 
     /// Check if this is the last image in the ROM.
     fn is_last(&self) -> bool {
-        self.last_image & LAST_IMAGE_BIT_MASK != 0
+        self.last_image & Self::LAST_IMAGE_BIT_MASK != 0
     }
 
     /// Calculate image size in bytes from 512-byte blocks.
@@ -505,10 +496,10 @@ struct BitToken {
 // SAFETY: all bit patterns are valid for `BitToken`.
 unsafe impl FromBytes for BitToken {}
 
-// Define the token ID for the Falcon data
-const BIT_TOKEN_ID_FALCON_DATA: u8 = 0x70;
-
 impl BitToken {
+    /// BIT token ID for Falcon data.
+    const ID_FALCON_DATA: u8 = 0x70;
+
     /// Find a BIT token entry by BIT ID in a PciAtBiosImage
     fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
         let header = &image.bit_header;
@@ -604,6 +595,9 @@ struct NpdeStruct {
 unsafe impl FromBytes for NpdeStruct {}
 
 impl NpdeStruct {
+    /// The bit in `last_image` that indicates the last image.
+    const LAST_IMAGE_BIT_MASK: u8 = 0x80;
+
     fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
         let (npde, _) = NpdeStruct::from_bytes_copy_prefix(data)?;
 
@@ -627,7 +621,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
 
     /// Check if this is the last image in the ROM.
     fn is_last(&self) -> bool {
-        self.last_image & LAST_IMAGE_BIT_MASK != 0
+        self.last_image & Self::LAST_IMAGE_BIT_MASK != 0
     }
 
     /// Calculate image size in bytes from 512-byte blocks.
@@ -799,7 +793,7 @@ fn get_bit_token(&self, token_id: u8) -> Result<BitToken> {
     /// between them, so subtract the PCI-AT image size here to convert it to a FWSEC-relative
     /// offset.
     fn falcon_data_offset(&self) -> Result<usize> {
-        let token = self.get_bit_token(BIT_TOKEN_ID_FALCON_DATA)?;
+        let token = self.get_bit_token(BitToken::ID_FALCON_DATA)?;
         let offset = usize::from(token.data_offset);
 
         // Read the 4-byte falcon data pointer at the offset specified in the token.
@@ -846,6 +840,17 @@ struct PmuLookupTableEntry {
 // SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
 unsafe impl FromBytes for PmuLookupTableEntry {}
 
+impl PmuLookupTableEntry {
+    /// PMU lookup table application ID for firmware security license ucode.
+    #[expect(dead_code)]
+    const APPID_FIRMWARE_SEC_LIC: u8 = 0x05;
+    /// PMU lookup table application ID for debug FWSEC ucode.
+    #[expect(dead_code)]
+    const APPID_FWSEC_DBG: u8 = 0x45;
+    /// PMU lookup table application ID for production FWSEC ucode.
+    const APPID_FWSEC_PROD: u8 = 0x85;
+}
+
 #[repr(C)]
 struct PmuLookupTableHeader {
     version: u8,
@@ -923,7 +928,7 @@ fn new(
         let pmu_lookup_table = PmuLookupTable::new(&second_fwsec.dev, pmu_lookup_data)?;
 
         let entry = pmu_lookup_table
-            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
+            .find_entry_by_type(PmuLookupTableEntry::APPID_FWSEC_PROD)
             .inspect_err(|e| {
                 dev_err!(
                     second_fwsec.dev,

-- 
2.54.0

