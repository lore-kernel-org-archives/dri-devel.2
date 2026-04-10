Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97895E99052
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0892B10E8EE;
	Fri, 10 Apr 2026 08:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGr4/iO5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED50210E8EE
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzB2z47TdgMq0XMa5mSJhDsHhpB9a4iVDEqPSBoRGZmat+GgtzVbsOJzuQ81yX7NCKxXqes6/GqoE1nNMn1cfxditb5riKdwgMR1EAibEnpokbwiAdsVn4zwe1xfn7qe2qnpug6JeYD1zImbLDMl/VQUw4syc2vCxu8eqWrVBPc/G2DeQNPfUr/623QMLsqQhTKuovjbX0XwKfvWU6fiGoEvBmFIabeC/gXRWk1S0T2mp+RuiicAu/nGvCfnCKrkcZvcOBrI8oFuup61rdZOXLelONpI0Edjgzs8IzPqfEvonM9f+V8LXwi+DiBcFJE24P7lJCbKH74rMTDuKcNNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BwER6Nk5cO4ECkE0QPerqfD8CuRQzIVdWOBZNVMWqA=;
 b=DTpnYa5dt7jnHx0YhjxARE0hR4FjXgpWLW5Z5Kfdvf2RsiIxBRlX8s6RK/PjksNmYQWcesxEjswiUkpGB6pMAJw80nv/4HZexp/0AcvCumPP5kenLq1bVCsTd+5xE9wsboFLQtCNfzKiv2CWfoLBu7mndZyqvC11Tp1CLJ3xCWj0h487M0GshZCnkZ3l8C2M2M6z5euQeIl3igqbXN/UWk952Yn4A5x0zxRjSpVXmdGWgVmacf9iNHoOfD0zVWtAX/H9wGkCb80avCYAMDJ040204YkvLKB5EFlPEIZOMz2Oz6DANyoHdxzjgC8qGJzqdSZ1fzyCEgs38jm0XoHS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BwER6Nk5cO4ECkE0QPerqfD8CuRQzIVdWOBZNVMWqA=;
 b=mGr4/iO5LqqTd55s2oihFcYuSqwRJHO0gv6x8/svD8VtK+5A5YJNSaR1pVcHTMVHWvOhWgOUPKmP5Rb/Awkirywv312n41UOcnwcy47VzUBYpcFZHvU/L0isuOCQ37hNgOQzXMr2rZh9wlMMrM0u5tPj8LtkWIJVBrqfdNv8UQbkCpQjgmFcMIVVqkE56rIVEwoRF2BdIACIpFmGYL/Dvjv4zKysPYkpBNHJ1VQSlLz5koMi27g5+XvQaR3uGXwRf8N9EEW5ZOJmHKVyR0ADwXX4VY2gia+JK0MKer4ovS62Hq9sUncgfMfUoupbYH8NtimVeM8i++WmSwiKRrjwSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 08:39:18 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:39:18 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 10 Apr 2026 17:38:51 +0900
