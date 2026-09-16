Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF336C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A9E10E8DA;
	Wed, 16 Sep 2026 08:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hNHYdANV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97F210E8DA
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789548292; x=1821084292;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RHcfOSplw7MFwFqPnZKYqlO3BbT03sGWz1lyygxJi4A=;
 b=hNHYdANVVoAw7BMqDwtlA9sXZqxXT3jXc/6HHYbnROsXuJwvC+TU1byf
 h/w4j/LLcw6tNkoTpF2mpSfl5N4krZ2aZMzlmLRhF+4/rfMahPUSzaLVZ
 6EvmZuYExrJeldTvWAO8uJLwNVdlXQJ2xkzC/g1RrKsELL1qzFG1CEBg0
 nLzJwwCHB7eI4AFooKHXHKkade1HFa5budrTfCrIaS0mQDZYWpa20hi8U
 8nlkkgNWgeS0QRp4gTmtSd/PAr21Jy8tpS1oRKCaj5OseRtFzNOckzDHY
 wdhc7CzhPGV1NYC/mg0hg+MYVuLk/DJWOBwP80MLdvr4ug+81MUQB1Nfy g==;
X-CSE-ConnectionGUID: rWQ7bOq9QmOg9PYmAdeJ/w==
X-CSE-MsgGUID: 06RQWetmRHykREUfGDyg4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="430822"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="430822"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:44:52 -0700
X-CSE-ConnectionGUID: /RT++njXQJm5PeudXcxOOw==
X-CSE-MsgGUID: rANCW8OlSmGw8J1L6i4XqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1500360"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.244.168])
 ([10.245.244.168])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 01:44:50 -0700
Message-ID: <da707cc7-abba-4bf5-802f-3cb8f021eaa6@intel.com>
Date: Wed, 16 Sep 2026 09:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 christian.koenig@amd.com, ray.huang@amd.com, nat@pixelcluster.dev,
 arunpravin.paneerselvam@amd.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260915154804.605772-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260915154804.605772-1-christian.koenig@amd.com>
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

On 15/09/2026 16:48, Christian König wrote:
> The blunt reality is that I don't have time to look into patches or bugs
> any more as it would be necessary. The same counts for Ray.
> 
> Natalie has been working on the dmem cgroup patches for TTM and agreed
> to take over looking more into TTM.
> 
> Arun is working in my team and already maintaining AMDs VRAM backend for
> TTM and the underlying buddy allocator.
> 
> Add Thomas as reviewer as well, better to have more eyes on that
> component.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Acked-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   MAINTAINERS | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b5a4e4b35cf..b6e58a138501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
>   F:	include/drm/drm_privacy_screen*
>   
>   DRM TTM SUBSYSTEM
> -M:	Christian Koenig <christian.koenig@amd.com>
> -M:	Huang Rui <ray.huang@amd.com>
> +M:	Natalie Vock <nat@pixelcluster.dev>
> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
>   R:	Matthew Auld <matthew.auld@intel.com>
>   R:	Matthew Brost <matthew.brost@intel.com>
> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

