Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AE606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DseH5NgM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C105110F753;
	Tue, 17 Nov 2026 16:43:48 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7612410EE90
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:08:13 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso53226535e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794924492; x=1795529292;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v76ViL/fPpH3DxoDiLBNNmIXt8842BqFIg5AT4VdEnI=;
 b=DseH5NgMcVlpiy92yo63uT47zOTB/JkipKfKpK/eguf1jz83d5IKTuHg3BwbPgjjKW
 h8zdkEwEFlyE1wRIKSaMwJwZOD0fJImK0HjbOAuiGfLXFHhbCfZpmgMZGaneRjMmRZM+
 p8way3sArAWpuAzfXsxhmHLlEf8G9UCAZlpoVwskdn8V8IhUH6ABHf1j/KsrUWy6OG92
 1A1HhZtHnGKwgJmUhny1plLoaSjYuU0rPMvKHRIKL7jNJaoJrElSIQBYghrm9nzBl8yQ
 sah5b1+7jDTeQLEAxdRtyCj3A6MMFFAzMTqLSP5QLvgUPcoLur50VwWU++wodOTVF/nl
 IXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924492; x=1795529292;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v76ViL/fPpH3DxoDiLBNNmIXt8842BqFIg5AT4VdEnI=;
 b=Y+5ePf3ng3hk9jV4jkhC1Jb80f249NYclkKJHDpgtERfm/FFQ4qxWPMXsfF/IKFm6n
 /Ac2NFEozfM021C9AoTkv79pVr57GWM1R1i1+j/fX51lINKZZMWYfTH/Gfx6ks/wAX/1
 FqA64sJF0kQzRwW7++0PF2Tj9gXK1hjqgU3nFsm+8t56oNSSkYS7fKDzFMePsbS9f0Rd
 iev+yJHOQ3uJ9f8QAkdWLXYqbTw+NuKrbi3rdea1cNFgSogRVQsm3AAcjdIRqySXbxn+
 j4J7dqACuRVHFO4LL3G4byxnoCBHHuft269S7IC3yJiJIwuCcd9dnL2Dn/RTj1xiGugy
 GOUw==
X-Gm-Message-State: APuU4Z/0ftPNV3IkkUDlT4FRZFI8iu8I9EoBsG2o0mmDLIv0m1K4vRy/
 rXPhgIaKpAmyrFThSzG1t9bvVeDyk1gJU/SPtzx9R7AZPq9Z4OLxrpsj/dwPEF495dM=
X-Gm-Gg: AYBFou2LcUcIWyQpCA/JH8QPcL0/pebG4r2V2iYq01yMXlRON9QCR4YScpio14O/VoK
 Ocl4RXBTIdMKtmQ+7Rgg7W5rUhhGdiLXo3sMiK2/Gqy4kbCM9Br7xF5qhHpuEvj3BLIhmOA1SLi
 KtJhjaay4MuDxYYL5Slep5kGzu7fvdHYCHLCpo+27yRplqqAZomVzzGLaRE3YQT2yHnddu7WyGO
 pJSXzPYVIUVmgg7EUALR/kQnEUehTBxFJGZX65q+6ormPGJ0/qZORTO9pP9ATorOrGv0qlom4VI
 TxqxhWDmKP/+OnQcg1HKUb8yUQHqTUs8EfYeV8RWMyghO8jMy4Vc8+h0wXiKrSSkuKKMTpM/QxD
 fw6VGnxkOYuZjquFHU1aVR/en1UaIuLpLgnQgbcENpS9wgIMPEhW8mYHkrtIYuUvCVkZKicERWW
 bMXUPWRUajYWm2cwSarws84E4QYkMFp16JX33dYnW9dNKmEnIHtpinzejyXVnSozMJqDt6hJISD
 fpzgSQjHq8PHG/XT2a/RxHfVh5/vxmpZ5eRpL8hbdUEMkt67VOsLhPZ9HGk0UiJ986masUhvPVF
 EhauiRR2Ul+fhBtWBjimTpjlfz5OGVQ7mgKCse+ia4w59FlgqOPArRyLGQ36j+vnajiAAjLyXPV
 2Sw==
