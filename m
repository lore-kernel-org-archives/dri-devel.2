Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE69C44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F38210E464;
	Tue,  7 Jul 2026 07:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fc0I2JXC";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A609B10EB79
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp43hbeMzFi81aGURAMVRCu5gXoedATNsYLfmed60n5IyqQxa3uwy8a0VBncZi6TuQK2VcWOoEBxARcN2cvthZpqf18QYlB0l1No9488/D7LbsAOr621Mj0D8z+5GmihXTEYDDkVazIaPhzUXhzy4DpZWAGcKyK0Jtnfne8yWVNfv2CV7rGBJrMljNZ1Fnpnp7CgvBKirnaGQs0bSz0ZuTTDWbJ/Uk8+JwvES0aRrBYTCx1519v9F8OUjBo0wW+PNV5D9x/2mRndRNyG5AK5w1Zuh8b6ArnsidmwB8aPUMMwHKndTmZzCeFv4IAijruTZTCXcklW4RoOjoHi7tmsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an2L21Yj1aP56P8Wo0VCEqMjQe4gZqlAot5YKoLhCFQ=;
 b=w9dFmUCn46NavPIBw8V6802h0+Z70440ZIgHLQZyIjEOTB9uMIai+jiPw7H+hzGcwsqyHNplzk2F9uA0VRVG8KbzM1XUnUezn1prFr6ub98LVheCUyG1nbEtTTKrGeQRvkJIPg+riY5LRqW7cX8W5AUeyMWjdysjgWWf2d34kedyQVCaDYulmPWa5bCv0fT/ktT4kDhrfxandM1IFlo/SHvPB0R5tLa7as8hAsMlDMaUdjsWzVGbdAfD0MGdr3mc8763ItwBW4Y1uLO3ka8GY/EKlVSUWTYsQ7nG2KP/+wD63Sh9dUP50Rd4YAT+NM5ab5W15wp/Ly2gCtFFrAQaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an2L21Yj1aP56P8Wo0VCEqMjQe4gZqlAot5YKoLhCFQ=;
 b=Fc0I2JXCsmSQajTS6vXQwRLIekgpqAlafu0Ink+n6koRSYbh0ro1MLfgrbOi7TtTdcu6s0FBC7o7Y7fgKJDQjwVQYOzORtxG11JxvE9WssBE/ZkfHRVL3PFlfRaXni26DHJYwBtRcQCrNp6k+qishkVF7ngKEF/ESsaTlPxhxAtecVqz5NeELuKB6ZkYz4mpMqSCqgXkrEklLcs2JZzSOWfeFEbyBKmPDc7ipe9398MaEZXEwZdQcZS3/WPcXpITb/mZSNf5CgCzEnI76yej6MLb4kfFj9fNnnVAmP7XEEdljpnCkie9fx71eiH0+Izy9wQINS3E4LqwXyAn3UtVpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:38 +0900
