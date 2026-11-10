Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF8606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lL7je7rV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CE510E8F4;
	Tue, 10 Nov 2026 20:44:08 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7CA10E8F4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:44:01 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso17512955e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:44:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794343440; cv=none;
 d=google.com; s=arc-20260327;
 b=fZ5rIr5kYc2Zq/zJIhG8zdjHoDN35JrpM7zpik/TTIqvzeT15FexbiUna3X767/+aa
 J4suugmIlFE7GOGzyDn0CK+P7vaUqJiI9kQ+aFtCrQWFFpkZClmZGFQxWNa4p/4/mpCC
 JOitJ0JEaBcGe1RZ7mwgkrablL8dMhuGzx1wzgGhn+5uCga5PZAC0nWLmqfGcWYnf5AJ
 Q8kekv+ws+sMaXy1myTorAFBefYuv6tY+bD8L4ZivjCoRlwWIXXKPw23g/4p9PEnCFvQ
 rbp5Oz8D/4Raoe8PDoA6EaSUamWiDy2nsJZLbKMYITRyGDDy5lKPemlcyWyl7Gy3Z/Ep
 VzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZRgSF8D4bd4C8Ia14tMpoUoyFPEZ196x64KWzShEANc=;
 fh=d7LJMM8ulSEpBXF20V1viDtfX7rzSvukhcJ0Dccmhr8=;
 b=atTRxVdR1BvcjLZcut4KkPaHeD3z1zchLhfrLrMEadq9/4f1B1rShAwo9Uw+FyacVq
 T94WZ+p224/dtOYqY3bftmeNKsBa5lTG+/W1MCXMwo2jvfZwswnON3LJ1MkSVtEB+mdf
 eMrYKGwIOKftjdvZ5dhFbnv0xpiGEq65fOwp2Lj2+Q/YQdD3InBw+fjJ/i2+nDXgUGRn
 a6dDy7JJ802BEzxh4xQWXGYTM//HXbkxFm52dy+Evqy6gFW6X88+6u0xcNwDdKcRKG26
 mY8xNE0hiq4vm64b2WPbc2GKKidXVWcD9z/NfQTkEno2PSU/Rru7omDaQClx1V3CMAJy
 jVPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794343440; x=1794948240;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZRgSF8D4bd4C8Ia14tMpoUoyFPEZ196x64KWzShEANc=;
 b=lL7je7rVNIPzgHqJ9qhVhN3BHGeYBmacevENaibd642FL0ulbGWpFSf3TonrCXo/EX
 HVXX+30GT36a+7Ugpu3FkNYQIk7vM9bgGSdVP9FiFjGzvCp/bCbaek/xOo81gO+Rptnk
 tepOZuf1NbUcoNDw9zqpA9TEp+u0oAgVnkS9JDVk17bCGn44KWGTsOqO6CfDfXPoGwPl
 hW3/NcQN9Pk3nRsVmpQUIzIH2ITBWBG2FOGjmA+A4PfReGNMz5KuuIf1T2T4GI82ua/f
 zadNIZXXbPZdNdXc44BrE1I+QvkryvAN5keUUauN9wIMLt/Qj3l8jJjmqi/9Tc8cVq1D
 fNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794343440; x=1794948240;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZRgSF8D4bd4C8Ia14tMpoUoyFPEZ196x64KWzShEANc=;
 b=1BZhrCkBfqlKyxnsjYedgU52OVZJ/r+f1ZaStJKa0hDvW62kDOxFn2feE6NuYz+ok0
 VtlNfG43t1nmj9/RYVLlpnY/6ueEy5eVoDHuVElpOzZVs1xUKOuPscVK2o9lGno/1MGP
 ERcvpbMIVH+tg+70Phe61HVXNn7k7Jzje9uRobMqKlxTR0KXyXrgZ9VV3gr/vS00X2Wv
 aiX8zsgWd9Pi1HEKWr7BlZ9VHJ1Kw0Gd4Z1KHuBKUh0n2NqdXb8TfPUp42dDFWGx/fcU
 4vRmw0xT2wBAliBJCMn3pP68YrsxCaXYMvx4ihgFoBH08lYCInzJ+UDIGFVaAZNtWGjr
 GKLA==
