Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B81BC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50AE510EF57;
	Thu, 27 Aug 2026 09:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eMvUWjFs";
	dkim-atps=neutral
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D253210EF45
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:32:32 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482a2d55c4eso989348f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787823151; x=1788427951;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EOVo/FTydc/3lTq5xwei4nbCv9MVREwBkwBRQhpC8zc=;
 b=eMvUWjFsAkuVlTJxVHYAY8kkKDPgIHB6f2g3JWGToly5qjG/1XfEF+19ZY+CogkNH5
 aHJVaQVP3d0kuhpi7tz/1RuVqKMgmXd2MxO61aTq+kIkFk58pFTL3dmxdvXQjcZ/lBYs
 aU9FurgM/JeI9loQL1S+Ibz7kFyU37aVnDMHa0A16kRMEH3SVX4a8Suxg1z3RjhOd5zF
 IIo2X3REh/2wJ6+oNlZ25OW9SCfnLcCfQfoDn4VYE/k2DmCr2rt+LQRI2uhqSE7uMnvO
 ivXOkknmuFXRoUZkvNIp3iFhrZ3TgZSFbPFQ8U878hwbS1H4RC4CHRkYCv0P1tSy0SGD
 jflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787823151; x=1788427951;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EOVo/FTydc/3lTq5xwei4nbCv9MVREwBkwBRQhpC8zc=;
 b=A4am0HqNaHjiyHdv49+zIoJ0ECMezYjcxJi7W4qCFHw+fE5k4aDsw41dGaf9fYBlrM
 x9y1D2FTe7MTwtgVmKjiRLszzpIM70IaL+fIxZJFq+P7UCjCyA1CnPnvkr84fLlXRdcv
 uKm7ysb5Alyy+5Jp7HHvGkzLZ3UslJ4w5b4BzWIn22bCbjC0g08+ECLi5aYtSiKrOTOB
 s6KcT+AKbRxcJ72oL+wQFSd31KAvsrE9ALY09BT/mOT0vkaMJRtvwJr10vBoCqp1npnr
 RwzZ73pOzSuDhKEQaQ16lIzarcsr5js2KxUg0hLZMbwQdAwxo/Rhj7CmNDnJcKGKcnfg
 bc0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMHSK1ZdztuaVEMGFL8BNf34QrX7EdqLZyMJ+7vSO114jLFYUlNRW6RiRgeV+Um4841lRK7ZMS7B8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++loasEeU6PwU4ckuU58WyVIXAEqFNnMvL0E6puyAKjvtglCeZ+v
 3tYaHLgQp+YR7JohdAqahgoaW4TpbEItKJySwjfCDGU/+2I76yN+tijzmen5fPvR3IEzJLAunlc
 ICULthNaYekVp106I9A==
X-Received: from wrck21.prod.google.com ([2002:a5d:5255:0:b0:47f:6d55:abcd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41fd:b0:47f:95e8:2ebf with SMTP id
 ffacd0b85a97d-482e26f8466mr17865060f8f.12.1787823150366; 
 Thu, 27 Aug 2026 02:32:30 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:32:27 +0000
In-Reply-To: <20260827-chid-v8-3-bc74c77d0214@nvidia.com>
Mime-Version: 1.0
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com>
Message-ID: <apAEK9CUZICDTL1i@google.com>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
> Currently, using NonZero/Bounded constants is quite verbose. It's
> unfortunate because it disincentivizes using it in interface boundaries.
> Introduce a macro to make it nicer to use. The macro `cv!` (for constant
> value) takes a const integer expression and widens it to i128 (at build
> time only) before passing it as a const generic value to a new trait
> function `FromConst::from_const`. The trait is implemented by NonZero,
> Bounded, and Alignment and lets values of each be constructed from
> constants without a verbose turbofish syntax. For example,
> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

This doesn't work in const context, so I don't think this is a great
strategy.

I would want to use it for cases like this:

drivers/android/binder/netlink.rs
        const BINDER_CMD_REPORT: u8 = kernel::uapi::BINDER_CMD_REPORT as u8;
        const BINDER_A_REPORT_ERROR: c_int = kernel::uapi::BINDER_A_REPORT_ERROR as c_int;
        const BINDER_A_REPORT_CONTEXT: c_int = kernel::uapi::BINDER_A_REPORT_CONTEXT as c_int;
        const BINDER_A_REPORT_FROM_PID: c_int = kernel::uapi::BINDER_A_REPORT_FROM_PID as c_int;
        const BINDER_A_REPORT_FROM_TID: c_int = kernel::uapi::BINDER_A_REPORT_FROM_TID as c_int;
        const BINDER_A_REPORT_TO_PID: c_int = kernel::uapi::BINDER_A_REPORT_TO_PID as c_int;
        const BINDER_A_REPORT_TO_TID: c_int = kernel::uapi::BINDER_A_REPORT_TO_TID as c_int;
        const BINDER_A_REPORT_IS_REPLY: c_int = kernel::uapi::BINDER_A_REPORT_IS_REPLY as c_int;
        const BINDER_A_REPORT_FLAGS: c_int = kernel::uapi::BINDER_A_REPORT_FLAGS as c_int;
        const BINDER_A_REPORT_CODE: c_int = kernel::uapi::BINDER_A_REPORT_CODE as c_int;
        const BINDER_A_REPORT_DATA_SIZE: c_int = kernel::uapi::BINDER_A_REPORT_DATA_SIZE as c_int;

Alice
