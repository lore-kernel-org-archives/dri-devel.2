Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7845610E317;
	Wed,  1 Jul 2026 07:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZKs906k";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6255B10E317
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 07:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRpxScvEi5Ia+gHUg10IchjHmqlzeMbTOwsrAVjuOUNY/vvmT13//0trshLjE6w2l+0M36C3vxaymykLh5Kib/3NCH5154TEb6D8ku9AVlCaY3XHS22FLNBRlK0cGKYf/fPbg7Qm66F3AdITMFUNjFt7EJ2vG2ukj5ctnF6KuAaEkwBVQxA026K1tqPmo2neYJtYyh+y0GuCuuHvpY4VvvYI2PsXEVG/Ai837zT89edkntrl5Z9CeqUbug6bkd8F3xwHKuJlsgAIi5M6k7EAs5VYNy3AcQZ4+KF3zsiOap/qKW7OOgdqmpTGHEbZGTeUrn7c3QLQ3UVnC9wc8eCbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvRqex8vp0Hro8AFJmC12xRjNR0OxyfYPk78dqsWHr4=;
 b=vHl461DchHYn27y9BadFFn6teHrX8d3xk1o8pVouSdi/HdDgtHqkigLoM/rUOm+GRczQSzapCP+dXQO3pS8xJapiFtmYuF+sfH8sdOtuY7ypEJR49t0YQuGQnPCcwukgn7h27EpQXbox1gRXQE/2+dHQrVeZrHtegjcHgeOo3zY6tlLaZCVasonCWlO5z0Yia1rUvy//ztzhPtEzqQIFLStL3t2A9v8kXIK29sBRWUOct9xhV4bODZ6u6RAFkrcViktFgF4AbeZ2DIeq6RpIhnRNfOYnvYzHPGZEO7RPTgvKSyCzUFO6O3UmpGAWH4E0kKkpclT9v2UgO1JAM0NuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvRqex8vp0Hro8AFJmC12xRjNR0OxyfYPk78dqsWHr4=;
 b=wZKs906kSgZ/vdMHIADDtDk5w5aNH9BN5MHnXE7cqQhNeORkzI/b6YnzZe+KO68PR4wNa9p6pcNwppgX97akNGATe+qpNB7o6fSTW3SuHNrIay3Kw63z9qHFxEiCKN/7trRUohKbJHyAzy0UrjpkOwGW231Am6ox8xg9iM9TBqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:23:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 07:23:48 +0000
Message-ID: <71c9a318-47ee-4c3c-b841-26c7b8a9ef4c@amd.com>
Date: Wed, 1 Jul 2026 09:23:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/syncobj: Reformat kmalloc for chains
To: Jonathan Cavitt <jonathan.cavitt@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, tobias.hector@amd.com, jason@jlekstrand.net,
 airlied@redhat.com, chris@chris-wilson.co.uk, david1.zhou@amd.com,
 lionel.g.landwerlin@intel.com
