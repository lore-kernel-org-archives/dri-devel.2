Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D67C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681E610E83E;
	Mon, 28 Sep 2026 10:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Bs0LNYE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6527210E816;
 Mon, 28 Sep 2026 10:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUubxGMYpb4gvle04NtRpJyunKxAWRx8yHSSxb7GatHFCBxRk+EZCsBUELIawUax7eNVm8HA6HYwZVDX8hXf4pOmNW7Fot7dlsz35qF1lpr9O4Z7hzcUzdHpJVdccAp9HcDvE9IsumPXuKhXcyZxHrJzbtOTZ/08gX/dspIqTYVc0+QIvY/An8lR+Lc2pTprmTuamhjuyBBNzVY9ztNPZ25TAjdPFmVskTgnp2bWtN30vXn0qoDbyzcCRWpFP+H9E99PAGs6oLotUpztHTjZAuqx0Pkpsoft+eGkl3Pek4Rexv/pnAP0vzFlNCiRQMntsmiKuUmHgd49h14ozticaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=669Ud33NSswgye1cytTVDUyExT2nHB2+p/USLdIk4B0=;
 b=GwZvwnT/ue/1jd0eB0fx/U+8EE4r5GeCSFIOsKXHzIYzga/9AEANAh3iHj33R9p0KMz/zbW8GYDPvTwZ5un0N9ohoUSJbZsie9/3WisH7mCfWNKtehfU3/PqgEmTPg0q1VA5ak7ElC2+ZHveNfmY6UJw9zURyS1NTb5QU1vb6G0rDKvRRgJxGog0D1qd+lPkAxGfi7SCz7KXmxB4yu+DxXoagk6T8sGOmVkZBeKcuaxDE84wNAJKifogAU/o2j+N437lcUaa7C4K3ezZhkUtTaAxb6P0bl+Yd9kcVJ47udoQPYnLpsDtlXoJK1J001cKcjhZ807v/mx1otubNk2Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=669Ud33NSswgye1cytTVDUyExT2nHB2+p/USLdIk4B0=;
 b=4Bs0LNYE+hpA2aZB2/zldjuP6oVjIp4KhKhhdjZz8J3U3IHQc26DjajUii3qe7J56xPOMfX7KqLa9zaf/zXo0qVg24akrUNggoT6AhtEcvpA7pEcBr+8bjpBJJatJF1KFbKslxjOFkEb06zhklp0kDj9Irt4HItbIFfUw+y3Up4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 10:12:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 10:12:30 +0000
