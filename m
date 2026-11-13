Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C93606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=sqJVO9Oh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E2410E133;
	Fri, 13 Nov 2026 05:03:00 +0000 (UTC)
X-Greylist: delayed 2655 seconds by postgrey-1.36 at gabe;
 Fri, 13 Nov 2026 05:02:53 UTC
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A003210E103;
 Fri, 13 Nov 2026 05:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=ZiYALzwBjI65tTTQSXY2U+ySmJs1lqd9md75ReSDjlI=; b=sqJVO9OhFJFFp5d+CorT0gFFwx
 gQHtm0rP9jBKdo5gtNhPuLDVJFyS5i84cybGKtUoyz1fhqHNy/GRDTRJWNgzdqFTWEyGhMkX/IdYX
 1gczl9YxmBvNI3QYA9KvCiNAWLYKnpgv/dbGuxQdmfjTnj+SrMaiu9Ge6b2Zzu3cJj3uIAscyiV2Z
 gGz+MjtR0Ub8ypP0wa3inb778TZZgjDpL3fgNIJjKwllEUMLxQ7GC61J0NW/qoFJgAi8vPToPSlrb
 Ptdylv4aBTXI6DXk9fq3Si66BLJQ8a5feCTMk2q9JmLUpH879Zp+OriFt9ucCWJscZvyIYeC/6V5J
 pp72RlUg==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.98.2)
 (envelope-from <logang@deltatee.com>) id 1xRik9-00000002SeY-3ZkQ;
 Thu, 12 Nov 2026 22:18:32 -0600
Message-ID: <029ccd27-68df-4e0a-bf27-3b40f68e91c6@deltatee.com>
Date: Thu, 12 Nov 2026 22:17:50 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pavel Popov <pavel.e.popov@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-4-pavel.e.popov@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Content-Language: en-CA
In-Reply-To: <20261111234821.4814-4-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, rafael@kernel.org,
 viresh.kumar@linaro.org, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, tursulin@ursulin.net,
 alexander.deucher@amd.com, christian.koenig@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, peterhuewe@gmx.de, jarkko@kernel.org,
 thomas.lendacky@amd.com, herbert@gondor.apana.org.au, leon@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, lenb@kernel.org,
 sakari.ailus@linux.intel.com, jgg@ziepe.ca, airlied@gmail.com, simona@ffwll.ch,
 davem@davemloft.net, x86@kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
Subject: Re: [PATCH 3/7] drm/amdgpu: Include <asm/cpu_device_id.h>
 unconditionally
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2026-11-11 5:48 p.m., Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> <asm/intel-family.h> is included by <asm/cpu_device_id.h>.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.
> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 19a566187df..fc4e7273630 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -88,10 +88,7 @@
>  
>  #include <drm/drm_drv.h>
>  
> -#if IS_ENABLED(CONFIG_X86)
> -#include <asm/intel-family.h>
>  #include <asm/cpu_device_id.h>
> -#endif
>  
I don't see the corresponding addition of adding the cpu_device_id.h.
The commit message doesn't mention that. Am I missing something here?

Logan
