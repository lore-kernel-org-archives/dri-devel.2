Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAF3C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4493A10E12B;
	Tue,  8 Sep 2026 09:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="IkIX/FDT";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C7710E12B
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:18:55 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-482f9309813so4013674f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788859134; cv=none;
 d=google.com; s=arc-20260327;
 b=BaDIUWm2Mxolhxr04s5kPhFqhm3KfRSkiTzIjm87kHBMP/jIcsvz8zB+mAM7FXkpfq
 5ohLzFN77i9IyHs6lI/Vz0yTj0UDjLnbLiOJMzv8av5JPiv6AwCumQgP6bgsQG8oBLUc
 iGXC3A3fUZfRR0Ur6wQgNCUqX6WyOlFfoaOt+yShp+pVKraaiGGaki0V/RMRceE8l1cP
 tub8J2Gh3uQjUOmC0R5h5RLIcX8HKAnyKUISBmzt9Ab1t4YwnByWmqk1AkBdY7UmkkqW
 pqqOQ8FcvcmLZqsUhLnTrsZJs6AVGOEGkxbEeChzzKweVdsdKN+7x5WzEpbjXM9tFRtl
 xirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VIgSHXB8I26MCbzgx5LIxLwOOEsEsffKtC5qMFw/5wM=;
 fh=wSGlXalEAMoA/4ZpngYG3m/ZtzZ1eljvA/bngUlw2GQ=;
 b=KTl6olYs5MldhVPiL0/nHzmKWTSk3Idu/I2LVK7yvR5lrWHnfFVj5IzJE+DfbRNK4t
 dTeCLkcizxTzHIjIA7yFousExqlP9S+iL53q89Tj3m+xrYCzDvJE5kFzxo7L8VHSpKWS
 F8+JWKJoGVQraPzqxESaFv5L7WM1OKebYQf3LJ4lwKKSxbWT6zUZRk73nKOmwTPXP5UJ
 61hZAsPDn07KyzQdpNpsqW+pHvD3gbN8EU+1E4F5kd/qt+6VvsgBWNL8I1jEpz6hYZPS
 8Il3jNw7enWChbWYxZswPsUhcLysWLj0+2RnxTUbtVHRoda2Es4l6mZoJeQvEX2e+8vL
 kh2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788859134; x=1789463934;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VIgSHXB8I26MCbzgx5LIxLwOOEsEsffKtC5qMFw/5wM=;
 b=IkIX/FDTVI4gvRp74MzeC2xp3KmwJrdhy7ZVhfL2vL8+VIqO/MIEX0w67YdpmXTtnC
 QYfWM/kH1bOlY1WPiW2Qu3fRWpcqicacjG8fOmmpssTbAnfxW8I2Vbn7xTJiYIs2mmkI
 1grT/pJNNB0cS25Bz3ficR7WV48aIZVr5VCZtr/lS1gG5syuhe8JQ5ClI/p5n9Xw3bO/
 66VQ0Qc2MsovRqXsNaeJEhl/mSln22L1o7nRvNeA7b9zjZIS2P/ad9f7vNrjGT5WBEGR
 xWySogK0sqR60WHnQYwGiebB+UJlqQB4/At/NTZ0JfogykyTV+qxKSzF1/FvMhej1C6C
 qg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859134; x=1789463934;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VIgSHXB8I26MCbzgx5LIxLwOOEsEsffKtC5qMFw/5wM=;
 b=dVdDlJJTKwttlKj2rnLCM16zZ4Rhx8NNtCSYqGVJlCviAISd+wMnV9oweQa/5Eh6zP
 hWjPW2TSLKjAp0YdEGEBZzv6OHJMt5HesrEXqMvuQYLuP/veaxE02tYX8wUY8v+rA9o9
 neTOoPptbam4eydPHtTpHDYP9uaaCBvcdLRI2A0NSVrEdM375p+COFZ5Oa1l7pxtRVYE
 ueUdhcx4MIRUhtVc3zssm5hie8z0CfxTxsp0TUAJ8i7wjWZHq4r8WWEimJp+b0TBjRE4
 rbdExO2F5RBhv3YNStSdRcSxBexwvcmIUE0Q0BF7JZIRg+43eYZiUUUE8Lqq3j0XX4zn
 rEdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+n+fJZv0Bm4f+0EYYOaPeoXOoQEfhKBQINu4GQ2Q1La1sCJuzo1IrUkxKPPl0MUIcPT9s8SjmV3U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++liIAo3XuaVQd0DVdzIoKm+UyH9xFWn0VR5CnPW04IwxiVncR7K
 U/u/YKSYnXHfA7NxKsgShaFNeJ6WpC0piC30S3ABD4YiThfNVzQS3Da1yuCsnxF4TaE/HXVmkgn
 gp9uB4hzwM2smK0BPkcvGdlzH+eL032Hm8cSrvBvf
