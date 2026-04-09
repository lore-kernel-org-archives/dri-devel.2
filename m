Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B8FF31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A2910E808;
	Thu,  9 Apr 2026 14:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DXR9sStt";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E247710E808
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH+rOGEa+IrsM5fxv0IRmINHU3SQdOlg/YvGZ3orxxD7Wmrza/zSJ/k0A7Q/AWM8ECa6No/+TBfmXyMXWmW6xzCPzWSqv+0UC44FrqSR/D5fgpudg1bAtA1DGlU/roApRkp2ijRpGCDYySZhpFoJ8gKRqpFRGriqGve6aFaa7wg+StoHMPURW5/miaw67gD6Vugqj07yPhDnjJZVPEaY3vm43t+mJ43yY/4Bq9IcNcAx252f6tqnQWzdCrMR6UvxwtGfHdS3RcW+3YsdfVp2K5NEmZjH5IIUKUmT4mHxTT2BzUGbOQLVVWatUhQHx1QU1c33Rg6vT43D/QFnCy1ZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYwlIR7BAxAF+/npW0KI1yrkEa+aBp5gFsKNFINgdTQ=;
 b=qhFFjEXaG9NUhXkAwogdstlx2JzeAqb7xGRqc38mp4RGF1xe1hMtd5RKO9Vyb9JgOpjB8QaCS8koq0b9hJIOms4rOMtMftpJY2rUBji/nELjm+KujqozrqGqlVaXQGYuxf6GCFMsaleHPsUFK7VPp5CaYPpZbKfpECs0/FiQwi+zNO80xmIaLyEjUSfe0cNHXcpO68w9BaK/yg95rt0UG2dXZQOKujLDNWdAftXelcWU7rw/r8mN2pouWSBjZ9IYhdxKErftSCx0mwODIWSX0tXPu/pvVMIJC2kl1N14U9Tzmu0Cvzw3p2krjXyKmV0dJZjxa2wA1qsKQc7VARiKeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYwlIR7BAxAF+/npW0KI1yrkEa+aBp5gFsKNFINgdTQ=;
 b=DXR9sSttSWsX3GmOenO90f1ucXQuuDGqqsMnQokDWeb2R4uDW/U3SvOBQ/AHj6zgYXRGCuQH4U1CYWKNb2GtiWv+4KKwN1ARlJwL6Ggx0PLx7ZHhEmWN88qmimWPYJ/gqFnAJORvVz6RlE/ZpiH/MHPAGVfJ/0kA280+tLnG6xy7pWsE8zON231YZkujWOolZ3oAmFJLXQ/kzM2+BJNhcjI3QXfZksXTtN+JDHzj+/XjSVDhQ/Bi4H7F9ApuLq0/3i6pz376AVYrbsEJF5SDxe6TWLllycvX5YS2RRXe2kxb6QgPj4/73ywPMFqNphuOCPHiQnqYIUIPjfRqR2qDAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 14:20:10 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:20:10 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 09 Apr 2026 23:19:41 +0900
