Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47279606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VVhJlPcD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC61310E069;
	Wed, 21 Oct 2026 08:09:01 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B541010E069
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=NvukL1YkYWvvmYohA6hxlmPKOZNOWIjgvH912SBvpxA=; b=VVhJlPcDgXCE3hl4qmvDm67Eq4
 8/3gv6QaghFZ8I2/grBaPtx+esxoQvZ/WsW5kOl0UOIIy/apvDLn4p4rYxgii0ifVhsnkiTCzvLEo
 b9G0EzFl+VuE0rpb0I2OkEG+kwpRAGtl708ILKxMkMX/awAfrx3aJ42ktUX6fBl3vhKFPrmPTm5m1
 fxYrrZpy8dhXG0ZTP05eRjkYEat8yMAw/ddRKQtbZ5JoDmEBtZz8ogLIFcELkJfdJJLJVPXXw0KxK
 r7WABgWrmSmleyT6nug5wvzSZBNZrN/jH1COxhbQBeGDAQXTZ87y8c4CXlKMzQw1WAejRcPCK25AQ
 lnj6SDMA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJRNV-005Puq-Qf; Wed, 21 Oct 2026 10:08:53 +0200
Message-ID: <c32a1931-c0de-4d63-a8c8-2189c35137dc@igalia.com>
Date: Wed, 21 Oct 2026 09:08:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/sched: Disallow initializing entities with
 un-initialized schedulers
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
 <20261020154123.33631-3-tvrtko.ursulin@igalia.com>
 <sashiko-outbox-179327@kernel.org>
Content-Language: en-GB
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <sashiko-outbox-179327@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 20/10/2026 17:02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm/sched: drm_sched_entity_init() breaks v3d_open() on V3D 3.3
> --
> 
> commit 607520d70e20fa56f0a8fa9eade2db9f019b764f
> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> drm/sched: Disallow initializing entities with un-initialized schedulers
> 
> This patch updates drm_sched_entity_init() to reject schedulers whose
> run-queues have not been initialized, returning -EINVAL instead of logging
> a warning and continuing.
> 
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>> index e12709b7bd0c3..95bb79b3d003a 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -119,9 +119,16 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
>>   			  unsigned int num_sched_list,
>>   			  atomic_t *guilty)
>>   {
>> -	if (!entity || !sched_list || !num_sched_list || !sched_list[0])
>> +	unsigned int i;
>> +
>> +	if (!entity || !sched_list || !num_sched_list)
>>   		return -EINVAL;
>>   
>> +	for (i = 0; i < num_sched_list; i++) {
>> +		if (!sched_list[i] || !sched_list[i]->sched_rq)
>> +			return -EINVAL;
>> +	}
> 
> [Severity: High]
> Does returning -EINVAL here when !sched_list[i]->sched_rq break
> v3d_open() on V3D 3.3 hardware (V3D_GEN_33)?
> 
> During probe, v3d_sched_init() in drivers/gpu/drm/v3d/v3d_sched.c only
> initializes the V3D_CSD and V3D_CACHE_CLEAN schedulers when
> v3d_has_csd(v3d) is true:
> 
> drivers/gpu/drm/v3d/v3d_sched.c:v3d_sched_init() {
> 	...
> 	if (v3d_has_csd(v3d)) {
> 		ret = v3d_queue_sched_init(v3d, &v3d_csd_sched_ops, V3D_CSD,
> 					   "v3d_csd");
> 		if (ret)
> 			goto fail;
> 
> 		ret = v3d_queue_sched_init(v3d, &v3d_cache_clean_sched_ops,
> 					   V3D_CACHE_CLEAN, "v3d_cache_clean");
> 		if (ret)
> 			goto fail;
> 	}
> 	...
> }
> 
> On V3D 3.3 platforms where !v3d_has_csd(v3d), those two schedulers are
> never initialized via drm_sched_init(), leaving their sched_rq pointers
> NULL.
> 
> However, when userspace opens the DRM device node, v3d_open() in
> drivers/gpu/drm/v3d/v3d_drv.c unconditionally loops over all
> V3D_MAX_QUEUES queues and fails if drm_sched_entity_init() returns an
> error:
> 
> drivers/gpu/drm/v3d/v3d_drv.c:v3d_open() {
> 	...
> 	for (i = 0; i < V3D_MAX_QUEUES; i++) {
> 		v3d_priv->stats[i] = v3d_stats_alloc();
> 		if (!v3d_priv->stats[i]) {
> 			ret = -ENOMEM;
> 			goto err_stats;
> 		}
> 
> 		sched = &v3d->queue[i].sched;
> 		ret = drm_sched_entity_init(&v3d_priv->sched_entity[i],
> 					    DRM_SCHED_PRIORITY_NORMAL, &sched,
> 					    1, NULL);
> 		if (ret)
> 			goto err_sched;
> 	}
> 	...
> }
> 
> Previously, drm_sched_entity_init() logged a warning via pr_warn() and
> returned 0, allowing v3d_open() to succeed. With this change, won't
> every v3d_open() call on V3D 3.3 fail with -EINVAL?

Oh well, guess I overestimated the general public sensitivity to weird 
error messages.

Given the submit side is guarded with the same v3d_has_csd() as the 
scheduler init, so those entities are not reachable after open, I think 
I can just add a patch which adds the same skip condition in the 
v3d_open() loop.

Maira - does that sound like it would work?

Regards,

Tvrtko

> 
> [ ... ]
> 
>>
> 