X-Gm-Gg: AYBFou0C7VJB3ecI/1UeuOYC9x1yOCqoy+Oiy9Ef2KvTM2NLKPw3dMC6pLrtFunseTy
 21X0NSDxcy5HEK21oEFAdkMTd0zYgvdPSN50HOwKFjShiNf4Ij+3Mfqyw7y7fFISmd5CV8xrpVG
 rI0CDmLI29GVY0FVqiiVD6TeNqUmLvJkmFQeB5xvJRrLSF29ZkGUkxmVQ0p0wl0lEkJfjONco8I
 vUnp+x98EsZJfXbYOPc+2+4cperO6m6EKenBgnszUHmOA1lDDf80EFQwLUVARUGC+xU1c/FBPGA
 bF6v036/s8cpiydXiCOIme/NEASIhdJWDKXcrwLIJ+YojBy4cIM407qMV82XO4esBjF1A34pLFw
 5d4BKpN0OWvBYCqtQi/Q+2vjYStEZ6Q==
X-Received: by 2002:a05:6000:2584:b0:485:8c16:5efa with SMTP id
 ffacd0b85a97d-4858c16617emr27731999f8f.52.1788859132844; Tue, 08 Sep 2026
 02:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
 <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
 <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
 <2dpwVpJS3VbfQ7CmE3HeY4IJSSMXTP_O9sSP3HHHUD7Z29RNEG4Hc0m8f94jKWjFlekcTXvIBA-QdGYrf8w1sw==@protonmail.internalid>
 <CAH5fLgjEfZO9DwcUxaKCWd_hFUrXU+cxiwmRg1UnM2pKD6gPvg@mail.gmail.com>
 <87zextw4c4.fsf@t14s.mail-host-address-is-not-set>
 <CAH5fLgjYmvp1Ph3dYXnTKkAvWgNpgCAPeq_7PZhRai6pCNmVmw@mail.gmail.com>
 <87qzj4w2nw.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87qzj4w2nw.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Sep 2026 11:18:40 +0200
X-Gm-Features: AcwNN1VPjOtQdlrm_QvCyA8uta8erft96HkhfUzl1dJDcrSqVwPtKidMELQvEqo
Message-ID: <CAH5fLgjrQDWSPX-81TNdnc=AU3Jge57vUJ_SHCn8=uUyGfRq=g@mail.gmail.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
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
 Asahi Lina <lina+kernel@asahilina.net>
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

On Tue, Sep 8, 2026 at 11:00=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > On Mon, Sep 7, 2026 at 3:58=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >>
> >> > On Mon, Sep 7, 2026 at 2:38=E2=80=AFPM Andreas Hindborg <a.hindborg@=
kernel.org> wrote:
> >> >>
> >> >> Alice Ryhl <aliceryhl@google.com> writes:
> >> >>
> >> >> > On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net=
> wrote:
> >> >> >>
> >> >> >> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> >> >> >> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wro=
te:
> >> >> >> >> +        // SAFETY: We just successfully allocated a page, so=
 we now have ownership of the newly
> >> >> >> >> +        // allocated page. We transfer that ownership to the=
 new `Owned<Page>` object.
> >> >> >> >> +        // Since `Page` is transparent, we can cast the poin=
ter directly.
> >> >> >> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >> >> >> >
> >> >> >> > This doesn't satisfy the safety requirements of Owned::from_ra=
w()
> >> >> >> > because the page may be used with vm_insert_page(), which incr=
ements its
> >> >> >> > refcount and causes it to be shared the vma system, and this o=
ccurs
> >> >> >> > before Page::release() is called.
> >> >> >>
> >> >> >> I suppose the existing vm_insert_page() abstraction we have is a=
lready
> >> >> >> problematic, because it uses `&Page`?
> >> >> >>
> >> >> >> Maybe we want to change the API to use `ARef<Page>` so it alread=
y has to be
> >> >> >> shared? Conceptually it takes a reference count from a `&Page`, =
which isn't
> >> >> >> possible because `Page` is not `AlwaysRefCounted`, so it needs a=
 `&ARef<Page>`