Subject: [PATCH v5 05/13] gpu: nova-core: gsp: centralize missing unload
 bundle warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-5-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0130.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c48727-dd78-476e-a55a-08dedbf877e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: +IU5P3qiggBBFTDCR8o7To8PFcPQK2bi4Ma5wrkvUFaf7KMEMgnNvkEkyWVEPGFpnpFeNScP0ZTNMC5jgfT4GFDNUsG18BBJr8uRi0/LqWX+t4CAEUhyXBVhyIGA3c/tJJeGpEyB+mOmyC5i1d3mUm3DseFMDZthqtG4Tu57XM5rRi8qlx7X2w5FlXexAj6zHjoTEqVgpxENjKWD1R3VTI2DlH7bgSssUdJo7OEpuuxWT95wWM7dZgsH/7QAJyf4S0NlInGeKbsdTUbnrUc1f9CWVEbOl8OD/91AJAd4HZr1Pm0uMewYNNhXd1+ee6cqbqipINJVcqTj5o/pPsIbVXIV1VsZdZ/AH+8IQJi7AU7c+own/RF7o+PY+KrZ1u+Fl+nIRz4cpOAaH6UOpcQozmJCNFozL6Txq1I1TylH8OF6xiCZi972fRcT4WL6MCkeCzG6MPqIKtJe9vT4UDev8elZ9T2f33FhHfyM8vCwWVeKN+QRh1ktXOnM0hAsoJQFphJQIn6sTk5C438cu0/xZwOGzvqiwymXhKKhQP7rgAd029hFKQb73uadVHSnuShXSIkkQiBAZ6Hyesuezu/z1ZErIv+kIMQDXMcmBDriG/Hv2hpDZvE8fBoHSnlq2T6qBEUk65/2NkOQUCgR94iphRUOyaSU6TXohV+NP4SkLBeRO+lNx0gUkclkktk6IGtCc405xV59uhCbBVlcnIaYSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhQbVRDL3lrZVVqdVhYMkJpVlVKTy9yWkJmU0RJdDJ3eDduSzlERDByR0V2?=
 =?utf-8?B?ZFY4OU9nV292VmMveGpVT2ppY2tLTGlpZjdzZ1d3aXBYYkE4S0N2NlJQU2RK?=
 =?utf-8?B?MDVhNm1oWlJDSmxva1YzMXVrRWhNOGkzcjg5NmlTOEd4bEZML2prOEVYLzN5?=
 =?utf-8?B?NG9sNmdRZis3TFdDUEI1Qjg0QVREVmZGS2I0RERiMXV6WFhjbStLR1hLcVFs?=
 =?utf-8?B?alNXOWV4WmY0RXUxTXZibFdpc29Nb2ZNT013VW9VQWtUNzZsUEpvWms4ZElS?=
 =?utf-8?B?MHpZWU9LWjV6NkUveStiZExMYXVMRGtncmFFdHRJb2o0U1VHWXpBbGEvTU10?=
 =?utf-8?B?SkFka0FDdVpLZGo4bXh0WHloZTIzNS9WWE9mYlpVdkNUaWFjSE9BZEpHaFVM?=
 =?utf-8?B?NGppUFBsWlVSbVhMcDVNY043QnpTZGFmanFzc3NiSGMvWFg3TXk0OFlmWmhC?=
 =?utf-8?B?bGoxb1FCYVYwWEhycmhmNmhVY1I3cjVmdVdRSEJoZlJVdEkzcEVEd1cwb3Ev?=
 =?utf-8?B?U2xNcjlIdVNibURTMHVQd1NEM2Z0ajBjTU9RamRZSFVDUHlEN2ptckttRFlo?=
 =?utf-8?B?RTY0NGVyajM1a3dhVFJiYkVxQVRQTjF2VzZJZSt4c05iUmd3cEdKNmx1dVVa?=
 =?utf-8?B?Z1Vqd3ppK2w5MDZGOXhkcGZDL0ZjWG1MUzNqckJMTm83bUZ1MXEwWXRJNXpC?=
 =?utf-8?B?OHNncURkR05nWklLeDN1QjcwVHJpZktiaEVtV3NPRUpMM2d4ZXVsQVMwaEpO?=
 =?utf-8?B?UExpU3lmMnNVWlgxZGtpWGpiYlJmRmZiMTZvL3N1TnlGeG9aTC9TdjA1Q1FN?=
 =?utf-8?B?WmcyRHBZL1g0cXFaT1M3eUpBRE1sUll4cFdkdFFMOEorOWJYbjFIQWYxQWdW?=
 =?utf-8?B?ODVJN2F5TG9ZYjdIM2lQNlJrcERtZmJQYW5CYS94dFhDakpFdmRZMjBHREpX?=
 =?utf-8?B?V0ZJSm1WNmlGdmFtVy9sKytNNnB5VzVhNUE5c3UvV1haTHpqV1BLV1N0VWs1?=
 =?utf-8?B?QUdzTklkZWxtT1Z5dHFRSGJWZWFVbTltaUplcjJvNmRWeDB1RWsvWlZ1d0xD?=
 =?utf-8?B?bWNiblZWNkxGc2dLSGp4K3RjYU12L2tZaUxFTTc3UEl2SU9kdzBVNEYyTkFW?=
 =?utf-8?B?dmgyMVpDZW5xSzk4RlNBOGExWVdUZU5QSVFhdi8vUTJZS1BuK29zSi9WcURV?=
 =?utf-8?B?QWVLQ0doRGdGMURqMm9adDVXYnVWV3ZCWlJHU2NRa1FtRXoyUWlxMXZwcDR3?=
 =?utf-8?B?OUdOLzhoZE1idXZnckJQSHNUNDlSLzc2ZTRRRjJKdVBvZGxOWEdwV2dSZ3Mx?=
 =?utf-8?B?UjVXMmo5Q2J1WGU4SXNYMXhnUzlDRUNXSGtZelk5VjZPSTV0WnBqL3dnQkEv?=
 =?utf-8?B?cEcvc2NnNEJvYzBER3k0cVg0ckVkdEJCYWx3QTRpZUMzMXc5Z3ViRGhKSlZL?=
 =?utf-8?B?Q21WOXFSZnFIWHB1dkNicTJMNTNHalc4OWlEOG5TRFZzOENLT0svTUlkSXd2?=
 =?utf-8?B?ZFVFeC9zTG0xdzQ5czRhVmJkQWhOaUFyTERCQzZtY3h1SEpIZTN5cDFITUJC?=
 =?utf-8?B?NmtnUVRkWCtkQkJodnZxQzBxbHVCTVcyUERyMUsrRFJ0K1pkUWxYVDhZeWE3?=
 =?utf-8?B?T2swVUhJNDU2NjR3MXBrM2t2N0pFOFkyR1RuOU9uQ09VcDJOdWZMQ3FqY25X?=
 =?utf-8?B?MXBtR3M5bDNad21JVCtMQzJtc01LckpiOUpEczFpTHJ2T21ncjZmcFl5UHNX?=
 =?utf-8?B?dzhkYnZMOGd6VllROGRoZ1ROYVRsZHZKL3lhOVZFUTAxaTlPNDJ6cDBxR05v?=
 =?utf-8?B?dmRJT1JZSTAxREQ1T1hkOUNNUWxxc0h6bmtsUDFlbVJmZm5vM2pOVDBmUEpt?=
 =?utf-8?B?dUtyVlRIMlhtTCtpNjJVRWt6NTJiZWlFV1BuTHNlelJoZW1rdkl1cVdERlZs?=
 =?utf-8?B?akY3QUpGcXdSTDczcnBSNWtkZUNUYVVGR2Q5dnBqMGR5SjhDYTBteUNxMEJJ?=
 =?utf-8?B?RDFHRjZaZG14eHI1ZVFlbFQ1NzJ2UHBMZ1RZTGhFb1ByeDQ4ZWR4V1N4SFRu?=
 =?utf-8?B?REdqOW1uSURFNlZsQVNUZFU3YklsZ2J6OUUxa1JTenJUaUdHbzJCbENveWJq?=
 =?utf-8?B?WG1zWE03a0J2aitDRUFUNWNYYzFXU1VSenRXRHM0TWdmRWVIWTlwSER2VGFM?=
 =?utf-8?B?eDAzY0Qxc2NyRCs2YVZSaG94MHE3eEVmRDRGL2lnUXZIVFNrZnF0TnQ5VnJ2?=
 =?utf-8?B?ejNyNTdZcUlZWmprTE90YjVYdTJDamZQVjJqK2l4Q3k0YVpwUEgxYlBNdE5p?=
 =?utf-8?B?ckZ5cU9YSit0RDluZjQ3bFJzMklLVHJaL2RTVGRFeDc3K2hrdE9pWVBhOWMz?=
 =?utf-8?Q?rn+iP57ZtYyuH3uNV+GQd6WdZ8kIPXuYjhKd32qlyT25n?=
