Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2AEFCD0CE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D77610E6AE;
	Wed, 18 Mar 2026 08:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gUaJvepJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6899610E71D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m22d/JIu1wDjs/Pg3OWHtRTNwQfrp7CqVjBRh0LhPPiHO58QTz8mKCV5AxJpD75BeLy/2/rtR0BVvghJgDOYukNLdOx88Q+0c2EIPNmRfAe4nVpncYVB8+TTXVwgB+fC2Dh7GrVaqMg7zYdw9yjRUdrJyoOnoOAWFs+eLQpe1xWfrBoIpJkc0uo0YzfnkrdxloYBvD8Ld1Ufczn4HcS5qnSIfNUW2j0EMzj3caeFIGOcd1RAXJ2ZIn+kMqbd+FlifKDBwaTOE5BORS2hBVSZiR9I7g7D5GIWkwkPwCc8ekLgbzc5aoMGWGCvd7WLmL7b5S19XMX8C4odlKqNZadSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLlg5iqhSwT/6DISYNd5wGQuidf6+ytyrXDVepgE0JE=;
 b=hRtjP7a1AOcBv8+atzIe0uYxED/B8GtDgNOer8c0hOKHlFDj9NIhYujzVI3gB5b11GvaEyUjOQpU1dnawqREY7PfxeOwVa0jiciQg9LGsH8H/ILEa6y7S/LJuSvuvsnVtWTFjdn6NQabQsQFGZ6bSUWAq/hSud1jlGT3deCBjWA6PA7+5iLHKKzJWoIs+rrS3kuDCjaAQ+85JA/ItmMhsz1v5hT+0K7aAChvVecFaSuJQmYCgXl9xWMdI+zZP02TR+7Yj/Fv69VQmsV1xRLr7WZkBzB4CDUJl82EejXA5jxKjkbOBPdK2Qfasrv4wFiAgDD5fTlJiXEg8UfwIOAOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLlg5iqhSwT/6DISYNd5wGQuidf6+ytyrXDVepgE0JE=;
 b=gUaJvepJbnCmHbJ1CMEGJDYn09Y3ds9mpuPMprnqJkNZs8mXKfiN26xQvHygImMROHR0re1vfits3w8apT3ueJ3vvymbLuz1sfFyKzf+1cTWdvlFPAeJNx5+rYBYubeXElisWoRPMgk07UyeZ0RcfCq6eJscI4I3637L/pkQkqAbFLDyHahxK8gGIR4kAQGTK7qJJwOHzzSjzJzb7j5HBvYxq/ZJW0Qjt4EQeHNbkTSI7uT4QZ5X1b352DemioO3+QEQtX3mn/ZvlTSjxtCHAgiG1mCU1O+pw34RV+bNK0iWmHRUusJbzSFLVmmloCrQgJbZucWBSDEsuSRYFds52A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 18 Mar 2026 17:06:00 +0900
