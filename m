Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607AF606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=noW1YjEv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C2CE10E6A1;
	Thu, 19 Nov 2026 10:58:02 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F013310E6A1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAam0mPbZ052MtUjU0HsAfssfe7Sci56gzadUIgbnCzsV8b7NODhK9EtxYk3xPOrO4J0z7v5O8JFTzz0yfJ3UTEwcPJ4PCYHwJioptg0ye1NkhfBZt4MDG+RNQTkQkOlxq/DWgF25MBO1DXZq8IVrXb5FirqRIsfpMF3/AXPjj1LIR0BJ/jCa9oNvOG/vnl94Mixx6gS2URTdm7wEmSqUWt03H79Ryowuuw26uoFm5irhCL39/kxe6tFKOpd/gZKI8z3k9z7nsqlo5wfgau25jJkx2m1QErBFGJweZEYU/LwOfXkABrzf/aLfz2gMlEFsOMaSG9r4VYdlpIukq76sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT2ElwEVkKeEqoknKedg4NmpirFzrxdcAJYgypJKpqA=;
 b=LNjUTpkL6M9jRDmo0KqV9qty3QwBB4UJsO2aiQ++9g4aRyDG8/XwodIYAUmptPCXQQiv2IETAeUOKSC4cZTXUEijLs8HzFty6NhjMHOtjqTt234HV/vhumeJjG/y7cdGqLuwnaWmbKlcDdwDihQ6/LjcqAF9mxBsc3zwLViRiUHP05m40aD65hsh2Tre91JEsOm4iuZPTmDffjkiMq+haW+9k2KkrXEDcBaleQdl2WYkW86VNeX1gQVAIqiFKIWmWcLyS5eLdqElnrrXhwzmgE/ipQFIspklRKOBHhoxxzAvZP+you2LbLKXSzTI4a+1kO3TMWOYTGa9tncP1x2Wsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT2ElwEVkKeEqoknKedg4NmpirFzrxdcAJYgypJKpqA=;
 b=noW1YjEvNHfE1QVoRwJYG/yomDg8RZJPCQq1j23C0Aha856fjhO8xn7QQUKJcGJfzLoyIGeYtvteRW3GwkH6rVNesYkhbWHQPJXWnKoHgua3pT7qLfJqnSlKhvOrPe9U4hgeDb4HjT9l9OaEu9Y4soyXJhG+kl/EMDQdMJC8nHU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999174.namprd12.prod.outlook.com (2603:10b6:8:389::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:57:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 10:57:53 +0000
Message-ID: <4f507f12-2b1a-4319-93a8-813f35b9da3e@amd.com>
Date: Thu, 19 Nov 2026 11:57:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/syncobj: Add a fast path to
 drm_syncobj_array_wait_timeout
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Fei Yu <fei.yu@intel.com>
References: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
 <20261117103916.9101-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117103916.9101-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999174:EE_
X-MS-Office365-Filtering-Correlation-Id: 931fa78d-f737-407f-9b02-08df462bf5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|5023799004|10067099003|56012099006|261022105027099003|261026140227099003|261026121527099003|261022113327099003|261028144727099003|261021123027099003|261021121427099003|261009221227099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: Cg94HL6bdXlbkz2Uh6WCnKEx93cwhjWRldPMxKwYaisgdCq03Wz5YqKKorsxCoyx4d0zAAYMyRt+oZsuKW1HG/sKBwDc8fbpqvdZA/sWE+PIOaJmF5XCDAggXhqMXFMoZcmUfhjE2uAfx6ZYmumpwlEp7DGT0NYQ8QA4jD3dCAvtVUuXbcd6mNKjcpHI1VnfHh6t6+cIpSF86kUQlSYzQkPtex3wmk7YHtKGr1QqbHinTEANGlxiqVvgNUr2teanKIkQFuuK/4gRMe32y1M9VIRzSE1hgALiEfLFH7XKS0WB3QFS3yCK9qhZqx+8jjheQnOE8syfOhRwDjEzRWspglhhE9VKIrDnDwSv8qa8dBnR+ILvgZIZuBVmzHrUmIl1UGb36tmzaBKkVgrPKBx6y6pZKV1Chr39dyuvA8nlk9bX0YeFggcwZosQoDU9/bsmsReOiPLo3Pwj3/oPPjK9gqiFG+FN2QPTmRKvpTzlC5HwXUtCG37Q0JIm+9rKwnwavSKDlc3iSBIUK1Nk7lVckWH5scauGvM+dnwWzjA+1/0aKJTSqhxau8sTOw/X4X5vxa1KKVaYAg8u+Jy7ySnPYmheNDMb3krCVuXO/RYAm47yA2Ci2D9xjDHhBhpqHDEiua6aw7pVuZ12hcUCSXebARqlgb0k4wgkPu1E+5na7rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261022113327099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRmNDVwTWw3YTFNZzR2RmZxMTJ2WEd5Zzl6UTV4NzVqOXJJWGtjTFhCRmha?=
 =?utf-8?B?ZmZjTW83NzZCbkY1aStTUlhOZ1FZVDZvaTNWbXBQY1YyWUNTTXZmOXIvUDZF?=
 =?utf-8?B?U1JGcjE5cE83UzRGdkM5NnQ3b3grS1I5bHQ0MnJ3VkVqWG92bm5SR0RtNjg0?=
 =?utf-8?B?VlViNjZYVENBVmJoZThxWHhobDZuNCtaWm1kNnpyYk9QNlROWGQzMDc0OVV4?=
 =?utf-8?B?YkFJUExGRDYwZkJtUDlGck1ickZnNCtTVmQ4Y3p0SmNXWnZRWG84U1ZQOUVS?=
 =?utf-8?B?Y0QwaTl1SEZoSWxOMnBzc3k2ZGJPaCtOVUZSNTcrYURxdms1SnpDVHhCSUpE?=
 =?utf-8?B?REZoenRrZmtUdWREV0VLaWIvZWhmYm9iTjFhOGgycW5tT1hFNGplR2ZoRVov?=
 =?utf-8?B?NHJVRFNDZlgveEU2ZDJXSHlvb3NpZ1pyWHhKZWE1Sk0vSnVmcVN6R1FIRVo1?=
 =?utf-8?B?Uy9LMVU3VGwzQnlhNFhqT2hOMXROQmF0QllGSE5NMDU2MWdzT3R2ZTNKTUZD?=
 =?utf-8?B?eVZ2M1dXRlpRUHdKV3hIMlRUbVdFbTkzLzJMRGhUdUlHaUFIcm5RdWlBU21o?=
 =?utf-8?B?UlNsdnFEa0VXSXo1Y2hZU0U2MkphWXpXWWl2YWlVR094aFlSWkMzaDRlVzUw?=
 =?utf-8?B?elJlTXZmazhocHh4bEdPUXNDZTNKcnV1NHhVUFYycHJnS0ZlTlc5RHJVelcv?=
 =?utf-8?B?YmRKTjhZK2daZjZFcGZWait4N3h3dGRvL3hhQ015U0h4NFlyM2F5Ulh3Sitp?=
 =?utf-8?B?NnQvYVFrdUpMT2krbHl0OHU1ZjRiTUx3Qm9qNVpjSjVIditSYTdCODJXSXFX?=
 =?utf-8?B?TXY2MEZmeWpBVkd0dWhxMnA2aytzWmpmZHRYWVMxbC9BZng1L0Z1djhaSmxa?=
 =?utf-8?B?MU5td01OdXVnUEtIdHY5MmtCend1ZDVFU053aEtEUnBORWVwd3U4cHJyNysz?=
 =?utf-8?B?MzFCUkIwS3pKaFNUcmRSTEVodHBhS3I1THZ0NmQ4Y2VNbGlGaGc5NkFXNzJY?=
 =?utf-8?B?T093L2phQThNejJERUlKQi9lTWF6TkUwM0pHRUc5cGdBUVl5WTQzY25TVDFW?=
 =?utf-8?B?emNTU1VhbFFRdThNaGIyRnROWFFRMkFuVWt6V0VkeXFoRzk0VUNFV2F6Z056?=
 =?utf-8?B?eVRBcnNTVXA3ZVk0NzVTMHpGbFdPNXdwdDVzanRPb3QxME94S3l4WEcwaFBY?=
 =?utf-8?B?c3F6SktjZEk0aDBLbGZYSWdGQzB6Y1FxMUwraXVzcGJGOHExOVJodGZrUmNm?=
 =?utf-8?B?ajZsaFB1WkNlcExoRnhGMFhYZEVwMHRqc1NjT3AwUFdGNWV4RXorRW5JYThz?=
 =?utf-8?B?UkU0cjF4NlVUa2t0ejhna3VtQVkzT0ZDYW1kdlFHQ29mZytCT3VadnArTUZ1?=
 =?utf-8?B?dHl1Sk5yWG4vSzRLRmpESjVCbS9qMWpaZW9IdDh5MnRpTFZrcXFMT0N5bG1u?=
 =?utf-8?B?OENBTURXMFBpM1lxY3JFcEVTS3JaMkN2QlI0cC9xME5Wci9QYkU4SWlOQ3Vl?=
 =?utf-8?B?cEVsYmtFekV0SU56N1dEcHJGbFRoczlFZUZJZFVlR0kwTXlFaDhaaVlmL2hX?=
 =?utf-8?B?ZHppZ0toSmZPY2hZZnRjdHFNMEpyVTkxVmV0bVo4U1BveURmZGo5OWdBTFZw?=
 =?utf-8?B?bkxYYW1rYW5QVERNSXE5aEhvQVJXZ0tpeTVCdWxOS21FY0VJdzg3RVhtZ2lt?=
 =?utf-8?B?MVdvU0RFWi9hNHpJTFIxanBBRUNPcmZFb0QwZ2h5Nm9ZZm15Lzd5SXJwVXpa?=
 =?utf-8?B?N2VKUzM2NWZFQm1zTkFCaTl2M25SaUJ4NWUrazM1Y2xKMDZUbkNneDBsSncz?=
 =?utf-8?B?dVUzTFkwNDNXWjRNVkU0UFdxc0pGMTliYWo1aW5BWWJuRndZUHJJZ2RramFz?=
 =?utf-8?B?QlZJWnNqQUM2eU5tUnE5QkMyTHBLMWgyUEVtUE0xdE5Nemdoc1lOMGVkbU1y?=
 =?utf-8?B?bWRMelA3QU80T0t6UEVMN2U0bHZLN0FyM3FoaG94NGJCeWtrNVAySktrMlNu?=
 =?utf-8?B?MDl5QWpodkRRUXY3Q1p6dHVRZDh1Vy9UaXhyaDg0UGRtVEZtYkhQZnl2MGxG?=
 =?utf-8?B?SUVMWGxEOTlxR0NoSWZBOFFWaC9xazB3RDlvQXg5RkIxL2tPYitNMUJ2eWg0?=
 =?utf-8?B?OHQxWTRLVU9YZStVL0F6ckZwZmtnVjFQa0ozb3ZQUTQ4WElvTWF2eldPQ3Fx?=
 =?utf-8?B?WU13MVZ0T0NzYUFDN045a3FXSHJCNnAxMkdSUm1GY0JlMFI4SGplN0VhbGh6?=
 =?utf-8?B?ZURqUjlXaVpqN2dDWk9mN3ZrT1dKc3crdlZ5NkFNZlRKQjFUeldMbC9rb2Y4?=
 =?utf-8?Q?0LFtD47NPQ3+357W15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931fa78d-f737-407f-9b02-08df462bf5da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:57:53.3962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaUJYd9qgDfoyltCGeiU4I8SjQIA43BlC31DWmXgSqszZ+ZW5m3ZhdgRWnw9P5oU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999174
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

On 11/17/26 11:39, Tvrtko Ursulin wrote:
> Running the Cyberpunk 2077 benchmark we can observe that waiting on DRM
> sycobjs is relatively hot, but the 96% of the calls are for a single
> object. (~4% for two points, and never more than three points. While
> a more trivial workload like vkmark under Plasma is even more skewed
> to single point waits.)
> 
> Therefore lets add a fast path to bypass the kcalloc/kfree and use a pre-
> allocated stack array for those cases.

In general it seems valid to optimize that stuff, but I'm a bit concerned about the complexity and opportunity for coding errors which are hard to detect.

How about we have a macro which creates a guarded stack allocation which is either using the stack when it is small enough or kvzalloc_objs() as fallback?

Regards,
Christian.

> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reviewed-by: Maíra Canal <mcanal@igalia.com> # v3
> Cc: Fei Yu <fei.yu@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
> v2:
>  * Document rationale for stack array in a comment.
> 
> v3:
>  * Added DRM_SYNCOBJ_FAST_PATH_ENTRIES to avoid hardcoding fast path array
>    size.
> 
> v4:
>  * Rebased to be standalone.
> 
> v5:
>  * Rebased for kzalloc_objs.
> 
> v6:
>  * Rebased for kvmalloc_objs and kvzalloc_objs.
> ---
>  drivers/gpu/drm/drm_syncobj.c | 44 ++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 663d6cb8dbf8..b76b957b1fff 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -248,6 +248,14 @@ static void
>  syncobj_eventfd_entry_func(struct drm_syncobj *syncobj,
>  			   struct syncobj_eventfd_entry *entry);
>  
> +/*
> + * Empirically vast majority of ioctls pass in a single syncobj (96%) and never
> + * more than three points. Therefore implement a fast path with a small stack
> + * array to avoid going into the allocator sometimes several times per
> + * userspace rendered frame.
> + */
> +#define DRM_SYNCOBJ_FAST_PATH_ENTRIES 4
> +
>  /**
>   * drm_syncobj_find - lookup and reference a sync object.
>   * @file_private: drm file private pointer
> @@ -1051,10 +1059,12 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  						  uint32_t *idx,
>  						  ktime_t *deadline)
>  {
> +	struct syncobj_wait_entry stack_entries[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
> +	u64 stack_points[DRM_SYNCOBJ_FAST_PATH_ENTRIES];
>  	struct syncobj_wait_entry *entries;
>  	struct dma_fence *fence;
> -	uint64_t *points;
>  	uint32_t signaled_count, i;
> +	uint64_t *points;
>  
>  	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
>  		     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
> @@ -1062,24 +1072,33 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  		lockdep_assert_none_held_once();
>  	}
>  
> -	points = kvmalloc_objs(*points, count);
> -	if (points == NULL)
> -		return -ENOMEM;
> +	if (count > ARRAY_SIZE(stack_points)) {
> +		points = kvmalloc_objs(*points, count);
> +		if (!points)
> +			return -ENOMEM;
> +	} else {
> +		points = stack_points;
> +	}
>  
>  	if (!user_points) {
>  		memset(points, 0, count * sizeof(uint64_t));
> -
>  	} else if (copy_from_user(points, user_points,
>  				  sizeof(uint64_t) * count)) {
>  		timeout = -EFAULT;
>  		goto err_free_points;
>  	}
>  
> -	entries = kvzalloc_objs(*entries, count);
> -	if (!entries) {
> -		timeout = -ENOMEM;
> -		goto err_free_points;
> +	if (count > ARRAY_SIZE(stack_entries)) {
> +		entries = kvzalloc_objs(*entries, count);
> +		if (!entries) {
> +			timeout = -ENOMEM;
> +			goto err_free_points;
> +		}
> +	} else {
> +		memset(stack_entries, 0, sizeof(stack_entries));
> +		entries = stack_entries;
>  	}
> +
>  	/* Walk the list of sync objects and initialize entries.  We do
>  	 * this up-front so that we can properly return -EINVAL if there is
>  	 * a syncobj with a missing fence and then never have the chance of
> @@ -1196,10 +1215,13 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  						  &entries[i].fence_cb);
>  		dma_fence_put(entries[i].fence);
>  	}
> -	kvfree(entries);
> +
> +	if (entries != stack_entries)
> +		kvfree(entries);
>  
>  err_free_points:
> -	kvfree(points);
> +	if (points != stack_points)
> +		kvfree(points);
>  
>  	return timeout;
>  }

