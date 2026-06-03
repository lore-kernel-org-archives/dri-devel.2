Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344CCCD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF9610FAC4;
	Wed,  3 Jun 2026 09:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UrlAP4zv";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A76A10FAC4
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 09:35:45 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so5011288f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 02:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780479343; cv=none;
 d=google.com; s=arc-20240605;
 b=Ijtjw7AcAeY6kZgWEnMmwdhEQIXUAoVjQkiyihngtwYnfz6UGWTH8uR6DqL2cjxYLZ
 KpXEh0kUr/hQNaUt3PRv4zZXHrGH5wtgKqi/03/476hHhUeIk3tWtbEhIz9sQVSVaOVK
 VLR3pgztwCcciPSmNZiFcvm8jJo7Et8Qbic3wwm1nbUnlScBXzm565yHvfwYpENMHM2x
 59spNFl0NyXMbeus8qtG0Y3ZbHyFyiCA37Q2/PMm5zXxYWDMasT16zNJ5VETl7jHP0kE
 Tf6uzeWEGLAcFokjeGrapg97iF822pAcOMLm3X4qBARPLtRfsP2IpJCcrw9uJ57I/JYQ
 hnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
 fh=XmyWGI4BRHtdr4woqaJ2wKxl+nvtHza/hA8Vf/qR7OU=;
 b=IE3Z9lyUGUddIqnL5qWlAcuS1c8GCDrdKn0ETwex5oqgN+MZRBq/PVwwlpm1+KE+Ye
 /6BUeDOtLnGoRkVQqZ1nwV8hb7SGGx73ls48QdCuWH4TTDIfNBUBQVp7iUR5U3+/piXJ
 gb1pSh2PlT+RTh5VbnCiVj1UCtgXwzbJQR8LfwoxYtjXNPiN2o1aFZ8YPOBYpWQXEo3u
 xW4QOs+qfBjhwUUZCqJ2MKK2p5jK6qP0ZXwRb5ZYlMMZCIoPcPewMf544S0NQv1/RvDf
 Dy7SZn/Ib/ytGwTe5yi0iIomeJcESKBhf/zA+kCpPDm2ObYpaeC5MXW+tX50CA2UNZKn
 ecRg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780479343; x=1781084143;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
 b=UrlAP4zvRmYiHQBpWcLYXSI9lgPJxskovIhkT9151eIvM1hxYikd3mJxXf8HKEH29n
 OWci0NX3NBTp48RPlXpRfJ9ESQynECk28E6zAjLADyeda3DTGVe5QY8zTudikzTE/7mh
 5hdWeJmhEwGm8SrUBgjrv8IJptu6/ZwFcIeVVTK424sItFd3Tkngn+e2XXB+LKpaRbly
 wPu3TI/HSAFSDzyg6HhWebwdnydBk8TsXEEVhFADeLRLrRpbUVQjgBp8Jz2o3Sfv3QoP
 vzJAMCgrVTPlqZOzYLzsb/TF1c8/m3eBbNLEpksfi9h2+n80LIbNqDV1mSrSMFAwK7w7
 gnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780479343; x=1781084143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qnmLv29VDM7TDLA9eKCDywEk/4kIQYPIoZRxiHYqPdE=;
 b=dfYn5c3e4dvYLwv46bNqM8zgw4lUxiBjcv0bE9QqDJ80n5D258ZR3Qg4JINwwJTfAT
 zpoF9K21opKtpkZwKguLyomEFdrMkYSqTg1OFSHxRdDuXJyQ6B8H/pqofK/BtBuHqbf/
 lkuUIbJ83LLL866RnVPFYxALoXwuWoO0pRnx+tYnqm+tEGehAQOTQFGVzIQtnPxnmRez
 ARwyJHHvKuGod60npzA6HH+b38r2+Zuh9tb6v9mdeS6qQCew1+6WSKMk1SIPvWQqvXS5
 L8c1UBQHiAywMIbfloGw44CkZhcB2JD0UAk3G/sIvl8VhHtSD3M7nalCAcJpz2j74Lcy
 KNVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6ehjzp8T9+ZeSU46yqU4MM0iw08GbzEGp+3nsQtcM/VNTD53tAp1YkOVPy5pAGCiDz2GsnTJx9QM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybDNlVpFFkL/vAp/9HRJ8b0/xmM1MK7HHZKLMrC7d/RUjFUqDn
 pLKdsPj7jKK6iSr1HJVc3/xOarSf/YhhjZFd8cpcd2LZgJuDCL4zZUj3Jqsv6QS8xknZasFdT2J
 qqKwKqFlWpY+ntqlfn6MbP8CKsM/rMf6qg8rRzobd
