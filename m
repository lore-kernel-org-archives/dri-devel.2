Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A58CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 22:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5AB810E9FD;
	Mon,  1 Jun 2026 22:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JifaOx9K";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC65510E9F1
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Reply-To:To:
 From:References:Subject:MIME-Version:Date:Message-ID:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v5ztsX8Qt/KGgT1kKuIJVZdwn8mIAqSwZwzeBf5Dwfk=; b=JifaOx9KP07VCcxqERRHtM3x/U
 Mq1PztbeKYhGktyr7F4S5FEvKuZad+tmjgKKBttcmygmCrhcXsq2xRKoDc3uD0ePw3dVnygSIeC+Z
 WtGfi7spjpRP/CTFq8n8QrHpn84LHi6L7Mw9UL9+EyClo2tBWcONMBBHpGj4Sjf86XowDZl8D+rpP
 N+XZNtikU/RMKuR0U0sPbai3U/+i7seOWDUWdLtOh/bm7xLkvk9aBUcbbyiCGuyZwztvyeVkeKSdH
 dWWqfaVGcCYDatwv8TaAoUxM10zRy1lYpEHezVVtPF71fb9VhEMDPyeeD6XoNT2ptsm/KqMaFYnOv
 kYsngKxg==;
Received: from [189.7.87.67] (helo=[192.168.0.2])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wUAgU-00BQ99-3M; Tue, 02 Jun 2026 00:00:34 +0200
Message-ID: <eb4cb238-05aa-4998-a098-516de49e8136@igalia.com>
Date: Mon, 1 Jun 2026 19:00:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [PATCH 0/4] drm/v3d: Fix RPi 4 system hangs from stale cache and
 MMU state
References: <31fc0cbbed1e844f179d87ab407511db8b4d8145.camel@igalia.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
To: DRI Development <dri-devel@lists.freedesktop.org>,
 Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>
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
In-Reply-To: <31fc0cbbed1e844f179d87ab407511db8b4d8145.camel@igalia.com>
X-Forwarded-Message-Id: <31fc0cbbed1e844f179d87ab407511db8b4d8145.camel@igalia.com>
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
Reply-To: 20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thanks, Iago!

- PATCH 1 was applied to drm-misc-fixes.
- PATCH 2 and 3 were applied to drm-misc-next-fixes.
- PATCH 4 was applied to drm-misc-next.

Best regards,
- Maíra

-------- Forwarded Message --------
Subject: Re: [PATCH 0/4] drm/v3d: Fix RPi 4 system hangs from stale 
cache and MMU state
Date: Mon, 01 Jun 2026 11:51:52 +0200
From: Iago Toral <itoral@igalia.com>
To: Maíra Canal <mcanal@igalia.com>

Thanks Maíra:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

Iago

El sáb, 30-05-2026 a las 15:37 -0300, Maíra Canal escribió:
> Some users have reported hard system hangs on the Raspberry Pi 4 (V3D
> 4.2)
> under GPU load [1][2][3]. Investigation had traced these to V3D
> caches and
> MMU being left in an inconsistent state across PM transitions. This
> series
> addresses three distinct issues in the cache and MMU maintenance:
> 
>   1. PATCH 1: Addresses an issue on pre-V3D 7.1 hardware, in which
>      starting a clean while an L2T flush is still pending can clobber
> bits
>      in L2TCACTL and leave the caches inconsistent. This issue
> existed
>      before the runtime PM series.
> 
>   2. PATCH 2: Fixes the MMU TLB/cache flush in
> v3d_mmu_set_page_table()
>      being silently skipped during runtime resume. Directly addresses
>      the system hangs reported by the users.
> 
>   3. PATCH 3: Cleans the V3D caches on runtime suspend, so all dirty
> lines
>      are written back to memory before the power domain is shut down.
>      Directly addresses the error `v3d fec00000.v3d: MMU error from
>      client L2T (7) at 0xff877600, pte invalid` reported during the
>      hangs.
> 
> Together these restore correct cache/MMU coherency around runtime PM,
> addressing the reported hangs. Moreover, with this fixes, it was
> possible
> to reduce the autosuspend delay, which was increased as the shorter
> delays
> used to cause more frequent runtime suspend/resume cycles, which
> exposed
> the cache and MMU coherency bugs as random GPU hangs. With those
> fixed,
> we can reduce the autosuspend delay to a more reasonable value.
> 
> [1] https://github.com/raspberrypi/linux/issues/7381
> [2] https://github.com/raspberrypi/linux/issues/7396
> [3] https://github.com/raspberrypi/linux/issues/7397
> 
> Best regards,
> - Maíra
> 
> ---
> Maíra Canal (4):
>       drm/v3d: Wait for pending L2T flush before cleaning caches
>       drm/v3d: Flush MMU TLB and cache during runtime resume
>       drm/v3d: Clean caches before runtime suspend
>       drm/v3d: Reduce PM runtime autosuspend delay
> 
>  drivers/gpu/drm/v3d/v3d_drv.c   |  2 +-
>  drivers/gpu/drm/v3d/v3d_gem.c   |  8 ++++++++
>  drivers/gpu/drm/v3d/v3d_mmu.c   | 31 ++++++++++++++++++++++---------
>  drivers/gpu/drm/v3d/v3d_power.c |  2 ++
>  4 files changed, 33 insertions(+), 10 deletions(-)
> ---
> base-commit: 61de054a772a1feda6364931ab1baf9038abf1c8
> change-id: 20260528-v3d-fix-rpi4-freezes-8bae519d04ce
> 
> 

