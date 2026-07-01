Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E786AC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D52E10E312;
	Wed,  1 Jul 2026 14:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bE2GYUK8";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A7C10E312
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 14:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu0HwMbru5SMBCdv3BvlDGFPiPtV5Dm9alX7eEjSJp2RSHA4Hy8/olRrq8Zbi268VIQiM+B+o+DgyvapFgcj33gqMhSDDZNSm7/A0pnAlp+k3Fa0AmAhEypufrjs8yN0k8wfbOFibYtnVGnhB2qbVatqCBHtM4AXicaCF36yHFTWKSzBqqKFjEnSzmj7w4kDDjgxxpl43oHuqGPQyrbkTS3CgSnmF6cXYFfk5W/QR3WzOBgIIJqDhSKvSsOP/nnhJIEzMB0OVcmyOGxaXRtze/Nrh1KFRpDNZLN1GIGgVGIL+0qpcXCV1lpYxSe1MJdkI5THKnAJ+TyCvMhZEvHC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f5ewQlxMaXp4AdlsCuTVWYG+o7YzBSfaXKPLUfQ9QA=;
 b=Z8zBa3isair+49WvZgc73GSA1YGVdcmAEF4oOpFP0D+L+cTgvIcwB70OYXXConCdJLcNXZiCKlOryjYlr5xXSZA9U82EAIJdv7sGFxip3Ab/mZDfChBByuSzAbGIHBqSqxQNK08Uvqc3EJberoCYnduckCom49q4cCJiHVcVpB5hzfkBS50I7dzs6bpfqIPW0kBbue75RfRNABk0RGJjQmPR8JiOSXsPhSfKtL0pPvKEGboLwVrNRcbqM3d7kBEu5L2ujZxyuoT2rHwQCnFeIFSRg1Ksa52n8phMjgfzuMxOk4a36qfb+21zxMCrTXcJybMAR27Gp4UYU9oU018tMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f5ewQlxMaXp4AdlsCuTVWYG+o7YzBSfaXKPLUfQ9QA=;
 b=bE2GYUK83JV/b2yLB/z5W5sdqELUEs4JrflyF8Pe4woLhCR05hfpXt6SoW1hK3RRWlDkF5g4OKIv1fQp8quayxM8rgnfXMF/92w6VL/na2BhcQGHMONn0iE6SFq/kc9BvAUCIi9mgdh81cuSwpaBhpcTMJbRzZ4IDMucIR7HjG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 14:48:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 14:48:32 +0000
Message-ID: <0d6342b3-799b-47e0-8e8d-f81baaaed8dd@amd.com>
Date: Wed, 1 Jul 2026 16:48:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/syncobj: Use kmalloc_objs for chains
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, tobias.hector@amd.com, jason@jlekstrand.net,
 airlied@redhat.com, chris@chris-wilson.co.uk, david1.zhou@amd.com,
 lionel.g.landwerlin@intel.com
