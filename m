Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCCC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F35810FAFD;
	Tue, 15 Sep 2026 08:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cvyd99DW";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B6910FAFC;
 Tue, 15 Sep 2026 08:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViGYC4oHxVYS+uwQoVh8uQKweb02ubEej1+FtwjwdnvIQzD8Mm+ynxMgrqb8u9HBX9YOlNH1Gz9oJ5URXs8BmJYaR6ic7LWDrJAGAdZxlImxC5sEovwyKZNN6zkfUcWwJb6CdfHSUQT1SMLxiZeIG5lpTST6Wf0TMtMg6kKgM6UYteUAaGzUog/mWuszrIttE8q1VvEUPuwt4igrULKCuk3Q/ZIhrzfiENPyzbVIHpNMZ5Aw4XbJB1YMH8BSphSoVfGX6Wy4hrQxDh0Xs/EiqGZ/SfUZXV6QkLzXZteD+qe47ypuXI6/1ZMJd/upA38DAodUNwLFZwnqDoSRbjSghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrxuqL0CtQR2p6ES7p6WGtmqYkmZUvJ0htsK9xZzKiY=;
 b=fg7Qg+I4iqp+o0yLQoc3zSegQDTSFvx6bTckKbpjmr+ER+WIXkIbHbVrDJ/yq1fhXxMamni+26J6G0AF7H+Wd+GtKghTQspMVizupBpD7GnHg9eOvjj2sU8Y8kfJwHRIpOrBKz+CqxHTE3r2nQeOo/COmDH+vsVLGg3m0qJ+VY8rK1le7zGPYVoDKZe1BKkeV0M2Fwcz5+wlAZrxwyp+q0VivYcKpKaLe50KmazfZT2GvMYLq1ZQUgs6SoiuDaUmkqCX8qZvelhML3/M1ESJexqosdZDBDStGjZVXJanKCHdriXbP0ldJ5e5Koh2FdQD0oOLkCoft3HXa60Xb7qz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrxuqL0CtQR2p6ES7p6WGtmqYkmZUvJ0htsK9xZzKiY=;
 b=Cvyd99DWjbiHOxb4m31AfTiZuf2diqovTl6ExCyUfwg7QiTP08ya5GHipZZ8MxuMVIGIg9CQX6siMVW/myOw4egK5nLoy2cPSXGqfY7uDRERzj5uKXyhtO/gk9V5r4s0GzIfEI8fuXSIMNu7438P4DIGJHz837B5wBr0lFdE6AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 08:33:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:33:32 +0000
