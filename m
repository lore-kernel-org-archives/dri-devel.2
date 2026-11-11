Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F49606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcFm7Mhv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0660610FCBD;
	Wed, 11 Nov 2026 17:12:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D18E10FCED;
 Wed, 11 Nov 2026 17:12:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67929611CA;
 Wed, 11 Nov 2026 17:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE5A1F00A06;
 Wed, 11 Nov 2026 17:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794417164;
 bh=1Huj8VQR9Pol1tX/DUm46ZdSfS+Dy+eEjO0zCxYKFCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kcFm7MhvS4viYu77ugB2B5ZkavdD5NoRzDJl2OCjRXwr7QTit5sFmzEqe+u+41yKN
 OPxNmLMx54tdQFayQkFWci16u74+XS4ZHEdcq3cPaVkMJDwUtIVhzj0WztcNv/aI8C
 Lx6U6KzTaZvMDFVny5YgAlbFDuMCZEoO20FPs5nwflVPkdHkrS4V+TAat5daMNpDBc
 baoSC6E/R/nd2RPfFoA3eizc3p9gIpIdLvCJMznCWNRp9ak+l4p7+vVbIrFAkI7wF0
 hyj+LUj/a8L904AMksYEYG8sNo0cZYH1yK0VvhsinB5xK4lh0/gZ3yDWseM49TJE4S
 YR/Et6o5vYFyw==
Message-ID: <sashiko-outbox-209384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/15] drm/atomic: only add states of active or
 transient active colorops
To: "Melissa Wen" <mwen@igalia.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261111160814.21326-4-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
 <20261111160814.21326-4-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:12:43 +0000
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
- [Low] drm/atomic: missing Fixes trailer for
  drm_atomic_add_affected_planes() fix
--

commit ee3d4ff90daed11fcddfd7b71b626ca04e91bc82
Author: Melissa Wen <mwen@igalia.com>

> drm/atomic: only add states of active or transient active colorops
>
> Only consider affected colorop states those that are part of an active
> color pipeline or a pipeline that is about to be activated or
> deactivated in the same atomic commit, i.e., colorop is in the chain of
> old/new plane color pipeline property. To cover color_pipeline
> deactivation, remove the condition for plane_state->color_pipeline.
>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

[Severity: Low]
Since this fixes colorop state inclusion in
drm_atomic_add_affected_planes(), should it include:

  Fixes: 6955d6bca053 ("drm/atomic: Add affected colorops with affected pla=
nes")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111160814.2132=
6-1-mwen@igalia.com?part=3D3
