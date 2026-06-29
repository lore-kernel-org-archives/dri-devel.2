Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B888C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA2E10E905;
	Mon, 29 Jun 2026 14:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9cc2bt6";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602BB10E904
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMM8XTysuuP8jBbJLqsPbm7hP5cwPTIRx01HrmjMl8oIp/W1dttELKFVqcW6pbpTfefbc1UGn0YIy1ZKnMQ32PGMvk0wdcM2uRs+Kff2K2UIzHjNqlyxPXDUG0qRWMLm7aEo/9ryjhA87BoaOu3lhFHk+ojZ+CRcmqZxgEK1NezQyugASaQL066qYExBngZypm47cBxGHBPKGrcj15w6Jdshgx2QC9l/OmRzUDDJ3cwUBMBQky1y2rcKu/kMb+rrz7SVaj2Y6waPBJRyb78HeQSLRJgX3PXBhXXHwZJHCLl+AwcBKZgHRkSM4D7OH5F1o3Z748E96A8vZR4tIjl9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOhRJalRjOnxbvbfX9Nw+U3AieU+TVFubpAwcJGiHdY=;
 b=GPhccfhQsckwI0kc32XFydB7Te7YKTwVh3GhYHbK9cCox6WjZD96HRIU19MLvjXfpbMZ0f/xPsNnSm1l6rl1sKeWO0ytSYyAG350cypmCkkJyGrvWH1n6O+Af5DfLAt1dBUY7Rm2m/7onmK/0omIbnznbCEJEigbqs8wz/FY+IZuVf6RbZUpdBuAbATlXSK2LozvNduKbetouAIrMFXMwo31sEibpr95BquAWdTnJUNlkE+dEywUjCzrkjq6DBNpa5yoh+cEJApXSivT5MyaFlj+4oY8lzhPTnK9YWEDAaIQoDFtrx7s+8vkp6H4GJVV/sFHG7kwcINjuASEIjnj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOhRJalRjOnxbvbfX9Nw+U3AieU+TVFubpAwcJGiHdY=;
 b=W9cc2bt6CsFrlpHKyHgfW1k1Pm1J9X9yVE/d40KkVh4nxFGevg/pP3vC9YeQ7dmqDHNkeg2nXGbz3PomrDdPH49f2I9XkkOAqeefIMz+t5hYWkiATdEVYe6aI0wjpwTyM4STPupmUcYTll3lXxyLaINnVtqKJbxTKfAQzP2nPe73Oekm4u2KwORlDALp2vxSAyeyq7oNCD9fm/kcSc6tEkMNwpIE4/oHWkkyswvK4fsmYdK8F+4ncAvwy99o+FkdRzF/oE99zrgwQzmXlAYSnbCwRjqv2eaFXv49OpqhnlVVxL8cD0suIThRPKuYEkI2viUGtn9eYGORDdsH+XWoxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:39 +0900
