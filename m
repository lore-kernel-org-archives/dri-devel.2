Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53D7D39422
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4428210F26C;
	Thu,  2 Apr 2026 13:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="EtS9VRau";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF43810F26C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LEuQskG1iYvQyAT0EX7yk5PQZBXMChDmD8ovQ7R0yDU=; b=EtS9VRauYhkWCd0FqWEXNDF0XK
 +vIotq7dMkwZiQ7hUKUChtxoLKczcpEYPtHO3A8BjCihW8tHge4jV5KyFE3UT5OlyK1ixwMBveXTr
 1mzAn3+1VfPdXgaUc5Z78BB7qAJ4YAdBdubybtJ9I5xqVppPkjEruDapR+nhjVVqBAcHsb1tupd2B
 JkvCd/m7LgktWKP/+XHdkTiGWQ0Tu7C+K/zj8cbu+/sDO2f0ac4sug9QqYzCZBEz5gfB//LLWgEPk
 y2C2M2o2eJY8ZExY+btq37wPwBqGAtAAGAVfzgUTQ37xKjWChybRB14xMgqYq93ESx9XHbenTpRRi
 OUQEnc5w==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w8IAl-00AUFv-LS; Thu, 02 Apr 2026 15:33:23 +0200
Message-ID: <d2788318-a701-43c1-9107-d6f63df1d8cd@igalia.com>
Date: Thu, 2 Apr 2026 10:33:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drm/vc4: Miscellaneous fixes and improvements
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
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
In-Reply-To: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
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

On 30/03/26 14:51, Maíra Canal wrote:
> Hi,
> 
> This is a spin-off of the series "[PATCH 00/11] drm/vc4: Switch to DRM
> GPU scheduler" [1]. While I was writing the series, I noticed some small
> bugs in the driver code, so I compiled the fixes and code improvements
> in this series.
> 
> Patches #1 to #4 are bug-fixes related to PM reference unbalance, memory
> leaks, and race conditions. They will probably go through the
> drm-misc-fixes branch. Finally, patches #5 and #6 are minor clean-ups
> and common API adoption.
> 
> [1] https://lore.kernel.org/dri-devel/20260205-vc4-drm-scheduler-v1-0-c6174fd7bbc1@igalia.com/T/
> 
> Best regards,
> - Maíra
> 
> ---
> Maíra Canal (6):
>        drm/vc4: Release runtime PM reference after binding V3D
>        drm/vc4: Fix memory leak of BO array in hang state
>        drm/vc4: Fix a memory leak in hang state error path
>        drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock
>        drm/vc4: Use devm_request_irq() for automatic cleanup
>        drm/vc4: Clean-up UAPI header inclusion

Applied to drm-misc-fixes:

[1/6] drm/vc4: Release runtime PM reference after binding V3D
       commit: aaefbdde9abdc43699e110679c0e10972a5e1c59
[2/6] drm/vc4: Fix memory leak of BO array in hang state
       commit: f4dfd6847b3e5d24e336bca6057485116d17aea4
[3/6] drm/vc4: Fix a memory leak in hang state error path
       commit: 9525d169e5fd481538cf8c663cc5839e54f2e481
[4/6] drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock
       commit: 338c56050d8e892604da97f67bfa8cc4015a955f

Applied to drm-misc-next:

[5/6] drm/vc4: Use devm_request_irq() for automatic cleanup
       commit: 19e2815babd4c51a51ebabfe68daa90eb26309c3
[6/6] drm/vc4: Clean-up UAPI header inclusion
       commit: 4b9c36c83b34f710da9573291404f6a2246251c1

Thanks for the reviews!

Best regards,
- Maíra
