Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0768C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D47C892E4;
	Fri,  4 Sep 2026 19:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LQ/aG+me";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018F410FB2A
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 19:10:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C45543A6D;
 Fri,  4 Sep 2026 19:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA81E1F00A3D;
 Fri,  4 Sep 2026 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788549051;
 bh=na5i1soZ3xqfV/G5eljpoR2AX2PA9y24/AE4TJM7JtE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=LQ/aG+me4upa5df7ulLAA64VaBaBAdjtkw0SOHI/EFR/Xk3x7hYBzSCXQ1k/pah9K
 beBHNIiqOHnRo+ud//ZQME2IAuVxkXO3qgTdh+a21w4y5dhOYzoPUrosXFKOk+ZUDf
 UKv5XzzjWVagO9bS0WSkwsuQZ2YEeKzsjTRPXlSuc291tN+kfA8AQIlwUy2c4EQ8sM
 46zwRDWgy5bL5OyfFWnY6Bt+SHY5FzNlIIdK9KGKThBR4DJGu8t09ipV9dywUMpfys
 kBLkBY2tD7nGnT69KRibzODytZcZVqxeZf1bJjWKUPVe4k1tdxQu388GeLD3wd+5gQ
 7UT7IMeFYYqQQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 21:10:44 +0200
Message-Id: <DL6RPZU472G9.2IG1XWSTOAMFU@kernel.org>
Subject: Re: [PATCH v10 1/2] rust: Add dma_fence abstractions
Cc: <phasta@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 "Asahi Lina" <lina+kernel@asahilina.net>, "Burak Emir"
 <burak.emir@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812072217.1971807-2-phasta@kernel.org>
 <20260812072217.1971807-3-phasta@kernel.org>
 <DL6N387CE2AT.1LU4TDUB8QBIU@kernel.org>
 <5916d336906e4918a379178eca5699c2f7506ce8.camel@mailbox.org>
In-Reply-To: <5916d336906e4918a379178eca5699c2f7506ce8.camel@mailbox.org>
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

On Fri Sep 4, 2026 at 8:53 PM CEST, Philipp Stanner wrote:
> On Fri, 2026-09-04 at 17:32 +0200, Danilo Krummrich wrote:
>> On Wed Aug 12, 2026 at 9:22 AM CEST, Philipp Stanner wrote:
>> > Add abstractions for dma_fence in Rust.
>>=20
>> I was about to pick this up, but ended up with too many things to tweak.
>
> :(
>
>>=20
>> =C2=A0 * Fix checkpatch.pl warnings,
>
> I get two, one of them being obsolete

I think the other one was a spelling mistake, do you run --codespell?

> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #114:=20
> new file mode 100644
>
> WARNING: line length of 101 exceeds 100 columns
> #158: FILE: rust/helpers/dma_fence.c:40:
> +__rust_helper void rust_helper_dma_fence_unlock_irqrestore(struct dma_fe=
nce *f, unsigned long *flags)
>
>
>>=20
>> =C2=A0 * use Opaque::zeroed() instead of __GFP_ZERO,
>
> That's literally what I had originally, but Alice objected and wanted
> GFP_ZERO, AFAIR because it's more efficient.

I don't think you can say this in general, it depends e.g. on the size of
T::FenceDataType, etc.

But struct dma_fence is pretty small, I doubt one can even measure the over=
head.
Besides that, fence context creation is a cold path with many *much* more
expensive operations.

If we'd really care about that, you could also do neither as __dma_fence_in=
it()
should write all fields anyway.

> Maybe you two want to get to an agreement on what's better.

Nah, it doesn't really matter, anything is fine with me.

>> =C2=A0 * use kernel vertical import style.
>> Here's the diff I suggest for a v11:
>
> Thx, I'll take it into account.
