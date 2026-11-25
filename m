Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF3F606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XTkkioz9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1790010F9ED;
	Wed, 25 Nov 2026 08:41:22 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB5A10E1D2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:57:59 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8b4fb5d96b3so84074097b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:57:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593478; cv=none;
 d=google.com; s=arc-20260327;
 b=iiidcfmrcvwmbwJROuuMSD6uc8ZTL7UyelKva3xewJ56JsA8u5gcOYL/y/wAsdPz4R
 KJgD3RAG4f53z2Y3XvJmq4zaeHP1vKLFnNrjxFUvZqs7gaeb4rEzyWpHo6Ubm2BDzxfA
 SujdbbY4Z6W7gZdvcnO9p4T+GirLdlSW7sMF+kxrBa0DUPRUo8mngYAN97PB+YMOEzKE
 Iqf65DfFRjGlioyD4ZX1V/4IRjjkM2yRp6cju+2cF419TAQH8o1zVN7aWhRESHS30xy+
 xBW/I3H3hLg2sjymTVY/a7k54rxKsS2xCS9my2tbdFqcTbREgtGpRxt/I4VYckgqzpbz
 iB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:mime-version:dkim-signature;
 bh=ul5eVM6to8I5k6j4gyfBybKY8kBadnDIJAoBs2N8ESE=;
 fh=lQro894kaBLANWM0Xk4+Nq/EEbjt576oYZlg9yDXW1c=;
 b=jAiqoXNNRSBNlHr1YGr8YgijPM0ibLjKfLyViMIr7LWwpBYgEp8Y7Y2tQdZBl4BdLu
 YU1Oi5aj2tRkqokgl2V3VF66kKoJbIUxdAuApQG7W94xp+16Ycwnr3GzS87NZcPQElUY
 2VKDbeQaBqfxRK4s4or9QyVfgWbRQ+GgyP1yDlOudW6hHjhSW3Hm0hvptc8i0jyCYCVZ
 wZZnz6wKk4AmsTvkAmN/xgwLPljhViKsqi3AkM/iIspHIofjqRAKMJwDRdOB8x4Yu84O
 FeWb3guKJWjEOstnYvV1BUcsTreFBVGarR3pVcn2XVhBho1APJsQW536dVd7Rf/OTeYo
 1ckw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795593478; x=1796198278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:references:in-reply-to:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ul5eVM6to8I5k6j4gyfBybKY8kBadnDIJAoBs2N8ESE=;
 b=XTkkioz9AiLJIFgNpV1D1WDPyCO0imPyJcsM8jK+JhMXw22lT58N58Kyq5OTy3hw4x
 Y4TOn3NK6jXiFv0shfdZPI82VuKAXwvAdm0k6j5QJDRJEOJEYerAUb5M3EnqZDsu2Lhr
 /W0Mnfpj4PgXfOShgJ9geZXvrWoV8Km5HHnbvruDvwsAVzwwCbgxzYg+T/r4byyiZdCV
 TSdk97mQrY6Y65fNeJ4akkBJFj+0Un6a5k5TOlDpiExMmoHW0NXJvt3tu42ihaMbagPs
 6keUwXl/Wr40Dv0vmm+SAbgPoOY8T1hXtD6CdBI1BNsUhQFgR8LW/on2cd6NfEHE87LJ
 8x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795593478; x=1796198278;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:references:in-reply-to:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ul5eVM6to8I5k6j4gyfBybKY8kBadnDIJAoBs2N8ESE=;
 b=u3EyhDDDQbUzbP0FpP3GJo2hnTR/Vr9Lyxn/IXYZVcMzoppQoC+AMS96XAgThxV9yA
 /RuuS5x2QmfnkmjlU5pKzH+lQARfBe7BTFifLGb0wUy6UHfcLpsXLoSZ9w2USwVpzZA1
 lJHqLoJufp8L7OpXnDXo942hshblwox+3RlhbfiwClLYWHeVnWx60nacdatnGFD6QL13
 KqA4jzv3H9+jahomnosZEqfT7THI15Jqb0LZuzEHaaQC6XaIdQm3/EAoI0nV3VVUY+8K
 Zmkgc7Ak16WpjNfZPbybbbDzaZCAMHHKAzaQWgyJRj/0xblpjEOHoUNPCx246Px1kPIi
 lyXg==
