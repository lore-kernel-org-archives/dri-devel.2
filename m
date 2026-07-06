Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EF4C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051BD10E38C;
	Mon,  6 Jul 2026 12:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pLygXaQU";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6722D10E38C
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:46:51 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-c07d22d503fso178690266b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783342010; x=1783946810;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w4Q98ESFsm5V2q2RxX/fy6rfondgx2jkzF1eEys7nYs=;
 b=pLygXaQU7Np6QIIZWMqn4m5e/hTkyMV2Y9YIKqbVVFk9PWdj4omKz8sGjbUaT6tr4P
 ztf43eQ7a1qb1FqjxGhNBXGXY/6wnKvHU3a/igFeF2/heRAsj0Ao4p0YoHCWnIjn8ZLs
 cdqnKeb5kacXu/iJN0dndDwUIJsZmeBNk5hw3CrrliCCkkVO4kS48zKSQFsTnqwO/+Nr
 h41PEmQfqxD9ZohfGSge0kexyJpvNzMhcy3IFVAQV7DjnBNbq7ozskUzQ12ucE8Wp7tN
 sXqRhstSv0O1mWVk/bC4CHnXtoMntMUrRR1Qw7NQFfQb2Z9wr8Y7S/yIA6TDsvG3GJ2G
 x5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783342010; x=1783946810;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w4Q98ESFsm5V2q2RxX/fy6rfondgx2jkzF1eEys7nYs=;
 b=msEREu4+HK0J2YqW7JwLeESK4rpmx+23T3cwnEANgmwbgLgnci9lhuvTnFe8nl79KQ
 zBt5GhMVg7FPQ7WmWk/lKAiKB+xlSiXZrhR23UeF3cieTbPdHiRxXLPPyGd9xLmpG3X1
 PmUx3j0YimIqMYaHbEo6BEcF/tS/rAC/u4L2dHPKmx8I2Go9qIFoU8EgbucYajAaCG++
 U6m8K7v0OBdKIU29GAd2M5fIDca92FElvf3FAlSLJ8b8SvgW1qfUWBEFeyrDBBm8hAKb
 IojistJbgmTPL2maOTfDIt2V5sTI4Ue4OuPPvstdtS4Sp0Pjr602LmlP3u9Q6kbr+s+S
 il1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rot1XpFGs0yBHt2Y2CsJDgtdlQ1QusiZBJQrjzhCByAmNuMKUybH+wVr3ER9mWu3AdpTgaiaaNztb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwAy0LsQ83bJS1s9m2/k4kXED5yQQKdb3v47xhIJW4tTsVVbt+
 wWZTerpouS2pCAF0n5bKtVhyQ2jF7DtCzvCAyXufsynRLAH1eZaC7zKEdttz8KmD8J9mjKJtovD
 ayE0bJyRxByRrrili5g==
X-Received: from edbev14.prod.google.com
 ([2002:a05:6402:540e:b0:699:e9c6:5556])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4015:b0:698:ad7f:9383 with SMTP id
 4fb4d7f45d1cf-69a85b93b10mr266244a12.14.1783342009416; 
 Mon, 06 Jul 2026 05:46:49 -0700 (PDT)
Date: Mon, 6 Jul 2026 12:46:48 +0000
In-Reply-To: <DJRGUGMD8CNG.8DWRHJ3PRH3Q@garyguo.net>
Mime-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <akuV_GRAM4QPqf-o@google.com>
 <DJRGUGMD8CNG.8DWRHJ3PRH3Q@garyguo.net>
Message-ID: <akujuAJOZxRJlQZo@google.com>
Subject: Re: [PATCH 0/4] rust: Add support for reserving of ranges of IDs
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Burak Emir <bqe@google.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
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

On Mon, Jul 06, 2026 at 12:53:24PM +0100, Gary Guo wrote:
> On Mon Jul 6, 2026 at 12:48 PM BST, Alice Ryhl wrote:
> > On Fri, Jul 03, 2026 at 07:16:03PM +0900, Eliot Courtney wrote:
> >> Add support for reserving of ranges of IDs, with a usage in nova-core
> >> for channel IDs. This entails adding the helpers+users of the C bitmap
> >> API for ranges of bits, then users of that in `IdPool`, and finally a
> >> user of `IdPool` in nova-core, `ChannelIdPool`.
> >
> > If you need ranges of IDs, perhaps you want the maple tree instead?
> >
> > Alice
> 
> Any reason that the current ID pool is implemented directly on top of bitmap
> rather than using IDA?

To some extent it's because that's how C Binder did it. Though I do also
think that the bitmap fits binder's needs pretty well. Almost no Binder
processes will have more than 8 handles in use, in which case the
BitmapVec is extremely efficient because no allocation or pointer
indirection is used. And the bitmap also performs well for the few
processes with many external handles.

But it could also use the xarray instead. Nothing stopping that.

Alice
