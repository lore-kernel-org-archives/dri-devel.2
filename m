Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A4EA3C4E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C9810E805;
	Thu,  9 Apr 2026 11:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="nLFRixz6";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD24B10E805
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1775734898; x=1775994098;
 bh=efqPVMGczIcJl1rkfcg+l9ERgPe/gpA/6pX11p/gGCc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nLFRixz6FhLjek7w/EQxoVKY3RZK8Bl0Y448TUq5vCnmvc8Yq3UWYYRrVe4coOLaS
 cM78SdI4YPnYxqRXGDkE6rOUskMFJED2wK8BvNiFZFEmGNNSFKSDbV6Zj8CiLYRyHk
 cksWURtSIXiYyd4FXBgGXt+8O/Dig+OgtO0z919UwcD19xU63CzU1dT/AZkYQxfUsn
 Kvh7DGpi4H0oRS3BlJ4GVlrfDhsD3fd64dsqqcZkTYYjyvcW7uP1Ace7UyGF455n2F
 MGoEn6dObzTK4lYw0DQyo36x9K3fbeCe4FDydGCrjbO3uIKxgpT5G09FJ40jlqgfhu
 Nk4LzET2uTruQ==
X-Pm-Submission-Id: 4fryh02sHXz1DDLV
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
Date: Thu,  9 Apr 2026 14:41:32 +0300
Message-ID: <20260409114133.43134-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
References: <20260313091646.16938-1-work@onurozkan.dev>
 <20260313091646.16938-5-work@onurozkan.dev> <20260319120828.52736966@fedora>
 <9876893D-F3B4-4CA4-8858-473B6FB8E7EB@collabora.com>
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

On Fri, 03 Apr 2026 12:01:09 -0300=0D
Daniel Almeida <daniel.almeida@collabora.com> wrote:=0D
=0D
> =0D
> =0D
> > On 19 Mar 2026, at 08:08, Boris Brezillon <boris.brezillon@collabora.co=
m> wrote:=0D
> > =0D
> > On Fri, 13 Mar 2026 12:16:44 +0300=0D
> > Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > =0D
> >> +impl Controller {=0D
> >> +    /// Creates a [`Controller`] instance.=0D
> >> +    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) -=
> Result<Arc<Self>> {=0D
> >> +        let wq =3D workqueue::OrderedQueue::new(c"tyr-reset-wq", 0)?;=
=0D
> >> +=0D
> >> +        Arc::pin_init(=0D
> >> +            try_pin_init!(Self {=0D
> >> +                pdev,=0D
> >> +                iomem,=0D
> >> +                pending: Atomic::new(false),=0D
> >> +                wq,=0D
> >> +                work <- kernel::new_work!("tyr::reset"),=0D
> >> +            }),=0D
> >> +            GFP_KERNEL,=0D
> >> +        )=0D
> >> +    }=0D
> >> +=0D
> >> +    /// Processes one scheduled reset request.=0D
> >> +    ///=0D
> >> +    /// Panthor reference:=0D
> >> +    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_re=
set_work()=0D
> >> +    fn reset_work(self: &Arc<Self>) {=0D
> >> +        dev_info!(self.pdev.as_ref(), "GPU reset work is started.\n")=
;=0D
> >> +=0D
> >> +        // SAFETY: `Controller` is part of driver-private data and on=
ly exists=0D
> >> +        // while the platform device is bound.=0D
> >> +        let pdev =3D unsafe { self.pdev.as_ref().as_bound() };=0D
> >> +        if let Err(e) =3D run_reset(pdev, &self.iomem) {=0D
> >> +            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n", =
e);=0D
> >> +        } else {=0D
> >> +            dev_info!(self.pdev.as_ref(), "GPU reset work is done.\n"=
);=0D
> >> +        }=0D
> > =0D
> > Unfortunately, the reset operation is not as simple as instructing the=
=0D
> > GPU to reset, it's a complex synchronization process where you need to=
=0D
> > try to gracefully put various components on hold before you reset, and=
=0D
> > then resume those after the reset is effective. Of course, with what we=
=0D
> > currently have in-tree, there's not much to suspend/resume, but I think=
=0D
> > I'd prefer to design the thing so we can progressively add more=0D
> > components without changing the reset logic too much.=0D
> > =0D
> > I would probably start with a Resettable trait that has the=0D
> > {pre,post}_reset() methods that exist in Panthor.=0D
> > =0D
> > The other thing we need is a way for those components to know when a=0D
> > reset is about to happen so they can postpone some actions they were=0D
> > planning in order to not further delay the reset, or end up with=0D
> > actions that fail because the HW is already unusable. Not too sure how=
=0D
> > we want to handle that though. Panthor is currently sprinkled with=0D
> > panthor_device_reset_is_pending() calls in key places, but that's still=
=0D
> > very manual, maybe we can automate that a bit more in Tyr, dunno.=0D
> > =0D
> =0D
> =0D
> We could have an enum where one of the variants is Resetting, and the oth=
er one=0D
> gives access to whatever state is not accessible while resets are in prog=
ress.=0D
> =0D
> Something like=0D
> =0D
> pub enum TyrData {=0D
>   Active(ActiveTyrData),=0D
>   ResetInProgress(ActiveTyrData)=0D
> }=0D
> =0D
> fn access() -> Option<&ActiveTyrData> {=0D
>   =E2=80=A6 // if the =E2=80=9CResetInProgress=E2=80=9D variant is active=
, return None=0D
> }=0D
> =0D
=0D
That's an interesting approach, but if it's all about `fn access` function,=
 we=0D
can already do that with a simple atomic state e.g.,:=0D
=0D
	// The state flag in reset::Controller=0D
	state: Atomic<ResetState>=0D
=0D
	fn access(&self) -> Option<&Arc<Devres<IoMem>>> {=0D
		match self.state.load(Relaxed) {=0D
			ResetState::Idle =3D> Some(&self.iomem),=0D
			_ =3D> None,=0D
		}=0D
	}=0D
=0D
What do you think? Would this be sufficient?=0D
=0D
Btw, a sample code snippet from the caller side would be very helpful for=0D
designing this further. That part is kind a blurry for me.=0D
=0D
Thanks,=0D
Onur=0D
=0D
> =0D
> >> +=0D
> >> +        self.pending.store(false, Release);=0D
> >> +    }=0D
> >> +}=0D
> =0D