Message-ID: <9c507259-f65c-4f18-8fc7-8e03de0c4f87@amd.com>
Date: Tue, 15 Sep 2026 10:33:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com,
 Natalie Vock <nat@pixelcluster.dev>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfb816d-f026-4f82-0aac-08df130406b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: JHBxcnxI42rGGqgcRSlq427Lp11/OlFH5j9Ysw5SAPycAFzGYTRvX9BUNy9MEqVFO/g7hcKBAaypqEpWg7W6O+OfO6WkfTRSGZ7nwN9oC+1Xt1qccH5kcMHlU2yLh7J1mbiCAI3OUnsraZlOvUkAOmnxcm+xbBkBxCn8Keaxr4gxYnxp0+83rf4wQtTSezUUd/A4zJ6Fp2H77dQWjQ5KRrj7oXuP3tyPZUr+gvYcMdnd6ompx2MDaShUDD3qBrnxD3iY/ANAE+MMYPLskZpb07xesjkgrIGL3SCt/hYDWKfhxaokmV99qFOC+FUpFaJEkXrh0xoRm8v+S2GUBxvs5e6/+XUqAMU4j4muLqrjhEwRaBshHgzjyXMvpmpH/moG38+0DoRqdd8MiEYxlGzsXF4TQltaNY6tO/soTugoR4NvAdW63PPujx5RKQAn86dCjRSj32Ks2p67g4ScZ/D9herg2NSBFL+HCSTzKrUBlcOxyUx3pW0vnPJxMGmodMIdvW0B3oU1nQUDur/AAMKONi+Tn+1xDf0DUbPj4+XNp/gbp4a2C1eyTYFEKisBS6IiRZ8FZlFodvGE994+kCbTFZ0soR9KivcIC7VURSHOulrF8Vn1GzUEjTC9UYHrcpMxu6b/er43TsHoYP1CMBjIXG3A3EooVnNb171lGP16nys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWs4M1I0TThpWkd0enBmeEJ6OG9hck9OMzhvemQ3NHJ0VDFpb1d1TG5tcmNm?=
 =?utf-8?B?T2o5SlBXdFh4RkloRlJlRkl2SVNUNHE4ekVrNmNPaGY3a0xXUS9ZU1h5d1l0?=
 =?utf-8?B?V1VudHN1NzhhUEJyS2NwY3U0Mmx4aksxSnNDRWlFTnFzd1YzZHBtRldETlJH?=
 =?utf-8?B?SkR3V1RpSEVVdXJFYUhtM2xWbHd1dlZZOVM2bVJZT3Z3cHUyZFBpRGJzTkhC?=
 =?utf-8?B?WFVSRHVkQjBHcFVoWktFVzNlUVNWYU5mejdja3d6NThKaHB6dkJJbUxMYjEz?=
 =?utf-8?B?VUx0bmJJOUZJYU52RWZnT3ludjF2aSthLzJWdnV5M2FpUmhnU0R2TUZTSHhs?=
 =?utf-8?B?V2dJM0xKT2ZVNEp2UzIybHRKQ1pWZlkwVlVNaHRlTUNHQ2VMRkcvR2Z6cUhM?=
 =?utf-8?B?d0E4bEFDZnJHY0xpYkxRbnUzZFV4N3RBN3loN1ZreXFWaFh1cURseVZ6ZFJ6?=
 =?utf-8?B?VzBOMCs3aUV1dHFoR1NMb21BOGdqYTJnaFFMb08xNXRaRHdwaUZFOEpyK045?=
 =?utf-8?B?d3FUR3E3Kzh4cGxxMWVWcFNDeC92Y2dKTUVpMDRoZFBCRVdNYlRXelk2Qlh3?=
 =?utf-8?B?RnJ0b2s1bEw4NE1ETlVzSkp5OXNuUkMyd3RGK1BENDdHck5LU1dVSTQxdlll?=
 =?utf-8?B?ZVVUa1BTSnE4Y2FreER4Z0lHS0RZOG45amNFN3ZTWUE0SXo0NEdaUTlMamRO?=
 =?utf-8?B?Q3A1WHE1MlAzUmhjeXVqeWJEOUNTS2VlOTc2N2UrQlNGbmdwWFdnY1UxU3A5?=
 =?utf-8?B?YytwY1BBeW5wQlE2WU03WEZGRS9WWWZlQkIwS0U2MnJuRW1yd3dDaFRibEVr?=
 =?utf-8?B?aDV5R0NhZmRLS0xiSWRlZHpTTkgzajd0djZXUjdHQVR0RVN4ZzJwVk01Q2RG?=
 =?utf-8?B?TzUwUTlTc05KTWQ4T2pVb3k2b0xBRXB1QTBWczF1QzlKRVlXS0JOTXJKd0pp?=
 =?utf-8?B?REdJRDBFL2svWnBmZkhYL3hJK3Azc0tjcm5uS0J0cGk3TG4xUForRGpkQVlW?=
 =?utf-8?B?NnNWK1dsWTVvWWhOb0dYOU1NOUU5WCs0ejFKU1NlM2lxeWxwNnYwTThIV2hp?=
 =?utf-8?B?VEFkaTVTNEdxb1AvMytVNEdsV0M2TmwwUUVOYU93VldrRTlEQ3F4SVYwMkps?=
 =?utf-8?B?SU1TU3R4YVpBNW5KVWR2WVVneTZHTkprVTgxNU5XYlhoZHd2TzFJVUpPQXpN?=
 =?utf-8?B?ZW9sNWhlN1g2S2NmUzdQVEJsTTR3U1BmK1JzL1NpM0ZWMS9mU1BEcGxtVjNW?=
 =?utf-8?B?blgxTnJINmZpd1RiNnRPeTZkeWF5TzZOYnd4S1hSei9SNktUQ0Y2QWJOVXQv?=
 =?utf-8?B?S1g3WkY1N1F4YkhrUGlpQ3hEQ1ZlRnlJOWNIazVnTGxWV25PY1VqRkVINmd2?=
 =?utf-8?B?VVA4RmpMd2hBRVlyYzlra3g5cWNxanpMWE1OcXFMeUpJMnBnVUwxOVE5dkUx?=
 =?utf-8?B?R1pqcUlLc2ZUUXFyV1R2bUJmZnplN1pIRnhPdDhjWmg4RVZNVWhpaDU5TFFj?=
 =?utf-8?B?UDV3NHVPcVRHamxzcVp6V2lWYVVxTnU1M3o5aGh0MmYwNExtYUplWDdWZ1lo?=
 =?utf-8?B?bXZiNmswandnVW1XWGY0Sys3bFJ6bFBVaUxMVzZIUDQ4V0ZDVXVmZGYyUEJp?=
 =?utf-8?B?T3A3MW82VmltSzhsZzJjTGtjMzg1YXZPQ1dFeC9oNkZmRFdDb0hRYy9tTERy?=
 =?utf-8?B?SzI1SUpxQWx4dWZKQXNjUjRaKzBJazRRR3o0UWVSQmlJbkpEV3prQi9OeGUv?=
 =?utf-8?B?T3J6YjRPbWhQTVBiVFFYandrak5VMnI0YkJvcTBoUVplRWZhVnV5NWdrVWVT?=
 =?utf-8?B?OENZTGR6Tmo3SzNUWjJCNDBxekVaTFh4czgrMjhkblNVVWJQRmtTaUI4SC9i?=
 =?utf-8?B?RE5FMm9Mb3lqMzRwS0xxNEFJemZPK2VNMXNOVlVmbVh3Y1VyRG9KMi9nN0lR?=
 =?utf-8?B?MWZOVUwwUzhhTk9WWUczZ2kvUnZMWEpCMjJROS91UHhQWUxCamJtRXlyUDZI?=
 =?utf-8?B?TFlrVmd3Y1BYRExPU0I1NUY0TisxSndKNXh2S2gwdDdvNmtRR2M1SndRV3Fi?=
 =?utf-8?B?QkgranlPSmp6QnhuZ1R2WUh2V3VxSnlZNFg3SzVRVWxXclFwRzk3ck9FeDho?=
 =?utf-8?B?VFV4c3VqZmN1RGVEaEVTV0hZZkl5NFlWY0RrMjVwY3hRZ1pCNTJHaXlENGE4?=
 =?utf-8?B?MjVqaHp2YVMrOXZjSjhmejNSRVNudWc5QVQvbGVXWTZYcnFOdmxVNWliVHl3?=
 =?utf-8?B?SVV1bnZxMGtIajdxZi9xcGppSDI2WGt4ck8yZGxZWDRraStJQTI2Z0NndkhX?=
 =?utf-8?Q?vo9QBOKSXssEOvOsWH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfb816d-f026-4f82-0aac-08df130406b2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:33:32.4565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djF3+zs68ounlsbHJiBs4K6dzeHEy5PW14+cLvvcajYuCYHzgmACM24t7bUZ/giP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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

