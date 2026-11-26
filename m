Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835D606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sf1zwEvW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 468D410F2D4;
	Thu, 26 Nov 2026 12:12:02 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B86010F2D4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWYcVs3F/cay4kKOnQ7CWAOR1EAfs3G8A94MoifZ2CwUEpzMoUe6NgkEj+BphPFheFKuggCW0H5K/EtCYl7p737i1Gc+ANY4z3DEQpaEBmMw4ZTNI0SEgZ8Tz72iBqpEkP8ansugocMliTdAkvy4Bwq6KL4PUvCaPSBaA6MH3p9HoYpap02t3Rsu/dbAHHOteW/SYmbv4tQNlo0oO0HODYkaqy9q1Swc70ySc0IpNqjZLzqZ2GOo5zQ6KSsRs6Ts8tou0ud9BURvid75T2Bs9DMofJA84DGJbmEvjtqb6FDDLgyUqIcDhUZLvl82+q0hIEgGDgbANF6Bms0705VmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXsT6bbhtrvyV45DIU6yxmK8klos2DOw8lEd6Kpkcu4=;
 b=I52GyGzX36b2k8+XlqHKa1vo0bubCHCREYPLbmlY+riNmiUPfeEPN0Oyzm3lEG7SaGHUoms7tTNMiE8Io/scfXi+mSZx5uhGiGPpQJFAeW6r4/xef4ZsafUG/iteRwRW3SlEa0gkKVSfH55EoXkmauxaor2tzfNjcSTxgvmMIgTu4Qs71HSADLyZnfPlwuDxBDrLm0AdjM9NZ0AEkcBh6J1XkAjBVCNy0AlfOZoJ7BUoNHXwKLmY+KbvAHoWN9ffFrVK+IClm/5ZQGU59HPlAlCtV7vXT3SK7Is3WmC1aUKLK8a4jJhz2aKb9J2FszQDQ8E0hK6zg+Zz2B9KLb7TeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXsT6bbhtrvyV45DIU6yxmK8klos2DOw8lEd6Kpkcu4=;
 b=sf1zwEvWRRhP35Y0tgYZShvxd8ZPLBQ+YD4xEpJJ+g2dr2iu5rF9E97mEdC4Zp0YHG06GkjGxsklna90/TVZTK3JZXKE84Q/h91DRfyOl35EHxL84NGhVoAW2Lg9SFTNNtGAWqNCUY2Vcqs6J/78/eRq5geLr26dO3Qe3zAbiHE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 12:11:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:11:50 +0000