Subject: [PATCH 2/5] gpu: nova-core: vbios: limit `BitToken` entry reads
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fix-vbios-v1-2-bc6f71d153d6@nvidia.com>
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: DM6PR01CA0010.prod.exchangelabs.com (2603:10b6:5:296::15)
 To BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ca196c-622c-490b-a627-08de96dca76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4ifJjT5iFNvRqDpWFko+hDqlkR/kHq334s5tUpgSHe+z+6KYY0HpAW+9x5cztxak7TSEfUGE4C2arroWZL6iOLOSrKb7/sx5W2r6fSliyBsD5ACBq9NxcMJ16Iu0gzG9iEl/5yvIzLNpPAcB0JefAkMEnHv97JJbt3hJiRR7plQ1pnxqT5K8r9jR9DyAhV2HrJjCKu4vHOLIWlzkeTcprTPvZnVYgtddplwh9S465Z25vxcFom4mRGeoX+Ggp9sUQMdtVNuMBYIj9HWQ1kDs4kWOEHVKOb0LuIRcvorpDeRMZQx2Y53VLTqJTS+WwcJVCiVPXMGmjrK21+UTatIxKmnQTzu8pCtqNhNXPVs0j16Gq/Zi55V9fCAin8FKfncjnLGzpEXt0dFQGVEAJQJXRUwkipq28uBvjWlqaZKpxLJ3FHL5weGyhMPmrJvFlzUGI2rhOfbeg55IQkqXW2A68nipdvYywY+JIbKGXJW1sORJgSwfuz7wd/vbKhWy+6xsBUL9HwSbHg8BAJPaA9fh5Bje9vpjjt2OpWfRT9yLFIQARJovTXhLjmlwDsSuMB1c2en3ycQcKp3DInZBWL2U+9ep7Ou5+nsMyPJFccdE/yfNT5i95NCKZIMrbWaH41iycMLnomlROr+Szu2oP1cQY4qSDP5csCfVpj4KczAlutLEQILuKa1j6hgvWYOSzmjyi7oeWhbJkzSa9+ssust46GB/ynT7ovAJBn3UNLNbnHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9EVUxxd1lvYmd4YVF1aU8rNkNiZGZNQ3BPOXA5SFVxUytaTTlZclhPS1or?=
 =?utf-8?B?Q3R0eVhPajQ1U2hab3pRRGpzdk10c3NXK1cxSHpNSGRXS2w2a2laTnpzb2tK?=
 =?utf-8?B?b1hzcjZmMmMxVFY2TnZYdHNkUytMeWpieTk1dEROUjZhQmp3WTBBelBzOGFt?=
 =?utf-8?B?NkM2U1RYaWhIQnVjOGRHU3UzOGliWU9Fd3JWWVZBOUtuV2ZZWkxPQ3BnME5Z?=
 =?utf-8?B?UXlnSEZ0dHk4Y0IrUXFkZVExQS9pb3pGb0M5YllqakM2MEhoRE5GZjlVWUxS?=
 =?utf-8?B?V1p6MTJwZWNvTDRtVXU1ZWRIV2txNGhEaVZIcWJaaGhXTHc5TlNRcVhIelFO?=
 =?utf-8?B?NzhMUHZjYk9HVGNRVTlncVRaaGZxa1M1cGl3Yis3Y0ROQXhWc0F1eWhyOUp0?=
 =?utf-8?B?RVVmUE8wWHltZ3VmWjlWakNtQmdhT1A2TDZvR3FibkVPZEFKNGdVWVlOU1dL?=
 =?utf-8?B?UUZIMnVmSnJBNmNxdHE4ZmpWc3cvUEZpY3ZXb001VWZHdjJoaWVjbHcyWkNi?=
 =?utf-8?B?WnlvSU14YldZTlFUWmhLeXVIY0tVNGFLVHZqZXZraVBsMWRLOFI0cDZEekFq?=
 =?utf-8?B?T0hrWGMvNWljWFo5bzI0dHpJZXkvLzZKNmlGR1lOSE8yMGozbG53UGZ0ZG1a?=
 =?utf-8?B?amVLbTMwNVdCV2lIdklWME9MY1pHb2xBNXVWd3V0cXltQ2lSdy9PTHp2dlg5?=
 =?utf-8?B?Qlk5M2M1UnQ5YXF1MjdxUGNLZ2Q0MU5jcHlXa29DTWRDeVZ2ZExITTkraGRz?=
 =?utf-8?B?RlFxcDB1SXJUOEJpVlgvWG4yMXRhVk1GQTE4TXliWEo0c0t1Sm5MLzIrZnMz?=
 =?utf-8?B?a1lkSkk4eXc3Ymw5c2R3Q1lIbGJlM2U5TjNQSXBMUHl4WjJJM0grL1hXeWRN?=
 =?utf-8?B?d3ArOFVtWlZXRDB1RVNHRlhuSi96dmJxcitMT2lMRzBONXJZbW4vWEZuZ0tE?=
 =?utf-8?B?UjNEUjc1VnMrVTlFRUxKaTR3bzRnc05QdkFQa21xaTM3ZmZCN2hkbTFieVV0?=
 =?utf-8?B?aGY3UHlLa3hOYzRlMUx4Mi9TZTMyN092Y05YcHo2MjJBbXhOZXNWV0piVDJG?=
 =?utf-8?B?elVXbnZmRHV6ek5oeCtkc2NTUXk5ZWl1Y2owMmlEUm9OY2lmZVI0WE5qWkRG?=
 =?utf-8?B?L1dzQjZWZy9OQTViYjJTRm85ZjBXSjBVM3Y3K3hjRGtiSGwwNUlxZGU1aVY5?=
 =?utf-8?B?VHl4ZDVva3AxV2N6Q1EzYzRVakc0amFSa0F5Uzc3SzNsZHg1R1VDekF1YzZO?=
 =?utf-8?B?QTNpdGlZM2U3bmFxaEVvYVFKYk5JdlF5bXNXTWlMaFF2bUdiMEhaUEw5MlVn?=
 =?utf-8?B?QXlOYTBQSFAydVVtWGtReExyZ05CYjJlZ0VXMFY4SkxpZlg4bFFsYmdwalRY?=
 =?utf-8?B?dmZqQ21OOHRoQ04wazByRzNPcVZSMUhYRFEvQ1VPeFpHMlNWdndQUXJqaktB?=
 =?utf-8?B?dE4xb3JHMFpKa0J0c1NBVlduSmxxK3BaZmRQRjBTRm44RjRHa0Q1eHh4c00x?=
 =?utf-8?B?TTNmOHJFN05CTGczL1FZZXU0NE41YVVaS2NnR3BNUnphNCtIZnQ2bDZtVFQ5?=
 =?utf-8?B?ZzVoaFhzdkY1L05wS01TVWJTbGIzUE0xaVZaZjAxTTFiNUVWaE9mcHRLWndC?=
 =?utf-8?B?NFJOWkNMbDQ5MnhOZGduN0xNYWJGWkwxMGFhS0dETGZXSEQ2bkpiZ0RQekFr?=
 =?utf-8?B?SEt3NmVoNDVHYTVYcW05L01uTGVDczZpYVN5a0lIa29nbXJaZStJMG9XMjls?=
 =?utf-8?B?SHYzN2ZJMVNaZHlIWFFOQ0Y2Y1pFSkRWV1B2NDE4NVBnL0IwT3dhRlJNWW04?=
 =?utf-8?B?c2o4Vm9CcFN1Y2toczVoMTRXL2tSUzBMcUdQM0VCSHhUVVZoY2s0Qk9DTEJT?=
 =?utf-8?B?K1JQWnhsLzdFLzlEcTF2MTQwOVd4VXY5c2ZiS2pvWmxUSytMRHVsOFRRYnlR?=
 =?utf-8?B?K24wc2ZVaHZUV1V2aysrL2dXMDBsU0xGYitZZEFLeFhyZHdDM2V2ekhzSk5C?=
 =?utf-8?B?UGZBVkZ5SStqMWZVNFFxVk0vQTFzK1Z0a1lCbld2QlBRWmNFdGdBaFZ1S1pS?=
 =?utf-8?B?UU9mSjRIaWVWTklzWS93RFU2ZngrdkZLMnp2dnMrYW1nYklCNy9LamxUdmNJ?=
 =?utf-8?B?ZS9FWGR0aldOVUlWVnBSLy9IZmRzU1RvNFdXYnZNMGZEQ1B1Qmc4L1VzTEs0?=
 =?utf-8?B?Z1d1dVQzZktaWkRoQjZIZCtFTGNRQW1VS2RUb3Rhc2hXeGdpU0NrNmRTQ3JB?=
 =?utf-8?B?TmVzMUR4ZTE2R29jeXlFQ25kZmUvY0hpOXFkUXAxMlZMZStmNC90bVRWeFRR?=
 =?utf-8?B?VUE0U05rV0hRbmIvVWpteG40RnF5WUxZV2h1cUhGZWEySDZab0kvN04weU1v?=
 =?utf-8?Q?gSsPbelrhcahdIh+A+Wx4yh/TTnE0WPWqHITx8dkP9bfa?=
