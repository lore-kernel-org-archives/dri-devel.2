Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F62606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OT4R3ech
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E9210E4B4;
	Wed, 18 Nov 2026 22:46:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1752D10E4B4
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 22:45:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 052C262253;
 Wed, 18 Nov 2026 22:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2331F000C4;
 Wed, 18 Nov 2026 22:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795041954;
 bh=BYk/c0gsLCrf5jVqJaRR5xbeOm4kW9crjwwPAlxYeHQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=OT4R3echz20YrVaDz2cGiE48b9X9zbzL9vkrT+mAkViLCRjJgi7IfPWvL5ItLyaoc
 /hHi40GLVuT1bfxoSz6NWJRxulAw9mp+uboI7Jc9PjHuAeUIdpyH9WaHaxa+VFjjs1
 RnsPa/PNx4Kr7sE9wmF2mQlH60p6iYJiNCOAyfAuYeD5fKAgUD3HANf4J8TGJS1mUO
 YOJWm7GQJvwMbcAs/zf1iIpXjswNwRwGlm2Q3cg3pt3y/7KdS6tyU6JwxQlOKWEqvc
 JZTnJqvu2adHU+OxVkB6RuaQGOIFgBia/l7Ad58h7Q5u/UgoxMpzrXih0Ins4QTJwq
 CbJscQixm7CpQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 23:45:49 +0100
Message-Id: <DMYP9JMEAF53.13MHUJHT7J420@kernel.org>
Subject: Re: [PATCH 1/2] rust: scatterlist: tie owned tables to the device's
 bound lifetime
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261114234324.82387-1-dakr@kernel.org>
 <DMWC45NN5L9I.2NUG81ETBC84L@nvidia.com>
In-Reply-To: <DMWC45NN5L9I.2NUG81ETBC84L@nvidia.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 5:02 AM CET, Alexandre Courbot wrote:
> The `RawSGTable` documentation still mentions `Owned`. We could adapt it
> or (maybe better) just drop that sentence.

[...]

> `sgt` is removed by this patch.

diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 93f431d7f548..22d039f3fdb1 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -214,9 +214,6 @@ fn drop(&mut self) {
 }

 /// A transparent wrapper around a `struct sg_table`.
-///
-/// While we could also create the `struct sg_table` in the constructor of=
 [`Owned`], we can't tear
-/// down the `struct sg_table` in [`Owned::drop`]; the drop order in [`Own=
ed`] matters.
 #[repr(transparent)]
 struct RawSGTable(Opaque<bindings::sg_table>);

@@ -282,7 +279,6 @@ fn drop(&mut self) {
 /// A [`SGTable<Owned>`] signifies that the [`SGTable`] owns all associate=
d resources:
 ///
 /// - The backing memory pages.
-/// - The `struct sg_table` allocation (`sgt`).
 /// - The DMA mapping, released before the table and backing pages are fre=
ed.
 ///
 /// Users interact with this type through the [`SGTable`] handle and do no=
t need to manage
