Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B085CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0520F10E7C1;
	Mon, 22 Jun 2026 17:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N0SQLaX7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864F710E7C1;
 Mon, 22 Jun 2026 17:51:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A2F7601F3;
 Mon, 22 Jun 2026 17:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1421F000E9;
 Mon, 22 Jun 2026 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782150668;
 bh=qaTMOMArbJO9+bFRaoOprCcsGyBpTalp5WHHmMeRU3U=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=N0SQLaX76cjgaI9P7c6P9J3nP3brat1Paxtb+UVWEat1qvWnzi15leZm7Tg+04lSm
 goxLZB0NlNTy35HWzcayeCfMWC/zGJtB2FbgxL19bOm1O8zjTLHknQJFkBlx/nW0Ir
 rch1tOg6I17/FjZrXpypqrTW4fqwJsyscJ202J4nFAgkrYOKiiLT4cXOM5Ce4Hu5co
 Tse+7Fwln4MiJoQfgA5O+ZRZQlfo9+DdHafud8qaVyxkOeAGyIrZOpVXywamN9KRKI
 +5TlXfhdKgDnD2h4nvdVS4w/er2w77EpzBDUNn3LVu76XMmGc7DjyobfT9ZASyrdqs
 3tVBy9J0cstUg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 19:51:03 +0200
Message-Id: <DJFROOH493EG.1ODJ1NF6VVMPV@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
Cc: <phasta@kernel.org>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 <dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>, "Lyude Paul"
 <lyude@redhat.com>, <nouveau@lists.freedesktop.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boris Brezillon" <boris.brezillon@collabora.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Dave Airlie"
 <airlied@gmail.com>, "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@mailbox.org>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
 <DJEU27KUZRNN.3R1F8AL6UL30S@kernel.org>
 <d3e27b911dd1c0261c2c4d7d65d12d6c1aef58ff.camel@mailbox.org>
In-Reply-To: <d3e27b911dd1c0261c2c4d7d65d12d6c1aef58ff.camel@mailbox.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Jun 22, 2026 at 10:57 AM CEST, Philipp Stanner wrote:
> Tvrtko's patch does not address the RCU issues you mention, nor does it
> address any other fence related issue except for adding the comment that
> should have been added back then with the fix in nouveau_cli_work_ready()=
.

I described exactly that, with the goal to discuss a proper solution rather=
 than
arguing about which hack is the better one.
