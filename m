Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B460EDB7CA
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD2C10E349;
	Tue,  7 Apr 2026 07:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Akx7mjZm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292DB10E349;
 Tue,  7 Apr 2026 07:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJgjoPoB1PxRIrrRMsKpxYcJ2+5Ufe2bxbgM4XNe3pi5o3fHRp0ijRM5MzaUz7UTogU5pmMaLMGUnUYG8EKkxaNYphUg+Sr1Aqr8Gik7RneOaCPe2afpLHxw3k9vrlCv2DTH1i03lgRjn5f9drW8W+Pcf9e/dpO9g/lmmWJhkbyZSAksQAO1gr8RNGxGfZz7olbLsW7or8FLILe8bBIdtAMLD/Ysqzs46lJxJOvCKCqq8afJhbRfYnwnO9Hui6lpjYHvptPm+imwTKvyf9xcDNP7hxKRt2PLduAoASfeKgWt85L6bKXe35U0iPBuj6/2t1nY/URGbmGsyMO1CDBm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2DHvb7duFW9tT5635dmSk5ZaZRfIOuKYvJSfdsrJEU=;
 b=ypVydxG5MNS0N1P2fIGGZnjB9LFyHC/zjwd7NbtkAPvtCODNVQwPLmNRnWkQGhaDkzIW7ymXA+8cg1NJoM+uc+oV9ugA6jxWoegqmjGooLlY5rsB3TT80Z3X260XAjaVI8XZ+BYPDSZy36ErVh3sCpI+sQc1gdXr9v5s+nc/GR4FbCfCqQ6mW7k0dX4rPP1OTJoi0J/RR5+AYeLSOpUWQU2l3z02/J3MYEaF/UtnccOVgmprifXGnuR/0xPYjMqmeATZNHnPfWCCf0yimold/sbqouiMsYFxiFk3hkZgJdLGieLfOJSiK5uDNZTWHaO31wMO5Xs28epmshDuCOtAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2DHvb7duFW9tT5635dmSk5ZaZRfIOuKYvJSfdsrJEU=;
 b=Akx7mjZmlRUWXAOHUHmpCRFMSLQABY+Cw63fdBpbSwTYdz20bWz3uCovGC7i6nVjnhKeJyBMaUdF2gFCD/OVZyGlRosKY6zkWWCbwQqQYoFUoZWWMCf5M101C1ob1zqxonM13/STFa9hHAF87MT1BN/B76jF0Jtmzb896SO0rtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 07:43:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 07:43:35 +0000