X-MS-Exchange-AntiSpam-MessageData-1: PhnoMpsfWm4ODw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c48727-dd78-476e-a55a-08dedbf877e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:14.4597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUgBjsI1ibGTj/HzlOWBuWquSgZTjWeQoFcNg+fNik9meg0c31ATWbiA+Arst8AlUGMpXZFlEvB3FMXKMyt9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

The warning emitted when the unload bundle cannot be constructed is
valid regardless of the boot method, but it was local to `Tu102`. Move
it to `Gsp::boot` so it applies to all boot methods.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 10 +++++++++-
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  9 +--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 75054424a951..430ffc57b136 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -56,7 +56,15 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?.or_else(|| {
+            dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+            dev_warn!(
+                dev,
+                "The GPU will need to be reset before the driver can bind again.\n"
+            );
+
+            None
+        });
 
         let unload_guard =
             ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index c0956fb1c9cf..ef465b99af05 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -278,14 +278,7 @@ fn boot(
         // If the unload bundle creation fails, the GPU will need to be reset before the driver can
         // be probed again.
         let unload_bundle = Sec2UnloadBundle::build(dev, chipset, &bios, gsp_falcon, sec2_falcon)
-            .inspect_err(|e| {
-                dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
-                dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                dev_warn!(
-                    dev,
-                    "The GPU will need to be reset before the driver can bind again.\n"
-                );
-            })
+            .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
             .ok()
             .map(crate::gsp::UnloadBundle);
 

-- 
2.55.0