Subject: [PATCH 3/3] gpu: nova-core: add non-sec2 unload path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-blackwell-unload-v1-3-0f5a2ff838dd@nvidia.com>
References: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
In-Reply-To: <20260409-b4-blackwell-unload-v1-0-0f5a2ff838dd@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0308.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb3e063-83ac-49ec-e591-08de96431b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: AMD+s9RP0wxxkYIHCen5iznhrnPmMkehIrzcChrMzIDDapV9STdpsKfAl8xk6uGsn5UBsVhYLH3ue4tD0gxuVQdqE7tmge0fh9mPbj1kjW+5PBKtShiAD2xQwkppDpnqc21cEp4Py2w0lOLMZ6rNnbBayHTNy1RrV7idUNjOY3cdONAz3qCzlA2LDhkDPHp0Bm+0YUp1y+5p9Bgy2P42n0sjp0yEGhDDcL0HfhhvfDWSPqkb4AVKW3D16TOEaakDm+K/64Aw9vbWu8MJE7Mk0BJOZrU/QNnIoPys7hJWM6XCe1lp5HmtkfR0Ui2fZAn6KmmLIGh6wPQD3a6Xb7oPS0UfATYZmyHktQlEwOBOJCBfmDChGxDikeJRyryJUs5cGqpDPE9s11sj8AGIOsoTDXafJpKSo9ExlDVvwZYzYQtVPhjqTWMLi5x+/tKUsMv6WCx/OzGAp52LRiXUWMXYB8+NC5MHxJp7KfuE9J0jKzsZbKnAX764HkmlzvsGf9Z9msDXiYRTFpoQwIag+TOwlRlPJqWT4AKUEgQ8amJORmMR3g/8DuFSLCadGifyRvp8Petb+G1rbHjlGOLliLRhCPUFI3jxBmAb6xHq2vordQTCCYswKC+3RGlW7EDmqM3R4Pe5q+ba0WXP1WqJUowEGMwqTevkE9Pz9gemhnNtdh/Q+NcyyA32w9Wzo3wLUsAl5EUg4va1m9fG3hrKTf3PTE0e7XNi8gCkoGRUEvO6uug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm8wSWxZL2JadlN4UEZrSnV0RWJTRmVmZ2xKRElkUEZURnh3YWVzRVZwQkp0?=
 =?utf-8?B?MGVmb0RuMDFMSC9WZGpJN0Z5ZS9wVEJzU2xyaFQxSHlxU1BhcXlNalZmK3hj?=
 =?utf-8?B?dUVOUDBBSk1QandLNU5GRGsrMG53c2dsYWZlQVA0MFlIdUd6c3ZaSUJBN2N5?=
 =?utf-8?B?ZHR0UWU1VjFJQmh4elhrS0Z2WW5QUk92Z3Y3ajRZaFp0cklncm5MNVVYRzYr?=
 =?utf-8?B?bFNQZGpnMHMzY3dRNUo0S0E3QzNXRUFKd3dadDNDKzNCNlZrK01PeFpyTmZG?=
 =?utf-8?B?cE8rbUR3RzNIWlcrNGVJMVRCYnVMNnRETlI5ZVF5MzFkd0grb1RGR0grOWZ6?=
 =?utf-8?B?N09rVFVEaFUwTS80U216RXk5OStWQWhQQkJhRnpsNWdWU1hQTFhiN2JSUmdn?=
 =?utf-8?B?b3NpY2NZeWNYM0NIM0lZMHFpU3NSczVsUEh2ejJYR0s2YVZlZTZPbmVJTGJy?=
 =?utf-8?B?U3paR0YvR1pUUkg1VCswODVaK2s0Mlk3SlNua1F5QUFpQUpsbUsxZGxDbXpn?=
 =?utf-8?B?N215ODk5VDkvM0NtYjg4WGR6K3FZaWdtUjlNVXJERUJCaDZHWjg3aFFQOUVW?=
 =?utf-8?B?MnpaU1k5N3paR00yVU9wVkZ2V0JISTJ4NjNWUlNDUlY0dk5WVG82Y2U1V29r?=
 =?utf-8?B?NjAyYi9wcnJkODJaSVQzR3c2akV5Znh3U01XR1FxZ2lnU25Cck1YUk5XRUxP?=
 =?utf-8?B?UHdKTUtia0NRU2pzbVdzMUsyS3R3MXBBZ3VNdzU2S1VpUm9MUGQ4SUxEcWhv?=
 =?utf-8?B?OUJyNWVuTUNSSDRHUWhJSHNibC9DbldrcUZ1YXpqckdweGJSam5rQVZUY2VZ?=
 =?utf-8?B?cG5RWFZXU1hMTWkvRWRQaGo5c3FYUUowMHRaWHEzbnNOOTNQWGoyaE5Dd21w?=
 =?utf-8?B?MTVpaExsR0RYbUtScWJneWw4Nk1WQWt3MnRSa05ic0NaVTRwMlQ4cmpBZENz?=
 =?utf-8?B?aWptUTllMDgxdys2TUptZFVjWUNsZlpRZzZ2V1prdWMzdnMxaHBJeXVUVzZs?=
 =?utf-8?B?TWcrWEY2Vis4Tm01bENNdklwa0w4OElGRDJ0aytnYXpNZHBMTTJpUVBocllZ?=
 =?utf-8?B?SVVVL3FtTlN6UnROTXc3SnRlNFRUblAwNWNwdEVHMUZQUVRNQ1E4bTZjMzNG?=
 =?utf-8?B?QWdmSHJCaEUrcnFDNzlFWFlXd3c3QWw0emMrSXNJS1JiSmdxc040cGRGRWFl?=
 =?utf-8?B?bGprN29FNGxybnd6SVlmcGVtWUFvS2Q3K3pHN3Z3SzV0clJOY2V5TzJWN3kz?=
 =?utf-8?B?TVJ5OFd6Vmw4aU9mRElGNDhRTXBuUndxQmEwSlI0VFhWNG9GQmtXYmJQT0ZM?=
 =?utf-8?B?aDQ0UzFUc0hyb2dVT05uVjBLOGcyejZkNnJSbmIvdStiUXhCQzFPcGJmVHBj?=
 =?utf-8?B?c2xEVGZVVWJzZFNSMVg4SFRLZy8zYnY4bnl1M3ppbXlYaVg2c0E1bDd3d05i?=
 =?utf-8?B?ZjYyOFhaZnJzeW1XSjRuM2dtVDN1MXAramNRRzc5NEhNUytkcGlwcjB3RmY3?=
 =?utf-8?B?cWxlWHlVczVzSm1mTWtFQ1IycW1uYkVFc1REMUVuNjJHNitFRzBtaG1pNExo?=
 =?utf-8?B?WUJWYTROaXZEU05NN2ZkTGFZSTJwdW1SelROZHpWei9oWGNRRDEzNDZLNG1s?=
 =?utf-8?B?emw2TDhRTU9MdW1UVGxsS1lxbDY4NG0ySDNiMyt5VDJkakUwc0xDSXlhOHVB?=
 =?utf-8?B?MFVsOUtSWmJpQ3JGLzRxbDhteDJpZWY1NUlKb1VTQmdBaFRCVlRCQUNNVEJm?=
 =?utf-8?B?b3FneGZtbktHeTltdjNFNkhpZkNGdyt6UGpSZ01ZM3ExbUQzL0QxbUxkclpS?=
 =?utf-8?B?d2t0MDZXT0VLc3RaeGJLRmJYaHZiMll4ZWNBRklYY01pQUFobmlZUmRGY1Rs?=
 =?utf-8?B?T05CZGFjSzZkeElOYWlvSDY3VHpNSHRCcW9RN2ZCT0U0eEVNU0tjUGJzQ2t4?=
 =?utf-8?B?SCtwYUk5aHhnelFHcWZIN1JsNEU5ckFvRDdHNHl3bmtldXRwcTg2RE14RmZj?=
 =?utf-8?B?SFk4enRMR3Rva0pjSlp1cWovSjBRUWtRWUI4dkdGSVA0eVFkTEh0T2VBOGJE?=
 =?utf-8?B?Y05Fc1dGSG9INDBnM00xOU5reE94YXhzbW9oWTJuMVNaWXVJODlZWHF2MmNR?=
 =?utf-8?B?Ynhqbjd3dlRjb0oxN28rNGN3WGhDRnAxTy8rZ2lYdUhaMFp3L0RIcU1Fckhp?=
 =?utf-8?B?U3IyVEdSZW41ejBldFI3VWdHODNUa2xnNXV4NUVhMVd0WXVqVXhuNGpRdmti?=
 =?utf-8?B?TTNkUHlSYW4ybkhteE41VjFEdXppYVJ1dEVOOExJamwwcTZ1VWdGcVJKVXQw?=
 =?utf-8?B?QWFFYjJKU0hETk1NdGV5R09pSTlJcUtzREFpejJWd2JvYXVvNmQzem9janVh?=
 =?utf-8?Q?hQpo2DDR7y4dRNJhueuQEb9AVDqN42t4N0OgmBnwakgSe?=
