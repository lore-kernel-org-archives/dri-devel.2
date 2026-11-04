Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB30606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeO392NA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070E210F9F5;
	Wed,  4 Nov 2026 07:11:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807E010F9F1;
 Wed,  4 Nov 2026 07:11:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03431601F6;
 Wed,  4 Nov 2026 07:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EABA1F000C1;
 Wed,  4 Nov 2026 07:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776283;
 bh=mPZzPJnE4ktU/VLOSGQXCc/Vln0H4iBfo314j0YU08Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YeO392NAp+FO4ITnnmc+4Kz7u9QpACFpLde8Tk0YR+XmOa3sb176w9NTndzPzoJ/x
 oeml2q0epc7fz8BRK7JpjeYAvXHtL9PF++tOdxk36RX86dAttKrEFoQkBKfqrdlYIA
 u79rhdqkKhhkHzuWNxVsZAHmt88lymYnUGdkkY1FQeqlvtm+gMVu6h0aIGOjB4lEtm
 4DsALCQl4Ykt2kkaomriqvMJIZcvFhAz5QY4Kt8ZJkNpWrfLBDo7hZFwxh+d6zizP4
 c3M3vDZ1ZiwcexPPuSGhnRO2n6ODnj0wJmbIsgxx+e8PrWoR/XGYPBN6/GJm0Fzd7C
 q3MeyanT4Qqlw==
Date: Wed, 4 Nov 2026 08:11:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: David Airlie <airlied@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] drm/amdgpu/jpeg: unwind the ring when sysfs init fails
Message-ID: <20261104-thankful-excellent-tapir-2cf9de@quoll>
References: <20261104025337.1527305-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025337.1527305-1-vulab@iscas.ac.cn>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 04 Nov 2026 02:53:37 +0000, Wentao Liang wrote:
> jpeg_v5_3_0_sw_init() returns directly when
> amdgpu_jpeg_sysfs_reset_mask_init() fails, after the JPEG ring has been
> initialized successfully. amdgpu_ring_init() allocated the ring buffer,
> writeback slots and the vmid fence, and only amdgpu_ring_fini(), called
> through amdgpu_jpeg_sw_fini(), releases them. Because the IP block's
> status.sw is only set after sw_init() succeeds, the upper layers skip
> sw_fini() for this block and the resources are leaked.
> 
> Unwind with amdgpu_jpeg_sw_fini(), as the other JPEG implementations do.
> 
> Fixes: 4aeaf3cbfa9f ("drm/amdgpu/jpeg: Add jpeg 5.3.0 support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
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