X-Forwarded-Encrypted: i=1;
 AL+hErEFEJ1mMjW7B4RrAIZMJbSDMmcgLIIqg7rNMGyncaRkK1x9NR4ykIsbV0BtwRi/4NjHve41+ziQpGA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8mhcj3QxwFNh4ryiaYHQBpXxQQn4LyY2RaXTQmZ9/lG+zWCBG/
 YiCeycR/PFLBoklXFnRiHYSOUDE93NQLgFx7EqjNRPZ6JKzwzq7sUe3lSKDSpywbtxiTjA3JjD/
 lVBbH7TxiQniK3Er9NcHpfkxNm9Ho7oQ5iN/tIUij
X-Gm-Gg: AYBFou0fg61FSxiNk689w/HY9KM1Ue18o2Kb3lNGq7f0RHEgw4hojF/Skrwh8/xSUCx
 qR1XChP+WB9DWHUsg99oJ2DbKxLZaJuHBr+TaGDAA+/nvmMWG4/1iVGHoy2R8D+akwoie/lDCC0
 GiuTGFhBGS38sK+4Avh2rtvRNsIa4GdN+2XpxhSgF9i/NlSXleHYVisU5OBsWA5D+wSZ8+YtEgJ
 MhU1Y3pTSqsBWOUfYIwcHV0UD2oGKlsfi27pmS/Vm30GZimfxG8e2VlrH23jlxTJCgPevcmmv1Z
 99wC8o35Q3tZGhc3nuBhe4hyjQ8BQn7NTea0sAL75+tkSxxgU5uKBr2aYszM+ijmg8aBSuQYoKa
 Wl67cZskdvNSjATtmXvYxlTvS7ljEi+tNQofF0qUcaiThZyRBMHXjqdQLwHEdiPy1iScT0JK/Ng
 VzdFhEGEW+5AviDYY=
X-Received: by 2002:a05:600c:354a:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4ba0935dbe6mr4583165e9.5.1794343439620; Tue, 10 Nov 2026
 12:43:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-8-dakr@kernel.org>
 <au7eV0D_44ipe3mw@google.com> <DMP0HGBVA3Q9.T8UP93DA34UK@kernel.org>
In-Reply-To: <DMP0HGBVA3Q9.T8UP93DA34UK@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 10 Nov 2026 21:43:47 +0100
X-Gm-Features: AclHuK_M_RBnCdkeBBogWw-mSzZ7FX9o88E5X3OuiqD9l_BOcZbdHx_bNnfG79w
Message-ID: <CAH5fLggzEvheweiHte5KTaQi4G_5GtV02krR0OpXB+buDUORBg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] rust: drm: make Driver::File lifetime-parameterized
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, daniel.almeida@collabora.com, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, 
 alvin.sun@linux.dev, deborah.brouwer@collabora.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 2:26=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Sat Nov 7, 2026 at 9:16 AM CET, Alice Ryhl wrote:
> > On Sat, Nov 07, 2026 at 03:03:25AM +0100, Danilo Krummrich wrote:
> >> +        // Run driver destructors without `filelist_mutex`. Take each=
 link before dropping its
> >> +        // allocation to avoid recursively dropping the entire chain.
> >> +        while let Some(mut data) =3D files {
> >> +            files =3D data.as_mut().project().next.take();
> >> +            drop(data);
> >> +            drm.open_count.fetch_sub(1, Release);
> >> +        }
> >
> > Instead of transferring all the files to another linked list, how about
> > taking them off the file list one-by-one? If you release the mutex in
> > between dropping each file, then we still avoid deadlocks if the file
> > private data destructor takes the lock.
>
> I did consider this, and technically it would (currently) work with
> list_del_init(), but I did not like it because it would be a very subtle =
change
> in semantics from the perspective of the C code. (I.e. for C drivers the =
list
> entry would remain intact after this callback, whereas for Rust drivers i=
t would
> be removed.)
>
> Actually, I did hesitate to move drop() out of the filelist_mutex protect=
ed path
> at all because I don't think there's a way this could actually ever produ=
ce a
> lock inversion, but the "move to a separate list" approach was pretty sim=
ple and
> very few code so I thought it's worth ruling it out anyway.
>
> (In any case, I'll soon start working on the C code to implement a common
> lifecycle scheme.  Once we have that, the Rust code becomes even more str=
aight
> foward.)

As per discussion on chat, my suggestion doesn't quite work. The point
of moving to a separate list is that we don't want to modify the
existing file list.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
