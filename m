Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9844F327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4253010EBAF;
	Tue, 21 Apr 2026 08:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EhIFHnzI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E486410EBAF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXvJuZEuL2F20EjXTg8U6+UeWQQ2A8BwONc+1EhHXBtcM+NOQb/yEt0fS2VQFx3gmPKuatNAcBl5B+4wbvkehk4+kEj+TZ/bIzlzJUt9ACw5Qo5Dhp/249BOugvBR5VSNWRAJHgGdnfNr7ZMGsGOFymRSLBZniduzeOKqrfzD+IbRuVXHvXpUPI9M7OV0YlYTDvFlQT7xu427tung2LSiQQppB3O7SA2+LwtaIv4MtZk2ey/Csk/JzvkCSkutgrtsmZkmQAGH7epAz7yi0ZmxkGtOdTqayMSSFCOxxX7lfjQuKWKDzZ4IV0NAbwJyWNoAai29W1sWeHH1gV/j/zVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIJS803h+6en4LRXZrfW9ak4cFRq1j+W6VoWYu60Mew=;
 b=Ae8zOHgeEPhq7uhYyN1W9XfnYhuTyHl6lMT3uDRL4MUDf2F4QCegKmoj2rHnb3kk+GPq6KCLJXzXfchaR1y2L28YvEv6/UoHg5h19PzYgZpjZgiKoOWDb4+7qMTWujs5R1N0jYOnACNZLgDJ7DezOkfD/BsK4BQMCOVA3O+an3UfpXFYLn+J3R0dMWL0o5epRGY3QcVWhQ80R7p6Irn3CEfUZri4iPKm4FnivUL83fiqnXIN9ShJohNGNZ4z/KeaxmUny3ViHbcsUt5CUTbZRHQhCmGeG3NwHd4f/etRh08JnE4MfCmIh9y9YcWVedeigRvY3mex+6Q8/VtztunwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIJS803h+6en4LRXZrfW9ak4cFRq1j+W6VoWYu60Mew=;
 b=EhIFHnzI2ygBj1V4cBeLzk9P+6bd4p1/RIxbhSLQcTUKOf+n1TNAzXhS0q+suvW+DKKsTaTLW4AVLPNI1FULOuKrlV3KByqomOHyELmLeOUP/BQcQ6Ver/kEgzI4mOmbigz51VPSs6rXnwJF2KA7CLbbfJaYLlQTmiB16m8cmlVDA9x3J5zjj27OAnxeB/IQKugYiqGMNdR57s8+RWnh4Ur/KI8Y+JVxHSIwZ2r4n5u6nanuBJJsS5bACE/A/zsdwo9xMpvJ25E1svmnjO/3KThPzv61PhexvSW5SzxD/DNSYRip0M3mjRq3fc6mkTXQHjCCXCh3D7oWYfX/13RLFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:21:01 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:21:01 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:24 +0900
