Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89526C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B03FA10E0F5;
	Tue,  8 Sep 2026 21:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=darkrefraction-com.20251104.gappssmtp.com header.i=@darkrefraction-com.20251104.gappssmtp.com header.b="U1xGYQUI";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3602E10E0F5
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 21:20:58 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5c7c25d9f6fso4672445e0c.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 14:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788902457; cv=none;
 d=google.com; s=arc-20260327;
 b=s5LGCNa6h2slkuuSr0s9wjX/nWKfkuEKT4pdjuSSb/v++tqnZVNo2mrrnP6vGrPZAq
 Ir2SXBgWMskjeNgz2GGAtiH564eDH82eKEdHJWUFGDSG+79tziOYLmjdqHHS14NVl2JS
 AI+rbCwacZmsrztSDiy5J4PWd0prQmzTCaSfcBq0CSHkYHIfiIetMZXB9fzI4Zpy1zsI
 Dyh9bNlI5uQ98dLGFJEDI5z9fcgl60V4AvAjMPAetC/RrJMMHN+gnpzECeJ2Hsry1HLi
 YhU6TB7nH4mmU4akocRbKWu9Py/yqS/F8Qe/t+0tuHQZUAz4bht/iI9VylTKEK70jPkk
 PbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VvyjDZ06O/CEu+yLay8HNE7ZoTCVU0Mg4mkvXP43glw=;
 fh=QZR4sSWT5oWXgwJyZUa5FXNNVPGEdKr7oAHgHZyDk+w=;
 b=W9tLxmJOnJOF33LccQP7ToZcLtYpZgOJUxfId+ldhgSl8CcnuGdpe38+dIu8Xz1HvZ
 TVfG+wePJd7zT5ydW8CZPpmHy2nzQcXK4rlpQfRqH4oPz3E7fhd1wSxCU/FM54OH82Ez
 Ru3njRcOFxrYhhfTty0R6tO3SIJRNRYWoaVoKoGmTHuqF7ZqUOX/0r+KzFI86BjUv06A
 R8f04C+uWhSNevrTs0AHiZ2e09yN8Zt4mL+RgckF9tRcgk7BJUNPlBmN7Vk6ivE+mJpC
 Gf+w3QB5bCoh8zQzBIq4etm24mLolZNZ1dGtnoiwi0Sn+jXHTGIoUD+bGG5dq56JaiS7
 Ma8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darkrefraction-com.20251104.gappssmtp.com; s=20251104; t=1788902457;
 x=1789507257; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VvyjDZ06O/CEu+yLay8HNE7ZoTCVU0Mg4mkvXP43glw=;
 b=U1xGYQUIaCzkEZUIFD4gIwrDs0cdHf4ke7mcBfyZoczywXpKCR/xpHed4hprpXIy6Z
 0FiixmQMlqvA4R8Bjyesxr/fvFnbEm6SDk6OvL/xsmCDh78ol2Gdq1wbo40lYs4dwzXK
 7wNZ6tCG0dyykLlqIrrdkL0cEqe6mSZfbfVYzcVimw3YdcnXDAGWIYjMT2LPoE0PhEUi
 aKGlscZ3SlGljQFmf5Dm0T9IQQC7lsbnOKV9D2KCt14MyEReet4XqoR4Vg4Y+nfkfJJe
 HjOs6mWjjM5Ct2WWMUKEZBJBxoUqeKVqaorzSGncWmdMybGGJppH+OSJ61gej42MarMg
 xZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788902457; x=1789507257;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvyjDZ06O/CEu+yLay8HNE7ZoTCVU0Mg4mkvXP43glw=;
 b=gVNJIKUJC7+4YRUO08J9akoaz29Y3dJa1CYjSFjStuQM90DUrE1fJQ1/51FuPc3zNg
 rtj5hhwVjcx9JDSXERz3RB38p/TDLfav4xxNZaMPWp6YSZ1qPdQ2SE163jjoQEMjuMxM
 ltBGHei7PIoDw/La+5v5wWVSeZfsjdq6JcNdxH5wn0NS+qDCHW5co/ZYPDqSQD19izbR
 EgTrFfvqDTPujV2J+KOAPSkRgWMnWtrWIwSHxLJktBZYsRRGkEa+3O9afvfMAssy6zL1
 ZYrtV3y2Ivc1Rx5yDncnsQl3XeYRUzqWvoxsEBPbiFff5SuhsR/cVJXyIXveP8pTf/9p
 f1HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxajZ/7K7P46XtfMOfmIXTyH1EJBI4S3LimRcdOdhAkhOGepCyFEcPjfEREYgxhwGoI91Ua7MhppP4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/hYuwS4WM/cWY11i9EGGfPSoXxzbi+Xz5NcH+YCEfEx5mo6WG
 UYeKc26W45nyHYkhdbtgMNoBtJHLaNW5F/TR+/6DSq+4uRjByP1PUmcjwDe4vW9tdy0bBM6Us9D
 DonctKBLu9XMj5ahZ0OS3hk3jo/3e3aEnTsuHDC+XmQ==
