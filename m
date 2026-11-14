Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AA606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1C5aA+b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6225B10E55A;
	Sat, 14 Nov 2026 01:48:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5643010E2D1;
 Sat, 14 Nov 2026 01:48:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1F0441923;
 Sat, 14 Nov 2026 01:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22681F000C4;
 Sat, 14 Nov 2026 01:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794620928;
 bh=+C23i9s4pK7w5fShW/lOLZO1rtkyssCMKTEdIDY+USc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M1C5aA+b3Skr0G/yAx/w3t5J0nipR2pjVB6FffD4yKG7g1LPnHljz/qpxRfvlV9L1
 BgkbjpWuhyDUszMCO9GFzu70zdsxFkFrv7rRObn2bG+1IgXhwn3dCpiaUnq3TV8r2D
 DbEAOsFlhMyGgkkst63i249hlG/uOZKB7T0ap0sB7v2CIAuWvgqcxUvInhVHSSMbnN
 RbXijigCqYMfSWx4sGp2JPIdHTJJAssNTsFD84ZUK0NcTlt+PZ93cRKJLDhZSiR5SK
 ODb17Ebq14yUSQxlhVqh5gRg0JJ1BIW8D9TLT5TMnrxosIngB2+avudkJqBb3RHtFF
 RZT6Aw/Qfn7DA==
Message-ID: <sashiko-outbox-214011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] drm/i915: Split intel_update_crtc() into its stages
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-5-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-5-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:48:48 +0000
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
- [High] drm/i915: Signed-off-by trailer uses handle instead of real
  full name
--

commit 4c5cd64a7c5678be3ce749725bc8055689ef0bfc
Author: ElXreno <elxreno@gmail.com>

> drm/i915: Split intel_update_crtc() into its stages
>
> Pull the arming of a pipe on the MMIO path and the bookkeeping that
> follows the commit of a pipe out of intel_update_crtc(), into
> commit_pipe_arm() and intel_post_update_crtc(). The next patch arms
> several joined pipes inside one vblank evasion critical section and
> needs them separately.
>
> No functional change.
>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
The Author and Signed-off-by lines use a handle ("ElXreno") rather than a
real full name, which does not meet the Developer's Certificate of Origin
requirements in Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D4
