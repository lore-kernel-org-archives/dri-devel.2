Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00D606A895
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=j3bJ0+Si
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F187E10E78B;
	Fri, 13 Nov 2026 12:05:43 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E9610E78B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=HGa2LtN5SxQHGhVjL96Qry9kLjLjuk5ezesfPHD/LWg=; t=1794571537; x=2109931537; 
 b=j3bJ0+Sii17lhzEeJ5GqUrRd7NmUw+dF0GmILVK9u7oPQgXRoOHOoLte5o/qfoYPKa7rEwrY9gk
 ajMRNY1qlOgF4iaPfUwaVLHvesZjB9ImhHnxMig+nsIV7Z2QgwoOl0q3lneGccCiSVqCuiM8oHv3J
 7bMC6sHdFkHZsi99I6EQmFeHw44yXbA5L8TrE3bjQlidKIe52znx3y3K1agfoJy8JTNneVsj8w91X
 iFG2aoGPqEkc69n+KRV0TqQw9v2ICOp8aWAs8ro6RCrojoW+18s9De2iTZY0AmfpeKSi7MK8EjaMa
 eaHQjlRDakXFY5WQlWVZ3YfRnnPkeH1S8x4Q==;
Received: from [179.105.94.163] (helo=[192.168.0.4])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xRq1u-00AAIP-8O; Fri, 13 Nov 2026 13:05:18 +0100
Message-ID: <0738fac2-66c5-4c6f-ac53-d5fd038a2d96@igalia.com>
Date: Fri, 13 Nov 2026 09:05:10 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/12] drm/v3d: Add support for write-back cacheable
 BOs
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 JaeHoon Lee <dlwognsdc610@gmail.com>, kernel-dev <kernel-dev@igalia.com>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
 <1a1d009dddd.60725d0c103197.2638865837867497355@collabora.com>
 <20261112160947.44e88c66@fedora1.home>
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
In-Reply-To: <20261112160947.44e88c66@fedora1.home>
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Faith and Boris,

Thank you a lot for your feedback!

On 12/11/26 12:09, Boris Brezillon wrote:
> On Thu, 12 Nov 2026 08:54:29 -0500
> Faith Ekstrand <faith.ekstrand@collabora.com> wrote:
 >> [...]
>> Not entirely included in the mailing list discussion was why we
>> abandon this approach for panfrost/panthor:  CPU mapping shared
>> dma-bufs is tricky, especialy with non-coherent caching.  Gone are
>> the days when we dma-buf had an ownership concept and clients
>> properly bookended usage with begin/end.  With explicit cache
>> management, there are too many ways that one client can screw up
>> another if the BO is shared.
>>
>> The solution was to disallow BO sharing for any BOs that weren't
>> mapped write-combined or uncached. A number of DRM drivers already
>> have a concept of non-sharable BOs for locking reasons.  We simply
>> required that for write-back caching.
> 
> Hm, I think the confusion comes from the fact I kept this logic in
> panthor/panfrost, just made it panfrost/panthor specific. We also don't
> enforce !WB_MMAP on shareable at the KMD level, but we have it filtered
> out in panvk.
> 
> Honestly, I still have a hard time making sense of how this whole
> dma-buf sharing can work if importers/exporter clients are free to CPU
> map the thing without proper signalling of CPU accesses, and
> importers/exporter devices are not IO coherent (which is often the case
> on Arm SoCs). Yes, making the CPU mapping non-cached ensures that two
> CPU accesses from two clients can't step on each other, but there's
> still device <-> CPU synchronization I can't make sense of, especially
> if the importer doesn't know about CPU accesses done by the exporter
> and has device accesses that weren't flushed for some reason.

 From my understanding, with WC mappings, CPU accesses will bypass the
CPU caches, so there's no cache maintenance to signal and the device <->
CPU synchronization is reduced to waiting on fences (and trusting that
everybody is following the contract).

About "device accesses that weren't flushed", do you mean device-side
caches? If so, I'd expect the importer driver to flush them before
signaling its fence, regardless of the CPU mapping type.

> 
> Anyway, I'm happy to drop all the cpu_start/end implementation in
> panfrost/panthor if that helps clearing the confusion.
> 

Considering your feedback, I'll proceed with the following steps:

1. Drop patches [01/12] and [02/12], but keep [03/12], as we still need
drm_gem_shmem_sync();

2. Drop the begin/end_cpu_access() implementation in Panfrost/
Panthor and enforce in the kernel that WB_MMAP BOs can't be shared;

3. Follow the same idea for V3D.

Let me know if have any problems with this plan.

Best regards,
- Maíra

