Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7705103E185
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21AD410E0D5;
	Thu, 19 Mar 2026 05:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5IS3ajq";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73D910E0D5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymCxsmMKeDhzun+3Ve1fFxBcxU1ybX0p4K/VkboG299IJ1n1q+Mai1hoJCl0Ei5QLCj4c4li7+hqukD+ESv+rfI3Mar8bqTmr9SzC2AtNFzD5wFk0TPU4H1/MKaU0RSOSbkofkqBCKGlmwG9FQeOWC+s0D8LG2jZ7tuEl1Nc5amrwOkv6F5IudnOn8nTwCCk3Xoc+TcfITJKc09l/3VMUrZj7caJLLj/nUi3yBryzvpCo7RyAMMRC8MaZgaR4Wb7mUGdiDup+cBMETdW347gEMi0KzJwFyHsPEE3kooiaGyo2F5Q0dpPsxILH5IaRyWaPcPnTsA9AgRJ/0zFvSj1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLX+IVPA4aU8lfkFsjWtCsdTL17qR/HrWvpyETZZyo0=;
 b=w3YuQZSH0Je+nW0/qo9dSjTpoiijjeGLx+HtPzPhW/ZhMuQtEw+aZwJ0rvZss6WJYCXvrVyDGiZF2Z+OMSQk5snKL8Sbeu1x86lY6eOxbR5U3T5Guy0ZE9delvOA5K3/SEgk6CcBzEppu28Y2lUfxc6zKVu7vy1iM6rMnOUizewf1c5TUyxLSv6dcKcEf0V683afua6b5KkshIvL3X9vQMurlxZ9H8zkQT80hr7SCypurHoSx17Kj9lSDB7m555n8SI/4XwNBtxf8aqT0QlMpepFNUdjx+9ynBn7Uxp7BFmo7p6lzwVH4YYqPoN2425C7muJCK3zuIbhrIfhfLqlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLX+IVPA4aU8lfkFsjWtCsdTL17qR/HrWvpyETZZyo0=;
 b=A5IS3ajqqpJL5wghiCXdVW8gaXsNCPL7JULn/7vjBBjlyGFe3Wo1P10lJINqUTOoD7M0In8HsuhFMOIxoJ8NIVTF25nMPIofZshOZgA62ATMjWUYrmsekzsPiXQOLWAGx7zDt0Lw2QP0CorcfjbiNO7B+J4H2aXISp1R7J2CjQ9m/GchHRGsEMD3ttmZBv3DdLlxC7ss/CFL8xEgkNIQ/v/VjndmhWC+nQQJbuGzGt/1DoWCsOYEXN9pM5taXO5wHkuiKMbxMpQAxZ2Hm00MsEAT5UxjIXhAufYb0eQIbe6/3XUY3WoAH6iAocYGnUUiB7yni2lH6AXgyZyXdBFnlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 05:37:01 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 05:37:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 19 Mar 2026 14:36:51 +0900
Subject: [PATCH] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0NL3eTclELd0iTdtMwK3RRT8yQDy0RzE9MkSyWgjoKiVKAw2LTo2Np
 aAG6BRuFdAAAA
