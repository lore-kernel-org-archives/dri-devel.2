Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF10CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99C811333E;
	Mon,  1 Jun 2026 13:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="N0Cc6PvL";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C53A11333E
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 13:22:19 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304ffa40c5dso5135598eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 06:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320139; cv=none;
 d=google.com; s=arc-20240605;
 b=FCbn8KO9UnXR/dJ/PxAPNQz32M7ddFtm9JMYmQDXHhe2h0RdqoONAcgFcSqy2sn87o
 XhjyW394GfwJgN0fwPS6rlBFGOXelyarNXPCcICxSM0Zhn82MtJyEhn7YS+rsiopZLNt
 V5ej2ufwGvF2JYPwpc3X3mOfwgrYZ7XPrgtNfpZ1xVveej6Arl8JviZEXxXwlR7S2VKS
 XP5t5nku1kRyb4VT+FxU42E0ViW7soBAip12XM3EOCHGH9yZxsM8iN63/E/lOXsTFtaV
 aE/FLtwVV6XhmnWyrxD2yFNG8SCa1Cs0ep6RTEaQSeSzgnI33vcaBwexYwboJnQiQEDZ
 8mRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GdkOBdEWo+k8nIccYq3ePCwKTGzhNT9vQ5Dk5zhGNHg=;
 fh=CsZ5HJsK7j3SIVvRwQKRAvpsTCgPOBF2rZX6sqqyW9U=;
 b=DpqN9vseljb41arOaILcAxZLsCd3WsMUKjeJGtiFrN1YJiYFe9fnPAqSpjm5yGOoC4
 smH8qZ4iAo8wthxdqJTTqhqtVBb7VO4r5FQNaOc+fogwiIWy+U23TtLosLJqHDyu7NoF
 v2H7aW/aCnk670HQogoH/3hisRJLlbuz1yl4zUr6gvJ75zVSSo4w74ewB9DQRpHSHR1+
 9mDxFMTJ3QUowRZVmcRJZknoo5W+Pj7Oh5gyNvoKU9bAvSh5s3nyC/0/mQyBu/ue1S3I
 wFANP4MAYOKhYkfvN+XmNBieFaiZogd6XYK5jN06h2ddwIJPQCY6j5qLCMQ8Tt8H+5NI
 cfGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780320139; x=1780924939;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdkOBdEWo+k8nIccYq3ePCwKTGzhNT9vQ5Dk5zhGNHg=;
 b=N0Cc6PvLyso+9tp8fpcg5kcL6RGfHRG0wtwIT8fx9y84jdB9lOWAampI76e30hg46v
 gcPUz2BHxMLUQRyuBmgSVHBcTOBwp3AVxtGG98YUT68YV1LK0jIbTDLe73GcLgAFMtL6
 EGHQtgYFz8UJ3jaTPwTuYmK8kN5HuvxtwcqydddPKGINQlcYKTCkSJ/U7//IkEDuWov3
 CXHwIGh2vhMs9YMO+n59mDqfBrYBMM51X7wIRVBo5xO53r2gOAwN83MxehxhFnsohj7H
 7Q0Dpbe/VR4urIlDrPo1GEoQB4qAavZwZ/bi2MQTp7AOAlpSIDC0kHduYZ1vtIS7+Yi5
 q6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320139; x=1780924939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GdkOBdEWo+k8nIccYq3ePCwKTGzhNT9vQ5Dk5zhGNHg=;
 b=lbdxBVoPAL8M7BmF5TJqX7LDeA6Fwq+bZtXwFCG8sXdEZryze+vCItHrb49pH93zZ8
 2Xz9A9HMg70pNcGfIeXRyB5fEf1icTDTL35o2AFDlyQmM3suvRaPT6BDDGChkYI44wn0
 KSuwMVfr5GMInDjAFfX5Wh3iHQJkeg74ENgTNeGkWwkmEVzB7c/cdO31IPvtr4GE9GU3
 OTGLhHGVeMD1BsWay/x3p1SBAoZd8q/WvBsj2rqnSGu0lFw+3FTQWOHj1CMW46iRzMZq
 vdfRm2hXRJrcGU/CoEu32GlBjCyZP9sQBJToEoYD68ip3jf2k3BX8S45Exfep4tMU+gf
 kK+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YU84ZaqHMWyqpYtZdwRsGlByspnE7zivBzvCb9kLp9Sn34+eUIUhnZyIrepsvXysPSq2YW2s6BLA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzN5MFJOgvJE6bvzJFBrNenYm76i+0n7G2p3Ba4hslI78Un0bif
 ZcGvojBOs2FM4P0zC/i1iYU8MVleRuV5Rj/jGLoReSgSTXB/Zw2013MpUHBT01HHG4eCvGGLeR5
 ylFve7ZD1VuwUuUwLKXYEe3iJWV87HpUq05Z7u13d
