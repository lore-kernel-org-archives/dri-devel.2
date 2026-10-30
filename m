Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC741606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tky2fhWH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B60112A06;
	Fri, 30 Oct 2026 21:34:57 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CCE112A06;
 Fri, 30 Oct 2026 21:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh/t76O8DjTO2DKlSgJ5NXevUnQuFtV32wB6rh3aTJoW+tTYTAE60FHBoIiBYf3DuKmsnP2EEQ769W9t5erXmFatwP23Kv8rrpjLF9iMUygyGaSG+RT82WAAIYPLUxnT2r21rRUFiDV4W89wSkU+rrz0CPssPhoKXn0arrOHSRFQ8tDBniVf1Cc+dedxjkBJjqi3O0zbl5yp3JTi/+1FoKNvUS3Tnk6W5RaDuITjLXzFymxcN3fBX8M2Bufziq5Xs+wNDKypekbHgVuFBi+BKBk+73iMVRx/DiklDtIi2WVY9MJdTVZX7Bh7CsX4GgmaWZli8plIuaUoPGIv+7rZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8wukRfbvFkRV4Bl1RmMYZ9zArJacd0VgoFYlenbSY0=;
 b=rYXJrytiny58TFuvzht5yr4fIhbsUX9R+/3ZThYsMBySFEOytY1sFq2polEDwB8woitHJJYq+Gj7vKj42VjArnNIlAHZ16XENLYDLwsmdP9Wm2zU4GhcS5We+QLs7SQsq2XzujSVQD9yoSGJJXvX/AGl7bIcrxW0xAP4Uwx1k84EDDuHAUQzItiZfRjopFepfgGs5nVOEWmO/lyTs0bF9XQb9jyvvXXynrr42YU3RyeF6w5RxuIZ45gYKcKlvc7RFLrJjv+l2vh3y6z7HciG/uoFgyEu8JoTKPoGBch9QFx6LaT14La0mcmxHTDcemSIbw+YxIoSWfLvrEqQqDXY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8wukRfbvFkRV4Bl1RmMYZ9zArJacd0VgoFYlenbSY0=;
 b=tky2fhWHYF3IyVz1exVjhnoT70z3+b0l0pIMObvJtxP2WUKYIQsTXDLdceIqLdjLYnCe4DDDr8LFFm25XC8gsvwy+9JXTjPdUwqvtmrDwUTSBGje9FLxfV8E+ADcYKGYRVE7V+oaAO+gGGR/LKWxmfYsLzTbhqjCjXxnPFk4hgd8GsuXygc7VxHja7px3FGjuk2ZeJYOxaIbCFL7fuVL/eSsgZv6oAB3CcsXZWi5iS3/hF1jGo4gas1AiMTuv/Qitd0zRMSmAOhVSfq8PaFIGyuSlNjqVxdJgTiMvXTEaBGw0vP5IujPmdv9kJbMJFZ5f4IrYnFUS/Ec7FheVVABOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by IA1PR12MB9523.namprd12.prod.outlook.com (2603:10b6:208:595::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:34:43 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:34:43 +0000
Message-ID: <2fd5c42f-48b6-495b-a3a7-0696e6a53be1@nvidia.com>
Date: Fri, 30 Oct 2026 14:34:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
To: Eliot Courtney <ecourtney@nvidia.com>, airlied@redhat.com,
 Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMI0H1ZU5R4C.25MM4QF6UDWA2@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMI0H1ZU5R4C.25MM4QF6UDWA2@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|IA1PR12MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 254c7ad2-f64c-4c74-9c71-08df36cd9cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261028144727099003|261022105027099003|4143699003|11063799006|261026121527099003|261026140227099003|261021121427099003|261009223027099003|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7im+Nudzpf/gdhuhagfYHrhC7qIcHUKk4L4TwzjrYMKUBWclWyCprX3+bAE8onaVm4qHl2i61Q+GO3lUNT/GsJdgwBZ4NYnRjsLs9cb9ZyT3st9ER+sgk/D1+ZJojKIYjTXzEAtRRx3u7ncH8GeFiARPAgxzXxzNhsh6k9yaZbkhF9v5sCLdg9UP4H7zvNZxef4vAAOwjGxt60y+HX7dKEhutM+W67zi3C9W/XZ8rlR4zHOdTUhoO9gPllF0NKm7A06jZ9HMG4rYgGajIYqJW+Vp1r+9TJ+g7R2QDverTSwFnrZbyRKg/RIdWRNWMs1TGInTB8/j9svUyn4kEBvCufN0yrjDrf9wvxuEeOu25GT/NFBB3aPkMhD8tz97wBnCQMe3u/i8RNk4hTuDHQ1fAUmyWSxgNSaMqOusVtHEWykcm+ICzmmgJjgy4FB2tS99pveIclo/2ZchB/6tz/NwezprzbGfD1KfV6GtqbVAHXEBatsJgtwUI+IXkpjl35oGFvCw1k9Uu6zdWMyvzamM7Z/4nL3woWw6QUPncOisIl2KUPktMfVxR7sZkYJpwLUJcuSQE8jQCapA+GL4+5D/kp/86DN/0GL6bAWaGQEMST1AGI8jQSJxWWPdjaEk5Tf3Lzhdnh/AaaW4aoqsWfYcN9Yl0EeNDFgZGxDP2OT2dHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261028144727099003)(261022105027099003)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFQdXpGeFhxNW9uRVVkSUc5ZEZ6Z3FWaGRvT1JiVXRaS0JVMjNzUE5RaEpz?=
 =?utf-8?B?Y1hWOWpTa29OZ0hkUUVxNHBVd1oxVzQxa01XWllRdUtBbm5DQ05vajRkcWlK?=
 =?utf-8?B?ZUVxRkRhZmlEVW45Q1BaQ3dEVEJCWnByNVkySmpZZGFpVlNGczc1b1hZUnBz?=
 =?utf-8?B?bXVtNXdzdmVwWXFBL0N0L29ZYlZTMUdlV3haN21ZS2VHWjVCUUFyeFdPdUZi?=
 =?utf-8?B?blJpSDJTSkNzTW5VWlZaRXBqOUdONVRQOUN2bTNBS0dZREkvTDlXcXJzOWcy?=
 =?utf-8?B?aXFvRXl1dHhvUUFjNG9CZzlaZFR2STVaU0dvYjFGWXZScG93L1pjOGJIWVpM?=
 =?utf-8?B?bU9DWENpN0haeXNNRkJwN0hiaDRidEJHL3FOZWFaWVJ6RDRYWVJRWkVwNlFz?=
 =?utf-8?B?ZGx0b21zUVJkeXN5TG4xRThZeVpGQWZacUM2WHlpN3dXQ3BVRG5KdXZhWUk3?=
 =?utf-8?B?UnBpaUErWk9JRHRxQTNHdkIrVklCRTRlSzRKM2ZFSjN2U3FENWlpOEFEMjFj?=
 =?utf-8?B?SVFVRjY5cjFhOWVoaktTc3BHMlBMSFE1TENrWXk3YnQ0VzU2aWg1YVE3K3JV?=
 =?utf-8?B?STNYVmw2amJsQmtFR3lQUWF3ekc3UExWSFVLQ1Nwa2NGVnd1cjJZd0t1cmJF?=
 =?utf-8?B?NWtsbzhGWHJKOXRNU0YwV0VuNkJLUDdPdGtWZFhJS3E3bEhuL1A2bmVxNjB5?=
 =?utf-8?B?d1E5TlVvYTJ2L1ZzK2xqRlFPNWREMnM1QUwzT3N0cmxmN1ZxQmVaVnFBNlhW?=
 =?utf-8?B?YkNPRkJoSmFzcEc4ajZ6NFltU3NEKzVrdVBtUTkwcDZrTm00RnBtQ3FPVHYy?=
 =?utf-8?B?OWtTN0cvdDNoaE1UTVdWLzRmdTIwaDUxR2h4bGZoaUlnREFpeFNLS2V2dTg2?=
 =?utf-8?B?QTMwR3JqZERmV2RuUHREczc4VWM3VzVWSmw1ZVBQU1dVd21nRDhLbk9FMjg0?=
 =?utf-8?B?UlhxeHI1YkxkWGRMODBTT3hQL2F1V3QvUTVxUTQ0UVc2VHY5Zy8vMTVwZmxz?=
 =?utf-8?B?REhmbG1PcGFOZkxkVy9ybkpLV3Rtd3dSYWh3SEdrUXBOYWdXYkVPZXB1TVNK?=
 =?utf-8?B?dmdNMWY2dVBPMWJTTGFTSkxwQ2x5R0NWeUFEaktZb21Cb3kyeVZ2UkFXTGgz?=
 =?utf-8?B?UUNWL21ocUVrU09IU0JJY0JEL2RrT0xMcmFGT3U1a2MwTEkzTUxMbUFZd0tT?=
 =?utf-8?B?N05ldGJlVXFabldFTXFYbi9ickRLZlAxYjdybEdOZ2sxWnpCQ0xuNVVOaUtE?=
 =?utf-8?B?dlBwdHlOcGlBY1p4c0E2VVJLbFU4Ny85UTJuWTk5eC9RYWY2eW9qZ1NYYlNy?=
 =?utf-8?B?L28wUXhBOFlCSkFXQU8xOXoyblJ6cmpjYlpaMmg0OFBGQUI2QzhrYVk4SldE?=
 =?utf-8?B?MUs2T0VnYXc3QVhNdFAzaG5OMFRLSktaME5wcjJCUk5tYVU3SWFZU3ZXMmsz?=
 =?utf-8?B?UjlPcVZEZUtQYzRPNFNQZTZYT3NNWEhSRzFrT0VreGtEdXBKMnZpcjV6clY4?=
 =?utf-8?B?TkwyYXhkMGRTKzV1Vm85QWlYNUtwRE5TQldxS2dRZWNqT1B3N3BJbTE5UkRS?=
 =?utf-8?B?WUtMTUt2MFJmcHVRdEVUTzZsbk5ndlFjRjBFMEcyOVhlSGl2cVlaeFYwQVZF?=
 =?utf-8?B?QU5xY2NOL0hCc1RrMDZTUEh1YmlCM3J6QTAybDlZdGVNMjkyNnp3T0ZLRWk0?=
 =?utf-8?B?elVnL2pPdXljWlJ6U0dsNk9qSXFvT1VUbWYwM2J2bUY4Z1hUMUFBdjFwZ3BR?=
 =?utf-8?B?eGlReUFLUjJHbm5DVUVmWDdGUm9mZ25TVmV3dUVxYlV0YmhmdThHYXJ6RkE4?=
 =?utf-8?B?YmoxblBoU00vemgrY2grOUNWUFkvL283Z0tla2FpaU44QlN1NEhSRGlBcitp?=
 =?utf-8?B?cElaR1Y2N2IwVUpQWTh2UUhvaE8vY0JMMTBCYTBxd1dtZXFBVExXb3oyOVVR?=
 =?utf-8?B?WkF2bnlQamd4MXRRTU5naEw3MFBJSTlMblpFS0JXRWdtMDFLUjlhRUpEKzdr?=
 =?utf-8?B?UFdGQ09tLzh2ZHdYam5wTzRXT0pNekdjV21LbXZlLys2ODlSZHJjcENGTzBL?=
 =?utf-8?B?NXV5NWRPZVlvSXpwNUpBMlBESnZQbXZXRlJ1L3hhNXF6MGlHTmM1d0p2SHhG?=
 =?utf-8?B?VXU3U0EzSEVvOS9FQWl3YU56b2hYZkZCRDN5dm8ra1padEhQWWd2bEpRZ2lT?=
 =?utf-8?B?eUJVZHpxK3Axci9UcG0yWEFVVHNlTHpDYkVlMTlNdkdwdVFYWUNINGVCRnMr?=
 =?utf-8?B?cU9JZEpHM3doZlJ0SWhmaWt6OWJGMzVtNkJ0cmtYRS81enNuckJEUXVDNFZZ?=
 =?utf-8?B?RTQvZ21ENWpBSmUzRzBvcVBTT3pMejk2WWRjL0Vtc1RYWkJMSkdsZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254c7ad2-f64c-4c74-9c71-08df36cd9cd9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:34:43.8814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5qlD9RbE8/x4P2iDgLebLwumKMk8+Jf0iD8LrfLpGgzI+92e5wR6znNgqWHTMMICioT6bjEgcvZ/aYUJ+opRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9523
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 12:57 AM, Eliot Courtney wrote:
> On Mon Oct 26, 2026 at 1:24 PM JST, Dave Airlie via B4 Relay wrote:
>> From: Dave Airlie <airlied@redhat.com>
...
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -564,18 +564,19 @@ pub(crate) fn new<'a>(
>>  
>>              // Create GPU memory manager owning memory management resources.
>>              mm: {
>> -                let usable_vram = gsp_static_info.usable_fb_regions.first().ok_or(ENODEV)?;
>> -                let buddy_params = GpuBuddyParams {
>> -                    base_offset: usable_vram.start,
>> -                    size: usable_vram.end - usable_vram.start,
>> -                    chunk_size: Alignment::new::<SZ_4K>(),
>> -                };
>> +                let buddy_params = gsp_static_info.usable_fb_regions.first().map(|usable_vram| {
>> +                    GpuBuddyParams {
>> +                        base_offset: usable_vram.start,
>> +                        size: usable_vram.end - usable_vram.start,
>> +                        chunk_size: Alignment::new::<SZ_4K>(),
>> +                    }
>> +                });
> 
> We should probably add a helper method on e.g. Chipset to say which
> chips we expect FB on vs not, instead of proceeding with no fb regions
> here for ones where we expect there to be one.

Open RM does approximately that, although Alex's point about using a
HAL instead does of course apply. In Open RM, "bGpuArchIsZeroFb" is a
per-chip HAL constant, true only for the Tegra iGPUs (GB10B, GB10C,
GB20B, GB20C in the current public source).

None of the chipsets that nova-core supports today is in that set, so an
empty region list is still an error for all of them.


thanks,
-- 
John Hubbard