Subject: [PATCH v4 07/13] gpu: nova-core: gsp: turn FWSEC execution into
 HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-7-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS7PR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:604:24e::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c13a5fb-4e52-4547-8000-08ded5e82424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|6133799003|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: +Ux1aJBdfhyqzgFumpH0wt6gjLzT+agkPI44FKOI064oQRIfT029mOL08YKQfqPAH6YB8/ZyguIPe6SPuHNHF03rE9FtkxLMGyu3tCMieDUiHlbfkefX4TxwGQZIQ0fV1NbLAWuDMMSV3NyRFukp0o3RPa+ghtbYcbBZ866FVkrOH0y7Bw06LsfyxrpLLaHW8CYv+Dj0HcjKwKq9cPcnfzRJo+4IszzvVCuHyYDpkkZmrJL8/dGg9QRG/aBB0CHMU4HftIaaFQUjILjb8YfFidfvDF0kfrQBNCHhKG8IHd9xD/KbkXf52GUj5oqniFtlyOn1oi27o8fUF51AGY+iVSb95FRMdNqG1i9II9W0WNh5IFE7Yt7cdBG51c38+v0f7R3W0e52/5ocxTIFKEUWc7OmnFVdEcownjmOdmdq2qRbwwZ1+f5eihm1OGK5MyiuHeRm0K56R0UOSp1gfGHPjsynUFBA19yQljiiWwd/6dYD1Xk7WMAC27XW7rjlIxRohGK3BWQ/hx8mjWBJ3eVeQU//Qm805WVm+FFfthagbC/yD6ztmIP0Kr5A0OypmxkdKQsH3EgXU8UTeEYQOuJlp8Cbq4eDz/6sX3uwAPnsOfKZRqkn4iP8TvsKChlXgZ1CZIXyiLAFNFhI5JrZE+lorXwOJbntYG2XlsqVN/taCeWN8XXRuL0InBSnQnxmKHHIonDQH4IMBTJZjusDSkZa9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sml4RDFoYUlrOXZxNnNaWlJJSDNnOXhuRmRDUWdNL0xydGtwSXVJZXFnRnVO?=
 =?utf-8?B?Wjl4bVVYejgwVHgzdzZ0MWVzbnluZHQzeVB1VXJkYWdFNjVhZnhXQzNVMjdo?=
 =?utf-8?B?L2xEQzRVV1lqdmFkQ3BadkZhODVVRjdSbUlpblZIM3RLYzJkZnhjeS91MXIv?=
 =?utf-8?B?WW96VWtFRGVLVmdXTzBCQ3c4cjcwRmg1Y1h5eWNkbU1YNnU1Q3R6VklDbFF1?=
 =?utf-8?B?RGo5Z1I3TE5ONHBhQmVZU04veXpueW93dXRwOGlQenlqSFZyRFRPRDVEK0Nq?=
 =?utf-8?B?aEIxcWwvaUVjZ2tjeExpczkrYzV1cURSN2J2ZW5WVmdLNldEK2NVb1BXWVIv?=
 =?utf-8?B?aFl4eEZzU2EyQ0xGTXN6U0xsYjJaNHlnM1ovc0srQ2w2UkRQYklHcWVwcXAw?=
 =?utf-8?B?NXpMMXhQc1BoN0FzZ3M4TjRxVkRpeDNjRDVzVWZKc1NMT2dqK1BJQjhsZ1Qx?=
 =?utf-8?B?Vm4vWlZWUWVYa0pSajFHTS9PSU1lNDdsRjlJSVBUN3BlZVF3NEY2TVFZMXJj?=
 =?utf-8?B?VHNZdXNMUERaTngxMHlVbloxcWxNaXhhaUxPeGxKYjBlTTc3c2JsSEYwN0Rz?=
 =?utf-8?B?d0NYbmExODR3bVp0M0gzWEp1aE0vT3JSUmd6dm5xcmUveEUzSGp4RFA3dWUz?=
 =?utf-8?B?OCtEdW14ZXcrUW1pWWZhdzVVTDRFRFl4MERja3hyZDVSaFZsSVJrVTlPY2x5?=
 =?utf-8?B?MGlWQzNDUDZNNXprMlpmQzFkazgzUy9HNkpicEdtOFpSbmx5YktBRE84M2dW?=
 =?utf-8?B?YVFWdzZ4VjF1RERZdVZVZy85VWE3TXZWTm9tZ2ptYlVwKytXSlJUTXhIMXBM?=
 =?utf-8?B?UkVvR0NIb294S2JtTzhTNmV6UldQNWRET3YyeHRjZC9xMkpNMStyQmt0RTFN?=
 =?utf-8?B?VEs1Sll5QTliV1FhTlRUU3lnYXA4M0dLTHZVbURaMTA2QjNQNDVzZ3dSNDVM?=
 =?utf-8?B?ME8yYTJ3NDBpWGFPcEllYjdmSDloOEg3QWhoLzZxNXVSMXhFaWtOcVg2bitN?=
 =?utf-8?B?cHI0Tlg4NVlJL2pLSVppK0U1c0NPbkRCeGtpektyMXhpZjBXcm12b2Qrclg3?=
 =?utf-8?B?R3crOTZ4anBzSjhkUjRTaWRMZ2hYRGhuOWZKZmJOZkVDSDBPZTFLK1h0YlRH?=
 =?utf-8?B?U2tEbGg1NU9ObXZsL3dyZUIwTDNOMDNhUC9sck8xdzNPNGtNa2NjaUJhTFg1?=
 =?utf-8?B?OW5oOThQNW5BaCtPNVQ2a284a09TSTFzTXBxSW05VExtNGRLMFpwUnF0eldm?=
 =?utf-8?B?cVRMcHZDVm9KRlJ6VFV5OTZvL2k1V1ppWG5OcFBwdHFGSTF3WktIZDR0amZl?=
 =?utf-8?B?anpqRVAzNFlQVmtGRXdOTGRPNjM4RTBtVGtGMGZzbEgrRE40OWxsMjkzWDBl?=
 =?utf-8?B?NWRnVTk4L1dmUGQrNkJBSms1SmZpNGphOGs4Tjg1d09GZ2IxUURSR3hYRkdF?=
 =?utf-8?B?KzUxQ2JpMUdrN1VoKzNGR2pIenN3clRqSmRrVExqTzlBT3J6bjAvVXIzb1lC?=
 =?utf-8?B?YXZrVUF2MUFMMzRWd0srNUk1S2dsYzU3ZHFjZmt6NzBHdHBUOHJyc3hKVTQ4?=
 =?utf-8?B?SkRyZ2k4YlQ0VjFxd3FEQ3F5dktjSDhtUlNGLzhVa0tmZVVkZjZTbGZseEsz?=
 =?utf-8?B?bnJYV0pnQlhCdnlEV3hRZ2YrLzJXMjdLbTMwOGxOYmkxTUNDOFFIUG40cDhL?=
 =?utf-8?B?MG1XNjl3blVJRGtqZ2Y3dDhHcVl4N0JaYnUvMEt1dVlGUHRQTmRoMG4wbU4r?=
 =?utf-8?B?VE9UN2ZqalZwR2pCZDQ1aStSWnVBaEtrZVNhSkdnQWE1VG5IMkc3ZkhpVWNU?=
 =?utf-8?B?UldZWlhFN0dXK0wrQXdONStibVpHUHZuV0lLb1V1SkJDeEVRekY2Sm15cFcx?=
 =?utf-8?B?WmM3d0ZKWjVpZWI1cmFQSCt0b0RvMXdkNW9BUEt0TEFDSm9Sbjlic0oySmZq?=
 =?utf-8?B?S1N6Nld3ZUZjcHdBbFJRaXZ4TkRNZ0d4cllKbkVueDBpNjZjR3UyNHo2RU1T?=
 =?utf-8?B?alJIay9NODVsQmIxUE5lZzdLQ0VZOVBjOTRZRjc2THVaT0cwcERZMTMzQm9x?=
 =?utf-8?B?WmIwYjA1TjFYNFZqM01LaXJUSkM0WER4UTlsRzdqUW1UMmZrTnN5bXlMV1g3?=
 =?utf-8?B?TnVGaEF0eEEzZ3lkWW9BVzVzZFFTbjlNVi93UWZQVnlmcUMwUzkzYmg5dUJt?=
 =?utf-8?B?TUxKUnVuS0RSTHZJeU9neWloQVlCNzNtSm5Bek9Oall0bHdQWnkvTjFhV2Ns?=
 =?utf-8?B?Z0dvQ0x3dzdtcmtYU05nME43RkRjdnQ4S3JrRTdzTXFjc0JiQW91ZG1XbTZ4?=
 =?utf-8?B?VVk5WWhCNGNLeTVQL3hTQ3BSenF2bXV3d3I0NklhQTJqbjVseG9EYjRjcnR5?=
 =?utf-8?Q?v0X1++4/xMMi+OYTmiIvF+UugliSAgq7XEHtRVvrNpt2f?=
