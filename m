Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87F2CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304F110EA2C;
	Tue, 19 May 2026 02:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nWb3PnJ3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F95710EA2C
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWuxMyoV3bw/BBoa564aGyx7icZsrC+seg8xKIeXY3UshARagYfZeuP/Y/kH5ABin/MuU4TH6d9dXCmFJOTF9JJ6uD3YzQ8Wl+mePUYpDIVJOscAk8b6qFN2ROyQOS2jqNA1jCnPxYmLcwlZzx3tYX5QjPZwglMBBxWMnedNa8IyVnljl2Nqiq8RdJygIrHkrUFcMLSm+LXX43zLyVzJnq0G69hfzOw2cjbCwsbUSJ+aSRljoFAS1p9dCUlf7q7+dBbOT1byVil80jiOUxbY5FFpsY+aOQLnfqB5vE27ch8nfkFSy9y+/Lg5eWRwoAsQyh7Fix4NYm++C8/4Ey3ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4Bk1xiDF/2KD+IERc8hfzDoL82h2P6JxJuR86NfbDI=;
 b=B/0ZTHUNYyfLhOJR07e2VffJAyDmysXMbU1cQc8nLjM/+PPASXRe6EMNZh2bY0LgW97SUkJMqtS5Ywvpgfb0/nFASGJoJlazD96C5gOaebHBGfAg3+SMHtn7OKbLURmdtKsZhifUny0J6BeVsDT9TuhlBgT3cyYwLlgvOW5gnwm7WY2vLMC2p3kISdMt0rwu2ESZBn5ZF/zV4KToD8KgxRfwwer7wLuSE7iXU9CjA3sBhVSxEnDtm8u9sqyaVeTVUPx8GWFKRUKoTp5W6uIxS9YyjFFefNsTxpMij/U9QSQpeyYRMMRIPgACbexmXj4E/3b7gZarihTzMntmALBClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4Bk1xiDF/2KD+IERc8hfzDoL82h2P6JxJuR86NfbDI=;
 b=nWb3PnJ3FJVRJ6E/nL3+Tc7YNB5aGgS79A7DbsfhFKCszjxnhcDfopU1m8pywTgJLP8DxX7vG0X0KTZmjyt0LbsO2meEjtav5sL0dNXHUcjcR6/cwJkp15M4qJDuJsVoznA7/ZybZF5RkMP1OIcDp0PASnZRLrMputbzlGJeL06iNVOnDJm3afCwMveN/uJiDtn+3Ft43pHveeP+vU7cIWmq7hCMwSmkmzU7VQJlZ7OvnpnTtT12/BfdPeZ2htNAok/WrFGPsJTJPWdWjH8BwHM3MjBhrRG6hCFEDwSz9a6LJ0Yth+Ns6Wyn5N7h5M2WFB2/P5qCYyLs8rZXphx4Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:52 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:10 +0900
