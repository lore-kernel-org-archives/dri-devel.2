Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C8606D803
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dpm0o76g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAE710F46C;
	Tue,  3 Nov 2026 09:28:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE9310F46C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 09:28:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B70AA60098;
 Tue,  3 Nov 2026 09:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB0C1F00A16;
 Tue,  3 Nov 2026 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793698105;
 bh=MAtXJ5JSgJ/i75JTgD0TVOP5Cyry7grTp5Tgw6O2AQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Dpm0o76gp5i9DTnt2DH9XAK2sBfyFF9miP5uOl03QLiwH6W/4jAl/t/BHPvmP1ONt
 AazggoHjH3WVPpjrQX7mwgnyhXoJn0xbKBZpiEsrsJP4f2O93KdQ1D35DELZh5/mCV
 COi3iLlbmE9hjdQkBLa4simwgq73/IrtdiE8KPzlrEcZek3ayacS/m0UMOH6rkzZ3Y
 tHKa08IO8ZRi7EB5GmAw+Hm9GTAgfjOCHZUql3lbrS+/Oh6SO9fN10q1iAEZq/qOhA
 X/SxDyp7yeUBZwfoDH+5uUOxS6lqdq7n6Yp9MwJkFrrnJ9hIihTpRZgEopqv9VLcWY
 56LOBt0xIaLqA==
Date: Tue, 3 Nov 2026 10:28:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org, 
 linux-kernel@vger.kernel.org, andrzej.hajda@intel.com, stable@vger.kernel.org, 
 xji@analogixsemi.com, rfoss@kernel.org, windhl@126.com
Subject: Re: [PATCH] drm/bridge: anx7625: Release the MIPI host node at
 teardown
Message-ID: <20261103-strict-flying-boar-a7a6c7@quoll>
References: <20261103075758.1119919-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103075758.1119919-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 07:57:58 +0000, Wentao Liang wrote:
> anx7625_parse_dt() obtains a reference to the MIPI host node and keeps
> it in the platform data for DSI host lookup. Neither the probe failure
> paths nor device removal release this reference.
> 
> The existing put before looking up the node only releases a previously
> stored value. The platform data is freshly allocated for each probe, so
> that does not release the reference acquired by the current probe.
> 
> Register a managed action to put the node when probe fails or the device
> is removed. Drop the put of the initially empty platform data field.
> 
> Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
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




