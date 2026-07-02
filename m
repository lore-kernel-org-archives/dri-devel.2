Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A50C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 19:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931A910E4FF;
	Thu,  2 Jul 2026 19:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nfraprado@collabora.com header.b="OeTq6wo4";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B6310E4FF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 19:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783020983; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WduAoKg0XCZIQtLCHJ/8I/fF9TLWvGt5HzfunbE8cjSOpQ0UrfgUs57tl0uuvbclO5T7BCBTXoOJgolnPbfIaV79D8B/jeCLtXwalBMpGncw2KCyEeWYHQccoPOs084B7n+5nl99d3Y3uUsKP89+8DYMkJBFn6Gk5s4d3H3wNhA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783020983;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EtcCMiRuQMnXNZb0ge3XacN5GVBtCdKVPL5Vh14xflA=; 
 b=Y2VTYwJp7X+Uz0jGNgDz6BqAzs24j458JCX/lHTUXkrJqFg7tfgc4ghSoyPsCrrvzncI6C+NChmmVhL4nnoR11DGfRagDY1pj259FnS8RXh+xTARALjbPYgaC1lxy172PsaVRcQarqqxi6TCkDQElEhw4FHkLHYrOzgVLeeTmGg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nfraprado@collabora.com;
 dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783020982; 
 s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=EtcCMiRuQMnXNZb0ge3XacN5GVBtCdKVPL5Vh14xflA=;
 b=OeTq6wo46Y1QCUSae86rHlA7hqedz805B+ZKs7HcyT8IjAlt4U+WQ8iXhuwujaR0
 lnjPyNkHWyrBdkqwxIA8ytg9XRpPLMWR2nFQ+3IadGOxRcus4zAsGWIdE+mQX+2mwY3
 lMjvUGFqz47NuI3OMCyOEGoDUkbWmGwFO64WNNmY=
Received: by mx.zohomail.com with SMTPS id 1783020981505231.81005490114353;
 Thu, 2 Jul 2026 12:36:21 -0700 (PDT)
Message-ID: <7fb9a6661cdab79183fda44330a3e94697d5aa9d.camel@collabora.com>
Subject: Re: [PATCH] drm/amd/display: Always notify the HDA driver on
 connector disconnect
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Thu, 02 Jul 2026 16:36:18 -0300
In-Reply-To: <20260626144456.53EA61F000E9@smtp.kernel.org>
References: <20260626-amdgpu-dm-always-eld-notify-on-disconnect-v1-1-40ce473cd724@collabora.com>
 <20260626144456.53EA61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
X-ZohoMailClient: External
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

