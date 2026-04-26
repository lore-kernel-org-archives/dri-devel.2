Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645A0FF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 21:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5496D10E16B;
	Sun, 26 Apr 2026 21:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NkMirT4R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFBC10E16B
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 21:33:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AAAE60138;
 Sun, 26 Apr 2026 21:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFCC2BCAF;
 Sun, 26 Apr 2026 21:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777239187;
 bh=hhIRGFDgMyHb8qHPStrp0zkhGvc8+JYpfKJhJoTAMGg=;
 h=Date:Subject:Cc:To:From:From;
 b=NkMirT4RfEeb5R8pDjOqGbdD//pRfJvN0+IIyTnLsEc+8Hk8xiGaAWRc3eeVkEVwm
 w748UGO4Iq/lbDFRJx8VXvXTNNnlujVU352owigj38NQm9EvegTJiugcke2AJbNkWN
 vQcAOGFCp4zkxUA7yGj4P76aKdLdiMap2OITP5w9NbRb1GRzTxH2b2X4p5sQcRopW4
 deImKdWJsRnCKXVCTlhFXhKkSebVcCTmzelN/ulmvSb17ta9pWKBjep3hNeS8Zuh4j
 MKYx2ZPcFWUNDXoyNt02usw7MZktlEUqGgNrOoB3xlh/SIBN9CUxtWnDXdG3bLU8lB
 zySfeY8PVxR5g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 23:33:01 +0200
Message-Id: <DI3EPKNRWMQJ.17YVN5V0VBKLR@kernel.org>
Subject: drm-rust: process change announcement
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Gary Guo"
 <gary@garyguo.net>, "Philipp Stanner" <phasta@mailbox.org>, "Deborah
 Brouwer" <deborah.brouwer@collabora.com>, "Beata Michalska"
 <beata.michalska@arm.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Steven Price" <steven.price@arm.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Janne Grunau"
 <j@jannau.net>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
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

As already mentioned in [1], starting from the next cycle, the drm-rust-nex=
t
branch will be open for new features at all times.

Consequently, all patches applied to drm-rust-next after -rc6 do not target=
 the
upcoming merge window, but the one after that.

Fixes for code that landed in drm-rust-next before -rc6 have to go into
drm-rust-next-fixes.

drm-rust-fixes will continue to be the target for fixes for the current -rc=
.

Please also see the updated documentation in [2] and [3].

Also note that commits merged into drm-rust-next after -rc6 will not be pre=
sent
in linux-next until -rc1 of the next cycle.

- Danilo

[1] https://lore.kernel.org/all/DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org/
[2] https://drm.pages.freedesktop.org/maintainer-tools/repositories/drm-rus=
t.html
[3] https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-=
drm-rust.html