X-MS-Exchange-AntiSpam-MessageData-1: 58a76qh7tpN9HQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3e063-83ac-49ec-e591-08de96431b04
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:20:09.4566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voFzwbph7M4OmCJbaspTTX74hR20ghmWSYOQD63q8lCx5PYTR/2ZZVX+4fWx0Rf8ABQgWz9EDIPbixYW6Ralwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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

For non-sec2 it is only required to wait for GSP falcon to halt. This is
because GSP does the main work of unloading on GPUs not using sec2.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs | 63 +++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 1aac634c3b67..e536ad7222b2 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -453,37 +453,48 @@ pub(crate) fn unload(
             .inspect_err(|e| dev_err!(dev, "unload guest driver failed: {:?}", e))?;
         dev_dbg!(dev, "GSP shut down\n");
 
-        /* Run FWSEC-SB to reset the GSP falcon to its pre-libos state. */
+        if chipset.arch().uses_sec2() {
+            /* Run FWSEC-SB to reset the GSP falcon to its pre-libos state. */
 
-        let bios = Vbios::new(dev, bar)?;
-        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, &bios, FwsecCommand::Sb)?;
-        fwsec_sb.run(dev, gsp_falcon, bar)?;
-        dev_dbg!(dev, "FWSEC SB completed\n");
+            let bios = Vbios::new(dev, bar)?;
+            let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, &bios, FwsecCommand::Sb)?;
+            fwsec_sb.run(dev, gsp_falcon, bar)?;
+            dev_dbg!(dev, "FWSEC SB completed\n");
 