Subject: [PATCH v3 05/11] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-5-8f648aef7a85@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a182889-4007-4b00-c918-08de9f7eec39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: A05djAFJ9hbWdmmdIXOJkp/YaebUidanSA9h+DVhhy3LFYhk4/Cwa98KThEg9W+0IgjAJ8CoEyhCh+I87hpzDLJmq2NKyRTA92TEjfwTCiIwR9B6FLg0Qk5uo6xYfUwb2CbgCTr2DD7PCvhjdQOG0dCrxTbyswz+0ktJPUmZVOxGASIDno8xC015ShIy1gqE/Z6s5joSFOQgBZ4x6I58YXvVTedyyQzo8W0yxkeL7ovxJLD24m9yNwlDK3Usz6lOhKeqRSeqae1sq9NfCeRzGzZclmFoGG64ttHlzSu1d8YXqXyT7XvfjYyl6S/7jxfKTBsk0Yhvx3y3aFQSn8CIlKGfhDfm//VtJdDh+qnQJ0BwGWMOjMIcRrh9esUSepwTU0pVUBfwJTei2AOY+etb7cBWRZQurVgdjqZvpBNktckX5h9CtG5yHDefcfrGXJSKtZafXgBxyhxnEKI33GfKJeIT0O3Z/KoQxvTA2csuoe9fdwWZz1G+jLF+TV+LCBo2mj4OcEAq46LH8Pd64Ltz9oLH9oilw3s/NitXjHc5flsVZWFq9xOgzTNb2Bi1oaPWhPkX50WNf+zp++mmnMl9AF+mnq73ZRAreo6WNJ8XRSFpdBY4Di4NyD14Yce0TPbXlo6jgcG59qW8CURAIgIzsm7bgm5zDL+XycgSCR0/Dk1/yhCDuFPru2jA2XXFZmjJIBJnHImK2ArNsOGuZALlxw5VjWsDgvFvLUUwLFf2Vi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhOM3I3VFA2UmxBT0lMT05JcDlka052c3ErbnlzQ3VMM2RCUWRSbnY5ZWNT?=
 =?utf-8?B?OFhkd0dZSDVUMmY4cXJYdy9sK2VzQjFJUDlVUmxqeGdISGdxbGx3Vi9Zd3JL?=
 =?utf-8?B?THd4b1FjS1VWT2psMCtDRTE4VUFnRm91dWJ6c1lYcG81dTRuaDBrS2NGdnNM?=
 =?utf-8?B?Nm85elFsekNQSTdqSkVrUC91OERMeHdFSlNsaFprWDhuR1JkQXNFY1pORXZ3?=
 =?utf-8?B?alVvYnF1b3NST2M2Ny9BVERtdVkxNVN6V3M3T3FMeHE0YmtGdys2aHJEK2Fr?=
 =?utf-8?B?ZnRuOUdUSTVadG5NOFlzMWh3YnNXNTF1djRBQVRROGRxZlk1L2lyUWQyRldU?=
 =?utf-8?B?RzM1VE5lMXBUdzlvdzlKalptOHVyTUJlbW1FRUpaYnFoeWhhYjRqVjZocFhi?=
 =?utf-8?B?Y2RJODJCY01LNkpraGhtZlBDV1h3NjYwMU5OR3A3eXkzalo5eElYWHhBUVZ2?=
 =?utf-8?B?cmRLNUpMa3diVndWQWIxR29adGpHbDRoWW43OStzeUliZk9FNW8zWFNScStx?=
 =?utf-8?B?eno2enQ5KzM5Z1FtSytWSFl0M01BcHhBcG1jZEptekdGQVppZ2ZhVG9xUXlm?=
 =?utf-8?B?QThIZ0M1anNjb2ltM1p4RTBtbEsxYWhUc1M5QTRHTUE5M29Da29DWHBiT1JM?=
 =?utf-8?B?aUJrTHNWYW9qRDZ5dW5IdXdqVDE1NkJ2SmxBWXlxV2EwODYyQmVSSDVETGxy?=
 =?utf-8?B?Rk5vd1k1eWd6dVNOK3hRdzlsRkVJRytJeC9heCtpcWVDam5raGNuUDdjWWNB?=
 =?utf-8?B?SHRlSGVNL1BNWUlZUlNCVlNCRVhmU3ZwRnlxK1IvaktMc2IzV1QzR2tSZW1F?=
 =?utf-8?B?UUcrUlpoNkhaRmp0UncwcklqUUV2V1d5NkhtU0p2ZzFrQ2Vqd0xpbnlYbWRN?=
 =?utf-8?B?cG5uNFRxWW5qdTg1OHNxbkREOEIwOEp6OTNxTmRjbkJVQXg0QVUxR09TdnpI?=
 =?utf-8?B?d2M4UTRZTDIydnJSWEZUZ0VabmdqK0UwQjRDREh0dDNmRVgyUUVpSkRabExy?=
 =?utf-8?B?Z2p0SXpNeFBQV2lyNmRzdmRkQXZqdzk4aEZ1MThhTVRiSVJuV29yRzE3Y0Vk?=
 =?utf-8?B?R09xa2tSc01hbE1EVm1udTZEcVFZK0U5d1pEME9WWko1cjdGZ09qTlh6TGdW?=
 =?utf-8?B?SitzUWlXUDZGL1JxbTA1U2NVWkpDZWNSdGdLR1ZEb0huemhINjhTNGJPMXl6?=
 =?utf-8?B?NWQwdXQ3bVVkbnQ4S0tTVFpYSDJaSW9vREdKY3VRU0RrYzNtYWhuUkx3T0pW?=
 =?utf-8?B?T3VIT3psZVppb2JZdDM3NUhwL0M5c3pYanJkSW8yYWFNQTZvc1hDakpuaFpp?=
 =?utf-8?B?R213VzdtdWFNdmFNcXZzVS9ORmdIenMwWnRrNzBjRkZLZTFDU1lBbUxtSlhN?=
 =?utf-8?B?TW9HQ2p0VW93SE5xVzhybUlQTkRVKzI1SlF3QU1haGNEbWQ5MHJUQ3VPUENr?=
 =?utf-8?B?UzVXNld2cHRTMTdTNDZqaXhzNmhWaFRpUDk5Tzl1MTY1Ym1rc2pxYkdYMG5I?=
 =?utf-8?B?LzlBNTFudTN3ZFlGYUgvYm9zUXFsdG52dFZISUJRSS93VEV6MWVTMFc4T3JX?=
 =?utf-8?B?MW9JM3M5UWNHWlg0RDNMb2NUTmVpSUp4dnNtVlVjMUVlbVRqRHJFR1NDZTRR?=
 =?utf-8?B?bytNQjV4NFhaTU1VUUZSNkNyQ3VCY1c4VjNpdUs3S2xhSEF2TnV5b1NVV2p5?=
 =?utf-8?B?SlYwY0lLeUowTWJsZnQ3bUxVNEJKaFZzYUhkNWErWmhhQ1QwckRFR05qdUtn?=
 =?utf-8?B?eHRUQjJqZnNXdlJxWllSQWV0M3cremFlc1Q4bW5CTEQ0dWFWdGk3MkJ5WGxI?=
 =?utf-8?B?aDZJekRvL1ZKRHFRSEJOaXpWSytSZXRyNVlMNk9KWGR0Nk9aNlpSUE55QXJ0?=
 =?utf-8?B?OERRZjFXcVJKbE9LUGwzdjlNV1dVRlVDZ0gvaWwvQjVibC96b3d6Q0FsYlJW?=
 =?utf-8?B?VHVxcWhhNEx0em1jU2VXOEpseFErd255TngxaExxV1ZnRkJlUGpSWU9CVHBY?=
 =?utf-8?B?VlVQeWJFOVE5OS9FV3JGaUJxMUZZb2N5M1pYbTNmZFRtZ0d2WFNDMC9lVnFl?=
 =?utf-8?B?UzlZYlRhN2l5SHJIRko4MnpRS0tRTHErV09KNzJKN2hidlQyU0JnbHFvaS9D?=
 =?utf-8?B?a1FGRFdxeTUvendOUis1VWdrTjArSjJJZGZEdHpqT1BPZ2MwUElQMjZEUGc5?=
 =?utf-8?B?bUlkVWNCcm0wRGoveGMrek9PWVRHZFZFUXJaNXRVVzA1SWNvNTlTZFI4VHlR?=
 =?utf-8?B?Tzd5QmxiM0h4VFprOVVvb1k3WDhOc0pCbHB5VGkrTXB2dmo0ck5sN2NZNUM1?=
 =?utf-8?B?eFBidEN6YkFWTHF3cDhoMk01U2UyUnI4NFkwc2ovVVRLdzlETWI0OXJ5TE5k?=
 =?utf-8?Q?KIYcurIiASkMmzO9/P8r2YIWpiknosD90QPDvCa4UgT81?=
