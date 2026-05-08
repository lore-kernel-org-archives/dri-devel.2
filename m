Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0300CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 18:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CE710E33F;
	Fri,  8 May 2026 18:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="3oZLkdmP";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E2510E33F;
 Fri,  8 May 2026 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=fD79LjbLJzRV4SU5PUp0N6BYWSilqW/UE9YNtO6ZM6w=; b=3oZLkdmPo6NbLo4vBhDBSZkIk5
 mPtsJ0KZOtzO4pfdTFH9DJ9wOKlMzcJnKdAjPANzKGIIkMRUDSGrMFJac5FGznslOQFOZ6kmr4VRL
 uMy5euj+BuFydpcglmgVUwXWlCUYwACPx9exoiZgd7VxNJZtbZr73Xxdzubu0jrZgN2/ZDgcDJ2L3
 rSZ+a7TOg7Qbb+Xi3A9nWyHCz/KrOO7XcEK5UMfR8pc13e7kaEUOkhpE5JgiaWZKnxxKhONo2SajO
 LW/LXDAsnANICdARyu1ldMLQW00aGHneqQcAjOYAaM6QPwYov0M0i4MLHG8OKX/HkkCtYDE0nqxSI
 Iqp8sogw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wLPpq-00000007FRf-2Pvf; Fri, 08 May 2026 18:22:02 +0000
Message-ID: <4aba5b5e-75a5-4800-bedb-8f7cc673c7f7@infradead.org>
Date: Fri, 8 May 2026 11:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Documentation/gpu: add dedicated documentation for
 Intel display
To: Jani Nikula <jani.nikula@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Cc: rodrigo.vivi@intel.com, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
References: <cover.1778235406.git.jani.nikula@intel.com>
 <21bfa7777eb0926eadd309d4c6f5c9cf48405cf0.1778235406.git.jani.nikula@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <21bfa7777eb0926eadd309d4c6f5c9cf48405cf0.1778235406.git.jani.nikula@intel.com>
Content-Type: text/plain; charset=UTF-8
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



On 5/8/26 3:20 AM, Jani Nikula wrote:
> diff --git a/Documentation/gpu/intel-display/index.rst b/Documentation/gpu/intel-display/index.rst
> new file mode 100644
> index 000000000000..8d40363b8f90
> --- /dev/null
> +++ b/Documentation/gpu/intel-display/index.rst
> @@ -0,0 +1,40 @@
> +.. SPDX-License-Identifier: MIT
> +.. Copyright © 2026 Intel Corporation
> +
> +.. _drm/intel-display:
> +
> +====================
> +Intel Display Driver
> +====================
> +
> +The Intel display driver provides the display, or :ref:`drm-kms`, support for
> +both the :ref:`drm/xe <drm/xe>` and :ref:`drm/i915 <drm/i915>` Intel GPU
> +drivers.
> +
> +The source code currently resides under ``drivers/gpu/drm/i915/display`` due to
> +historical reasons, and it's compiled separately into both drm/xe and drm/i915
> +kernel modules.
> +
> +The drm/xe and drm/i915 drivers are the "core" or "parent" drivers for display,
> +as they initialize and own the drm device, and pass that on to the display
> +driver. The display driver isn't an independent driver in that sense.
> +
> +.. toctree::
> +   :maxdepth: 1
> +   :caption: Detailed display topics
> +
> +   async-flip
> +   audio
> +   cdclk
> +   dmc
> +   dpio
> +   dpll
> +   drrs
> +   dsb
> +   fbc
> +   fifo-underrun
> +   frontbuffer
> +   hotplug
> +   plane
> +   psr
> +   vbt

Is this in almost-alphabetical order or just random?  :)

Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
