Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84B606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9hswSs9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C35410F9C9;
	Wed,  4 Nov 2026 07:10:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1173210F9C9
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:10:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EA0D60AAB;
 Wed,  4 Nov 2026 07:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B91F000C1;
 Wed,  4 Nov 2026 07:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776232;
 bh=hKwZwLISlyrZRoSYe8UqN4PmHGGlaU0ArAeEDXc/U8I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q9hswSs9fAm6Kf513ogva/n6h6XPf4VLLcCoKgUfFdBy64lp78UD1lVZj6M76LUfm
 PssYbEp8JLXQ/2IOO6tSohW7inzGiSaVNW+zJYT/D8n1SNdf4WK8byHDKj0/rf2aT4
 +TATT9gF0cIuDQPqFOmmqzM22w7TpCj/Aualk6dix/Kpc+EdDtLna5KhoMaHvgFQUv
 kwiG2dlT/umvJtUrzrvFX+mrSbWVzva4YaHvp42UpJ8bIx16hUhZctGtYKacyr2tC5
 mdGjYsGOxOAceNE7hvOKK2vJ/8oc+LL6qPAI4QIqep4zsxAaf5oUE5fH+JrqAdIqMM
 9SNsphzhuNHyg==
Date: Wed, 4 Nov 2026 08:10:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>, Andy Yan <andyshrk@163.com>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Sandy Huang <hjc@rock-chips.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: use the safe iterator when removing device
 links
Message-ID: <20261104-wombat-of-phenomenal-blizzard-93dcf0@quoll>
References: <20261104025346.1527550-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025346.1527550-1-vulab@iscas.ac.cn>
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


On Wed, 04 Nov 2026 02:53:46 +0000, Wentao Liang wrote:
> rockchip_drm_match_remove() walks dev->links.consumers and calls
> device_link_del() for every entry.  That drops the link's reference and,
> once it reaches zero, __device_link_del() removes the link from the
> device link lists and schedules the release of the link object.
> 
> list_for_each_entry() still reads link->s_node after the loop body to
> find the next entry, so it accesses a link that has already been
> released.  Use list_for_each_entry_safe() so that the next entry is
> loaded before the current link is deleted.
> 
> Fixes: 7d4e981d41e3 ("drm/rockchip: Add device links for master and components")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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




