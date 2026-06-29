Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7637DC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D5C10E8FD;
	Mon, 29 Jun 2026 14:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLHh0lUu";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0781910E900
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW3NROhgTogaKyTtPxcZIAPxlutBXBgt6HBhvmYTrrrMr0iiO3eSdDUFZJZB4MFLc/LTitZaTJAaVKrvSFdUlg6jGGEFApwr0PuPWeE4kEOL6firdMDfp7ZvWi7yj/U+5kS/L5AiMWPx1dbUjhG5/i/a95saZZwWGG45O71uJGxZza7xr8Tlaz6W3hY+v+Qpgap1n6D1rnZqnYXspZf9HXdZX8HM74e77qjglyRkr4o89JU2acjVzKCUBTPFriztW/WwkX6MOQaoTQrhp7TEQxN88jhnwokzSx7uUrEVPYhEX0JNq4A7AALkjaGaFFpeae9aDReOQeOcIWslru6+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2o3w12GyFwskf3OqP41YlB5rFNYQhErP0koAZmnxMw=;
 b=fmKt8LdJf1LgPBBtYsS8AalTTMfXkI+K4WV1W9+ReZeXIJJsb4zv7EmGEonkIAYCEQP7LGfSJLdU2432zRBu7PhE80VxAY9dwwpcROYrxveXFQU9lyxl1yDbdi+G5N7o4I+5IUxPKYKlIFiyrspPWNsHwAJzlx2wIJileM2O9PdYZ/VaZ6SdpdvWnu1ta3b8BBi9IQoKMZHV3PUWpaxA+cPt7WKDpp97quG5f03qzhHrs/IWybV4sipY78ALQDSd6XKaKym+WPV4vw5XyrxWoRhewky2IguXaX+zTrfzp7VMESpFzlQnp/nPZFGsr7QRPzUVxBO3bqgtV+TATmXbzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2o3w12GyFwskf3OqP41YlB5rFNYQhErP0koAZmnxMw=;
 b=WLHh0lUu0FSw7VDHhBnFgnxq5sIfQMQjLpkOzQOCQneEznUK/Ie9leGdRhsRukw3P07Vb9QGaeCKYc+dGjNgLIt+gBPlQtfOIm2PgRkRtz3bhDndfzfEHF7VOX0ls77yM/EEGBFQULxFDQrutwy5sZ0gXE/WnJ/EovX8iLhdTCbOqrlF/ChWhIydsiOF1DsXMT7oAcH2uq1Jen4H1D4y21BU09iDZXmct7nsw+qFABH3JFbTjRcfzZ/HuNy49gXS2Rp+08KtQPsllpHnUw+uUfmnGG5AOZ73wVN6l3pa2b1jWCc3UxymBeaP6lObdh1L1z3Dh5aSHZEMC4M0Vtqa3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:37 +0900
