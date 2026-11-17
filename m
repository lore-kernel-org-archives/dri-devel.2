Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA1606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dzk7/fYN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF34C88CBF;
	Tue, 17 Nov 2026 01:31:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF0F10E3A0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:31:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 449CC4141C;
 Tue, 17 Nov 2026 01:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D2E1F000C4;
 Tue, 17 Nov 2026 01:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794879096;
 bh=FurmrSzvHcKZh9s1lNpze/+efhYAHBcNhogCeaSoj0Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dzk7/fYNpbHJ4JvtflzxaUquu2eyha1qpIYlxjHC13xyTFY7tMHFF2kGo5iMDeAPF
 WWo22ylBo0cJUP6RSMMvnqaWBtd3km2eP1Sk2T5XadFLy/+onlUhKW5M0WLXixuKoU
 ygIrplilwXyMQ/mWQ/d13IweljUuXpLSym8cUBPOFRyjpqQegHWYGawRzqOGirXH1q
 WBUEMbe4QVucgvGplYEGztyNA4iBMz6OSAjD1xUruMra0mOKLToqYJeX51+Yj1s3Gc
 /W5IpBd4mcsW+O9owO47qk1Ucqbv2k3glci6FAlWyqBfRPHiXolaWPGoSOSP9sQDp/
 P4/8Pn3X2T8rw==
Message-ID: <sashiko-outbox-218043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/vkms: Add KUnit tests for RGB332 and BGR233
 writeback conversion
To: "Sidharth Saha" <ssaha2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-rgb565-test-v1-4-27f49c1aa694@gmail.com>
References: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
 <20261116-rgb565-test-v1-4-27f49c1aa694@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:31:35 +0000
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
- [High] drm/vkms: invalid noreply and mismatched email in Signed-off-by
  trailer
--

commit 029ee38d1c5f0c8b5a4e5b775f76588cc0eb383e
Author: Sidharth Saha <ssaha2000@gmail.com>

> drm/vkms: Add KUnit tests for RGB332 and BGR233 writeback conversion
>
> Test argb_u16_to_RGB332() and argb_u16_to_BGR233(), which reduce 16-bit
> channels to 3/3/2 bits. Cases cover the 0x8000 midpoint, inputs on
> either side of the first rounding step for both 3- and 2-bit channels,
> and a round trip using values produced by the read conversion.
>
> Make both functions visible to KUnit so the tests can call them.
>
> Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github=
.com>

[Severity: High]
The Signed-off-by trailer uses a non-routable GitHub noreply address that
does not match the commit Author address (ssaha2000@gmail.com).  Should
the Signed-off-by line use the routable ssaha2000@gmail.com address to
satisfy DCO requirements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rgb565-tes=
t-v1-0-27f49c1aa694@gmail.com?part=3D4
