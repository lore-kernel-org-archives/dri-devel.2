Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8A0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376BE10EB7C;
	Tue,  7 Jul 2026 07:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJdtipmN";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF13910EB7C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCX3Lvyx4O2J7kT4Pn8sWT83jyhy5awwmzAgfu00T/G/M7B2VJM2ef/PabAkZCxtozcXD7DxlUwtAkIi89NIDBXVTSxN7AKJOUjYrsNCAeFxPYCqqgmkfqp5DRAS68kc/yMDBiDCFPmm1uqGgDs2uZmvUOywqzpRSZmMTzzFjl4qE82YfashBNa9ghe+GZRVTjIozPDZuVf//0ialYWd3jJBCrfTgiYtcxIVed/htY+ra6oT1lykmDYGsWlc8LdVlIaH0vUM/cI9dBl1+/Z6ybzYxKrQuLbmKCEEy9lxIDBZcubB7O0HNsXHFN4ieT1PWDUDZnm0gwRT8/vBbIbKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCMnPAEZIhT0XwIpqmHyLgnB3jhrTBPoSRokuLZhbEY=;
 b=Q2MgtfV2n944l1K/SQRN95AsDYKr4r+ANsdpGw+8Ai0eN16JY2e/qtaxiP7yZlOgxJ+i+gcD5l98VJ8A34SaJYOS3ueqCuWfkTgOEmIIwrn4DynPzi2RbW8g0i9gQGjiIICPmO2PQNlBorcIEtc1lIvWXoP8inuHu+xro073PLMv0BFu3zB7fgFLjZIvVZeYpIT9qO/vqmiSE9mAdJuGCT4oJ5ELdno2yFi+Jr9JI5voZgeL9xdDIAssMyYocSVQXJ9AqvlgdgTeRP2z6R5BHvnf7Dz7lamsvJgnCHdY/nalKTJyUWwGrl69zKjAmwySZiKaBkzWe+7l1hGUF5Z+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCMnPAEZIhT0XwIpqmHyLgnB3jhrTBPoSRokuLZhbEY=;
 b=TJdtipmNeG3yyb9Pqr/0Twqxm02PyevwXJhak0Hf5accPQyI/aimbZoutYaQLs+2hJvJtHq5p2kvGdjadDxhwV/IKp/LKzVAj5tDM4+2bEn47uAQQFKqktX96e8fHvRoNmD1MdxoETawM8kq4qvTxxjAKvtJ7htiVI8OFeEl6SpGnrvGIkYJM5GkJo4ZQF/fRMN8qDPro1Ow/3etOUDvOtSTtL1AuanFYINR6GIAMuC2txr1IADTzS1AAjzpaBqmOtOMXV2n7UwS4v48tO35tVXLSwQ37zvUHqTh9cmZ0eTtpbJBpxcB8pwJ/LqIbK+wPzY6KV0PBLz/ZLMWYWUTvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:40 +0900
