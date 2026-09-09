Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD14C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1479710E216;
	Wed,  9 Sep 2026 21:20:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k4eLXKQK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2A410E216;
 Wed,  9 Sep 2026 21:20:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0B414130B;
 Wed,  9 Sep 2026 21:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2CB1F000FF;
 Wed,  9 Sep 2026 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788988842;
 bh=+H+ZJH0ftAZSxJQeKW5qVtWQtWSEpir02EwuyhbdWBI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=k4eLXKQKxfoqeo96EwDFH5e65PpklSb2NNCZc1xLDyqE6L/5TJExkm3Iv6jqRygn4
 giURXvSy+sW0CnLf9xIuffuTDL8mQ2kk8lEv5BJ+ZpUin5iJQ5YR30b/mopq28OV8P
 S9pFNyQhgXFopvWQHHhO0PENVx4WstNpP1ixChDIZGe73LwdS/yP+BqXtT1XqY5W/C
 o5/PMNfWJtvGL277DO/28712qqfdT0JvVXmVsyblY1gqV0KiOw+b2VSkUHRu0aGDpr
 zbrxPvM94gque/w3xDflmQh83gixcGpchRNb3cWnhDgiespWi1pRFtbtI3JeDdCVw2
 W88mya4WPARLQ==
Date: Wed, 9 Sep 2026 23:20:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Fix memory leak in query_perf_config_list()
Message-ID: <aqHNb7fH68g9aw93@zenone.zhora.eu>
References: <20260823205028.178597-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823205028.178597-2-thorsten.blum@linux.dev>
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

Hi Thorsten,

On Sun, Aug 23, 2026 at 10:50:28PM +0200, Thorsten Blum wrote:
> When krealloc() fails, free the original oa_config_ids before returning
> to avoid a memory leak.
> 
> Fixes: 4f6ccc74a85c ("drm/i915: add support for perf configuration queries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

merged to drm-intel-next.

Thanks,
Andi
