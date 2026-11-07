Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1032606A333
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyB6++V8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4263810E5DD;
	Sat,  7 Nov 2026 13:03:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C126A10E5DD
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:03:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EBF940F4D;
 Sat,  7 Nov 2026 13:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533251F0089F;
 Sat,  7 Nov 2026 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794056627;
 bh=Ey3oHwVRsPT9qCJLHcC4MSGbnBIXfjqy7Yr85fp9kEs=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=OyB6++V8XHk3eQemxKVKupYvoakLI1Ou1n653MBQuMvbrfovPU8DNu53ofiLG6oIj
 ixQW+x7K/NPoq7aJMnGxzSSAA+BDUjyihYUmiRVPqlHC2qHP0S+wG9ZUtHoIF3WTrx
 jiR7aVFGR+nnDUAGfUoA2SaOLfyigGewEW8DS/8Davt4PUDvF6pBlDVIXJ1Okn8bVM
 /fM2L20AKZhINkKEtjjAnrixMCMWc6CHr+K3020NsM/VvZC24IeDQ8pYYqGpCGFuTl
 lA0ri66JSFc+2Z8qHTbj8qbGcVA93XgdkchmpZAQv1P5N6eqyvx8cVvaDV174lDIVi
 //nA8e1rN5P6A==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 14:03:40 +0100
Message-Id: <DMOZZTN9Y87S.BEGCSG2XU10S@kernel.org>
Subject: Re: [PATCH v10 1/3] rust: use Alignment size constants
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
 <DMOZR1THYXEZ.138HB6J6HIMFK@nvidia.com>
In-Reply-To: <DMOZR1THYXEZ.138HB6J6HIMFK@nvidia.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 1:52 PM CET, Alexandre Courbot wrote:
> On Mon Oct 19, 2026 at 1:29 PM JST, Eliot Courtney wrote:
>> Use `SizeConstants` for Alignment that are implemented now.
>>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/fb.rs               | 10 +++++-----
>>  drivers/gpu/nova-core/fb/hal/gb100.rs     |  2 +-
>>  drivers/gpu/nova-core/fsp.rs              |  4 ++--
>>  drivers/gpu/nova-core/gpu.rs              |  7 ++-----
>>  drivers/gpu/nova-core/gsp/fw.rs           | 12 +++---------
>>  drivers/gpu/nova-core/mm.rs               |  2 +-
>>  drivers/gpu/nova-core/mm/bar_user.rs      |  7 ++++---
>>  drivers/gpu/nova-core/mm/pagetable/map.rs |  7 +++++--
>>  drivers/gpu/nova-core/mm/pramin.rs        |  6 +++---
>>  drivers/gpu/nova-core/vbios.rs            |  7 +++++--
>>  rust/kernel/gpu/buddy.rs                  | 26 +++++++++++++-----------=
--
>>  rust/kernel/io.rs                         |  5 +++--
>>  12 files changed, 47 insertions(+), 48 deletions(-)
>
> Danilo, Alice: could we get an ack for the buddy and io parts, in order
> to push this series through drm-rust-next?

Not a big deal, but can't we make this separate patches?