X-Change-ID: 20260319-cmdq-ub-fix-d57b09a745b9
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0079.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fadc9a6-0828-41db-1ca0-08de85798b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: SXjohXttMBf+X/UyoYk/E9DBEYeZrKa4hDZb01kaPDfD+Xovpygzre885arnJzqlvGr8OJEndZSZoEtjvUt96vpFhwCnATp3kVXlZuJqmCQHATOHFdYGq/IBQkLaZNOT2rYebOGXTFY5XxTs6Y6hgMpxcahxYMAh8pKLXQHW/vqNT00JGiz6MPPbtAvFjyiBW5aw25HdOX9N/56UgfZN7oF2PWHIJOAQ7mq8ZXEw67CWt+SiPY4YFG7Pbr44Nr0y84/pPUigIob7Xj5DICtvEdyZJMm+MT7qc1s1QVBEJIf1PmqEOcX5X5lwXRN2ieYnoEN7gkjJAHAK6FRVAc1ylQfqP8DCtK/NMq9nYNj+fl03+sCLO37ZOfuuemFKnyRTiJ97z8wnOluKmaPrClSFxzfGuLULMAWdI+bTb49wxk/Irj1ugtAz151tP4MeeYERjo3sdjIn5zMxXcVnBDC1YpjGIUQZs+MJmQUhsKE9wKXKa3rDG9wNAnhk02oYdYFWBOfPDQyZGDwnAJrULqjctJPlzTiw66Zf0H0ottJZEVZyEBGuHGitsJeMaDDbkwYzdedebk1Ddl6moFl9mb9VLqaFdGGjFLB79+nQ09hHE3rLDXGIhwSRfLXVwDhHBNPlgGUmrGIAtaEu9hMgU412gflQjGoXEtKpbGkelEitJqVua70lOLR+NgjKdDztWhVE+zqJKtBP9g4GgW+N9qYt2zb3CtPsFwExeqUPEXS3ndGUWBPcuZ/eH9e1ScBi4YzW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0t1L25WRXJVWkN2bjRhb3p3NTRrdHp2VmlyVjBKUHByTjgvd280QUgwYzJ1?=
 =?utf-8?B?QVpTOTh1Q2VzVWZqTFplUU8weHVqME1TUW9xbVlScXMwUHJjSmxudDh0SEpM?=
 =?utf-8?B?dlcxeTI3OFptdzVRdlk5TWN2eEcraldBQkQySUM3YnZnNFBqOUI4MlpiNWFB?=
 =?utf-8?B?K2pGV3hSWE5mWncwdE96V2x6dDRORm9xQVFUcXgycjA1QUNDSzI3QzRscEJ5?=
 =?utf-8?B?SWZlWktxczNuQVNIRWZzTWJmdFhrV3pYWFBRZU4yZitmVlJGdU5KZjNsZnFN?=
 =?utf-8?B?OHkxdnhYWkFoVy9WSG0wWExreUFXcHAwSThNeDB0ZGlZdFJkR0tLU0NTQzgw?=
 =?utf-8?B?R2JaUUJCQmJwZ3kzaWtUQVNiSkRqZDUySFpsdjVwczNRbW5VdHVFallOdXgv?=
 =?utf-8?B?ZDlmUGNiOU9oKzhid0tzWG13eUFxU3RCamFwc3F3VUIxRyt2TVJvdElXWXJH?=
 =?utf-8?B?TktEM09iQjRDelBXTHBVVkxRclhhVUwrOVdwTytyREFCVnBER05BTmovSWxZ?=
 =?utf-8?B?aE1mdyswY1ArejdzeWxjaHN0a25WUjNUcnNxdkx6Kzd6UFBmRGMxaURDRG9m?=
 =?utf-8?B?eHdsdllXOGdqdHMwTTJCUlNMYUZzRFdza04vLzBZbm13Q0RqbWVNK2pVeTN2?=
 =?utf-8?B?MjdaR2pkVVA1ZzBoRGN3OUFqNjZtL0wzTWpVbUVodDdKSnJ4UmRxeUU1dnRG?=
 =?utf-8?B?YW1tQmRWVVFFWm1CanpFY21Jb2xEWXgySGZsYU9MMU9HRGZGa0xJZmEvTmJV?=
 =?utf-8?B?T0NuWGh5dHIyL2dTRVRiSUd5M255bHlDSjUrRWg1bW1GK3Y2aTBzZFRJRXVr?=
 =?utf-8?B?dUs3Uk9peVp1MEN4RDRmWi9lVUtPSHppM1dGT2dMa1hNaSs1UEdvNHVMYkF3?=
 =?utf-8?B?ckl1UFh6MTJnbll3Z0VIVlhKZzY4dUFLMzBDR0ZpWjJWd0s4aEpSWUtCZzNr?=
 =?utf-8?B?N0doRzExWVBLR2Q3YnB5S1JoMVNDdWJveUpWL1pOeXVpdDVFZVRZc3EvbmdX?=
 =?utf-8?B?UmpSODdzMGFFd1dNei9PSFZzVERHV3UwVlVRVGJJbnlkS0RaY2Nrc3N3S1I2?=
 =?utf-8?B?eDR3NjFUdnBqUkVNaTZWYmlBbVhmcFY2U1Nkcy94R2FlRTlDUyt4Tm5wRFlI?=
 =?utf-8?B?OUpla1BBMlR2S3NJNUQ1bFVMLzVudjd4eUJxV2dYTTFvU2tXVTVhTDladFZE?=
 =?utf-8?B?c01KRUJyVTNMb0Q3OFJlWFQxM0QzaGRVOGJ4aEVBSjhNR3BLU1NSU09LMDBG?=
 =?utf-8?B?Q2VDelNZWiszR0dtMmMrdGVvTjBEZVh6NGxNdjFXNncyTVFiMVlOU25waUpV?=
 =?utf-8?B?am5vN3dBODZDWnpvUWVicU9kZFFwNUJtRFk3MldpZDF6MWNoT1UwZzY0RE92?=
 =?utf-8?B?UTlYQVRtUm8rMlY3UW43RkZYb3F6em5wZjVMRGRrVUNtMHhJM2FIbkxkbVdB?=
 =?utf-8?B?c29ad1RTVXFrUmEzMG1WcHpBY3lRVndLVWM0bVl0d3RZU0I4Sm1DRGZQQkZL?=
 =?utf-8?B?NlBMT3ladTlRM0xmUTJMUm1CTUhobHRGSFEyTmZJRDRUTEh5MnlvVERJMjBS?=
 =?utf-8?B?cXdRZjZsbHVXSWkrbnhEZ2F3OGNyNGQ1eUcza2hJbktRZS9ad2NtVytlR3l5?=
 =?utf-8?B?M1VNTE05V3BIVEI0NEtxVjVidXJVSStaK2dwcFlOL2dXZytVZlZ3dURlY3BV?=
 =?utf-8?B?c1BLT01SVWpsT1B1ZzhpaUEwZlBVZll3ek44OVpCcWpTb0ZNaVRSWE1MdXpw?=
 =?utf-8?B?UVRMVFhNM0FZTU16MWhud1I1bWZYdW1zc3Z3ZnZLNDhKWWRoQ0lmZHZJS1Ri?=
 =?utf-8?B?NmFmRmdxa3l2OTVUYXRwSmxVL1dNaWZvNTE5aWdSSDY3eWdSRHUrdDhOeG5U?=
 =?utf-8?B?TVhOL3JhWE9vSDZROG1VZnR6dFlGS2x6RzFtby9YMklhSGQ1UkRydmlOaktk?=
 =?utf-8?B?MGdTM0diWXZzWWMzemxYakhtVUV6S1FWUlUxUnhISlV6RlBOR2pLVmljbzZU?=
 =?utf-8?B?OWdlZFh0ZDRmams5MFdFZ0FVWFFzQmhJVE10UEkzTnNKRkxnV0M4Nm9DaTZC?=
 =?utf-8?B?Z3RpYjBrUmFmNXVCRkYvdGdUM01nbVk5dUN4THhmMmhrRVRLMHo1TnJicTNM?=
 =?utf-8?B?Ry8xTG9MNnhidjFtbEtMcHNMZVVUeFFuRURvU0prUWdLNk5Rd0V2OEJYbkZI?=
 =?utf-8?B?R1RUVE5CSkM1WlhYcW0yK3NnTTlqRE40Q1hNQ0M5YjViSFFZazJ4QnZpUDB0?=
 =?utf-8?B?QStCVmtJNlVLN2JGV2NONXE4N212a1BDZWl2QUhoeGdBaDR6ZlBsTSttNjc4?=
 =?utf-8?B?cVFUUkZRTnRnR3djb2dJV0gzd0VZY0Z0clF5Rk5xSlVGa0R0N1pTMDJUcFRU?=
 =?utf-8?Q?/GkO2atrtUno4pL6RMvd0y3E03w/0Z7jwxJjEEDcdlH7C?=
