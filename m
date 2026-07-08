Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1B5C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDF410F0A6;
	Wed,  8 Jul 2026 10:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ub2g3+0O";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EEA10F0A6
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 10:34:20 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-ca5b707b78aso16474a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 03:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783506860; cv=none;
 d=google.com; s=arc-20260327;
 b=PKKu02Nj7WxN+2VZB+VWA8RGQ4xkkw4WmkZSU+magchYVtNE8Bb+d8U5wZxsUmTMlr
 e5A6YxRbzWgZiGVLfMU4JVZnvsBZcAp29gOQjW0UVBZaDxVwWURvdfghPIzZN3cC78on
 37e6Vvax5p5+T31yEp5y4KzgLgYXlyXS6NUWd3XCG1crmRu/db5fxivBZa7Xls6Pupwo
 eeXZ5umPjfKHIUf7XMQrpWbZMxt7HhXOmzbUgLxZ8DzkVVOigAFrVTqE9FI3FIkodvX/
 EMuSBs+CIKKqW0WsJeLmyGpnpTstasO3QgWIQtFASAQHekyAOhJRS78h23hHbtvwZuGw
 r9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
 fh=DDT+kwZhTNEmEVouehZWjMxFU9jR+Rjl9WQnJjMsJBc=;
 b=O+3JLuSFTkWNtOomXgGiDCwvSBBq+g3s+NNEj7SlDe8rcTlomjx+oQKu3788g+4nfA
 AN47potFu9NxzhjXWDTCOLaCT2+fGv0ZTLJSh3Qino6Gf/S3Uie2IyNeC+ptn04dBmLP
 ZSVnnJmi5cxWPE46yW3FgH8iscA4v6x9c/wh+cfZXNVdWYq2eRywvA/iB94DEV3amKJr
 tHUw+U51bZ6ey+FeaDqY3lMqAn1v1SbA4ODBXGY3A+tNoWJuAOJY95cauIXZld5YdsBX
 Ft4jryJ9uHC4ihEE6EykNMT21yQNGzgsI6wsO/FyJFcOWlqMjHs3+02Ex1RtPxL/quSS
 TvKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783506860; x=1784111660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
 b=Ub2g3+0OASN0UykjOOSzSA/OVTc+jP0XOl4gS5Dk9nkXH00IyiT3oSxhWzKpOMYjdc
 XeNr8tHQUNFAviSzfMZ5/u6eM5/D5aEkjqeFv05v7PSJjNx60dud+L5+8KaHz75zU8P5
 sbpMNoezpgfmlBcjdmuNx0zhf52P09ckAKl4+kaRmHkAzQ0mQjHx/5eXN/W+TL3Ax5Uz
 TKTR6i59do9joMR+5qGDYcCUDubaRx5Niu+T37nQq3BO57KngEYAT0dIiiP/S5ibh634
 5X7pO6LokwpUdEYfJSIo+A0oSwlQzFuUUGTgsNwY3IcI1ApJcAiVikb+dSxADse1sIsi
 PnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506860; x=1784111660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v1UpS+73rzKmbQDqdjKaD2WlfUfXQNd9Rp1m77QZLw4=;
 b=FxvFgzxV16AgwHnysVMGfmaPfudgWqKIV/EgqJprbd8iQphJ7KOkeH0LAcR2DMn5F+
 H6yEtEOFfc6geRgdhyBrIUW38wiE2HwqmZAnQNvyLytCZoPt/+vPveckQtEDP6A4Fdqm
 2AgKXPQI6LZcrvgE61soALn3JGtwKYuAqKde/lBPcCaN7Qu9UoTy5GAV+/0CvxKPrWgT
 2RC45k+/IEPLB0gZoI3PEFhpSWiRuBVAbipNIyqZPqFg9AUU6pTlE3T/YDhJSpFhLv/U
 ZEWr0VjLfBWi6xBQpP8Wq+6RP6XZ65gUhpHvJRi11mD7Cg4/5+pwU736VLvokywM+9Un
 vHgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvR8Iufw5yUa153lElFus6nkpc6y4PLAFZprqNTA7uHweu5jC6Cg7UX8XnKJ7WmdCtqZ8FoH0Ysuc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMTSM2JNi/mjWahU/9otefTM86Sz7I/fBYTxreqKcdkDKVewoQ
 oA+V/OvBYtCTybl2qf5rIsTl6HBwqJzqNnGs0PLps9z3pj0rCVlxnZCcxv2drdj64AGLxK1dF3c
 aiLwAxKnjtZM1Qt+Ff9TytzTk0vMGRPk=
X-Gm-Gg: AfdE7clTDkEKSVmCraxUsr1vr0VwOQF5Q2N2OaWs7stmRMnnjzY3hbV3d6WdeDc76JC
 nFC0OFV3GVV2F1BxEIA0/5vUBwsLLwEEx1ELTj2MYcoh18Y3RI9VYdY8ldxGPi4CZJEHH3e6hLk
 erLmqPXKUVPtnZd1Yqtp9aoblCrPZAlsCqS8JSpqrrFrxyI5JfaFsdxM+d00B89/0UiZU5D/cBt
 rD4H+OsPx9mJC7ZofdI4nwmDN73eEiYpQaclTTTSDvuZvyk9CmyRUHJs/Hhm1hKal6Nd+2qsGDC
 UJu4O/iUD2B1WQPzMvC9MaxqaHMOhBuVLYts+F94jEPXULDLYAHek5B97G1/chFeWas+560nU75
 5XcucDgVvpgiD
X-Received: by 2002:a17:90b:57cd:b0:381:2d9a:447b with SMTP id
 98e67ed59e1d1-389417e436cmr1662657a91.4.1783506859636; Wed, 08 Jul 2026
 03:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
 <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
 <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
In-Reply-To: <DJSLVGBW90CT.3W3FHC3J5NPMG@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 12:34:06 +0200
X-Gm-Features: AVVi8CerPf3D12GiMfvLd9xxakdPl4vxt6Mk91TDYQmPEW-zWuPFQaL-PCqilw4
Message-ID: <CANiq72=8V967CuH92AJBAob6YaygXtCYY1GAr=qGuF8JzQfZ3A@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 7, 2026 at 10:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> It does, but if the alignment is 8 then it breaks a lot of platform devic=
es. 4
> is the most common alignment needed so it is chosen. Different base types=
 can be
> added subsequently when needs arise.

Maybe a two-line comment/doc would be worth it?

Cheers,
Miguel