Message-ID: <6724627c-d211-44be-98d5-4ded6b663483@amd.com>
Date: Thu, 26 Nov 2026 13:11:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout syncobjs
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-4-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126111117.67342-4-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0536.namprd03.prod.outlook.com
 (2603:10b6:408:131::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 653f5888-f81b-416c-1bfc-08df4bb673b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|6133799003|261009223027099003|261009221227099003|22082099003|18002099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: PTScjc7NDS8u8FIO4wVvlHyBgM0bpVuO9/kcMpbWRq+2SV2JNgvQgGQGR/jYfRMVLDxz6vh5WOyWT+cLwiSGw5Fkvxn4drkiAYkiLbjqUgBAxnpSX83edCVD4CK6xWwiFLZVr72jtjITtKuOLTn4DkBp8T+drtaETqtTcghnbwuQIIz8s0oaSlR92kkds8CVEwwz3QehI4JW02Yowq7/Ys3+1m9knSQ6cRWD5CUPPU1gFIZ8J+hO+O8PGTxWC2iifmJ6LOCvr9iBuzzPJFzkkAxb9o/xvXNvScYkopOGjhwL9s4erKsrQUyXV31A41eEvNQ6ig9+krYNdxHeayuT5PeIMWHHozcxuERexmkCQ/15764OCB8bXjCO6JqF3JyZWDmMwPLBcOmPyxUI4fEx+xzmsQNY0aDKncldU7C8t2FoVkiBTsRhqpxTBftTNPyYfzuOh99cOtMdmJ0hRN/KncDnEBGnb4Z7ZJDHWVMynwxkhY7tJ/t3p0y4NcG1y+rUMazUQY/WBvaZqG74M8yCFFqqFwjd+ZcIJ0ZojKqP1EbQvcs5CS7m080b4r0Vq3SRZFHcw/HiESSU9+9RYprC8MDPAuNKKJI9lZveCrv/wETGbKr25PaJJqjp50NIJbKv+VQ42GULBSDtAB1plmAZ4MJaMG9JJA4LE70zzh3p5fo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(6133799003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJpY2FWTGF3eitNVkk3NWxLNWN1SlZTczZtRThJZmpKUGUvV01HLzNkTHQ4?=
 =?utf-8?B?Nm5ZamRxbFRFZkluOG5ibURaajhCTEFEdGd2bVN5SzYraDh3RXU0dzhzbmNR?=
 =?utf-8?B?QzFMeThzUlJ6dmtEQUZQZmsrLzVMSzVKcE5TZ3hGT1FtVnpmdVVNdnJrczRC?=
 =?utf-8?B?eXFGMW45ZGcvTFBtajAwWlpuNytBYmI2czBITkNvMmRqOGZqeURKbkUyVEFR?=
 =?utf-8?B?SzhQdk5KbndCa0hxb0ozWGdUWVBtMEVDMDdaSTlQVEljaEQzdnFVaFJkbURv?=
 =?utf-8?B?RmpnamR2MklTeU1kRFV0czVoMXF0UWR3SWdDbHlGOEJORGZXdG9NZjdVbEh4?=
 =?utf-8?B?aUNDOUZaanhjdkpoa0Q0d0tNSlpGWU1aQmlRWnF2d0dDT09ad09wT3FnVUxw?=
 =?utf-8?B?c2Rya1owOHlod0pDSjMzOHRnTU5wb0dzSGlSbGc5cFFsUjBzNHRDVUkwRXNY?=
 =?utf-8?B?Lyt5b1ZKclZnSW1NMHFvdXRJd0MrbU1Cc3czL0RVbmhHNHZSbGxXYW9aMmhD?=
 =?utf-8?B?VzczOFp3M2J5STUyUzRWTDk5d2NpcnNCL0Y0ZTRJRTdHVk9FSGcvM1BadmNr?=
 =?utf-8?B?Y2pnWWdqeEZjMGpQU2NqNHY1MzUrc2JrY3RSVXpSc2tlaEtQNDFkb2R1SUYv?=
 =?utf-8?B?Q1JGOU1Fa1YzQjFScFBRdXMyeFJETWYzOUJ0THJONmlMeUNMZ3pLRjd5YjBq?=
 =?utf-8?B?NWdFaEc3Nndmd2RwTTVsc1lldzhqWU1hK3pCaFdsYnBlcGZxMHNQK2pHeXNy?=
 =?utf-8?B?NUJ3OVg4SldBdzl1aVVMa25lSzN2STRIOWQvOEhuZXU0aWJqYjN2a3c3c0tS?=
 =?utf-8?B?MXlidjBpSm4rdnYrS3Z1MVZjU05iTFh4UkJQaGt5WW8yUUNJVW80Z1hqTkpY?=
 =?utf-8?B?N3lYTzE0TXZ1ZVBqd1ZjSUlCYmUxWmVCbWNURDBrOFg2dStYK1lvNkloTy9K?=
 =?utf-8?B?dGFLRmdmQUY0UlNyOWdpTkRxOUlwWk1zV3M0ME14YlFGMm8rLzdrN01RbmtG?=
 =?utf-8?B?bC9pb2ZCV09pM3Z1NHZ0bXJzSm1EcmRHdUNGdlVldjN5ZHdyKzVCL1RHSXpp?=
 =?utf-8?B?SmJrUmlodi9TWEZpdUdKdDdOdkdMUnh0b0Nla2pRb3BwNUZpRmV2ZUZrQ0lP?=
 =?utf-8?B?R041Tko1NDhBZ3hLMHFER1hTei9KNGlGWStOdkpOUGhRT3JodXA3Y2kyTStY?=
 =?utf-8?B?SkFFMEZnNWZOR3BYdUE2ZWI2TzkrVmZydXhqUmtLNjU4N0tHS2Y1Zi9nR0Jq?=
 =?utf-8?B?dWVKVmJ2RWpJbm80ZDVDN0JDTzJIQkdDVEd2SUVuNDYwVlRXd2xrUXc3bmor?=
 =?utf-8?B?dWVJVTZyclEyZEMzWG9aRU0zUHZvTjVUMWNzT1Mrc2tBZVpPNUF6RXhRcWxi?=
 =?utf-8?B?UWtmaVpIVFRPKzdyd0dIR1lVZzdwc0NBY3FkRWxPWHZ0UWtSWU5mNUFKaVRL?=
 =?utf-8?B?L2poUnJ4R2lHNG9UYS81K0VCY3liR0ZRc0JlRi9vRmRDN2xQU3dyN3h1NjM4?=
 =?utf-8?B?S3FkdFpvZW5NenU3OWJTbmlJdXB4bE5PUEhONURFb3ZIUDdHLzBuTUNwL2ov?=
 =?utf-8?B?c0s3d2E1SURFV1lGNmI0QjhGQzdtMFRpamJBbURvL2tPVUdVZkdhbTBsZDM4?=
 =?utf-8?B?QTBGaGtSWVdhVHd0RUplL1BoMG5RN2Q2WFB6SXJYcC93WWcyMXhXYjBqMC9S?=
 =?utf-8?B?NFgrK2VHM1RCa3htQ0NzQlp4NnJVT21zSlczeDRGcTNBMWFQVndQZmpITXBN?=
 =?utf-8?B?TENSejdONEZTQktLRVZWZFZLRFYxSkFsWmxkKzEzcW52QkplYlZKYmxJa2c0?=
 =?utf-8?B?T2lIK1R0ZUZCSXFEbU9pdkhWWWNmbnA0UXRmbWtKblRQUHRUZ1dtWFVScXow?=
 =?utf-8?B?aVpPWGZIR0hKMDdSMkJUeGpwQUQrZmhxc3BXZWNlcGZRUStKazJodE1DVTgr?=
 =?utf-8?B?Y2NnQVk1c3o4aWs3QmdrcS85cVBnTXJIVjlOd1dyMUs2MkNOZEVhNUdsUjZT?=
 =?utf-8?B?VnNxN3dRS3RzTVpZaC9sVy9HRmJKQ0tXemtNSTkxTzNDWG02SGdEVTB1amFV?=
 =?utf-8?B?TGl3aXVCRGZsMzZBcjgvdGUzWEdPUVJwKzYrWGxOZk9LRUxlaGlaSWpYaVk1?=
 =?utf-8?B?RTgvUm1TT0owTVk4Njh1czdpVkMxTm5KOWx5SFE4WmdycVMwendMZlI4WURm?=
 =?utf-8?B?K2YxOVpidC9mY05PY3EvTWwxWnowRUNZR2JoSk82QUR3N0x0N242VGg4cy9G?=
 =?utf-8?B?TEpsWGdMRXB4dTliZC9KaXVWM0NYcnBXUnptOU1GaWxrMUxSSlNkcFlvNGIx?=
 =?utf-8?Q?NukojmLRFRxqRMhXH1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653f5888-f81b-416c-1bfc-08df4bb673b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 12:11:50.8563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnw9N7tjqzKLAIa/JIVRka2lFmt4/S3vr59I4V+PLX3VzrEAFthsTIK94JBr9pwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/26/26 12:11, Tvrtko Ursulin wrote:
> Use scoped cleanup for drm_syncobj_array_wait_timeout entries array
> allocation and syncobj cleanup.
> 
> This converts the remaining parts of the function resulting in simpler
> error handling and easier extending with a fast path in the future.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Fei Yu <fei.yu@intel.com>
> Cc: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 61 +++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index bd3f9e74e678..7d5c4e4e29b2 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1044,6 +1044,31 @@ static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
>  	list_del_init(&wait->node);
>  }
>  
> +struct syncobj_wait_entries {
> +	struct drm_syncobj **syncobjs;
> +	struct syncobj_wait_entry *entries;
> +	unsigned int count;
> +};
> +
> +static void syncobj_wait_entries_free(struct syncobj_wait_entries *e)
> +{
> +	if (!e->entries)
> +		return;
> +
> +	for (unsigned int i = 0; i < e->count; i++) {
> +		drm_syncobj_remove_wait(e->syncobjs[i], &e->entries[i]);
> +		if (e->entries[i].fence_cb.func)
> +			dma_fence_remove_callback(e->entries[i].fence,
> +						  &e->entries[i].fence_cb);
> +		dma_fence_put(e->entries[i].fence);
> +	}
> +
> +	kvfree(e->entries);
> +}
> +
> +DEFINE_FREE(syncobj_wait_entries, struct syncobj_wait_entries,
> +	    syncobj_wait_entries_free(&_T))
> +
>  static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  						  void __user *user_points,
>  						  uint32_t count,
> @@ -1052,6 +1077,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  						  uint32_t *idx,
>  						  ktime_t *deadline)
>  {
> +	struct syncobj_wait_entries cleanup __free(syncobj_wait_entries) = {};

Oh that looks ugly, I would seriously not do it this way.

Replacing the extra kvfree() is ok put I would keep the ref-counting cleanup in the same function.

Regards,
Christian.

>  	struct syncobj_wait_entry *entries;
>  	u64 *points __free(kvfree) = NULL;
>  	struct dma_fence *fence;
> @@ -1076,6 +1102,11 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  	if (!entries)
>  		return -ENOMEM;
>  
> +	/* After this the entries cleanup is fully automatic. */
> +	cleanup.syncobjs = syncobjs;
> +	cleanup.entries = entries;
> +	cleanup.count = count;
> +
>  	/* Walk the list of sync objects and initialize entries.  We do
>  	 * this up-front so that we can properly return -EINVAL if there is
>  	 * a syncobj with a missing fence and then never have the chance of
> @@ -1091,12 +1122,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  		if (!fence || dma_fence_chain_find_seqno(&fence, points[i])) {
>  			dma_fence_put(fence);
>  			if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> -				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
> +				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE))
>  				continue;
> -			} else {
> -				timeout = -EINVAL;
> -				goto cleanup_entries;
> -			}
> +
> +			return -EINVAL;
>  		}
>  
>  		if (fence)
> @@ -1115,7 +1144,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  	if (signaled_count == count ||
>  	    (signaled_count > 0 &&
>  	     !(flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL)))
> -		goto cleanup_entries;
> +		return timeout;
>  
>  	/* There's a very annoying laxness in the dma_fence API here, in
>  	 * that backends are not required to automatically report when a
> @@ -1160,40 +1189,30 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  				} else {
>  					if (idx)
>  						*idx = i;
> -					goto done_waiting;
> +					__set_current_state(TASK_RUNNING);
> +					return timeout;
>  				}
>  			}
>  		}
>  
>  		if (signaled_count == count)
> -			goto done_waiting;
> +			break;
>  
>  		if (timeout == 0) {
>  			timeout = -ETIME;
> -			goto done_waiting;
> +			break;
>  		}
>  
>  		if (signal_pending(current)) {
>  			timeout = -ERESTARTSYS;
> -			goto done_waiting;
> +			break;
>  		}
>  
>  		timeout = schedule_timeout(timeout);
>  	} while (1);
>  
> -done_waiting:
>  	__set_current_state(TASK_RUNNING);
>  
> -cleanup_entries:
> -	for (i = 0; i < count; ++i) {
> -		drm_syncobj_remove_wait(syncobjs[i], &entries[i]);
> -		if (entries[i].fence_cb.func)
> -			dma_fence_remove_callback(entries[i].fence,
> -						  &entries[i].fence_cb);
> -		dma_fence_put(entries[i].fence);
> -	}
> -	kvfree(entries);
> -
>  	return timeout;
>  }
>  

