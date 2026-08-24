Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CB6C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF7110E74F;
	Mon, 24 Aug 2026 11:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iu4p4JX0";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A4910E74F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d30c22b1eeso2420795ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
 d=google.com; s=arc-20260327;
 b=nbd5HYIM7si4kXgL8pudV4+OIU0ezCpNLXGBaARcTWT2a2K5agqKakJzXT9tT2l7Y9
 FrQOpvZQnxXpAwvfpE487HXCS9wsMlzKvjr9IePC172uLH8Cg9pgZabdt0G3k0m0iXV+
 D8lN8Y66UY+URQw5gAKDcryTzyGy0iJw8FdCdYFukSDs9WOQTNnVH/1e18vDGw6sGDae
 lkLpaqa8H2sWSYPg2NoeSuLQZSHjW9Lt5zo46G+6LraJvTgvwkgfg19Zs+uG4lsf3RCp
 ++0HlDe0O0ahZUVGxhRcSCFFqnsknv1fDwAYk9IX0dfTkkblwIXj7rXM7uENz/8iLEdE
 ZNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
 fh=T2Xzb2BgLhYdf8E12Q7Xz5duZLZWQIg88BqaLzF4ZzI=;
 b=OkSaaEMOrb0EsaBrMjQH/X+5pQ5qp7NU+fPYdkd/93/pS644XMTDHIB9Kps6r/wHMj
 3x233yQHKlumoLunaMMYMVWtRkQny/rzQr+TDtyY/npCaIIFppzTF+lmuTglTW2nFzSs
 sSdEx0iidHg8u4F2ndF0h3G99ziUfNwI2J75SU0uJRXkRsJfHK3tFvNmqSKs+r7S0XQj
 oEVIRj3YBBTiXiZJvTQQl792V/kRVXA7BfA5G3aMTjS/zN79O4c5la182gGm9pRdRbGE
 9UoZHOcqJItO1cyaIIT57O56CyFt9H9Zorp+G7aGuqZxxlIRNhe5tnhu6ZlNU9K8VSOs
 Y7Cg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
 b=iu4p4JX0+5ptgH0dcHLXYnzCcay5d8BLzVbM5FrleXszFIkq82CVXYGEfqAhvWi+Pv
 JX8Nc/kXhq0PxTwHc+NEQbcPJyEN1BMhQuiI/uH1p1QAZda3D4M2ZGdUSg7SZ/LdnRIR
 7cD5qmCj17DUUD1KMipwBjFoORVKA58wJxVnE1OyukL/zba2LT3CBnwDN7f8FwX1q246
 P9dyfDC3o7MFuWSd55R4K1/adLTRayNmJZCtstaFFIs8eF39d7/Goz5Fc8Mgmtb8SorI
 VagZv74WNfR8+eau9ak+4lmTptejCivnRPwQIaeOpAhVLVhyG90HbNEOdn4Uyg2XZp5t
 E6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787571396; x=1788176196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
 b=r/ZVQHVuPNI7Vw3CUWazrImjefiHpWrXwtckVx+On0IWhBL2Gk/rapdcvKiNMwBiO3
 b2v1pPGrU3uQvFMHnC7LOLjOL8GDIoSU43XVWuIkCVz6ESutpijdgiHR86ZtbOEO+t8V
 BnfDcyW458uViLpD3KG6sgLoTSpIaWP8aIS4S2haGoIZZvWtHWWrg1QtQxdN6heEPWbI
 rvdbXrWR1RKfIknKny0uwlLrTZdVKLJiTa0GHLjRmN5FrSp2Vs+txCEKIo3z0cLrfbBb
 Pfvtz+jwhkTvl+CiB2CLhfqHy60sU6hJ0u6Hc8XFhMk1z49/WwDPo/9n+iCp4coIgU0n
 pOgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RosYlGMK4V0btM3zQFtYxJfoQ0Firj0oZRvudxegI9h21ZgPIAkgYqIp5mt75C27NekLn1D87NO6IY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nA8dKNl0aR2Lc/xTtK/Uri7QNVZ6i8eLitrSwQU4n4HpJfG4X+
 GRJ89IN3nnZxFdE4XSWx6o209aE/Jesj4gyjnsXIZZ9GB2lE3QHdfolz3c/eUm4dersa98QemFx
 gk6HxSFUmCyYu5pJB/uMGfBYyQ8XoEVg=
X-Gm-Gg: AR+sD10yBFEFj88RV1eQRLMXXHQ1TUCKF6eVz7w+G+LUaTcFy1ll93rN1ZqNf5xuZB4
 LnIwpk103veEQFm76gHphROtwgOKV/Hq0IT+GoxGkSLCc1N2DKaNQsQYklPuCt6QlCYyXTng/od
 7isJZ/nj9td2F/Q1lNtWUzG6HTcCP9X27Omfzekv6p7jQzkWGC0cmXuhotAoIgkmSUu5S6u7hmH
 cFj3/mu1zGUJx1zyWiBnOLdbgH/HTWw/pJ3ImkqI8XgYvHv27XZ8EVxRV+l+OlMmepFPWrwLQXm
 o30lLoyzX4CwmxsR9/ENWQjw5e+lqqL174I4ocz5ztTl9AX8THCNWowDsEcX/hThn7wp3gpecM7
 lrD17jdQNYeUTv9ASDGR+ihZJ1OtK8Y3nriTzsw2Fi2gpBPLT/M9pM/J0TOQtCeKg22ePM14=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef`
 example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Oliver Mangold <oliver.mangold@pm.me>
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

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel
