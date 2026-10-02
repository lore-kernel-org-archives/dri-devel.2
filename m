Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B962DCA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1721910E37A;
	Fri,  2 Oct 2026 21:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QpPBk64j";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751C010E053
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 21:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=h1H0FJL7OfJdsPvlOidQq1GEmGk1a3asZM5lDYa+uvE=; b=QpPBk64jWHhwoO3bjcLEvN5Bag
 Hm3mrwj0GS+5S3cGqMzMQLcF7MIaypwr8gv3ZBmMKkkQzgEuUz2ACmtf9eK86pro4w0ylx34aLmNB
 TVObLwG6lf4zQKPP0iMGds5Fwf/GzGCTB5/u9R7RRtS44HrR2XmlZfMuXLrkG9yV8HNmDy17pjxbC
 RRu6chmJiO1m2qx5lchsMRHUdiBOxkV40Ir8GZdKD1vjbC+PwI/Qc58kUtlRG67RlxIs4zRi7HFlH
 KZJIOj88nu9lLBlBPdtgnKxGamYLz5JxiwdyO3X0kKDpdEZznIhJf6UNPPy9OoI6iNhCdKbSEB9U/
 4y3YUQsw==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xCkZR-00Amwt-T4; Fri, 02 Oct 2026 23:13:34 +0200
Message-ID: <6820428b-64b8-4365-8117-d779fdc43af0@igalia.com>
Date: Fri, 2 Oct 2026 18:13:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Fabio Piparo <holofermes@gmail.com>, Melissa Wen <mwen@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>
Cc: dri-devel@lists.freedesktop.org
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
 <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
 <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
 <xlv1jyo2enyv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <3bfe2517-a5d3-4e86-99bd-6c28556f0f2d@igalia.com>
 <55914ef9-517d-48dd-a084-0f553f04cb8a@suse.de>
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
In-Reply-To: <55914ef9-517d-48dd-a084-0f553f04cb8a@suse.de>
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



On 02/10/26 05:12, Thomas Zimmermann wrote:
> Hi
> 
> Am 30.09.26 um 21:57 schrieb Maíra Canal:
>> + cc Chema (Mesa developer in V3D)
>>
>> Hi,
>>
>> On 30/09/26 12:52, Javier Martinez Canillas wrote:
>>> Maíra Canal <mcanal@igalia.com> writes:
>>>
>>> Hello Maíra,
>>>
>>>> Hi,
>>>>
>>>> On 30/09/26 05:32, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 30.09.26 um 09:48 schrieb Javier Martinez Canillas:
>>>>> [...]
>>>>>>>> I have a patch implementing begin/end_cpu_access to
>>>>>>>> drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm 
>>>>>>>> not sure
>>>>>>>> we would like to support this use case upstream because, as you
>>>>>>>> mentioned, dumb buffers are usually used for software-rendering 
>>>>>>>> only.
>>>>>>> Before we fix anything, I think we should talk to someone with
>>>>>>> dma-buf/PRIME credentials.  As I outlined, the ideomatic pattern 
>>>>>>> is a
>>>>>>> producer-consumer relationship and HW rendering into dumb-buffers 
>>>>>>> is not
>>>>>>> supported. Those buffers should have been allocated on the v3d side.
>>>>>>>
>>>>>>> IMHO we should write down these rules in the PRIME documentation and
>>>>>>> (soft-)enforce them in the implementation.
>>>>>>>
>>>>>> Yeah, I think either drm_gem_fb_begin_cpu_access() needs to also sync
>>>>>> exported buffers (what Maíra is proposing as a fix) or there 
>>>>>> should be
>>>>>> documentation of the rules for cross-devices buffer sharing through
>>>>>> PRIME.
>>>>>
>>>>> This specific case only happens with v3d and only this driver can know
>>>>> when to flush caches. If we flush caches in begin_cpu_access, we 
>>>>> easily
>>>>> end up paying the overhead on all systems.
>>>>>
>>>>
>>>> I believe that's the main issue. We would pay a reasonably big price to
>>>> support this uncommon (and maybe even wrong) use case.
>>>>
>>>> P.S.: To be clear, I wasn't proposing a fix. I should have called my
>>>> patch a "hack", because although it works, I don't believe we should
>>>> support this use case for the reasons stated by Thomas.
>>>>
>>>
>>> Yes, I agree with you. Making v3d to warn as Thomas suggested seems 
>>> to be
>>> the best compromise.
>>
>> I was thinking about Thomas' suggestion, and I might be missing
>> something. If v3d warns when rendering to imported buffers, it will
>> warn on every RPi 4/5, as Mesa renders the display path into dumb
>> buffers imported from vc4. That works because vc4 buffers are WC and
>> scanned out by hardware, so the CPU never reads them [1].
> 
> Oh, that's not good. It actually convinces me that v3d (and every other 
> driver) should have warned about this situation. See my example below.
> 
> 
>>
>> From my point of view, the issue here is cross-device sharing of a dumb
>> buffer that the exporter reads with the CPU through a cached mapping.
> 
> The whole workaround with WC doesn't fully capture the issue.
> 
> Imagine the renderer would have used discrete video memory (e.g. like on 
> an old PCI device). Rendering to an imported buffer would simply not 
> work at all. After rendering a frame into the video memory, the render 
> driver would have to memcpy the result from the video memory to the 
> imported buffer. This would need to be done on every frame because the 
> importer doesn't know when exactly the exporter requires the image. 
>   Sharing buffers in the other direction would work fine.  The importer 
> (now ssd130x) can always setup a page mapping from the dma-buf's 
> provided s/g table. The s/g table can refer directly to the video memory 
> on the PCI device.
> 
> 
>>
>> [1] Right after writing this paragraph, I decided to read the
>> documentation in drm_dumb_object.c and I found:
>>
>> * Note that dumb objects may not be used for gpu acceleration, as has 
>> been
>> * attempted on some ARM embedded platforms. Such drivers really must have
>> * a hardware-specific ioctl to allocate suitable buffer objects.
>>
>> Does anyone know why Mesa kmsro create dumb buffers for rendering? Maybe
>> I understood the documentation incorrectly, but it looks like we
>> shouldn't be doing that.
> 
> The first bullet point talks specifically about GPU acceleration. Mesa 
> creates dumb buffers for _software rendering_. Ssd130x scans out the 
> final result and transfers it to the panel. No GPU rendering involved 
> there.
> 

Mesa also uses dumb buffers for rendering. kmsro created dumb buffers as
render targets for several render-only GPUs, such as V3D, Panfrost,
Etnaviv, and others. You can check that in the function
renderonly_create_kms_dumb_buffer_for_resource().

I believe I don't have the full historical background to affirm if dumb
buffers should be used or not as render targets. If Mesa is using it for
so many years, it's probably not wrong.

Best regards,
- Maíra

