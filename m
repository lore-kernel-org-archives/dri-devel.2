Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836A4FF8865
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9CA10E27D;
	Mon, 27 Apr 2026 06:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U4a70+sz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D50F10E27D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwQzTNRLwQFtt1bviZGQf8NsLuDCTEJRq9/2KOvrOQiJMbZFRGwlnbgI9D3knRTqxHIgvPpUCX5kADF+7GOnc7yVP0f0bS6/fXRIsGeCKPe+KVPuLgK2Cb1PoDkouHe171aXZlPS6CHQV5J0CvhQMbfMf6A52oWrox6dP28qe1X3g5lcyrqZ0LyHvCkOzJ3OAhUZ4klU3BhQp+QOISTb6zwfRQp8bVhaIHywDdcUqKynG22YXTywfcLjUB+WlQqOyDVB5PMt4BjLHLDBgRSmyyV0Adf1XH5n7s7jEPBH5FbqAghPQl/opfzkl5OMBl3xgHvspEsqVb1BTgh192na3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhs6lWyJYcR41l7SZBeEXszvKt9zJlgEaK+sO2mD6v0=;
 b=PoIiLiIx2oUwtjnRkoCjWRhjp2oJO2tWH4C3VzpFka2CXG0NWJ8MqN058Zg3aYXRXZgbuzTbWq4fGv9JH+6yCMnvQS+866mhYLrY49XyinWIEdXgnufddGS+v4aqiYSlVEZxbbuvKXyyMm+aC2/S5+fmMyyERFT9Psesx9e+fYiLiomBIZniNpe+gOJ9l/lHiqJPaek4EcNxGs4k+OBUPixIfdcHPtFYKmkF7AlUj5eJaeqM9Z/SrbgsG88CGU84RrZz/388LCG+kEKQm2Era97tO6Co1D8by4QdDf+iOCVBnzZk9b/2bPf87ZuaDfLgVxY5bW7rRUYTgZKAD8sU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhs6lWyJYcR41l7SZBeEXszvKt9zJlgEaK+sO2mD6v0=;
 b=U4a70+sznOwo/rOdvvVwF816YVy9vnqZp2RxQCCXMxDY4PeK0S0Rf208dvJUEje6rSVbztN4QyDYKK989lMr3fzoxS2qMLy87/Dyt53p/yJ11SflpklKjv+L1O/6yKblwglqOoe2fglbskujgCzEpShujK8LW1TarjWY36oA5ooV3VYzlK2Zpri3He5rxBpnfZXm/P/+GH/y4Ay8K5z5xkf2xexBGzVq+2WX1RymEYexd0Xd8R6he4dHDqRxBSAbxZws1cV1Fn3u0V4sJBuXUhiXWN3w6vlhKo64ODsD5gntHjHYfvIOoYatKJ3vi18wc55460qrf+ob/vxO0QBz8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:08 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:56:58 +0900