X-Received: by 2002:a05:600c:1daa:b0:4a1:d087:f6ab with SMTP id
 5b1f17b1804b1-4bb55a4ea8emr285441765e9.18.1794924491662; 
 Tue, 17 Nov 2026 06:08:11 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb69ac4e16sm187624005e9.0.2026.11.17.06.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 06:08:11 -0800 (PST)
Message-ID: <13cf246c-2fc9-4076-92b3-fd953337099e@baylibre.com>
Date: Tue, 17 Nov 2026 14:08:10 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/rocket: fix NULL derefs and missing error check
To: Ali Khaledi <ali.khaledi1989@gmail.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <20260301182428.82981-1-ali.khaledi1989@gmail.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <20260301182428.82981-1-ali.khaledi1989@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 17 Nov 2026 16:43:43 +0000
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

The subject says 3/3 but I only see one patch submitted.

On 01/03/2026 18:24, Ali Khaledi wrote:
> Fix several issues in the rocket accelerator driver:
> 
> rocket_gem.c: Add missing error check after
> drm_mm_insert_node_generic(). The return value was silently
> overwritten by iommu_map_sgtable(), causing DMA mapping to use
> an uninitialized IOVA on MM insertion failure.
> 
> rocket_job.c: Add missing NULL check after kvmalloc_array() in
> rocket_job_push(). A large job can trigger allocation failure,
> leading to NULL pointer dereference in the following memcpy.
> 
> rocket_job.c: Add missing NULL check after kmalloc_objs() in
> rocket_job_open(). Also fix memory leak of the scheds array
> when drm_sched_entity_init() fails.

You could reduce the verbosity of this commit message - no need to show 
filenames, and you can limit it just to pointing out what is not obvious 
from the code change itself.

> Found by AI-assisted code review (Claude Opus 4.6, Anthropic)
> in collaboration with Ali Khaledi.

No need for this statement; if you understand the code and your proposed 
changes, then submit it without crediting an agent. If you don't 
understand it, then refrain from submitting until you personally can 
stand behind your contribution.

> Signed-off-by: Ali Khaledi <ali.khaledi1989@gmail.com>
> ---
>   drivers/accel/rocket/rocket_gem.c | 2 ++
>   drivers/accel/rocket/rocket_job.c | 9 ++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
> index b6a385d2e..7212edc3f 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -95,6 +95,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
>   					 rkt_obj->size, PAGE_SIZE,
>   					 0, 0);
>   	mutex_unlock(&rocket_priv->mm_lock);
> +	if (ret)
> +		goto err;
>   
>   	ret = iommu_map_sgtable(rocket_priv->domain->domain,
>   				rkt_obj->mm.start,
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index ac51bff39..6502b7148 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -192,6 +192,8 @@ static int rocket_job_push(struct rocket_job *job)
>   
>   	bos = kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(void *),
>   			     GFP_KERNEL);
> +	if (!bos)
> +		return -ENOMEM;
>   	memcpy(bos, job->in_bos, job->in_bo_count * sizeof(void *));
>   	memcpy(&bos[job->in_bo_count], job->out_bos, job->out_bo_count * sizeof(void *));

These two have already been fixed in other commits.

> @@ -501,6 +503,9 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
>   	unsigned int core;
>   	int ret;
>   
> +	if (!scheds)
> +		return -ENOMEM;
> +
>   	for (core = 0; core < rdev->num_cores; core++)
>   		scheds[core] = &rdev->cores[core].sched;
>   
> @@ -508,8 +513,10 @@ int rocket_job_open(struct rocket_file_priv *rocket_priv)
>   				    DRM_SCHED_PRIORITY_NORMAL,
>   				    scheds,
>   				    rdev->num_cores, NULL);
> -	if (WARN_ON(ret))
> +	if (WARN_ON(ret)) {
> +		kfree(scheds);
>   		return ret;
> +	}
>   
>   	return 0;
>   }

This issue still stands but I would encourage you to do a deeper fix if 
continuing your work here. Even in the non-error path if num_cores is 1 
for any reason, it looks like drm will not set sched_list, so the memory 
will be leaked there too. I think we need a better strategy for handling 
the scheds.

Daniel

