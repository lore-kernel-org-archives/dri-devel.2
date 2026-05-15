Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DFECD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 06:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6BB10F3EE;
	Fri, 15 May 2026 06:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bmpxo1Ln";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C67B010F3EE
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIamQ5pAC7GrWoB1d2WAQzTQuY9THMeIwOr9vFjR/2ZiWnr72IJ8A6l+4NKLCIlSFMgDhkxuQ0TN9m6ekJF1OnCnnvX+aFphJWJo5v7t8DPP5wM9YHma+2/TazDlV1C5epy9rwGUmBEKjUtc9FGiFsOkBvX7Q7EvaGgFNgHI12M/wfMy8J8uP/mfTqJfqdT7ubrsTgHMzQsiZ7Spzw9/PZpTwZaQ1zAW9h2QX4H/yTL/ebyulGUjLQsnZtbnsgVTiu5CWAOa5zbNzaTkpUCe/0x+xn+iYq/4EasBldv9Evj15NU0HtsVb6X4GAY1422D6KHcIHsakgioMv1LDV/nAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qcwx2RHhnU1otC21F4/L3YLTWa0Y6cj2xqSKD5ZwSp4=;
 b=Zu8Qnxl63VGK/z5wxFV3e/r1a9G2acMlRYSYIdCCHfhIUhmbTbjB+Y5fWA+i6oFAlHEIvtJU2yylJBQMQ7Q2w6WUgV6aciQO6cMxuiTwtbCnpduLSBPiyyYwmnV8XszhrvM0/Vn+GZaqlK/sN8BVvYAV2ruUn1pw3XM80E4pv9A9Ug7uPeKzJ76y+fYDug5FwmMJ5CNac/igTJze8FHMuY2B37qsr5JeOaDlnXQYgf1xAtzlZ9KOl82LA+KV+G3PbguPvVWkKs7PtYVvVfU/kDYFNn1qUDyu6FssARD+YzQayHi1x4mO5nHBNDW8jzU1jvIT0NmEzE7XcDwVVcTojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcwx2RHhnU1otC21F4/L3YLTWa0Y6cj2xqSKD5ZwSp4=;
 b=Bmpxo1LnZk54e5ZkafkIQXI5UYYpt1hgqzbPK8X+A6UtiJWYnsyY1hKwUXCnUuzNOoU9RKPwVnPg45VRoOQiBx+39FEQk/pmvrwizKgeGI64C7L8kzCVn2lpHr0ug8iC+UH6OeqhzMLHlYRvJTyMhXI9+rsUXNMeRO0xQDZSvcsS8bU5INuVm3eUBCZ0ioWsmlaYiJ6gAXZ8/IcQZoQiN54nFzM6BigeeKSNx5HdnKB55sCYLqUXH2eKDSB9y5pYbAfzlKYuv89MX9x714ZfiowoV+exegw+/IprO+LqB7uaJvVHkB4CSQAChVeUs+CMlhK+I3ciZMHt67RIVGqk4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 06:13:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 06:13:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 15 May 2026 15:12:30 +0900
Subject: [PATCH v5 4/7] gpu: nova-core: refactor SEC2 booter loading into
 BooterFirmware::run()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-nova-unload-v5-4-c4d6250ad160@nvidia.com>
