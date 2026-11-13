Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22315606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Odgo7Y4Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5852D10E809;
	Fri, 13 Nov 2026 14:47:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F63A10E809
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:47:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F16B62775;
 Fri, 13 Nov 2026 14:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256BA1F000C4;
 Fri, 13 Nov 2026 14:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794581255;
 bh=ao6/E3jfgyB7sb03quf1SESl2mhcXqQfhsMnxbaW/+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Odgo7Y4ZFpXA75Y1d2YsHoP50+5zaiXGFTwUeYTiVv0Bk+K0KHpYCeWsrzoPOA6wC
 pY28Qp4jyQ34HP7sQqSgBehdAVQwmta1Tjd2sl9IL2uOket8r0nLe1JB+Zyn2Cirk4
 NR/YlUUXQw9k1G4DtRyaEAp32nt4qRx5YzO1r8Pp2Vcx9+Iv5M+Z3ueSYEx85L97YZ
 Oiooyt/G5nxeAvHI7MSi2MbvsfynoB6W2pVmreBfX2IrhzQDQn7pLUk9G3N7yol6sL
 jukU2yi6GlQBV76UMWc5lQ4RpcgnCbqKoIzTCOfu3TQZZyst/Es9BeEfmU5UrKBSlh
 YFsucJ5OgEh3w==
Message-ID: <sashiko-outbox-213013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] drm/tyr: add GPU reset infrastructure
To: =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
 <20261113-tyr-reset-impl-v8-2-2ee298ac9808@onurozkan.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:47:34 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/tyr: prepared clocks leaked on error in
  TyrPlatformDriver::probe()
- [Low] drm/tyr: overly restrictive &'reset self lifetime in
  ResetHandle::schedule()
--

commit 2f1b0845121531379549eca9ca27fd1ffc58562f
Author: Onur =C3=96zkan <work@onurozkan.dev>

drm/tyr: add GPU reset infrastructure

This commit adds GPU reset infrastructure using a dedicated ordered
workqueue and an SRCU-based hardware access gate, and drains pending
or running reset work on teardown.

Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 5b57bc9a1d3e7..863c8008a132b 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
[ ... ]
> @@ -171,8 +153,11 @@ fn probe<'bound>(
>                  _reg <- unsafe { drm::Registration::new(
>                      pdev.as_ref(),
>                      unreg_dev,
> -                    pin_init!(TyrDrmRegistrationData {
> +                    try_pin_init!(TyrDrmRegistrationData {
>                          pdev,
> +                        // SAFETY: The registration is owned by platform=
 driver data,
> +                        // so reset work is drained before borrowed data=
 expires.
> +                        reset <- reset::ResetHandle::new(pdev, iomem.as_=
arc_borrow())?,
>                          fw: firmware,
>                          clks <- new_mutex!(Clocks {
>                              core: core_clk,

[Severity: Medium]
Does this leak the prepared and enabled clocks if ResetHandle::new() or
its PinInit initializer fails?

Drop for Clk and OptionalClk only calls clk_put(), while
disable_unprepare() is only called in Clocks::drop():

drivers/gpu/drm/tyr/driver.rs:Clocks::drop() {
    fn drop(&mut self) {
        self.core.disable_unprepare();
        self.stacks.disable_unprepare();
        self.coregroup.disable_unprepare();
    }
}

Because TyrDrmRegistrationData now initializes reset via try_pin_init!
before constructing Clocks, a failure in Queue::build() or HwGate::new()
(as well as earlier error paths after prepare_enable() in probe()) drops
core_clk, stacks_clk, and coregroup_clk without disabling or unpreparing
them, leaving the hardware clocks enabled and triggering a warning in
clk_put().  Wrapping the clocks in Clocks immediately after
prepare_enable() would ensure they are cleaned up on all error paths.

> diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.rs
> new file mode 100644
> index 0000000000000..640371b3104da
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/reset.rs
[ ... ]
> +pub(crate) struct ResetHandle<'reset> {
> +    #[pin]
> +    controller: ScopedWork<Controller<'reset>>,
> +    wq: OwnedQueue,
> +}
[ ... ]
> +    /// Schedules a GPU reset on the dedicated workqueue.
> +    ///
> +    /// If a reset is already pending or in progress the call is a no-op.
> +    #[expect(dead_code)]
> +    pub(crate) fn schedule(&'reset self) {
> +        // TODO: Similar to `panthor_device_schedule_reset()` in Panthor=
, add a
> +        // power management check once Tyr supports it.
> +
> +        if self
> +            .controller
> +            .try_transition(ResetState::Idle, ResetState::Pending)
> +        {
> +            let _ =3D self.wq.enqueue_scoped(&self.controller);
> +        }
> +    }

[Severity: Low]
Can ResetHandle::schedule() take &self instead of &'reset self?

ScopedWork wraps its payload in Opaque (UnsafeCell), making
ResetHandle<'reset> invariant over 'reset, where 'reset is the device
binding lifetime in TyrDrmRegistrationData<'drm>.  Requiring &'reset self
prevents callers holding a normal short-lived borrow of
TyrDrmRegistrationData or ResetHandle from calling schedule(), and
neither try_transition() nor enqueue_scoped() needs the reference to live
for 'reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-tyr-reset-=
impl-v8-0-2ee298ac9808@onurozkan.dev?part=3D2
