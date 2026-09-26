Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32DDC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 21:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA8610E061;
	Sat, 26 Sep 2026 21:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KML1pR0+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840E510E061
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 21:38:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5478A600D1;
 Sat, 26 Sep 2026 21:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722DC1F000FF;
 Sat, 26 Sep 2026 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790458717;
 bh=YmeBn4iVGzFom21AShd9pBGF6QuXhtV16ZOJy3OGq4E=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=KML1pR0+BfrNQ4Yghb4qjoTrIkiQpkJD5iOutuYq57LmS/EWbufxO6Nsm864w1j6q
 V9zXwqGaXm7r4CTZi8CqSRf+EMPZffYdhA+DfQE7zNVFpVOVlZvTLGwKH3hRlwTTjw
 DxUNm+YyYtIVvyoGp4M5wFdE11SJ1PFxn5JlIbDilUD07S0YwzLwj4XPLf4xCzddVB
 jmctxQTigesltpMUQGm0x4t2BPNa2/de+yYDqFvLXQm6SLcSphIht6kDkem70oKnj4
 +81tg7oTWQto2bksJ2WuSChe41+vEIt7EvmKxL1FpiTUmK6kNC4uHug+mte5kUGndG
 6vEnZdG85S/pw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 23:38:31 +0200
Message-Id: <DLPKN532X7JJ.14Z51ZIBUIK94@kernel.org>
Subject: Re: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
 <DLPD8RQKM8VU.3QWOV9RFLA8S6@garyguo.net>
 <DLPE0D8F96DE.91C7E0MAERDS@kernel.org>
 <DLPJT1IUSKQO.1CAWHDECQAFPO@garyguo.net>
In-Reply-To: <DLPJT1IUSKQO.1CAWHDECQAFPO@garyguo.net>
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

On Sat Sep 26, 2026 at 10:59 PM CEST, Gary Guo wrote:
> On Sat Sep 26, 2026 at 5:26 PM BST, Danilo Krummrich wrote:
>> On Sat Sep 26, 2026 at 5:50 PM CEST, Gary Guo wrote:
>>> On Sat Sep 26, 2026 at 1:26 AM BST, Deborah Brouwer wrote:
>>>> @@ -71,3 +71,6 @@
>>>>  # Structs should implement `Zeroable` when all of their fields do.
>>>>  --with-derive-custom-struct .*=3DMaybeZeroable
>>>>  --with-derive-custom-union .*=3DMaybeZeroable
>>>> +
>>>> +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
>>>> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3Dzerocopy_deriv=
e::most_traits
>>>
>>> This is Tyr specific change and should be in patch 2.
>>
>> Why list all of them separately? Can't we apply this to all uAPI structs=
?
>
> There are types with paddings which cannot derive `IntoBytes`.

We have some existing uAPI structs without explicit padding; new ones shoul=
d use
explicit padding though.

But isn=E2=80=99t most_traits intended to handle this through best-effort d=
erivation,
leaving IntoBytes unavailable for types with implicit padding?
