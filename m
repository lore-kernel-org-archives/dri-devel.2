Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D981C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0A610E83E;
	Mon,  7 Sep 2026 13:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZCnV1883";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F9710E83E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:31:31 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so3979419f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788787889; cv=none;
 d=google.com; s=arc-20260327;
 b=NPuoogJviY3x91SKIvbdsfFOabdsa5EISkZQ0FoacAWUNkRp2AQ4sWAKuel+bmikW2
 noq0yI5gOSk8OCq5eRKxz1XjFzY1SHOYMFwgasV0YyjIxPpjX3FMwS6R0+YEDf5cfE3U
 ZMr7JoIJ2AtIS+/cUgfifCc2t8od0LIDhTOrCGSZsQFCA7+hJRJ4KeNzT0WbEiGgaH64
 +3HUstLWTujiw+P63znVOWx2fJ0MgqdGO19nwLvcxfTih69ZRm+rdSauER6nn0HR6Gbh
 0at8qmUcWKinCIT8Ezyc7f1RN7s0LtNRtA5CIdU5/4Df9PnPSYu06gIaYza/hES/NIuX
 2oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MeIqMgyiOqWe7HQD7SmKTKpkW52D9bvAC89kO8GNV9I=;
 fh=sEdyBamAiiyfYtxqtEpmwD597fVjLhrGADmPgq+mqCE=;
 b=Rsw02ok1qBpsfVlEw8n3LTjpHlzx9Nxr/tPFvNTuC476clCJ5tqWbNg5yNGSagGGb4
 GtV7Ub0aJmXCSHhVfsD7nPzXFnfgFnJgtxaxXl5W4DyJ2hMiRYW060IentA1fJf8P8DQ
 BdI7PeeU5V8gUxxyD/r5ucgySNIREdV9pwaJ7UnrPXUihtkqSkcvqO1H6x/ecBeeoHBl
 oLVub047R7TURX3xgUytr+kC/A8Kb09j+5CH0nBTmqpNBFMmfr3mJUoxrrsTVT83Qkzr
 X3Q8mJJazKyoWipcvPtvrTPc60UBRtKQnM/VYJRKi5vfGYkMpor9Jq9daopYr5KU2Byk
 ImAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788787889; x=1789392689;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MeIqMgyiOqWe7HQD7SmKTKpkW52D9bvAC89kO8GNV9I=;
 b=ZCnV1883JQ0YliiDYpWwOdUpsqqNeo0HBk7gctg/YltovShNZbutKPi6FY47iL5IhE
 1EC0Qv8h/1U2/HIxPlJWNogDO/+RiEPtErkV5gFHqJrgO8hJ3DSqwVmWjjISDX3n0neP
 MAiocslpGNCf9dpHoIydLaUvrMQ3LOp+DCz8HjmNXPA2KBDcLJJCOn/NDuSi6qvFZqgf
 xQe+eDmqH0Sn3Dqq6H1clT6FkKD6VqGwMTbMzyzzZpa1lmxy1rWWsqCKSjtVEbsivyy0
 JTFsikHyzojhF1Rf4gu/5cxF5mGUUCw9Vu29pAe89vW0AcbA9JaTYd2C5J6HcOwcGec3
 /YcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787889; x=1789392689;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MeIqMgyiOqWe7HQD7SmKTKpkW52D9bvAC89kO8GNV9I=;
 b=VDsQcgbWeOYhLAJ0XMjCL/TubT9NO+OQQj+t0JXPmeDpqUsFG+4NmRKA83sZrGiN54
 PFNSV+5ZZYbv0SsoBLCqwzh/EdM/JVivKAIb0hyYFtXC0y3oX2nlwMgVpvd64kNFOONc
 4277R0OWsXtdEUR+JfIn+qpJprng9BdUWEhpbKB8c+Sm1U1flWfq+m1Ki0WQToUM+DFF
 pcpUfb7vTitZOKTyb01THtPcMwS+barYblNspajSm51CT4jbI+u2XWuvOc/Jm82n07+m
 iIFEpOAFcb69AJBAMck85KqFdQfyHKwZZDO3RvzVc/sgRL0F7lUk7XsuSBXOOO0pddiT
 BefQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+J8+Rr1M8Hq+dqe5Eh8Irsd3DQipyGsmc5at+QpfG05bCVqUfZiVsjQArEZvnPi0G+n2Idtdb/0E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l3+grGBfBq1BsQCTOs3P7c7qF/3Jot/SpMsHQcUKHm+lLJQ3Oz
 lNnFrYF5pDtSR+ff2/9qUsVp3DgZi0hzPdLSsMLr3dA1CTGASRCzJxZJRMf63/hDMQyQtMu8CBA
 KZJ+4vTtKc9me7TW3YYcyU2oHcNAifPr742IWh1mx
