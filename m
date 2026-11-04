Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E25606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8AuM9na
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCE510F9E7;
	Wed,  4 Nov 2026 07:10:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9EB10F9E4
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:10:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D28FB60DA0;
 Wed,  4 Nov 2026 07:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E471F00A15;
 Wed,  4 Nov 2026 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776243;
 bh=N4KYeFQ1qYR8k3JmR3RkUkuRmlnvLdsE17s5KXqLkPc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c8AuM9nauMsturM0amA0m+1DtsxtrED77xC5BN9OXMbu53OmGulpAjRtGYMjQX6x1
 Mkbkj416BQmLXvTC57hprc3vupWKUuuKYINYMbcxRZo4toLlnsOtspEQBvoQJVMb13
 iYofrZ6QVacV2Dn4vFrQ1s7PdcoSsBilgD2Z2OOSKxTZtd9A5wP6jYp8wiMQxVASMU
 Aph3n2zrmWB4VruYbHvO9BDcImbB0GpPosOGvyNjcHMMFoRju/lBxoYTxNtcQ9Brsw
 N2v/upsxVO5EHPbxwupLjstrBKhta42jiOKIwUIMPQzu48nWsOwo39KzB5yIEOHCP6
 s6VMQo06v+neQ==
Date: Wed, 4 Nov 2026 08:10:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Simona Vetter <simona@ffwll.ch>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm: bridge: ti-dlpc3433: register the DSI device with
 devres
Message-ID: <20261104-classic-fuzzy-nautilus-ff95c3@quoll>
References: <20261104025338.1527339-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025338.1527339-1-vulab@iscas.ac.cn>
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


On Wed, 04 Nov 2026 02:53:38 +0000, Wentao Liang wrote:
> dlpc_host_attach() registers a MIPI DSI device with
> mipi_dsi_device_register_full(). That call adds the device to the DSI
> bus and the driver never unregisters it: dlpc3433_remove() only removes
> the bridge, and the error path when devm_mipi_dsi_attach() fails returns
> without unregistering either. The DSI device is leaked on every
> successful probe and on that failure path.
> 
> devm_mipi_dsi_attach() only registers a detach action, it does not
> unregister the device. Use devm_mipi_dsi_device_register_full() so the
> device is unregistered when the bridge device goes away.
> 
> Fixes: 6352cd451ddb ("drm: bridge: Add TI DLPC3433 DSI to DMD bridge")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




