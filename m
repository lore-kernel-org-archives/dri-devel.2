Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED8606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=BUldVeoV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F37E10E013;
	Fri, 20 Nov 2026 15:31:34 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1498F10E64F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=EkXZISUgyp8P5fx5QB4QsAetPzLwfV+83m+18GaFq90=; t=1795188688; x=2110548688; 
 b=BUldVeoV3vPOwpTPL6KOI3zFBFOUBfRp81KK3t6MyjiCq2vZ+u6sMQq/VLz/Dd9mJ/5MaPuTU2I
 4LQYobE+F7U2gLP0GhVybpTLKGKFMFu0gZgMu+YZ299Z8VH3SauayAVAavcYlVlqMGuWfPNlnjh/l
 uUeW66fPk8bAOtRsLegvDlgbqUIOI1cnL8KluEEdO+k4NI6S7A6g0t3UDgiLIeidqv6xR5tdSJnVn
 7KDcJx6CcoiKym8FX3VMiS4LU5gH0TaMFGXP3sQUzCeU7h1niE9W67dOmNKsCPBPzy8crvRiHCmcF
 N9vQ/N/TsWxppUumetaEbBzW2M6MYWBBnXWA==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xUQaB-00000001vSC-0jax; Fri, 20 Nov 2026 16:31:23 +0100
Message-ID: <c2c39d36-70ec-4623-9d21-639622cef80a@igalia.com>
Date: Fri, 20 Nov 2026 12:31:17 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] accel/rocket: Report NPU usage through fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, Heiko Stuebner <heiko@sntech.de>,
 Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261120141225.789350-1-sidong.yang@furiosa.ai>
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
In-Reply-To: <20261120141225.789350-1-sidong.yang@furiosa.ai>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sidong,

On 20/11/26 11:12, Sidong Yang wrote:
> Report how much of the NPU each client uses through fdinfo. Patch 1
> exports the runtime the scheduler already accounts per entity, and patch
> 2 uses it for rocket's drm-engine-npu key.
> 
> v6: Rename the getter to drm_sched_entity_get_runtime_ns() (Maíra
>      Canal). Report rdev->num_cores, the cores that are bound, as the
>      capacity instead of rdev->max_cores, and skip the key once no core
>      is left as a capacity of zero is not allowed (Maíra Canal). Add
>      tags.
> v5: Use the entity runtime from the new drm_sched_entity_get_runtime()
>      instead of a counter in rocket (Tvrtko Ursulin). Reviewed-by tags
>      are not carried as the accounting changed. Based on drm-misc-next.
> v4: Single drm-engine-npu key with drm-engine-capacity-npu, and
>      documentation (Tomeu Vizoso).
> v3: Add a rocket_engine_usage_create() helper (Gyeyoung Baek).
> v2: Size the per-core counters by rdev->max_cores.

For both patches,

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best regards,
- Maíra

> 
> Link to v5: https://lore.kernel.org/all/20261112171144.3151554-1-sidong.yang@furiosa.ai/
> Link to v4: https://lore.kernel.org/all/20261103155338.1949294-1-sidong.yang@furiosa.ai/
> Link to v3: https://lore.kernel.org/all/20261103104804.1887489-1-sidong.yang@furiosa.ai/
> Link to v2: https://lore.kernel.org/all/20261101152723.1430312-1-sidong.yang@furiosa.ai/
> Link to v1: https://lore.kernel.org/all/20261031083642.1076356-1-sidong.yang@furiosa.ai/
> 
> Sidong Yang (2):
>    drm/sched: Add drm_sched_entity_get_runtime_ns()
>    accel/rocket: Report NPU usage through fdinfo
> 
>   Documentation/accel/rocket/index.rst     | 29 ++++++++++++++++++++++++
>   Documentation/gpu/drm-usage-stats.rst    |  1 +
>   drivers/accel/rocket/rocket_drv.c        | 25 +++++++++++++++++++-
>   drivers/gpu/drm/scheduler/sched_entity.c | 25 ++++++++++++++++++++
>   include/drm/gpu_scheduler.h              |  1 +
>   5 files changed, 80 insertions(+), 1 deletion(-)
> 
> 
> base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40

