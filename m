Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1366EF327B0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DD510EBBC;
	Tue, 21 Apr 2026 08:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b6RVxN9L";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C262510EBAF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfMLgpQKxc1gqVJ2oaAX7DdzQ1QlokWjHjVkxPVSxGX+FXoxDQ9R3xAo3XRIUScROm9DFl5rBDd33KZ2UTwEwHbp/AMzmnlE4RIvIyUMD5pzeBqjwbqhfezfuFkyM/oFjYAEyOkWKo+U3YnOk2rIMXXZ6KbZSuLse1Rz/0SvbDWlhGKBnMRtW3uOzEcPu96H13jhdQ5RotWXEKdB520yJIpaQunU8Lkp3ZjFhhzPSj8vbfZ3tHBj/G3nRn75XGRbvkcAoUjOx06U/j4Q6t2QN0nXFzDTugmFJu/rq2wQnsbDeb1ORhnLPZh/yz1YX1sCvQr3euX8zwf//RkYWrZetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJGKn7REC86E5tUsR+tg/ZANOgEainiZXI/avTLWx4A=;
 b=PryyFGDoaXvije6GWUqWTzKxcMD9Ur6NhL9oWvOs/v5+BN37UZzLk4XJvaWxrYeomhMRS3eVu00vi3FBWi5nVPFyhL/NglFWCPgpRvo8TesRvQIfZ7OBLVwx3jiABq4Hff+awDCVnR2slB4AGVHveRt2Ee1g60H7y14vWslB+Jkry0UAKpC5DdOrQAqwZzEM8kiKCZ6OtixnQxpfCkPySUNpSmVr2k6g3663Kc3mH5WcO3RPMEB3Nz9tLi1LJN00U1/lcqvbRKyElSNYibOxSZDeidF3BQ/lqfUmJU2a1rqQDGT2XxX0YPN79bJPSZO1risrlVFTbMudUsFbRKVaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJGKn7REC86E5tUsR+tg/ZANOgEainiZXI/avTLWx4A=;
 b=b6RVxN9LdHdAFOS6kOSIzZ3b0qzvYCSqTV6oD54/nGcLu5cnpFnDoyoJQVv2RkFUlQIJNyFmPbudec6eS55DTXBwVml8TSYnGDQpLDPGE34HgP6J5WNNsZJCfjwqCiJubKwobhK+5ZIgda2O0AbBKHtcHE96w9p54Rz9k6HpeHWXymljilb0z3Zyp2NFPeGlEw/aT5RbOZxoEdWMUproFivvbbnc9GZqeKKHY4h+Hjr5+bmROzI5huIolhByRQocA1oXK3bSbru1Ycb/u+KKsmkEz1FM5yBobK++03GH/D5ciRDSoBz68Lu/82Pd5u7x6zMdndYM1VOes05llpr1kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:05 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:05 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:25 +0900