> >> >> >> to be able to do that op.
> >> >> >
> >> >> > Honestly, the problem is the safety requirements of Owned::from_r=
aw().
> >> >> > Pages have a "special" main reference, and free_page() does more =
than
> >> >> > put_page(). It even does something when the refcount does not hit
> >> >> > zero.
> >> >> >
> >> >> > The correct behavior for Page is to allow the user to hold one
> >> >> > Owned<Page> whose drop calls free_page(), *plus* any number of
> >> >> > ARef<Page> references that invoke put_page() on drop. This way, t=
he
> >> >> > owned page controls the special drop codepath.
> >> >>
> >> >> This does not mesh well with the model of `Owned` behaving like
> >> >> `UniqueArc` to `ARef` behaving like an `Arc`.
> >> >
> >> > It's a different case, I agree.
> >> >
> >> >> Please help me understand; with page having a main ref and an auxil=
iary
> >> >> refcount, if we model that with a single `Owned<Page>` and a number=
 of
> >> >> `ARef<Page>`, what would happen in the case where the main ref (`Ow=
ned`)
> >> >> is dropped first? Is this legal?
> >> >
> >> > Yes, it's legal.
> >> >
> >> >> My intuition here would be to follow Garry's suggestion and have
> >> >> `vm_insert_page` take an `ARef<Page>`. Can you elaborate why this i=
s not
> >> >> an option?
> >> >
> >> > That would be the wrong ownership semantics. The C side increments t=
he
> >> > refcount rather than take ownership of a passed-in refcount, so the
> >> > correct argument type is &Page.
> >>
> >> Or `&ARef<Page>`? Because with `Page` being `Ownable` it would not be
> >> OK to increment the refcount from just a `&Page`.
> >
> > That's just a limitation in your traits. There is no problem with
> > creating a refcount from just a &Page.
>
> Yes, I agree. The limitation is by design. My point is, `vm_insert_page`
> can work fine with the `&ARef<Page>` type. So if that would be OK with
> you, I would patch that as part of this patch.

IMO, Page should implement AlwaysRefcounted and this method should
take &Page. Anything else just adds limitations that are not needed.
But I'm ok not implementing Ownable for it.

> >> > Now, for the use-case in Binder I believe we could switch to
> >> > put_page(), as we don't need the extra stuff from free_page(), in
> >> > which case we only want ARef<Page> and do not require Owned support.
> >> > But as long as we are calling free_page(), it needs to not be
> >> > clonable.
> >>
> >> You are calling `__free_page` directly in binder? I could not find thi=
s
> >> with grep except in the C binder. Is this code you are calling into fr=
om
> >> Rust binder?
> >
> > Via the Drop of Page, not directly of course.
> >
> >> From `__free_pages()` kernel-doc (`mm/page_alloc.c`):
> >>
> >> > If the last reference to this page is speculative, it will be
> >> > released by put_page() which only frees the first page of a
> >> > non-compound allocation. [...] **If you want to use the page's
> >> > reference count to decide when to free the allocation, you should
> >> > allocate a compound page, and use put_page() instead of
> >> > __free_pages().**
> >>
> >> I guess this is what you are referring to? We could change `Page` to
> >> this style as well and all would be fine I think?
> >>
> >> At any rate, today I learned about Pfn walkers, compaction,
> >> memory-failure, etc. that take transient refcounts
> >> pages. With that in mind we need to reformulate the invariant of
> >> `Ownable` to exclude optimistic transient references.
> >
> > Yes we can switch Rust Binder to use put_page() and have Page not
> > implement Ownable at all. That would be okay, because Binder's pages
> > are not higher order.
>
> As far as I can tell, we can also switch `Owned<Page>` to allocate the
> page with `__GFP_COMP` and use `put_page` in drop.

I'm not entirely sure if __GFP_COMP is needed, since the page is order
zero to begin with, so I don't think it makes a difference.

> > But this case still does highlight that
> > Ownable<_> currently does not address the use-case where the
> > Ownable<T> is a special reference there can only be one of, rather
> > than a completely unique reference.
>
> This is not the use case `Ownable` aims to solve.

Maybe not, but then it doesn't apply to Page.

> > For instance, the GPUVM abstraction would be another case where
> > Ownable<_> could be used if we have this other model where Ownable<_>
> > and ARef<_> are legal at the same time. Currently GPUVM uses a special
> > UniqueRefGpuVm type to solve this problem.
>
> I am wondering if we can make case I intend to solve (Ownable is a
> unique reference) coexist with the "at most one of this ref can exist".
> The "at most one of this kind" sounds similar to the `ListArc` use case
> to me, which is a different problem.

I think they can co-exist. If AlwaysRefcounted is implemented, it is
the ListArc use-case. If Refcounted but not AlwaysRefcounted is
implemented, it is UniqueArc use-case.

Alice
