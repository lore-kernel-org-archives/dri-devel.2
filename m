Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930C5CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0166110E7C3;
	Mon,  1 Jun 2026 13:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="o9S+8kAI";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDE210E7D1
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 13:27:23 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-137d452574cso2984551c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 06:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320442; cv=none;
 d=google.com; s=arc-20240605;
 b=el5WLyeqTq9barI8y9u/tEwGmRH0zFiR9uYcGiq/54nR2Xden4jpuFhdd77marp1Fo
 BA2GreYmgIGUI+8u6wmLPlxzzy/yFsPpHRMMWdJUXxoXb284LfFl4mOt8R3QjFgVi3dy
 84UFU9+6YXpY/vkXGdRJzvjatJgKyBmGX0JaWyUghQtCQSR7scSxbZZvlYWt7rAdwZDx
 gajguKr3rqJKgRjUBkbjcmcMhR8GwGwOPDmah53pv7lR3gFz4ZGN/rBoJ0WrzCb9lneS
 BUbxFvD4OcSvwIhrpGTg7cbhtr+FtDeVP3HjkKKO7nv5Z7VtHiXTLaUfoXHYezzZx/4T
 3W9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ri49UqDlI7T6GkNPLNf+vktr0M6I1uPdwQQUuW9VuW4=;
 fh=C4HuYGBJzWML69NHLo54GI1rRGoorDdZTBZQOvW083M=;
 b=CaVi8AuCRWb5WX3RuAg4ydeLx5jB6VXxu9EXMVZKm22PAZtS7zKfysnUFcY6uNHYXC
 d7cwMHXtHgMG7z4MhJUPKWjdLkODmxCVPdikl99C2j1VSfjLt8OOs6F7TVJR+qWtR8JG
 PL2F9jX9Vju6PFbEYTM/+vzlvrPbsLz6VPxNNp6QRHplYJzlV3WVRjlIdKX7pNghljjt
 Dirog7p9y/AJVpa4L3AhR0+gUgvp9avoNZ7BzpbgIw7Lm6Oed0NBFNCDcyJbw2E3AY7t
 GK4F4okn+2Ilv7CMb/ccCMhiRnqMNE3SReZmXgkROTHxSQqMJOIGYl2Xtcc9iAyJs3CQ
 SHYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780320442; x=1780925242;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri49UqDlI7T6GkNPLNf+vktr0M6I1uPdwQQUuW9VuW4=;
 b=o9S+8kAImEy9Dby2YJHX7Y/HynkCTF+xDHzMr2zctqUc3/7zS/BIbaNpyHeJwCe3mT
 wssXZMBR470Idipui/rSuB2fxexoO0Uyx9ZqbLTMN0U0rH/g28acx5cbuevcwUEjzzBs
 PISrr0khBybKDDGSCcd8Q3bN+4mMPEHaizHbwztGIQaGHXZWplDUdDlgfu43f8J3dHsI
 6MljTyorR5uCzzhJjDGglq/LZ2E8IimPZ+N3Jk90GkQuxQUsktUb9AjJsFdtdndvtySb
 KZWk1x3pap+VBY1OBx45uTpygR5n68ypdr6ex4hD/vW8Lpw8icff8aMAxMZNX7UjgC+x
 a78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320442; x=1780925242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ri49UqDlI7T6GkNPLNf+vktr0M6I1uPdwQQUuW9VuW4=;
 b=aXTTsSnF8lIMV+vW5l4hdjVOy1j7EtXt9A25ZHEgywtHhJcD11chiX6N3VTrOWur+E
 +zBjxLnOVdrKwNHyXYavWVh2kYiSJqeUyPPe/JlLM5c57swztNWjypy9sAhW1FjhPBI2
 WNkmoSizlfY8A8vRdHjx36fcHP0ahfLiyXwojvZIz0gsYrK9F9uEzmv0d/Nhwi1k6QAc
 4LumQ9RFpcj7esPT6vC/4/1SUSVmBHeMJaOImCJe97YRWV0QuyEIqBmk91DX0fSr8zkf
 6ZVWQkOmLiNzx7P/R9oZaMezj91hPvq63tclGF5roCC/j+vfxbVUWvbYtGuOIYREBNrd
 yU7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9V7nK3khUhHjoH3uqcE+Ndzx8SeFRBc6W1rb0/gzIDwkVj2NYDeepfK0rabR3oHBoFNAvf+Pt7y4g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLM2/JMCxmHvA+1yoU6/N+CqJ5WTKazUEdKFG/00pjuwipQ0IJ
 l4/1YXid1o9Va5DCALkEdnBlRqUAkHrVAbA3ZT7JcjJbLntHabSNlrOmw5rnFe7W2tnP8pJgetS
 0MEx3BlcDbsKHGLdlQVdL9cjzKfYO4HiCyFcml71z
X-Gm-Gg: Acq92OE9D5vwpbGZNeRKmXiwfSSC0hl4eqm6RJlyTdTbR/fYS0F9wkbnOQbc/YJUX4P
 nVXPtLbtBgyUXdzsynqwU3l3KHQAEDDyhObp6WedZb89JHGnnbnj9Av0/YLu5fn+qLlrccF1cga
 g1DUd/N+QzG11tdru6EMTfad94bTSDan9CvFQyinyqJSEVdiYoHhbJmL4a+MzJob5YnGus6jRkI
 LKg9iKvH9uEilBtAgem3htmaSPKRoRzDBcIE/Quq6J3eWJ3IiM19apdDKgzdpLMpCiYIXmrPnx4
 LK/11WG0zy3K0xg7C12NA2rG+GrMFVb2Y1NhwMwLqBAJSGg9x+vpzelV92NaNyoDAV3u1EuqxaO
 VR14=