X-Forwarded-Encrypted: i=1;
 AL+hErG7Nti7j4e0BuXkaHlDtNN6WzVKd7WSwicI9iaaMQOI2TKK6cN5bDhG6QDt2uEnC3hZzTO5oHj11mU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9rdmV354kHqssgAWbBWiIry55kVhv5OObOFS8vSG52wbyuYnIt
 nuTI68quLT42BbpvSP+Wa/g/dyVxPXyoz7fl0qMwT/4Halk5CDNDUbn0ifM3ANygglP9ToHZ0Xn
 iIBOAeavgwaV4PpnPSweCtgLCzkup0gY=
X-Gm-Gg: AZFdTZff+Sv3q1vvw4tTDAlpRDm2yiJ6T2t31orJZYet6z01bu2dp9kXD3JotHzmarK
 prkJhBw25RdT2utMiYrbzyfM45vhNYooXwlXixjYtHSIJV6vZvOqLX5MNl2mU1+4QzFaVSqFN7z
 uSArj9rzVcEixGGshzAR23tKzp4clDbltheAjfQMiJsNQqaMx2TYsjLeU+rDo4VmcCdrqvKGyyo
 VfKAgVin163/SmkVh4xG8B1mIgoATlLn3Z8Pnqw+RMgMDGGdktJzyjAwa3SjD3nuHe6EL/Zt7TB
 UAzv15p9P/HFg7LF2JEuZ+cE+GkfkGgg0ywf/eEJqRYJ4N4UlUnLTuL9ruREPdMbrww35jVKAGz
 LYAQOE2TORKKNHy/1Mu1LONcEZo86O5OG6RQRn1YpRup8DNvvwsYV7V47sjL4+xDadTtpUwoLm0
 9AYu1nMQpc7yl7DwEDH4rvznTIxLNx6mIAAytOaDrwGW8sbTkqqSC7u7iLBi2qrt3+qsumTIr+a
 PwEDV4=
X-Received: by 2002:a05:690c:60c4:b0:8b3:b01:74c3 with SMTP id
 00721157ae682-8b518f19782mr69361117b3.23.1795593477817; Tue, 24 Nov 2026
 23:57:57 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Wed, 25 Nov 2026 01:57:56 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: peder.bergan@gmail.com
In-Reply-To: <20261124185427.3821700-1-aliceryhl@google.com>
References: <20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com>
 <20261124185427.3821700-1-aliceryhl@google.com>
X-Google-Nh-Sender: AW_J_UoiGWtwg6qnqUMBw-OJ-1UVFEbjy0wfv5Rh44W6JIMxd7U4y8mFVkrNI5HtQOK7ljja6JOiAjS7xwkZiGXEFdl0Ulsl2DyARbLE2OBtjbGtkeGRZSW5XZ0J_3lGWC7feWPG6jWtexTx2GjMEIk-wJteUIn1NtnDiX31bUda1vsE4L49hwYvar3comaDfsQX3th1DE1l2TZIEwwsgH3CoUYV2ANOWtkRhrYjuGo-r5eEdHFq0arOpzb1pjIEWnQXWuL9
Date: Wed, 25 Nov 2026 01:57:56 -0600
X-Gm-Features: Aa3M54p1LUGsSOwrIWll983HQ7Jb_OQJyMjmYeIZbB_tbx53ZIZvkiW3hGwAhAA
Message-ID: <nh-b28a5938-34e4-4077-822b-71fae5f4773b@google.com>
Subject: Re: [PATCH] rust: drm: enable standard fdinfo for Rust drivers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Janne Grunau <j@jannau.net>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks for the reviews, and thanks Janne for testing on Asahi. I agree
that the Fixes tag should go.

Danilo, I=E2=80=99ve prepared a v2 against drm-rust-next with the callback =
in
UnregisteredDevice::FOPS. Would you like me to send it?

Peder


On Tue, 24 Nov 2026 18:54:27 +0000, Alice Ryhl <aliceryhl@google.com> wrote=
:
> On Thu, Nov 19, 2026 at 10:48:47AM +0100, Peder Bergan wrote:
> > DRM monitoring tools use drm-driver and drm-client-id in procfs fdinfo
> > to identify DRM clients. The common Rust DRM file operations leave
> > show_fdinfo unset, so these entries are missing for those clients.
> >
> > Set show_fdinfo to drm_show_fdinfo. The DRM core helper emits the
> > standard client information and calls the separate driver statistics
> > hook if the driver provides one.
> >
> > Fixes: c284d3e42338 ("rust: drm: gem: Add GEM object abstraction")
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1266
> > Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Alice