Subject: [PATCH v5 07/13] gpu: nova-core: gsp: turn FWSEC execution into
 HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-7-ecad9346387f@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: e828458f-8f11-41f3-4a41-08dedbf87c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: k4UmFNSp/gWABqzfPRxvX3wON5dyIbTo8mafOMIl1NVSplQl4r16gUEAAUiR3S5R2taevnqHpvKT6jINrkOduezWFeEeoNzj58Rxel1rNEqd18iPWXf3dNJq+Hd2wBSCBJS7NzrAldThOQTwED4Ry42h7X631n+YJbKXSOavWX6cz0871ffdYYx36u/W4tdxPQ7+76jxhZD7hTXb++6QmYJwKtYa2/lid3OYm4Q/bdSerQIe9j/dXZxZQgj8stIOrzZfAZRLJTxnY6OBdOW6jnMAi/XuSSOUYFYFEnCqVAVYOG9hyYcl09e6TKe5OXzJBJiItQPZsD7BVZsV7UIqfOuQb6fpxf6yhJ25mwFe4EhfcmrCLfsoBxxT3v+zL3z7JymAcKNcsL9WgtMeVNanerRCMOhmcxnmkT1akwVOG4XUQRWHTcJ3OlsjTEHysVZTSu8V5ahgBSG44U78k8dXA32uK/Wis8mDcIN6bFoCboilu5cO8TvIhd8PQ4HqE1T7LTWdjezcwg9ZfQOaiAfTo8rmao7ZqEr1EquLaL/sufXJ1QBQdfoFPXy0Hzvp37m4+wu8JhsuiQ55ae9uaa3M4dtvw7cAPqrYu8C3t7T0RJhjI7QWge6kmpYkU8TfpmZXa2/omJIT4vdmohj7t7gi+TtW+mhRRgP0+EQDT1l5Ldv+jB1EBrda8DGYyD5IYHxtrO6KPsXolie+XesdPmWzUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1YwL2grdXp0S0IrQ29KL1p3OEd5MGYvVlZVMVEvSkMySnZZcTZJeEJVUkp1?=
 =?utf-8?B?RmhVZnRuNEJ6YldTcjI4NjhNVWVMcTZyQ3FKdEM1YXphVzRHeTlnVVU2b3pr?=
 =?utf-8?B?d1lwS3ZqY3BYZFRFNUQ5cWs0ODV1MnVlVEdjVHIzckdtYW5BNUVaRGgzYkJB?=
 =?utf-8?B?UCtrdHd3Vk1JZHl5eXNvelhoN0pvcVFDTmNyaThZL3RjK0lWcFZVTWRheE9v?=
 =?utf-8?B?T0prdFVodnpWNTIxMVJYYkw4NGtmSThEWEFYdWNaNEoxbHNQbkVWL3pFNnA2?=
 =?utf-8?B?eDBtZHM1YzhLdTJBdTEvYVVhaVRFSWxvc2p3WEdlSWt5K1dDcVU5R0NQWXVv?=
 =?utf-8?B?N1FPSkhOOVFCTmxMM2I5eGM5a09WemJXUjJRYUVSd3JvVVhYMk9nWWlBZFor?=
 =?utf-8?B?QW94TzFqQ0QxVEFiU3lzSXREREtNeXB4VVRhMmV2cnk4bGZxWTdENkZvZ0Ux?=
 =?utf-8?B?MURoVXQzV3l6N3Z5RkpsS1pJRS9kOFBGU2Q3QjAzOTc0eVVKZjAxTGlhUkNI?=
 =?utf-8?B?dWJCRDFnVmJROGJtbEgzdjU5eHVxSWxEQTJhakNaS3RzS3lndmJtZHdKNU5P?=
 =?utf-8?B?NXp6TnRqZ3RiVGtJZVlZRjNPRjNOQi9RMlZnME1ENkxyZzVPS0ltb2tMUk04?=
 =?utf-8?B?SWwxNmxCcThYZ2lwamhQVForRzF2Vk9iY0Y1bURtYkk0Kzh1M0hjb3JVU0Er?=
 =?utf-8?B?dGkzUTAyZFFXWlc1RDMyQlRlUFdWQkdjNTZDVVRJa1BCdXlIcHVmNnhwWm1x?=
 =?utf-8?B?ck9EaEc2OHZhME1KcSs1SCs4eWNqUTdHeDdjTnNGOFlJMWlDakJDTGErTGpk?=
 =?utf-8?B?aDJLWVAwT1NOcXN3VDFNZ1JPTk5Rd3JLeSt4KzdiVUxRM3pSekZaUWFsM2xt?=
 =?utf-8?B?Tm0yOUZteUFSczk2NXp1VC81a3FFaHA2SUZqdDJjVjJjQnRMQWVSaUJTSXB3?=
 =?utf-8?B?T0dTN0RPRFpPNnVOL1c0WDZHdHVFakpoN0ZZSkhFNkgzc1hXMVh3TjMyS2xh?=
 =?utf-8?B?UGg3WTFycytwcForcVg3cFhKamppVzZnNFB4dFcxQVE5aDZUTHluZDFWUEFS?=
 =?utf-8?B?WE9wR3JwZUFhYWJoUWhqb3NHd1A2TE1aNSt1V0IrVDBWVnQxR0VtNGFDT0JT?=
 =?utf-8?B?R3B1L2RraHUvK21OWHl5OWErbWxKQzFPTHhlemZxVkZWNWVTNkt1WHY0ZDd0?=
 =?utf-8?B?YzdIRmJxRHUzWU90dVJOUW5ZTkpGVjdSMTRicWhhODcyakREb3FtcG1VeWtz?=
 =?utf-8?B?eEsxdHh3YkFBclRQazl6V0VVTGZMMzhVNFlKT1NDaTdZWHY1TmdkM0JsTkpO?=
 =?utf-8?B?REd4ZysyM2cwRmRUQkpoZmJONHI1elRzK0R4VVBScWxuRE5rYUZTbW1ISGQ4?=
 =?utf-8?B?T1lkemJIbktNUW91TUZhaTUvcGE0dUFDKzEvNmZ6cUsrLzRZajFTR29SRHlk?=
 =?utf-8?B?NnNvMG9UeFJxdGhjUGMrcTV5WUFHRnlJVEZESWxEaGNjbTdodGpsdHZ1cWJX?=
 =?utf-8?B?cU4zWmFoUDl6ZDlzV3lrZlhXYnRxbjBndVVVSVpMZ1FEdnpWQS9sS3ZUczFS?=
 =?utf-8?B?YS9uSzFlQkJTaUJJZnJkRVpDcVZVNzZGU0pNZSt1eVUwTU1Ib2pFRGk4aWMv?=
 =?utf-8?B?WGdWMzR6azBIaXlkQ3pobDlRWlJTNUFmbkhBeG9ZdU03MHNTVGV5RHNJR0RE?=
 =?utf-8?B?OUFNUE5temV4NDN4YVQ1UnQwT0RYZXAyYVJSVG0wMDZGYVNDbGdjdmRjL3I2?=
 =?utf-8?B?M2hLY1F4WWtSUHJnaWxiTHEyVC9od1h2empwb2hBNUZPUGVTeW5lNnM4Q0hp?=
 =?utf-8?B?d2hTeHh3Sklwc29uT2Nnd3UxNkVmY1ErY1NaS1ZJTDUwT0lTcTNVZTUrQUVF?=
 =?utf-8?B?VUNaeHFZL0dGZXpMSEJuSSs0SzhSSitTU2ZvRlhHWjE1emRpTVNsY3JwU3M2?=
 =?utf-8?B?b1hNbFlsWUh4VmdXMFZJTTBFNGJpdEdrYXNESXlqR0VyYjhOa3YvbEp0RmxH?=
 =?utf-8?B?Lzc1L3ZxRytJazdBaTZEbjdwbW85N1U2eEJacHRKQjI0cUtiOEh0T3hUYWVx?=
 =?utf-8?B?bmNNbFh2TVhRak1xakpnamNsb1NYaXY3TklXdDFydVd3YU5CMSt5RUp4bDZC?=
 =?utf-8?B?VlNaNkVxV05YTjBjZXlLTE96YWhiWkxyR1RSNkF4TEk2VlFaYzFIenFLSGhy?=
 =?utf-8?B?SmxGblM4bWFMN1k2NVZNeFoydHgydUVyQ1ZJYmhYTGFvZ0M2bDZyQlJlOHhS?=
 =?utf-8?B?cTRWOXRwSm5aV0w3YmIwRytrM0V3RExZOFRqU2Zicmw5SGpJZ2dJTTlJOUVa?=
 =?utf-8?B?VHEweHFNZy9ndTJHKy92MDRqOWFNa3pab3J5dXRFT3MxNzkwNXdpL2hWUFU3?=
 =?utf-8?Q?dYuHL0rDd/5QqK98X9iLJyl0T74C6D5DWyXUAuYojBgVM?=
X-MS-Exchange-AntiSpam-MessageData-1: lEH+CNdGSCF6Rw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e828458f-8f11-41f3-4a41-08dedbf87c43
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:21.7574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nce3UPL2RHffobdgvZxZ4UucNH6hYPw+u+HjUH9mWsuustCXOcfTHCaiTWvBElV+SAQp9vsVIj9SsSA2ia6poA==
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

Turn the `run_fwsec_frts` function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 173 +++++++++++++++++----------------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index c8c7a4f45809..066f97c9908a 100644
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
@@ -284,7 +285,7 @@ fn boot(
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
         }
 
         gsp_falcon.reset()?;

-- 
2.55.0