Message-ID: <d8e8f290-c2bd-483f-ba0f-735c503e269a@amd.com>
Date: Tue, 7 Apr 2026 09:43:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
To: Matthew Brost <matthew.brost@intel.com>,
 Daniel Colascione <dancol@dancol.org>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <87341fsa85.fsf@dancol.org>
 <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cea65ee-7062-4127-a76c-08de94795ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GZzJJ331uJmBx5XCwoIv/cwHzv0v7LrgpjpnJyEf3c56ZAUB/w5fMkmMTbZ9qGG1PIdIwWumKgaBrn3q3ItQ+mW+CGprQswJ/dATVbhUtwIlKFCv6tIl5fAUMqq/3DUcvx0TZ/RrvBIODPZow4GM8REx12s2tK/PBQBIl3HqeuAHRZN5xnJsPu2lHzqmxzKH3f8ZJ+61ebdlnsMaqNX4dw5ngaUj5OW6zMR2tHutwGZWWTN/iMP+5Vh7OJ2zmz/FO71NBh+k1GbiETncQZ+MKQfrH1inxbAE6RLLzlgMO//L5eJUcizTGLp+mKmo6Cla7JfIpISXwJeZocDQHEKQ4wyF+i0w1rrtzHHssLrY3pT4zJhpEzHwpXs1+AsL5MuvqPgv4Q9emxL1isifbzlz/s6CDDTC/rxC4NgOeoqfnEbGyRO18dgmkZzMwEo9r32PIhQ9o8ewRIZTWafhCy1KktS7FZYyinPEZmC3yzobrnDNFuQvSndA76lcYpv2K72lz3Ss/tLOHpHO96sdr2KEMAJfirMlHBTUkp8EXSjqTZ9mrcga7I4osBTH1ghly+1vAGNheE2IsJPGkRScZ4HczTdqVM6Zf6QEIURunwZY6suqgDTsF+PqWrfBNhgZPIkAu3/w4Hv1JFawIJz3FTG6r7UzAcRHvtCSZpkTq9ByHrxhhMumIe09RDnveBqyAf0x1W+4zIyn1C7kxXr1S+jiGO2jAg3hDgYQCwKUtUO4hAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUsxVXRUNmJTZlp2RHREckQ0UFAxaDNQUGZ6T2RBd3dQZDM3QTVDQ0hIMzJW?=
 =?utf-8?B?SG1QSTQzeDhPT3ovUGlES1prWEcrNzNWSXF2Qms3LzM3OXlTdFA1Q2RDNUNj?=
 =?utf-8?B?clVmM0NOMGJ1SU9saXUyNmozMGMvUWs5MVdIOHNOSklWYkFzY2JPNEhDNkZO?=
 =?utf-8?B?RmVSYkhpdCsrR2RhMTN3NTN4OVI5Nm93UGRUajIyR1V1aEUxd0puMktZeVFS?=
 =?utf-8?B?bVRRSzlLQ2wrc0UvR2JTK1V4RWUrNGY2M0tpb2NpVU9EaGVZeUZlUUQ1RDZq?=
 =?utf-8?B?cWhZNW54TXhSWkJjR255N2ZFa0xNQVJXUjhGUzF4VTdDZzVQanZkUVhJWWVr?=
 =?utf-8?B?SHVBSzlFY1hEczlqMkZHZnhuMGs3Vk4wbWU0ZWcxZFhzZDZ6NFRHOVJ0OGhv?=
 =?utf-8?B?Ym56TzZ2Sm03dVRpc0FCUVpqWDJsOTRaR0dMYldEaUFqQm5EZjg1ZFZsbGZv?=
 =?utf-8?B?MEsvcS96dXpHZGd0V0ZoZGlyeU92TkZKRWhKdk53akkvL0F1TTgvRW1oUTBC?=
 =?utf-8?B?d05HNlg0R1piK3RMc0NjZFBVdXBTbXo2SUhjTHg1Mzl3V2MrSGJzemdwckky?=
 =?utf-8?B?c2VTN1VWai9TWnhIUFovSEIveG9aVWR3M0RoVHZBRkt3Z21OcVdFU1krY1Zx?=
 =?utf-8?B?d25JUm4wZlgyRFZhTTRUaVBrc2RoK0dza1dNZXBZMUoybWFWNEd5UFBPSENI?=
 =?utf-8?B?UnBUaDZ3OWVIKzhSanZKUnZndXpnK3ZRdjNKUVF3Y2NlZUpGbjN5RTNPN1Vs?=
 =?utf-8?B?NW9KLzJUN1UyUUo0NUZwak03MnJNdFpESWtwZ2lpdE1NZnNuUDY3U2s1R29k?=
 =?utf-8?B?L0dhYXBUNTQwaTkzalk0WTAzS1d6eTBTL2dBbkcxRXF1SnBEY2pPVGxMYyts?=
 =?utf-8?B?Q1ViMXRTODFQRVdNdEpGSGdrTXhNKzl4bEZ4V2dLbEsxVTVoVHV3Qm5lclpM?=
 =?utf-8?B?ZHNoc0Rla3lRWEtyZ21ENks5THM1NHFsaUk2bm1OZ1drRW1UVUtUdnZBWUpS?=
 =?utf-8?B?WHF5NjFiczJEWnVWQ0xxMWZTSSs3SWQ3RmZENDVSenBhcXh5bFkxMmMrZ1gw?=
 =?utf-8?B?amNhYVBtVy9JMXhkZDlaK1JtdExYSFdKNTN4RzA1dkpNbnR4cWRua090UW9K?=
 =?utf-8?B?T0NpV2wvQi9BM2tKR2I0Y3RIZ0JBMVFsTDZ1YmpSRVR5NCt2bFNYR3c0ZWxV?=
 =?utf-8?B?Z3NMenIzTmtUTTRlUkNGdVN6emI3SFh5c2Q4Sis1MFJmeEtXZStFN3lHSktZ?=
 =?utf-8?B?TC83Q1pKcVVMa2ExR2NoNG5HTGJQeDc4M1FMamJ3VFhocGxCZVByeDlpMjFX?=
 =?utf-8?B?KzhvaEtVNkNtRmVQQXpCNU8zMDFYNVRxWGNJSzl1ZkFzUXZyOVRGSXVKSWVD?=
 =?utf-8?B?azA5S1NoY2NTZTR0azNPTE5aZ0w1ckxDRTNmc09xZTBjdHR6b0NlMEhxNDFB?=
 =?utf-8?B?YXNBVzM3UWM2QnBDSzJ6a3ZLek1FUWQ0LzRiejFUWWNrK3g5d0JaSWNicjFK?=
 =?utf-8?B?TXlpajU4UGxERThTVnRaLytrbml0eE54N29LYzRZcTZmNDdDcXR0aEQyWStK?=
 =?utf-8?B?aEcwTnFvZE8wcUFjZWlaZVkvM1JFdVhQRGROc0p2WVM2ekpjRU9lbUQ0YUlU?=
 =?utf-8?B?NHpXN0NZbzUwNG82cFpob0FVeDlTb0FwczYySWFWVW9OS3d0d29aSU8wTTdF?=
 =?utf-8?B?ekFab1F5Y1IrejZHS1Z0KzBkTXlJNERXNjdaVkVVeDdUTVc1T3RBR3daTTJE?=
 =?utf-8?B?RGlnT2g3YnpzS2tKd1pqSDFRb095WGwrNWwxUjJUMnJ4N2loSjZ2bXdqZHIy?=
 =?utf-8?B?bG5oNnkxTExNeGI0SncvWHRKVXFFNm52UlM4L0liYUV4ZzF1N3lrdlF0U0Ju?=
 =?utf-8?B?bzhkSVRlY0toaTN5K2l3bVhhV3BjcEVzcmRXZGFVOHVGUUFFZWZLMGVCVWtH?=
 =?utf-8?B?TlQ5ZXNxUkc1MDRRckVObjJuaDdzR1NQWGlERnNHdEZOQ213ZjRaMm9weVlI?=
 =?utf-8?B?VDJNUzhVeXhnVTQxSVN2Vi9DQTJCSDhXVDF3U0ZkTmRpYmszTjFtenRpNFFE?=
 =?utf-8?B?QU5pMytFekw1Y1BXOThnQ2JSZjR6dmhkeGV5K0t6YjNNTDY2bXZ2VEYxU0Nm?=
 =?utf-8?B?Wnp3dDRCVTRRWlF3cml3cGJoRjJwTU85TGtVcHlEem1keHFDTngwVkRzNGRr?=
 =?utf-8?B?Rm55c1F1clBXMmNxWVcwWmVwZGg2a2RPQW0wRVB4WUx5czJDOCtwczA1c3J5?=
 =?utf-8?B?OHRrSE1pWmM4VHF1dXJXbFh0TWZFSVUrYWRJZitHVTRyUkc2V1pIZGl3Qm9Q?=
 =?utf-8?Q?9MsiwUMa7DvHikyM+/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cea65ee-7062-4127-a76c-08de94795ff5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 07:43:35.6278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEMzK+ubL4uMhCym+X8occA3dglnjgMutdREhvLX0gc5zsZyIC2P/UeJcIn7sc92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617
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

