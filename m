Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B6AC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4428010E56D;
	Thu, 23 Jul 2026 11:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yy+oMhUx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA9610F09F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:14:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C84D0600AD;
 Thu, 23 Jul 2026 11:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B671F000E9;
 Thu, 23 Jul 2026 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784805243;
 bh=tL8U/snSpPsV5sjc2a0mjLNSXwYrsiEDHKfqmhjl67I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yy+oMhUxFRdy78E3x33g3WXEOEKZe4cFMFLkVCWWUIJyp77qnNGrJYNGsXZV1GLOx
 MYWqu6fjjIUaRDClgs2+BOAZ/Wp6pKzGDpm2GEC4gYO+pHMsqOlXqY1zCbM7/fn0e8
 ZzVgs4jYEoQauFLdUY3nf4ndVPQcP0XjatH3ROa6yb2HVYNAbzny1/Y/nPC+mQyygB
 mliy5Vl0GLhdrbzwcmGRiJBsu58F1bYILXeVe8S2W9TyvVcXzQBu8LCSSc5W8zI8uy
 JdSaH0uqUpGKoxYz/RR/aWZc0PaHDhpbPtTkhxvSAYFlqja5OCpiYfNz6VRXYpyhIR
 llfFjVJEWuW7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] drm/i915/gem: Pull out size validation into a
 separate function
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723102542.3245495-4-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-4-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:14:01 +0000
Message-Id: <20260723111403.54B671F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typos in the commit message making it difficult to read.
--

--- Patch [3]: [PATCH v4 3/5] drm/i915/gem: Pull out size validation into a=
 separate function ---
commit 1c3ac6d93ee48bc676608654e6e56d00b02a3262
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Pull out size validation into a separate function

This commit refactors shmem_sg_alloc_table by extracting the size validation
and page count assignment into a separate helper function to improve
readability.

>     shmem_sg_alloc_table is a very large and hard to read function,
>     so reduce the number of operations it is responsible for by
>     placing "size" validation ind "page_count" assignment n a new
>     helper.

[Severity: Low]
This isn't a bug, but there are a couple of typos here ("ind" instead of "a=
nd",
and "n" instead of "in").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723102542.3245=
495-1-krzysztof.karas@intel.com?part=3D3