Message-ID: <66def337-5237-464d-9361-4d1f9da02f7b@amd.com>
Date: Mon, 28 Sep 2026 12:12:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/sched: keep the current runqueue when no
 scheduler is ready
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Philipp Stanner <phasta@kernel.org>
References: <20260928020018.120503-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928020018.120503-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0454db-b4ad-4cc4-c721-08df1d49015c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gbFC7ey/a5CMSxj4zgyo24sPZkwRsvr6MzovhQAuxIGp5B5/GjR5FsQFgY9hh79R3fNkggnrweBSCJxGXzZWR2T9mtrSOMMkmcNsHCDx5+XiwKrk9As/MxPM43Qf9Pf2WIog6YXiJ/dZzgZ7uQvihCEUSYfDKFlR60RHir+ytyvi9QT1jpnZiKYOAxgiuj0+SWPHwrzzIlu6LsJXpumseBLXT2FUzll3Z0HuctQR3WdVFKWRZ6ZI84obj3IpP10Ur4LZXQ0VoGZnseWsWT0WbwpjywmEyO8pqdfTyml2iGuk39SdRe3dU7yUZ/1niZrvPvbSly7QB8KdMUAedTeNlAT8nvfiAiv5/VOpFCgvvlxYieXNDAPmrVVnz7Zax8S+uuFy/dMR7yFPI2cqHWos8uqBAbGQ+7AAD4RFDTdItGu3IlgtZHePgN3XYp8O9U3BLhpVxSSy0j0HYCSAknmdsKV9UDvBM1eGfaFWUNM4cxhE9kavw+vkBtP4i/8TXItWVIeVQOeXkGul7HNFS5yIsijj42AYE5J3iAwKODZHSU2nCl6qVkiHOMZZixvQERmv51e1Lsb2ZeZkrPVW2T8+gx6m5vWvwKyzfLDhtcFj2LkU1iIeCNLqa2wCEZiJorwacyV3oUuM9iYAd67d2wgKklpW2BPmy9uhKRe0C7Ra/Ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2dFZVBSR3ZYUGtuN204SU9HVmJ1ZmcrbUI3WDlINkVhRGQ3RHZHNmh4UzM5?=
 =?utf-8?B?L3Y2cjBwQ2dtMTBmNTJNTlY0ZktBbEtGVUFuUjAzY3NUYjkvdlJCVVM5bzQr?=
 =?utf-8?B?eUdtK0xISlVFSC82b3VRWHc2MksvQmNOaXFzR1EvV0UvODAvcmlLTFBsMWFD?=
 =?utf-8?B?bnRTd2tOYUR0MWc2SmNiZks2ZHVlYXBJY3o3Z2hvcUJuTzM1U3JDdDRpTG9m?=
 =?utf-8?B?NUhpTnFwZGRyQ0FXYWVMdDl1QTJBaFJlYWs1MzFORlBoUW01N1hSNWtHRkRF?=
 =?utf-8?B?SzR5STlQMi9qa01ZSW12cXhDMlBvNGg3a1BrNUc1UmRyNDE1Wkx6RnhhdGFh?=
 =?utf-8?B?ZGkyL1F6TzZVL2RNS0VZQlR1YnpmdjJuYWFoRXl2dHZLSStTTjBXaytOb3U0?=
 =?utf-8?B?ZEZLUVFZT2FhWmdXeEEvVFpoMkJuNnA2bzhVYjd4dDRwU0E0d2lFS1VaeFFY?=
 =?utf-8?B?YVFzQkJscVZ2eTNFdzFaRFBEMFQvczVwWi9LM1hiREpIc1VhcjllbHAwbkts?=
 =?utf-8?B?MC9FZ2E1aVk1b0tDcUhIRGZRSjBmelVXRmlqc2VLeHVkd203S05EVVI4b3pG?=
 =?utf-8?B?R3FrK1U0YjIzcXNmSHFOMFVTZ3VnNk1mTHNkbENJcEl1S1ZWLyt1dGJNQW1p?=
 =?utf-8?B?TGNZY2JYTlFqaDVrYUFRTjhQL1h2WXZKcnc2cjZNSWtkcmdJSFNSb3QyUHNV?=
 =?utf-8?B?dkd4U3kxWUdOanA1eGRYL0YyOThIbTJrN2dvNEZWMU42MVE1S3FEUHdPNm1u?=
 =?utf-8?B?bTNWeVZQdEtkbUV1RmVObnpPdDZjWU1CdU9nb3NvSjNCVHBvWU95TFZNUUQ4?=
 =?utf-8?B?YzV4M0NuWE9QU1lxRlhnUHgwOEhZb0tySFROejY5azMvcnFQYXBYSlZJY2x2?=
 =?utf-8?B?VUhkdURhelV5cDdtSXFrcnkzYjNZTVRIdHlzdGtOUmcrK1dMQTFwL1Npc0JQ?=
 =?utf-8?B?MjFLN0RiUXpMWlFlOTRreDNERjYwTkZwZ1ZaNGNZWVhiQVpMVmhjdGFyOHZh?=
 =?utf-8?B?dy9oNzh6RlJxeEFBdGUxcWJIMC9UWnpQLzdVWlNCaTVFci9xMEt1L01mS2VD?=
 =?utf-8?B?aW5YM1VxQ3plaXU0VXFFSSt2RS9HZnBEeWFiVTFDVm1GM3FmcFUzRU8wNjBv?=
 =?utf-8?B?VFNNWGtpK0lvcHhoMUZsRWFLTlhCSVRIQkxPSG52L25VODlORTN2Y0VZSEpR?=
 =?utf-8?B?bndIeElOOTBjOXdRaXp6T0kxT0JvU2V1SVd4Sm5TZHFESi94SUpOK2lBS2lx?=
 =?utf-8?B?TzYyTWJwQVI4RXR2ZjYrdzI4QlRzL0U4ZTNjVlJWaE9xNTc4dENvWm5ic1VQ?=
 =?utf-8?B?bWpoTEtyb2FMQm1zUGZuL0I5YWNkcUhVSkJoU3gvck41aXNWR0htMUJib1lE?=
 =?utf-8?B?Qm95cTkyeldNNG4xcjkvcTFWaEU5QU5RcE1kYnlWMzZjcUxya2F5RjI0eGJk?=
 =?utf-8?B?MUQ0cGt5NUFYbnlpWkVsWURLd3BMcWNPRktLZ2VraldMYkxzNXFCa0dQZ29Z?=
 =?utf-8?B?Vk1MSWhsVGdabHJnSW8vbXZpOFErSm4zelV3UTR3ektHYlNTUWRXbUxJdXQz?=
 =?utf-8?B?R0NLYmdEbkYya1AwKzFKaTUyMThQMUtGY3BQTElzTWczV3FkUTg3VktZeWdu?=
 =?utf-8?B?NUU3TjJ6ZGRlQkhOU24vSWNoSTV1SjhoVXRhNmk0QlNsRHZETjFVZGJoczdz?=
 =?utf-8?B?RCtBQ25XNVdrTDd5TVBJNHhvMFBZbHVqOU5GWmlVbEtZMzBJZUJkbkdwN0FK?=
 =?utf-8?B?eTBsUEZOeWczMjE3WG5DVTBQSlNweklkV0gyODVhVzBTV2xQcU9qTDAzSVVa?=
 =?utf-8?B?Wmp6SU9LV2ZUN3hPZEVKWStEbkdEVTFmb25Pc2xUb2JzWHBmOWo5Um9qVUxp?=
 =?utf-8?B?RzhXWlZOQnJoRjA1SCtFcmVLbU1mTXhsYzIyODRJendpQlV2VHRrcENMYXJo?=
 =?utf-8?B?SWpsVGhLeFZ0WUZLZVprOU42R2o4Y0F2TG1zdjNMN1J5aUZEZ3Z0WEpqajg4?=
 =?utf-8?B?TjVHRGhsOFNJU2tRSHNPbUhHUWs1S1orREViWm9mQVVsTFU5YWRxY01NT1cw?=
 =?utf-8?B?N3lmSmdqek1QYmlCQitYclptS1VpQkF2a21mNk1WcHRGS0tJN2NTRlNYUUhl?=
 =?utf-8?B?OTg4ek94THpNMU8wOHlkd2hKT0hkNEpzR0hUS0tVb0NGU00rUmE2SitnMXdF?=
 =?utf-8?B?dXFZSGJPcVFJYlhoUFlIMmx3RVIwdmk3RmEwS0V3TnhZQUthVUFuM1hvaWNP?=
 =?utf-8?B?NlIzdHVueXRKOVlIK0prV29jVENzcDZpTi9MenRpNW10c25uMVA3T1p6YW80?=
 =?utf-8?Q?OiNlGPkSgWfbxWUSHi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0454db-b4ad-4cc4-c721-08df1d49015c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:12:30.4114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SshaBPnoL9LuMMwjiqXZpoa5cKs1wLPDijl+XT56a3ntDke7BsEYLShx8jyOQHHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D
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

