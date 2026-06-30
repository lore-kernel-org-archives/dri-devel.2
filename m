Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298F8C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2524D10E164;
	Tue, 30 Jun 2026 11:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gG/FCCqT";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5059D10E164
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 11:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8t5hT16N9q57q2hfipsRR66hVpPND5Lltlf29NuQSVY9F2puD8KVRZiTKA4F2XfNwSXjz5+hzw+ohZB0iQjhAuCOGd7SDw0l7dlmJzys0//mvQMhTbqzq4B5zS3MHdsFR1tg1kSD9Vm6ia4mgKR8YsRUTQ0ngF3QHl8E2JOdLB41gt8oKhPo0wmrAfDTWYvowccaSYatZ2rzf6gM8eP5lh++INSSuFVuFim73DNAZ3plirerwY0htbq69AHL5YSukbet4POR0bZxqf0xVqAnuYpOr84vI358ZQRR/UmC4PcmmTbcEQhvh6fjA8tVJc3RGa0B2rkyjl3OsHM+B5HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CC8UnV73CgySyWMIo3hoITcj3SpEEgrHmLNde4MkjQ=;
 b=VcSHlYRAmyzLMe9BemG3NCcRjatyK2389wI9EmR7f/l/JpfGgrJnyI0RZ3/yg3DdFGLDUBVDHTfboaXFixy3aAs9P1Po+JX7xy0STR35+z+P3EMm157l/AopZdU1CF1Tf6m6vBOAvurK1aF/LX8miu3K4NvLPUOpMk0AdCmbv9AGJ1SZhUePzEM+TSiks8TUNgmx/UHV5BaJFP3ggLgLeoO5I7eqvLIFZutMqmak4JjsKto9FlhHdgl/lb0QMqcjpSs/XyFrikDgCP731Gvp40cGSCxiZHGdAKL2NDaetpz3u1cwQo+eWXbLS9P9gbL9Ce3AWLURtu/tn5jWW9qnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CC8UnV73CgySyWMIo3hoITcj3SpEEgrHmLNde4MkjQ=;
 b=gG/FCCqTveRbKOZRoszd4PY0RtMd2d4jQBFsEdGg0Lr2pvyRm5EpUJLZGhvpCtCP4jQdSIgR7atIkrWyNMbjCRSSxezngyj56va3mhXgS9Rj32FBpL9oaeygaabh60HQ9t2bWnRrabme43zAlMkW8mDCIobZ1X+qTyQCk1s+ZF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:25:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:25:01 +0000
