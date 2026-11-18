Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFA60A260B
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=XcDQ3xHb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD2B10E128;
	Wed, 18 Nov 2026 17:39:22 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2360410E128
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=xAcgPMTJEReMCd2gp7JdMZhRq7Vy/sK0KQgL6Ave2gA=; t=1795023556; x=2110383556; 
 b=XcDQ3xHbjfY12aRfsvE9H+I3OMQT6miyOAZ7VFUnUQdGcwQO8zgUMEoyCUX24i8y8TIU8+H7c6v
 VDAX+jz2PJeGpNVEX68P5zhHowGm5PNQDFp+cMJtQEzXqYsTJXQrFhI3997FDpQE+KDsHDWkJ+YgF
 94JYe3Abm+CbOoQvqcwO10fZnZ2FmvP4SNEUFuSOBzwXSOu7cotfofgvUgOuceFC+yWSi2Ea/OVSJ
 I79jGH3mE4WvhjnfPYbqaAjWaCsnFzaInDdBEr/rRajA5i4+Idn3G41q6+SZ6ppryYBbE2/NLbV8e
 eCYHP2ruB9jnrb19pvkYS4rgo5IhFI+CQ2IQ==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xTjcl-000000017le-0NqJ; Wed, 18 Nov 2026 18:39:11 +0100
Message-ID: <1b78ef4b-011e-4174-800e-425c94fddf3a@igalia.com>
Date: Wed, 18 Nov 2026 14:39:05 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] drm/sched: Add drm_sched_entity_get_runtime()
To: phasta@kernel.org, Sidong Yang <sidong.yang@furiosa.ai>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Heiko Stuebner <heiko@sntech.de>,
 Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-2-sidong.yang@furiosa.ai>
 <34494226eb920bdbd7f3257ef6f9b20f4e8ffd6a.camel@mailbox.org>
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
In-Reply-To: <34494226eb920bdbd7f3257ef6f9b20f4e8ffd6a.camel@mailbox.org>
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 18/11/26 14:13, Philipp Stanner wrote:
> On Fri, 2026-11-13 at 02:11 +0900, Sidong Yang wrote:
>> The scheduler accumulates the time each entity's jobs spend on the
>> hardware for the fair policy, but drivers cannot read it. Export it so
>> drivers can report per-client engine time through fdinfo without
>> keeping their own counter.
>>
>> The stats object is refcounted and held by the entity and its jobs, so
>> unlike commit df622729ddbf ("drm/scheduler: track GPU active time per
>> entity"), which was reverted, accounting a job does not touch the
>> entity.
> 
> In general looks good to me, no objections.
> 
> But a question below:
> 
>>
>> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
>> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> 
> 
>> +u64 drm_sched_entity_get_runtime(struct drm_sched_entity *entity)
>> +{
>> +	struct drm_sched_entity_stats *stats = entity->stats;
>> +	ktime_t runtime;
>> +
>> +	spin_lock(&stats->lock);
>> +	runtime = stats->runtime;
>> +	spin_unlock(&stats->lock);
>> +
>> +	return ktime_to_ns(runtime);
> 
> Why not return it as ktime_t?
> 
> ktime_t, I suppose, is the universal time unit in the kernel, and the
> user can use one of the converters to turn it into whatever is desired.
> 
> With ns you would have to write the converters yourself.

Considering that the main use of this function by the drivers would be
fdinfo, I believe that ns makes more sense. Otherwise, all drivers would
need to convert to ns locally.

Maybe we could name it drm_sched_entity_get_runtime_ns()?

Best regards,
- Maíra

> 
> P.

