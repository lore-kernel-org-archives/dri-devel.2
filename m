Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C096606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+wEgUT5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7370F10F9F2;
	Wed,  4 Nov 2026 07:11:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5D710F9F2;
 Wed,  4 Nov 2026 07:11:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 316A760AAB;
 Wed,  4 Nov 2026 07:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104FA1F000C1;
 Wed,  4 Nov 2026 07:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776272;
 bh=T0qJvAVSX8i/iKC1VW5a+ihb8ZerxF1KsKXeV3Ox9j0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=d+wEgUT5XylSFJ72jiSefapRvp64K3KBmzVtdjDtBywJoTFt7l0mSh2iEhvivLqO2
 BV18cEpAuwoOLz9S8HfJ9V6uj4fhnXmr1W3rqEtC64T0tYiyrWUu1hOTffNPZ2PcBR
 PnSTMVMuIj58L+1ReWfArE8W+A+WueuGZBuTWPaULQqwvYhiPH2ov5tzE17NtcqWAw
 1qzpfSigZGdlKF4KipzY4HAHU1GzVG+22bfSBid0Q+i2g0U6Yy+qB1EL2RxK86GLOJ
 /VzaKBs405ZngxN6AmmSmkVVIHDSpBJ/JoAHU7tDss1hbrkR7p/4W6smFsOlNxS+l1
 HnFQgXnKT9wuA==
Date: Wed, 4 Nov 2026 08:11:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Simona Vetter <simona@ffwll.ch>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, 
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/jpeg: unwind late software init failures in
 v5.0.0
Message-ID: <20261104-elusive-convivial-elk-cfeaf8@quoll>
References: <20261104025340.1527373-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025340.1527373-1-vulab@iscas.ac.cn>
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


On Wed, 04 Nov 2026 02:53:40 +0000, Wentao Liang wrote:
> The v5.0.0 software initialization callback creates its ring before
> allocating the register dump storage and creating the reset mask sysfs
> file. If either of the latter steps fails, the callback returns without
> releasing the initialized JPEG resources, including the ring buffers and
> the vmid_wait fence reference. The IP block's status.sw flag has not been
> set, so the common error cleanup skips its sw_fini callback.
> 
> Suspend the JPEG work and release the JPEG software resources on these
> late failures. amdgpu_jpeg_sw_fini() also releases the register dump
> storage if it was successfully allocated before sysfs creation failed.
> 
> Fixes: 64dc2f0029ec ("drm/amdgpu: Enable devcoredump for JPEG5_0_0")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
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