-        /* Remove WPR2 region if set. */
+            /* Remove WPR2 region if set. */
 
-        let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
-        dev_dbg!(dev, "WPR2 HI: {:?}\n", wpr2_hi);
-        if wpr2_hi.is_wpr2_set() {
-            let booter_unloader = BooterFirmware::new(
-                dev,
-                BooterKind::Unloader,
-                chipset,
-                FIRMWARE_VERSION,
-                sec2_falcon,
-                bar,
-            )?;
+            let wpr2_hi = bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI);
+            dev_dbg!(dev, "WPR2 HI: {:?}\n", wpr2_hi);
+            if wpr2_hi.is_wpr2_set() {
+                let booter_unloader = BooterFirmware::new(
+                    dev,
+                    BooterKind::Unloader,
+                    chipset,
+                    FIRMWARE_VERSION,
+                    sec2_falcon,
+                    bar,
+                )?;
 
-            dev_dbg!(dev, "Booter unloader created\n");
+                dev_dbg!(dev, "Booter unloader created\n");
 
-            sec2_falcon.reset(bar)?;
-            sec2_falcon.load(dev, bar, &booter_unloader)?;
-            let _ = sec2_falcon.boot(bar, Some(0xff), Some(0xff))?;
-            dev_dbg!(
-                dev,
-                "WPR2 HI: {:?}\n",
-                bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI)
-            );
+                sec2_falcon.reset(bar)?;
+                sec2_falcon.load(dev, bar, &booter_unloader)?;
+                let _ = sec2_falcon.boot(bar, Some(0xff), Some(0xff))?;
+                dev_dbg!(
+                    dev,
+                    "WPR2 HI: {:?}\n",
+                    bar.read(regs::NV_PFB_PRI_MMU_WPR2_ADDR_HI)
+                );
+            }
+        } else {
+            // GSP falcon does most of the work of resetting, so just wait for it to finish.
+            read_poll_timeout(
+                || Ok(gsp_falcon.is_riscv_active(bar)),
+                |&active| !active,
+                Delta::from_millis(10),
+                Delta::from_secs(5),
+            )
+            .inspect_err(|_| dev_err!(dev, "GSP falcon failed to halt\n"))?;
         }
 
         Ok(())

-- 
2.53.0