Message-ID: <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
Date: Tue, 30 Jun 2026 13:24:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
To: Dave Airlie <airlied@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, iommu@lists.linux-foundation.org
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: ad94564b-bfd1-47ef-c6c3-08ded69a39ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 095wVuLtFH2jG8Y5bbOIjlFdaCfqC0DA3RCKHlYVIu68s5go8da5EcIcJLYuqZitCOx/5/mYckXZsXceE5VhM5EQUPNK9jjat72s92bU2Rd34rExXwfb9BrGZLe3uEVdZ0FJ9oU4FA5w1LAGICu/BB9RApk5itGnUiXb/B4XoTMT4KjTR+lGqJJ25WWjpj/MH42r3rAHbstb21NLdZLwFtcnNbcC5QOYFmZ3MVs8qgg1b3ikvuEKklw+gvYXTcJ1joEf5G7yqhzxKhMj4O5f5Coj3c/rnPWyZf1kkNVOVpmUtsr2uj204XaITEVACYuRykFCqilVyNr5CfkJP5CZ83eLAwFcYmjCAXmfe3ZsSnrsorfAz7sobneCcSc02j4k+4iaJgbt0ym2EaISeiwLYtVALEl9VRqRofb2pG9K7fZNqzdptsSyESk0VNHT7hpSCELMrvq/9tk/Yqwh8D48Y+n6zkfPvVmrQjm4OeYEVUacAu9CTAibaXn24Z6uo2K5ixbmLUC1OmaQY8OzgV5ZUkuyeb9FGgWINj4ahi02X9W4E0wI/UPuglElHiYFO9cQa3U88pCZ6bvF8t7Sq+CoXg49nUYB4AFQP7l4iMK4gIAyDcSSssQVjN+6RxrKcCBmBSdtmLuolBXenDP89QIpgc17bQqxwQFzvFiKWdWdPJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDlzZ1A5a2NvdVAwUkFvRCtJcU9zYitvT1Ntd1VqZjVwMVVnb0Evc3VYZURB?=
 =?utf-8?B?TVhseW1HaFZZMEZ5cHhtU09qVzJscG82N2lDMDBkaFpVSVByWEdsTWU3RW1I?=
 =?utf-8?B?N3Q2WHA3YkpRWkhxVkk3VjBOeVVacThlbWUzejY1ei9qZ3VQRzZNNWtYL3Zv?=
 =?utf-8?B?azd4ZFo3Q3F6ZDUybGcyWUY5UVdoR2s2Z2NENTBxQzN3d0tEK3Y2Z01oMmxn?=
 =?utf-8?B?d2VKOUVURnFDY0FvN3BnbTdVZ3ZGMHpFMStqRXNLck5XdXBMZHZ5OWtETGtk?=
 =?utf-8?B?WWt1OW9qLzl6K1dVSU5CNjRjNTJlOEdzWVZUS25kQUlRWXJlR2NyVlBRRVB4?=
 =?utf-8?B?djFWRGxQWE94cEtETUhuZG5ObTZmZzh4Lyt6SmFDN280LytaakdQV3JLMmxC?=
 =?utf-8?B?WG53NFVINnVHK0hyQThFOXVSNjNGbHcvVGp2YTEzbXpGUTV1UWNxR2tEbGhw?=
 =?utf-8?B?TGdiZEtIaStKVk9BbVAzMDBncTMxSHpjSzBnLzI5T3RXUXJ2ZmlMMExiQzYr?=
 =?utf-8?B?WHhqVFZzRjNDUjNBUXdqdnVKeVJRaURjMDdNVVRiTVp4VGpxYVlHb29XRzQ1?=
 =?utf-8?B?TjZpeWNqVXloWEpWajR1Q0gvZjdZNzZnalVEc2JRUXRjdXVLUzNoT29VYWI0?=
 =?utf-8?B?U2w5K1FBS0w5ZVF6a1NDT002azN6TXVEalQ4WTJMZGJCYzM2WCtpMWI3bzMr?=
 =?utf-8?B?dFRWM0pldlExWS9KRURhWmVVczVMWkd4UnRBYTR5b2RNUXpibU9leXR5eUNV?=
 =?utf-8?B?djRobW1scllIcGJmbk9ja0k5ckNtL1Ayd0c3RGR3VmVnZGZ2VU0xUklySDQ2?=
 =?utf-8?B?cHFVSG90a0pNdUJNMkdidmVxRWNVMExCOTlvTTVoUWZrRVd5a2NkYWJFOVVC?=
 =?utf-8?B?Zkt5M0prQVlqWWJQc3RjWkFteXhrdTg2Mk1HU1EwUjU5NmdzekhPMDNNdlMx?=
 =?utf-8?B?SzhNSnVnMC82RG1pekFYeTAwUXYzVjN1STJsenRzendVMnkyTTBTbE9yeFhx?=
 =?utf-8?B?VEE4OVhTcDVHb1pOYmJaWVNrVHNJQjExbS9yMjEvZFFncDNucHoxcWw3a0lI?=
 =?utf-8?B?RHpPZ0VVUS9tRXU0SWlZaG1JMnlsYWtnYVZMcmNQUXYzbkJMVEpRRzF6ejlE?=
 =?utf-8?B?dkI1RkpZa0YvMXlMSGxXaHNta09QS1Zqc0NkREE4QlpxUHN1NVQxVEQvNVY3?=
 =?utf-8?B?anBTbVA0RHYrc2R6Tm1UaTYzVnpVM3E2OURxYSt4ZVhqOTVkUTdpZHVaSHJn?=
 =?utf-8?B?Vjh6djZVbkFML1pnRzV4MGU5Y1BmalNyR2JTNmF2MXJXRm81WmFNN0JOcU5K?=
 =?utf-8?B?c29RWE5PZys0dnNNUDB0NTcrUW5Jbm03TEloZkRtMnUwOGRxY0t5MDVWeFNS?=
 =?utf-8?B?dms5Y0g0NFMzc1pWOU40UEtzTk1QU2tMNExHa1JMbWVFVVlWUWIreGlUb2sw?=
 =?utf-8?B?ODJWNnRpL212ZkptTDA3djdkUVB0WUp2c1AxSGRrMWhnM1lvQmRBWmk1YTlH?=
 =?utf-8?B?RzNiMGI2bDc1TTdBTEUzNjFPYVI2YVEwZS9Ha0FJMVFHdmowS25MWFg4c2tW?=
 =?utf-8?B?bTZGUWVQMHRMRHgvZUZKK25vb2lIQ3JHTEQxRFRKTEdDMVhQT1QzQ3JhdU04?=
 =?utf-8?B?VkhuTXRDUVg1OEg1dUtOaDZpV08zSFlJS2FSN3llY0dzN0NTNVVRZk9MSGlY?=
 =?utf-8?B?RXU2UVZvR3pGMFllOXoyWllCU3ZFNHpVejBOeHBWQ0U2Z1JaZjI4YUQwdDVJ?=
 =?utf-8?B?clgrRHJialA3amxNZ3M4amhFcGV1WGJmcnVlR3RQbkJqMGRrNDFaMkZGSUZ2?=
 =?utf-8?B?SWtmbmFjWjJ3L0F1bnBpN3o4bmlWZlBvY3lhNlFlUzlnZnllaUdjWmV0ME1O?=
 =?utf-8?B?cGEvdjEvbnc3N3I1N0tKc1p6Z3Q0OHQzdmFnRUJOTU9ReUxlamVBREJzS1Ux?=
 =?utf-8?B?L1NpTEJHYkhYeEZRaEo0ZFJRRzdZVEZ4MVJSQlFNQ29xR3pPL2c5d2FmWUZu?=
 =?utf-8?B?dmFvKy9hUGh4bHZwam5NTjQ2cTdidk94OUQvL3JGNnZZeHB3V1pLRUI5Sjlm?=
 =?utf-8?B?cHoybHRwblBJZmNWTVRiRUJBdmJzTWxxS1kwU1E0UmZOQmVJNFg1OE14ckFl?=
 =?utf-8?B?TTNuZXRYVjlheG0xZStuWUs2Uk90cDJBQU1YUkt2b3MyeEU2UStNSzVwTGp3?=
 =?utf-8?B?elo0bHE5Q0tGZ2RXM1RkQ05OcWxCdzJKaklPekNlZGowVVl0cGM1NVJQUXky?=
 =?utf-8?B?ZWZyMkZ1SDREdVNPR1VvZHVDWVRGUTkrMVRBN0x4eUxvb1IwZ25vQVJ0Z1Fp?=
 =?utf-8?Q?LoxKRhuv2LDFlaNCoV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad94564b-bfd1-47ef-c6c3-08ded69a39ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:25:01.7382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7ukk4tUgMZIxg1Nt2U8BKN9luUv97oF/4SZVRZwI7X5gW8aDUfPlaSS84V+BeQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446
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

