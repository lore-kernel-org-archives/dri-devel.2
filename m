Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7282A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONw0zvD5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C8E10FF18;
	Wed, 18 Nov 2026 17:59:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF3410FF26
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:59:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EECBD635E4;
 Wed, 18 Nov 2026 17:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E161F000C5;
 Wed, 18 Nov 2026 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795024783;
 bh=MA5d+ycHgls6wQsMC5x72So3CjhOE08GAohyL3p2KU4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ONw0zvD5QseopHTyfrotnD/eF1FMiNak4wl6PniKzxnjxfakj3tHiJmf09eNDHEMj
 Z7x9sLpS5Gpj9kZtGYqbB4dKMjauz53Di5zMV+/dCh2OQNXaTT6FWoszePWSI5ecan
 Vggifzg75nTzV44GxW/tVfWE8ihEuSnU7nAIi5B7QA6VE5vztwGORs8u57u2+/iVqb
 s9eG6Su71VYWwHD4k+APhjI3ipF3awNdxR1I0h7n4JDHPoW5r7fP8bObv1ETFXpaQO
 Lyq5T8O42rMRZtTcAhu4VWGjLgLImtTBMAqAcfMrzhlWyZGMia1NSJ7QGn3oK8Z0yU
 Lo3Zd9X3thZQQ==
Message-ID: <sashiko-outbox-221714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] drm/panthor: Rename neural accelerator feature
 macro to NX
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261118175332.519657-3-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:59:43 +0000
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
- [Low] drm/panthor: commit message does not explain why GPU_FEATURES_NX
  is renamed
--

commit 3c2d4a42dd0c3592fabeebac43540b024c3cd919
Author: Karunika Choo <karunika.choo@arm.com>

> drm/panthor: Rename neural accelerator feature macro to NX
>
> Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
> Update the panthor_hw helper to use the new name.
>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

[Severity: Low]
Could the commit message explain why GPU_FEATURES_NEURAL_ENGINE is being
renamed to GPU_FEATURES_NX (for example, to match the hardware register
specification or product naming), while panthor_hw_has_neural() and the
PWR_NEURAL_* definitions keep the NEURAL naming?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118175332.5196=
57-1-karunika.choo@arm.com?part=3D2