Subject: [PATCH v4 05/13] gpu: nova-core: gsp: centralize missing unload
 bundle warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-5-5539d8469590@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0288.jpnprd01.prod.outlook.com
 (2603:1096:604:25a::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6f70da-0833-4711-e61f-08ded5e81eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|6133799003|11063799006|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: w3+4OAvBoGy86q95gUKPOx63P1xmj8+FjXR7wohTW2waWifDv3g3136GoAPDZTovVmKMfeTv8hvCkDyLw+ZBFY92njPT11EE+1dRWsmG/WgHtNHu98xrrfKg+G7kEzuNwnjoXp07Vy+AJY65CJjTUmxfs3klViQpvdnFygYzJNR3o1lEKgLP1Z6lpk2t7o7nrrEaivJWdt3IJv99ycbsmDJMlzjpy2Ingu//ImLCuS0ue5bwPrinaGjghridaqed6vzIH9bsh0/IPjJCHtQffybFwetDeTQuwIgGYBHXn03qojKLosUy+2FV7GUMKWuvYhEG9o34he7HLm/dyHkM7kHvZ3DjWvK/LQBsPb50/rbZQmjGmALbgl8KlXU3gAwNvg8wte4OhRuJyIUmaOmTtRw46DsN2W9bOXv5NAoFkYNPqb3tT1h7qEYRyYLgCY94rOfZ8ngZXJam5j5NMSI3p7PbuYop83bGA+GFbJMqaoKFmx3Oc17OI9F9oCsueZ5O1MUgehjvo98QBlIzC3k+8JRQIX5VzHX4rit3JvPr3HL6RDbrt5VONrPl8Hl8UeZGpoai2AELeVXrYEw8K7EgrBHsYqfZzdhSQT1BMfIVcTinkG2ogaPUOXxwW1GD3voMPdHZ4fbX4axL6csps8c3lU/2rt9NRiGx/8XpD0us4B5TfKzrwIY34fzGC9B+dQ7WXygjFq6goJ/oFWfxl2i0yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUU5SlptNkticFUrV3FISUlaaTZkeWxBQ1BmdGdXQkZrSk1jQjNFMytjMmpT?=
 =?utf-8?B?K1hTb0FVRWRZYXJQWi9aWEp6R3FqNHFKME54RERGVzBFL0V4K3MxQlZNNDJ0?=
 =?utf-8?B?aE9lWXduS0hJTWJCR0Z3WTA2K3FETEs2bGc1NWVzZXJRbmJ3Yk1IdzFCZ21q?=
 =?utf-8?B?M0p1K0VQVWpLb2lCVEZ0Y1IxalVhOGVIRE1oWjVnU2trUWtTKys2Y0w2a2pr?=
 =?utf-8?B?N0t6WkQ2Q0MzUDg2M2NsNU54S3l2eHJoV2xvRDRaZjg4Qi91QjNoQ2k5TkZF?=
 =?utf-8?B?Q1NoVTQ5SXZSL3F4WDh6MGhKVmRjUE5IaE44NW5uQnpiSjVCTEdiam1hd1dI?=
 =?utf-8?B?YnpaTlg0QnllQzRISTh3bGRVUVJIQllSMWp3Tk9hUWFFNVZJb1ZicHBiR01E?=
 =?utf-8?B?T0hEdEVKUlBJeU1jMlBiNUF5bzJRQUx6eXloQUQranA2M3dCejRiWkdlRThF?=
 =?utf-8?B?ZjJpMEtNVFpIZU8rY2lpNWE0TElvZGVTSnVpWVVJTjZoeUlVUnZDTlJISllW?=
 =?utf-8?B?MFZ3YmViOXBTc3ZTZ0Rub0xBKy9nb3RRblF2ZmZWMmlKUGx1bUZWZ2tWYnpW?=
 =?utf-8?B?aGRoSVpYUkk2MUs5djV5NTBRZnVjbmI3QzgxdVZmRHBTWWNKSDQ5SFV1aTVK?=
 =?utf-8?B?NThrK2RPRXJBTGgrVjh2U1RHdkphNERxRktFTXE5ejVmZ2dFODhVVW55Wndj?=
 =?utf-8?B?WTNvQzRHR1NMSWpTdEpQZ3JsN2pKb0dQNWhWaVZpZ1Z5dHE0Z2NJVTBKV3Iv?=
 =?utf-8?B?OVpmcXlUQjBiS2YrdXVBaEtHWmMzcVg4YitQb1dWcDRLSHQ2TWMySlNxNjNw?=
 =?utf-8?B?ekhQalcxZlFYK0tqT2U3N0NSc3YvbGRPVElZRUVMV1UzQ3o4MmJwMlp5WW8v?=
 =?utf-8?B?b0U5UjBZdVJ6dFJoVnhvLzZ6RER1aW5TbDFyY3F2YnlmaU80ZVNUb2FtcklG?=
 =?utf-8?B?ektaa05lcFRQYTFMbHBQWWMrOHRhZ0F6aFFRWU43aGpCUy90TEwzdmQrZ3Zr?=
 =?utf-8?B?d1dYRWo4c1JkWDlGUTlmZEtPRmVNYkxZNVJHVGh2bTNscWdPelNDcXhiOTl1?=
 =?utf-8?B?OWE3V1EzanluQzk4WE1IdUR1N2tpMHdRbFgyNU1WSFBETXVEd0xxS1lHMG96?=
 =?utf-8?B?Y3JLYVYraVpHazhnRWhGZVJhNmprYnZaVFFBRkcwOEFEb2JkRkU3MnptQnIw?=
 =?utf-8?B?T21BTG9XWjVJT2NHQXdmRUs4VFNMb2NXYVhRREhFRm1Pa0U2bWdUeUF6YzVt?=
 =?utf-8?B?UWp2UHZCT0tpRWdiWWJLVDlEV21VMXNBUHQzWFlMOVgwWDc0N1RuK2MrYlg4?=
 =?utf-8?B?eHJjTWVWZUIrelQ4QmNPVnNtVCs4WWovM3c5amduV3ZiWDJvQVdTTnQxeEIw?=
 =?utf-8?B?QmlnZmVpTG4xUU94a20ra2ltdjdrZThlU1VWczZ2V3FOekVyOGpQUmtWNDMx?=
 =?utf-8?B?YTlYMGg5VlRqdGUya21ud05jWENINkowOUhjeVd0eUIwY0hDZGFuWkNMbi9T?=
 =?utf-8?B?THJiano5dFhFa3Y0Rk5HVm9jV1lJSHZjanlUcU4vNmxzV0JjcWZpdUxoY1FQ?=
 =?utf-8?B?NG5QUityWm9VYWcwWkNVcHF2Z0E2TThzV3RVV2xUMDJmWWNUS2N6WEZhRGhk?=
 =?utf-8?B?YlBNODQwSzhIbkFsNnRPTHZwNDNzaWFseGR1bmNsK1N6MElwS1NyZVRZTzlT?=
 =?utf-8?B?bWpoZmI3Q3QrVzNNOFZJZmlTVTJjRkJqK2hYRVh1V0piUFlhd3pSNnpXVVVS?=
 =?utf-8?B?MkNwZHQrVUFvVzVSSjhvVEYrOThJNXBVV29ndEtKbWs4U3pHZmJJY21EQ1hO?=
 =?utf-8?B?YUU5SW4xN1c5K0JHcEtHbE9EeU1RTkZEcUZaTzVIRURZYXR1dFNwcXlnOXFX?=
 =?utf-8?B?eTdRWU16b2JYNktacWlIWTRwZndwcUVzM0t4MUNLdlBkSHpJeCtSUWxTVWVV?=
 =?utf-8?B?OWRlb2Fyd2gwNnpmWi9XZ1g2cDJaRXJNMHZYdy8vT2NYc1VSd3pVK1FXbkVW?=
 =?utf-8?B?cHQ5T2NjaW9vMzFCUTZCWlliV3VWaTc3OU5leE9vczNSMXhYOEwvaEc4ekdy?=
 =?utf-8?B?cnBRNmtXSHYxcytOSTQwOXlRTk1uZ0RGT3hrSnRWUGwvQmtZOG1ZemtnTXhw?=
 =?utf-8?B?UzBoR0VtMzJud0I0dGlHSDRwK0xnNUY5bnhJRXlRVW92aXA4VEVOQ3A3TmdV?=
 =?utf-8?B?TkJGUmsrWHFFS1Mrcnh5NjhPQUVrMzJMejY3ek15R3BmTW0rODNiSW9Zb2lx?=
 =?utf-8?B?bVZCZFM0NzJFZU5qOTZpZmx1RWZPRFNpbEdGbXYwMTR0UENUUTVsRUs3WHBR?=
 =?utf-8?B?NklnZllkeEY5WUNEUWt1N3dCMWxwTzhxc1BVdk1JVGJYTkpEd2NodHlEeEFR?=
 =?utf-8?Q?zsUPcorCIspzqq+eD1nGvJz6q75B1nlU8DWm39+KoTCxI?=
X-MS-Exchange-AntiSpam-MessageData-1: h1xtCuIVP/Pbqg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6f70da-0833-4711-e61f-08ded5e81eec
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:06.2556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vji803GSBoIbx/4AmkQ/Lx2fnU/08R2u8nPYgnfGmK164FhlpUO+M4IDB/yrKXyHeLlYgX+TEdjy3Vq0XhmiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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
2.54.0

