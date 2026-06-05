Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11098CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6765E11A5F2;
	Fri,  5 Jun 2026 08:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VPTREzGE";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C35411A5F2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:48:27 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30741f821cfso197455eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 01:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780649306; cv=none;
 d=google.com; s=arc-20240605;
 b=lZMbEf1cluLPb1Ng20SeRqKlhqYhU8wpr0UmRS2nsSzwqWEZk86Vb1anYostFX2UeS
 6EgnA2MJljlbi6c4eA5n8YmgbRfT3V4thHjX2CObvXUmDDWs5S5nYBEuUGgrBQiflD9K
 rpkniyWYzR33KvHUd4O2Eo3AIt4KNes0LIbO8O7mVR/NaJ2t6Vk3n3bdlH6lOhu2Lmp1
 gzYmkzCc4Hc0f5N9BLXREOdjvkwJTFCDd+80RG2YA/XLmwZG8LfXpe9QlcpGeBCkWC8e
 xTkehJL5vkL/HC6xhBwUd1O184IPvlZdx2ZXygT/S3l38N9NHZqVlQ93XVlGOIpaMAOA
 BW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t30JAFeGxUhlx2yZbt8/VaZkSxhoi+xRWFYAKjEhn+g=;
 fh=f+vvE7qisNl0R7j4oD1S3IkoHF3IaRjl490FpTrOiow=;
 b=awiChZmrhpNtmwozO3HtR5AILROTLyh9oaRxP60vOcYrk7ZQr0qBESYhJeTJAKS03f
 l5oS/klQMFubVu47P/TiHwO1mvUqaBwd85lS9C/ZCkHpvXLn8k1vTqZIA4PCtk9ycUZs
 xu8gIKdwwXxeV6q7CaGcxuuL4NWAuFZp3ppjPI8SGp35/VMjm96LCdhs0ynMWL9O7sEo
 4UXODsSVAH6MRZXC0QXmuaG2pYrUEp9paWYbf9wqutF/aZ903yNrXncQY1ulXZahPgAy
 ZfhYXxB8FSlXi0cSpwgsatgEHmHZb8ZyE0XONF3OU2shWb0/Zgl9nE0g7UYyRcvO1Up7
 HIEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780649306; x=1781254106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t30JAFeGxUhlx2yZbt8/VaZkSxhoi+xRWFYAKjEhn+g=;
 b=VPTREzGE+Dm5SE1Z7qoqVTW0osJZjxwZ/UAlVDL3+iZjJnZb5OQ5Gia2JHlkNEytnC
 lWFVR+ueCGR+D0qRE9vnZ2UwUQDOzqaiuKozymH8+zP/7nvR1FhiStnFBjJj9cvzuNgO
 8Yb1cq28WOj/DwqgLHqf4vNXYE9kH37rs52UjtR0/zHYgJLFRQLJb1n5NElxMapu9Snj
 g215FWLayzb4mS2tKkZ9jv3JGAaKLlQRPyXyOJojp+LDn4+PiGHH62zGp5TJZKwZQ0gg
 P+CP93yY6poGjSRkJw4ZvOWTXaCNTaP755eeoCbY1rIV/57PqlekoJUjnuIlWs4Klb+/
 1eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780649306; x=1781254106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t30JAFeGxUhlx2yZbt8/VaZkSxhoi+xRWFYAKjEhn+g=;
 b=OiDE+r0FZna9olnKwulbNdPL8iWYbcGWNL6uLveSwta5se3Q1pEg44j8z3XF7gc80C
 qeWkxmNfhsCvoxIhn82/2Z+69Jio8x2VzSgQE7u06bwnVqwGgqyeMKTobKj4T/4wc6Sl
 yLrmmvc8QqJEVfI6oayk/hTrm+2nRfTXMIrQh7iTczLDKNxlnjOb5+VefcpvKiPzwP2O
 s+afKKhj13DB0ZpGIlg9xckM2oFSI+Wm6dSR67KJ/OfAfDZmD/hDtmZb1HH9gXOSWMGA
 jfvWBXW8UeJZKWPiDDTbU+6rcu8/KtJYFC7NiRULDXL9qOcLZkAQRmMoEUZpypBbxVWe
 6oKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cDyoeudkmGFxnHgPg7zDk/6VS/ZHlHPW3ZruFUJaNaK7oESb2kVyYwoeLi/A1aoYhQ7bCDojO+OU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/XqrzgGRHL6Ye7fiv4K0qI4CsTvOF1ei2BX6K5uI5brryTRsE
 5mMpH6oTO7akiDMYPPlGJZpulGdtBhA2qA+klakolVDFK6nM6zh9/hsF6EovOw5HCyHq3VZxkuZ
 plNa9IK+/Q2s1ecGnRUYm47aFYn3Ou1E=
X-Gm-Gg: Acq92OHsT9zjY/l+7IKQSLtKr7smgjxdB6mD97D1qMUXWj1UPShLsE8xOmue/rod6gB
 11k3v/okvczlXkBoad2P/Tz8T5OPSFBZvWeP2XpDLl6jFeWGG2jiIqO6mIfDfBP18D1QtjeK5+j
 Xb0Z/OfsnKL+4wOiONrW1vRAwFKv18bDrBJC0eiBhUM38Ux7v5DcgL3/JX5FGMs10X9sS5g4fVX
 OBRqwwteqP4JlbeLoBp7IV/hLrmYb90selDJ4CtneffgQFj0198FV0fTT/Bjp5w9qqRdpZaWov2
 z30k9KLGrV4yN0AH8IGpEo5fiHUKMOM3Ntbbm2OpySLTqVHNs61oeSg9/8x9Xmoyj4eipk1u/Nv
 Hr39Q92cqTXZgdFfH91TnPu1qp/eZSGaD9Q==
X-Received: by 2002:a05:7301:1e4a:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-3077b3668c1mr552123eec.3.1780649306414; Fri, 05 Jun 2026
 01:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
In-Reply-To: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 10:48:12 +0200
X-Gm-Features: AVVi8Cc74TRwhc7yjE46MLUkC2_0K6dWthB_1BctPYhz93WSvkLnW5tntk2yBNE
Message-ID: <CANiq72m54FU+zqhhGCXC_v2TyBA2LjpgHbU_J=AFfpWZLM_6_w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] gpu: drm: nova: enable calling into nova-core
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Fri, Jun 5, 2026 at 10:32=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> This series is based on `drm-rust-next`. The current revision includes
> the feedback received on v3. In particular, moving everything to
> `drivers/gpu/Makefile` simplifies things considerably, and I have tried
> to align more with what is done in `rust/Makefile`.

Thanks for reworking it!

It looks indeed way simpler, and is pretty much what tried when we
discussed this a few months ago (well, speaking from memory), so I am
glad it works for you.

And now that it is also closer to `rust/Makefile`, it will be easier to rep=
lace.

So thanks again :)

Cheers,
Miguel
