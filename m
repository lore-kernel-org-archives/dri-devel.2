Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E698606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Awc7ULZ3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B488F10F79B;
	Tue, 24 Nov 2026 16:24:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB0F10F78F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:24:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A03AA41A3E;
 Tue, 24 Nov 2026 16:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CB31F000C0;
 Tue, 24 Nov 2026 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537480;
 bh=6cfUoc15Ikd7ksK5UwKuGduYxbvZWelZh/k+rK8Lpes=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Awc7ULZ3qoe8X0oj6Vs3vv5QmcWL8Wn3EvaMxeZDl67+tymvzco2uLEqDRKIO+bS7
 n/W3va7Lt6JPeH51V3kAT+5xpw8iP4ShSwfcbjPdP9PJRKiQvd+ZBSXVI7I2VIwqkw
 sk/pfcj5UJ42cGfEDsITn3hikwl60PPQ8KFT+92WoiYmUah5lLQ7So/Dix4B8Qj1XH
 U1UZYKrmk61DpStVQQiN/xuoL4tJhLCyeGBDahpwgTHQroIahRLlvGqjt2Ie67iqIV
 ti8svw0M7CmvjAQwMjkY++0AoZAa7z1BBJK115NFSw0sUazc8DUBpTRDO+wkvy3sH+
 ShaCUFxep+PoA==
Message-ID: <sashiko-outbox-231553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] drm/panthor: Rename neural accelerator feature
 macro to NX
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124161952.1053586-3-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
 <20261124161952.1053586-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:24:39 +0000
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

commit ce6e22c794606bedaa1915cc0ee7c58ac972744b
Author: Karunika Choo <karunika.choo@arm.com>

> drm/panthor: Rename neural accelerator feature macro to NX
>
> Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
> Update the panthor_hw helper to use the new name.
>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

[Severity: Low]
This isn't a bug, but the commit message only restates the rename without
explaining why GPU_FEATURES_NEURAL_ENGINE is renamed to GPU_FEATURES_NX
while panthor_hw_has_neural() keeps its existing name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124161952.1053=
586-1-karunika.choo@arm.com?part=3D2
