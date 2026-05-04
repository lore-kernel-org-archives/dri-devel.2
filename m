Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C73FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA0C10E009;
	Mon,  4 May 2026 19:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VE9SDWfQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C46810E009
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:42:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F075243ABA;
 Mon,  4 May 2026 19:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C8C2BCB8;
 Mon,  4 May 2026 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777923734;
 bh=2t8eYSnq0vCaib0IOLian329tB/t0se5+Jb2OTmsQn8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=VE9SDWfQdL8AYRxgta9nD/C3swhBTpOnocQyqvoyAOrO87/PVXrikJPqfz2Wa2iYw
 eFVXDiyDBDIrniWTz7oHhdxKIBSh9KeZQl72HxEuunddZuSRFKoAg7yCo/J3LQtcIY
 GLrhYT2M2TA3jWoAKQQ2ibTaHeTwA5laaEI5zx3SVdq4MkAtJ2X+ag5bYU1z8XSlTk
 p20AJZxLNpTP7Q79lmJaPcVQDy+ArZpPhP7Me5eHsqjM2lxJr8Qaw8u3xSJirXjW2w
 Wop5WCe+H/f1/N+grDH1zv+taphhCDqLVbpIYDgAQvjDVRgxRoZ58OME0ZWE7ayrve
 Kcu5B8tJBerTg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 21:42:07 +0200
Message-Id: <DIA5D0RYRE24.2LB65BF0UK4UI@kernel.org>
Subject: Re: [PATCH v12 12/22] gpu: nova-core: mm: Add page table entry
 operation traits
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy Baron"
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Dave Airlie" <airlied@redhat.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, "Nikola Djukic" <ndjukic@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer" <epeer@nvidia.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Andy Ritger" <aritger@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Balbir Singh" <balbirs@nvidia.com>, "Philipp Stanner"
 <phasta@kernel.org>, <alexeyi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <joel@joelfernandes.org>,
 <linux-doc@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-13-joelagnelf@nvidia.com>
 <DI8B0IOXNP2L.1NFX4OTABNHA0@nvidia.com>
 <53c88538-dca7-41f1-bb2b-856035728c69@nvidia.com>
 <DI9YR10HH6PE.AMLEZUV7701V@nvidia.com>
 <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
In-Reply-To: <bd210abc-590f-4011-8337-21b54780fd4c@nvidia.com>
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

On Mon May 4, 2026 at 9:28 PM CEST, Joel Fernandes wrote:
> We are already at v12 now

To be fair, the series is actually at v6, as you initially added those patc=
hes
to another series that was at v6 already back then, and then you decided to=
 just
keep going with it. So, nothing too crazy going on that front. :-)
