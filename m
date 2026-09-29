Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D03ACA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 20:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96F310E84C;
	Tue, 29 Sep 2026 20:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VhOanSht";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2658010E84C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 20:43:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2711A6022F;
 Tue, 29 Sep 2026 20:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856FC1F000FF;
 Tue, 29 Sep 2026 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790714628;
 bh=1QdUQtGpZBOclXG/K5zrAwhgVwrWhwndx2juy1qfu6Y=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=VhOanShtKisgQOxdUhh0WvO1nLI4+lImCAPmIKhhdmgKgnLv664LZwqF7fK0hGhwI
 z1zbchdcqh9FDydsMDp5N5dR3c6cZT5S9sCipd1Q1lOjRlHKWoajlCg6ESGjk94CHC
 UXZN3iP/+yVPsCDlihDl4ZrootfmTmnOim0VsgcoMxAMHYr9H+oN+y9eBF+W3s6MRA
 0os1Pj1botqPDDEg7THy2DOdzI0g9cKwIRzxmlUaSakJxWvu7uRpJiw+u9rdgCZJda
 QgcgTUnkTcxVqeZuWu5yXsHe5HfF4rRzSXFEKowQRvotqAqQZsKpWzW/ttCCaDTNPX
 oxBHoz5QvDvog==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 22:43:45 +0200
Message-Id: <DLS3CUGE89P0.AV9LGT4GCLVV@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQIRUGZ3L4S.2HUCTWWXHIDII@nvidia.com>
 <DLQZW9ZSEQF8.EFP3CFEMUABB@kernel.org>
 <51dccdd0-eb85-4572-be62-6ca39038cbdf@nvidia.com>
In-Reply-To: <51dccdd0-eb85-4572-be62-6ca39038cbdf@nvidia.com>
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

On Tue Sep 29, 2026 at 10:31 PM CEST, John Hubbard wrote:
> I really would like this restored. This is a high value thing to
> print, because it acts as kind of a bookend, showing the beginning of
> trying to boot up.

Hm...the next print in the boot process is

	nova-core 0000:01:00.0: NVIDIA (Chipset: GA106, Architecture: Ampere, Revi=
sion: a.1)

which is at the very beginning of probe and to me seems sufficient.

But a debug print doesn't hurt, so if you prefer to keep it, no concerns fr=
om my
end.

> I can post a trivial patch to restore it, if desired.

That'd be great, thanks!