X-MS-Exchange-AntiSpam-MessageData-1: eHNZmY5AS6n+jA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a182889-4007-4b00-c918-08de9f7eec39
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:21:01.2713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzLB3nTxwOx3d6Cv4LUu0SjS5pP1ennG/oohBJlb+R7es37WH16N8kky6ztYGPFQ323bhcrM8hu1pIcEevIjMQ==
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

Use checked arithmetic for `ucode_offset` in `setup_falcon_data`. This
prevents a malformed firmware from causing a panic.

Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index bc752d135cbf..d8633e61178b 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -955,14 +955,15 @@ fn setup_falcon_data(
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
         {
             Ok(entry) => {
-                let mut ucode_offset = usize::from_safe_cast(entry.data);
-                ucode_offset -= pci_at_image.base.data.len();
-                if ucode_offset < first_fwsec.base.data.len() {
-                    dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
-                    return Err(EINVAL);
-                }
-                ucode_offset -= first_fwsec.base.data.len();
-                self.falcon_ucode_offset = Some(ucode_offset);
+                self.falcon_ucode_offset = Some(
+                    usize::from_safe_cast(entry.data)
+                        .checked_sub(pci_at_image.base.data.len())
+                        .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
+                        .ok_or(EINVAL)
+                        .inspect_err(|_| {
+                            dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
+                        })?,
+                );
             }
             Err(e) => {
                 dev_err!(

-- 
2.53.0

