Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB4606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e83NMGyO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4E711274A;
	Thu, 19 Nov 2026 22:09:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FD3112747;
 Thu, 19 Nov 2026 22:09:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5190845600;
 Thu, 19 Nov 2026 22:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8441F000C0;
 Thu, 19 Nov 2026 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795126142;
 bh=YpoAHjU6moP8icUI83qqCJrJjrDSorwcFrdvb3bizYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=e83NMGyO48+gsumhHlshjvcLQj9NOG9c0apfD6S0AHSr9INyBijvVdS/3layX9/7S
 /GDDC6z41BIxo2dts7bl88bVrvmZ/A2FZPS/0WpY1jtYITVff2rVR6fspvIrJFhKex
 AA0o/yH3r1FIa/TFRzZwVxH0oJjrqFJU5jLD+pauU6MjOylHv46tbAwGGM7/sxoI+a
 aS9uGEijZ7466Oypm+EGpoBRX6l8nozwH3diNAwISqy35kv6qrDDslZUj2vzI6uPQP
 L4bFfWp84XGPJPotJovvGBwOefzBCsbkvcKG7B58keaT9KbfM3O7wdRrO9QpHXeMGC
 JgJD6xTOpEmPw==
Date: Thu, 19 Nov 2026 23:08:58 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
Message-ID: <av9yfXc2CE7ZoWp-@zenone.zhora.eu>
References: <20261118153205.2432736-1-haoxiang_li2024@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118153205.2432736-1-haoxiang_li2024@163.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Haoxiang,

On Wed, Nov 18, 2026 at 11:32:05PM +0800, Haoxiang Li wrote:
> i915_vma_pin_ww() allocates bind work before retrieving the object's
> moving fence. If the lookup fails, it jumps to err_rpm, bypassing the
> fence commit at err_fence and leaking the work allocation.
> 
> Jump to err_fence instead so the fence callbacks can release the work.
> 
> Fixes: 8ec5c0006c50 ("Merge tag 'drm-intel-next-2022-05-20' of git://anongit.freedesktop.org/drm/drm-intel into drm-intel-gt-next")

that's weird to use the a merge commit as fixes, but that's what
it is.

> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