References: <20260701143111.1410442-1-jonathan.cavitt@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701143111.1410442-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ae8b2d-0e0a-42a5-0782-08ded77fd248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ey6dl1hW8SwK3FOXQ35bD4zY629HfrrYNBfYc/kNZdcbd2nf82xER/LrtGC3DSfBHcyvlzDcvXbNuXMlecqw2BSW5/8WUo3a3mLHBkPJrjP4ezUZtOIm9METnJsG7XdXwbhN1dnAN747dnm5Dlou5IsukrqK6MGfjjTM0Qw7QswtjcM4I/Z55l64WgH0zzNWsllPD52pPgZ1qYALt36NfKp/zDUgDIXFem2Fctmo4VwcArbJhgiH22hq9yP7f7nbRdunYwQ3AXdMn3ZVTg1DimSxluFyp8w+QArzb0sPGyV10A7w6Cpb7eHFzLzOqeprA5k7Qx2jzaFLJQzm3f4rnRiRuomopMYPIOd9509Bk+ln9Z7altRvCL0ukYHC0spTAO48qblxu5HnkQEVIuP1kqUgK/S2c35PJcPZJjcnwzXusPx3lrDsebAQxqgdhTjTEOScaKeOU5ESqkfVvwX03yRKS4MThHbJFHmbzygzAwcKcyk90mK8xKs7uPvtq9h2bfI+fYVINRva2HW+cMA885fuVKTF9FYM6gHe0hWWidAWA/kCDXUko0Sw0OwIay7UWuZJi5JPW/X6FriLav0bq0Xub2/TfrSi6HwaLmWik9EnUeqPgwvOvXU7VmJRhdG3ooOzfRhlD6zU/0zCsi+FSYb44lTFgrrT4jbf42wsfdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2REZ055aHcyeWNBOStUSGh4Y3Z1MnZwWEZtVng3b0lFbmNYNS9vOUtmcWts?=
 =?utf-8?B?MWgrSm1mSVp3TWlJKzVLUnM4amZQa01admpBTUkwQkcvM2V3eXdBdkU4Q2o5?=
 =?utf-8?B?UENDb2VJLzlKOUVXTUZQd2owcDY1a3UxMmdwMTEwM0lzelN1c3lPRW55emM2?=
 =?utf-8?B?aTBvR0U4MndId3I1ZkYrL3U2TGp1M3FpT1N6MDZTTVN6K0xpOHdxTjJDK0dV?=
 =?utf-8?B?SCs3MU1tUVFtcFZUZXdTWXpackhJRGREaWZMb0xOcWxsSzhXOU03eFRKc1N1?=
 =?utf-8?B?SVVmR1U0aXl0MG1UbzU0eWVXQUk4Z25uSmlaNnE4NnprUzZ1dWNVam1NMEJw?=
 =?utf-8?B?S1JwTG1nR3JqVzNqbm5kVlM5UjEwWEdjK3c2QUVLVW9ORXpCdWg5L0JUYjh5?=
 =?utf-8?B?RHpWclI5WUNOZ3I0ZytsZ01BazdpQmcyNWlxenVPQUtBTXVsazVnWHlxSUpy?=
 =?utf-8?B?Rk5jV3F0L213ZUYwVHViNitXRXhDNm5nMkxIZDBnNXg2clpnZEFURjhjdlNW?=
 =?utf-8?B?REEyWStDWForTWtDOG1IWUtPL09ONjRsVVlRd1RxUUFRMUt1YnE3ZHg2a21O?=
 =?utf-8?B?OWNlaHB5SkpRZFo5MHJ2MCtvam9XelNuZ1VyNzBUaWRRb2pBVEZaWkpycEdn?=
 =?utf-8?B?Y3pDdnBzK0FVc0pPOGUwdEtqTTVVRlY3ZzRKaGx3WEZ4bmt2VEZTRzc0NzJ4?=
 =?utf-8?B?N29LdnNMVU50OXlFNVI0Vksxcjh5Q3grSXQxVUlZMFlPM0pWMEl2MHVEY0FB?=
 =?utf-8?B?b3NjM3Vza3dZbjA0OGR6VzVsWExyUWtOQTE3VnhTUE5WR3VzVXdCUE5KUzRa?=
 =?utf-8?B?Vm1QK3lobGU1a05YcE1kRUpRRmFQZTAvcHhKcCsvb1pjbHBUUzY5cWxQeGNT?=
 =?utf-8?B?OTdrbGxFQzBoSTRxVi9Sa1UvQ0svUjVpckVqY1hOS2pkUFpCSjRjdlZUOXJa?=
 =?utf-8?B?eExuTEszSEczNXd0VmNpcUtETUtiWE4yZ1RIVi9jblc3bkpuVmZENHJoNzEy?=
 =?utf-8?B?eXZGZG9jWVUvaHhwc1dyTmowSG1PeG5YNHhVeG1pUHlLOTU2ZGR3NTFoUWFx?=
 =?utf-8?B?emZRbkxCaVBKcUFnUFBLRmpiM1ZmbC9LNjBkZnVMc20rRjhhOHhZOEE0SjFU?=
 =?utf-8?B?YnlvNGE5aDQ5d29IZjUxbnV0cUZTb0h5MUF1NkJ6Q2ZJS1RaSFBkQitsUWtq?=
 =?utf-8?B?QTVKNEs4dDdIeXVxSE9ZQmJYMDByLzZiR3hMZFZNbzM3Ym1nQ0VyY3h5eWRJ?=
 =?utf-8?B?bkhYelNuc1MxSEcvZ1B5MFZGb25vWU1VQWpyeWVxVU5XU2dqNU8xUlUvRGE1?=
 =?utf-8?B?M2NnZldVNDlSUmhzSDNnVE5JS0taOU84SUdjSzl5MkUzTmZVWVJ2clRBNDBw?=
 =?utf-8?B?dFBoek5iSXRjQm9xbG1mL2dLS1g4blhMSytpVGRzclZOd0lBNUczaGFwTW5D?=
 =?utf-8?B?WUNjZDBGZkJWc2FUMGVMaFhCRmhmSkxKSHk4Wm9ScWZnc1R0OFcwNTFqWDN4?=
 =?utf-8?B?SFR3U09ycWUvMDRnNXR5WGhKeEEyc1ZvaXlHaTJQY0pSM3RVcVV3SkNZR21S?=
 =?utf-8?B?R01hc095RC9jc2Yya2tWR1QxcE9CMnovZnZQY0JOeEU1WGMyMkZlTzhYMVRx?=
 =?utf-8?B?dUxCbTk0aWxUK3o2U3VMOVh0MEVxd0QxV2E0amtwTGphUTlxNW5HMnJ0UHlt?=
 =?utf-8?B?VTYzSTFmNUFOcS95R0oyTlJZckNkY2Iwdi9Xd1M3UHhYQ2RYb1lNUnRNWnJN?=
 =?utf-8?B?dHMvcUUwdC9NTnc0S0tlYXpzODF6YnJ5WnVHYmRLNWgwSU13UzhSNDVhVUFm?=
 =?utf-8?B?NjArcGpTaUlWcG1YZDBzdGpTSzcrNFp5Vzl3bHJxRzVGR25xbE5nT1F4VWFN?=
 =?utf-8?B?UWRvK1hhelordzNCb05qSFM3emoyaTdIMHM3WjFIbThrM2RvcVNKWGF6czJZ?=
 =?utf-8?B?VjBvOTgwcGxqdkRZajY3UHF6c3c4dWVTeVFWbTlPamlqdUNQc1JmcVJHQ01j?=
 =?utf-8?B?aDl4cUp3b3BReWhDV09Rcm1vb2tmZjYyNmNMdEw0YjBtSGowUXZ6eGZ3QzUy?=
 =?utf-8?B?SWdJZUY5R2lPSUVReVdNZFNhSzdPRlhWaTdCcHpZSndFZ3hZTW1xVnNIU01F?=
 =?utf-8?B?U05FMEpLSytGRG1Gd2QzbTN3a3NtcFF5QTlsSmJrYzhFUmJUOXlYM3k0VTdl?=
 =?utf-8?B?THBqYno4WXZMMEc5QjFyUVVCOWtRcFFzSUZlWnU3L2lwdFMwMEZXMFo4WVpm?=
 =?utf-8?B?REFMaWxyMStoS21SMytXZzhHWTFoTmg1Wmd4MmRseFBhWG0yMzhQUXl2RElv?=
 =?utf-8?Q?nhSPLR1HKTj+SqRLsA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ae8b2d-0e0a-42a5-0782-08ded77fd248
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:48:32.5263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY0oAWAZVuQOkqd3RZ3cJy2YmIrAuMDB9Mld9+uslR3tWLgcxl27wwWmIE18MuKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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



On 7/1/26 16:31, Jonathan Cavitt wrote:
> Use kmalloc_objs instead of kmalloc_array when initializing chains in
> drm_syncobj_timeline_signal_ioctl.
> 
> Concern caught by static analysis.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Tobias Hector <Tobias.Hector@amd.com>
> Cc: Jason Ekstrand <jason@jlekstrand.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Chunming Zhou <david1.zhou@amd.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/drm_syncobj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index c9dbf64c0c9f..2fa170a29a62 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1619,7 +1619,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  		goto err_points;
>  	}
>  
> -	chains = kmalloc_array(args->count_handles, sizeof(void *), GFP_KERNEL);
> +	chains = kmalloc_objs(*chains, args->count_handles, GFP_KERNEL);
>  	if (!chains) {
>  		ret = -ENOMEM;
>  		goto err_points;

