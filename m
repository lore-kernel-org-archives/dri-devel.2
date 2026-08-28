Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B84EC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 18:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3279710E4B8;
	Fri, 28 Aug 2026 18:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZHlxmVsx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11BE10E4B8;
 Fri, 28 Aug 2026 18:12:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3C8B60052;
 Fri, 28 Aug 2026 18:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A61F000E9;
 Fri, 28 Aug 2026 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787940722;
 bh=enYrTIiUDgLZ6qrNsLyru4eCF8JD5x+/rIFCtu+nnmc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=ZHlxmVsxGRgrs0bL2wgqPL1SSlXehSQyaRk6Ooy1l1d8UwLm8hydyBYafnj8GxqnD
 ksW9e9MB39mMsez0Q8xGMqY7PPM0H56VNXh+yexDQclRzDaeuimbAn0vyLnuWr5aas
 44cYWTZFiIA/6QBOUYKrBU6JdFl7dfh1yLpjEqXFHdf7LiMqQjms6cWmztOCsFj1wH
 5SZwf7i07eU9s0FYrtiJPNxO5tG98fb8H6D2QmfVsxfmYlA2O2n6DJDultTNtGTHjU
 rMMOCUO4FyVGLpzA8daSZpGHXLqF0wnNBysjqDTadRfTUDf2RTnJ+KX/AMDpqoyAB6
 PzDu6VSrhDgsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 20:11:56 +0200
Message-Id: <DL0S35VSVSX0.3KQH490YEZUR0@kernel.org>
Subject: Re: [PATCH 2/6] gpu: nova-core: add NVKV encoder
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260817-b4-nvkv-v1-0-b84db5e84b67@nvidia.com>
 <20260817-b4-nvkv-v1-2-b84db5e84b67@nvidia.com>
 <DKT2C9FT6IBW.3L5PJN1J8IVLD@kernel.org>
 <DKT2NSDRJXYX.1S0H8K3Z75QVK@kernel.org>
 <DKZSNG5J5UA8.12HFHO9KURG0G@nvidia.com>
In-Reply-To: <DKZSNG5J5UA8.12HFHO9KURG0G@nvidia.com>
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

On Thu Aug 27, 2026 at 4:25 PM CEST, Eliot Courtney wrote:
> I sent the respin of this series using your EncodedStream idea but I
> think I should add you as Co-developed-by. If that makes sense I will
> add it plus your Signed-off-by (I think that's the right process?).

Sure, if you think it is justified, please feel free to add those tags. Wil=
l dig
into v2 soon!

Thanks,
Danilo