References: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
In-Reply-To: <20260515-nova-unload-v5-0-c4d6250ad160@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9d2bf4-f6cd-4cdc-b0c4-08deb2490571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: xY3UGMbkVSuJR+5Znf4kXLGqy+M7Hj2NZ5XTLtNPX/uYF4zbWS7EXllUCRH2wmMikTkP+SSL07NLsabSUoIU83NGQxhDFSvFvsOagY4fWPDeZWLq7d/b3u6yadD8TutqqexomHgI2fyXmX9jbcCVc04mskU2wE6GwMtUuDkoybJ9co6rslhpl1C7ASgY+CxhdF2WwTpjzsx3pRbXTHj8r6s2izFgQ7lRBZtBkPBj+e+XDNV+QEJiHiNjalTPZPJuEp1rD1/pGHyh40HaG86r5wbJb83cb00KAxHXz7NWPkebYA0BmECQ2dqkYALEfIosPyLoVzkpMfVWXDPbS08dppB7c3Tk0q75DjOtqVxYM9z82kjjgjdsmdsxlhuMjOXGYtIPLoXd90LTu609kjpWAGiI6b6ui6Zh5EKLZpSYUh5m6KWqEp5lgRVKrAatIzi24U4CR8Jg/ch8TwUebncp8tmrl07QYeOeY/Ldo682Yj8JE1CxPHqQLNdoxtSzWNRSr6TWhQ3B/Z3HOZDyCAf8ETCQZVVbDYUCUBwrw3oOasEG/l8L88alpBx9jsBFJfNmlf2U8FFhOutvaA6GFt6k3sNrnSVYvFel42YgA1S96D8FavLvJmeQyNpwvL0cCO+KFnoY3ta1hh/Sbm4a+Gllqiuk60TLTkIKKme1pMCnI7ssed3y3nPRGhPVXUmympjB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUQ2ODBvZ2d0YlhuWTdhUTZUeXE1cWdDMzlhRzhxREF1Vk1WS3FYVWdieTJ3?=
 =?utf-8?B?V0pzOHlOSnhUQlR1bWZvdElXQ1NaakFZd2pPRFlZd0JxZ2d0NFRKTUlSRk5h?=
 =?utf-8?B?WWhkeGtxSUZPOXMzeDVHYXBRYU9ENURpTjFMQU9qSjlQc2ZKVExqV2J1UVVT?=
 =?utf-8?B?NFVHR0NBalhaM2tHdjZvVmoxaFlNQ2wzUlpFK1h6S3h3RFNUckVzN0F3MHZs?=
 =?utf-8?B?L0x4Q21adjJCN1h6U1hlc05kWUxlc05uRDBOeGhHSlQ5RFlkTEpKTDhRNVRZ?=
 =?utf-8?B?L2VtN1lwdlk2U1k1cjhoem5mbEg0dlcxMHhTdysrTXl1TGtVdVUwTFNtUjRt?=
 =?utf-8?B?Z3hlOE1CWXc1WmRDNTBaVFRDbVNsQ0tIeFI5anFLcHVzcmZNTHNkcWtyYlZW?=
 =?utf-8?B?TTRUT0lCRUFJZ0wvcFBzNUZpSUNkOTA2cGF0UWJrM090QzU2UkVlcHZGdTc5?=
 =?utf-8?B?ZHNndXRzNDgraXZUNmpBS0dFYlk0c2lvTUpsWElBTGFqRXFEVVlvbVNqV21E?=
 =?utf-8?B?YjBsWCtia0NFUEV2ZWpoTGc0cEJsQkRtVTV6di9mRVZLa0FNejBJV2M1QWl5?=
 =?utf-8?B?dmY3SW9OY2J0MDE4KzcrMFBvSGRhYlI5aHk4REhwSzNHOFhKOUFHK0wyQ04x?=
 =?utf-8?B?cXFJajk5STZHaGtVcmtHL25LNDE1Qm9tN0lPU01jUmJnT3hmWkUzZkVYVlp2?=
 =?utf-8?B?U2IwZG40S2ZvdnQ0WktmTFpQU25xNzNqK2N0THBEWFd3RU9PLzlVWGkvQlM1?=
 =?utf-8?B?UjJ5NXgydlZXdnB6dUNNdEF4OElBR2ZIeWVvU1VDZGNDZHp6c2FEbkFXUTRH?=
 =?utf-8?B?VGthWGc5NVdHbjI4VVdBOE9LS29Da3BVY1ZocDNIcUJBWHUwSnhkczVzMWsw?=
 =?utf-8?B?T3ZVWmxVUzA4K1NlS1Fac01lQkhrUWZsQmhoaDVnYkVqUEczRzlDTWF6Qkdv?=
 =?utf-8?B?TlVDT0g0dXZuejZDUlVJOEp1M3VqVGlXWHJ5d3c1QjllRHlYWkd3NFZvZUVV?=
 =?utf-8?B?ZTMxR0k1a2ZleEUvNG05Mmh4WFFzbXdBeDZUZ3E4TVVGVVdsaVpURHpnVTlY?=
 =?utf-8?B?WGhNMURiZEc2ajBFTkUwL25wRFpaS1F5SEdneXNDbCsxamR2VWVtRUtrYW1n?=
 =?utf-8?B?NFN0ajI0NWxSaG0xVDFLYzFnV043NVJaeGx4RUJ4OXNhekZaWW1ITWFxWUJN?=
 =?utf-8?B?RVAxUCtrRWZPTE0vb3ZWNWxKaXNRT3cxcTVHaHFXekFjR2IwemFYRUZrWnBZ?=
 =?utf-8?B?QXVNYURjTGVBZjAwcVRibk9WbnNxZEl1aTFZYkF0QVBocHR2SXZ1TW9YV0U0?=
 =?utf-8?B?S2pKUkViZGY4MHNnU0Q3dDk0S3IrVTB3WnlZSVAvdy9uRlZHT0FBU2pXM3RT?=
 =?utf-8?B?ZVRLVGQ4ZG5OL0Uzd3Z3VzlxLzZROVllQSszNEM3SndjbWh5OUN5aEZKZklD?=
 =?utf-8?B?V29ONkZEdkkvZDREaFkvd1BvRkFPcG5wd2pwTVN3dGk4emtCVFhIc0prdU1W?=
 =?utf-8?B?dmRrTG5EbUlPVUhxT3ViOEl1Mlh4Q1JzUy9CUmt5YThPay9tQWRlL242ZUUx?=
 =?utf-8?B?S2IxOVk3aFhTNU1ISko4dDRQRmVidHFiTWN0cTY5ZnFlbk1mcjE2M2V6UTB6?=
 =?utf-8?B?V1JtS1pRcE5wUkQxbWtlb1VVZUw1LzNWaFZCR0RRWk51VUNVazk1ek1lcnY2?=
 =?utf-8?B?UTZmK3BwTmhtcGRLTktoQkgvK2RYWnJoKzM3cC9IM0IyZUoyYmZjWHFMMW5Y?=
 =?utf-8?B?YThVeU4zdTVlci9FR0Vha0ZYWWRSclZTVVhpeEhMMW8ydkxmN1g2aDY2V0F0?=
 =?utf-8?B?U2k5WW1ETEhocnRDa2JpK0xTWGYrK054WlNuRTJoeUF6cFBEa0YvME5rMERL?=
 =?utf-8?B?QjNwSnhlWGFJelloc1YwWmpCdWZibmxpTXNqM29tRzdPWXRPM3RRVlV3cFpq?=
 =?utf-8?B?dUlGbEwxU1dXODJZVXN5WlpnU1dja3I4eTluWk1DajBBd0RteFl1YnRIY3dF?=
 =?utf-8?B?dWFlbmwvbXFNdUYzelhzN2lYK2VmSDZtRW1EeVNqQTEvS1htQVZIL3lHOGRK?=
 =?utf-8?B?MFp0Sit1UjdaUjlKRlREMzFSRkthWWpGZmptWW1CQzhDR0pRYjNFZFZhd2Jx?=
 =?utf-8?B?TFRER1ZlS2JPNmptdDVUWGcrbVNRNEtwS1dMY2JxN0loNUpqRmFyVExJN0lL?=
 =?utf-8?B?U3pxV09GenMvZ3RyWmI3RGJsdE1RVGFueVRUaGZnRzIzc1ZLdWlNbWdZelVS?=
 =?utf-8?B?NDRtMnZXZ01KQU9wWURldERsWDRoM2ExZUgxWUxxaGQ4cHhyUDhPUm9JRkVh?=
 =?utf-8?B?SGZueU8yK2hUMEZsVk1EeTdwZzhvSythNFFFc1F0TlQwdkt4Uko1Nlc3Q2xl?=
 =?utf-8?Q?hbqCDOwojNBsT+vkn15Aghmk3O+8vtgzHwU/cxEp5EYAY?=
