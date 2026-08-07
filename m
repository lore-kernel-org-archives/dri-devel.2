Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A79BC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFD610F520;
	Fri,  7 Aug 2026 15:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JTDkqHSc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B270F10F520
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:23:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8C7D600BB;
 Fri,  7 Aug 2026 15:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457611F00A3E;
 Fri,  7 Aug 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786116181;
 bh=fL6h4iTH7w2q9naCxrMaDloXmEmafRSyN9GsTCBta6E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JTDkqHScmkNnichXcB89DAMad4nIqozokbKSpEXXBX1UEULNqVT79jT+pA0c5vOMr
 3OnrLRjCLBDfntP45A0dOacTxm5Tj83RrwqOLBWCmAqi1NkkD1nQi/0GXvWaDFk/3x
 9k0kSeEyGNNVI0Xtg5t9f+aMpdkUrodktzODBuQIUr1KxhboQCABhraB9ZU2N4NcTe
 3zb5nL//UzLV07TSaXcmfCyNwfRUWePnwV046EsvmBx6h5swVE/uv9WM5hE3ZIWurT
 gCfREkzxKwNxy5DNLGEFzrDTnWahRJ0qdSbpe7ryVqeF+N8cLcq3oKUkgtJzq3hBCw
 dfro0RL0wlt6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 amdgpu_dm_crtc_set_vblank()
To: "Samuel Pitoiset" <samuel.pitoiset@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
References: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:23:00 +0000
Message-Id: <20260807152301.457611F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `crtc->state` in the vblank enable hook can lea=
d to a Use-After-Free of the state and stream objects.
--

--- Patch [1]: [PATCH] drm/amd/display: Fix NULL pointer dereference in amd=
gpu_dm_crtc_set_vblank() ---
commit 22682e17c05c1df8dcb5140d5111a3b728f76c8e
Author: Samuel Pitoiset <samuel.pitoiset@gmail.com>
Subject: drm/amd/display: Fix NULL pointer dereference in amdgpu_dm_crtc_se=
t_vblank()

This commit adds a check to ensure acrtc_state->stream is non-NULL before
dereferencing it in the vblank enable path, fixing a crash when vblank is
queried early.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 46d85457c77b9..62eac6e65334b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -268,7 +268,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct dr=
m_crtc *crtc, bool enable)
> =20
>  	irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
> =20
> -	if (enable) {
> +	if (enable && acrtc_state->stream) {
>  		struct dc *dc =3D adev->dm.dc;
>  		struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
>  		struct psr_settings *psr =3D &acrtc_state->stream->link->psr_settings;

[Severity: High]
This is a pre-existing issue, but could this lockless access to crtc->state
lead to a use-after-free of the state and stream objects?

The enable_vblank hook (amdgpu_dm_crtc_set_vblank) is reached through the i=
octl
path where only vbl_lock is held, not crtc->mutex:

drm_crtc_get_sequence_ioctl()
  drm_vblank_get()
    amdgpu_dm_crtc_set_vblank()

Concurrently, a non-blocking atomic commit can swap crtc->state and free the
old state asynchronously.

If the hook is preempted or delayed, the old state could be freed before
dereferencing acrtc_state->stream here.

Could this also cause the dc_stream_retain(acrtc_state->stream) call further
down in this function to corrupt memory by incrementing the refcount of a
freed object?

>  		struct replay_settings *pr =3D &acrtc_state->stream->link->replay_sett=
ings;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807145855.8347=
9-1-samuel.pitoiset@gmail.com?part=3D1
