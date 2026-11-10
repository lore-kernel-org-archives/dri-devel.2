Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEqx7Sb+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53A410E1E2;
	Tue, 10 Nov 2026 00:33:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349B910E1E2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:33:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1927062D65;
 Tue, 10 Nov 2026 00:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99551F0089F;
 Tue, 10 Nov 2026 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794270785;
 bh=jOpEvRPbDw0u4EXWwjW8vP+Sd0HPBuXavYAOBxb1sCI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UEqx7Sb+0Oz448YRBBugVNPQnZUqLJE6jshUjPnbOzPsghF2xJb2lP1l/yFAPe31v
 BgqTJFIRSmOza6pFny17LzXjN9UbzyTNLbZYT+mXDfyHjmmn9Pkfy1HQ4/1Pouromo
 eDM/bnBNz4P/YcjubQmbx8HNYwqnhLAT6HNm/YUEzOZhq8X/72PdLOmBJvlPYh1DHC
 zUm5ewcLpFdgdUlnnLN5OTZKn4pGfTrqUrfOSHqOA14dRdWbpKm9ljGVXrAInOdePt
 5RuyS00DcU+fOfutOJFENllN6ol8UNpLjBdT2ThZlI3OkDWxofJm+JsaNjhoxWLzoA
 t+Lxv02tKG6Tg==
Message-ID: <sashiko-outbox-205865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] drm/vc4: hdmi: Propagate -EDEADLK to the top level
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vc4-common-scramb-v4-4-eaa141a0da0f@collabora.com>
References: <20261110-vc4-common-scramb-v4-0-eaa141a0da0f@collabora.com>
 <20261110-vc4-common-scramb-v4-4-eaa141a0da0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:33:05 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/vc4: hdmi: missing Fixes trailer for
  vc4_hdmi_handle_hotplug()
--

commit 6d4e22aadcba086750601443588ce618f73cc846
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

> drm/vc4: hdmi: Propagate -EDEADLK to the top level
>
> drm_connector_helper_funcs.detect_ctx() is expected to propagate
> -EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
> perform the required backoff and retry.
>
> vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
> drm_modeset_backoff() on an acquire context it does not own.  This drops
> all locks in the context, including connection_mutex held by the core.
>
> Drop the local retry logic and propagate -EDEADLK to the caller instead.
> This aligns VC4 with the expected detect_ctx() semantics.
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[Severity: Low]
Since this fixes the local retry loop and drm_modeset_backoff() call in
vc4_hdmi_handle_hotplug(), should this include a Fixes tag?

  Fixes: 479d4f0be423 ("drm/vc4: drop all currently held locks if deadlock =
happens")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vc4-common=
-scramb-v4-0-eaa141a0da0f@collabora.com?part=3D4
