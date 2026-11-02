Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10821606DE82
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tQqpJ+h5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED52D10F01F;
	Mon,  2 Nov 2026 15:45:01 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAE5A10F015;
 Mon,  2 Nov 2026 15:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkWJGP3WG5Ot2liWeFpq2RrX27bUBJthyqvFoI+8SMu8pg4r+5LG76+7at5C71KJ9zP8nwQp9sBP8aamr5E5qYmJEj0H2rD3W8eELcH8jXGgd28BzP/4RnUtAUAXQm5Jcq6KbkmuJ+Vt+hlalT1h/TFCi+IuzhvA3bwGY7xS/Hs5fGjdQAdxmLRMJoelkgw1/N4Q8ZAgDkYjCj8k459H1cRB68RKRypx0b2emwKwhg/vt2fVfHBLkePJzAXu/5KVosTy89Cj28omKkbFfe/djhY+cfCcgKeZ2jPSMpwB6HyB4wvPF6xFXlLv8Eq8kQ342RLVTIK+Airzz97oFSWK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2vskZVrRT2Sr/MQJ84kEYXVZRCD9WXu2rQ7RBiiXEQ=;
 b=YgeRccgBfCUDUVdAEWKkdgfAGWGd9xHgVGKogJQKmLQG0kLx+E3+aVRRdRTfM5NOU0ZJ2oBrjoyDw5LAaZlF1moPcYe7c8rok5PoU495vZjYGW1PZ8We9aMjMa3uDGAwjQ0iIafxN4PZItvcYiweozHVC1xMfywS1qhoRL1B9Oi9+c315AVdKgVHgaQT+YclJliiJR7a8YGUECgqAijqOomdEokctLzoWPAFKRqlWKWCpDMpg7jhxxxxpfHYkG4qF8DrfVh06vLE8FNCb4wHF6J2QE+NYCGBsNq0/1H5vZJAR00HnPZmgxdvqGzt2eUWla2OQlvGzN1/J+ezvOzqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2vskZVrRT2Sr/MQJ84kEYXVZRCD9WXu2rQ7RBiiXEQ=;
 b=tQqpJ+h5Mpvd5hjCMlbkatHvEdx6rMudyzvdndhzOHAplV5Na52ckUyesNsdZUYdutKRkOfJS7DS4qMmNlAYwl/jmpxro4IjUD4tQK0/iiGDXS7rsuvUvy0wzkLIBNpf/iP2lXKjKlxsXs3z4w6gyHMV+Vn/NbWgj/JxcHIhQ28=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:44:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:44:52 +0000
