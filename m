Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC04CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 06:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B93D10E4FA;
	Wed,  6 May 2026 06:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="jxDoomzg";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27ADD10E4FA
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:35:26 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260506063525euoutp0114621d4a0fbbef63f6f679c8710df04b~s5nDbouAm3038930389euoutp01E
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:35:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260506063525euoutp0114621d4a0fbbef63f6f679c8710df04b~s5nDbouAm3038930389euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1778049325;
 bh=Uj+QchjM1TjaqqN5H20BKQY/O8GeHx9yl6VKOOJcP5Y=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=jxDoomzgWnwlDvZ9xVJImT5gCkCKA/ASI4o2s+9y+hPBQdbcN9fOfescQKJ8Dntmu
 i4+bxXm80oDwkjVFGT1m4nHv4s7T5xvAgsKYCTR/BrCWewYsdwyxxia/HQa3z6setC
 Vu+k9V1oKUYuvFGNKd1gr76Eyd2qa+F+3aVSVN90=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260506063524eucas1p2e642628db1f6ac58096790da6f502e48~s5nDJldkh1757617576eucas1p29;
 Wed,  6 May 2026 06:35:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260506063523eusmtip246f21b2b475e3cbfa4443ee0d0673545~s5nCKdIkG2580125801eusmtip2I;
 Wed,  6 May 2026 06:35:23 +0000 (GMT)
Message-ID: <b9765ddd-bb8a-458f-85d4-159d3cc5fe5b@samsung.com>
Date: Wed, 6 May 2026 08:35:23 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/5] drm/exynos: fbdev: Use client buffers
To: Thomas Zimmermann <tzimmermann@suse.de>, inki.dae@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org
Cc: linux-samsung-soc@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260423094452.32665-1-tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260506063524eucas1p2e642628db1f6ac58096790da6f502e48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260423095139eucas1p149a0e97f62e8bf353a65466ca26cbff9
X-EPHeader: CA
X-CMS-RootMailID: 20260423095139eucas1p149a0e97f62e8bf353a65466ca26cbff9
References: <CGME20260423095139eucas1p149a0e97f62e8bf353a65466ca26cbff9@eucas1p1.samsung.com>
 <20260423094452.32665-1-tzimmermann@suse.de>
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


On 23.04.2026 11:37, Thomas Zimmermann wrote:
> A client buffer holds the DRM framebuffer for an in-kernel DRM
> client. Until now, exynos created an internal ad-hoc framebuffer for
> its fbdev emulation, while by-passing the regular interfaces used by
> user-space compositors.
>
> Convert exynos' fbdev emulation to use client buffers. Replacing the
> existing code with a client buffer allows for stream-lining exynos code
> and later also the fbdev helpers. The new framebuffer will be registered
> against the client's file and will support handles for GEM objects. It
> is then just another framebuffer within the DRM ecosystem.
>
> If all driver's fbdev-emulation helpers can be converted to use client
> buffers, the emulation's framebuffer handling as a whole can possibly be
> moved into shared helpers.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> Patch 1 first fixes a long-standing bug.
>
> Patches 2 to 4 convert exynos' fbdev emulation to client buffers. It
> still allocates a GEM object buffer tailored towards fbdev emulation,
> but size calculations now use common DRM helpers.
>
> Patch 5 cleans up symbol visibility in exynos' fb code.
>
> Thomas Zimmermann (5):
>   drm/exynos: fbdev: Remove offset into screen_buffer
>   drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
>   drm/exynos: fbdev: Calculate buffer geometry with format helpers
>   drm/exynos: fbdev: Use a DRM client buffer
>   drm/exynos: Make exynos_drm_framebuffer_init() an internal interface
>
>  drivers/gpu/drm/exynos/exynos_drm_fb.c    |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_fb.h    |   7 --
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 100 ++++++++++------------
>  3 files changed, 47 insertions(+), 62 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