References: <20260630214954.1406447-1-jonathan.cavitt@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260630214954.1406447-1-jonathan.cavitt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 7619a606-9a1c-4a31-5a2f-08ded741b137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PoxG6C5t+z3cjC1WpRSVXOEIKvAcZI12oc+FrDi2uoCemhjYZqM1Dq7ofGJOJnUdd35cpp+bEdeJjZwa+xKeGYPkRsK7+xr9/WYtQaeH1v//QsLCNfLJxQ6mhed/sQ/VINCkhnZ2AFOVudbfq6jysOXjjomrF2xCdX6G22HZYH2Y5CeHG+o1KeR8Nhto67R/4UcwW1G39Zx503LE3hCr3fwwbuIol2ErnLdpILJJB5pwM4vMN1XlguSGJWmHDheKq1FC6ohcB6nEjTG5Nt1bWv4xA2/EVclQURks7lHjJggB35/G4P5PWrAb99PjIsNaggeQvfMO5O92utWwK1FcqJ0mKe6XgYcpAx4lYifMcQ0v8wizI8PfqCPxVTn7UkJfWGpfOmZXKD6V5ow5ERwF/Zwr04eOYVZUVLKu+uOAfjpK+8TtYm9PEJB0HdJuwfgPk5HaFMn2zpaLyVsc3XB6erR6fYl4aznwWbH8zAoUMsn8VBbYLonuC7AEJVfhEalKCqZrFwqcGxVHcawhc/wp2KDYMmDpNHUzW6A9pAk0ALO4w9arN5GtO0Vk11dpXNX84MpocXjmBjS02vOwvFVnJDN9qTbBcfJj/wnzPKP372Rqa0GuZClkhUOtoS29l6vpDsEjj5oNKLmKyh2grAACUBgXamTPJhAGiTlOV48k5UM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE94UXZ3YU9MR0ZKWkRUQTlGbG9nOWlwT3cydm5HeHBWektQU29la2ZxQWdR?=
 =?utf-8?B?SnJjRnNhTnE0dzh6OUFDcjhKekR0cnRWZitROFgybUgreWl3dnVPVCsrRjlQ?=
 =?utf-8?B?Y1V2Z2NycFdQcGFnZ243eXNlVUN5Q1g4M2lXZUoreFpvYks1U05oaVhVeWtt?=
 =?utf-8?B?SW9CZjh4cVMxb0RSb0JDU25pY2xOUTBjelUrRGw1ZWlsUGZCbU9WSGkzWXgr?=
 =?utf-8?B?a0tvdWEwZGkzUTRYQ0ZQRlZUdUEyMFVwWmtBY3FEbmtMN0gza1FKRUFGeU9r?=
 =?utf-8?B?YVczQU1nR2NWZjh5QW1kMGx3Nlp5NXhzc3pkL3NWYlkzTm5hUUFyejlkMmN6?=
 =?utf-8?B?OXJhY05oT3hjaUpUQzBZcGEvbW1IMVBUYnNvQWNuWFYzbFJwOVVDV1JVQkZw?=
 =?utf-8?B?TUhOa2htaFlHUEIrMTNBbUNwTDRqR1dpa0h4YVNHS2dXUDhPNHdqOFRmVUpx?=
 =?utf-8?B?SXA5TU9yanBvOEVHYS9KTS8yNWtVajM1b28wN3RxQ2ZwQ2RFdCt1WDNpazhK?=
 =?utf-8?B?a05EeDZIUEE1WExkKzk2KzFveFlucXN5UDNwbk03WGsxMDA3RjJubTg5NTRL?=
 =?utf-8?B?Znhyd2V3dWpiYnFub2xmdGNib2VrWVoyRzJBUXRkSHNrUEFlK0hZd1hvUDk5?=
 =?utf-8?B?eEVWcS9hdGJRcjdaTjJKTkJ0K05zaWg3K1RYS0VyQVJkdko1VHFuQUMwKzht?=
 =?utf-8?B?K0NaQVhzUG9rNUYyREwyYkZBbzloRXBoU3FmMy9yaTV2QWJDSWNEQ2FQWlRk?=
 =?utf-8?B?UUVaVWhOcWxOdGZEcW04Y05TTDI0M2F2TjVCM0p0ZHo1VDJCcEc0UTdFQksx?=
 =?utf-8?B?RGhrblhocXJsb3FSTW43eXhYREx2dURmU3lpTHdMajJmWW1QTHg2dkhnSVRF?=
 =?utf-8?B?b092aDFEd1VyZFdtWTFtaTZ5VWRibVZjSzd5eWM3UC9EMm1EcUxhUER1TEFt?=
 =?utf-8?B?NGNiSnVPcEowVXhCRk9VWWdkOGFuanVNZEE0MTVCNmNVMVk5M1BuRlBVaUFG?=
 =?utf-8?B?TmFmbk1aSk4rcWVham1GbU5TbG5XRWRFRkZVNUpGSkxrTmVjNzdvY3UyTjdn?=
 =?utf-8?B?blN0SzNUTUk1MVNZZlpzTGRPVGZ0a3BTQ2hsNHFCQUZuWXovWm1xdHduV0U3?=
 =?utf-8?B?Y2dETUZqc1F6YjcvS05Nb1FwSDFSaTVFRjBMM1pJSm5FMmx4Ym1BT2ticC9a?=
 =?utf-8?B?S1lvQ1E0WWd2aWxtbXdCMEpvZEZ3aG9rWHRiM0hic0w5Q3ViT05HNUZXSEV3?=
 =?utf-8?B?SDZTdENDejF3MzZPYXF0UytHV1NQd2NId0pWZFI0YS8zWjkzSVQ2UFRUZTZX?=
 =?utf-8?B?N1NJY3dQNFR5ZGdJYTd0VkxMVFBKZ0JGdW5OdVpTUXZxR2V5aWRRZTFiZ2Rm?=
 =?utf-8?B?MHRLVkt0U2ZhbTJmUFhPL003R21CV1lGT084Q2Y5cGx1bXhRQTJHdTRyT0Zv?=
 =?utf-8?B?VzZLNS9pVHlTQkRBcnVIaXpjcDZXYWJlRjFPeGNYRmRxNjkxaWRqQUVramo3?=
 =?utf-8?B?SUxlOWk4VUx6Z2ZIUHNOVlVMdWdDUnBaZ3lOaU1zSE9tS3NCTmEzN09zUndD?=
 =?utf-8?B?aWRieEwvdmdxa1FWUVlmcU8wZkxzY2N3dnVIdlE5dGZ1WEZUQlVxRFZvZWIz?=
 =?utf-8?B?emhiVDUvVitNc242ZmhHZkpIaEdLL05YcW9HRTlVZ0xSaWRxeG9jdUUvcTR0?=
 =?utf-8?B?cWd3eG9SbkdZTnFoWm5HaHJCU1BBSFFRR1AyQTNQTE9VcTBuK2JlTjdialNO?=
 =?utf-8?B?U3oyc096d0ZDUFdCc1Y4WHJJbFkyVkFybElaN0hKS2w2dlI1SmNnczVIY0N4?=
 =?utf-8?B?akJ0QTZ4OVl5MWpnUkwyUlVRLzc1aHo0N0pFTmtqcU9FbFJQUEMzdUlNNWVB?=
 =?utf-8?B?MXNjUkdZVjFaNDduSyt5SWQzU1lobHNZbHRhQzNWUlBSRnJJbUNHTnVlRDRP?=
 =?utf-8?B?K0wramdONDVwL09zeUthQXpTZHpKR0ZnaUcvVzNmUkVxSVQrNFRlVXQyZUZw?=
 =?utf-8?B?U1RsRDBEdWhLU3dVT0NEdDI3NnJlUFZKLzk1aDR5bG80ZGtJVUIzc0lKREU5?=
 =?utf-8?B?KzNPakFKQVZDNzMxejRwTzdXNkx5OElVOEhrb3lGd01HZjR5dzNTMk5tRUxH?=
 =?utf-8?B?d2tybVp5OFh1Ull6QjlGVE5RNmJvUkQxS2tmRkt3ait0b1pJZmpGVndwMmRz?=
 =?utf-8?B?MEg2SC83TnEzRURjMDNtejFQdzhmYmpVR09ROEczdVh5OVlXT2NjRGpSdkU5?=
 =?utf-8?B?cjJMRXdycXdzZXU3M3I5LzJUY3RmL1JjcWo2TzdTK1pISTFHZkF3OEZGdHlL?=
 =?utf-8?Q?v0FW/EFDk0Ec6/rK2z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7619a606-9a1c-4a31-5a2f-08ded741b137
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:23:48.1571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjd+zNukrl/ZDord8ZOjKwUVA3GMvKUFZfk8Vg9vDBboZNE/Rib75u80AqvbDdKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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

On 6/30/26 23:49, Jonathan Cavitt wrote:
> We should use sizeof(*chains) instead of sizeof(void *) when performing
> the kmalloc for chains in drm_syncobj_timeline_signal_ioctl,
> stylistically speaking.  Also, wrap the line to match how the variable
> points is allocated.
> 
> Concern caught by static analysis.
> 
> Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
> Cc: Tobias Hector <Tobias.Hector@amd.com>
> Cc: Jason Ekstrand <jason@jlekstrand.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Chunming Zhou <david1.zhou@amd.com>
> Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index c9dbf64c0c9f..d4c5b97403ee 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1619,7 +1619,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  		goto err_points;
>  	}
>  
> -	chains = kmalloc_array(args->count_handles, sizeof(void *), GFP_KERNEL);
> +	chains = kmalloc_array(args->count_handles, sizeof(*chains),
> +			       GFP_KERNEL);

We should probably use kmalloc_objs() instead here.

Regards,
Christian.


>  	if (!chains) {
>  		ret = -ENOMEM;
>  		goto err_points;