X-Gm-Gg: AYBFou06XMTq5MAn3kyx59QGEbHNnwUAaoq4FA8OXp8nYpiOvxREUfGpNulQECYiQL+
 d3BCa1HoUrLrdxTQnEl3sOcALFue6S4Z3OZa4Qv0rKnkMYBeVhwb80/ACpJDvKVt+2dyYdCErKW
 g7ZNFrvN7PGEN/jhfRU0KYpWVYN7YWpltJT8PC2XS3GiFK11Rwy4rKXWd2oG7Jo30Ha4evvaWwp
 IpRstxDLtszmDlc9cdLRRGaYYFkVdTDn+/itBXgGmREh7nKPHqg+dO7RHLHISWDwx8Lhp4gBdPP
 qbzUqRZkQMhw5OeS4MAjlVDh24ABnukZuVkfF6FAjN5U19QofzHRM0kIS9O1MkUh9aeNqWignr8
 40DG9YCyhoIMldrXJ9BNb1x+R/mmIE1EwR+TPnPCFHA==
X-Received: by 2002:a05:6000:26d3:b0:485:8393:2176 with SMTP id
 ffacd0b85a97d-485870902eamr40614985f8f.21.1788787888668; Mon, 07 Sep 2026
 06:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
 <ao2WubjLtDuHvRzx@google.com>
 <DL894TFXM5AT.2QOXN683UKXIF@garyguo.net>
 <CAH5fLggAMfBcxprKJxs4JbieKadC_mKg4B0xNETOH1QUi72UGQ@mail.gmail.com>
 <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <8733vlxmm8.fsf@t14s.mail-host-address-is-not-set>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Sep 2026 15:31:16 +0200
X-Gm-Features: AcwNN1Umd_wQEAUZHPYxidNRM70dkjd7WtcOMgQxK1KjbblodnsY1lRpQ3kHiGM
Message-ID: <CAH5fLgjEfZO9DwcUxaKCWd_hFUrXU+cxiwmRg1UnM2pKD6gPvg@mail.gmail.com>
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

On Mon, Sep 7, 2026 at 2:38=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> Alice Ryhl <aliceryhl@google.com> writes:
>
> > On Sun, Sep 6, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrot=
e:
> >>
> >> On Tue Aug 25, 2026 at 2:20 PM BST, Alice Ryhl wrote:
> >> > On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> >> >> +        // SAFETY: We just successfully allocated a page, so we no=
w have ownership of the newly
> >> >> +        // allocated page. We transfer that ownership to the new `=
Owned<Page>` object.
> >> >> +        // Since `Page` is transparent, we can cast the pointer di=
rectly.
> >> >> +        Ok(unsafe { Owned::from_raw(page.cast()) })
> >> >
> >> > This doesn't satisfy the safety requirements of Owned::from_raw()
> >> > because the page may be used with vm_insert_page(), which increments=
 its
> >> > refcount and causes it to be shared the vma system, and this occurs
> >> > before Page::release() is called.
> >>
> >> I suppose the existing vm_insert_page() abstraction we have is already
> >> problematic, because it uses `&Page`?
> >>
> >> Maybe we want to change the API to use `ARef<Page>` so it already has =
to be
> >> shared? Conceptually it takes a reference count from a `&Page`, which =
isn't
> >> possible because `Page` is not `AlwaysRefCounted`, so it needs a `&ARe=
f<Page>`
> >> to be able to do that op.
> >
> > Honestly, the problem is the safety requirements of Owned::from_raw().
> > Pages have a "special" main reference, and free_page() does more than
> > put_page(). It even does something when the refcount does not hit
> > zero.
> >
> > The correct behavior for Page is to allow the user to hold one
> > Owned<Page> whose drop calls free_page(), *plus* any number of
> > ARef<Page> references that invoke put_page() on drop. This way, the
> > owned page controls the special drop codepath.
>
> This does not mesh well with the model of `Owned` behaving like
> `UniqueArc` to `ARef` behaving like an `Arc`.

It's a different case, I agree.

> Please help me understand; with page having a main ref and an auxiliary
> refcount, if we model that with a single `Owned<Page>` and a number of
> `ARef<Page>`, what would happen in the case where the main ref (`Owned`)
> is dropped first? Is this legal?

Yes, it's legal.

> My intuition here would be to follow Garry's suggestion and have
> `vm_insert_page` take an `ARef<Page>`. Can you elaborate why this is not
> an option?

That would be the wrong ownership semantics. The C side increments the
refcount rather than take ownership of a passed-in refcount, so the
correct argument type is &Page.

Now, for the use-case in Binder I believe we could switch to
put_page(), as we don't need the extra stuff from free_page(), in
which case we only want ARef<Page> and do not require Owned support.
But as long as we are calling free_page(), it needs to not be
clonable.

Alice
