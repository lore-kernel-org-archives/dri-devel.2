Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32118C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C0110F067;
	Wed, 12 Aug 2026 22:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cZyL++4B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EE1510F146
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 22:32:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B647541AFD;
 Wed, 12 Aug 2026 22:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7461F000E9;
 Wed, 12 Aug 2026 22:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786573971;
 bh=8r5wf+1EdOu9kDZSeKuRUzd6DU8YYx8iwDviFqjhf3w=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=cZyL++4BmFmoo9BIgo8g3pYbTdpvjKtLU46K+doWAdWyQ+ABhkt23ZDudjHO5RtyR
 ZarOQLDtGP/B0WDAIE0SVLWw50HTB/yJHcBYbIUAKU3+awH3DeKveuyLhKSMz4fBTP
 4VxEVl3pCR6JLAzBNZA7b/y/5cWqnsHDOgApmd6MDamKw28/LNP2IHuKKWiXHzxGET
 BSXbE+aWud+vt0Uy7W99wvRsN3lqE6fpsKQ25D3vnMSTrA/HnxoVdj9pvoxCGtQrxX
 mSzIyw+UeqfRWJxqm0fsbCIpB/XmgKQJCXLwuAWLr4OpKqBjChKAms8D1RcLMaN//H
 UGSKLCo5/h34g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 00:32:45 +0200
Message-Id: <DKNBM5C0CWIL.1Y659FEPPM2G0@kernel.org>
Subject: Re: [PATCH v2 2/3] rust: dma: rename dma_handle to dma_address
Cc: "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
 <20260805-falcon-dma-projections-v2-2-4cc9f3f13ee9@nvidia.com>
 <3a87960b-8a20-4947-a8b5-d5197174317c@arm.com>
 <DKHATVF1WAE7.NGVXJQD12XQ@kernel.org>
 <DKIQEJX6H5A0.1D3POLLNZB9YS@garyguo.net>
In-Reply-To: <DKIQEJX6H5A0.1D3POLLNZB9YS@garyguo.net>
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

On Fri Aug 7, 2026 at 3:04 PM CEST, Gary Guo wrote:
> On Wed Aug 5, 2026 at 9:39 PM BST, Danilo Krummrich wrote:
>> On Wed Aug 5, 2026 at 1:32 PM CEST, Robin Murphy wrote:
>>> To be fair, that is sort of the intent in the C API as well, to be clea=
r=20
>>> that DMA addresses must not simply be treated as physical addresses, an=
d=20
>>> aren't necessarily address-like in general e.g. comparing two=20
>>> dma_handles is pretty meaningless, since they could have different=20
>>> values but still refer to the same underlying memory, or vice-versa.=20
>>> Adding or subtracting offsets within the bounds of the original=20
>>> allocation/mapping size is pretty much the only arithmetic that _is_ va=
lid.
>>
>> Yes, I did suggest a dma::Range type [1] for this purpose, such that onl=
y this
>> kind arithmetic is possible to do.
>>
>> The dma::Range type should have a method returning its embedded raw valu=
e which
>> then can be used to program registers etc.
>>
>> This patch is only an intermediate step, that clarifies that intent of t=
he
>> current usage of dma_handle() (or now dma_address()), which is not to se=
rve as a
>> handle.
>
> I suppose with I/O projections now it's rarer that people need to operate=
 on dma
> address directly? What do you envison as the use case for `dma::Range`?
>
> Also, I suppose we can also represent dma address ranges as `Io` views th=
at does
> not implement any accessor methods, so projection still works on them.

Yes, that covers most cases. What about SGEntry cases and CoherentHandle?

For instance, in nova-core we currently have

	for sg_entry in sg_table.iter() {
	    let num_pages =3D usize::from_safe_cast(sg_entry.dma_len()).div_ceil(G=
SP_PAGE_SIZE);
	    for i in 0..num_pages {
	        let entry =3D sg_entry.dma_address()
	            + (u64::from_safe_cast(i) * u64::from_safe_cast(GSP_PAGE_SIZE)=
);
	        dst.extend_from_slice(&entry.to_le_bytes(), GFP_KERNEL)?;
	    }
	}

which could become

	for sg_entry in sg_table.iter() {
	    sg_entry.dma_range().for_each_block(GSP_PAGE_SIZE, |addr| {
	        dst.extend_from_slice(&addr.to_le_bytes(), GFP_KERNEL)
	    })?;
	}
