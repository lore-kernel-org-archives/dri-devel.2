Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331FFCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9676010EC16;
	Tue, 16 Jun 2026 14:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="frlJVMVp";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A3310EC16
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1781621480; x=1781880680;
 bh=8lg0lMM++bEYHjTp0b5ME3AVk0YuMGGw60/KhELAHHI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=frlJVMVpec64vFDqx5fdB8XDPtgKB/tWL7HRxgIspC73pZxexP3/M6050v9LV+EBR
 5eU27vNdh69Jajt1fmYlyjG84fyrFsk0Gm7ZwrahvHwnuv1CtNkWd3EzOw9EECf/oV
 1f1LdftmcQxuBLZlGi+kMPfJ6hW1CkEF6lvNjKF5ivzHfukwBIB1QPns1GmJAMatjz
 hbXFPCA/0Nh1XVHUTEiCGmPJE0blabPn7rWYC4yPekp4CtWK6UNrC4IGvPWhphzQVV
 P68Zg0VJ9i0SkCm1ec/2B89kk1K9RwlSGc2ENeJz30CxDj2cr15Qnc5MBtyp6+racn
 TFN9SXPp7E7BQ==
X-Pm-Submission-Id: 4gfqgP6Gpyz1DFGT
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@mailbox.org>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rcu@vger.kernel.org
Subject: Re: [PATCH v2 5/6] rust: Add dma_fence abstractions
Date: Tue, 16 Jun 2026 17:51:11 +0300
Message-ID: <20260616145112.14201-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
 <20260616082819.2943886-7-phasta@kernel.org>
 <20260616124755.460550-1-work@onurozkan.dev>
 <d074d3105a2c1d4f594bc6d7b0b09e62757790d5.camel@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 16 Jun 2026 16:38:51 +0200=0D
Philipp Stanner <phasta@mailbox.org> wrote:=0D
=0D
> On Tue, 2026-06-16 at 15:47 +0300, Onur =C3=96zkan wrote:=0D
> > On Tue, 16 Jun 2026 10:28:17 +0200=0D
> > > +=0D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // DriverFenceData is rep=
r(C) and a Fence is its first member.=0D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fence_data_ptr =3D fe=
nce_ptr as *mut DriverFenceData<T>;=0D
> > =0D
> > Either the field ordering on the type or this code is wrong because the=
 first=0D
> > member of DriverFenceData is `rcu_head`.=0D
> =0D
> Yeah, that's a bug introduced in this revision. Thx for pointing it=0D
> out. Already fixed it downstream.=0D
> =0D
> I'm just wondering why my test did not blow up.=0D
> =0D
> > > =0D
> > > +}=0D
> > =0D
> > I am unsure whether it is safe to cast the pointer in Fence::from_raw w=
ithout=0D
> > Fence being #[repr(transparent)] as the layout compatibility is not gua=
ranteed=0D
> > explicitly.=0D
> =0D
> Shouldn't #[repr(C)] do that trick, too? Do you need both?=0D
> =0D
> Who can answer that?=0D
> =0D
> =0D
> P.=0D
=0D
You shouldn't use both and I think it wouldn't compile anyway. repr(C) only=
=0D
makes sense when the type have multiple fields.=0D
=0D
Thanks,=0D
Onur=0D
