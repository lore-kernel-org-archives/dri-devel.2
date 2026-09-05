Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00266C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 19:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1711910E32F;
	Sat,  5 Sep 2026 19:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sxuMX6Dh";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AA410E32F
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 19:24:32 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff3936easo239595ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 12:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788636272; cv=none;
 d=google.com; s=arc-20260327;
 b=W3fR6i+EZhen93b6iYguygxk6fOGIwtMh8Kw7UxRQ4SzSZypzjajtAcpP2FBmH9fJd
 WDq/IQPivNGQ0kJTyPsEjMq4SdtkOCtNyBOsZOEO+nq5oarszmqIZGAPOInI+ZODd9Oc
 /jEaJX1Q/+/0OBtWdAVKmloTP5PPZ0edq4dWw36gN2VVjRKjIusJhZuuFcIA2ZJiRaeb
 0bm1dN/TwLOAYRbIEjC/YC5zlkgKmbH74YGoOTRD7/C5iSC45lgKHbXt5RvUL4V/WUkC
 4Jt0M/eb7pHWq5TWTkBmJvDkNLLOl+xznLYXGMgc4wYcKFrcKnkT4dR7SBux6cFiDgQc
 7WJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
 fh=PiAczvCEh5tFWTXYw0eDTlPLggEzm3znKSyFBY0GoNQ=;
 b=ejWRp+eUtHe19NoOFkFr7idJRC+jmX2MYvK4HrB4qlD9MuZGSOxKhUD7baGviQJ50h
 4ph2p4p3lfaG7bKLqQ7wkPcHGWgLbTdiUtP0U8EkIW+fldfGcbp9L6ULTUkiHZ9frM98
 vNcyjrHx20fyMHJTr9pPlUd3aU78sbOyPQZc4vqqLz3wLbfJJ9QSOpnzn/vkCwQgKulm
 48DcBRSfl4WCVBu8qEUDAd0Q+OUg0eZ4+vnxkMSoqWfVuqIPi2ElYSKz9s0KGO44gPeC
 7qGUR/ijmBqCYFT9zMLUM92kzzwLLuberlR5+XJ5guaCplpnHiUIKlvlcSrtfvGRmhkD
 Zn2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788636272; x=1789241072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
 b=sxuMX6DheeOBocCP9fZBhtXGd95KXsBXOdEjb1iSMJ4LeZDzuvdkwKfZQONgdN9dHe
 /lPwJSljfsjCh7Ar4KdJyZ8SlTKQ4/l6RLec+CFDN1DHRyZgBobXoOZM7/nlx5K7ehUd
 3hbz3falfdI1u2FNd5gIhcpfNbrh/5LzSRSWiegKhOMAA7D1EknLIkY+BMSrL/K9BcUM
 7mZwWDT8dpEDSjHsCUqlX9cB1P/Pjjijc/p9Ewxv4lL3XsBPCheP/O8kuparxux6plr+
 f+XbUEVLvh6H6p/CNjZwGHimifrDFlwMPdYSGWEYc0W1jtAh03wdFgqX5pH3nJ0Jiz3B
 GyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788636272; x=1789241072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qlpeqXScrDkE5nbP6tp8g5wa9e/y0HMZle6PR6w1uuw=;
 b=i097xCLWCZItMNTy3X5g7Itz2kzyOugbpuGuIanhPTABIxxuBfD9XeMg9X6TtG/E88
 DXSiMOhSZ7AMh1jMKeVjoYEkc6dcMl5FnJJU5b5hU0pOjb88mMAKX3aQtrVG7S3CvAE6
 3ACniwfpgNLPCtGpWw0fBDTUBqbFTS/SOTjsaV77rb6DJ669vxHT7KelpLwUsrlSd6pl
 juKYl5e6Hfweb0cZaAw0k/eI1Ix+7Z9HHaUw4TXK/xXtt16FMO/ZAim5yG4L/6UB1oGd
 mUJ0unG3qmfQW8LBotIrG6oELyxDMsjBcItrs+m2hT6d75DxYWoQ717V3ZHRJltZogBl
 Aelg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjrpxnP2XXKxuMcKEyxEFx7qCj0YQY3rBwEqkPDzIEeyyPt53tIAyAZeoipvW6OBRTeW9Bg0KfJoQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lFC/hOdKKPsN6ZXbmHx/I+vGieCfgzXWe5mTn5lWoyFQvOF0Mf
 z1Em8GROb1/TaE44CBecQ5RP/V+9YM2A4NCcTZVrEVcDTZpi20u8PtGanwEcf+nc+L2QYQMctDz
 ZPeNVBrWHzSjGAw9NNgqAGHAoZzTvG2iJiqo4
X-Gm-Gg: AYBFou3biBWMBDgSekEDAib6hbLe9cRlp2YHDfLJKU3dwRDSVkxCo5nIuHUpoQbp7jH
 hmOXT6N3kq6jMbRtlhVo1xci89xp/gx0DVfGMM4ET6n1/PM632ISpDDoI4QeMwOd9euAaGe81FI
 PrXQdzKOlHGKvkA36yyvH7CEJWQgx8jkwOrnvvR1IxYI3fv14gkc01aaAOyc6V0cfbKGoMKEVP4
 Q3wck0ccp/CevgH4XzRYCyAlyZbqWuN501vZhB5Lak5ph4F0+6sJ3ef6r9t6UyHmiEauhSrWQ2p
 m12IwI00sv/Y+T+76antjQHg0EuMnK8vgD+06gWoXJH67K3bWctUh+6MsyHORQal7FKz41zHpVN
 Kp0N8g+D+RKOeJJqTEkAINM5EfpGf/jU8ro1F5IbBT09oBjt46xUCx2W6AQcs
X-Received: by 2002:a17:902:ce90:b0:2ca:ecf6:9115 with SMTP id
 d9443c01a7336-2db2776adbbmr63554785ad.2.1788636272311; Sat, 05 Sep 2026
 12:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260903192248.2248560-1-dakr@kernel.org>
 <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
In-Reply-To: <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 21:24:19 +0200
X-Gm-Features: AcwNN1VrVIX1rn-ymHE6KZVlOZK2RCfm_y-i_dbObCbOpleHp8K2ryo0MaspaGI
Message-ID: <CANiq72m1ZxFtQjm4fUAt6Y1MFE=ww6jx+dEg3F4Bqbki=ndO=g@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
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

On Thu, Sep 3, 2026 at 9:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Miguel, Boqun: Please let me know if you are fine with the two
> rust/kernel/mem.rs patches.

I see you fixed a few nits -- I pointed a few others in a couple replies.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

It is nice to get a slice of the future of the standard library a bit soone=
r :)

Thanks!

Cheers,
Miguel
