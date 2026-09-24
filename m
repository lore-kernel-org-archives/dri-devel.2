Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0BFC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 17:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5E510E1D2;
	Thu, 24 Sep 2026 17:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lfWJgHjt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF4310E1D2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 17:21:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EF0C40A19;
 Thu, 24 Sep 2026 17:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488BC1F000FF;
 Thu, 24 Sep 2026 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790270517;
 bh=HBC3YtGwOS/hrQSLCFzW0giR+SP29nfbPT/65wjTmVA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=lfWJgHjti98TQemT6CHMxITv1UlfN1h+FF2he8rd4Q5Ic4jxUwIFecS0eOKr40yQ4
 YHBo5xMEnjywMrKcrxgGss1rotB9Dhh7WBV7B+7YmfNmjkzupCxcxlWV4qtNPMBb19
 NCcQSAH1WjA1znQLZbVRkXRxOvyd5i6qrtjxshOqEzYugWHh3F8kOquEoipqlTSjnN
 RczjE7Jl5QLWCaRAZQ0G6EKGllepLt1WRUw1R+cBfuqVwi9sW5/Z7Sa7fkYZK84djZ
 HIIieVSQvMEryHL4lEbfZ80JF4ueoeMSfCCZV1b2KFlWj4heNIDwsJyFLkpPtxJ4ZM
 PhPwumnfqGC2w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 19:21:51 +0200
Message-Id: <DLNPXJ4WPH4L.2MBUGV1TAESYY@kernel.org>
Subject: Re: [PATCH v3] rust: io: convert ResourceSize into a transparent
 newtype
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Robin
 Murphy" <robin.murphy@arm.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Lorenzo Delgado" <lnsdev@proton.me>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260920-resource-size-newtype-v3-1-9451444e83bb@proton.me>
In-Reply-To: <20260920-resource-size-newtype-v3-1-9451444e83bb@proton.me>
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

On Sun Sep 20, 2026 at 2:13 PM CEST, Lorenzo Delgado wrote:
> `ResourceSize` is a bare type alias for `resource_size_t`, so it
> inherits every integer operation and `as` cast. That allows operations
> that make no sense for the size of a hardware resource, such as mixing
> it with unrelated integers or truncating it with a cast.
>
> Wrap it in a `#[repr(transparent)]` newtype so each conversion at a
> boundary is explicit. The representation is unchanged, so this is
> ABI-identical; only the spelling at the FFI boundary changes. Provide
> `from_raw`/`into_raw`, `From` in both directions, and a fallible
> `TryFrom<ResourceSize> for usize`. On 64-bit, where `resource_size_t`
> is a `u64`, also implement `FromSafeCastArch<ResourceSize> for usize`,
> so code that is specific to 64-bit can keep the conversion infallible.

This looks good now, but it makes me notice that dma_len() shouldn't return
ResourceSize in the first place.

The length of a single SG segment is bounded by max_segment_size, which is =
also
unsigned int.

So, I think we should change dma_len() to just return u32 (I'm also fine wi=
th a
new type, but it might be slighly overkill).

I'd usually pick this patch regardless and leave that for a follow-up, as i=
t is
a separate issue. But if we change dma_len() first, we only have to update =
tyr
once, whereas if change it after we end up touching nova and tyr twice.

Thanks,
Danilo
