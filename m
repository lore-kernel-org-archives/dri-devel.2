Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09350606A326
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBrCGKci
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4E5112A94;
	Fri, 27 Nov 2026 12:46:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1246A112A94
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:45:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 497AF61F49;
 Fri, 27 Nov 2026 12:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDDC1F0089F;
 Fri, 27 Nov 2026 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795783557;
 bh=gXD/Y6noajIG21iPUOfGSGzR09j+kYz8fJ0NGxnapmA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBrCGKciRjh6mPVlBEq0gJ/lZeR3dgP3SputxuwrzVr94gOzlTVyFcqjv0Pj37lK6
 PfbuudqCKYPpd99jbF/b4uTc8bOOtah2+u+vKA8+QM1Sd/r/H/mziUCyK2Ai0XJ4YH
 qJQBaMhAwWgEQfLvmeDOpv/TfdmHS6RYCo3XZ1rldYK7+zh03RiJShCvRTNC+aXg6E
 27+rdsX4UycXbQ0dwvhshQfWMIGgmC+CkRtaCZxVyw880QdGOjl2PnZe9zShdh8b18
 Ai1Dq1otJ3lhwVw+LjOImMbmurO7/Z+3e4iShrcRkOc5OVydFYrccHVyeOsbbOQ4Sw
 63YfpBJNYNV/Q==
Message-ID: <sashiko-outbox-237428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tyr: fw: fix integer overflow and inverted range
 check in Cursor
To: "Bilal Hashim" <AeeSec@126.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261127124107.1782-1-AeeSec@126.com>
References: <20261127124107.1782-1-AeeSec@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 12:45:57 +0000
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
- [Low] drm/tyr: missing Fixes trailer for Cursor bounds and overflow
  fix
--

commit b90a1dd0329f798d9b7953db9ea5076afe11d6da
Author: Bilal Hashim <AeeSec@126.com>

> drm/tyr: fw: fix integer overflow and inverted range check in Cursor
>
> In drivers/gpu/drm/tyr/fw/parser.rs, the firmware binary parser `Cursor`
> has two bounds-checking bugs that can panic the kernel on malformed
> firmware images:
>
> 1. `Cursor::view()` checks `range.start < self.pos || range.end >
>    self.data.len()`, but does not check `range.start > range.end`. An
>    inverted range passes the check and panics when indexing
>    `&self.data[range]`.
> 2. `Cursor::read()` and `Cursor::advance()` compute `self.pos + nbytes`
>    without overflow checking. On 32-bit systems (or with large `nbytes`),
>    the addition can wrap around to a value less than `self.data.len()`,
>    bypassing the bounds check and panicking in `&self.data[start..end]`
>    or corrupting `self.pos`.
>
> Use `checked_add()` in `read()` and `advance()`, and reject inverted
> ranges (`range.start > range.end`) in `view()`.
>
> Signed-off-by: Bilal Hashim <AeeSec@126.com>

[Severity: Low]
This fixes bounds-checking bugs in Cursor::view(), Cursor::read(), and
Cursor::advance().  Should the commit message include a Fixes tag?

  Fixes: aa9ce8201360 ("drm/tyr: add parser for firmware binary")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127124107.1782=
-1-AeeSec@126.com?part=3D1