Subject: [PATCH v4 16/20] gpu: nova-core: vbios: use let-else in Vbios::new
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-16-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 57996ed3-f027-4006-05e1-08deb5524780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: p01OyhhutEjWMZT0Xyj7KEdvEOSR7uAjMkYDaf2DLAjPawjeZ+riZeNUL913ZnwjQlH526QJyL0Up1QBNx/AcaZv03+p/kxjI8aM4At+nd+EDzkdy76ptYdIv0kjrra7cVBoY7F/5OIsnrzShVOio+wPxjONK7D1qicrT52qR+EUOREbkJlLSG8ccuYt9hNVZn+vHIGQzal799bYXM/yi/271OjGacLSPC/USKG5phixZ4b9PZkOJrmlvMm2J+sBOFqQ2n3BHhavEnJ9XSkFYzyrZrM1sPv5UtYJ+s0ssRzdz0TMQOiIejwzYLja+4sFLnr4CGLUTK6RYwAHWKjaAFGtIeslSv0fpkyO9OYo2HBMFMSQjMHkxM19gxYHZM1dGsqXPn2Fd0uoMObfxYRmW1n4Q8/EK0D35QJqAehwMeLLAE8mH63MegpSoae84YfzRb2MUHYacUNxq4VX1W4VdGeGJ6EVVmC8NbszoV5Us85LDpowOt/kAhUl3VVQcIWffC1d7j57sfHORL2ZThWamgO1hNraoCeZA8P6sS7oynrgWawUUtnKW89/5wxFAgcnqMn9HjqxK7N6GVml7CAAPnwcTbgVuMwDbFl/rXLBKJP49AJwZTTZDNJreqJWmX8fo8LRPT+OPWp15AhgGJ+8KvbVY5g1jrGr3nIzIxRDuy34/4+e+zDV71EG1/Oxs8pG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFGRE0xOFJUM3ZGekJWQ3FQaVFZcFRRbGdtblNuZGRtVU1Qd2pKT1kvZ2E4?=
 =?utf-8?B?UkRnNEdzcmw5bGUySTdDS3p5R1lNbFBURHpUdndPYUNqWG9lWmwxS2x1ZUVI?=
 =?utf-8?B?dWNndk0yaVVYNmVTckZ5VHZjNjVQV1RrSGpsOUNTQlZpRHU3aHVUTVdsL0hj?=
 =?utf-8?B?SW9ZMmNqWEpPcFAyRlVLL3JuSVpEeEhUc1JxWjFjYU8yanlqSjVrdFJtcUQy?=
 =?utf-8?B?STJTeUxCWHRnOTdPWEN6WHRzb3Y2UlR4RkN3NkdPRXhhcndKclhmRGRSMFNW?=
 =?utf-8?B?OGJhbkdsSFBHUmZsR3dNQjR2WFRSRENpTjVSZjNCY29XZlhkNWZITFpPb3RO?=
 =?utf-8?B?bkNJWnd3eFYzak01eTQ0a0kybjFOMGhsWk91QURFM2lvMUZPMUlVOFlRZ2Iy?=
 =?utf-8?B?RXdPWGdZTGdQYW5xYzl0Yzh3SThCa3BHMnNNcVh5TjNCa2grL3hZRk1jaCtE?=
 =?utf-8?B?bTJiK21wOHY4eHIwVVRxbVg4MUJDV05oR1hUZXFMYzJ0NEpwZHlBbTcxeFcv?=
 =?utf-8?B?UkREZVgwbmJ0RXUrNVovUUw5eTJDWlcxdE1BaVljc2ZlZFY0RlpkcWhMcjhZ?=
 =?utf-8?B?Q0R4NWRQZlJWL0gzQzFSVVdpam8vZDJ6NzN4V0Z2ZmhrcHd5U1dPRHUyb0VE?=
 =?utf-8?B?OFZhZ04zemVqTUp2UGJvR0xGMmdLbXlLeXRmb1hMQmtvYnJKODZ1OWxSbks1?=
 =?utf-8?B?SWNSL1l1eThvUXlJT2szNE1GTC84WkVFdWdIYzdKcExBOXptaGFmRFpvbWov?=
 =?utf-8?B?YlIzY2UxM0xlbEJCeUtjbzFaY1FwblFUYmZxQjlFUkJjdCs2Ui9SK3RVcHIx?=
 =?utf-8?B?cjgwL1h5NTNLQWlINCt4aWNERXJKbVJjQTA5T1VRWUY2Ym5ZMU9NVEovRytB?=
 =?utf-8?B?WnNGZ3dBbXZQL1kyQmQ4SSsvMVVKcklIcnh5bndrMHAwY1MySTVEbjVmRGJy?=
 =?utf-8?B?M2VpM2o3WlNzUmZMM3ZON3VQd3hyVS9LVEhtL0JvRjRqK1R4SW9jREpxYWVT?=
 =?utf-8?B?UzUrY3llekdmNkErKzFKVVNLZ1ZxcXNGQ2lVU3BqYXVIK0ZOc1dHQjdzNFlx?=
 =?utf-8?B?QXp3N081TCs3NjFPTHIrSnlnL0dqV2FSZzM2VHUvYVRCc2ZrMVkxay93c3Vj?=
 =?utf-8?B?ejVaRTFEdmxZQVZTTUJTWVZrbnlrQm9XekJidEphUmhOb3l0ZXNtTzAxZGdE?=
 =?utf-8?B?R1BVYXF1Q0tTQUg3WC9LWURRc09WNy9oNDFnUWFZTFp5ZHNOdG1zSzFZOEh0?=
 =?utf-8?B?dCthbTB1UjlUTUFWMlNVL1hUU2M4dkZSdVcrSjJja0tVbFNhS3pZTnNQK1VO?=
 =?utf-8?B?T1R4N1dwQnBZekFFTUxFY3Fwelo3OGFxaEVxaU5tUnVBT3hNYWVCNzBHTkxJ?=
 =?utf-8?B?Tm9zcUU5UVdEZTdYREFqdnQyZnJvWlNEMitpZEVnOXRxWndFdGViNlV2WHNT?=
 =?utf-8?B?RUlQeVp3ZmFkc2k0M2pRc3hraEt6c0Y4NFBwY2s4U0w2NS8xMmpiTGJxd3I4?=
 =?utf-8?B?NVFjYXFFN09KMEZSSWxIT3FPdXlzQlBuazJwRmN5SHo1dVAvRzliV29GR3kw?=
 =?utf-8?B?RlFtWlo1TFlCZWZ2eFJPaWo0VFdCSDBTSndoZmZTeWYrc2UvZXE2Wm1yc1Bj?=
 =?utf-8?B?Rlhra3A2aTBPdEN2dklVY2p4d3grKzMrNThoK0NrdE40dFNmLzhteVV2aWpv?=
 =?utf-8?B?ZFlZbXRBR2hBdzJOOGcrK3JEUjNEMHZ1c3E2am5JbkNTdmNCMkNVYnhSVU8r?=
 =?utf-8?B?UGs1ZmpQRHhnYlpKekxDYU1lS0d4NUZuS0ZwRGtiRUJVMGFkaGI5a3VwaGhz?=
 =?utf-8?B?bzhSUWhycG5NOUtrRGdVa2FYSU5ScEpOV3B2UWg1ZmVBeVFxMXdUL242RXJ1?=
 =?utf-8?B?U3VtTjkxLzFZRDNBSW5CVklCVGNRUkVNR1VZZXZoM0JrMWN5VkRlNEJjc0ww?=
 =?utf-8?B?UGRjaEJ6VUZmeFZUNUkzV09KcEFFM1RkQUdtS3g2WTVPblI0NTc1UUpjWTNW?=
 =?utf-8?B?bzlpUHVLRzVxSUtLNms5YkNFV1k4Z01TdFd0VVZZdlpja3c4Nk5YQlNxMVZk?=
 =?utf-8?B?cUNuYWxYS0VQMG1sYXN4TW5KVThRZHdyTzkxZVJmOW5xam1idjF2RGdOZVRu?=
 =?utf-8?B?TkV0NGxzZTBtS012OHQwSWVGWEhyV2FLN2xaUmVuejg3UHVKRHJ1R1Z5cXd4?=
 =?utf-8?B?bnZCcHFVR1hkK3BOMlhuTUxCVHAxbjUrZkRxK3dLaVp3MFhIV0krOWJxS1c2?=
 =?utf-8?B?VGlUMmJkQS9ON1kva3pZclBoejlHNzNkRUZlamNqNHNNYStIWUlnQ3A1YWw2?=
 =?utf-8?B?L2Y1Sy82bEVldnpIeWJSeVlGN09pRG9YVkY1K0pXZzdrUDN3S1BOdFBXMkRh?=
 =?utf-8?Q?yDnSqLUTRRFbNT05vALwsMAwihgxvVOaYJbQSTtOEkPlH?=