Subject: [PATCH v4 1/8] gpu: nova-core: remove unneeded get_gsp_info proxy
 function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-1-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:405:379::8) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: e30f5c5c-b735-4c20-d340-08dea42a32c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N81FvmCAfTLxkrV3p+Aiz8bRhlV6hQMEICTnEzvys+wPbpK6V+IC6qszIEAXXENrw91HgU/HQgbsvhfdzH6e0CtJe3oECeBugUZ12j3odAA3o9mT39XhJ+jWBG05tzmPDLDp9/Vt0UNLoCEtUHRDoVZ7lXjE8xn19akUK7vO8xVMKiqxLQETjlZbbLOcKv4BeUw2/7CtdwPjT2UvmrfVua6zrXtu5geNO/ZoLR8Uf0UPN/Y1STH+m9y2qCcDStsKtnfM+atLiE9ZFi5osp9KbLiDqRfUg5rcLdjj412zGtwwJ683xS4juuGxDnqB4edWwOpM0aD3/qGtYJrxminNIcOHXvrEaj0Zk/eYE5Hfa02o5M94Nya8P9vNOITFEtV3hWJfcJVDHeRlbMHXHzM9IP2q5WwU6WUUJVI4BuVfXaiFqjYx+wENyXdl0DfgUYXrQE6J8P78DD242LAK6ZfI/ZYBH74itk8YXVgk0SUZMZONOlRIyme838ivoX62Ldgx7SeqgwDM3K5NQDYrz73m1oG5/fmlmAVUScm0UL0bUJlldJW6+qtvm2aLgfaNBKkQeWLAs1R2ABPSE5H8UblBNAUQLD/U+K8mWMSpiFiVXXTDY+8dM3Tun3RmFaBfXTdxMNmmI/hXO3GSRQvnBVUUjilD13S3vjU3lkbVxXr4Ycpv+RQpAbeUIzpW9udgjb8b6Q6VNrJRHdLoxjhxwbWkWk5sKvhyrh88f5XbN8KbSDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bklZRFN5bUhVNVFhR1JGZ1hnVFk4UmxOUFE0VGgvUDNXNTdITFIvQ0NQVytK?=
 =?utf-8?B?SnYrQlJlS3lMeVo4cVd0TGdPelZQRHd2S3JTNlNBbWxXd1lpQlU2cG9WQkxB?=
 =?utf-8?B?YWwzeCtSMGF5TEUwaXM5dkI5ZXFOY3Z6M1ppWmpUNlJBTm1tY3laUmZ2MmRO?=
 =?utf-8?B?bHhiSGZMdU9oTmNLU0YxVjFHazFwR2hDakNrdkVDa2JmQmRVV2ZEL3hMSW5i?=
 =?utf-8?B?V25GNzE5UlFaZUV2UENBSG94d3lwR1hkVGFlTWptTmJob0RCL0xHeGJoTzhG?=
 =?utf-8?B?Sjlycnp6bVdPZ21qMnFGVnprdU9kTkp0YjIzcFFjUnN3QnpOSFhPMnpINm8v?=
 =?utf-8?B?a2twU1dOUVhiTitUZHFNcXZlS3BLOFc3SVl2a3lvTkxpbkdRVkZjcElmdkNq?=
 =?utf-8?B?TXp1V3F4Y04wcmJXMDZBQ1VWd3ZvZU1OekswUkFyRVRKbk9pZmZmclVPU1hs?=
 =?utf-8?B?QVNiNW8wQ2RtSmRCZ1UwV29aT2Q2NUk4U0kzemtKMGdvUHdaTFozeldPSU0w?=
 =?utf-8?B?ak8vdVdXbHZCZjVLUk4xTlA2QU5MaElRQm0rZS95TE5SeFFwRHE3U24zalFn?=
 =?utf-8?B?N2g5YmxpTFZFZGgvL1RTSEZxUmhLTStvNUl4UGpNTzViMmFlcEN2eFBvSDVI?=
 =?utf-8?B?ZDB2M3RFOElFMGtaWnhCUUIzcjB1Zy9Sb0xTeGxwRHNQeHRiSkU1b2x0Y040?=
 =?utf-8?B?Smovak1WMW1MREVaQkJZNXVBZWNXUDhSS3RtMm4xNjJqL21YeWZ0Qm9ESURB?=
 =?utf-8?B?RVoyd3FqVzBxUzhCYk5HZUI4SkZFZ0hHRkZMNTBDYlhZcHVZV1FXb2ZtUmtL?=
 =?utf-8?B?UVdkVkZxNFdMeHhoTENlR0M3V0RnTmlLRWFSY3NmQlcrejhMU2h1SUIxbnM3?=
 =?utf-8?B?eXFnaklpaDdRY1VLOEZBMlBUeU00RUlTRDVvbWRxQmovWHp4amUxUGFUNnFO?=
 =?utf-8?B?SS96OTV5Qm5Vc0Vpdjk5by92S0lyOVIwTWlEK283SFI3Wi9nZXRlc3pBRnNx?=
 =?utf-8?B?VHh4YVVxNXpiNnRWd2pkNHJjZlhjNEpRbVNVeDJjVlN4dHBhRCtySTJqMTl6?=
 =?utf-8?B?VERCOUxPWDQwZFBadkFqSU0yVHhHS1lTZE9GSCszeUhENXM0Ky8rSDNhbGd0?=
 =?utf-8?B?aXA3S0hGbXdqY2xGSDRRd1NESE1rdUk5ZFRCSXlITmRZRU0zRnFZSGF0ZzJF?=
 =?utf-8?B?NU1kZ1M0UWllNVl2dTFTb2ZNbFdwb2VtR0tCNGZ1SzR4RDBWTkNUTGRJQjZ4?=
 =?utf-8?B?V0FlNytvNlVGV1Y2RFRPSGFsSTB5U3lWbkhSbUpSeU00UllXYk1mRDFZSmdT?=
 =?utf-8?B?bEZvVkgwRGNpZ1p1aE1welRGUUlYcDhuYVpSZnVkT1dZckgvc3VHR1ZLRGk0?=
 =?utf-8?B?S3I3MVN3cC8yS2ptZDVlUXdyRVBrcllUaXoxME0yUFMrWkNJWDNFZEQ3WFd6?=
 =?utf-8?B?c1d5TTVRSjJLT3UzQUVSbXhsZzlKeDVxbXcvZDI0OEFpbEhtS2pnRVg0SFVM?=
 =?utf-8?B?QW5pcm5aSFAyNjVyMVVSbERBcGdNdlhmKzhWSDVEUTdUcFlrVFNURTc1eDVL?=
 =?utf-8?B?L0ZkLzBFT3p4dHUrZHVDYmROUDJjWGFPUmFtODVES2Y3Y3A0ODJGU1NsS240?=
 =?utf-8?B?NmpQa3dMTHRxTkZUZTgxckwwT2VWNzZySCtVZXF5TE4rYjFlcUJQUHVQOU1u?=
 =?utf-8?B?ODVoY3h6VkpzSzhTenROckJoNWRTVmlnenV1aTA4amZQc0loRlBSR1NlM08z?=
 =?utf-8?B?SFo5YVNaNlRadTNWYjVTNFNRb1Rsby9aQ25QdUhCUk05M3FWdkIxbG5EQno4?=
 =?utf-8?B?N2JFMlJ2cU9UMVV4bmk0Q0dxa1BSWkd0MWtwTDhkMGJqZWUwNW5HZFViUW1p?=
 =?utf-8?B?SStGV3U0WDFNNUZ5Z3IxY3NwMWJHUzFoUFdzaWsxREJQZHB1QUFuZWRjaTRX?=
 =?utf-8?B?ZXpTVEM5aVpUeGhLS1NzekdrUnA1cDhvV0tZanVnSUhjSmk5Y29WdSswaHEz?=
 =?utf-8?B?cS9iQ1FZTm1MM2lIbWFFS3FWYVZJZXlKTUdnMy96SVlMbkVsM3dVSWIzTFdG?=
 =?utf-8?B?ZFA5QXhaWEYvbWlSU1RKMFdFZERhNWRYRlJTUHlXbjZHMS9PWkNmOTgwSkpr?=
 =?utf-8?B?bkxieWJteExobTdNeEp4TFlXdkF5aGhEUHM3WkNVQWVmRS9NL0RqeEVWTlph?=
 =?utf-8?B?dDQ3a2dQc3VwK3RDTU1BdTBRUFphT1VWYTVFeWo4SXgyTFd1OEFEd2x1S0hN?=
 =?utf-8?B?Mko4N1paVWJ0TnhHSGJwbkdvRkEycnlTOTR0MmtqbHBRaHhhR0VqVGpUaDBE?=
 =?utf-8?B?UHpsZnFKRlFIdnBLbWhPWXNoR3JhZHpNdWpPMC9QdG5CZjF5cDhySEVoUGFD?=
 =?utf-8?Q?NhunCm+4chlV7zKmRHlzLItlYO4U93TJDJNhrTsVHwhN3?=
