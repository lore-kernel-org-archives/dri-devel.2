Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0212C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BDA10F63B;
	Fri, 26 Jun 2026 14:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LN3ftvpA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9825C10F63B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C49E6600C8;
 Fri, 26 Jun 2026 14:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA61F000E9;
 Fri, 26 Jun 2026 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485096;
 bh=8NdCRjtb+kMmjv7SlChjtmFryrTNknCogulu42G3Jq4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LN3ftvpAQgjr0EoxXklCKvh7LTzWHuOtJLFSyHNIdY73+9ZJ7yxizo/Mr+TlO//eb
 ijZVpVwAvmF9LSANYlZF/64zXQ46JJpN802ZH+h9/a5wb9P1Dv8ixl21HpzU1J9WLn
 UylbspKn3+ngm9FImrGvSSOr6aOapRwBNp9DVC03q5i236aj3P7CTzo6oo4sta8eOb
 ue1Oe3Nv5R+6i+qx1VTQE2Kh4njk8SgCz4IC/CkVGXRumu2pNWQpnyNMSImCk9Fwj2
 dDxc9vn7kn+g2YS7aLGiRjYnrVC5aIZuSdT++Qxh2L1OyoIc/tne3ubtfDIegOy71q
 8jswbjJQY2+QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Always notify the HDA driver on
 connector disconnect
To: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-amdgpu-dm-always-eld-notify-on-disconnect-v1-1-40ce473cd724@collabora.com>
References: <20260626-amdgpu-dm-always-eld-notify-on-disconnect-v1-1-40ce473cd724@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:44:55 +0000
Message-Id: <20260626144456.53EA61F000E9@smtp.kernel.org>
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

New issues:
- [High] Audio state is permanently broken upon reconnect if a full modeset=
 does not occur.
- [Low] Spurious ELD notifications with an invalid pin (-1) during normal C=
RTC disable sequence.

Pre-existing issues:
- [Critical] Data race between ELD notification and audio component unbind =
leads to Use-After-Free.
--

commit 0c399aeba0fb63f7bdb4374bcb0fb67d5cd679bb
Author: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

drm/amd/display: Always notify the HDA driver on connector disconnect

This patch modifies the display detect logic to call
amdgpu_dm_audio_eld_notify() when a sink is disconnected. This ensures the
HDA driver is notified even if no subsequent atomic commit occurs.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> index 13c9a9d145baa..c9da19335eacf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
> @@ -168,7 +168,7 @@ void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_audio_fini);
> =20
> -STATIC_IFN_KUNIT void amdgpu_dm_audio_eld_notify(struct amdgpu_device *a=
dev, int pin)
> +void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
>  {
>  	struct drm_audio_component *acomp =3D adev->dm.audio_component;
> =20

[Severity: Critical]
This is a pre-existing issue, but can this lead to a use-after-free if the
HDA module is unloaded concurrently?

Looking at amdgpu_dm_audio_eld_notify(), the acomp pointer and its audio_ops
are checked and dereferenced without holding any locks:

    if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify) {

Concurrently, if the HDA module is unloaded,
amdgpu_dm_audio_component_unbind() clears these component fields. If the
notify function is preempted after its check, could it dereference the
freed audio_ops?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 300ee26f26ff0..9286f86a20cd7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -601,6 +603,13 @@ void amdgpu_dm_update_connector_after_detect(
>  		/* Set CP to DESIRED if it was ENABLED, so we can re-enable it again o=
n hotplug */
>  		if (connector->state->content_protection =3D=3D DRM_MODE_CONTENT_PROTE=
CTION_ENABLED)
>  			connector->state->content_protection =3D DRM_MODE_CONTENT_PROTECTION_=
DESIRED;
> +
> +		mutex_lock(&adev->dm.audio_lock);
> +		inst =3D aconnector->audio_inst;
> +		aconnector->audio_inst =3D -1;
> +		mutex_unlock(&adev->dm.audio_lock);
> +		if (inst !=3D -1)
> +			amdgpu_dm_audio_eld_notify(adev, inst);

[Severity: High]
Does wiping aconnector->audio_inst to -1 on disconnect permanently break
audio upon reconnect if a full modeset does not occur?

If a display is reconnected and userspace triggers an atomic commit that do=
es
not require a full modeset (like a fastset), amdgpu_dm_commit_audio() skips
the connector because drm_atomic_crtc_needs_modeset() is false.

In that scenario, does audio_inst remain -1, preventing the HDA driver from
ever being notified of the new ELD?

[Severity: Low]
Also, does setting audio_inst to -1 here cause spurious ELD notifications
with an invalid pin during a normal CRTC disable sequence?

If a display is disconnected, audio_inst becomes -1. Later, when a modeset
disables the CRTC, amdgpu_dm_commit_audio() reads the -1 and unconditionally
calls amdgpu_dm_audio_eld_notify() with the invalid pin:

amdgpu_dm_commit_audio() {
    ...
    inst =3D aconnector->audio_inst;
    aconnector->audio_inst =3D -1;
    mutex_unlock(&adev->dm.audio_lock);

    amdgpu_dm_audio_eld_notify(adev, inst);
}

Does this violate the cross-subsystem API by logging a bogus debug message
and passing an invalid index to the HDA driver?

>  	}
> =20
>  	update_subconnector_property(aconnector);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-amdgpu-dm-=
always-eld-notify-on-disconnect-v1-1-40ce473cd724@collabora.com?part=3D1
