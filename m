Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E08606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FoXl3xLw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5763410F9EB;
	Wed,  4 Nov 2026 07:11:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746F310F9EB
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:10:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D09C40253;
 Wed,  4 Nov 2026 07:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0281F000C1;
 Wed,  4 Nov 2026 07:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776257;
 bh=/4Vaz1/VNxTYF518LkkZoDIlUmn8VqFaL2EVigTRlSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FoXl3xLwJX/qih3wbg0IWrP/g/PXTsmeujKJj4qFPNOd9+xsodWh3wzXBUOfJlGNy
 8rtJtLJdWWShK+RrgCoF8Yvicz2KkJxdtIRQPlodjxlRijrXCTtc9MZKWCdthFdWVr
 dusp/Y/pE/urQ/WQOQGSV7hZN6GLsrvvDCtxba2nzpc8kEU3DX1W6z7eNqFWgH6hvD
 F9xG7mKuRk4C1qi30WA6cfzi5vHc5uVXVmvXKgFF2dgR3tVrQ8Rnr+NdRZzPvi0/uZ
 WTdc7xVv+Z8mwc8DYiymFzykEU6vM0C/wFU6rjqLvcU9aUdMfG0REvAH1EGi2h7JiR
 iMbWt1/TviHKA==
Date: Wed, 4 Nov 2026 08:10:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] drm/gem-atomic-helper: fix explicit fence leak without a
 framebuffer
Message-ID: <20261104-dangerous-dachshund-of-sufficiency-6bbbab@quoll>
References: <20261104025342.1527424-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025342.1527424-1-vulab@iscas.ac.cn>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 04 Nov 2026 02:53:42 +0000, Wentao Liang wrote:
> drm_gem_plane_helper_prepare_fb() takes a reference on state->fence
> before checking whether the plane state has a framebuffer. An explicit
> fence can be attached to a disabled plane through the IN_FENCE_FD
> property, and drm_atomic_plane_check() accepts that state because CRTC
> and framebuffer are both unset. The early return for the missing
> framebuffer then drops the newly acquired reference without releasing
> it.
> 
> Move the reference acquisition after the framebuffer check.
> 
> Fixes: 1ea28bc5542d ("drm: handle kernel fences in drm_gem_plane_helper_prepare_fb v2")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/drm_gem_atomic_helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




