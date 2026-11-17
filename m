Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ez34KnEd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F69610E032;
	Tue, 17 Nov 2026 01:29:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC8F710E032
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:29:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 069C66140E;
 Tue, 17 Nov 2026 01:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951021F000C4;
 Tue, 17 Nov 2026 01:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794878964;
 bh=XimPP6GSV6GemMlOK2R7eCOVM0+OOT/CApMAR4Y4CzY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ez34KnEdJZL1m0hZ6ztBvO7X54G16xWjNcjLf9FH3PZGNGk4oIDCq68TpbZNFJE4I
 vPQNAj1yen9cD/PBhMjLHFhuO9nK6SO+Ldn5UnqzOikLGDljg7mn2gwBnJKbNyvQcT
 kw0FddMuEsKpqmTNBC2Ry9K0oUiimvMRBp5T8G5Qgqn2d44lci8eKutHirIl1hMPfm
 ZIEKzllN3fjePVaMRUipL5ehRJpob+cW9/ks0XVh1i7GuOxzfC/Wuj72/yeGrKCghJ
 uknMhHFOip7lVVZJUaFj8/7PoaOSi3fkYnhmRb/575NBaf4oMvvUuZiqRj+zz0WwlY
 RFbcx/CzUCTmg==
Message-ID: <sashiko-outbox-218042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/vkms: Add KUnit tests for RGB565 and BGR565
 read conversion
To: "Sidharth Saha" <ssaha2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-rgb565-test-v1-5-27f49c1aa694@gmail.com>
References: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
 <20261116-rgb565-test-v1-5-27f49c1aa694@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:29:24 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/vkms: non-routable GitHub noreply email in Signed-off-by
  trailer
--

commit ae58f1df1e3854cf85fe440504baa5b724769237
Author: Sidharth Saha <ssaha2000@gmail.com>

> drm/vkms: Add KUnit tests for RGB565 and BGR565 read conversion
>
> argb_u16_from_RGB565() and argb_u16_from_BGR565() were converted to the
> new channels_to_argb_u16() helper. Test them against hand-computed
> values; the tests pass both before and after that conversion, showing
> it didn't change behavior.
>
> Make both functions visible to KUnit so the tests can call them.
>
> Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github=
.com>

[Severity: High]
The Signed-off-by trailer uses a non-routable GitHub noreply email address
instead of a valid, routable address matching the Author line
(ssaha2000@gmail.com).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rgb565-tes=
t-v1-0-27f49c1aa694@gmail.com?part=3D5
