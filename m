Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF7BC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 201EC10F541;
	Fri, 14 Aug 2026 16:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d2lakXMZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60DB10F541
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:55:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E4F560008;
 Fri, 14 Aug 2026 16:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905321F000E9;
 Fri, 14 Aug 2026 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786726505;
 bh=G7l1auKCNKjVPUgApFFgCCnEVtxb8+vNXCKiXUWt0C4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d2lakXMZHs5K6oteLLExONYLxmVyTQvH/O2r5iRWDUUsBy38OYDtVm4Mt6ngyS37N
 jVVgu8N10fpCV7xSPlmsJjrmyI7DNKRLQrM8mvcLFAEc81V29fh+NdtlLtXVc2R+V+
 0Q8orBXFq4mA84BJcD0nT3uMoPVnT7oSbhwvEhu/co9EORYntp4ynEHuw4cmB3woyH
 r4dSVITN0UXb6xPeR34rSRedswzmkThLdixqaccsONeO6NcXebMwOwd+l4fwAzWnbZ
 X2iIFVc/bdgBxQZbG0w8fO12LN4/s7veHBktriY6CRJ7wASxGGQ5Ka1ooCAMZtVFHB
 lDpxntDdFABcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] drm/amd/display: Add 2.1 FreeSync support for
 AMD VSDB EDID Block
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814164344.3098143-2-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <20260814164344.3098143-2-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:55:05 +0000
Message-Id: <20260814165505.905321F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The VTEM info packet incorrectly overwrites the AMD FreeSync (SPD)=
 info packet in the local `vrr_infopacket` variable, causing the FreeSync m=
etadata to be lost and the VTEM packet to be programmed into the wrong hard=
ware slot.
- [High] Unsafe dereference of the deprecated `new_stream->sink` pointer wi=
thout a NULL check inside a spinlock, risking a kernel panic and system dea=
dlock.
--

--- Patch [1]: [PATCH v4 1/4] drm/amd/display: Add 2.1 FreeSync support for=
 AMD VSDB EDID Block ---
commit ac51682620be921a897de496468475a6c9820661
Author: Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: drm/amd/display: Add 2.1 FreeSync support for AMD VSDB EDID Block

This commit adds HDMI 2.1 FreeSync support by parsing the AMD VSDB for HDMI
FRL signals. It updates the FreeSync capabilities and introduces a function=
 to
build and send the VTEM info packet during the freesync state update.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
[ ... ]
> @@ -229,6 +230,9 @@ void amdgpu_dm_update_freesync_state_on_stream(
>  		&vrr_infopacket,
>  		pack_sdp_v1_3);
> =20
> +	if (new_stream->sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_FRL)

[Severity: High]
Is it possible for new_stream->sink to be NULL here?

Existing KUnit tests like dm_test_update_freesync_state_default_packet()
allocate dummy streams with a NULL sink. Phantom streams or writeback setups
can also have a NULL sink.

Since this check occurs inside the event_lock spinlock, would a NULL sink
cause a kernel panic and a system deadlock? Would it be safer to verify
new_stream->sink is not NULL before dereferencing it, or use the already
available new_stream->signal instead?

> +		mod_build_infopacket_vtem(new_stream, &vrr_params, 0, &vrr_infopacket);

[Severity: High]
Does this overwrite the existing AMD FreeSync metadata stored in
vrr_infopacket?

Looking at the newly added mod_build_infopacket_vtem(), it calls memset()
on the passed infopacket:

drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c:mod_build_inf=
opacket_vtem() {
	memset(infopacket, 0, sizeof(struct dc_info_packet));
	...
}

Since vrr_infopacket was just populated by mod_freesync_build_vrr_infopacke=
t()
immediately before this block, the memset() appears to erase the SPD packet=
.=20

Furthermore, this assigns the VTEM packet to the vrr_infopacket variable,
which is later routed to the SPD hardware slot in set_spd_info_packet().
Should the VTEM packet be stored in new_stream->vtem_infopacket instead to
preserve the FreeSync packet and ensure VTEM is sent in the correct slot?

> +
>  	new_crtc_state->freesync_vrr_info_changed |=3D
>  		(memcmp(&new_crtc_state->vrr_infopacket,
>  			&vrr_infopacket,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814164344.3098=
143-1-jerry.zuo@amd.com?part=3D1
