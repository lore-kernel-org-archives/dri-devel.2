Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50C2C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 18:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3319C10E094;
	Sun,  9 Aug 2026 18:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svWBbLj9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8781310E094
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 18:20:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1285A6020E;
 Sun,  9 Aug 2026 18:20:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504351F000E9;
 Sun,  9 Aug 2026 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1786299653;
 bh=mb9QDC1iQYi8pCNJ4G320686nkqpM1gwPXkt8iVgfOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=svWBbLj9LgUQ6eYjQAVWVPSZJzQwjcxZeJhN9tA478vWx+FfqqxH68PSUumwQnSnh
 94l1VieS/lE4E8lUU8U/+G89u/dV5fCq8Ky3+jnJHu7J4fqxgG3voG7O9y1CiNFIdN
 DJcc1yOWnjVAGMx+tiWU1iJInJzFhQ+ka3paCteM=
Date: Sun, 9 Aug 2026 20:19:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?=D3scar_Meg=EDa_L=F3pez?= <megia.oscar@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4] Memory leak error in qxl unbind
Message-ID: <2026080941-edge-lurk-2146@gregkh>
References: <20260809165326.164763-1-megia.oscar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260809165326.164763-1-megia.oscar@gmail.com>
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

On Sun, Aug 09, 2026 at 06:53:14PM +0200, Óscar Megía López wrote:
> I discovered an OOM after run the script below
> (I updated it and added a sleep to allow enough time for the cache to
> recover):
> 
> while [ 1 -eq 1 ]; do\
>   i=$((i+1)); echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/unbind;\
>   if (($i%1000==0)); then\
>     echo i=$i; free;\
>     grep nr_free_pages /proc/vmstat;\
>     grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>     sync; echo 3 > /proc/sys/vm/drop_caches;\
>     echo 1 > /proc/sys/vm/compact_memory;\
>     sleep 10s;\
>     free;\
>     grep nr_free_pages /proc/vmstat;\
>     grep -E "PageTables|VmallocUsed|Slab|Reclaimable" /proc/meminfo;\
>     uptime;\
>   fi;\
>   echo 0000:00:01.0 > /sys/bus/pci/drivers/qxl/bind;\
>  done
> 
> The OOM isn't just a simple leak; it's a refcount corruption which renders
> the list_lru fix dead code after the first mid-init failure.
> 
> Here's the chain:
> 
> Bug 1: ttm_pool_type_init() does not check return from list_lru_init().
> 
> Fix: Check the return value from list_lru_init() and propagate the error.
> 
> Bug 2: ttm_pool_fini() does not destroy list lru with list_lru_destroy().
> 
> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
> 
> Bug 3: ttm_pool_mgr_init() does not check ttm_pool_type_init() return
> and does not free pool if returns error.
> 
> Fix: Move up shrinker_alloc(), check ttm_pool_type_init() return and free
> pool types and shrinker if non-zero and return error.
> 
> Bug 4: ttm_pool_mgr_fini() does not destroy the list_lru.
> 
> Fix: Add list_lru_destroy() after ttm_pool_type_fini().
> 
> Fixed check for an empty shrinker_list.

Why is this not 4 different patches as part of a series?

> This patch depends on patch ("[PATCH v3] drm/qxl: fix use-after-free in
> qxl_irq_handler on PCI"), link [1] below.

That's not going to age well in a changelog text :(

thanks,

greg k-h
