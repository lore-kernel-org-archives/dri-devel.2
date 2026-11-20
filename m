Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C13606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=MzvFLUH4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A370B112BE5;
	Fri, 20 Nov 2026 16:49:40 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A2A112BE5
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=mn5he0+K8znliFOyTTFpEswHVtosrnYpIk2OlL8JzzI=; t=1795193374; x=2110553374; 
 b=MzvFLUH4wBfXGcvnD3qXFg0GHOwRggjDsbyE2UNigmH8SCL7gIktsY68/4zvSZjPgBP19zeIkx/
 phrMU0B7mPbIsuUdQpZzyiSlcbPp1mzGLYDuQhLHodCTqO1tZzgAH7RjMXjLF6/nI+DiRuTlsQt67
 lnh55U3zN80SZH5uGffns+tXm8X1EloPw/x5PvyfP1jEwIvTwyoF+dduz+ShRtBf+9271qB4H1QNB
 8oHSxySEV4d4jz2c+pHeuejzxiwSLuzZ3IWSamxrWUYqp0l6fF+VLiVHvFBdHCXmo+kX5iFsk6Vp/
 LUlRBVzRlDxA9l8RtIccSeJpkrNFcFYVktPw==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xURni-00000001wrv-1TkD; Fri, 20 Nov 2026 17:49:26 +0100
Message-ID: <3f029973-1a52-4118-acd5-4a433fb49710@igalia.com>
Date: Fri, 20 Nov 2026 13:49:19 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: Fix double free of query arrays on parse
 failure
To: Xiaolei Wang <wangxiaolei01@kaihong.com>, mwen@igalia.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, tvrtko.ursulin@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Iago Toral Quiroga <itoral@igalia.com>
References: <20261120022828.2612091-1-wangxiaolei01@kaihong.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20261120022828.2612091-1-wangxiaolei01@kaihong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Xiaolei,

On 19/11/26 23:28, Xiaolei Wang wrote:
> v3d_get_cpu_timestamp_query_params(), v3d_get_cpu_reset_timestamp_params(),
> v3d_get_cpu_copy_query_results_params() and v3d_copy_query_info() -- the
> latter shared by the reset and copy performance parsers -- free the query
> array on their error paths through v3d_timestamp_query_info_free() and
> v3d_performance_query_info_free().
> 
> The same job is then released by v3d_submit_cpu_ioctl()'s failure path
> (v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
> v3d_cpu_job_free()), which calls the same helpers on the same query_info.
> On these error paths query_info->count was never assigned -- it was only
> written after the parse loop completed -- so the syncobj loop ran zero
> times and no syncobj was put twice, but the "if (query_info->queries)" test
> still succeeded and the dangling pointer was handed to kvfree() a second
> time.
> 

====
> Every failure inside the parse loop takes this path: -ENOENT from
> drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
> kvmalloc_array() in v3d_copy_query_info().
====

Needless paragraph.

> 
> Fix the ownership instead of the symptom: the query array, and the per
> query kperfmon_ids, belong to the job and are freed exactly once, by
> v3d_cpu_job_free().  The parsers no longer free anything; they only fill
> the array in and record how far they got:
> 
>    - query_info->count is set before the parse loop, so the helpers know how
>      many entries were touched when parsing fails halfway;
> 
>    - the arrays are allocated with kvzalloc_objs(), so entries that were
>      never reached carry a NULL syncobj and a NULL kperfmon_ids;
> 
>    - the helpers walk the full count but test every entry, so they put
>      exactly the syncobj references that were taken, keeping
>      put-count == find-count on all failure paths;
> 
>    - the inline kvfree() of kperfmon_ids in v3d_copy_query_info() is dropped
>      for the same reason;
> 
>    - the count argument of v3d_timestamp_query_info_free() and
>      v3d_performance_query_info_free() goes away, as the count now lives in
>      query_info itself.

You don't need to describe every single detail of the code in the commit
message.

Please, make your commit message for human-readable.

[...]

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 1924e3440dc9..6ee64fbacae9 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -95,34 +95,44 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
>   	v3d_job_cleanup(job);
>   }
>   
> +/*
> + * The query arrays are owned by the job: they are allocated by the extension
> + * parsers in v3d_submit.c (which also publish ->count before they start
> + * filling the entries) and they are released only here, from
> + * v3d_cpu_job_free().  The arrays are zero allocated, so on a parsing failure
> + * the entries past the last one set up are all zero and get skipped.
> + */

This comment is superfluous. Please, delete it.

>   void
> -v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
> -			      unsigned int count)
> +v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info)
>   {
> -	if (query_info->queries) {
> -		unsigned int i;
> +	unsigned int i;
>   
> -		for (i = 0; i < count; i++)
> -			drm_syncobj_put(query_info->queries[i].syncobj);
> +	if (!query_info->queries)
> +		return;
>   
> -		kvfree(query_info->queries);
> +	for (i = 0; i < query_info->count; i++) {

Stop the loop at the first NULL syncobj.

if (!query_info->queries[i].syncobj)
     break;

> +		if (query_info->queries[i].syncobj)
> +			drm_syncobj_put(query_info->queries[i].syncobj);
>   	}
> +
> +	kvfree(query_info->queries);
>   }
>   

[...]

> @@ -915,7 +885,8 @@ v3d_copy_query_info(struct v3d_performance_query_info *query_info,
>   		    struct drm_file *file_priv)
>   {
>   	unsigned int i, j;
> -	int err;
> +
> +	query_info->count = count;

Leave this in the functions that call v3d_copy_query_info() and remove
count from v3d_copy_query_info()'s parameters.

Best regards,
- Maíra


