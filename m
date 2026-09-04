Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB93C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC9110E111;
	Fri,  4 Sep 2026 10:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="e0GJjNnZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87FD010FA1D;
 Fri,  4 Sep 2026 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=RDDngeAIKe+f5EvS1FEKVBgkCeJzpwonOcdVh5d0lgQ=; b=e0GJjNnZpp7O8L+8Ah6Md5d7TZ
 I0ceRJbu2iU82A6S221HbM3/18UmIhgdhTPqCA/GDcKycKn1hKWA+l4RWZjh6qhqds+VxF2TPw/6I
 JgBnjS3mQTqSS9iM7jN9UvtgxZIA27K+QqntoNSRIDwbWpl+OXi2fPbOTbSbpheese4aejUyJXOCD
 QBqbVC8Xm/SEYsk3LhazeeMTtXZzPC7csP9nllvi80ETYFIkrVVYze/THEul1RCyM6mkkFhQogrrI
 xFbVRaDE1LgPunQTrblDBh/aAM9raq0F0F2UXO58KMbBTz41YYXLJUbqVT+V7iF5xXln7xlmVXdRJ
 NZt45vCw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x2Qj4-00Eozt-9x; Fri, 04 Sep 2026 12:00:50 +0200
Message-ID: <8bc27494-ca97-4e21-9710-c9f88b169a6c@igalia.com>
Date: Fri, 4 Sep 2026 11:00:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v6 5/9] lib/amdgpu: add amdgpu_cgroup_region_name
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 kernel-dev@igalia.com
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
 <20260903-dmem_max-v6-5-61dc62970fae@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-5-61dc62970fae@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 03/09/2026 23:00, Thadeu Lima de Souza Cascardo wrote:
> The amdgpu dmem region name uses its PCI address, just like the one from
> Xe, but there is only a single VRAM region.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   lib/amdgpu/amd_memory.c | 25 +++++++++++++++++++++++++
>   lib/amdgpu/amd_memory.h |  2 ++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/lib/amdgpu/amd_memory.c b/lib/amdgpu/amd_memory.c
> index 12fe23c65ab2..2da4a8a4baee 100644
> --- a/lib/amdgpu/amd_memory.c
> +++ b/lib/amdgpu/amd_memory.c
> @@ -30,9 +30,11 @@
>   #include <amdgpu_drm.h>
>   #include <stdio.h>
>   #include <string.h>
> +#include <limits.h>
>   #include <unistd.h>
>   #include <sys/mman.h>
>   #include <inttypes.h>
> +#include "igt_device.h"
>   
>   /**
>    *
> @@ -679,6 +681,29 @@ bool virtual_free_memory(void *address, unsigned int size)
>   	}
>   }
>   
> +/**
> + * amdgpu_cgroup_region_name() - Build the dmem cgroup region name for an amdgpu.
> + * @fd: amdgpu device fd.
> + *
> + * Constructs the full dmem cgroup region path for VRAM on the device
> + * identified by @fd.  The returned string has the form
> + * ``drm/<pci-slot>/vram`` (e.g. ``drm/0000:03:00.0/vram``), matching
> + * the name registered by the kernel driver via drmm_cgroup_register_region().
> + *
> + * Return: A newly allocated string that the caller must free(), or %NULL if
> + * @region is not tracked by the dmem cgroup controller.
> + */
> +char *amdgpu_cgroup_region_name(int fd)
> +{
> +	char pci_slot[NAME_MAX];
> +	char *name;
> +
> +	igt_device_get_pci_slot_name(fd, pci_slot);
> +
> +	igt_assert(asprintf(&name, "drm/%s/vram", pci_slot) > 0);
> +	return name;
> +}
> +
>   /**
>    * Wait for specific value in memory with timeout
>    */
> diff --git a/lib/amdgpu/amd_memory.h b/lib/amdgpu/amd_memory.h
> index e26c85bc4b0a..de169e580c1b 100644
> --- a/lib/amdgpu/amd_memory.h
> +++ b/lib/amdgpu/amd_memory.h
> @@ -105,6 +105,8 @@ void
>   bool
>   virtual_free_memory(void *address, unsigned int size);
>   
> +char *amdgpu_cgroup_region_name(int fd);
> +
>   bool
>   wait_on_value(unsigned int *ptr, unsigned int expected);
>   #endif
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

