Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E523BC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF3A10E46F;
	Wed, 12 Aug 2026 23:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n+2d8PF8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E3D10E46F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:15:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3D3F4057E;
 Wed, 12 Aug 2026 23:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0392F1F000E9;
 Wed, 12 Aug 2026 23:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786576513;
 bh=9riEFF4pNfrUS8nXbREomHAlcpz0VMXUt2FDXJcbCnM=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=n+2d8PF81yk7gnDknORv9sG1adGZBHQ2qvgfIQWAMizMhaVBAWBIDKPiZrUZqwKTv
 RhFxnP+PGPsazbZmIHtQANlYTh1sBCHrkrm0vX1rR6L0S0tChjLAfuHjD6Xp0f7Y7X
 J84K8qp0HyiTRpYnh4ykoicrku7kKr1aYa4NmPfe+xNedtGvY6NDAcYdf7wH3eMw4d
 NbGBoIfnBtGN9u91ilk23iVZLyZmr+LGggKtIPYxZ3RR5Ke0BhEkp/mzGVRe3wNkVV
 ULMiWPj09CeayA7IO6XdlQ78Ge7MMstzgMD7sv59xwg9WlqsiTR/WTIa90qIjxYKz0
 GKk9xbW9UHNHg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 01:15:10 +0200
Message-Id: <DKNCIMHM4AG6.145KTN1QZLFTD@kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Cc: "Vladislav Zaharov" <vladazaharova2018@gmail.com>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
In-Reply-To: <a72edc5b-49c0-42e0-b21c-940e71909666@nvidia.com>
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

On Thu Aug 13, 2026 at 12:41 AM CEST, John Hubbard wrote:
> I'd *much* rather use a kernel parameter: keep_gsp_logs, instead of
> requiring a rebuild of the kernel. As you mention above, nouveau
> arrived at the same conclusion, and yet even after mentioning it,
> you went off in this other direction, but without explaining why.

Not sure if Vladislav read that, but it might be on us; we were both talkin=
g
about a Kconfig in [1] back then, but meant a module param actually. :)

> If someone is debugging, all they need to do is reboot with that
> parameter, in order to get the logs. That's a big improvement over
> requiring a kernel rebuild.

I think for development it doesn't make a huge difference, but a module par=
am
might be easier to deal with if something unexpected happens in some less
controlled environment.

So, while I'm usually not a huge fan of module params, I do agree in this c=
ase.

[1] https://lore.kernel.org/all/067c6016-ce21-449e-b0d6-86252ac483a0@nvidia=
.com/
