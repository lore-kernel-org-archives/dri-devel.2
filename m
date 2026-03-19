Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022AF1090221
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F13E10EA06;
	Thu, 19 Mar 2026 12:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NGi2Kb1c";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA91A10EA06
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1773924697; x=1774183897;
 bh=GqKdxHffuSWlXrX74Ie5nvW4sg5ME6U452+cB9VCml8=;
 h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NGi2Kb1cFQustv3/7NhZDcSnEaNO5c71BLUwCUiaIq73vuZ3uh9v8J1ZY5sY3eb0I
 pg05bj6joNqFXVZvdQLwzSPNz5KEgHWEW/mlepcWD6S5l4TQNnm3SIm0vAd0ziRukB
 L2GHA4wOH9PXNR5wS0zjd3jCBC/FnVv3zuFyojlmzBp+RAmnyWlMpdrVs2sKs/eImK
 bqjZl1jhBtfEEsg7CIuGOmAsfcwUL2HxsrsuPOyYp3qTh2mF6JwG+iwFNYXC001UG0
 y5QH5DGvaluQmKZmyaxasnsO3aCjfzeQ88syGzfevpl3smMAUeA8obWaQbDAZfoMKM
 OGTQOt2HOmKWg==
X-Pm-Submission-Id: 4fc5DR6fkJz2ScPc
Date: Thu, 19 Mar 2026 15:51:35 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Deborah
 Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
Message-ID: <20260319155135.18f87a1b@nimda>
In-Reply-To: <20260319120828.52736966@fedora>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev>
 <20260319120828.52736966@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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

Hi Boris,

On Thu, 19 Mar 2026 12:08:28 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Fri, 13 Mar 2026 12:16:44 +0300
> Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> > +impl Controller {
> > +    /// Creates a [`Controller`] instance.
> > +    fn new(pdev: ARef<platform::Device>, iomem:
> > Arc<Devres<IoMem>>) -> Result<Arc<Self>> {
> > +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", 0)?;
> > +
> > +        Arc::pin_init(
> > +            try_pin_init!(Self {
> > +                pdev,
> > +                iomem,
> > +                pending: Atomic::new(false),
> > +                wq,
> > +                work <- kernel::new_work!("tyr::reset"),
> > +            }),
> > +            GFP_KERNEL,
> > +        )
> > +    }
> > +
> > +    /// Processes one scheduled reset request.
> > +    ///
> > +    /// Panthor reference:
> > +    /// -
> > drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
> > +    fn reset_work(self: &Arc<Self>) {
> > +        dev_info!(self.pdev.as_ref(), "GPU reset work is
> > started.\n"); +
> > +        // SAFETY: `Controller` is part of driver-private data and
> > only exists
> > +        // while the platform device is bound.
> > +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };
> > +        if let Err(e) =3D run_reset(pdev, &self.iomem) {
> > +            dev_err!(self.pdev.as_ref(), "GPU reset failed:
> > {:?}\n", e);
> > +        } else {
> > +            dev_info!(self.pdev.as_ref(), "GPU reset work is
> > done.\n");
> > +        }
>=20
> Unfortunately, the reset operation is not as simple as instructing the
> GPU to reset, it's a complex synchronization process where you need to
> try to gracefully put various components on hold before you reset, and
> then resume those after the reset is effective. Of course, with what
> we currently have in-tree, there's not much to suspend/resume, but I
> think I'd prefer to design the thing so we can progressively add more
> components without changing the reset logic too much.
>=20
> I would probably start with a Resettable trait that has the
> {pre,post}_reset() methods that exist in Panthor.

Yeah, I checked Panthor and it has these functions for the reset logic.
I will implement that in v2 and will dig further to see if there is
anything else to cover in regards to proper syncing.

>=20
> The other thing we need is a way for those components to know when a
> reset is about to happen so they can postpone some actions they were
> planning in order to not further delay the reset, or end up with
> actions that fail because the HW is already unusable. Not too sure how
> we want to handle that though. Panthor is currently sprinkled with
> panthor_device_reset_is_pending() calls in key places, but that's
> still very manual, maybe we can automate that a bit more in Tyr,
> dunno.
>

Hmm, sounds like a perfect guard use-case. Is it possible to require
users to access the hw behind a guard (e.g., try_access_hw())? We would
then check if a reset is in progress and hold the user or return an
error until the reset is complete.

Thanks,
Onur

> > +
> > +        self.pending.store(false, Release);
> > +    }
> > +}

