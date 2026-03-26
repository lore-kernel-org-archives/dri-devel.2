Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BCF109E557
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 05:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5BD10E8E5;
	Thu, 26 Mar 2026 05:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SaDlZ6LW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013040.outbound.protection.outlook.com
 [40.107.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98DD10E8E5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:43:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwDMvyc9pAdIh0WqJwPinjaqLxq5aA6WB5ynO/29MT6fVMJUckabwGspdL8JlX1nLk6WdcFLH5XKxsZ02vIFQTcRvKfassp+6fkuHGR1iYT9Um/Ihu1bpw7ylcvHXXwVzcKM5xQXcMW05d5uKdLkB2UTwWwipE5BmE5pJVzVleZCgzBDQXLP0+fX+VlKqRnFS0s+Q0AHda1kSB1esAHT9NJpsKgPjxonqKDNo/RJMVK7gBJQkv/HzpNM7MemidfuyrVrqztzUFKxYU8HKOgWIbxKrV7+wUxb0nQ/orbY+8k7DQYhcGx7ZXPXsFHcY3+5Y4vU+TBT7a687XVzUGZ0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzc0D3Nf6Ixco5ZxzUaTMxP84qa2zZeMWcqvcUpdqOg=;
 b=EuJUSImYtBeeeaMjQc5NvHFCa1GhQuIa5GPv/nU2uvxiVqa+mUE9oaO+G/w53Wv4+iTV1sjeASe5aYsBkQGhlxePAI1DE6wZmJZLpXA/mPuS5daFY6XhBr/FGjoSrHsnDFbCDYqH68x0tmZdfwjjJbOcSnINVPp4KIspfSX2oBbJ2anNwGw8h2zEsH+Plm6ev7wKjr+p9CzWrFwxw2Y/XrHwS7LEVoSFRQsKUBDLV8E7+jomhsuPkfYBJCPZfVgksZ0i/kBaagAZU2iyFqEW/cg4eVW4B3Ely12yG+pt4wWZ36q33GZOH/EqfKGEoxjLHxNnDzS7AMInTd6T9nTCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzc0D3Nf6Ixco5ZxzUaTMxP84qa2zZeMWcqvcUpdqOg=;
 b=SaDlZ6LW9RngETsqE1GPPAZIf/dk0qSw9OPRSCqghiYKioKHMn44Lmav7YaJpXQqZq6akN4RYQY6TOVrXFrbrmJenhCqITZ5FvUOoFAiEfdfVYMw3ExPiDAyYfviLQ2FQsPHj0A8BfyCYdzxKipxPbQ+4omrpNUoyq2yF3Phv29drMN2y1tSIVcfi764syf5/zU0dHVoJjlm1gE0qrET3yW8zczRfJftwQalivCH1+mqM582h7nTOyPojaRSz+ABimPZxcqDy/ZomIMzdZg9XWzC0t7ZEayPnw9PLe8mSsV+9eraECW2y3ih0LW56/nfFmMjJRSzonZFb4TaBE4AAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 05:43:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 05:43:52 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 26 Mar 2026 14:43:42 +0900
Subject: [PATCH v3] gpu: nova-core: gsp: fix undefined behavior in command
 queue code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-cmdq-ub-fix-v3-1-96af2148ca5c@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MSw6CMBQAr0K69pl+hFpX3sO4oO2rvAWgrTYaw
 t0trCRxOZPMTCxhJEzsVE0sYqZE41BA7Srmuna4IZAvzCSXDVfCgOv9A14WAr3B19py0+pDbQ0
 rxT1i0evtci3cUXqO8bPOs1js/08WIIAHExo8BuVQnYdMntq9G3u2jLL8iaXaxrLEWnshhXIq6
 LCJ53n+AtlTBA/kAAAA
X-Change-ID: 20260319-cmdq-ub-fix-d57b09a745b9
To: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c10f0d-73b8-40b3-e7ff-08de8afaa96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Dw+4gB7NffKTRXghPtD/kR2X7P/4tqle62aKbvFyc1OVIS/HBkGHL2EAIOCKtyLu0BgBIPZpXSISg1hcDQpkWELg27Ssx+dbGSsipBchVkvWfzChyhHG952kHo3/jq5KOPpDaCskbAJcG9LFXhByvuM1KEQe6vmbMyorbKayjBCUbgBKVxtpx2QJq7S8SoYydrodt62880IHwDNesyohA1HEHJT0Qi2H/S45MyGSwqCK5L34f+nHvGCwxuxQT78dCfkeM6Qi2UYclLIgbv+Hvr9k2xBdtuSkj2r38pPXzwk6eMUwVT0TngbcJS3rP08dB0KTCtnyl1IbIClxBNI1LU2zRX2E8jHZ0pE/QMy7fWKe1qIXlZ3PBPJJHn82Y2nANom+zZ7Ha0cj9PoS+sXm0323KN5dawQiou+0+ZXVM8WlwhRp9UYAMVu3V9oGI9Fp777W60Nxpw+QyA+PxrckJdjy6a5eao8j3A0xK2ASRpM2HnfLzD2WFkgBPcW9acEwyHG/S09r3gaDBd7rM5UNa2rtrV3Herr9YllZ+vxuFbvI2iR2Sat6+5qoceldZJmoIprNJmQe87AArdTirbdeNK1RYVrYsHRs6MVE5WpIVrSXvHRjhRVyU+0Lda123N0Tb/LoSoHYW0lI9LS8psALyIiL8zjEXoawIABCwtDOnsIlHqLM7gfaGSeB8lOva0WtumEMHzLus6UWH+p7cl1VW7TjWoO3TSzKLQ2vGeTpaM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRGVy9Qa1pTVHplcE9VNUx1b2NBaGdYSzBFMk1pc0xGeVFIMzBUeTRrRlhY?=
 =?utf-8?B?eER5NEd1Sng1V29RK2hKVGFRTXJtVGVYQnVVNEJhOUpwRG1Yay9pTEd6TmlI?=
 =?utf-8?B?VG80ZzQ3alBMeDNtbjUrNDBPcXpTbU5TQTZkUGVhRGhISE42YnR4Qk9oTmt5?=
 =?utf-8?B?U3FIME5SNzF0OUh6SW1xKzFnczVseVBaV3I5UnRnZGRzc1hwdkdTNzlZRTRF?=
 =?utf-8?B?aXVTMWpseWFaWGsrSzYvOEpsczZ3WlBUb3VodmxaWGRPaVkzMDV6THBJTFl2?=
 =?utf-8?B?UE8xb2MwY204djhrMWxXbmV1TW5CVlZOWWJucUxHVG1JSTFFWUlGSWlLanly?=
 =?utf-8?B?aEJvTWFTaFZ2UmdNNHkxUW9nVS9EVU5mb2NGNy9vOHFtbTI5a0wwZldHSCta?=
 =?utf-8?B?Qm9HS29LWmFLL3VJUDE1dHR1TDlDOGZxaVRWR3NzdjBZTkw1bVloeHdrdFZM?=
 =?utf-8?B?SXBzTVFSVDNsNFZqZERaZjVRVEVMOFdwNzdFaFF3aEx6YXpCS21oSXhuRU9W?=
 =?utf-8?B?UUdWMUNBNWxJWTc2a2ZDZVVoM2lkMDcrZGlIdXBtait4ZjZzMk8xTE92VDNy?=
 =?utf-8?B?YmowWC8wMFdNWlZnVU53Tlc0Z01XdVFRTnBMODdUcEFGbXNvaG1nYXJYT3VL?=
 =?utf-8?B?eThKZTR1YWo0TGd5dVA5OG5yS2hkQ0hvbW1wV082d1NXVHB0cXFhYVgwYzhV?=
 =?utf-8?B?cGgzZ1BmVnlhWGdnV0VyY25BSU84UVV4U3BKT1JNclBDUWpBRzNFd1lpME9E?=
 =?utf-8?B?eTluQVloVkZFTFhtRXlzRGFkaXdCVEZMaG5pUzVtaHdOdnZSblU0TmxoSVZu?=
 =?utf-8?B?Wkg1cDJlazNZdUxKY3pXS2xiaFFlN25DUDNCSExCYmV1SmZKMCsyL1F3Z2s4?=
 =?utf-8?B?QVZYTVN1THl2SGlPTG1YcW5iQTYzanpocENpdGtndEpLeG1KNER6VC9PQ0py?=
 =?utf-8?B?L29xaVFaK1lwYnlsanhVTkZDWG0rcTJKbHhFaW1aZ2ZPMlhlMzRjU2Ztd2VI?=
 =?utf-8?B?WVJrTmRvV1k0RXp3TEdFSVVOZlpKZUJLcjU2cEJEN3Zza2ZRTHBGcHVRa0xk?=
 =?utf-8?B?ZU1wcW84M2Rrai9LeC9TRVdpck1rcUltWWpubjZzYlVuU0ZJNU4ycEdpTGJR?=
 =?utf-8?B?RTA2ZUVnTWVOWjZINjMwVnp1NWtVdXpCMUxRdEJtT3hVazBEY2cxU05NVVhx?=
 =?utf-8?B?MENJZnI3VDFkNXBnMEV0ZDVBayt2MUVLb2R3T2phSGNjZTRjSHN6VVhjMnN5?=
 =?utf-8?B?Y0xkM3laU0ErUzFvNzl2a0R0S1JLL2x4dnNjSUpYdUxrbFAyQXJUYzJSODg1?=
 =?utf-8?B?U25hb1JMSG5PS2V4dE5jSldOcmFQZ0dDYXNWZlIwdGhRM3QzZ2ZjL0lKNjhO?=
 =?utf-8?B?TlFrSnNxb3NXYzhoL0NtTUZwYm1GcE5lOFp6LzZWd2RsU205Z29uTjkvdGRF?=
 =?utf-8?B?TDdWbVNyWVh2VklGbUhIbHZ6eXQzamlxVDM3YVl5VDJPMUFFM3ZTOFpmQW0y?=
 =?utf-8?B?dmlGcmRaOG9FcFZOMk9WYjNtS0RTaXpwSk5VUDhBQ0RTM0NhYWdoQUtyTkZa?=
 =?utf-8?B?ZmUwTnJKWHZHZWE1QW1EbS9peVhpVGpTdlExRWlXYXZRUlM5Vms3SVRid3BK?=
 =?utf-8?B?ZFp1T1lNc292dTJicUpkUHRhQkdUNXAzSXhEcGllUnNSVHBidGZJbm0wSEpt?=
 =?utf-8?B?V1p6dlZvSFB4US84OTZjZCtHZGxIUUFPaGQ1MHYvUzNrQlUwaE9seU5oMm9o?=
 =?utf-8?B?SGoyb0NZWjZITDdSQVlFd3MxRHllNlZueFNRSFBsV2xWTkRFNExhR2ZDQlJI?=
 =?utf-8?B?OHhpemJwY3AxWjFyQUJpR0dxS2JwYXRwQWEycGF6eURWRUFhNytTbVR3cDhq?=
 =?utf-8?B?bkVuQTl4ZnlOOERLL0FzTG9PRDZ0Uy9VUkE5WE0zbnhweXhNVnY2Ull3UWg0?=
 =?utf-8?B?d3hpU2c0ZVp4aDFJZVlsdE5kU29uZXhzT0hLQTAzTHR0bFJMamhGdVhIUTdN?=
 =?utf-8?B?WTJTc3Z2UlNHelo2VmZkVWtvWUNPUlh5NUxMTVZ1TVFrMFZKOGlDY1JaTjNn?=
 =?utf-8?B?OXhaWkFvelBGYzg1SzBFY1JLWGM1QTc1RzFtNkJHVGduT091alV3NWRTY1Mx?=
 =?utf-8?B?dnloY2kwVmxnR3N4SFhNbHkrMXFyMW81dW55WDl6N3Ivbk96dGRwQVc0enk0?=
 =?utf-8?B?UzU5Z1Z0MWFkTnhSMDgyWU5nQ2F4TkdmQzBzQk9EemtkNGl6Rml6aVVVMkJi?=
 =?utf-8?B?TE5JbUxFZVhFRlNTd1VvaXpOemJXT0s2dWJjenRTVTRxZXlDeXpqN0pzK1pT?=
 =?utf-8?B?cFRoWGd1M3BKdUF1UHRianFSc3NMSXErYXRjd2R4cnA2SzhFdGI3SWJuQU4v?=
 =?utf-8?Q?w5Gk6kUpWfWxde4/7TADAP1EJ87TA6JKUSCP1PfB9jrnN?=
X-MS-Exchange-AntiSpam-MessageData-1: xUetyUM6NmYCBQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c10f0d-73b8-40b3-e7ff-08de8afaa96a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 05:43:52.3920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRFk0e/wtq5vkiwB+d8A9xdanGDUOBuD60sglfBYrpnhrEfes1MgSvfI9aVO1D2z3o6f4Rvy6FNrmcBbPAgbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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
driver has exclusive read or write access, respectively.

While their returned value is correct and safe to use, internally they
temporarily create a reference to the whole command-buffer slice,
including GSP-owned regions. These regions can change without notice,
and thus creating a slice to them, even if never accessed, is undefined
behavior.

Fix this by rewriting these methods to use pointer projections in order
to create slices to valid regions only. It should eventually be replaced
by `IoView` and `IoSlice` once they land.

Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings and handling")
Reported-by: Danilo Krummrich <dakr@kernel.org>
Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v3:
- Rebase on top of latest `drm-rust-next` (with `Coherent` patches).
- Use pointer projections. (thanks Gary!)
- Link to v2: https://patch.msgid.link/20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com

Changes in v2:
- Use `u32_as_usize` consistently.
- Reduce the number of `unsafe` blocks by computing the end offset of
  the returned slices and creating them at the end, in one step.
- Take advantage of the fact that both slices have the same start index
  regardless of the branch chosen.
- Improve safety comments.
- Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f3ce3@nvidia.com
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 104 ++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index c853be23e3a5..d85ed96334d4 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -14,6 +14,7 @@
     io::poll::read_poll_timeout,
     new_mutex,
     prelude::*,
+    ptr,
     sync::{
         aref::ARef,
         Mutex, //
@@ -252,38 +253,42 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut [[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.cpu_write_ptr() as usize;
-        let rx = self.gsp_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.cpu_write_ptr());
+        let rx = num::u32_as_usize(self.gsp_read_ptr());
+
+        // Command queue data.
+        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data);
+
+        let (tail_slice, wrap_slice) = if rx == 0 {
+            // Contiguous, leave an empty slot at end of the buffer.
+            (
+                ptr::project!(mut data, [tx..num::u32_as_usize(MSGQ_NUM_PAGES) - 1]),
+                ptr::project!(mut data, [..0]),
+            )
+        } else if rx <= tx {
+            // Discontiguous, leave an empty slot before `rx`.
+            (
+                ptr::project!(mut data, [tx..]),
+                ptr::project!(mut data, [..rx - 1]),
+            )
+        } else {
+            // Contiguous, leave an empty slot before `rx`.
+            (
+                ptr::project!(mut data, [tx..rx - 1]),
+                ptr::project!(mut data, [..0]),
+            )
+        };
 
         // SAFETY:
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = unsafe { &mut *self.0.as_mut() };
-        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_NUM_PAGES`.
-        let (before_tx, after_tx) = gsp_mem.cpuq.msgq.data.split_at_mut(tx);
-
-        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for writing.
-
-        if rx == 0 {
-            // Since `rx` is zero, leave an empty slot at end of the buffer.
-            let last = after_tx.len() - 1;
-            (&mut after_tx[..last], &mut [])
-        } else if rx <= tx {
-            // The area is discontiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - 1` is non-negative because `rx != 0` in this branch.
-            // - The index does not exceed `before_tx.len()` (which equals `tx`) because
-            //   `rx <= tx` in this branch.
-            (after_tx, &mut before_tx[..(rx - 1)])
-        } else {
-            // The area is contiguous and we leave an empty slot before `rx`.
-            // PANIC:
-            // - The index `rx - tx - 1` is non-negative because `rx > tx` in this branch.
-            // - The index does not exceed `after_tx.len()` (which is `MSGQ_NUM_PAGES - tx`)
-            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` invariant.
-            (&mut after_tx[..(rx - tx - 1)], &mut [])
-        }
+        // - Since `data` was created from a valid pointer, both `tail_slice` and `wrap_slice` are
+        //   pointers to valid arrays.
+        // - The area starting at `tx` and ending at `rx - 2` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for writing and is not accessed concurrently by
+        //   the GSP.
+        // - The caller holds a reference to `self` for as long as the returned slices are live,
+        //   meaning the CPU write pointer cannot be advanced and thus that the returned area
+        //   remains exclusive to the CPU for the duration of the slices.
+        (unsafe { &mut *tail_slice }, unsafe { &mut *wrap_slice })
     }
 
     /// Returns the size of the region of the CPU message queue that the driver is currently allowed
@@ -305,27 +310,28 @@ fn driver_write_area_size(&self) -> usize {
     /// As the message queue is a circular buffer, the region may be discontiguous in memory. In
     /// that case the second slice will have a non-zero length.
     fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PAGE_SIZE]]) {
-        let tx = self.gsp_write_ptr() as usize;
-        let rx = self.cpu_read_ptr() as usize;
+        let tx = num::u32_as_usize(self.gsp_write_ptr());
+        let rx = num::u32_as_usize(self.cpu_read_ptr());
+
+        // Message queue data.
+        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data);
+
+        let (tail_slice, wrap_slice) = if rx <= tx {
+            (ptr::project!(data, [rx..tx]), ptr::project!(data, [..0]))
+        } else {
+            (ptr::project!(data, [rx..]), ptr::project!(data, [..tx]))
+        };
 
         // SAFETY:
-        // - We will only access the driver-owned part of the shared memory.
-        // - Per the safety statement of the function, no concurrent access will be performed.
-        let gsp_mem = unsafe { &*self.0.as_ptr() };
-        let data = &gsp_mem.gspq.msgq.data;
-
-        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NUM_PAGES, inclusive,
-        // belongs to the driver for reading.
-        // PANIC:
-        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
-        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
-        if rx <= tx {
-            // The area is contiguous.
-            (&data[rx..tx], &[])
-        } else {
-            // The area is discontiguous.
-            (&data[rx..], &data[..tx])
-        }
+        // - Since `data` was created from a valid pointer, both `tail_slice` and `wrap_slice` are
+        //   pointers to valid arrays.
+        // - The area starting at `rx` and ending at `tx - 1` modulo `MSGQ_NUM_PAGES`,
+        //   inclusive, belongs to the driver for reading and is not accessed concurrently by
+        //   the GSP.
+        // - The caller holds a reference to `self` for as long as the returned slices are live,
+        //   meaning the CPU read pointer cannot be advanced and thus that the returned area
+        //   remains exclusive to the CPU for the duration of the slices.
+        (unsafe { &*tail_slice }, unsafe { &*wrap_slice })
     }
 
     /// Allocates a region on the command queue that is large enough to send a command of `size`

---
base-commit: dff8302ca1d0e773c90dbeeb05e759f995c95482
change-id: 20260319-cmdq-ub-fix-d57b09a745b9

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