X-MS-Exchange-AntiSpam-MessageData-1: 4ZmlbXtnQnKi0w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30f5c5c-b735-4c20-d340-08dea42a32c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:08.8505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUsimAxSIQj5mt+4w7k63gDuRkOPsJLmyyuLfBi4Ako6vXtrtiM3Nof0F2PunhE7P5nVFgFM2Ex2oq/x/PDS0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

This function was useful before the generic command-queue send methods
got merged, but it is just boilerplate now. Replace it with the correct
sequence to queue the `GetGspStaticInfo` command directly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs     | 2 +-
 drivers/gpu/nova-core/gsp/commands.rs | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index df105ef4b371..e838d61bef50 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -243,7 +243,7 @@ pub(crate) fn boot(
         commands::wait_gsp_init_done(&self.cmdq)?;
 
         // Obtain and display basic GPU information.
-        let info = commands::get_gsp_info(&self.cmdq, bar)?;
+        let info = self.cmdq.send_command(bar, commands::GetGspStaticInfo)?;
         match info.gpu_name() {
             Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..e81a865050e0 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -18,7 +18,6 @@
 };
 
 use crate::{
-    driver::Bar0,
     gsp::{
         cmdq::{
             Cmdq,
@@ -176,7 +175,7 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
 }
 
 /// The `GetGspStaticInfo` command.
-struct GetGspStaticInfo;
+pub(crate) struct GetGspStaticInfo;
 
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
@@ -232,8 +231,3 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
-
-/// Send the [`GetGspInfo`] command and awaits for its reply.
-pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
-    cmdq.send_command(bar, GetGspStaticInfo)
-}

-- 
2.54.0