X-MS-Exchange-AntiSpam-MessageData-1: P7fBpjSDlCndFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9d2bf4-f6cd-4cdc-b0c4-08deb2490571
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 06:13:02.8019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrBRvZEOFRBvyBQzIgiVzdX7dn8mZXPKwpJFYSjI83pNNjTLYGKmh6GMMVE0r6tYb7TuVUBN2bp1JtvutkWt1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

From: John Hubbard <jhubbard@nvidia.com>

Move the SEC2 reset/load/boot sequence into a BooterFirmware::run()
method, and call it from a thin run_booter() helper on Gsp. This is
mostly refactoring, with no significant behavior change, done in
preparation for adding an alternative FSP boot path.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/firmware/booter.rs | 30 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/boot.rs        | 43 +++++++++++++++-----------------
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index de2a4536b532..6a41690e72c6 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -8,6 +8,7 @@
 
 use kernel::{
     device,
+    dma::Coherent,
     prelude::*,
     transmute::FromBytes, //
 };
@@ -396,6 +397,35 @@ pub(crate) fn new(
             ucode: ucode_signed,
         })
     }
+
+    /// Load and run the booter firmware on SEC2.
+    ///
+    /// Resets SEC2, loads this firmware image, then boots with the WPR metadata
+    /// address passed via the SEC2 mailboxes.
+    pub(crate) fn run<T>(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        sec2_falcon: &Falcon<Sec2>,
+        wpr_meta: &Coherent<T>,
+    ) -> Result {
+        sec2_falcon.reset(bar)?;
+        sec2_falcon.load(dev, bar, self)?;
+        let wpr_handle = wpr_meta.dma_handle();
+        let (mbox0, mbox1) = sec2_falcon.boot(
+            bar,
+            Some(wpr_handle as u32),
+            Some((wpr_handle >> 32) as u32),
+        )?;
+        dev_dbg!(dev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
+
+        if mbox0 != 0 {
+            dev_err!(dev, "Booter-load failed with error {:#x}\n", mbox0);
+            return Err(ENODEV);
+        }
+
+        Ok(())
+    }
 }
 
 impl FalconDmaLoadable for BooterFirmware {
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index d39da38c8918..e75c4b235aab 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -136,6 +136,25 @@ fn run_fwsec_frts(
         }
     }
 