On 6/30/26 11:39, Dave Airlie wrote:
> I've been bringing up nouveau on NVIDIA Spark GB10 and fallen down a
> hole of why is the GPU writing to pages I've released back to the CPU
> page allocator. I've wasted a lot of time on GPU L2 cache and explicit
> handling for it, which might be needed but hasn't solved my problem.
> I've also invalidated and flushed the GPU TLB excessively.

How does nouveau make sure that all DMA transactions have completed (e.g. caches flushed etc...)?

> Today I finally hit up iommu.strict=1 makes things a lot happier,
> non-strict IOMMU seems to allow a race between dma_unmap_page and
> free_page where the unmap goes into the IOMMU flush queue, where the
> actual unmap are delayed until something triggers a flush later, and
> the ATS translations stay alive past when they should, and after the
> page has been allocated by some subsequent user.

Try disabling ATS, that was a common source of problems during HW bringup for us in the past.

It obviously cripples the performance, but when the problem doesn't happen any more you have at least an additional data point to narrow things down.

> The options I seem to have: (but I'm probably very wrong)
> 1. force my own iommu domain and use iommu_map/unmap explicitly in the
> driver which avoids the flush queue?
> 2. split ttm page unmap/free into two stages, and force an iommu
> flush/ATS sync operation after the unmap before the free. (I don't
> think iommu has an interface for this).

Yeah that idea already came up on similar issues as well. I certainly wouldn't be opposed to that.

> 3. force untrusted on the PCI device?
> 
> I just want to see if anyone else has hit this problem before in this
> space and I'm missing something, just feel solving this in the driver
> is a workaround for ttm/dma API impedance mismatch.

Yeah we have fought with stuff like that on basic every AMD GPU HW generation.

From experience I would say that both MMU implementations inside GPUs/accelerators as well as well as IOMMU are really hard to get 100% reliable in preventing random memory writes.

You either have to use memory fences which use the same path as the DMA operations itself or you have extra heavyweight TLB flushes with just insane overhead or grace periods to make sure that all transactions have actually reached system memory.

So far the record for grace periods you need after a TLB flush is 6 seconds on production HW with up to 10 seconds on engineering samples (because of HW bugs).

Regards,
Christian.

> 
> Thanks,
> Dave.

