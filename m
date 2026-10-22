Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE948606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZKHz7RBh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55AB711269A;
	Thu, 22 Oct 2026 14:12:25 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459EE1126A9;
 Thu, 22 Oct 2026 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=2INVMZr44hUwV3IfZpRsDxZrcaFyaPHQ/oH9JOKtmxg=; b=ZKHz7RBhw1FSgkTvGoTyW9pC/A
 p1M1e7G6kuZxd5skShYfOaMxWWbM4mkTCZrvh8YACo7joBwCyJZ5ybKEN/HekzTIFMiQJnqatkxat
 CXx+dgnDQERHm31EOlOdOdSVHWVzO+5bxphAABhxa67R7Miw58Dt1GcHObgsXrHXoxPN4kg6yuIr9
 Hx3cFL9TrCr/NmF8ivE0dYgB8EWzCafTH9nI99rglMMLkkciEUJX5U4EFlcuoX3YSEVgxX5PhKol8
 3KaLB1rVn3AjXDvgV0NB6JzrJAqagTD7pWHD2ulnoC8wW4Tk+BSpVOQqdXl55bsfao0kc4gTx7PTa
 EIbHqeTw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xJtWd-006ru7-Uv; Thu, 22 Oct 2026 16:12:12 +0200
Message-ID: <ae34a8b1-001c-4b02-b67a-0b85088b68fc@igalia.com>
Date: Thu, 22 Oct 2026 15:12:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t v7 3/9] lib/xe: add xe_cgroup_region_name() helper
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
References: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
 <20260923-dmem_max-v7-3-194ea47bbb4d@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-3-194ea47bbb4d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23/09/2026 21:44, Thadeu Lima de Souza Cascardo wrote:
> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> Add xe_cgroup_region_name(fd, region) which constructs the dmem cgroup
> region path for a given xe memory region.  The returned string has the
> form "drm/<pci-slot>/<region>" (e.g. "drm/0000:03:00.0/vram0"),
> matching the name registered by the kernel via drmm_cgroup_register_region().
> 
> Only VRAM regions are tracked by the dmem controller; system and stolen
> memory regions return NULL.
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   lib/xe/xe_query.c | 32 ++++++++++++++++++++++++++++++++
>   lib/xe/xe_query.h |  2 ++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/lib/xe/xe_query.c b/lib/xe/xe_query.c
> index 91ffc36e6425..058f95ed1484 100644
> --- a/lib/xe/xe_query.c
> +++ b/lib/xe/xe_query.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <fcntl.h>
> +#include <limits.h>
>   #include <stdlib.h>
>   #include <pthread.h>
>   
> @@ -21,6 +22,7 @@
>   
>   #include "drmtest.h"
>   #include "igt_debugfs.h"
> +#include "igt_device.h"
>   #include "ioctl_wrappers.h"
>   #include "igt_map.h"
>   #include "intel_common.h"
> @@ -1302,6 +1304,36 @@ int xe_query_eu_thread_count(int fd, int gt)
>   		xe_hwconfig_lookup_value_u32(fd, INTEL_HWCONFIG_NUM_THREADS_PER_EU);
>   }
>   
> +/**
> + * xe_cgroup_region_name() - Build the dmem cgroup region name for an xe memory region.
> + * @fd: xe device fd.
> + * @region: Region mask (as used by xe_mem_region(), xe_region_name(), etc.).
> + *
> + * Constructs the full dmem cgroup region path for @region on the device
> + * identified by @fd.  The returned string has the form
> + * ``drm/<pci-slot>/<region>`` (e.g. ``drm/0000:03:00.0/vram0``), matching
> + * the name registered by the kernel driver via drmm_cgroup_register_region().
> + *
> + * Only VRAM regions are registered with the dmem controller; passing a
> + * system-memory region returns %NULL.
> + *
> + * Return: A newly allocated string that the caller must free(), or %NULL if
> + * @region is not tracked by the dmem cgroup controller.
> + */
> +char *xe_cgroup_region_name(int fd, uint64_t region)
> +{
> +	char pci_slot[NAME_MAX];
> +	char *name;
> +
> +	if (xe_region_class(fd, region) != DRM_XE_MEM_REGION_CLASS_VRAM)
> +		return NULL;
> +
> +	igt_device_get_pci_slot_name(fd, pci_slot);
> +
> +	igt_assert(asprintf(&name, "drm/%s/%s", pci_slot, xe_region_name(region)) > 0);
> +	return name;
> +}
> +
>   igt_constructor
>   {
>   	xe_device_cache_init();
> diff --git a/lib/xe/xe_query.h b/lib/xe/xe_query.h
> index 59330d80fd1b..a6ef9cab9aa1 100644
> --- a/lib/xe/xe_query.h
> +++ b/lib/xe/xe_query.h
> @@ -206,4 +206,6 @@ void xe_device_put(int fd);
>   int xe_query_eu_count(int fd, int gt);
>   int xe_query_eu_thread_count(int fd, int gt);
>   
> +char *xe_cgroup_region_name(int fd, uint64_t region);
> +
>   #endif	/* XE_QUERY_H */
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