Subject: [PATCH v3 06/11] gpu: nova-core: vbios: drop unused
 falcon_data_offset from FwSecBiosBuilder
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-6-8f648aef7a85@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:405:4::27) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 79af21ea-7b14-43ba-9e00-08de9f7eeeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jIaVsvRbD58RkO11u+lvd+3Ma7/xOT7W37VsF/e+ewCwyJ8VmhaKldujJFMRvgtVrrdXgUqcgnxpoAM02QIzA1FSdT3UiAjtFlZwGacguciV4xE2hVX31VEWko+kl4M7h6nBcVLN7mkdAC5cd609R0wyMpKjRtagigzLT0xUlyXnEVgK+Z8urm2G7Fk60UZJUUXcijNa30fzF3ox4S+FENDJZ27GnkaODCXZ0mCCjjsn/TmdEiLYplJdfUXZQ92r7UmjsHQLaidXAsrxkPOu1ENy3RhPYRD+dVvJevzfXFYJxE7gLNCphRJSu2aBOKqv6ZH1B2pSS/ymqX6+qmVbdOy8YGmyih65ix1a2bgBXoJsJO5kzdempFjifeMGuWaXSPX45uxONX/bArDVZkVHLss336sjwhxoVNFXrZ6fSoHe/8f5unSm5tVkO5KasYL8tDarzd6x5TKXJfQ51M1z6am+TialYdq6jwdKtsiSF4XJD9FxVmb1w/dRzUHsnyDQ1Mo5VoPiZogwki1Of2/X39nb2XENa9BYoYnbMEJhRg79P3KAsUW0YFtfoFX3k+bwNJjZ2pSXSgWv8YM4HVFrQIlXMK3K/3MRuM/zkoGmPncsAzb8/g6Oe3e4uhJu9RQ18y3xDlxSOvb0dEJU0vhoGOTxrzVqN+8GsR7ACS3tUDwkjEKZPi3joGTjxkRRikXln7LFSEp8l0hSJITMcB8Fv4pSl4PQ6NERCyUHx2CzFg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0IwdEV5Z2pQN2M5R0J0MDhYUVh5VGdvM3IrUVgwWnVjVkVZQlVqUlRlVE5Z?=
 =?utf-8?B?T3VFeGpucko2UjVNVnBhejFicEFJL1FTZklKTEUvcTFYWm5JYUV1amYrNzNr?=
 =?utf-8?B?bjJwMmFBVkVFaU9ZeU56NkJPaVl5Unhwb0JNVlZtV3ZNNkpTSEpBQ296TEtv?=
 =?utf-8?B?SXVtM1d5cVQyOURiNEV5bDkrN2YyaGNBVlR4MU5oek52RWthRGNRSGdnZ2NC?=
 =?utf-8?B?bUQ1OHpYYUd2UWkwRmNQWU5FdlJNQkViRUhBdGVWZU5qUU5VTy8xY3VYZnAz?=
 =?utf-8?B?Q1RKUEI1ekFHYkpJS3FCNWkxRFBOTURFenNLdEpiRkIrMnFoZFU2QzRNUmNu?=
 =?utf-8?B?cXJFQWRTYmIwY3RBaHQxbkJiaDN5S1l5RzJUTW1oUittZGltYWtHak1BY1JN?=
 =?utf-8?B?ei9NbVMvQlpzcmJxM3VhWVNnTlFBd2N5a1A4a0xHWEZhZHJvaC9ENVRURWho?=
 =?utf-8?B?UndHMnFjRG9BcDR1bGN6U3h4REkrZkIwVG0vOHhJV0ZYQldTV29GY0FwbXZr?=
 =?utf-8?B?VnJIRFh3WkMxazNST3Z6dFVFUGxBRzFTMmptL1luamZzaU1RYXEybEUzdU1k?=
 =?utf-8?B?ajRrWk53elA0cFpOSFNBanBlemhDRTB2WE9hQjIyWE9ucnU2cXFkTERxdGNj?=
 =?utf-8?B?Q09VN2JzaU9Pb3ZVVG5CVURRVXpHeldWYTR2UGFqdXZld0pocU5LUmk0OTh3?=
 =?utf-8?B?bkNnR3RRcXVqekZrWjZka0ZtNkhnWjZJUnZCbUJVbTUwRmtVcE5IdGNjV2xN?=
 =?utf-8?B?S2hwRU83MG55aTgxekpJNFBhdWpxc21Jb0RnamJsS0hBQjY3VnBzT29IbDNV?=
 =?utf-8?B?aXRTSXBrdXlrZUhrbk5YRlhLTGRhREE0OFFOVWxDU2VQV1h6d08za3BBODJu?=
 =?utf-8?B?ZUZiZGlFUGg2dEVKaFh0Zk5qVk5wWXBYelVzRVM2VGNjRTlRSVJZaXVidlVL?=
 =?utf-8?B?QytpZEhCNnRSY2FUWnRLbmlwUlhZZ0dMaUI2bFJ6eE1GTGQ0aTVjTURXTlg3?=
 =?utf-8?B?UnVrMjNaMWNGV2pBb1BzUkRLNmhwOUUzRzRWM2h5VDFmZ0w2d2Q2TVlRMi9N?=
 =?utf-8?B?NXNYZUZjRXQ1ek9LTmFhMWdJNHZCS3V1b1oyS2VHQng0SzFidFoxdE9PZ0xS?=
 =?utf-8?B?YTRUakw1VEZNaHVRa3cwYjI5ZGlCdUhRMm1QL0RhcXBlWkRrbHR1cVFrSEU1?=
 =?utf-8?B?dkwrLzd2YzBXY2lsUUp4aGVybjF2dmhXRkFxbSs2VTh2K2d1SmZOL2JnbnFK?=
 =?utf-8?B?QW1XSEo1NGRLemNUVEk3NjhMcnFnNDByWUtVTlErblhCempkNmozNXpEVWdv?=
 =?utf-8?B?WHlvSmZITFY1VTNKTjArejczSFhNU2pGVjE5bGxDaUpRTHNVTHZONGRaZ1BG?=
 =?utf-8?B?N0ZOcm9PRTZwbU84bENRSkdwZm5wYi9mRHJrSkV2WFVaV2x2TGtmU2FnNzVB?=
 =?utf-8?B?WUtreDRXamJabTZmTm1XcG12T3dEeis3TmJCa2NlVHJYOWVVVGlYRWZSMjBU?=
 =?utf-8?B?WjlGNGpmdjVnVHNiZ2NlL2lnUjlwZGk0R1NGK1F3dVlNcDBtZ2pKK2l5VTA0?=
 =?utf-8?B?Y1NVV1JXOVM3SmF5dkVVNitYeGhuQUhkei9TY0Q0ZjRSM2NmcHhRVE5waW81?=
 =?utf-8?B?WHFKTndBa2Z6Qk11Q1FCTWJQcGcwTmRHSlVJQzdlZGhuUUtEQWM2d3VrOGE0?=
 =?utf-8?B?c3VLZmFPNEl2ZXByMWFPR1RIckx5UVRHeHR0T1MzK3lsYWgvRlFSS1NtMDRP?=
 =?utf-8?B?QXVEa2lzMWhvczQrL1k4ZUQvdmwvc09kVEdMWHJKZ1VHK2w2NDA0a1Z1RkE5?=
 =?utf-8?B?RjFKUVlYR0VSdktDZ2NRZXVtbkpkVmpWdTJvNXBnb2JxOFBhTkhlNENPR3p1?=
 =?utf-8?B?TTh6L0xTcVFSRTM1Um9mTWRQSFpTMU1MbW11ZXJpWUwvWHpnbHg1UGd1WDNZ?=
 =?utf-8?B?eTlUQlU3VWVBQzBNa1pOZGNLOUxuQU9ydnVBYW9MSmVpaTRHZGZoNFpjOEgw?=
 =?utf-8?B?ZXZ0YXVFd29EdXZtOGsvRE1veXBreDJEVW54K3paazBIYlNUK1dzVGxVMkVJ?=
 =?utf-8?B?M1ZxcER3dEpqOGVWUUkzRjlaV2xxMjZFSkdSQ1UrY3kzVFVhalZZUklnSGF1?=
 =?utf-8?B?elhZVTZwV3NVU2dsMmI0S1czRjl6N1lmQWxjOHNucFJVVFJGZnkyNVFNeWpY?=
 =?utf-8?B?N0J3N0ZmVzlZcFNwWUVwbzRudzhBQXdWZjhPR3pnTytlUzViUnBCMXRVU3ha?=
 =?utf-8?B?OUZSWVNCV1hyVm5LQXFiWjFKS0xnSUFvdU5TNHNLTndjU0g3eUVYQ0ZHME9E?=
 =?utf-8?B?bWpQTTduZ3R6WlJweUltcHNXTzZIdlpkQTkvOXNmdGg1Y1Z0SWxXdS9RRTRI?=
 =?utf-8?Q?w0+DaWA5hw+2wPMVoPZzX6GY/aZh9CaPwM27QZjsKIoC/?=
X-MS-Exchange-AntiSpam-MessageData-1: aJzMJfXT4A0t2Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79af21ea-7b14-43ba-9e00-08de9f7eeeb2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:05.3797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnjBsKuLowrY+/cAYx/FYlyuaQqsKEse4eIAY50vfEXbPEFinW8NlLC/8OA+4dAJKXrM2hWLwXLQbhUiJh66lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

This is unused, so we can remove it.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index d8633e61178b..d63af95eb642 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -256,7 +256,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        falcon_data_offset: None,
                         pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
@@ -631,8 +630,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The offset of the Falcon data from the start of Fwsec image.
-    falcon_data_offset: Option<usize>,
     /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
     pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
@@ -934,8 +931,6 @@ fn setup_falcon_data(
             offset -= first_fwsec.base.data.len();
         }
 
-        self.falcon_data_offset = Some(offset);
-
         if pmu_in_first_fwsec {
             self.pmu_lookup_table = Some(PmuLookupTable::new(
                 &self.base.dev,

-- 
2.53.0

