Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A0606A335
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGtN3pf/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 363C210E78B;
	Tue,  3 Nov 2026 07:27:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D276710E78B;
 Tue,  3 Nov 2026 07:26:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CEB99601EF;
 Tue,  3 Nov 2026 07:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC44B1F00919;
 Tue,  3 Nov 2026 07:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793690812;
 bh=hkQTxC/NFuAwVmMKQPX/llja7JxOh4icS3qa3sFNnfk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IGtN3pf/FUSc4/tUq2TglSKRRpn52Gyek9Lz7MTay8j766ilA4K9zx4YdCenVxN0b
 NRh4CKZuin3iE74oGa0DZ3g+mKoLYic12vVD6kYlqFrwqNCiJnyNGPIyDgz4W9Std2
 Vl7nxE3MQfpSbj7HqVRJkUZLXTqvNH4oL7zeYnoI8QYPV7uuYSdjMpc961EfJ2jYK0
 XrA/7IOg9dFZ6H9pa7qe6VytbdXO/aUeH1g1Q/k4Wz2tU2TAQmjuopIz6vYgY9WpsF
 +9r7UXsFJ3rl6vsfVLFNs3SqQYZX7/Zf7iu0Wel1j+Fmdh/h551mBmgNDc3HA2463F
 O+t8Mn9DlE3SQ==
Date: Tue, 3 Nov 2026 08:26:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/jpeg: Unwind late software init failures in
 v2-v4
Message-ID: <20261103-pretty-impala-from-ganymede-aa050c@quoll>
References: <20261103070629.1083890-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103070629.1083890-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 07:06:29 +0000, Wentao Liang wrote:
> The JPEG 2.0, 3.0 and 4.0 software initialization callbacks create their
> rings before allocating register dump storage and creating the reset
> mask sysfs file. If either of the latter steps fails, the callbacks
> return without releasing the initialized JPEG resources, including the
> ring buffers and vmid_wait fence reference. The IP block's status.sw flag
> has not been set, so the common error cleanup skips its sw_fini callback.
> 
> Suspend the JPEG work and release the JPEG software resources on these
> late failures. amdgpu_jpeg_sw_fini() also releases the register dump
> storage if it was successfully allocated before sysfs creation failed.
> 
> Fixes: 63d5f8db5313 ("drm/amdgpu: Enable devcoredump for JPEG2_0_0")
> Fixes: d949e91b42f2 ("drm/amdgpu: Enable devcoredump for JPEG3_0_0")
> Fixes: c3dddd602967 ("drm/amdgpu: Enable devcoredump for JPEG4_0_0")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 9 ++++++++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

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
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