On 4/6/26 23:02, Matthew Brost wrote:
> On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
...
>> -
>> -       /*
>> -        * Do not add latency to the allocation path for allocations orders
>> -        * device tolds us do not bring them additional performance gains.
>> -        */
>> -       if (beneficial_order && order > beneficial_order)
>> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>> +               if (beneficial_order && order > beneficial_order)
>> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>> +               if (order > max_reclaim_order)
>> +                       gfp_flags &= ~__GFP_RECLAIM;
> 
> I’m not very familiar with this code, but at first glance it doesn’t
> seem quite right.
> 
> Would setting Xe’s beneficial to 9, similar to AMD’s, along with this
> diff, help?

No, not really. The problem is that giving 9 as beneficial order only saves us avoiding direct reclaim for 10 (>=11 is usually not used in a x86 linux kernel anyway).

> 
> If I’m understanding this correctly, we would try a single allocation
> attempt with __GFP_DIRECT_RECLAIM cleared for the size we care about,
> still attempt allocations from the pools, and then finally fall back to
> allocating single pages one at a time.

Well the code is a bit broken, but the general idea is not so bad.

What we could do is to use beneficial_order as sweet spot and set __GFP_DIRECT_RECLAIM only for the allocations with that order.

This would skip setting it for order 1..8, which are nice to have as well but not so necessary that we always need to trigger reclaim for them.

Regards,
Christian.

> 
> Matt
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index aa41099c5ecf..f1f430aba0c1 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -714,6 +714,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>                             struct ttm_pool_alloc_state *alloc,
>                             struct ttm_pool_tt_restore *restore)
>  {
> +       const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
>         enum ttm_caching page_caching;
>         gfp_t gfp_flags = GFP_USER;
>         pgoff_t caching_divide;
> @@ -757,7 +758,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>                 if (!p) {
>                         page_caching = ttm_cached;
>                         allow_pools = false;
> -                       p = ttm_pool_alloc_page(pool, gfp_flags, order);
> +                       if (!order || order >= beneficial_order)
> +                               p = ttm_pool_alloc_page(pool, gfp_flags, order);
>                 }
>                 /* If that fails, lower the order if possible and retry. */
>                 if (!p) {
> 
> 
>> +       }
>>  
>>         if (!ttm_pool_uses_dma_alloc(pool)) {
>>                 p = alloc_pages_node(pool->nid, gfp_flags, order);