On Fri, 2026-06-26 at 14:44 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>=20
> New issues:
> - [High] Audio state is permanently broken upon reconnect if a full
> modeset does not occur.
> - [Low] Spurious ELD notifications with an invalid pin (-1) during
> normal CRTC disable sequence.
>=20
> Pre-existing issues:
> - [Critical] Data race between ELD notification and audio component
> unbind leads to Use-After-Free.
> --
>=20
> commit 0c399aeba0fb63f7bdb4374bcb0fb67d5cd679bb
> Author: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>=20
> drm/amd/display: Always notify the HDA driver on connector disconnect
>=20
> This patch modifies the display detect logic to call
> amdgpu_dm_audio_eld_notify() when a sink is disconnected. This
> ensures the
> HDA driver is notified even if no subsequent atomic commit occurs.
>=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> > index 13c9a9d145baa..c9da19335eacf 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> > @@ -168,7 +168,7 @@ void amdgpu_dm_audio_fini(struct amdgpu_device
> > *adev)
> > =C2=A0}
> > =C2=A0EXPORT_IF_KUNIT(amdgpu_dm_audio_fini);
> > =C2=A0
> > -STATIC_IFN_KUNIT void amdgpu_dm_audio_eld_notify(struct
> > amdgpu_device *adev, int pin)
> > +void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int
> > pin)
> > =C2=A0{
> > =C2=A0	struct drm_audio_component *acomp =3D adev-
> > >dm.audio_component;
> > =C2=A0
>=20
> [Severity: Critical]
> This is a pre-existing issue, but can this lead to a use-after-free
> if the
> HDA module is unloaded concurrently?
>=20
> Looking at amdgpu_dm_audio_eld_notify(), the acomp pointer and its
> audio_ops
> are checked and dereferenced without holding any locks:
>=20
> =C2=A0=C2=A0=C2=A0 if (acomp && acomp->audio_ops && acomp->audio_ops-
> >pin_eld_notify) {
>=20
> Concurrently, if the HDA module is unloaded,
> amdgpu_dm_audio_component_unbind() clears these component fields. If
> the
> notify function is preempted after its check, could it dereference
> the
> freed audio_ops?

As mentioned this is unrelated to this patch.

>=20
> [ ... ]
>=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > index 300ee26f26ff0..9286f86a20cd7 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>=20
> [ ... ]
>=20
> > @@ -601,6 +603,13 @@ void amdgpu_dm_update_connector_after_detect(
> > =C2=A0		/* Set CP to DESIRED if it was ENABLED, so we can
> > re-enable it again on hotplug */
> > =C2=A0		if (connector->state->content_protection =3D=3D
> > DRM_MODE_CONTENT_PROTECTION_ENABLED)
> > =C2=A0			connector->state->content_protection =3D
> > DRM_MODE_CONTENT_PROTECTION_DESIRED;
> > +
> > +		mutex_lock(&adev->dm.audio_lock);
> > +		inst =3D aconnector->audio_inst;
> > +		aconnector->audio_inst =3D -1;
> > +		mutex_unlock(&adev->dm.audio_lock);
> > +		if (inst !=3D -1)
> > +			amdgpu_dm_audio_eld_notify(adev, inst);
>=20
> [Severity: High]
> Does wiping aconnector->audio_inst to -1 on disconnect permanently
> break
> audio upon reconnect if a full modeset does not occur?
>=20
> If a display is reconnected and userspace triggers an atomic commit
> that does
> not require a full modeset (like a fastset), amdgpu_dm_commit_audio()
> skips
> the connector because drm_atomic_crtc_needs_modeset() is false.
>=20
> In that scenario, does audio_inst remain -1, preventing the HDA
> driver from
> ever being notified of the new ELD?

I couldn't find a real use case scenario where this might happen. I
tested turning the display off/on and disconnecting/reconnecting the
HDMI cable on multiple compositors (kwin, mutter, sway, weston,
gamescope) and in all cases a full modeset atomic commit was applied.
The only exception was when disabling the use of the display in the
compositor, but then the audio driver disables the audio devices
anyway, so this wouldn't be an issue.

>=20
> [Severity: Low]
> Also, does setting audio_inst to -1 here cause spurious ELD
> notifications
> with an invalid pin during a normal CRTC disable sequence?
>=20
> If a display is disconnected, audio_inst becomes -1. Later, when a
> modeset
> disables the CRTC, amdgpu_dm_commit_audio() reads the -1 and
> unconditionally
> calls amdgpu_dm_audio_eld_notify() with the invalid pin:
>=20
> amdgpu_dm_commit_audio() {
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 inst =3D aconnector->audio_inst;
> =C2=A0=C2=A0=C2=A0 aconnector->audio_inst =3D -1;
> =C2=A0=C2=A0=C2=A0 mutex_unlock(&adev->dm.audio_lock);
>=20
> =C2=A0=C2=A0=C2=A0 amdgpu_dm_audio_eld_notify(adev, inst);
> }
>=20
> Does this violate the cross-subsystem API by logging a bogus debug
> message
> and passing an invalid index to the HDA driver?

Upon testing it looks like calling amdgpu_dm_audio_eld_notify() with -1
already happens today. Browsing through the code looks like this is
mostly handled as a no-op, except for nvhdmi_port2pin() and
atihdmi_port2pin() which should probably be patched to handle that
case. I can send a separate patch for that.

Thanks,
N=C3=ADcolas

>=20
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	update_subconnector_property(aconnector);