Message-ID: <0c8f89c5-b02b-491b-99a5-f881ea82a804@amd.com>
Date: Mon, 2 Nov 2026 16:44:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: add wedge event implementation
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029152000.22001-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb6cf61-0630-4fe3-a4d9-08df38f83bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|4143699003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261009221227099003|261009223027099003|261028144727099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: dsbcli2N9+maDsT4UYETgPU9RJpdq4u+Tf2sod3K1W004JIh89ayHYS7ceRaWKkpqZOEZIsuQ3BKEZ07mYhzq0dkx84tWEdYlPeiZLXI3jfv2L0CsxeI9AL7JGP5vZNhCavbNp53adqzJ5UL8+R/wotDZOZAEjxf0jlsrEdqwcrkGjGHzpJl93PIdscJajLNBlJ5qRNo0lMUXE0JFxbhEU2zQMUfMyeiiY8szQgbepx8DLY9ZVq1NA6K9EFatj9aXVqUQLN6oynLpIMutYulATyS0PqUPOv020nKHbS7Yc0XNZoHfPeMO+3fDcj7w1tKNHoogC22BQBJLrevSNRqWeKaKgNsFy8a/Spg2F5jCFtb9k/Rv2k6b3DliEB8DohYJY7AgDrlCNds0Vw6uJeCeeLtwVauk0755B0f2b9twl2sj+Z56OaCeYI0eLTGNfmweAOeqWZiEPpOqe3kBRXx+GWVQOsEy1kA/KlU6cdosbKtSYICtNAgaIm16CtqkbC+xHZ/QheUPKzcwrTQuub7gULdSvsLD2rUvITgbqFRTgln4e7t1VpOdhScfWlH1A03h+7cQA5QjoCCs2gppJnIurb5QvDGyYwmSZxm/P9pXNVlfWPYpxbopghDIDotAIBZ+QoOCXgf5/ZoyvDDdsDhzR/xrZHDVEaPhUvZufi89KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009221227099003)(261009223027099003)(261028144727099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzlqSUJPalJOK3BjU2RSNy9TUEVtZC9jQ2VaaVFHY25OdloxUHRlYktQd1Vn?=
 =?utf-8?B?S1lpUytOeWh1OGpmUXd5a2RwM0hxaUtNelBRcURIcFQ0Z0duOGpHVFNlZzNk?=
 =?utf-8?B?ODE1VU8wWlZCZ2VsbmN0Y054dXF3TExsWVp0dkhTcFRSd3l0RTVrWlZMN0Ev?=
 =?utf-8?B?ZjZpbGQwb0x6Y2gzWllKRkVya2tmeHMrbDdSZXdub21uVVBaQ0pteHh1RHlw?=
 =?utf-8?B?Z3Q2SEZuMVFPcFdKeWgwbWZvc2RFWXJGUU5UY1RaVVRVQjFsUGk0TlRpYjl6?=
 =?utf-8?B?amZMSlhYYmZXcXk3QnYva3FjSVU0OXd3RmszRGExcXlzSUw4a2JCVlJwTU9J?=
 =?utf-8?B?VnBFeElsZW1xY28zRDJ4eWo2TTV3Q3IyanNCRU5CQkJickp0Qm9yaGFDc1Nk?=
 =?utf-8?B?S2I5SlpkZ3BBT1FKTmNBU3J3U0VOTzBWRXdnL3FZS1FsVDZCNXVpcVN6Mm5a?=
 =?utf-8?B?TFVhek9NRk5VczZvdmlhbzlBbGs3UWtVQUwydzZXSFNjQXRya1AxVkNsUTJQ?=
 =?utf-8?B?SDBWKzZVQ01BcjNIZjE1T25sZWluM0Fsc3VvVGJXdEMzZHdkQlNLcDk2YnNh?=
 =?utf-8?B?T2F3Ym16ajFCY0pCWVpoMFl0cTNwLytnVmxlSFZZZ09rRENGa2ZYa1JzK1VE?=
 =?utf-8?B?bEZFTDcxY0lGN2lqTXBxODN0azNVdWhsNHRwa2FZR0pCRTFob1hhaE9WQTdD?=
 =?utf-8?B?VjlFK1pOWko0VTlxQ3lJSE5GUDN2c2NVelFzTnpob2VBdm1BYUZISGZkb0RM?=
 =?utf-8?B?V2RiZEJ0dWJ0ZldrS2dISG9CZTVWNVJEdVVpK0w2SS9HYXN3LzNzaWJVQTYw?=
 =?utf-8?B?d3d0L0dlZ1NOK2ZXenFnSUZXN0xQSXVhalBWcXE1aUdIaXdxNXpxSHFqTzhu?=
 =?utf-8?B?SGwvZjgrUjNBaDlnSG5oZVM3MWdSeEtzeUlhWk1FWGNwN2N5LzNIeXBtODYz?=
 =?utf-8?B?dWRZNmZTV3o4UDJwNGhqbldvaG1DTmRJNEpTdmFXa0FuaXpNSm9nR0cwdWZG?=
 =?utf-8?B?TTVBTGNxb0xXd0VFK3Qzd0VGUlE1N3dPaGRvQjliWlF5UDk2L1hic1JBZzJK?=
 =?utf-8?B?UkNzekF4cWxBdzQ2YzdubWlUdFNpUzV5U2dmdnNYYmdzUnFiaU85OFVhaG5Y?=
 =?utf-8?B?c0VmRkJ5eEZPdUdCWUhPOC93NHNYOUFiV2hhOHJ6SlVpNStpT3ZFeWJBd3Ez?=
 =?utf-8?B?eFJ4RHF0MWpieEd4Qm1zNk9mQ09LdFZxQ050emUwTElXYWgyWFdNZVZ2L0hT?=
 =?utf-8?B?aStwZVlweThwWnlIcUFnRERCby9yRUVzNURMWkdJUVJmei9Bb1EwU0pCeFlL?=
 =?utf-8?B?NzFYakptOUtCbUdFNHB0OG82WGJQb2F0UjhNaGlzKzBkQjgvS3BSelR1MzRq?=
 =?utf-8?B?cXRJWFZ5cTdvVXhTeFpZb01pUnFsTHFyZzk5UUVldDFzc003aGVvVENDUkMw?=
 =?utf-8?B?SG9zZ3dxWkt2WWhRaGp0YXIwS0t1MmVBV1d6NnliSWV0TnhSWk9rL3NzNm00?=
 =?utf-8?B?NmVBS3FsS2l5RHdjZitnYUMrREdlOTJFWHlqR0Y1NkxBcldPYmRXYWlDNVZT?=
 =?utf-8?B?U0VlU0RIc21MdFhteGp4NUQ0SUNTUlBabGtHek5obWF1eENXUUJZbVlUNzdN?=
 =?utf-8?B?Yjd3Z3NCOGJFWWVvQkhXamZrWXBiVW41dzduNExxZis1dGpTcXcvSHdSSkk4?=
 =?utf-8?B?bUQ4R3RiOXdpblZhRVFBdjltZWNSNGFjbXdtOFNNZ3pFOVF6RHJPeGFpOTlV?=
 =?utf-8?B?L2dHcFVla2pwU2JqdWF1bHhFdXBiUzRhemRhWWIrcTh1Z0dtUitMZzM3Yld4?=
 =?utf-8?B?UVE2dkFxWUpQRHZ0WnZacVg1Uy95RThlODlmMm95WHRmTjJUVERIN0tkVXha?=
 =?utf-8?B?RTZtL0wycCt6ZWorUzczZmlaRGhqQ3FjUEtFbDBmMDhJQkp3T3lVQmNqU1Nn?=
 =?utf-8?B?RWhDeHRMN2ZKTWNjUDRLRWlRVlhOdmFZNEdNeGZHYUgxdVYyMWdaMjc3Y0lQ?=
 =?utf-8?B?dHVOU1NOeHBHS20zMG1MYVV3WG5pMVVFVGhSMVJyZ0dpU21tOHY3TFk3cmJv?=
 =?utf-8?B?ZlRNc3dNcTd4ekxHM1F1Z3JuQVVFNElqSkM0aXh1OHhxVWlQQ2dwVUFhUlpw?=
 =?utf-8?B?Nyt0c0xlTHdWcWp3Qm04eUVyVXBaS2ZEQmNVUHJaREZmSFhuN2pUSTlSOGVz?=
 =?utf-8?B?NTFDSDBncHg5YVZYTk12KytFYkNCUGx1Z0RsbzhWVldPQ2JrL2tQVC9oYXdx?=
 =?utf-8?B?WnJmcHd1SGY2MWgra2V3SDZXWG5wTVhnUnpPVmdQb2JERWdKamJSSHBYVmFp?=
 =?utf-8?Q?UHsN+O1mP79uFW4/lo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb6cf61-0630-4fe3-a4d9-08df38f83bd7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:44:52.0277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKQQGKjat5NwwIWoTsdEBLS+up9CeGKaytwS/R2InSCKrLNs6/xKTKeAY5h2qhIy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 16:19, Pierre-Eric Pelloux-Prayer wrote:
> When a job times out the kernel tries to reset the GPU to get
> the system back to a normal state.
> Sometimes it's useful to disable this process - for instance to
> be able to inspect the hardware state at the time of the hang.
> Since leaving fence unsignalled might affect the system's
> stability, this commit enables the drm wedge framework for amdgpu.
> 
> When a hang condition is detected, the GPU isn't reset but all
> the pending fences are signalled and the hung GPU cannot receive
> new work. For KFD it's implemented by making
> kfd_process_device_data_by_id return NULL if the requested GPU
> is wedged.
> 
> When the user is done, it's possible to trigger a GPU
> reset.
> 
> The auto-recovery is still enabled by default, and to use this
> feature one has to either:
> * boot with amdgpu.gpu_recovery=0: not recommended as it disables
>   recovery for all GPUs
> * write 0 to /sys/kernel/debug/dri/X/amdgpu_gpu_recover to disable
>   auto-recovery for one GPU only
> 
> Runtime power management is disabled when the device is wedged
> (because we can't submit any work to the GPU).
> 
> Assisted-by: LLM
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Looks mostly reasonable to me. 

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  8 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 34 ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 12 ++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  6 +++-
>  8 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 34bbb30b6f0c..cd4959486c94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -989,6 +989,13 @@ struct amdgpu_device {
>  	 */
>  	bool gpu_recovery_enabled;
>  
> +	/* Set to 1 when the device has been declared wedged following a
> +	 * hang: it no longer accepts new work and pending fences have been
> +	 * force-signalled. Reset to 0 once the device is reset back to a
> +	 * working state.
> +	 */
> +	atomic_t wedge_status;
> +
>  	/* KFD
>  	 * Must be last --ends in a flexible-array member.
>  	 */
> @@ -1374,4 +1381,10 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
>  			   uint64_t uid);
>  uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
>  			       enum amdgpu_uid_type type, uint8_t inst);
> +
> +static inline bool amdgpu_device_is_wedged(struct amdgpu_device *adev)
> +{
> +	return atomic_read(&adev->wedge_status);
> +}
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fa301c71b782..d119de477284 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1465,6 +1465,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  	if (!adev->accel_working)
>  		return -EBUSY;
>  
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +
>  	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>  
>  	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ec2514079919..641b7fe24951 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4110,6 +4110,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	}
>  
>  	adev->gpu_recovery_enabled = true;
> +	atomic_set(&adev->wedge_status, 0);
>  
>  fence_driver_init:
>  	/* Fence driver */
> @@ -4362,6 +4363,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  		amdgpu_sync_free(&adev->isolation[i].prev);
>  	}
>  
> +	if (atomic_xchg(&adev->wedge_status, 0))
> +		pm_runtime_put_autosuspend(adev->dev);
> +
>  	amdgpu_reset_fini(adev);
>  
>  	/* free i2c buses */
> @@ -5155,6 +5159,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  	r = 0;
>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>  		amdgpu_set_init_level(tmp_adev, init_level);
> +
> +		if (atomic_xchg(&tmp_adev->wedge_status, 0))
> +			pm_runtime_put_autosuspend(tmp_adev->dev);
> +
>  		if (full_reset) {
>  			/* post card */
>  			amdgpu_reset_set_dpc_status(tmp_adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index fb60a99f43c1..617d4eec4e26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -459,6 +459,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>  	uint32_t handle, initial_domain;
>  	int r;
>  
> +	if (amdgpu_device_is_wedged(adev))
> +		return -ENODEV;
> +
>  	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>  
>  	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> @@ -961,6 +964,11 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		abo = NULL;
>  	}
>  
> +	if (amdgpu_device_is_wedged(adev)) {
> +		r = -ENODEV;
> +		goto error_put_gobj;
> +	}
> +
>  	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, lock);
>  
>  	r = PM_RUNTIME_ACQUIRE_ERR(&lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 4204c3c750a8..53fa9fa83ae7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -730,6 +730,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	struct amdgpu_job *job;
>  	int r;
>  
> +	if (amdgpu_device_is_wedged(adev))
> +		return;
> +
>  	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
>  
>  	if (!hub->sdma_invalidation_workaround || vmid ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 0b8d0a79dd45..f72c9c690c3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -24,6 +24,7 @@
>  #include <linux/kthread.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <drm/drm_drv.h>
>  
> @@ -185,9 +186,35 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		if (r)
>  			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
>  	} else {
> -		drm_sched_suspend_timeout(&ring->sched);
> -		if (amdgpu_sriov_vf(adev))
> +		if (amdgpu_sriov_vf(adev)) {
> +			drm_sched_suspend_timeout(&ring->sched);
>  			adev->virt.tdr_debug = true;

I think we should just completely drop the tdr_debug approach from the VF handling under SRIOV.

The wedge event approach should be completely sufficient to handle all of that.

Regards,
Christian.

> +		} else {
> +			struct drm_gpu_scheduler *sched;
> +			struct amdgpu_fence *guilty_fence;
> +
> +			/* Declare the device as wedged if it's not already. */
> +			if (!atomic_xchg(&adev->wedge_status, 1)) {
> +				/* This ref will be dropped in amdgpu_device_reinit_after_reset. */
> +				pm_runtime_get_noresume(adev->dev);
> +
> +				pci_clear_master(adev->pdev);
> +
> +				drm_dev_wedged_event(&adev->ddev, DRM_WEDGE_RECOVERY_REBIND, info);
> +			}
> +
> +			guilty_fence = to_amdgpu_job(s_job)->hw_fence;
> +
> +			sched = &ring->sched;
> +
> +			/* Prevent anybody else from touching the ring buffer. */
> +			drm_sched_wqueue_stop(sched);
> +
> +			amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
> +
> +			/* Start the scheduler again */
> +			drm_sched_wqueue_start(sched);
> +		}
>  	}
>  
>  exit:
> @@ -439,7 +466,8 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>  
>  	/* Skip job if VRAM is lost and never resubmit gangs */
>  	if (job->generation != amdgpu_vm_generation(adev, job->vm) ||
> -	    (job->job_run_counter && job->gang_submit))
> +	    (job->job_run_counter && job->gang_submit) ||
> +	    amdgpu_device_is_wedged(adev))
>  		dma_fence_set_error(finished, -ECANCELED);
>  
>  	if (finished->error < 0) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 14a72a406d37..2393cad36ac0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -781,6 +781,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>  	}
>  	case AMDGPU_INFO_TIMESTAMP: {
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>  		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>  
>  		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> @@ -913,6 +916,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		if (info->read_mmr_reg.count > 128)
>  			return -EINVAL;
>  
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>  		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>  
>  		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> @@ -953,6 +959,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		uint64_t vm_size;
>  		uint32_t pcie_gen_mask, pcie_width_mask;
>  
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>  		/* The clock limits are only available while the SMU is up. */
>  		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>  
> @@ -1187,6 +1196,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		}
>  	}
>  	case AMDGPU_INFO_SENSOR: {
> +		if (amdgpu_device_is_wedged(adev))
> +			return -ENODEV;
> +
>  		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev->dev, pm);
>  
>  		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index ac18c2be6ecb..b95dddeaccc5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -2424,8 +2424,12 @@ struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p,
>  		for (i = 0; i < p->n_pdds; i++) {
>  			struct kfd_process_device *pdd = p->pdds[i];
>  
> -			if (pdd->user_gpu_id == gpu_id)
> +			if (pdd->user_gpu_id == gpu_id) {
> +				if (amdgpu_device_is_wedged(pdd->dev->adev))
> +					return NULL;
> +
>  				return pdd;
> +			}
>  		}
>  	}
>  	return NULL;

