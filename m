Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6022606A333
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfn+IVLD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD1F10F9DB;
	Wed,  4 Nov 2026 07:10:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110D410F9DB
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:10:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86A0160DA5;
 Wed,  4 Nov 2026 07:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995E91F000C1;
 Wed,  4 Nov 2026 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776236;
 bh=O6XI2UJm+bwRvc5JnCBHwaUXIssAjQ2hHludGhHpFkA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dfn+IVLDENF+nHNfpFJIwUmbS3T++pcFQeUVc8BdM4Rd+n+PyQdfwUgVHMz56H29w
 rxnSpmxudV3rHsaGUaVvpNBc9dKH8b7qSMjDxMKzKeR2USVvud0sQrTqbCaOW/Glwe
 kJoLKhRa5WAP7K/z20wFajkr3eC7aFmic+A5R8T+ss5DkbWB0ssuRUigAl85dFbmhB
 vyXyx7beCIc0k00SRiWqIwEAs5IB5jxG2oyrHOZDZMtrAjjUM5v6pk6Xgh256q4uxr
 zoSl518TLacYlze7ZtUuamqNYEVb7EQB0Wd7+Cl/UoIEsfbMyOLv0/+U5WKse7ukyu
 Bu9wTRYeDm5GQ==
Date: Wed, 4 Nov 2026 08:10:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Robert Foss <rfoss@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] drm/bridge: it6505: put the endpoint node after using it
Message-ID: <20261104-ultraviolet-guppy-of-enthusiasm-c8c6c1@quoll>
References: <20261104025343.1527475-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025343.1527475-1-vulab@iscas.ac.cn>
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


On Wed, 04 Nov 2026 02:53:43 +0000, Wentao Liang wrote:
> it6505_parse_dt() obtains an endpoint node with
> of_graph_get_endpoint_by_regs() and drops that reference with
> of_node_put() right away, before the node is checked and passed to
> it6505_get_data_lanes_count(), of_property_read_u32_array() and
> of_property_read_variable_u64_array().
> 
> The reference from of_graph_get_endpoint_by_regs() is the only thing
> keeping the endpoint alive, so releasing it first leaves the following
> property lookups operating on a node that another of_node_put() can free
> concurrently, for instance when a device tree overlay providing the
> endpoint is removed.
> 
> Keep the reference until the properties have been read and only then
> call of_node_put(), for both endpoints parsed by the function.
> 
> Fixes: 380d920b582d ("drm/bridge: add it6505 driver to read data-lanes and link-frequencies from dt")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
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