X-Gm-Gg: AYBFou0vhOu3qy0aZT8Vd1vlg26PaxbhZwOjpOFtpQaIv5aXoowuDDRFUM9QOxNrsXK
 YNIGSmFoVgo+rnWYVQmSSOkl8DFu3pWRHoFIR/GRpwMw2P/18DT9EvoEnAsBC0jPV7TdNHeUJFH
 BjDFRrkbdfIRGag17FZ9nTskfg9ZZkuklGHQ1ukxD57kQB4WUZLZ/RnGAt7+YaEQPrLH0QZRzAq
 29m6gLLdAPP368SJ/+YtkYKGoTh7dY67p8ZjN7p2PHX5ISYjxKc8pNGkI3KyIX/d4hxEO2FJBFf
 VbjqNveL1sxUjA0I34rjoS5DGSALVna5QVO80pG76eoA
X-Received: by 2002:a05:6122:e189:b0:5bb:eebe:7ffd with SMTP id
 71dfb90a1353d-5c7ed846723mr18349037e0c.8.1788902456679; Tue, 08 Sep 2026
 14:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal> <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal> <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <CAAgWFh2iPJzQ5PJfFpPBTdgZ=GFjy7Eoz5C0e1WwFMuOuyJSTQ@mail.gmail.com>
 <DLA3DUADGEQX.1Z2G7Z4TYFK1@kernel.org>
In-Reply-To: <DLA3DUADGEQX.1Z2G7Z4TYFK1@kernel.org>
From: M Henning <mhenning@darkrefraction.com>
Date: Tue, 8 Sep 2026 17:20:30 -0400
X-Gm-Features: AcwNN1WUDXxoNO6V6IWGTSyf4m-_qnTdLZpGwBIrUYQYwOu9jMMSrLkSn7q6ieM
Message-ID: <CAAgWFh3FoAJND1wS6Wu_taUWPYGXpawEtKUiAwR3HpjcqXyWGA@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Tue, Sep 8, 2026 at 12:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue Sep 8, 2026 at 4:48 PM CEST, M Henning wrote:
> > On Thu, Sep 3, 2026 at 6:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> >> Because userspace otherwise has to figure out the architecture itself =
based on
> >> the chipid, while the kernel already did derive this information.
> >>
> >> There's many ways userspace could do this, and I don't want to incenti=
vise any
> >> of them.
> >>
> >> For instance, you previously showed how userspace derives the SM value=
 from the
> >> chipid with sm_for_chipset() in mesa with its own lookup table.
> >>
> >> Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.
> >>
> >>         fn is_turing(&self) -> bool {
> >>             self.sm() >=3D 73 && self.sm() < 80
> >>         }
> >>
> >>         fn is_ampere(&self) -> bool {
> >>             self.sm() >=3D 80 && self.sm() < 89
> >>         }
> >>
> >>         fn is_ada(&self) -> bool {
> >>             self.sm() =3D=3D 89
> >>         }
> >>
> >>         #[allow(dead_code)]
> >>         fn is_hopper(&self) -> bool {
> >>             self.sm() >=3D 90 && self.sm() < 100
> >>         }
> >>
> >>         fn is_blackwell_a(&self) -> bool {
> >>             self.sm() >=3D 100 && self.sm() < 110
> >>         }
> >>
> >>         fn is_blackwell_b(&self) -> bool {
> >>             self.sm() >=3D 120 && self.sm() < 130
> >>         }
> >>
> >>         fn is_blackwell(&self) -> bool {
> >>             self.is_blackwell_a() || self.is_blackwell_b()
> >>         }
> >>
> >> That's two unnecessary indirections for something the kernel already h=
as
> >> available.
> >
> > Userspace mostly uses sm id and engine id for feature checks, and I'd
> > like to keep it that way.
>
> Please note that I did not ask to change any of that in the context of
> chipset/architecture enums.
>
> What I said is that I don't want to incentivise userspace to derive the
> architecture of a chip on its own, given that the kernel already does thi=
s. (If
> it is never needed, that's fine too, then we don't need to export it. :)
>
> Of course, architecture and engine class id can't be used interchangeably=
. The
> engine class id is more fine grained. For instance, the engine class id i=
s
> different for GA100 compared to all other Ampere chips.
>
> At a quick glance the code above looked to me as if it doesn't care about=
 the
> engine class id, because the granularity is architecture granularity and =
not
> engine class id granularity. But at a second glance, I think you are actu=
ally
> deriving the engine class id and it just happens that the code does not n=
eed to
> consider e.g. AMPERE_A vs. AMPERE_B, which is why you don't have an
> is_ampere_{a,b}() accessor I suppose.
>
> That said, nova can easily export the engine class id information instead=
 of the
> architecture; the kernel will likely need the engine class id anyway. (Al=
though
> it depends a bit on the GSP-RM API, I think technically it could get away
> without the driver passing it in.)

I guess my point is that the entire compiler uses SMs everywhere. It
largely only knows what sm you're running. The is_blackwell()
functions are helper functions and are not typical of most checks in
the compiler. I don't consider this "two unnecessary indirections" and
I think the code you quoted is fine.
