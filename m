Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E9BCA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E1110F41A;
	Wed, 30 Sep 2026 13:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="sujNf0Hb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ADF10F41A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=AlDA3CPqsRh/rGxDenJg9W0cfItR8cQBugDBRNACtuk=; b=sujNf0Hb8oOTg+9mBB8JtsFZI/
 YyElfyRziidNbxNMmDp+snq9a0MPnLkzbWgzB2jgdKQbjWUGPEsAykWSdKj+ePCunDvGo7yMvmGYx
 ybG0sOukkbARpUnv05RBoMj1qfcSNJpJnxWX78KHbBoFcBOc6dqIClfR7XdOf582UwpfIKfn+yA1f
 2fQSN3fu8isZNrjDFGQSqBYdetQULKLpTsy3dmDZ7rHh1BdufACJof5mjXUYJsq7UNharkEllVMIM
 m9AG85fDmeQohg/jGRvdWwcRMXMeY1BYWfxA/YFDUil+8yadQ0OuS3i+2f558CByBScjGyMlWIw+Z
 ZSApMQaA==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xBugq-009Sou-Pb; Wed, 30 Sep 2026 15:49:44 +0200
Message-ID: <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
Date: Wed, 30 Sep 2026 10:49:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Fabio Piparo <holofermes@gmail.com>, Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
 <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
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
In-Reply-To: <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
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

Hi,

On 30/09/26 05:32, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.09.26 um 09:48 schrieb Javier Martinez Canillas:
> [...]
>>>> I have a patch implementing begin/end_cpu_access to
>>>> drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm not sure
>>>> we would like to support this use case upstream because, as you
>>>> mentioned, dumb buffers are usually used for software-rendering only.
>>> Before we fix anything, I think we should talk to someone with
>>> dma-buf/PRIME credentials.  As I outlined, the ideomatic pattern is a
>>> producer-consumer relationship and HW rendering into dumb-buffers is not
>>> supported. Those buffers should have been allocated on the v3d side.
>>>
>>> IMHO we should write down these rules in the PRIME documentation and
>>> (soft-)enforce them in the implementation.
>>>
>> Yeah, I think either drm_gem_fb_begin_cpu_access() needs to also sync
>> exported buffers (what Maíra is proposing as a fix) or there should be
>> documentation of the rules for cross-devices buffer sharing through 
>> PRIME.
> 
> This specific case only happens with v3d and only this driver can know 
> when to flush caches. If we flush caches in begin_cpu_access, we easily 
> end up paying the overhead on all systems.
> 

I believe that's the main issue. We would pay a reasonably big price to
support this uncommon (and maybe even wrong) use case.

P.S.: To be clear, I wasn't proposing a fix. I should have called my
patch a "hack", because although it works, I don't believe we should
support this use case for the reasons stated by Thomas.

Best regards,
- Maíra

> 
>>
>> As mentioned, allocating buffers through v3d and importing into ssd130x
>> (or simpledrm) would work correctly, since the v3d driver already sets
>> bo->base.map_wc = true.
> 
> Hard enforcement would mean that drivers would reject to render to 
> imported buffers.  It is most certainly too late to implement this now. 
> But drivers such as v3d could at least print a warning when users 
> attempt to do it.
> 
> Best regards
> Thomas
> 
> 
>>
> 

