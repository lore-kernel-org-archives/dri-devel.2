Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B93606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQYVqTM9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3241C10ECF7;
	Sat, 14 Nov 2026 01:56:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C01AB10ED13;
 Sat, 14 Nov 2026 01:56:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4AFF6122A;
 Sat, 14 Nov 2026 01:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E71F000C4;
 Sat, 14 Nov 2026 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794621398;
 bh=Bvq3abI/c2wEiyKpnemVFOwknFERx4xxfu+AFRLZn80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kQYVqTM9F1jPDHBKwczHPpQXS9PbJzqSGP38N85O+0wtvmhcG35jeN5r6eFcihjYd
 qT3A80+T/N6e1kj9nr/klD/xWyNbW5yvWQ36AfeZkkoHQChFsJsRZwSaj4yNZ6tNtq
 A2ohBdTezVQkC+9mu2yfWt5V2zkQhzJhjLY7b+eyz1RZsTGMssufX6I1t/gj+WxFT0
 IoK6MtQo3/GK6XWQJV4SWFqQ+VemB2gM2+w7GjC8HZpYtcpEg+W9avtFI+dK3WOg3X
 /U9Xo0VIoEjhUo15yKEXoiq3Wf2KlFwRdsx4qlxJK2G+bUZFIxe6YMOyQ6kFgNPNTl
 VuK3ieSa+RQ4w==
Message-ID: <sashiko-outbox-214019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/i915/vrr: Leave the transcoder to the joiner
 primary
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-4-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-4-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:56:37 +0000
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/i915/vrr: Signed-off-by trailer uses handle instead of real
  full name
--

commit 6f78fb0ff83ff8c9f4f0ac58ba24164db71f007e
Author: ElXreno <elxreno@gmail.com>

> drm/i915/vrr: Leave the transcoder to the joiner primary
>
> All joined pipes run off the transcoder of the primary, and the crtc
> states of the secondaries are copies of the primary's state, the VRR
> state included. The commit therefore reaches the transcoder level VRR
> functions for every joined pipe: intel_pre_update_crtc() calls
> intel_vrr_set_transcoder_timings() for each crtc whose VRR parameters
> changed, intel_pre_plane_update() and commit_pipe_post_planes() call
> intel_vrr_disable() and intel_vrr_enable(), and both commit paths
> call intel_vrr_send_push() and intel_vrr_check_push_sent() per crtc.
>
> Do these once, from the primary. When disabling VRR also switch the
> active timings of all joined pipes as soon as the transcoder has left
> VRR mode, rather than leaving the secondaries on the VRR timings
> until their own turn comes.
>
> The check in intel_vrr_set_transcoder_timings() drops the second,
> identical programming of the transcoder that a joined fixed refresh
> rate configuration gets today. Everything else depends on vrr.enable,
> which is never set with the joiner yet, so there is no other
> functional change. In particular the push a secondary sends for the
> PSR and Panel Replay frame change is left as it is.
>
> The checks in intel_vrr_set_transcoder_timings(), intel_vrr_send_push(),
> intel_vrr_enable() and intel_vrr_disable() are the ones Ankit Nautiyal
> posted in "drm/i915/vrr: Handle joiner with vrr", last in [1].
>
> [1] https://lore.kernel.org/intel-gfx/20250224061717.1095226-14-ankit.k.n=
autiyal@intel.com/
>
> Suggested-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
The Signed-off-by trailer uses a single-word handle ("ElXreno") rather
than a real full name, which does not meet the Developer's Certificate
of Origin requirements in Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D3
