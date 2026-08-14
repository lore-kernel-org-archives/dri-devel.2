Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBCAC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B955510F6AB;
	Fri, 14 Aug 2026 17:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O4Ka6JCQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8B810F6AE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 17:01:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5385560120;
 Fri, 14 Aug 2026 17:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF33C1F000E9;
 Fri, 14 Aug 2026 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786726895;
 bh=guktap9pMdSUxhozhTzQB9mI/xYVS/XUW2VwQdET/Po=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O4Ka6JCQtAKLQ87275oEOZXOsxNl9QtRgUmdotkPWy+05ZS1JAWkbFzJWqDStPsNp
 sS24T9BAkqM2hlmI9sWNxRSOSv7IJLIkJxG1gqSK//5os5XhHRbQxWHl305fKMuzad
 CjXtDER9RKgcc+GC2krt7YmkcZRlvcMOWJAlhtByG3hU3qd3LJXxMosTwZtYOQ8/S+
 Pj2LGdjfKwQf3fyNnz9GXvdUOTRstQn4mQBAc2L+OzBxmFBEzH68av4GcMKC5m5i5K
 zJGqCGVAlYDqeTFbiIjOHS9va3ZOnkreX5GfLk7lEmzM6S9EQjHduvIXP6eHMTBXcM
 h2BAJyAShjCUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] drm/amd/display: Enable HDMI ALLM for Gaming-VRR
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814164344.3098143-5-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <20260814164344.3098143-5-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 17:01:34 +0000
Message-Id: <20260814170134.DF33C1F000E9@smtp.kernel.org>
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
- [High] Overloading `vsp_infopacket` with the HDMI Forum VSIF (HF-VSIF) ov=
erwrites the standard HDMI 1.4 VSIF, silently dropping the HDMI VIC require=
d for certain modes.
--

--- Patch [4]: [PATCH v4 4/4] drm/amd/display: Enable HDMI ALLM for Gaming-=
VRR ---
commit d9e1d834d57e6ab1f6bb6abbfa9007cc7a9851fc
Author: Fangzhi Zuo <jerry.zuo@amd.com>

drm/amd/display: Enable HDMI ALLM for Gaming-VRR

This commit enables Auto Low-Latency Mode (ALLM) by setting ALLM_Mode=3D1
in the HF-VSIF when Gaming-VRR is active. It transmits the updated HF-VSIF
as a stream update when the sink advertises ALLM support.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4029,9 +4029,12 @@ static void amdgpu_dm_commit_planes(struct drm_ato=
mic_commit *state,
>  		}
> =20
>  		if (acrtc_state->stream) {
> -			if (acrtc_state->freesync_vrr_info_changed)
> +			if (acrtc_state->freesync_vrr_info_changed) {
>  				bundle->stream_update.vrr_infopacket =3D
>  					&acrtc_state->stream->vrr_infopacket;
> +				bundle->stream_update.vsp_infopacket =3D
> +					&acrtc_state->stream->vsp_infopacket;

[Severity: High]
Does updating the stream using vsp_infopacket drop the standard HDMI Vendor
Specific InfoFrame (VSIF)?

The dc_stream_state structure has a separate hfvsif_infopacket member that
might be intended for the HF-VSIF payload instead of overloading the
vsp_infopacket.

> +			}
>  		}
>  	}
> =20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c

[ ... ]

> +	if (new_stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    new_stream->signal =3D=3D SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_info_packet vsp_infopacket =3D {0};
> +		bool sink_allm =3D aconn && aconn->base.display_info.hdmi.allm;
> +		bool allm =3D sink_allm &&
> +			(vrr_params.state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||
> +			 vrr_params.state =3D=3D VRR_STATE_ACTIVE_FIXED);
> +		bool allm_changed;
> +
> +		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
> +
> +		allm_changed =3D memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
> +				      sizeof(vsp_infopacket)) !=3D 0;
> +		new_crtc_state->freesync_vrr_info_changed |=3D allm_changed;
> +		new_stream->vsp_infopacket =3D vsp_infopacket;

[Severity: High]
Does storing the HF-VSIF inside the vsp_infopacket slot overwrite the
standard HDMI 1.4 VSIF?

When ALLM is active, this assignment appears to silently overwrite the VSIF
designated for HDMI 1.4, which can result in the display losing format
information like the hdmi_vic required for certain modes.

Looking at resource_build_info_frame() in dc_resource.c, the hardware
explicitly supports transmitting both the standard VSIF and the HF-VSIF
simultaneously via separate slots:

dc/core/dc_resource.c:resource_build_info_frame() {
    ...
    set_vendor_info_packet(&info->vendor, pipe_ctx->stream);
    set_hfvs_info_packet(&info->hfvsif, pipe_ctx->stream);
    ...
}

Should this code instead populate the hfvsif_infopacket member of new_strea=
m?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814164344.3098=
143-1-jerry.zuo@amd.com?part=3D4
