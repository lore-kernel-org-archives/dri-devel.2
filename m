Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067A6606D805
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FI7wUr13
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590A110F3DE;
	Tue,  3 Nov 2026 07:27:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F81F10F3B4;
 Tue,  3 Nov 2026 07:27:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F2A96022C;
 Tue,  3 Nov 2026 07:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6B01F00A16;
 Tue,  3 Nov 2026 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793690819;
 bh=G6WXuYVuFVaqWLX5G0w7v21yMWKT2qQz3bCPmIaySXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FI7wUr13qUiCZjI5Cfxbb+wytm4cVV3/lKY2i+xGFDsEoJWw4xuc0SWfVMyNwCQli
 GfGk87l4VZqMNz1NgrcnMA+ugAdGCVibsvTbAcLcsZkgB6WR3W+HtfS1B0ko1473Df
 6X/x8yPB3FoSRWnPZBhcYoX+q2NEWe/ssJU/8lG8y+weFcwW9kyefWtaCqG/TK1Fz6
 nkpEPgBVJV2Cv/rPCwAGimB03lq1z2pQql4PKNj9YKEYZytLgkFlKTmZJ/43jri9ac
 wE2n2fXTCW8aYJlquNKwpx2umsCtpk8zxXTlWVXrzGTBkP/1GogeNATFEq3ypP1dh6
 3riqd62KwmdPg==
Date: Tue, 3 Nov 2026 08:26:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com, 
 stable@vger.kernel.org, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, matthew.brost@intel.com
Subject: Re: [PATCH] drm/xe/pm: Balance the runtime PM reference when ioctl
 resume fails
Message-ID: <20261103-cheetah-of-inescapable-engineering-1766dd@quoll>
References: <20261103065810.1075142-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103065810.1075142-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 06:58:10 +0000, Wentao Liang wrote:
> xe_pm_runtime_get_ioctl() uses pm_runtime_get_sync(), which increments
> the usage counter even when resuming the device fails. Its conditional
> runtime PM guard only runs xe_pm_runtime_put() after a successful get,
> so failed resumes leave an extra reference behind.
> 
> Use pm_runtime_resume_and_get() so a failed resume releases the usage
> counter increment before returning the error.
> 
> Fixes: 23cf006beac3 ("drm/xe: Runtime PM wake on every IOCTL")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/xe/xe_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




