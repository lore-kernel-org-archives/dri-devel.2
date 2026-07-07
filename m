Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD50C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88DD10E515;
	Tue,  7 Jul 2026 22:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HuEmLrdX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0451410E515
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 22:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zpEXsXF8x7+EJDV03HN3+nO4q487/a7bD8ENQmhz2vE=; b=HuEmLrdXF1XL8p69Umj4eca6cD
 7/BnQD0ufNk7ptbVVflCSgdqYb574PUyRQXq7kQoeJ2P/vqe0SgFllcszLDb+BfGJwxW4d8T3NDuv
 Gi6YFottBodQ25zMMNHbfYKQiaxy1fRGQuPwgvfWuNYWLz9AZXnMw744mqGENbRyHHB8EQjqGkjkl
 Ot+HJEpoKwh6mI9mTXVEiQyMUn+HnYM+46x/w8dOJKUlo+hohaHYJonV4f9nnI3dKJgTWwuliNah1
 ot/vf0rx+ZN24WEy5LDk1d3rEPvrhwFxBvZQWi2L5NiL9JjnHcYbV/LIaWCRaZeHoXx37JAlDAozv
 9g7SJ2SQ==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1whDqQ-00B4tL-Nw; Wed, 08 Jul 2026 00:00:46 +0200
Message-ID: <46813874-6db9-449f-8e85-3ebccb96b97d@igalia.com>
Date: Tue, 7 Jul 2026 19:00:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drm/v3d: Miscellaneous fixes
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
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
In-Reply-To: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
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

On 03/07/26 12:33, Maíra Canal wrote:
> Being brief, this small series collects a correctness fix (#1) reported by
> Sashiko, a error-path fix (#2) reported by Sashiko, and a cleanup (#3)
> found while reading the code.
> 
> The first patch is the only notable one: a v3d submission expands into a
> chain of jobs (e.g. BIN + RENDER + CACHE CLEAN), but the BO list was only
> ever attached to the last job. Since implicit synchronization is added
> per-job and gated on job->bo_count, every job before the last one silently
> skipped implicit dependencies. In practice the RENDER job could read a
> buffer object while another context was still writing it. It's fixed by
> looking up the BOs onto every job that references them.
> 
> Best regards,
> - Maíra
> 
> To: Melissa Wen <mwen@igalia.com>
> To: Iago Toral Quiroga <itoral@igalia.com>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> Cc: kernel-dev@igalia.com
> Cc: dri-devel@lists.freedesktop.org
> 
> v1 -> v2: https://lore.kernel.org/r/20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com
> 
> - [1/3] Don't attach implicit dependencies to BIN jobs (Iago Toral)
> - [2/3, 3/3] Add Iago's R-b (Iago Toral)
> 
> v2 -> v3: https://lore.kernel.org/r/20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com
> 
> - [1/3] Add a comment clarifing why we don't attach BOs to BIN jobs (Iago Toral)
> - [1/3] Add Iago's R-b (Iago Toral)
> 
> ---
> Maíra Canal (3):
>        drm/v3d: Associate BOs with every job that accesses them
>        drm/v3d: Reject invalid indirect BO handle in indirect CSD setup
>        drm/v3d: Use write_to_buffer() helper in performance query copy
> 
>   drivers/gpu/drm/v3d/v3d_sched.c  | 11 ++--------
>   drivers/gpu/drm/v3d/v3d_submit.c | 44 +++++++++++++++++++++++-----------------
>   2 files changed, 27 insertions(+), 28 deletions(-)


Patches #2 and #3 were applied separately to drm-misc-fixes and drm-
misc-next, respectively, as I still need to address an issue pointed
by Sashiko in PATCH #1.

Best Regards,
- Maíra

> ---
> base-commit: 903f8773ee96c5dc5fb9aec65227f39fd3e7a1dc
> change-id: 20260609-v3d-cpu-job-fixes-fbe2051bee3a
> 