X-Gm-Gg: Acq92OE5FKkcRAA37ZXynsZOabJtGOGuOZKJ34U3ajA0r/xkaueRbQRM3aOOCyt2DQJ
 L5P2TpU4RZzqU/3Sm6UqKbEPkgxbfbFja8G/Fcrq1srUgW5M5Bj5PdpWOsoR8/Ae82AWLGMTdWD
 oawjoVIxQtV2WjJA+PsNGWudsThwZk5MOQ3521YP5lC20YJF+xakQdBqN0SRZH0aT/LVex3grL2
 sbf+B3Udzno+KDvasTVFlEJmSw1Xqzaizyu1xOcCxeBE974nNzZHKn5qukC5yKY4Ug4Pi3W+TKb
 ThfvZmIJ5/edOQVs7dvB7zZ3JIPQyEJo1m5H6Axkdm5Nojmof/WiWTJ8om+a30quEG0LSQQvNhP
 MoQXs
X-Received: by 2002:a05:600c:8184:b0:490:5cd8:d213 with SMTP id
 5b1f17b1804b1-490b5eb44f8mr43679475e9.15.1780479343116; Wed, 03 Jun 2026
 02:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-4-phasta@kernel.org>
 <ahr9gtzQLSbPeBx_@tardis.local>
 <e8b16f3b40d42f3b0a8814180fa9b06f82c9d901.camel@mailbox.org>
 <ah2L-TMT5UHSd_Hs@tardis-2.local>
 <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>
In-Reply-To: <441fccce521857ab82b84bb8e5ab539ee3810a36.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 3 Jun 2026 11:35:28 +0200
X-Gm-Features: AVHnY4JfNUks84z0WqzXiLep0aUyPzGhK0pYIVWREZIpQzivqBZzfg4IE8o75iI
Message-ID: <CAH5fLghA5LfV+=r4-LbX+gaNo6v_-gSdcXOJHa76Lc74WCJ5JA@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: rcu: add RcuBox type
To: phasta@kernel.org
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, 
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is, 
 Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rcu@vger.kernel.org
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

On Wed, Jun 3, 2026 at 11:33=E2=80=AFAM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> On Mon, 2026-06-01 at 06:41 -0700, Boqun Feng wrote:
> > On Mon, Jun 01, 2026 at 09:56:23AM +0200, Philipp Stanner wrote:
> > > On Sat, 2026-05-30 at 08:08 -0700, Boqun Feng wrote:
> > > > On Sat, May 30, 2026 at 04:35:10PM +0200, Philipp Stanner wrote:
> > > > > From: Alice Ryhl <aliceryhl@google.com>
> > > > >
> > > > > This adds an RcuBox container, which is like KBox except that the=
 value
> > > > > is freed with kfree_rcu.
> > > > >
> > > > > To allow containers to rely on the rcu properties of RcuBox, an
> > > > > extension of ForeignOwnable is added.
> > > > >
> > > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > > ---
> > > >
> > > > I have the following on top of Alice's patch. @Alice, @Danilo, thou=
ghts?
> > > >
> > > > Then we can have:
> > > >
> > > > type RcuKBox<T> =3D RcuBox<T, Kmalloc>;
> > > > type RcuVBox<T> =3D RcuBox<T, Vmalloc>;
> > >
> > > No objections by me.
> > >
> > > I just think we have to decide how the treat the namespaces, though.
> > > Probably Alice wrote it like that so that it's very apparent that thi=
s
> > > is not a normal box. It still breaks the naming convention in my
> > > opinion.
> > >
> > > rcu::Box vs rcu::RcuBox
> > >
> > > With all other subsystems, naming like that seems not allowed.
> > >
> > > dma::Fence vs dma::DmaFence
> > >
> > >
> > > I probably would allow the user to decide whether he wants to just us=
e
> > > it as `rcu::Box` in all his code.
> > >
> > > But no hard feelings.
> > >
> >
> > For this I think that rcu::RcuBox is a bit different than dma::Fence,
> > because Box has its widely-accepted meaning through all Rust code,
> > while `Fence` doesn't. Hence my current thought is rcu::RcuBox and
> > dma::Fence. My personal preference is using namespace as much as we
> > could until there might be some misleading.
>
> Yoah, probably better we're safer rather than hyper-consistent.
>
> >
> > >
> > >
> > > >
> > > > and Philipp can use the `RcuKBox` in this patchset. We also need to=
 impl
> > > > InPlaceInit for RcuBox, but that can be added later.
> > >
> > > So shall we merge my series with Alice's patch, and later we add your
> > > patch and other features, or would you prefer to have the additional
> > > boxes from your patch from the get-go?
> > >
> >
> > I would like to have it from the get-go mainly because of RcuBox vs
> > RcuKBox naming. Thank you!
>
> Fine by me. Just process-wise: how should we do it?
>
> I could include your patch on top of Alice's. Would be a bit more
> consistent regarding the git-workflow if we'd squash the two patches,
> but then you two would have to agree on authorship.
>
> All is fine by me, but I wanted to ask instead of just do A or B.

Squashing is fine with me, thanks.

Alice
