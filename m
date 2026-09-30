Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95430CA5FBA
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B9C10F2F5;
	Wed, 30 Sep 2026 11:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n6/MbUGl";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD7010F2F5
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:23:03 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-343bdca7590so209179eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:23:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790767382; cv=none;
 d=google.com; s=arc-20260327;
 b=o4L8GOO49cT+64b3oUP5arvxB6zFEq1ueDInl38rDMf/6wVba00YiEbF8sfuPOsJct
 CWlo80xdxDx3clmzsJ9QD87OCvio6fyCMT8NoWgIKGtHoXqtehkv1AQzHwaSXYjo5gaQ
 NYsG9QXXXsyoD00hPshwqCy2Wi0bbiQEAYx39x3Ayq27m6RSDJlSVoGTEoUy7nhQck5Z
 7S3fDhfrsEOeVhgRHlve/iWaLl0krDVshsrjoTI+io6kt45V7mbkrs5apZDimmbJbR31
 2WznnJUw0uM9Bg4WApvfrytKeUEpt3gMnsLeNmtSjTLy0ZlN5Yu2KZ0/AGIJaAOKXCqN
 gyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q967mc0EqT+NcQxMSEBQMD45Gc4hGwPZY4Sm4dYQidk=;
 fh=uq1lP4Xwf3I1+/w8F0b4m7iWFVPFF1gMgPK1L2xmuxo=;
 b=SlKHkkWozd720W4XqvkmGpV7aKw8DYTAMxpqrC1coIRnovayF6xBesrFBF2Pt+aUMG
 GbQTEhr9Vhpx7PeR+Mk0b6mbxmSx4rodeOwAzgPu4cnjC3peC261FF9lHDxdX5ABADaR
 RGFSXt098+83vrNG2jJjDjkjr+q1KMzptAqugLG/VNdaZbIfPV3JwvZ6jVNbOX81b9Az
 0XdWRLuxeSTNwlZDCuvIux7zQq0pEaXEVqSwZOKrQupdgzGqJgm1791L7+sRRswa3/E2
 GztsPmNUyv97qOd6ST9tC81KaGlZgK2qL9Dy9e7VO5eqWX6oLkMoL+5SOU0pwmhmRyiY
 FHmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790767382; x=1791372182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q967mc0EqT+NcQxMSEBQMD45Gc4hGwPZY4Sm4dYQidk=;
 b=n6/MbUGllnUq80rjvJcuBxqB/aru7KCJq18y1TJ5cMzv0PanZl5WJxBAgew2Qm4zxm
 i9TTy0KV7xgT2J8RmmQd1AC4XlatGayeiaD0k9ykDFjQZX2li3mnkLdNPC3U+II0o53R
 7cNvqDXO4//f8MGylOoc+FleNc0YbO5OlEIXbUFKA4VfO3i4YLO16LOj5M87qMHDQJX0
 UO8s7Kk8x47Bgqy+UUS2BJUxiijaXoj6bFt8UR4i9oM6h3Pchc+gW2bmiJfB4j84ax7t
 oGERHb8pFXPVfxMGHMwnBF53+zVIAmRWzt8xUj7cjSOOlH2DJ8Ch8gPxSgTPFcbk/J2P
 ZZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790767382; x=1791372182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q967mc0EqT+NcQxMSEBQMD45Gc4hGwPZY4Sm4dYQidk=;
 b=wAdjoXM5fN17xAYPVJ/PCas/4YCdm3D+HV40Cp1sqOPjYxMrq/AJvbtUIM4UDnvVIf
 cht2N/Qln6O7QnpI4/d2raDJk+4AlSwm+mztw95Go+dZNBwl/2DQ3+GZV+s6qhLHCIxh
 k+kq7UXK2h33iHyH7v+R9EryB216W230KaRO+JGn6pKffolLxhJzC9lJ/um23uHrn7kP
 1DabTov+hZT8yP0ktMqZq6qUZQbAa8s2Dve1NeZhjC2NUqzYa6h21ilU0Z1HD4Gc4b93
 gji8THKh4/K11SocIEUSSxAF4ERtjmFuE5WUG6UxAu3u+6kO7GpTSQMxZ0WkZodiLS8G
 mJ4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+AC5vye6F3zRtoBRZnhGR46jZlG65nbQgM+5EY7G/E29zPij2cnqZU6SFA4j+OzGq7lIbBu8HXcY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKeDJXayfciEOUeDP9Z6cV6JnQyny0CgnqTVUlXPB2MYSC7FkG+
 sd2lGV8p8RSIOQJaO79cVi/WOD+23CuJZTCNgvfXv8qonh1k/U8kzxQ0Y4ETEGn+8p2QvNpm6Nf
 OEJuFPFxUabN9vm25crkwWkO7hmoU1tU=
X-Gm-Gg: AYBFou2hEAS44C5Kbo1pT1sUsGIKEIt2ZbKbqHqYamuqmksAMCSijp24VMqKc++1UeO
 SUha2khlaUtZ1Iv5IkPJzJXkJFw5jaIbZd6nK6/UXJvmv22NJLehRN79TvURqKQkR+QGCJUGbcy
 Td6KLmahVV3P7CFjqD7OJAnVUh3YXTVP0q7/JSH8ANEuXzhXn2z3CferbMu+MfvrhGPxJQzudnB
 uEHadye+yemJUylh+pD3uKkju6PFtkbV3cns0fJSxgFT1Ndulnq4F4ib4okBenR6zfN4zYUPiFB
 zOiu7a4YogPloJ4GykOv/GhHTOO4Wm+KVOEj5hbuzBDS+4VWhbduINFuWDbtFkwt4QRrgshFK2E
 4KGMGh0W9V3xge0ekyENP5umyYMcY2fub8G4X9D1CvJVGXtsD7azuCFetRaefpdWRPWZIb8PUSv
 +ZB8T42TIQ0ZKAVPI5B6ufF51cdoNnk5R6ESrJVpiR0K7RD85bJgk=
X-Received: by 2002:a05:693c:8085:b0:34c:f181:85e4 with SMTP id
 5a478bee46e88-34cf1818b1fmr2066899eec.1.1790767382465; Wed, 30 Sep 2026
 04:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-3-0d6cca376cff@nvidia.com>
 <CANiq72kcqVfvVj_b7KTHKrCDj63LMKpsfP30zafoYB8c924i2Q@mail.gmail.com>
 <DLSLNL9HDUKM.HN7Z0MACZZSB@nvidia.com>
In-Reply-To: <DLSLNL9HDUKM.HN7Z0MACZZSB@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 13:22:49 +0200
X-Gm-Features: AclHuK_tZvjMuy0Rny6WfvK_GwQlWAvr20_A4Fja8oGIX-etyz8meHHBtoM6IgM
Message-ID: <CANiq72n5jjW8U9VkYJZYFpL9Z5rPe=nRfs3DqmUdfxCW39oMgQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] rust: sizes: add sub-1K size constants
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Wed, Sep 30, 2026 at 1:04=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> I am considering picking the series through DRM, but it also has a
> dependency on the `cv!` macro [1].
>
> Is this ok if we take the patch introducing `cv!` through DRM as well?
>
> [1] https://lore.kernel.org/all/20260917-cv-v4-1-547ef5727451@nvidia.com/

I asked Gary yesterday if there was any more recent discussion on the
tag thing from v3. Does anyone want to do some cleanups this cycle
through rust-next with `cv!`?

Cheers,
Miguel