Subject: [PATCH 2/8] gpu: nova-core: convert PBUS registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-b4-nova-register-v1-2-22a358aa4c63@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
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
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: f74e1777-4bb8-4f5d-47da-08de84c53aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i75uIPhnizavDTZadH3Lr62GoSPUjUlTKtmoNuo6ZdXFJJL3w9LkWDkeyPZzqUKvVK2L2yGf6JloPPHOSJvijFnV9yBEjLIvLcPxeXNTspong//L1nfZgUmhNnNUY2z3ypkhTCtguqGX0QaO5JowdlpSpYo/SwHHUoox8cKkEBg9RX8cp4fXJVBpdVebkhEqZR23TmNBBVYR3vWtBJ9JM8SXqYmuLRrou5UldLdRI9EHBcOlLZa5m8LUTmDhWa2LkQN5+lV11Na+hmChmTePeGB3xhFV5WRl9HoQx09yl7ScZpm/9Ox3yiM+QuiTBGvkfIHtcvWMhwoZCUgJfzZeQ57T3wF9WmK/HDM7u9F8TgCoJVqasuX4RejqcPK0U4ibV6EZuM4uy0V6V0h0wKHntf5G0t7JMjLOp/BI/mqsgW5+EGo9Ue9zAguwqrRUX/D9TFqn5sqw0wh8wpBuksnAJO424RBYdCkneBwfB4pWYcphWKXeo4mG6i88rXLWmea5ct1Sts1Yh5YO8iR7YIe/5nYzSiMnGg20C7TbGu6dB6R5VXXGtgqhftkJnWSJo9LHDy+SHBjWNXnSrJP+In2R1JY6Oyh3T+4yji9TVWZ9mysD1ZMu738hE8c/aupk4GO8kWFj9TBNWNYEPEF5Q3UmoxQz9VZ5KeanPk8iI7dSr3Rtv0bbWSSRSdBkCr9Q4Fb56TMxYtyxq4OJJpTnGWfl7gkNbw0QgVBp8LqfwTJitLN0cV386AH+d/lirw/Ug3DtlUTGKXoU+yY6NwtO3QdaoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkV5dU9ja3oxeHlpZzM2eVV1a21EVjBuTHZVRUpYN0xGU1pLOWk0R3dYYUNH?=
 =?utf-8?B?Vkoxd0EwNlRhQXhiY01KcXhERnhZSmVoK2RvNFJCSUdmRzdYMXkyRmdxNkFD?=
 =?utf-8?B?TEo4SXh3dlkrQktGYXEwMEM1MHV5Y3NkWWdyb0lwRkI1SFord3kvYWlLVUhi?=
 =?utf-8?B?ZG9BaHZPYmt6ZXl4NXJHYXcxMkJaUDBsTnNGdFNQRm85L2xOalJxMXVDUW9x?=
 =?utf-8?B?VEN0TnFrZnVCWEtKcUk2R1B5MTM3NlZ3dVJWT1lHRGxLNnRTbTh4MXFRL0dl?=
 =?utf-8?B?L04yYm9zSVkrNU1VejgwWG16MUpSZWV5ZUxTdmlFWDlYRUJQQXZBRm5GM21s?=
 =?utf-8?B?UDUvRUFNNzF1L0VoUmRwVk0yTG5QRVBsYzRRd1h5aGRpY0ZJNlpxRnZUdHR0?=
 =?utf-8?B?cXIycXRYYUZsMjE5alBtZm5qQnZhbDB4YmEydllNWEZFUmNRdXRkZUV2Vmds?=
 =?utf-8?B?QkRqS1U5MWpDWkRrTG9MVzBIS0Myd0xBWG0xUHhlREdnVzhQVjU2T2lUcmlh?=
 =?utf-8?B?MTNQRzh5RDJTeFBJY2JNYmc0WDBJTzZDRnZ3N0NLa2dZWUFZQUlwUHdHem1D?=
 =?utf-8?B?ZDFpRm9Fc3Y2VFZjalMrb003bEtaYURYK1ZUb0lsV3hTR0ZNVU5JclhzTjQv?=
 =?utf-8?B?L1pJS09WVTQwSWU0bzhvZURaTmdCU3JUWnk5VzNBNHNvUDMyWUFqUVJSQmRU?=
 =?utf-8?B?cHFBQnk2V2RLa1JyWGhUQkJoSkNULzBOQ3hmMk5QQjUra21LblR6ZEh1dmk4?=
 =?utf-8?B?WnV3UDlrUndMN2drc1pqaVE1Q2poKy9zY3VuT2tiakxaTHdDdGZ0NDdVdDZ1?=
 =?utf-8?B?NXNUa0hFNzE4cFBOUjN4ZXJpQlJzU1dLaXlra1dFR3lNTXdhZlBObmRabnI0?=
 =?utf-8?B?UExRYU9kL3JNMVBBOXlNeVRjVmhBcTNGekRRWkxGZVJaekVSbmRKa1RxR0JG?=
 =?utf-8?B?Rm00Wjh0eGUwVXRubjhpM0ZHNi9JSTBYRG94NnJuNnRKSFVFSDgza1dnUkhy?=
 =?utf-8?B?NTB0Um8yUnlKeVhuY0tZVWFXcVorYlZHMU41V2pacTZQZkpWM25qMndwaEJv?=
 =?utf-8?B?Z2hFUVcwRmtnRkNqT3B5UWo2aEtGUGh6TFNqMDVlQVJJMjYwOThuSmNjdTlF?=
 =?utf-8?B?UEo4S2ZuR25HdFhyT2pyQlg2WWJGdW5mUkcyZ1hYMEkxWkpnTldjTmdEL1g1?=
 =?utf-8?B?QVI3NXg2c0ExRW1CRGlJTjZEd09HVFhoWDdaTHMwVHpNNjh6OWRxQWlxNXYx?=
 =?utf-8?B?bDZaKyt3UkhBNHdPMXJ5eDJIWitFemdNR1JwRnBSN090RHl3NXdueWJEcjdT?=
 =?utf-8?B?b2pFcE42anBOMFhtR0hLWUR6YlZ4bTUvK1pjNkxtY3VjdnlURXY5UjJ4RGZM?=
 =?utf-8?B?TzdaVGlIc2I2eEpZSnZsY0ZMWUNwSFFxejRHUCtRM0czNVU1dzBpTnB5U0hJ?=
 =?utf-8?B?OEpuRlprbmVkeE1taFFDVEsxYStvVUNtMFppbmlFNFgxQWRmbW9TaUlZYVhy?=
 =?utf-8?B?MXVFUDkzYlFtZlJJZDFzcElYRFdvWTA0OFU5SVBNbFR0dEtBYjQvajNSOEpT?=
 =?utf-8?B?MEw2c2lLSTByR1BUUHdUdE96dW9jeDBORWl6OVVhbkl4RU9ORUM1UmdVekgx?=
 =?utf-8?B?TU4ycGNqdFFKR2ZDVWVibzNvUjZ5ajI0Zm1xQnM5SGVQVmgxOURBblJla05j?=
 =?utf-8?B?NXhXWE1Wc0pIQmtmYytNZHdQZUI1eXBPaHYxMExDT2dENTRBOFd6OUtUYXBN?=
 =?utf-8?B?dzNISDhHMlk0c3R6cXE2QStaVTIyNk9vc25YMlBRa28vSFVmZWpRcnpOcm5a?=
 =?utf-8?B?WStRQUdoTXhQRjNXamxpY1JBeFpHVXh4TitiYVFVekZtTXgwVE02Y2ovbFpq?=
 =?utf-8?B?QVNCZ0RYQmRUMkJhdXVJMWZwZEZZM1BjbS9vWTQvUURQY3lxd1I3TDRmWHQ5?=
 =?utf-8?B?aVljNkFpNysrR3lpNkpwZmV0QlkxQTJ0RHVWTDlzZzVPM1VwTnBzTVA0eVY5?=
 =?utf-8?B?NVNxK1NJRFVEVkRvOHhHRlcrUDdQd0tBZHNybWE5bVZDU2d0Y3NVMC9sazJD?=
 =?utf-8?B?dzNqcE9pcWhrSnh3eWJURWlnR0RIS3dwRURxV0pBZkx4eWk0eE1aUjRueE9p?=
 =?utf-8?B?Q3NrOW5LT1NmeHN6T3BvMVdRRFJIdzZtNldjTEVBK3ZQdUp1ckxTT1htaUJB?=
 =?utf-8?B?WUd1cFg1N3ZINkV3Y1QrblN1QUord2hmenVLYmU0L2Y0a3h0VW9HYnFaaVUy?=
 =?utf-8?B?Q09tWVFyc0IzbjFQUUNkOHJiOExlUWt2WU01emNWby9ON2VIWnMzM3dJcWdU?=
 =?utf-8?B?d2d6TWJLM3p5c0RmSHQ2Qmt6OU1jaEhHQ1dFa29lTTVISWsvdEg1VXkzbzE4?=
 =?utf-8?Q?FEZtrjImwVigwt32l/hM16fsonQBNQoOgVRkFPmmPiVmv?=
