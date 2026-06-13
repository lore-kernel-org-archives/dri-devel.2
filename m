Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD51CD8CA8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 14:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B8ED10EDAE;
	Sat, 13 Jun 2026 14:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XiPAZgSM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033D10EDAE
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9vpd6CpkfDTmou82ohHmOyS0X3x/LVj8e/YdwE5l8VM=; b=XiPAZgSMT2l4QEyGJb2aBlBTAd
 JqHBWGvmfMms5A12cAtfcbjz+pO6Go8gTf+hJU7q7PYxhuSpGiZkNKHR9oAfoaerYCF3/X6hQ6Qby
 d2ffOrv7vLtiAfSWJtwEK59FpEjpV6CdNoDFcNIOKfJPQl6tRlZbzqBCWIRsxXHbOHMAMHarOeXmy
 b131vSCTIBD0qNXzZk3o6xYvLz/pZXqS0lX1KRBWALzxJ01LKAtEXe/gVfbiEqyybAfzLkVqRM/Sj
 fhRHrgOMWf0DucsC0e+5gcNJG/8m2QpjSLW6K07C6/uZTwFLBccnFj9x2Q8OS+2oaXWE6F0hE5qp8
 undjLm/g==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wYPGE-00H75Z-Ns; Sat, 13 Jun 2026 16:22:58 +0200
Message-ID: <b1d177a4-02eb-4925-969f-952860045e56@igalia.com>
Date: Sat, 13 Jun 2026 11:22:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/v3d: Associate BOs with every job that accesses
 them
To: Emma Anholt <anholt@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: Melissa Wen <mwen@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org
References: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
 <20260610-v3d-cpu-job-fixes-v1-1-0d9c88989edc@igalia.com>
 <4a83fb4434459846c2e2936e4bbd297b75d70af1.camel@igalia.com>
 <b61d3055e59f0c83ac5b72ddc0befd04@igalia.com>
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
In-Reply-To: <b61d3055e59f0c83ac5b72ddc0befd04@igalia.com>
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

Hi Emma,

On 12/06/26 14:44, Emma Anholt wrote:
> On 2026-06-10 23:17, Iago Toral wrote:
>> Hi Maíra,
>>
>> I have a couple of thoughts here:
>>
>> 1. The original code seems to very specifica about targeting this only
>> for the last job, which makes it look like a very intentional decision,
>> so I wonder if there is something we are missing here. I am adding Emma
>> to the CC in case she has any thoughts about it.
>>
>> 2. I am not aware of any issues despite not having implicit sync for
>> all the jobs in the chanin. Like you mention, this is because user-
>> space is already trying to handle job depedencies, so I wonder if we
>> should instead work on the opposite direction and try to drop implicit
>> sync in the kernel entirely. Would that make sense? What are other
>> drivers doing in this regard?
> 
> Yeah, you should be working toward dropping implicit sync entirely.
> tu's VM_BIND is really nice and where you want to be eventually, but
> even if not, then you at least want something like
> MSM_SUBMIT_NO_IMPLICIT.
> 

I believe the main issue we would have to implement something like
VM_BIND is the fact that V3D only has one global page table (that we
could switch on runtime, but it would come with the cost that all the HW
queues would only be able to operate on BOs from one client).

NO_IMPLICIT would be a more reasonable option.

> I probably just didn't think about this implicit sync case in the
> initial implementation, because a bin job dependency on results from
> another context is just not a thing that's going to happen in practice.
> The implicit sync was mostly about render targets / texturing to be
> ordered correctly with X11, and about lifetime management of the BO
> (which only needed the last use).
> 

But does it make sense to attach the implicit dependencies to the
CACHE_CLEAN job (last job) and not to the RENDER job or the CSD job?

Best regards,
- Maíra
