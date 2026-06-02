Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439DACD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD39710EEF9;
	Tue,  2 Jun 2026 10:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YDQG78iy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C3A10EEF9
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:49:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C29CB41B72;
 Tue,  2 Jun 2026 10:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32301F00893;
 Tue,  2 Jun 2026 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780397381;
 bh=dda2g0AOA+F5AMlYixnPmuaXdYO4GO3Dd+j+NDDNWxE=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=YDQG78iyxFxfFlfIM6CdZNi6ypYywtLJs8DYlBpEiptosw36TiVv5Yp0yc5BkCIHH
 ycf5o1u87MaFuGwaKVnSFNuDqHAo97VVTpvr/UTmyfmqVhV7T9cMZ+jTclNOuKwTCf
 vlrok6v4r23A1/bG9IhE6vGzQJlaeRfY9qYhRY0GHkB0vic8egs6Sw/WKTjYjWL/cp
 pjJ78+TZMC46sen9aTi6VlCk6VSVqxDKzMROnHElei4ykspkSfhoBWYUKSHSyP4giK
 s24p7UE9PoO4L8XE8o7+v5qkitI+muhjMLiyuMlZwBuZFHmJ/ggG45a0w4UkcUjxTg
 MKN1/DoyWTo+w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 12:49:38 +0200
Message-Id: <DIYI74CF465A.259FWQ2ZT6Y1Y@kernel.org>
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <boris.brezillon@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] drm/tyr: use IoMem directly instead of Devres
References: <20260529000106.2257996-1-dakr@kernel.org>
 <20260529000106.2257996-3-dakr@kernel.org> <ah1SSN8_dCEA4Osz@google.com>
 <ah4t8IPo1L6XZMy_@um790> <DIYHW8MAG0AY.FJ96EJ5RDZK7@garyguo.net>
In-Reply-To: <DIYHW8MAG0AY.FJ96EJ5RDZK7@garyguo.net>
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

On Tue Jun 2, 2026 at 12:35 PM CEST, Gary Guo wrote:
> I am not sure what the distinction even mean for a class device?
>
> There's 1 device per registration, so they're equal. Am I missing somethi=
ng?

The existing DRM device private data's lifetime is tied to the lifetime of =
the
DRM device itself, which makes sense as long as IOCTLs are not guarded agai=
nst
driver unbind and can still reach into the driver after driver unbind.

Once that is changed, this doesn't make sense anymore, the driver structure=
s are
then tied to the lifetime of the Registration.

Any handles that userspace may keep open beyond this should be handled by t=
he
subsystem; at this point there is no more HW state the driver would need to=
 take
care of.

Thus, the private data tied to the lifetime of the DRM device won't be need=
ed
anymore, see also [1].

[1] https://lore.kernel.org/dri-devel/DIXMEKSYML5D.1JUXO9CW10RY8@kernel.org=
/