X-MS-Exchange-AntiSpam-MessageData-1: d3SK2Kd2MJelzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74e1777-4bb8-4f5d-47da-08de84c53aa3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:16.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DniVjPWbcCxjJuQ136Lbuar3uvfTNtJb/cbSYg6ouAzAz9V6Pw4VkPlE2FvPPRyhjq+jqwtq7yVHVa5P/Rkpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Convert all PBUS registers to use the kernel's register macro and update
the code accordingly.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs |  5 ++++-
 drivers/gpu/nova-core/regs.rs     | 12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 6db2decbc6f5..d885190b6d92 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -5,6 +5,7 @@
     dma::CoherentAllocation,
     dma_write,
     io::poll::read_poll_timeout,
+    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -87,7 +88,9 @@ fn run_fwsec_frts(
         }
 
         // SCRATCH_E contains the error code for FWSEC-FRTS.
-        let frts_status = regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR::read(bar).frts_err_code();
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
         if frts_status != 0 {
             dev_err!(
                 dev,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 62c2065e63ef..304fdd0c1705 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -132,12 +132,14 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-register!(NV_PBUS_SW_SCRATCH @ 0x00001400[64]  {});
+nv_reg! {
+    NV_PBUS_SW_SCRATCH[64] @ 0x00001400 {}
 
-register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
-    "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
-});
+    /// Scratch register 0xe used as FRTS firmware error code.
+    NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe] {
+        31:16   frts_err_code;
+    }
+}
 
 // PFB
 

-- 
2.53.0