On 9/14/26 22:25, Thadeu Lima de Souza Cascardo wrote:
> If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
> the clearing of that mapping will not be attempted again. Later on, when
> an IB tries to read that mapping, the read succeeds, leading to a
> potential info leak, or even data corruption, if it attempts to write to
> it.
> 
> If the mapping is left in the freed list, then clearing will be
> attempted again during amdgpu_cs_ioctl, which will either fail and not
> submit the job or will succeed in clearing the mapping, preventing the
> invalid access.

Same as I replied to oushinnyo <oushinnyo@163.com>, absolutely clear NAK to that.

amdgpu_vm_update_range() can only fail when the device is hot removed and we don't care about clearing page tables in that case.

Regards,
Christian.

> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 09037df76400..5bde36754607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>  	while (!list_empty(&vm->freed)) {
>  		mapping = list_first_entry(&vm->freed,
>  			struct amdgpu_bo_va_mapping, list);
> -		list_del(&mapping->list);
>  
>  		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>  					   &sync, mapping->start, mapping->last,
>  					   0, 0, 0, NULL, NULL, &f);
> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  		if (r) {
>  			dma_fence_put(f);
>  			goto error_free;
>  		}
> +		list_del(&mapping->list);
> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  	}
>  
>  	if (fence && f) {
> 

