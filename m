Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E957606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=oofBiByO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C06610E45E;
	Sat, 14 Nov 2026 05:56:49 +0000 (UTC)
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7571D10E55F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 05:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1794635801; x=1794895001;
 bh=wdOHbQ/vdfQB5bIpXbND37eNnsBADQny4t9uk3ztiDE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=oofBiByOingqHSAuMc07ehzh6lvQ8MrbGi+A85wwwDAV7ZjPbeKROXHRt4W90ucHi
 SOR3nuF1enXYcmYFpH4PijDz/AgoAV4QoHRYhpVr7uAXn6m5nGk2GD8eB1NoWfS5FQ
 YeBD/tw9EPAiApFkJA+UNdpoZZc2Ocr3fRUzkXsj/9hkwUPDjaCItPHIUirxgeQUIq
 zjpaELJCEea5UIsrofKasHViUbFF7tkGXM4LGktwdLplMB/LzQf3YdFjoOSgVGouMp
 Bt7RvxmwfemAbrUQmo1G7r2ZvjWC7yk5DLPLArwxKsEQIWMTL+rGoAn4UHFax7+oN8
 KbQP7AIMs/0gQ==
X-Pm-Submission-Id: 4jRNfv0S7Jz2ScWV
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: sashiko-bot@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	ojeda@kernel.org,
	gary@garyguo.net
Subject: Re: [PATCH v8 2/3] drm/tyr: add GPU reset infrastructure
Date: Sat, 14 Nov 2026 08:56:32 +0300
Message-ID: <20261114055637.545723-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <sashiko-outbox-213013@kernel.org>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
 <sashiko-outbox-213013@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 14:47:34 +0000=0D
sashiko-bot@kernel.org wrote:=0D
=0D
> Thank you for your contribution! Sashiko AI review found 2 potential=0D
> issues to consider:=0D
> - [Medium] drm/tyr: prepared clocks leaked on error in=0D
>   TyrPlatformDriver::probe()=0D
> - [Low] drm/tyr: overly restrictive &'reset self lifetime in=0D
>   ResetHandle::schedule()=0D
> --=0D
> =0D
> commit 2f1b0845121531379549eca9ca27fd1ffc58562f=0D
> Author: Onur =C3=96zkan <work@onurozkan.dev>=0D
> =0D
> drm/tyr: add GPU reset infrastructure=0D
> =0D
> This commit adds GPU reset infrastructure using a dedicated ordered=0D
> workqueue and an SRCU-based hardware access gate, and drains pending=0D
> or running reset work on teardown.=0D
> =0D
> Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28=0D
> =0D
> > diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver=
.rs=0D
> > index 5b57bc9a1d3e7..863c8008a132b 100644=0D
> > --- a/drivers/gpu/drm/tyr/driver.rs=0D
> > +++ b/drivers/gpu/drm/tyr/driver.rs=0D
> [ ... ]=0D
> > @@ -171,8 +153,11 @@ fn probe<'bound>(=0D
> >                  _reg <- unsafe { drm::Registration::new(=0D
> >                      pdev.as_ref(),=0D
> >                      unreg_dev,=0D
> > -                    pin_init!(TyrDrmRegistrationData {=0D
> > +                    try_pin_init!(TyrDrmRegistrationData {=0D
> >                          pdev,=0D
> > +                        // SAFETY: The registration is owned by platfo=
rm driver data,=0D
> > +                        // so reset work is drained before borrowed da=
ta expires.=0D
> > +                        reset <- reset::ResetHandle::new(pdev, iomem.a=
s_arc_borrow())?,=0D
> >                          fw: firmware,=0D
> >                          clks <- new_mutex!(Clocks {=0D
> >                              core: core_clk,=0D
> =0D
> [Severity: Medium]=0D
> Does this leak the prepared and enabled clocks if ResetHandle::new() or=0D
> its PinInit initializer fails?=0D
> =0D
> Drop for Clk and OptionalClk only calls clk_put(), while=0D
> disable_unprepare() is only called in Clocks::drop():=0D
> =0D
> drivers/gpu/drm/tyr/driver.rs:Clocks::drop() {=0D
>     fn drop(&mut self) {=0D
>         self.core.disable_unprepare();=0D
>         self.stacks.disable_unprepare();=0D
>         self.coregroup.disable_unprepare();=0D
>     }=0D
> }=0D
> =0D
> Because TyrDrmRegistrationData now initializes reset via try_pin_init!=0D
> before constructing Clocks, a failure in Queue::build() or HwGate::new()=
=0D
> (as well as earlier error paths after prepare_enable() in probe()) drops=
=0D
> core_clk, stacks_clk, and coregroup_clk without disabling or unpreparing=
=0D
> them, leaving the hardware clocks enabled and triggering a warning in=0D
> clk_put().  Wrapping the clocks in Clocks immediately after=0D
> prepare_enable() would ensure they are cleaned up on all error paths.=0D
=0D
I can fix this by guarding each enabled clock with ScopeGuard but IIUC this=
 will=0D
no longer be necessary once Daniel's Clk series [1] is applied. If we plan =
to=0D
land this soon I can still do it. Otherwise, it's pointless.=0D
=0D
@Daniel thoughts ?=0D
=0D
[1]: https://lore.kernel.org/rust-for-linux/1a1cb87df11.2c57f9fa237371.8441=
35553238709982@collabora.com=0D
=0D
> =0D
> > diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.r=
s=0D
> > new file mode 100644=0D
> > index 0000000000000..640371b3104da=0D
> > --- /dev/null=0D
> > +++ b/drivers/gpu/drm/tyr/reset.rs=0D
> [ ... ]=0D
> > +pub(crate) struct ResetHandle<'reset> {=0D
> > +    #[pin]=0D
> > +    controller: ScopedWork<Controller<'reset>>,=0D
> > +    wq: OwnedQueue,=0D
> > +}=0D
> [ ... ]=0D
> > +    /// Schedules a GPU reset on the dedicated workqueue.=0D
> > +    ///=0D
> > +    /// If a reset is already pending or in progress the call is a no-=
op.=0D
> > +    #[expect(dead_code)]=0D
> > +    pub(crate) fn schedule(&'reset self) {=0D
> > +        // TODO: Similar to `panthor_device_schedule_reset()` in Panth=
or, add a=0D
> > +        // power management check once Tyr supports it.=0D
> > +=0D
> > +        if self=0D
> > +            .controller=0D
> > +            .try_transition(ResetState::Idle, ResetState::Pending)=0D
> > +        {=0D
> > +            let _ =3D self.wq.enqueue_scoped(&self.controller);=0D
> > +        }=0D
> > +    }=0D
> =0D
> [Severity: Low]=0D
> Can ResetHandle::schedule() take &self instead of &'reset self?=0D
> =0D
> ScopedWork wraps its payload in Opaque (UnsafeCell), making=0D
> ResetHandle<'reset> invariant over 'reset, where 'reset is the device=0D
> binding lifetime in TyrDrmRegistrationData<'drm>.  Requiring &'reset self=
=0D
> prevents callers holding a normal short-lived borrow of=0D
> TyrDrmRegistrationData or ResetHandle from calling schedule(), and=0D
> neither try_transition() nor enqueue_scoped() needs the reference to live=
=0D
> for 'reset.=0D
> =0D
> -- =0D
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-tyr-rese=
t-impl-v8-0-2ee298ac9808@onurozkan.dev?part=3D2=0D
