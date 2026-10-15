Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC8CCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A7C10E08A;
	Thu, 15 Oct 2026 19:45:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FF010E08A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=2qg4EGv8SzH/hJeodG6d/ZUHhRUtxEQJwn7UpbJlRRo=; b=lA8q2/MtlUFErKF+zHBb3BP9/4
 1xVwh+S7hOCaYi7GT/6WviA9iVqCe1QHsHh+AZJ7WeYXv7fvOSM+kSPhiy0E9MRIx5evxKS3DOESF
 WlN19gpDncwauQubkCOtnNLY+o6XQeIXTKtRSyRdrVrxNpZosBaOQ0xsnOVAAeJBWYdDHt3wW9+00
 sw35r9vW6OiI3t52bXZjBwa0qcJtQR2RU1ONW0pfcZ0hCfbHx4GDAbsMSEQhk9IKP+s6/o9a6R/jr
 Ly28o+/mvrjBEbCwgfmofeO2uGQyZE61w7cv1DpEZVelHh8FTUGv2s/h+P9JAv69Fj7jfFL9JBc1v
 k/xebsYQ==;
Received: from [179.105.94.163] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xHROR-000i7A-Td; Thu, 15 Oct 2026 21:45:39 +0200
Message-ID: <d6800fd5-73c8-40e4-9470-0db7e72694fd@igalia.com>
Date: Thu, 15 Oct 2026 16:45:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] drm/vc4: Attach the job fences outside of job_lock
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
 <20261004-vc4-misc-fixes-v1-5-b763df9e33e1@igalia.com>
 <ac9b63c893795494d2b2ec128d3974713fdcc70d.camel@igalia.com>
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
In-Reply-To: <ac9b63c893795494d2b2ec128d3974713fdcc70d.camel@igalia.com>
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

Hi Iago,

On 13/10/26 04:28, Iago Toral wrote:
> El dom, 04-10-2026 a las 12:42 -0300, Maíra Canal escribió:
>> vc4_attach_fences() adds the job fence to the reservation of every BO
>> the
>> job touches, which is a O(bo_count) walk under job_lock. It was there
>> because vc4_exec_info could be freed by the job done worker the
>> moment the
>> lock was dropped.
>>
>> As vc4_exec_info is refcounted now, hand the fences over after the
>> unlock.
>>
>> Note that the render done handler dropped the fence as soon as the
>> job
>> completed, so the walk could find exec->fence already cleared. Leave
>> the
>> fence to be dropped by the release path. The submit path no longer
>> needs
>> a reference of its own to publish the fence through the sync object
>> either.
>>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/gpu/drm/vc4/vc4_gem.c | 23 ++++++-----------------
>>   drivers/gpu/drm/vc4/vc4_irq.c |  5 +----
>>   2 files changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c
>> b/drivers/gpu/drm/vc4/vc4_gem.c
>> index 9cf343297f83..ae76868663ea 100644
>> --- a/drivers/gpu/drm/vc4/vc4_gem.c
>> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
>> @@ -639,14 +639,6 @@ vc4_queue_submit(struct drm_device *dev, struct
>> vc4_exec_info *exec,
>>   
>>   	kref_get(&exec->refcount);
>>   
>> -	/* The job can complete and drop exec->fence as soon as
>> job_lock is
>> -	 * released, so hold our own reference.
>> -	 */
>> -	if (out_sync)
>> -		dma_fence_get(&fence->base);
>> -
>> -	vc4_attach_fences(exec);
>> -
>>   	list_add_tail(&exec->head, &vc4->bin_job_list);
>>   
>>   	/* If no bin job was executing and if the render job (if
>> any) has the
>> @@ -663,12 +655,12 @@ vc4_queue_submit(struct drm_device *dev, struct
>> vc4_exec_info *exec,
>>   
>>   	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
>>   
>> +	vc4_attach_fences(exec);
>> +
> 
> Similar question as before: doesn't this mean we may submit this job
> before we have installed the fences in the BO reservations? Wouldn't
> that mean there is a small window where the BOs look idle to other
> users when they are in fact being used by the GPU?
> 

In this case, the window exists, but it isn't observable in a way that
actually matters. The reservations stay locked until drm_exec_fini(),
which runs after the fences are attached, so anyone taking the resv
lock, including another submit touching the same BOs, waits for them.
Other drivers, such as V3D and Panfrost, follow the same pattern: push
jobs -> attach fences -> replace the out syncobjs fences.

Best regards,
- Maíra

