Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC783606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ophYpZLf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5503010F050;
	Mon, 16 Nov 2026 12:43:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6275010F050
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:43:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4810A400C4;
 Mon, 16 Nov 2026 12:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84781F000C4;
 Mon, 16 Nov 2026 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794833016;
 bh=CXw4JlwiXiBhfP+REkN7yHwsbglu9GFDUemcCMcjoyM=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=ophYpZLfEeJvZlyuCYfZQfdTYYsdpI8fR6sP3Tve7NtPhGSNkll+L3vUBsawnzHZK
 tgqRZdtsdeyiesEA2ZzPZB65M1ecVQ7kkIXgSEeoZGEvfcd7M8KVIUThCyAuMAqKJP
 D24o8ubU7QD9JSn3GLyCbxDyBgNeol2ayOI+Ux3kJA28Wj/MSsRtKvXsbj5CsHS+k+
 pycZ86HNuYgM2sC1qAItD/vL1oaoobi2HtgHkaGW6d2x0VpwMPFvtNDg8JZfy6HABW
 scy6jgCf2Ckujy4m/DVo2UZOgYwis6praWLL4Osj8ZBRoUd1t6DkHcirUWZ5nkNZDo
 +HKIJrcojIMJg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 13:43:31 +0100
Message-Id: <DMWN7AJF6SXX.1HN3UMDROET7F@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
>> @@ -81,7 +78,7 @@ pub(crate) fn new(
>>                      let mut level0 =3D CoherentBox::<'_, [u64]>::zeroed=
_slice(
>>                          dev,
>>                          GSP_PAGE_SIZE / size_of::<u64>(),
>> -                        GFP_KERNEL
>> +                        GFP_KERNEL,
>
> Stray hunk? Maybe we can move it to patch 2 since it reformats that part
> anyway.

I noticed this before sending too, but for some odd reason rustfmt insists =
on
this with this change.

When I noticed I was 'whatever', but now I got curious. It happens when

	level2 <- {
	    build_lvl(&data)
	        .map(|l2| SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNE=
L))?
	},
=09
is changed to

	level2: {
	    let l2 =3D build_lvl(data)?;
	    SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL)?
	},
=09

>> @@ -308,38 +283,27 @@ fn drop(&mut self) {
>>  ///
>>  /// - The backing memory pages.
>>  /// - The `struct sg_table` allocation (`sgt`).
>
> `sgt` is removed by this patch.

Good catch, I will remove this and the other one.

> <...>
>> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
>> index ffb693544673..844e137cddc8 100644
>> --- a/samples/rust/rust_dma.rs
>> +++ b/samples/rust/rust_dma.rs
>> @@ -35,8 +35,7 @@
>>  struct DmaSampleData<'bound> {
>>      pdev: &'bound pci::Device<Bound>,
>>      ca: Coherent<'bound, [MyStruct]>,
>> -    #[pin]
>> -    sgt: SGTable<Owned<VVec<u8>>>,
>> +    sgt: SGTable<Owned<'bound, VVec<u8>>>,
>
> Since there is no more `pin` in `DmaSampleData`, can we also remove its
> `pinned_drop` attribute?

Yes, I left it as is intentionally though as this patch is purely a mechani=
cal
conversion. I can send another one, analogous to the nova-core one.
