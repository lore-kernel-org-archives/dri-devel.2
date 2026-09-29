Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63CBCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1432410E1F9;
	Tue, 29 Sep 2026 21:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OUHHq+Bc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EA110E1F9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=k0i4xXQuBFgzC5FmgzEvBOZAZVEwv8KDOiSjD9LHxwM=; b=OUHHq+BcYDEGqBfDUCg05k24EF
 M5EMKRj41eJJ+hgYde5JNN4yXq4prDeJYYg9fm0spEEtqLfjH1hKPVm01e5n2zn180GaoydEi2muU
 h1/ee8LmIn2VVrLVVA3JLbSANc3kgfLZ7UoOhhBOoPhAcPY6AFUvgB5eCryHXuGThj2DDn5Wtany0
 xYDcNUextSWnQBAX91E0vsH61EjrQGpK+oQzhn5MQGZnPPlR/XjNkYA3wzw27fkVT74iwFUXm39Jo
 mXMtbpK0isBYV62oNPWOMHF6ujVAXRYP3H+MkduWj+kJx1BJZx5x/o/UWs+H2l2abWyLKOfmcAngc
 Bs9Ogy4Q==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xBfiu-0098QC-UG; Tue, 29 Sep 2026 23:50:53 +0200
Message-ID: <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
Date: Tue, 29 Sep 2026 18:50:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Fabio Piparo <holofermes@gmail.com>, Melissa Wen <mwen@igalia.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
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
In-Reply-To: <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Thomas,

On 29/09/26 06:04, Thomas Zimmermann wrote:
> (cc'ing v3d maintainers Maira and Melissa)
> 
> Hi
> 
> Am 23.09.26 um 18:00 schrieb Fabio Piparo:
>> Hi Thomas,
>>
>> Thanks for taking a look.
>>
>> On 14.09.26 10:43, Thomas Zimmermann wrote:
>>> I assume you write these frames quickly one after the other? As i2c is
>>> really slow, you might write to buffers that are still being transferred
>>> in the background.
>>>
>>> Do you read back the status of the page flips? DRM should tell you when
>>> it has completed transferring a frame. See [1]
>> The test renders with the GPU: two dumb buffers allocated on the
>> ssd130x device and shared with v3d over PRIME. It runs at 10 fps.
>> Before each flip it calls glFinish(), then flips with
>> DRM_MODE_PAGE_FLIP_EVENT and waits for the event before drawing into
>> the other buffer. The same test drawing with the CPU instead comes out
>> clean.
> 
> A number of things come to my mind.
> 
> - Dumb buffers (from ssd130x) are not meant for HW rendering. They are 
> generally for software rendering only.
> 

This reminded me of an issue I recently saw involving GPU rendering to
dumb buffers when combining simpledrm and Panthor. It had the same
symptom: this trail of glitches.

After investigating that issue, I noticed that, on platforms where the
GPU isn't DMA-coherent, when a shmem GEM buffer is exported via dma-
buf to a GPU for rendering, the CPU can read stale data from its cache
when later accessing the buffer, which manifests as rendering artifacts.

So, the GPU writes reach memory, but the CPU blit reads stale cache
lines. drm_gem_fb_begin_cpu_access() only syncs imported buffers, and
GEM dma_buf_ops have no begin/end_cpu_access, so nothing invalidates the
CPU cache before the blit and the CPU reads stale cached data.

I have a patch implementing begin/end_cpu_access to
drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm not sure
we would like to support this use case upstream because, as you
mentioned, dumb buffers are usually used for software-rendering only.
> - Hence, the ideomatic use for sharing graphics buffers is to model a 
> producer-consumer relationship. Export the buffer from the device that 
> generates the frame and import it to the buffer that displays it.
> 
> - Since you're compositor's sharing happens in the opposite direction, 
> ssd130x might not sync correctly. (I'm not sure of v3d requires a 
> dedicated flush.)
> 
> - Or maybe v3d needs to do a final cache flush after drawing to imported 
> buffers.

I don't think so...  Once the job completes, the GPU writes are in
memory. I believe the stale copy is in the CPU cache, so the
invalidation should happen on the CPU side.

Best regards,
- Maíra

> 
> If nothing else helpers, we could use map_wc for shared buffers in 
> ssd130x, but it seems like papering over something else.
> 
> Best regards
> Thomas
> 
> 
>>
>> I'm happy to send the test program if it would help.
>>
>> Best regards,
>> Fabio
> 

