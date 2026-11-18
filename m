Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD75606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=dVEp9uVL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FE010FBE9;
	Wed, 18 Nov 2026 12:54:24 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B6110FBF7
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=snVU1uqD4hTlrRX9k1xzj/33svmeMLTwMOQ0/0pcN24=; t=1795006458; x=2110366458; 
 b=dVEp9uVLtA0pu8FxIecTCL9IJfAYV5WibzFM9+7gHV81tzyNkClVyp2RU0o9qF2xlOohF40bSAx
 Azd1AfVSYZA72GeTR8NVkVWpikMP24aTnYIs5ANaQjTzbczFSCLeZR3OpfgFxxcJKodh5/CTn6CSK
 Ous51/UBx5OJ0W2rZlIuDK15wYyAA68fNBA9A5/hFiIv8RwTApkKo3Z3Muu6WzmmfkbFCCfSeo6iw
 Ssm97VwOG0iIxYSI7jClAuoUMEAHNeKu2dzC5LJ+KEV4uykAH7r411LLmp0WZ5dXJn1dS4xyk8Hpz
 XGEyl8RQz4ax9nkoemsAwh5UUE6qkUiUZr4Q==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTfB2-000000010Xu-1j4R; Wed, 18 Nov 2026 13:54:16 +0100
Message-ID: <99676bca-eba1-46e8-a23a-923bffdc574e@igalia.com>
Date: Wed, 18 Nov 2026 09:54:12 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Fix double free of the sg_table when a PRIME
 import fails
To: Aleksei Riapolov <tsbol@icloud.com>, mwen@igalia.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261114164451.9222-1-tsbol@icloud.com>
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
In-Reply-To: <20261114164451.9222-1-tsbol@icloud.com>
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

Hi Aleksei,

On 14/11/26 13:44, Aleksei Riapolov wrote:

[...]

> 
> Hand the table back to its owner before freeing the object: with
> shmem->sgt cleared, drm_gem_shmem_release() leaves it alone and it is
> unmapped once, by the exporter, on drm_gem_prime_import_dev()'s error
> path. With this change the same test gets -ENOSPC from the failing
> import in each of three consecutive fills and the kernel log stays
> clean.

The issue you reported is real and makes sense, but your fix only treats
the symptom, not the problem.

V3D allocates the GPU address inside the gem_prime_import_sg_table()
callback, before the core marks the object as imported. No teardown
would be correct at that point.

I'd rather move the allocation after the import completes. Implement
.gem_prime_import as a wrapper around drm_gem_prime_import() and call
v3d_bo_create_finish() once it returns. At that point import_attach is
set, so drm_gem_object_put() takes the regular import teardown path,
which unmaps the sg_table once and detaches.

Best regards,
- Maíra

> 
> A reproducer is available on request.
> 
> Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksei Riapolov <tsbol@icloud.com>
> ---
>   drivers/gpu/drm/v3d/v3d_bo.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index db95a2f..48c7807 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -185,6 +185,14 @@ v3d_prime_import_sg_table(struct drm_device *dev,
>   
>   	ret = v3d_bo_create_finish(obj);
>   	if (ret) {
> +		/*
> +		 * obj->import_attach is only set by drm_gem_prime_import_dev()
> +		 * after we return, so drm_gem_shmem_release() would treat this
> +		 * object as native and unmap/free the attachment's sg_table,
> +		 * which the caller unmaps again on its error path. Hand the
> +		 * table back to its owner before freeing the object.
> +		 */
> +		to_v3d_bo(obj)->base.sgt = NULL;
>   		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
>   		return ERR_PTR(ret);
>   	}

