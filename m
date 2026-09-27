Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2587EC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D68A10E3C7;
	Sun, 27 Sep 2026 10:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IwnAw0HJ";
	dkim-atps=neutral
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com
 [74.125.229.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB1210E3C7
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 10:32:16 +0000 (UTC)
Received: by mail-dy2-f41.google.com with SMTP id
 5a478bee46e88-344213c95bdso24013eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 03:32:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790505136; cv=none;
 d=google.com; s=arc-20260327;
 b=eoZ5BWCtFP60gA6fcat6Yq8r1T/EmOosapKSkdKlw35ssAFAQXAjZRk9BM99jCujqj
 UKLzV8jds8CCWXCvzWOD8GokwjWFkaHr0j8w+ivfAxDInXwLkeQDwNshkHVTA5c3Y2KA
 hvOYTDMkgDK3uxNMkLyCUXzDCaIEeWWZ/C63ysqyCTq0lkQTtZVt9Rl3Tab2oBdgGiC+
 gsPe7iy8HNKWijs+DUSNGdwfk1KHyoEjoW/sleY/6lMxJ3RK5Ht/oo+DqIvnd1NTK6lY
 2lDOQwlyHTUtuYBvq2cCyUU+ZMTuFoSD9nrWWzUpD41rFOwAk5lx3K4xLSa0xDKetrBf
 OHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T0IBN3YB7gkpyxIrrQJOq1rE0sGtI266Z+5OM5H2e1o=;
 fh=sc5OLAf7lmz4gVYi/5UE/2bmFCCMlD5B+F3uUQ+4pjg=;
 b=LXbgCH159/OsSaEEeWlwDaojPBYm1g0l1EE9Wb3AVwZUzU1a/rnvclAGdnZEBrPLj8
 iprHEm4MJQFq0vt1hBo/MJzj+JnurPOy+21ytPYfsttzUlWcGSX7TKABRkLhxw8y80cz
 WPSCXebGS65RjETGDOX6v4pC+RITIIi28feJDBSJcu8EQn1F/3XDVHx1uH5kXmUIoz4G
 vzxjrPfwon/HMfk5nsoL14+3h16A3iD83mFAYzzlxXVk6Up8rTeYjWJdAR5idKe/Kd8t
 QLdYc9+lTa0tN0USSTvS+iZsqG102vhUPaCRdhmKWuQGvO+v9Lig72R7XUQ4qV+yCCMQ
 Xt0Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790505136; x=1791109936; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T0IBN3YB7gkpyxIrrQJOq1rE0sGtI266Z+5OM5H2e1o=;
 b=IwnAw0HJXkQYHbkwqHytTzI0fGspEqqLzJ/JLGFYIr7sKVEXYsbvls/H4CjtiFTNcW
 EktFBRDJocwCh8AOatLIrAmHsNmffmg9x6/qUUnDJmf4EOkFLwVs4yM+XA/hBXEdEv4X
 ML4ViNC1/o21tZ+VteKBKylbAubXl+E53hSCbt+rh07zqqdpBNkC8JdgHy6RHYYZ+jcG
 EH0xSAEQSFyB/5CUX1PYPsaJhNSxARhT7zhCfDY4uvR/wudGrfjh99YF4s5Yfhvymjpe
 oGMPpjXj1IGZEvEVB3FCqaDG6RfGz83EuJZFaaH4dPBKUwNQn+yNjuKhFVO5IT63LuiC
 TZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790505136; x=1791109936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T0IBN3YB7gkpyxIrrQJOq1rE0sGtI266Z+5OM5H2e1o=;
 b=QhXS5rpkI0m4yKqkxT+07UnE0LkePj8EBZyDxFmXN/5AU7oVK/BOFggxA+oSqQcle7
 lnMDq7lbBL/1MwgUgLMibYgydI8PaVse8o8nFSfCzjDrle2CJ1ny+t/EYE88jwvPuw6w
 lawAIGFLqgQ9AWQs9tXaYQDwpoRnhnL1NZSFzPWCMig6m70kExlKIMMvkTA41SqCm9pG
 pIGEu9cWzLNn+3nrsknIcP5OS/U4/ImVAMs11gHVix8E2IxsdLhq13WLIrf3bkwKz+il
 tr8/ZoLnmpHmC7zSrU4z+hxhxOMYzGHUuPFmSe4qRvyB3U8cbhYGco182xbJqDos3aad
 hrcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmTzFG5TAy06vmwuQDMaq51OCb85vdFJdPZppZVb/IPys4+O6w5NeHNoss4/2Qr4YTqraypdwiolU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIy9iDnC+1A0aPzDzglVOeVnhkkVgj0ymr58l2CdYMKaPdtiwsq
 LO/CwXVZ8KxImO5Fnl5HGFaIUevY2qlr4ozryXWOOmq50J0PIEIFRbdldpTmy1Kg+rcVyVjrxvL
 I5wEV7Fdi+Ao8QOb1JLh0xM2CTpr8whU=
X-Gm-Gg: AYBFou3yHqTzPG+qjC7tWsnnBYPDVwmq61elx4/sXeltltRLecJL4meC+MGcyLdw21T
 ys+Kq5UCfDAtA9NyB/aSOWxTYwfWwcbbZ/sGUol0iALEcYRu1n0IjP+cTU1YHNfswuRIJhlWIpQ
 WXdpxLkid9WOUIpN5AaMIQyUZ2g2VgEWmmTsAsGvgSLWwQz/aG1r2pWEnQwjYdev38fstgxZU5E
 c5oLNf3IoRDCDQ03FkQouRmkZt16XdxyW56PdpY08TSMYqRcv17rbrriJKyCiy+gEpUHTCym1zc
 00c36IlYL5NwbvyCPTBc3etIW3ISAI+fRGnqa5qeUHPAY9tFbCgCKEDozqibPK9N5YaKWa/GtHf
 ZmlBpoTArtJX2/FsQema2U5O0pOxnJe0K7vnsvtkSoczZOKCcefuSJ/XGvH/Fk7cY/B0SZXQ0CQ
 JCqODgFL8LhARFGC8SWVwk3P24NO6ASFveKJLtsvcuWlKoa10vQiDTPU1aZl0DXHmvQqxlVFsJ
X-Received: by 2002:a05:7301:dd97:b0:33e:6a79:5a81 with SMTP id
 5a478bee46e88-3427179721dmr8395927eec.1.1790505136091; Sun, 27 Sep 2026
 03:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260909064506.910162-7-apopple@nvidia.com>
In-Reply-To: <20260909064506.910162-7-apopple@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 27 Sep 2026 12:32:02 +0200
X-Gm-Features: AclHuK8iLs1xJry90CQ3QvtDKTbcAUCAThEBu2i1dWjYp5xrWZkI9Bh3mU59r6M
Message-ID: <CANiq72nFAbA_uEuUfWvdeMQeYJ+uMcAn7z-FWcQOPUcbX9CkZA@mail.gmail.com>
Subject: Re: [PATCH v6 06/13] rust: uaccess: add
 UserSliceWriter::write_truncated()
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Wed, Sep 9, 2026 at 8:52=E2=80=AFAM Alistair Popple <apopple@nvidia.com>=
 wrote:
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Nit: if the suggestion happened in public, then a Link tag after it
would be nice.

> +    pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<u=
size> {
> +        let len =3D self.length.min(size_of::<T>());
> +        self.write_slice(&value.as_bytes()[..len])?;
> +        Ok(len)
> +    }

This could reuse `write_slice_partial()`, though it would need
`#[inline]` to make it generate the same code (but we may want to do
that anyway).

Thanks!

Cheers,
Miguel