X-MS-Exchange-AntiSpam-MessageData-1: r5Mc4cq01tHZKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ca196c-622c-490b-a627-08de96dca76c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:39:18.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snToGPUK1gE+hR66hQqFgsP3mL8iJsCJ+69UB6bFKzweJeG7C8l3JX947yQ0KXDf+w+yYI2fs6KGnTYBmfnybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

If `header.token_size` is smaller than `BitToken`, then we currently can
read past the end of `image.base.data`. Check that the token size is at
least as big as `BitToken`.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 6de7e58e0da0..de856000de23 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -423,31 +423,31 @@ impl BitToken {
     /// Find a BIT token entry by BIT ID in a PciAtBiosImage
     fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
         let header = &image.bit_header;
+        let entry_size = usize::from(header.token_size);
+
+        if entry_size < size_of::<BitToken>() {
+            return Err(EINVAL);
+        }
 
         // Offset to the first token entry
         let tokens_start = image.bit_offset + usize::from(header.header_size);
 
         for i in 0..usize::from(header.token_entries) {
-            let entry_offset = tokens_start + (i * usize::from(header.token_size));
-
-            // Make sure we don't go out of bounds
-            if entry_offset + usize::from(header.token_size) > image.base.data.len() {
-                return Err(EINVAL);
-            }
+            let entry_offset = tokens_start + (i * entry_size);
+            let entry = image
+                .base
+                .data
+                .get(entry_offset..)
+                .and_then(|data| data.get(..entry_size))
+                .ok_or(EINVAL)?;
 
             // Check if this token has the requested ID
-            if image.base.data[entry_offset] == token_id {
+            if entry[0] == token_id {
                 return Ok(BitToken {
-                    id: image.base.data[entry_offset],
-                    data_version: image.base.data[entry_offset + 1],
-                    data_size: u16::from_le_bytes([
-                        image.base.data[entry_offset + 2],
-                        image.base.data[entry_offset + 3],
-                    ]),
-                    data_offset: u16::from_le_bytes([
-                        image.base.data[entry_offset + 4],
-                        image.base.data[entry_offset + 5],
-                    ]),
+                    id: entry[0],
+                    data_version: entry[1],
+                    data_size: u16::from_le_bytes([entry[2], entry[3]]),
+                    data_offset: u16::from_le_bytes([entry[4], entry[5]]),
                 });
             }
         }

-- 
2.53.0

