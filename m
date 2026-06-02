Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF78CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835E8113AC4;
	Tue,  2 Jun 2026 15:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VqDwc26l";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA65113ACD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gUVSKwfXoDQWWYjbnImaSuYzSG5fVumw99xAgXWy0Y=; b=VqDwc26l/NKWX9wAgGt68uwI49
 E4PdDKZorM/nSc9D2W3K1MTIWJu7O2/a6NjYDlJQtx4xhvI2IqJQer0FrEVD87c+OTBUwRiD5t69q
 0hbsyrpOAcEsa4cz3++OFqHFCo4AJX/karnsad8eil5IHRKOKaQzTAQTg5+JQUgeL24oPN3Q/76Df
 Kb0VRB7FlBh05riQKQif4/79cbguXdGMqfHDGszZfylq39TkjRxZKZ6K2mGS3NFaHr3vh9kKCCTSp
 N7KZNFD07pYAv4BAPdB6orOMpC6+ZOcRf1pPjhl2bQ15X0wKe3UK7QmVSCXrxbbfUmnY/U/dZs9gE
 XDvIwNsg==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wURM4-00Bm8U-Up; Tue, 02 Jun 2026 17:48:37 +0200
Message-ID: <42de0186-0f96-4c0d-b51f-f449f931e723@igalia.com>
Date: Tue, 2 Jun 2026 12:48:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: fix to avoid cleaning up uninitialized CPU jobs
To: Jeongjun Park <aha310510@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
References: <20260525140422.1545327-1-aha310510@gmail.com>
 <9956a72e-57ad-4bad-a3f6-87710eb4924d@igalia.com>
 <CAO9qdTGB=7K0SJCiCpP9TYOk_3Z6wETM43m49FqvD6iw9ApOEA@mail.gmail.com>
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
In-Reply-To: <CAO9qdTGB=7K0SJCiCpP9TYOk_3Z6wETM43m49FqvD6iw9ApOEA@mail.gmail.com>
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

Hi Jeongjun,

On 02/06/26 12:41, Jeongjun Park wrote:
> Hi Maíra,
> 
> Maíra Canal <mcanal@igalia.com> wrote:
>>
>> Hi Jeongjun,
>>
>> On 25/05/26 11:04, Jeongjun Park wrote:
>>> The CPU submit ioctl checks cpu_job->job_type before the CPU job has been
>>> initialized with v3d_job_init(). When no CPU job extension is supplied,
>>> the check fails and the ioctl goes to the common error path.
>>>
>>> That path calls v3d_job_cleanup(), which expects a fully initialized
>>> v3d_job. However at this point the CPU job has only been allocated,
>>> so the embedded DRM scheduler job state has not been initialized yet.
>>>
>>> Initialize the CPU job after parsing extensions, but before validating
>>> the CPU job type and BO count. Keep pre-initialization failures on a
>>
>> Considering that this is a minimal fix for stable, could you explain me
>> why do you believe moving v3d_job_init() is the best solution?
>>
> 
> Because according to the implementation of v3d_submit_cpu_ioctl(),
> v3d_job_cleanup() should never be called when v3d_job_init() fails to
> execute successfully, but it is currently being called.
> 
> Therefore, I called the init function before the job_type check and added
> the missing v3d_job_deallocate(), which should be called when
> v3d_get_extensions() fails. However, upon re-analysis, it appears that
> adding the fail_init label is unnecessary now, and I have discovered
> another serious issue.
> 
> If v3d_job_init() fails after v3d_get_extensions() succeeds, a memory leak
> may occur in the memory allocated by v3d_get_extensions(). In such cases,
> v3d_job_cleanup() cannot be called, and consequently, v3d_cpu_job_free()
> cannot be used either. Therefore, it seems necessary to add a separate
> helper function to handle this case.
> 
> I will quickly write a v2 patch reflecting these changes.

I wouldn't worry a lot about this particular issue, as I already
addressed it in [1].

[1] 
https://lore.kernel.org/dri-devel/20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com/T/

Best regards,
- Maíra

> 
>> Best regards,
>> - Maíra
>>
> 
> Regards,
> Jeongjun Park