X-MS-Exchange-AntiSpam-MessageData-1: 5T7s1rfAf7AAqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57996ed3-f027-4006-05e1-08deb5524780
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:52.5966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPGvoBifoxELJeIQ1nX9WHShl1HqT27ggSgKX/pM0EdzbZ0fCm7EWJYkbPelL4yLdCpDPE450l51IgpwZdMJIg==
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

Improve readability by moving the success path outside of a nested
branch.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index ff21f85fdfb6..64d100b6699b 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -353,30 +353,30 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
         }
 
         // Using all the images, setup the falcon data pointer in Fwsec.
-        if let (Some(second), Some(first), Some(pci_at)) =
+        let (Some(second), Some(first), Some(pci_at)) =
             (second_fwsec_image, first_fwsec_image, pci_at_image)
-        {
-            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
-                .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
-
-            if cfg!(debug_assertions) {
-                // Print the desc header for debugging
-                let desc = fwsec_image.header()?;
-                dev_dbg!(
-                    fwsec_image.base.dev,
-                    "PmuLookupTableEntry desc: {:#?}\n",
-                    desc
-                );
-            }
-
-            Ok(Vbios { fwsec_image })
-        } else {
+        else {
             dev_err!(
                 dev,
                 "Missing required images for falcon data setup, skipping\n"
             );
-            Err(EINVAL)
+            return Err(EINVAL);
+        };
+
+        let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
+            .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
+
+        if cfg!(debug_assertions) {
+            // Print the desc header for debugging
+            let desc = fwsec_image.header()?;
+            dev_dbg!(
+                fwsec_image.base.dev,
+                "PmuLookupTableEntry desc: {:#?}\n",
+                desc
+            );
         }
+
+        Ok(Vbios { fwsec_image })
     }
 
     pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {

-- 
2.54.0

