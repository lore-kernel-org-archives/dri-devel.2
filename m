Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B18606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=U2rlAaST
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB27010E4CB;
	Wed, 18 Nov 2026 13:22:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB30A10E4CB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=5EiWHwH4lZHEOy9Cv6oxcmHmVFbgWDUAl8vqnSez6fY=; t=1795008116; x=2110368116; 
 b=U2rlAaST4vEHmvyXbWxg+JO4w0TbJ77YRtDyjnWms77vEjjpGzC8OyVU8QAwvN1C7Q5XA9cIfNC
 7Zvgq/wjHEi00BuX4sELdaATzud6qJJqsbhzvVVCh8lHHAO3RzW6lnd1LbDwRP3cUFD7CqlL/+Bt2
 qAWjs3brp1ub5QdsHQzL4MSxUwy/8U/2rYo24tE2QxE7SRKbErN2gtHQEBZFJ3wGt/VXDJY2aHzRH
 Uu6cwItHX+Js4GZePvWdXeWCBYioS9dmBdxG2s36K+dJv4ZhbdSPnQ6mkdfkFrAGQyxwKj2ckOpPC
 RVKOMWgP+Gu738cG/0KSCSw09UHon7nd7V4Q==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTfbh-0000000116M-0ccA; Wed, 18 Nov 2026 14:21:49 +0100
Message-ID: <c8e13d27-7d16-481d-82bf-6f7cca80a5e4@igalia.com>
Date: Wed, 18 Nov 2026 10:21:43 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix double free of query arrays when extension
 parsing fails
To: Wang Xiaolei <wangxiaolei01@kaihong.com>, mwen@igalia.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, tvrtko.ursulin@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Iago Toral Quiroga <itoral@igalia.com>
References: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
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
In-Reply-To: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wang,

Please, be patient with kernel maintainers. Kernel etiquette recommends
waiting at least a week before pinging maintainers [1].

On 10/11/26 03:13, Wang Xiaolei wrote:
> v3d_get_cpu_timestamp_query_params() and v3d_copy_query_info() - the
> latter used by both performance query parsers - free the query array on
> their error paths through v3d_timestamp_query_info_free() /
> v3d_performance_query_info_free(), but leave query_info->queries
> pointing at the freed buffer.
> 
> The same job is then released by v3d_submit_cpu_ioctl()'s failure path
> (v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
> v3d_cpu_job_free()), which calls the same helpers on the same
> query_info. On these error paths query_info->count was never assigned -
> it is only written after the parsing loop completes - so the syncobj
> loop runs zero times and no syncobj is put twice, but the
> "if (query_info->queries)" test still succeeds and the dangling pointer
> is handed to kvfree() a second time.
> 
> Every failure inside the parsing loop takes this path: -ENOENT from
> drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
> kvmalloc_array() in v3d_copy_query_info(). The helpers are shared
> between that error path and the job release path.
> 
> Clear the pointer once the buffer has been freed.

This is indeed a bug, but the solution doesn't fix the ownership problem
here. We should actually leave the cleaning process to
v3d_cpu_job_free() instead of cleaning it in the parser. I wrote this
draft of what I was thinking on:

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c 
b/drivers/gpu/drm/v3d/v3d_sched.c
index f29d79b15be3..15bec1e35e39 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -96,17 +96,18 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
  }

  void
-v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
-                             unsigned int count)
+v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info)
  {
-       if (query_info->queries) {
-               unsigned int i;
+       unsigned int i;

-               for (i = 0; i < count; i++)
-                       drm_syncobj_put(query_info->queries[i].syncobj);
+       for (i = 0; i < query_info->count; i++) {
+               if (!query_info->queries[i].syncobj)
+                       break;

-               kvfree(query_info->queries);
+               drm_syncobj_put(query_info->queries[i].syncobj);
         }
+
+       kvfree(query_info->queries);
  }

  void
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c 
b/drivers/gpu/drm/v3d/v3d_submit.c
index eada30a31701..a3e92e097423 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -734,7 +734,6 @@ v3d_get_cpu_timestamp_query_params(struct drm_file 
*file_priv,
         struct drm_v3d_timestamp_query timestamp;
         struct v3d_timestamp_query_info *query_info = 
&job->timestamp_query;
         unsigned int i;
-       int err;

         if (!v3d_validate_cpu_job(file_priv, job))
                 return -EINVAL;
@@ -747,7 +746,7 @@ v3d_get_cpu_timestamp_query_params(struct drm_file 
*file_priv,

         job->job_type = V3D_CPU_JOB_TYPE_TIMESTAMP_QUERY;

-       query_info->queries = kvmalloc_objs(struct v3d_timestamp_query,
+       query_info->queries = kvzalloc_objs(struct v3d_timestamp_query,
                                             timestamp.count);
         if (!query_info->queries)
                 return -ENOMEM;
@@ -758,32 +757,22 @@ v3d_get_cpu_timestamp_query_params(struct drm_file 
*file_priv,
         for (i = 0; i < timestamp.count; i++) {
                 u32 offset, sync;

-               if (get_user(offset, offsets++)) {
-                       err = -EFAULT;
-                       goto error;
-               }
+               if (get_user(offset, offsets++))
+                       return -EFAULT;

                 query_info->queries[i].offset = offset;

-               if (get_user(sync, syncs++)) {
-                       err = -EFAULT;
-                       goto error;
-               }
+               if (get_user(sync, syncs++))
+                       return -EFAULT;

                 query_info->queries[i].syncobj = 
drm_syncobj_find(file_priv,
                                                                   sync);
-               if (!query_info->queries[i].syncobj) {
-                       err = -ENOENT;
-                       goto error;
-               }
+               if (!query_info->queries[i].syncobj)
+                       return -ENOENT;
         }
         query_info->count = timestamp.count;

         return 0;
-
-error:
-       v3d_timestamp_query_info_free(&job->timestamp_query, i);
-       return err;
  }

It doesn't even compile, it's just a draft to give you a more concrete
example of what I'm thinking on.

[1] 
https://docs.kernel.org/process/submitting-patches.html#don-t-get-discouraged-or-impatient

Best regards,
- Maíra

> 
> Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp extension")
> Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performance extension")
> Cc: stable@vger.kernel.org
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Wang Xiaolei <wangxiaolei01@kaihong.com>
> ---
>   drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 1924e3440dc9..a96023b5dce0 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -106,6 +106,7 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
>   			drm_syncobj_put(query_info->queries[i].syncobj);
>   
>   		kvfree(query_info->queries);
> +		query_info->queries = NULL;
>   	}
>   }
>   
> @@ -122,6 +123,7 @@ v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
>   		}
>   
>   		kvfree(query_info->queries);
> +		query_info->queries = NULL;
>   	}
>   }
>   