X-Received: by 2002:a05:7300:2201:b0:304:d8cb:8424 with SMTP id
 5a478bee46e88-304fa546886mr4919952eec.9.1780320441610; Mon, 01 Jun 2026
 06:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260530143541.229628-2-phasta@kernel.org>
 <20260530143541.229628-5-phasta@kernel.org>
 <ah1glmXDM-OAKa5h@google.com>
 <0ea6b6fdd1e3f1e07445f17c0bf672524938dc85.camel@mailbox.org>
 <ah19ZVkr7b3m7V_u@google.com>
 <3b216f24afb406b797b8bbb73b3f5c0eec2fdc6c.camel@mailbox.org>
 <CAH5fLgiZb5fqfXGQMicPp+UbBi3JMN8ZNG_Ldt5KiSk+btVCSA@mail.gmail.com>
 <3829028571be1886b99018040782ef94369b9523.camel@mailbox.org>
In-Reply-To: <3829028571be1886b99018040782ef94369b9523.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 1 Jun 2026 15:27:06 +0200
X-Gm-Features: AVHnY4IJXBoMvh-rw5Yz6dkN_FCzB34R7ldudBtNs3IR1XQFjKtmqNv3cEC-Bt4
Message-ID: <CAH5fLggFHp6bLZ-g8aTQKY_sHRJ0aEmB+-2XWG3RMS1yBXO+8A@mail.gmail.com>
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

On Mon, Jun 1, 2026 at 3:24=E2=80=AFPM Philipp Stanner <phasta@mailbox.org>=
 wrote:
>
> On Mon, 2026-06-01 at 15:22 +0200, Alice Ryhl wrote:
> > On Mon, Jun 1, 2026 at 2:47=E2=80=AFPM Philipp Stanner <phasta@mailbox.=
org> wrote:
> > >
> > > On Mon, 2026-06-01 at 12:39 +0000, Alice Ryhl wrote:
> > > > On Mon, Jun 01, 2026 at 02:26:17PM +0200, Philipp Stanner wrote:
> > > > > On Mon, 2026-06-01 at 10:36 +0000, Alice Ryhl wrote:
> > > > > > On Sat, May 30, 2026 at 04:35:11PM +0200, Philipp Stanner wrote=
:
> > > > > > > +/// A trait to enforce that all data in a [`DriverFence`] ei=
ther does not need
> > > > > > > +/// drop, or lives in a [`RcuBox`].
> > > > > > > +pub trait DriverFenceAllowedData: private::Sealed {}
> > > > > > > +
> > > > > > > +mod private {
> > > > > > > +    pub trait Sealed {}
> > > > > > > +}
> > > > > > > +
> > > > > > > +impl<F: Copy> DriverFenceAllowedData for F {}
> > > > > > > +impl<F: Send> DriverFenceAllowedData for RcuBox<F> {}
> > > > > > > +
> > > > > > > +impl<F: Copy> private::Sealed for F {}
> > > > > > > +impl<F: Send> private::Sealed for RcuBox<F> {}
> > > > > >
> > > > > > Why sealed? Just make the trait unsafe and require the things y=
ou
> > > > > > require from the user.
> > > > >
> > > > > This is far better. We definitely only allow the user to pass A o=
r B,
> > > > > and only then it compiles.
> > > >
> > > > What if I have another type that I want to use here? For example, m=
aybe
> > > > I have a struct containing a copy field and an RcuBox. Or maybe I h=
ave
> > > > an ARef<_> of some C type that uses rcu for cleanup. Then I must ed=
it
> > > > this file to add support for it?
> > > >
> > > > > The unsafe implementation could be messed up.
> > > > >
> > > > > I thought that's what Sealed is for. Or isn't it?
> > > >
> > > > Sealed is for making 100% sure that downstream crates/drivers canno=
t
> > > > provide their own implementations. But I don't see why you need tha=
t.
> > > > All you require is that the value remains valid for one grace perio=
d
> > > > after cleanup begins. As long as the type satisfies that, you are h=
appy.
> > > > An unsafe trait can require that sort of requirement from the user.
> > > >
> > > > I think what you want is expressed well by `RcuFreeSafe` from this
> > > > thread:
> > > > https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library=
/topic/Consolidate.20.60PollCondVarBox.60.20into.20.60Rcu.2ABox.60/near/598=
726724
> > > >
> > >
> > > I guess this is a question of design principles. If you demand an
> > > RcuBox, you have a guarantee that it's safe.
> > >
> > > If you demand an unsafe trait, you open the possibility for people
> > > messing up.
> > >
> > > Due to the unsafe-contract you'd have moved the responsibility for th=
e
> > > soundness to the driver.
> > >
> > > I would not want to block your suggestion, but I am not sure whether
> > > that's really the better design idea.
> >
> > Yes, it's a design principle. You are saying that if someone needs to
> > do X but might get it wrong, we should take away the ability to do X?
> > I fundamentally disagree with that principle. Unsafe traits is the
> > tool Rust created for the exact problem you have; marking places where
> > you should be careful is the entire point of 'unsafe'.
>
> I mean, fine by me if the others don't disagree.
>
> But when then do you ever really want a Sealed trait?

Sealed traits are a very niche feature. The main use-case is
forwards-compatibility. It's not a breaking change to add a new method
to a sealed trait because no downstream crates could implement the
trait.

Alice
