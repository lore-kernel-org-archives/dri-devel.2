Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85DCC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C1210F5C4;
	Thu,  3 Sep 2026 13:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MYVdmgak";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEF610F5BE
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Y8j/ITVlOQxPRVqu5jSrEwrkx7x0SuDALimgCrujisk=; b=MYVdmgaktCtsAPnBXcEec/G3MY
 NxorhytiJ0rz4vfZR8d5ztfXHixOFjQqNFb0FkhZihK9n6T4HtTtotpaDZcuSaPld+ASw8hrT2ITC
 RCXAcXlnJfhY9/GtktBhfVfL3/AuquN2Ors0H+6+gCLzypjcq1Z0/x8AM3onQkENgRYaxbq2vGzcG
 voUJNaWFZw4i62eEk2HeZWnXyHC85rrX+BsBdZXW3OW10/ZW//Ypo4Qs8gebFzynXEkmu4okehvTx
 fQ9SnaMfzhOhy/M3TbMj12OIetYhQnsZVW7frOQvDneKD3kNYZ8qCtHZNgDLXkdn/SKe395/SvGHx
 H8/tesPg==;
Received: from [179.105.94.163] (helo=[192.168.0.6])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x27eq-00EO8X-3D; Thu, 03 Sep 2026 15:39:12 +0200
Message-ID: <a096712c-8bc6-4cb5-94ca-6a82525f1bad@igalia.com>
Date: Thu, 3 Sep 2026 10:39:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/vc4: Reset the V3D block through the reset
 controller
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
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
In-Reply-To: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
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

Florian, Stefan and other Broadcom engineers, any thoughts about this
series?

Best regards,
- Maíra

On 16/08/26 11:05, Maíra Canal wrote:
> vc4_reset() recovers a hung GPU by dropping the runtime PM usage count to
> zero so that the V3D power domain goes down, and then taking it again.
> Forcing the count to zero only works if the driver knows exactly how many
> references it holds, which is why vc4 unconventionaly wraps every
> pm_runtime_get_sync() call in a private refcount and mutex, making the
> code cumbersome.
> 
> The BCM2835 PM block has exposed a reset line for the V3D block since
> commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains
> under a new binding."), added for exactly this reason, but vc4 never
> picked it up. This series switches vc4 over to it and drops the private
> refcount, leaving vc4_v3d_pm_get/put() as plain runtime PM wrappers.
> 
> The reset line is optional, so device trees that do not describe one keep
> working: they get the driver-side recovery in vc4_irq_reset() while the
> hardware is left untouched. Of the two in-tree platforms,
> 
>    1. BCM2835 gains the property in PATCH 4.
>    2. Cygnus has no V3D power domain to begin with, so the power-cycle
>       only ever gated its clock there.
> 
> PATCH 1 is an independent cleanup. "brcm,vc4-v3d" was never documented
> and was never used by any in-tree device tree, so it is a candidate for
> removal on its own. It can be dropped from the series if it turns out
> to be contentious.
> 
> This series was tested on the Raspberry Pi 3B and 3B+.
> 
> Best regards,
> - Maíra
> 
> ---
> Maíra Canal (4):
>        drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
>        dt-bindings: display: bcm2835-v3d: Add an optional reset line
>        drm/vc4: Use the reset controller to recover from a GPU hang
>        ARM: dts: bcm2835: Add the V3D reset line
> 
>   .../bindings/display/brcm,bcm2835-v3d.yaml         |  3 ++
>   arch/arm/boot/dts/broadcom/bcm2835-common.dtsi     |  1 +
>   drivers/gpu/drm/vc4/vc4_drv.c                      |  1 -
>   drivers/gpu/drm/vc4/vc4_drv.h                      | 13 ++++---
>   drivers/gpu/drm/vc4/vc4_gem.c                      | 40 +++++++++++++---------
>   drivers/gpu/drm/vc4/vc4_irq.c                      |  7 ++--
>   drivers/gpu/drm/vc4/vc4_v3d.c                      | 37 +++++++-------------
>   7 files changed, 51 insertions(+), 51 deletions(-)
> ---
> base-commit: 09b47186a4164f3aaa3591313f80794443117342
> change-id: 20260812-vc4-reset-control-cddf3eb8a9e9
> 

