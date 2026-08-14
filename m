Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4BFC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB5210F6A5;
	Fri, 14 Aug 2026 16:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLT/dFSo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0527F10F6A5
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:55:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F59C402D3;
 Fri, 14 Aug 2026 16:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4864C1F00A3F;
 Fri, 14 Aug 2026 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786726521;
 bh=bRShyHY6w3caeXzLVH632K1d5O7SWTeIyB++6kncZqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OLT/dFSotzVZCRCda0ZbYgkrUnrrp0nhKLENQUWzGx+AXNe8vSl3W4LW79gV95p0C
 JVPdQfLT0uy1NT3jNd2mFrNgWyBDFq/FecJpvy+zAuUoNKMNfFJNiZNSF00JNpApXr
 ydlm3487KVUGOrsC+iWcwg01ZMWvEXBgWyJubgEiFRuazF2cwZJyoE97B5igiqqia3
 1is+DSyh1CfdRw2RXMU1slTFlT0XmLPcl8WjEtFs74GVg8rxqVCvz0Y/RWmDzV0VND
 F4aNUDN3VE0Os2kjl6oB2NBkLjoaF4ZGLzDh6Kgp7GnDbeShZl2igo2fPovomJTFsi
 svJ2DRexdAL7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] drm/amd/display: Add HDMI 2.1 VRR support from
 HF-VSDB
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814164344.3098143-4-jerry.zuo@amd.com>
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <20260814164344.3098143-4-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:55:20 +0000
Message-Id: <20260814165521.4864C1F00A3F@smtp.kernel.org>
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

New issues:
- [High] The HF-VSDB VRR fallback is negated for HDMI TMDS connections due =
to a pre-existing AMD FreeSync MCCS check resetting `freesync_capable` to `=
false`.

Pre-existing issues:
- [High] The highest refresh rate mode cache (`freesync_vid_base`) is never=
 invalidated across hotplugs, corrupting `max_vfreq` calculations for subse=
quently connected displays.
--

--- Patch [3]: [PATCH v4 3/4] drm/amd/display: Add HDMI 2.1 VRR support fro=
m HF-VSDB ---
commit cf4d7fc4ac615fcafd91467c91d4c4582773cd6b
Author: Fangzhi Zuo <jerry.zuo@amd.com>

drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB

This commit updates the FreeSync capabilities logic to fall back to the
HDMI 2.1 VRR range parsed from the HF-VSDB when the AMD VSDB does not
provide a valid range.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 9eaa20ec528ec..2fe7bfb1e88f7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -3856,6 +3865,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_con=
nector *connector,
>  				connector->display_info.monitor_range.max_vfreq =3D vsdb_info.max_re=
fresh_rate_hz;
>  			}
>  		}
> +
> +		drm_dbg_driver(adev_to_drm(adev),
> +			       "VRR: amd_vsdb i=3D%d fs_sup=3D%d min=3D%d max=3D%d fs_capable=
=3D%d\n",
> +			       i, vsdb_info.freesync_supported,
> +			       vsdb_info.min_refresh_rate_hz,
> +			       vsdb_info.max_refresh_rate_hz, freesync_capable);
> +
> +		/*
> +		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
> +		 * the HDMI 2.1 VRR capability parsed from the HF-VSDB.
> +		 */
> +		if (!freesync_capable && connector->display_info.hdmi.vrr_cap.supporte=
d) {
> +			struct drm_hdmi_vrr_cap *vrr_cap =3D
> +				&connector->display_info.hdmi.vrr_cap;
> +
> +			drm_dbg_driver(adev_to_drm(adev),
> +				       "VRR: HF-VSDB fallback: hdmi_vrr=3D1 vrr_cap[sup=3D%d min=3D%=
d max=3D%d] mrange_max=3D%d\n",
> +				       vrr_cap->supported, vrr_cap->vrr_min, vrr_cap->vrr_max,
> +				       connector->display_info.monitor_range.max_vfreq);
> +
> +			if (vrr_cap->supported && vrr_cap->vrr_min > 0) {
> +				amdgpu_dm_connector->min_vfreq =3D vrr_cap->vrr_min;
> +				amdgpu_dm_connector->max_vfreq =3D vrr_cap->vrr_max ?
> +					vrr_cap->vrr_max :
> +					connector->display_info.monitor_range.max_vfreq;
> +
> +				/*
> +				 * VRRMAX =3D 0 in the HF-VSDB means "up to the Base
> +				 * Refresh Rate". If the EDID also did not provide a
> +				 * monitor range max, fall back to the Base Refresh
> +				 * Rate (the highest refresh rate of the preferred
> +				 * timing) so a valid VRR range is still reported to
> +				 * userspace.
> +				 */
> +				if (!amdgpu_dm_connector->max_vfreq) {
> +					struct drm_display_mode *brr_mode =3D
> +						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector, true);

[Severity: High]
This is a pre-existing issue, but does amdgpu_dm_get_highest_refresh_rate_m=
ode()
return stale data across hotplugs?

It appears aconnector->freesync_vid_base is never cleared on hotplug:

amdgpu_dm_get_highest_refresh_rate_mode() {
    ...
    if (aconnector->freesync_vid_base.clock !=3D 0)
        return &aconnector->freesync_vid_base;
    ...
}

If a high-refresh monitor is unplugged and an HDMI 2.1 VRR monitor with
VRRMAX =3D 0 is plugged into the same port, will this use the cached
high-refresh mode of the disconnected monitor and calculate an incorrect
max_vfreq?

> +
> +					if (brr_mode)
> +						amdgpu_dm_connector->max_vfreq =3D
> +							drm_mode_vrefresh(brr_mode);
> +				}
> +
> +				if (amdgpu_dm_connector->max_vfreq -
> +				    amdgpu_dm_connector->min_vfreq > 10)
> +					freesync_capable =3D true;

[Severity: High]
Does this new fallback get negated later in amdgpu_dm_update_freesync_caps()
for HDMI TMDS connections?

When an HDMI monitor without an AMD VSDB is connected, freesync_vcp_code
remains 0. Later in this same function, the pre-existing MCCS check does th=
is:

    if ((sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A ||
        as_type =3D=3D FREESYNC_TYPE_PCON_IN_WHITELIST) &&
        (!sink->edid_caps.freesync_vcp_code ||
        (sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_sup=
ported)))
        freesync_capable =3D false;

Since !sink->edid_caps.freesync_vcp_code evaluates to true for TMDS,
could this prevent the HF-VSDB fallback from working for these displays?

> +
> +				connector->display_info.monitor_range.min_vfreq =3D
> +					amdgpu_dm_connector->min_vfreq;
> +				connector->display_info.monitor_range.max_vfreq =3D
> +					amdgpu_dm_connector->max_vfreq;
> +			}
> +		}
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814164344.3098=
143-1-jerry.zuo@amd.com?part=3D3