X-MS-Exchange-AntiSpam-MessageData-1: AIuy69Rvl36k+w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c13a5fb-4e52-4547-8000-08ded5e82424
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:15.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QduqX052DGywAnsSLwiiv+2SJUg2AQwGYrXmT1dI7OjSqyx4J6R2kV1GRj1K+/aI2I+L3T5n6GyYJ3HvYku7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

Turn the `run_fwsec_frts` function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 173 +++++++++++++++++----------------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 0505a5beee6e..df3d773bd354 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -127,94 +127,95 @@ fn run(&self, ctx: &GspBootContext<'_>) -> Result {
     }
 }
 
-/// Helper function to load and run the FWSEC-FRTS firmware and confirm that it has properly
-/// created the WPR2 region.
-fn run_fwsec_frts(
-    dev: &device::Device<device::Bound>,
-    chipset: Chipset,
-    falcon: &Falcon<'_, GspEngine>,
-    bar: Bar0<'_>,
-    bios: &Vbios,
-    fb_layout: &FbLayout,
-) -> Result {
-    // Check that the WPR2 region does not already exist - if it does, we cannot run
-    // FWSEC-FRTS until the GPU is reset.
-    if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
-        dev_err!(
-            dev,
-            "WPR2 region already exists - GPU needs to be reset to proceed\n"
-        );
-        return Err(EBUSY);
-    }
-
-    // FWSEC-FRTS will create the WPR2 region.
-    let fwsec_frts = FwsecFirmware::new(
-        dev,
-        falcon,
-        bios,
-        FwsecCommand::Frts {
-            frts_addr: fb_layout.frts.start,
-            frts_size: fb_layout.frts.len(),
-        },
-    )?;
-
-    if chipset.needs_fwsec_bootloader() {
-        let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
-        // Load and run the bootloader, which will load FWSEC-FRTS and run it.
-        fwsec_frts_bl.run(dev, falcon, bar)?;
-    } else {
-        // Load and run FWSEC-FRTS directly.
-        fwsec_frts.run(dev, falcon)?;
-    }
-
-    // SCRATCH_E contains the error code for FWSEC-FRTS.
-    let frts_status = bar
-        .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
-        .frts_err_code();
-    if frts_status != 0 {
-        dev_err!(
-            dev,
-            "FWSEC-FRTS returned with error code {:#x}\n",
-            frts_status
-        );
-
-        return Err(EIO);
-    }
-
-    // Check that the WPR2 region has been created as we requested.
-    let (wpr2_lo, wpr2_hi) = (
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
-        bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
-    );
-
-    match (wpr2_lo, wpr2_hi) {
-        (_, 0) => {
-            dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
-
-            Err(EIO)
-        }
-        (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
-            dev_err!(
-                dev,
-                "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
-                wpr2_lo,
-                fb_layout.frts.start,
-            );
-
-            Err(EIO)
-        }
-        (wpr2_lo, wpr2_hi) => {
-            dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
-            dev_dbg!(dev, "GPU instance built\n");
-
-            Ok(())
-        }
-    }
-}
-
 struct Tu102;
 
 impl Tu102 {
+    /// Helper method to load and run the FWSEC-FRTS firmware and confirm that it has properly
+    /// created the WPR2 region.
+    fn run_fwsec_frts(
+        &self,
+        dev: &device::Device<device::Bound>,
+        chipset: Chipset,
+        falcon: &Falcon<'_, GspEngine>,
+        bar: Bar0<'_>,
+        bios: &Vbios,
+        fb_layout: &FbLayout,
+    ) -> Result {
+        // Check that the WPR2 region does not already exist - if it does, we cannot run
+        // FWSEC-FRTS until the GPU is reset.
+        if bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound() != 0 {
+            dev_err!(
+                dev,
+                "WPR2 region already exists - GPU needs to be reset to proceed\n"
+            );
+            return Err(EBUSY);
+        }
+
+        // FWSEC-FRTS will create the WPR2 region.
+        let fwsec_frts = FwsecFirmware::new(
+            dev,
+            falcon,
+            bios,
+            FwsecCommand::Frts {
+                frts_addr: fb_layout.frts.start,
+                frts_size: fb_layout.frts.len(),
+            },
+        )?;
+
+        if chipset.needs_fwsec_bootloader() {
+            let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
+            // Load and run the bootloader, which will load FWSEC-FRTS and run it.
+            fwsec_frts_bl.run(dev, falcon, bar)?;
+        } else {
+            // Load and run FWSEC-FRTS directly.
+            fwsec_frts.run(dev, falcon)?;
+        }
+
+        // SCRATCH_E contains the error code for FWSEC-FRTS.
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
+        if frts_status != 0 {
+            dev_err!(
+                dev,
+                "FWSEC-FRTS returned with error code {:#x}\n",
+                frts_status
+            );
+
+            return Err(EIO);
+        }
+
+        // Check that the WPR2 region has been created as we requested.
+        let (wpr2_lo, wpr2_hi) = (
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_LO).lower_bound(),
+            bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI).higher_bound(),
+        );
+
+        match (wpr2_lo, wpr2_hi) {
+            (_, 0) => {
+                dev_err!(dev, "WPR2 region not created after running FWSEC-FRTS\n");
+
+                Err(EIO)
+            }
+            (wpr2_lo, _) if wpr2_lo != fb_layout.frts.start => {
+                dev_err!(
+                    dev,
+                    "WPR2 region created at unexpected address {:#x}; expected {:#x}\n",
+                    wpr2_lo,
+                    fb_layout.frts.start,
+                );
+
+                Err(EIO)
+            }
+            (wpr2_lo, wpr2_hi) => {
+                dev_dbg!(dev, "WPR2: {:#x}-{:#x}\n", wpr2_lo, wpr2_hi);
+                dev_dbg!(dev, "GPU instance built\n");
+
+                Ok(())
+            }
+        }
+    }
+
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
     fn build_unload_bundle(
         &self,
@@ -286,7 +287,7 @@ fn boot(
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
         }
 
         gsp_falcon.reset()?;

-- 
2.54.0