On 9/28/26 03:59, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> The IGT amd_dispatch test exposed a NULL pointer dereference in the
> AMDGPU CS submission path when the GPU schedulers were not ready.
> 
> drm_sched_pick_best() returns NULL when every scheduler in an entity's
> list is marked not ready. drm_sched_entity_select_rq() then replaces
> the entity's existing runqueue with NULL.

That is perfectly correct behavior as far as I can see.

The schedulers should only be marked not ready when they are permanently dead and in this case keeping the existing rq doesn't make sense any more either.

> 
> A subsequent drm_sched_job_arm() retains that invalid runqueue.
> When AMDGPU CS submission calls drm_sched_entity_push_job(), the
> scheduler pointer derived from entity->rq is invalid and the access
> to sched->score faults. The reported oops shows the sequence:
> 
>     [drm] scheduler comp_1.1.0 is not ready, skipping
>     [drm] scheduler comp_1.2.0 is not ready, skipping
>     BUG: kernel NULL pointer dereference, address: 0000000000000268
>     RIP: drm_sched_entity_push_job+0x4f/0x2b0 [gpu_sched]
>     Call Trace:
>       amdgpu_cs_ioctl+0x1e9e/0x2530 [amdgpu]

That is clearly a bug in amdgpu. The scheduler behavior here is correct.

Regards,
Christian.

> 
> Keep the previously selected runqueue when no ready replacement is
> found. This prevents scheduler selection from turning a valid entity
> runqueue into NULL; it does not make a stopped scheduler ready or
> guarantee that the submitted job will execute.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Philipp Stanner <phasta@kernel.org>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 4ebb513255ed..b11e1dddabd0 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -584,8 +584,8 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
>  
>  	spin_lock(&entity->lock);
>  	sched = drm_sched_pick_best(entity->sched_list, entity->num_sched_list);
> -	rq = sched ? &sched->rq : NULL;
> -	if (rq != entity->rq) {
> +	if (sched && &sched->rq != entity->rq) {
> +		rq = &sched->rq;
>  		drm_sched_rq_remove_entity(entity->rq, entity);
>  		entity->rq = rq;
>  	}

