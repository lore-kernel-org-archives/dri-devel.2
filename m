Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA637606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1bxCYZF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D0311287A;
	Fri, 20 Nov 2026 09:59:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89161112881;
 Fri, 20 Nov 2026 09:59:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7060B611C2;
 Fri, 20 Nov 2026 09:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E5E1F000C6;
 Fri, 20 Nov 2026 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795168756;
 bh=aNJVgiuqS87QmiPYqOjVcz6sjCHusWRo9ExL6mlDqFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=j1bxCYZFoOt0X9covx9etBcBFCdrVjrT1Yau1iipB2H1WFuFw/hyKeDw2BXO1pJYO
 FLqi0knnY6DjMsSJChaYtgyWNfwY6Fr+fyyna2cw61c+AMlpAeTFVV+mFYq+t5+hCQ
 M90Zl03QwDRQMThFZrDF56aw9B1J8UfcEKu+gCTtzfAP2z/oymrFBt+GZf8qHjmJti
 9nBBye9aWjcfrGWnnLbk+NySGLzq5VgomrY3Qa6munH2MBr674g12YZISvzZJXflmC
 9aHiyKMPkDx/XZnhJToSrHiKm34Iy7FDktYBwOBihJxgNvKJ03I8CQq9IdZkVv7Vdm
 TYKmtoLQT3I5A==
Date: Fri, 20 Nov 2026 10:59:12 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
Message-ID: <awAYXcgE4RMg3Hqi@zenone.zhora.eu>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Haoxing,

On Wed, Nov 18, 2026 at 11:32:05PM +0800, Haoxiang Li wrote:
> i915_vma_pin_ww() allocates bind work before retrieving the object's
> moving fence. If the lookup fails, it jumps to err_rpm, bypassing the
> fence commit at err_fence and leaking the work allocation.
> 
> Jump to err_fence instead so the fence callbacks can release the work.

BTW, this commit description, along with the title, is too
LLM-ish. Can you please write a simpler and more descriptive
commit message?

Please do not blindly rely on your LLM for this. Write it
yourself and use the LLM only to fix the grammar.

It would also be interesting to explain how this oversight
(because that's what it is) happened in the first place.

I'll wait for v2. You can add my R-b as well.

Andi