X-Gm-Gg: Acq92OE2ldGjqSqYDK/lMh2JcXxhilXAX42tQuxXFW1ild1sxZurysUMWbiPRC6hcsV
 r6n8oVC3YzTz8Z1Sf2lWbHHVuGlywZof7SMLTxyBWSod6V3BGiwJW6sWccsm8Ca8vpfOHMVOPS9
 bwSCKUEENCWoLtc0Gp79JDKQVoOyUWuJNe5P46MQJ5x8L/koDv5nQ9/H4/q96a15hh9IOmWTU2f
 NiqS5zo7NsINmR2pn8Mk3QZ9a7VrM18gKBlx60uzlRSVJkyInZUXZT2E2yvCXxw7fTaUyKSISoX
 XeS85OTw+35K0oUM9WqnA1b5nvhBxGs8sdwI6+tWauxUEtdbeu29+2vErMRVyoCL8C5dJ5nzMzB
 qv/U=
X-Received: by 2002:a05:693c:2c86:b0:2de:cc07:e99 with SMTP id
 5a478bee46e88-304fa49ce00mr5489017eec.7.1780320137881; Mon, 01 Jun 2026
 06:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com>
 <0ea6b6fdd1e3f1e07445f17c0bf672524938dc85.camel@mailbox.org>
 <ah19ZVkr7b3m7V_u@google.com>
 <3b216f24afb406b797b8bbb73b3f5c0eec2fdc6c.camel@mailbox.org>
In-Reply-To: <3b216f24afb406b797b8bbb73b3f5c0eec2fdc6c.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Jun 2026 15:22:02 +0200
X-Gm-Features: AVHnY4LWfDXXY2MTx1DqLyh8Hxwl3ZS8C8Evk9p1Nisz1mt4W-Tdk9DBxhQXUfk
Message-ID: <CAH5fLgiZb5fqfXGQMicPp+UbBi3JMN8ZNG_Ldt5KiSk+btVCSA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rust: Add dma_fence abstractions
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
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

On Mon, Jun 1, 2026 at 2:47=E2=80=AFPM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>
> On Mon, 2026-06-01 at 12:39 +0000, Alice Ryhl wrote:
> > On Mon, Jun 01, 2026 at 02:26:17PM +0200, Philipp Stanner wrote:
> > > On Mon, 2026-06-01 at 10:36 +0000, Alice Ryhl wrote:
> > > > On Sat, May 30, 2026 at 04:35:11PM +0200, Philipp Stanner wrote:
> > > > > +/// A trait to enforce that all data in a [`DriverFence`] either=
 does not need
> > > > > +/// drop, or lives in a [`RcuBox`].
> > > > > +pub trait DriverFenceAllowedData: private::Sealed {}
> > > > > +
> > > > > +mod private {
> > > > > +    pub trait Sealed {}
> > > > > +}
> > > > > +
> > > > > +impl<F: Copy> DriverFenceAllowedData for F {}
> > > > > +impl<F: Send> DriverFenceAllowedData for RcuBox<F> {}
> > > > > +
> > > > > +impl<F: Copy> private::Sealed for F {}
> > > > > +impl<F: Send> private::Sealed for RcuBox<F> {}
> > > >
> > > > Why sealed? Just make the trait unsafe and require the things you
> > > > require from the user.
> > >
> > > This is far better. We definitely only allow the user to pass A or B,
> > > and only then it compiles.
> >
> > What if I have another type that I want to use here? For example, maybe
> > I have a struct containing a copy field and an RcuBox. Or maybe I have
> > an ARef<_> of some C type that uses rcu for cleanup. Then I must edit
> > this file to add support for it?
> >
> > > The unsafe implementation could be messed up.
> > >
> > > I thought that's what Sealed is for. Or isn't it?
> >
> > Sealed is for making 100% sure that downstream crates/drivers cannot
> > provide their own implementations. But I don't see why you need that.
> > All you require is that the value remains valid for one grace period
> > after cleanup begins. As long as the type satisfies that, you are happy=
.
> > An unsafe trait can require that sort of requirement from the user.
> >
> > I think what you want is expressed well by `RcuFreeSafe` from this
> > thread:
> > https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library/top=
ic/Consolidate.20.60PollCondVarBox.60.20into.20.60Rcu.2ABox.60/near/5987267=
24
> >
>
> I guess this is a question of design principles. If you demand an
> RcuBox, you have a guarantee that it's safe.
>
> If you demand an unsafe trait, you open the possibility for people
> messing up.
>
> Due to the unsafe-contract you'd have moved the responsibility for the
> soundness to the driver.
>
> I would not want to block your suggestion, but I am not sure whether
> that's really the better design idea.

Yes, it's a design principle. You are saying that if someone needs to
do X but might get it wrong, we should take away the ability to do X?
I fundamentally disagree with that principle. Unsafe traits is the
tool Rust created for the exact problem you have; marking places where
you should be careful is the entire point of 'unsafe'.

Alice