+    /// Load and run the booter firmware.
+    fn run_booter(
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        chipset: Chipset,
+        sec2_falcon: &Falcon<Sec2>,
+        wpr_meta: &Coherent<GspFwWprMeta>,
+    ) -> Result {
+        BooterFirmware::new(
+            dev,
+            BooterKind::Loader,
+            chipset,
+            FIRMWARE_VERSION,
+            sec2_falcon,
+            bar,
+        )?
+        .run(dev, bar, sec2_falcon, wpr_meta)
+    }
+
     /// Attempt to boot the GSP.
     ///
     /// This is a GPU-dependent and complex procedure that involves loading firmware files from
@@ -173,15 +192,6 @@ pub(crate) fn boot(
             Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_layout)?;
         }
 
-        let booter_loader = BooterFirmware::new(
-            dev,
-            BooterKind::Loader,
-            chipset,
-            FIRMWARE_VERSION,
-            sec2_falcon,
-            bar,
-        )?;
-
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         self.cmdq
@@ -203,20 +213,7 @@ pub(crate) fn boot(
             "Using SEC2 to load and run the booter_load firmware...\n"
         );
 
-        sec2_falcon.reset(bar)?;
-        sec2_falcon.load(dev, bar, &booter_loader)?;
-        let wpr_handle = wpr_meta.dma_handle();
-        let (mbox0, mbox1) = sec2_falcon.boot(
-            bar,
-            Some(wpr_handle as u32),
-            Some((wpr_handle >> 32) as u32),
-        )?;
-        dev_dbg!(pdev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
-
-        if mbox0 != 0 {
-            dev_err!(pdev, "Booter-load failed with error {:#x}\n", mbox0);
-            return Err(ENODEV);
-        }
+        Self::run_booter(dev, bar, chipset, sec2_falcon, &wpr_meta)?;
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 

-- 
2.54.0