X-MS-Exchange-AntiSpam-MessageData-1: ub1r4VqXgNpL3g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fadc9a6-0828-41db-1ca0-08de85798b54
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 05:37:01.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFWBN391Ak7iEN2w2AAnbJC4AN0lTOwjssZaCA5oSLuA9cDg+EjdERzGxL5VfsNwS08iOCe5y4IKhbA+Fs+9+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

`driver_read_area` and `driver_write_area` are internal methods that
return slices containing the area of the command queue buffer that the
driver has exclusive read of write access, respectively.

While their returned value is correct and safe to use, internally they
temporarily create a reference to the whole command-buffer slice,
including GSP-owned regions. These regions can change without notice,
and thus creating a slice to them is undefined behavior.

Fix this by replacing the slice logic with pointer arithmetic and
creating slices to valid regions only. It relies on unsafe code, but
should be mostly replaced by `IoView` and `IoSlice` once they land.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 135 ++++++++++++++++++++++++++++----------
 1 file changed, 100 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d36a62ba1c60..4200e7986774 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -251,38 +251,77 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut [[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.cpu_write_ptr() as usize;
-        let rx = self.gsp_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.cpu_write_ptr());
+        let rx = num::u32_as_usize(self.gsp_read_ptr());
+        // Number of pages between `tx` and the end of the command queue.
+        // PANIC: Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES`.
+        let after_tx_len = num::u32_as_usize(MSGQ_NUM_PAGES) - tx;
 
+        // Pointer to the start of the CPU message queue.
+        //
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = &mut unsafe { self.0.as_slice_mut(0, 1) }.unwrap()[0];
-        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_NUM_PAGES`.
-        let (before_tx, after_tx) = gsp_mem.cpuq.msgq.data.split_at_mut(tx);
+        // - `self.0` contains exactly one element.
+        // - `cpuq.msgq.data[0]` is within the bounds of that element.
+        let data = unsafe { &raw mut (*self.0.start_ptr_mut()).cpuq.msgq.data[0] };
 
-        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for writing.
+        // Safety/Panic comments to be referenced by the code below.
+        //
+        // SAFETY[1]:
+        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
+        // - The area starting at `tx` and ending at `rx - 2` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for writing and is not accessed concurrently by
+        //   the GSP.
+        // - `tx + after_tx_len` == `MSGQ_NUM_PAGES`.
+        //
+        // PANIC[1]:
+        // - Per the invariant of `cpu_write_ptr`, `tx < MSGQ_NUM_PAGES`.
+        // - Per the invariant of `gsp_read_ptr`, `rx < MSGQ_NUM_PAGES`.
 
         if rx == 0 {
-            // Since `rx` is zero, leave an empty slot at end of the buffer.
-            let last = after_tx.len() - 1;
-            (&mut after_tx[..last], &mut [])
+            (
+                // SAFETY: See SAFETY[1].
+                unsafe {
+                    core::slice::from_raw_parts_mut(
+                        data.add(tx),
+                        // Since `rx` is zero, leave an empty slot at end of the buffer.
+                        // PANIC: See PANIC[1].
+                        after_tx_len - 1,
+                    )
+                },
+                &mut [],
+            )
         } else if rx <= tx {
             // The area is discontiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - 1` is non-negative because `rx != 0` in this branch.
-            // - The index does not exceed `before_tx.len()` (which equals `tx`) because
-            //   `rx <= tx` in this branch.
-            (after_tx, &mut before_tx[..(rx - 1)])
+            (
+                // SAFETY: See SAFETY[1].
+                unsafe { core::slice::from_raw_parts_mut(data.add(tx), after_tx_len) },
+                // SAFETY: See SAFETY[1].
+                unsafe {
+                    core::slice::from_raw_parts_mut(
+                        data,
+                        // Leave one empty slot before `rx`.
+                        // PANIC:
+                        // - See PANIC[1].
+                        // - `rx - 1` is non-negative because `rx != 0` in this branch.
+                        rx - 1,
+                    )
+                },
+            )
         } else {
             // The area is contiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - tx - 1` is non-negative because `rx > tx` in this branch.
-            // - The index does not exceed `after_tx.len()` (which is `MSGQ_NUM_PAGES - tx`)
-            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` invariant.
-            (&mut after_tx[..(rx - tx - 1)], &mut [])
+            (
+                // SAFETY: See SAFETY[1].
+                unsafe {
+                    core::slice::from_raw_parts_mut(
+                        data.add(tx),
+                        // PANIC:
+                        // - See PANIC[1].
+                        // - `rx - tx - 1` is non-negative because `rx > tx` in this branch.
+                        rx - tx - 1,
+                    )
+                },
+                &mut [],
+            )
         }
     }
 
@@ -308,24 +347,50 @@ fn driver_write_area_size(&self) -> usize {
         let tx = self.gsp_write_ptr() as usize;
         let rx = self.cpu_read_ptr() as usize;
 
+        // Pointer to the start of the GSP message queue.
+        //
         // SAFETY:
-        // - The `CoherentAllocation` contains exactly one object.
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = &unsafe { self.0.as_slice(0, 1) }.unwrap()[0];
-        let data = &gsp_mem.gspq.msgq.data;
+        // - `self.0` contains exactly one element.
+        // - `gspq.msgq.data[0]` is within the bounds of that element.
+        let data = unsafe { &raw const (*self.0.start_ptr()).gspq.msgq.data[0] };
+
+        // Safety/Panic comments to be referenced by the code below.
+        //
+        // SAFETY[1]:
+        // - `data` points to an array of `MSGQ_NUM_PAGES` elements.
+        // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for reading and is not accessed concurrently by
+        //   the GSP.
+        //
+        // PANIC[1]:
+        // - Per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`.
+        // - Per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`.
 
-        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for reading.
-        // PANIC:
-        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
-        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
         if rx <= tx {
             // The area is contiguous.
-            (&data[rx..tx], &[])
+            (
+                // SAFETY: See SAFETY[1].
+                // PANIC:
+                // - See PANIC[1].
+                // - Per the branch test, `rx <= tx`.
+                unsafe { core::slice::from_raw_parts(data.add(rx), tx - rx) },
+                &[],
+            )
         } else {
             // The area is discontiguous.
-            (&data[rx..], &data[..tx])
+            (
+                // SAFETY: See SAFETY[1].
+                // PANIC: See PANIC[1].
+                unsafe {
+                    core::slice::from_raw_parts(
+                        data.add(rx),
+                        num::u32_as_usize(MSGQ_NUM_PAGES) - rx,
+                    )
+                },
+                // SAFETY: See SAFETY[1].
+                // PANIC: See PANIC[1].
+                unsafe { core::slice::from_raw_parts(data, tx) },
+            )
         }
     }
 

---
base-commit: a19457958c3018783881c4416f272cd594f13049
change-id: 20260319-cmdq-ub-fix-d57b09a745b9

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

