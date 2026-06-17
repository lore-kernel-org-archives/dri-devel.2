Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BABCD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E8B10EAF6;
	Wed, 17 Jun 2026 20:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ENEKTVg0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408AF10EAF6
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:19:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E27742B83;
 Wed, 17 Jun 2026 20:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABB1F000E9;
 Wed, 17 Jun 2026 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727586;
 bh=9As5Q88Ydjl2Hl9Edw9RN8AlVHRsHVpLlHaDdwP2qEM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ENEKTVg0gGo/vU5qHbYU1DwN5vTvvwJlqrcynLqlqMKtJkajDpbQGNieo0otx40fh
 LngvLqk+UKuaaujOLDO75fIEyI0kIVnZPkdWn6sVaISZwVnCRTOpYaA72qS9BVmRgw
 78sdI+gE/jZKZ0IC10hN97UOY0/ZTjoZRNd/sDJO8l+Y97IF/OPaqQ/QJlx5BJHTd5
 ly3+zlSLSIJb1GOtHYCr3YIx5MlLtpBFGtd7JYgVj2gpeEhWgcxL6LRbzJn8zz7HIm
 UrUHXVv6r/KQWJHz8fBMlPVnnydWORacT8+nWt2pTBo3/gTAuSB6s6s0V8LJ1G9XEY
 jZFCmta9blfUA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/7] drm/vino: add DDC/CI brightness/contrast, DPMS
 power and DFU info
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260617151249.2937-7-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-7-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:19:44 +0000
Message-Id: <20260617201945.24ABB1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `crtc_atomic_disable` callback executes in an atomic context b=
ut triggers sleeping operations, including `GFP_KERNEL` allocations.
- [High] The `connector_atomic_set_property` directly mutates global hardwa=
re state during the atomic check/assembly phase, violating DRM atomic seman=
tics.
- [Medium] Missing contrast property replay during DPMS-on monitor wake.
--

commit f57a262e5ecdc9d7a9ab4c348f2232b364488d0e
Author: Mike Lothian <mike@fireburn.co.uk>

Add monitor controls that ride the same control plane

This patch adds DDC/CI monitor controls over a custom control plane for
brightness, contrast, and DPMS. It adds connector properties for
brightness and contrast, and hooks into the CRTC disable path for power
off.

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> index afbf883fba36..bcc871958a8a 100644
> --- a/drivers/gpu/drm/vino/drm_sink.rs
> +++ b/drivers/gpu/drm/vino/drm_sink.rs

[ ... ]

> @@ -637,6 +660,11 @@ fn install_edid(connector: *mut bindings::drm_connec=
tor, blob: &[u8]) -> i32 {
>      if let Err(e) =3D data.send_cp(head.index, 0x48, 16, |ctr| super::cp=
::set_mode(ctr, &timing)) {
>          pr_warn!("vino: head{} runtime mode-set send failed ({e:?})\n", =
head.index);
>      }
> +    // Bring the monitor out of DPMS standby (DDC/CI VCP 0xD6 =3D on). I=
nferred wire (see
> +    // `cp::ddc_set_vcp`); a no-op until CP engages, and re-applies the =
user's brightness.
> +    let _ =3D data.set_vcp(head.index, super::cp::VCP_POWER_MODE, super:=
:cp::POWER_ON);
> +    let b =3D head.brightness.load(core::sync::atomic::Ordering::Relaxed=
);
> +    let _ =3D data.set_vcp(head.index, super::cp::VCP_BRIGHTNESS, b as u=
16);

[Severity: Medium]
Does this code omit re-applying the contrast property during the DPMS-on
monitor wake sequence?

The struct documentation for head.contrast states it is replayed on DPMS-on,
but only head.brightness is loaded and re-applied to the monitor here. If
contrast is not restored, the monitor could lose its custom contrast setting
when waking from standby and revert to hardware defaults.

>  }
> =20
>  /// CRTC `.atomic_disable`: the display is turning off.

[ ... ]

> @@ -671,6 +701,10 @@ fn install_edid(connector: *mut bindings::drm_connec=
tor, blob: &[u8]) -> i32 {
>      }
>      head.cursor_primed
>          .store(false, core::sync::atomic::Ordering::SeqCst);
> +    // DPMS-off: blank the monitor backlight via DDC/CI (VCP 0xD6 =3D of=
f) rather than leaving
> +    // the last frame frozen on the panel. Inferred wire (see `cp::ddc_s=
et_vcp`); no-op until
> +    // CP engages.
> +    let _ =3D data.set_vcp(head.index, super::cp::VCP_POWER_MODE, super:=
:cp::POWER_OFF);

[Severity: High]
Does crtc_atomic_disable() execute in an atomic context where sleeping is
forbidden?

This calls data.set_vcp(), which delegates to ddc_set_vcp(). As seen in
cp.rs, ddc_set_vcp() uses sleeping allocations:

cp.rs:ddc_set_vcp() {
    ...
    let mut b =3D KVec::with_capacity(32, GFP_KERNEL)?;
    ...
    b.extend_from_slice(&[0x37, payload.len() as u8], GFP_KERNEL)?;
    ...
}

Allocating memory with GFP_KERNEL in the atomic CRTC disable callback could
lead to a scheduling-while-atomic panic during display modesets.

>      pr_info!("vino: KMS CRTC disable -- head{} display OFF (scanout stop=
ped)\n", head.index);
>  }

[ ... ]

> +unsafe extern "C" fn connector_atomic_set_property(
> +    connector: *mut bindings::drm_connector,
> +    _state: *mut bindings::drm_connector_state,
> +    property: *mut bindings::drm_property,
> +    val: u64,
> +) -> i32 {

[ ... ]

> +    if slot.swap(v, core::sync::atomic::Ordering::Relaxed) !=3D v {
> +        let _ =3D data.set_vcp(head.index, vcp, v as u16);
> +    }
> +    0
> +}

[Severity: High]
Does this directly mutate global hardware state during the atomic check or
assembly phase?

In the DRM atomic architecture, the atomic_set_property callback can be
invoked during state assembly and checking, such as for test-only commits
(DRM_MODE_ATOMIC_TEST_ONLY).

Because data.set_vcp() immediately pushes the DDC/CI write to the monitor
during this phase, a test-only commit will irreversibly modify the live
hardware state, breaking the expectations of userspace compositors relying
on atomic test operations having no side effects.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D6
