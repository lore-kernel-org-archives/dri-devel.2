Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34B2C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0642810F23E;
	Thu, 13 Aug 2026 09:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hh3i3ief";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E9310F258
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:36:15 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cf110997efso5125405ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 02:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786613775; cv=none;
 d=google.com; s=arc-20260327;
 b=LOC2gXxW73etZjJOyZmhVntw4148sl5lr7tOQP0tRLfC0OK3aAhqkDDVBrbvQX5pKh
 32gspcI3pkWpC9f33+Uc+XUQL4oVNLtABZx5y42FHbtP+GGUz4GAQ1hAvGjm9WmvwsZv
 appOEq003MX405WOOlCGplWBW40beeYgxUgnGm53sZl24mJ/Kl0qlLcsgKwl9s9OOl7V
 OaQ68tg8RHb+ZqrVpzPahcxL4uL703ShQGmYnLAvEbRvZTQlBCe7pfMeHcRcHhUHAems
 hURIcthQWQY0uGDkL7VizRk0bySWRJIA0d6R/9LFLee+zfRbobmfYYwLr6TcCK6k0rzt
 xWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
 fh=MMJAtaVKgGzej2pJeDRtSabkD6Iy2WZ+urxptCNtvyc=;
 b=Uca/PxF1kNVuJ4hCdeY2vmCLzCN93p53llMpN+/vNn1qsOtF1wymMRBwhPgPXPNDtI
 3L2PnZqmSeSbeMBKTUelcKQtJKEL+JZYEydqK3SgWJLm0k9mH9t1diujdRCT4OfJTA/R
 fEqh+1MptOW4F9cUg9cVPn7wHBxCGInJHg1lQSqCpbr6eWV0vYCMHwJCDu8vsiwcnuMq
 gAWeOYSquZeNiuXZndnpdvhhhGiF4Qz1/Vxy73Vq58XJLvVeawjDGJ9S5zvvFMvVNM4f
 NjxCsgIQi05cKATpKou18XfTH5LW8iQiAGz+kSTy1+HbohNhitN3/KfT8Ty0lZ53HTBI
 pt8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786613775; x=1787218575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
 b=Hh3i3iefHEzl2Qg9qRKVMQJ/lgW7+RZ7cpX95zUjdQg7CQ1BPhyOff2+PF2wflLNhc
 as4Jztu5k+v7PHRiNomx8nwqwQ6cI9+JooJDu0rF7VzBNMR6/AIQq2ftbJQ2Ad/jNN2o
 99JdPMqf7S19x2RPQIzCRlWlYI8i+49XhFqVMkc3pdj4gsz/+dKgb+VPOnUgCqESWT7b
 Pd4z/e4MdTwCC8CdtHmNcAsEvM/8kv2183uB+WlhL6EBD8b4mYpyFVJeRdp6HEjOVFP2
 UsV9RhjxRzyvBznYDj2VG+z/bvrcC9kC46Lot0jE8zzf3AJlkOUB9ZFdqjEcjAT/ggTU
 TV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786613775; x=1787218575;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I9h0QULojzau7syX2ptB1YiILa8mj5wKL7cDn/JLX6g=;
 b=o+z2QazCQmvLI+IUTE3PY1tNMVCCFslKpcZIlyhZfLpWDV6khi2P/f5C/JylCa8ZiZ
 +27z6CYUi23Z2BgBTJplLBkeBDXV7BjWriL0daUc5TekKAURZneT036WgrhaEMEi2QNj
 zAr1SFr7hLClqJf8BQxY/plf+lTcX3G9HDC7BS6bYBS6TA5qUwH5UTgs1Exr+o4/PAdv
 JY8Pz8mZwpd+YRTA0mBGtyLgQsCWXbT2t59nixC4NwrHiFzQIekr6bx+rZDp3EeYSE1C
 WAEWDKffQ23nwCvXnL+LKNdmfN8PktWRrTiUEj5VGJeWnCKBbrqXJ6s+wGCqTi1jeZg+
 Vgjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RroGEhHUR8WyRboOATXnj+UPkcNjaTLZhj86UHQC8Ce0XKl45TooAPLXBXjS/8uISkmfe3a+Qj6gjA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGzPqOStniHS4vIGDIdY+9LDImRv5t1OQe79Zo0PGcRFs/hkBr
 egYDMeKl26PaRiYwNlJ+X94KCxHWj+CC0lvNg16oiK4vdO060b610Ck/3oLynL0e5WGPPZn50eZ
 Mmc4L9OlSTR/SJHYLk+BaQpcGCeXtisw=
X-Gm-Gg: AR+sD11STd1t0IqMNoooU6U3nV/6hGEzxgUdRbNUHmKMboIZvSZeKDnBkWGwvU7o/B/
 hF+JOTzB+dbM5tKwim2bUrfMoqExSa4e6X90Am2hJYqzDzkfk6EhVBJyhUN0zUPKKOuFptM2yq3
 eAsgaax3C/km6zpAagreOvyCYMJTZcavE39PrP6E/Qg7WnQFZ/vhPUaGyrKQh5SyBfckDIv9m3b
 AqZVonLTW2OXkKucuyhA2LmS0B4zqBXo3z4Fodufz1s0oNUlW6elLrue70W899nBmWg10QmauBm
 HybL5gL2fHdca+web82dS6KKCkKSX00rzl4OPdN8WVxRhITMy5zcMsWCIyVdWjRJ35045OrxxH2
 o1L3dmTe944oFh4PUCprnsvwUTQizU6wiHkbeCgeWGlMcRUSARuB4+tyZktoQnrXetFYhlj4=
X-Received: by 2002:a17:902:ea0b:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d389b9107fmr28401875ad.3.1786613775343; Thu, 13 Aug 2026
 02:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
 <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
 <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
In-Reply-To: <DKNAS52KYWLD.M15VEC6U0F6R@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Aug 2026 11:36:01 +0200
X-Gm-Features: AUfX_mydrO4nx0TADc_1KF-ELy8K1d4zi4yvOYINpS4bHvyjdnsvoZ1CepMueE4
Message-ID: <CANiq72nR3K9d0Y--FyUm1yAkww2LaAuYQZ3yHXjYxxfztgMMYw@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Wed, Aug 12, 2026 at 11:53=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> This series has a semantic conflict with both the driver-core and the drm=
-rust
> tree:
>
> @Mark: When you merge driver-core-next after rust-next (which I think is =
the
> case) then you need to include the diff in [1] into the merge.

Mark: in case it helps to make it clearer and so you don't have to
read much, that [1] diff still needs to be included (i.e. the rest of
the discussion and the commit I added is independent).

Thanks!

Cheers,
Miguel
