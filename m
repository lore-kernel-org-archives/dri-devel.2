Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318DBC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827A410EE38;
	Wed,  5 Aug 2026 12:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ey1AKCia";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F411710EE39
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:24:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84674402D6;
 Wed,  5 Aug 2026 12:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08BB1F00A3D;
 Wed,  5 Aug 2026 12:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932658;
 bh=2DSKoUclAnGWgq6WyJWfPrq06DD7De4LJari1sy6uXg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ey1AKCiaDgay8oLQSi6zC1a4tvzP4MRoyYr8JcyqJ+swXfyZJUrsLLZW+tfu3VldY
 WEQkKrQUanFavihe/fVCz/L3ZrtJoi+AnYF6g2cDlRv2dZYNIaGxkWAe2PU6V/YCtV
 Pe85WrD8wcfVTLANaQTE9iJsRAFeo/BXwPHHhKKRetF+UaINH/UFZ/qLxkc3TRGepZ
 pPuaUCmbgzBdgl5lmLbwcetrSkkYpWW0HxzEZcDXgfPOqNVOFtlGEgsYD29dHKOked
 Q/sOg2saaYYpobdJxk2aiy6h9Wj+ha/Nj9mMvT48oVe/MHXvHoPBAGVlLNfopkitSO
 g7h79GhMIgNfQ==
From: sashiko-bot@kernel.org
Subject: Re: Patch "drm/dp: Read the PCON max FRL bandwidth only for HDMI
 DFPs" has been added to the 6.18-stable tree
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <2026080539-uncross-canopener-192f@gregkh>
References: <2026080539-uncross-canopener-192f@gregkh>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:24:16 +0000
Message-Id: <20260805122417.D08BB1F00A3D@smtp.kernel.org>
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
- [Medium] Omission of DP++ (DP Dual Mode) support when checking HDMI DFP t=
ypes.

Pre-existing issues:
- [High] Missing DPCD capabilities and DFP type check in `intel_dp_check_fr=
l_training()`.
--

--- Patch [1]: Patch "drm/dp: Read the PCON max FRL bandwidth only for HDMI=
 DFPs" has been added to the 6.18-stable tree ---
commit 580edf550253578c69a6a51eb6abfe83d33b3d72
Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>

Patch "drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs" has been=
 added to the 6.18-stable tree

This commit restricts drm_dp_get_pcon_max_frl_bw() to only parse the FRL
bandwidth field for an HDMI DFP behind a DPCD 1.1+ branch device that repor=
ts
detailed capability info. Previously, it parsed the byte without checking t=
he
DFP type, leading to incorrect parsing on some adapters.

Link: https://patch.msgid.link/20260610193825.2933-1-alexander.kaplan@sms-m=
edipool.de

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index 4aaeae4fa03c3..8c858ba40c6c6 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3457,6 +3457,18 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RE=
CEIVER_CAP_SIZE],
>  	int bw;
>  	u8 buf;
> =20
> +	if (!drm_dp_is_branch(dpcd))
> +		return 0;
> +
> +	if (dpcd[DP_DPCD_REV] < 0x11)
> +		return 0;
> +
> +	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) =
=3D=3D 0)
> +		return 0;
> +
> +	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) !=3D DP_DS_PORT_TYPE_HDMI)
> +		return 0;

[Severity: Medium]
Does this strict check for DP_DS_PORT_TYPE_HDMI inadvertently omit DP++
(DP Dual Mode) support?

As mentioned in the commit message, amdgpu's DC parses the field for both H=
DMI
and DP++ detailed types. Other helpers like drm_dp_downstream_max_bpc() also
handle DP++ alongside HDMI. By rejecting DP_DS_PORT_TYPE_DP_DUALMODE, could
active DP-to-HDMI adapters identifying as DP++ have their max FRL bandwidth
evaluated as 0 Gbps, leading to a loss of FRL capabilities?

> +
>  	buf =3D port_cap[2];
>  	bw =3D buf & DP_PCON_MAX_FRL_BW;

[Severity: High]
This is a pre-existing issue, but is it possible for
intel_dp_check_frl_training() to incorrectly write to PCON DPCD registers o=
n a
non-PCON branch device?

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_check_frl_training() {
    ...
	if (!(intel_dp->downstream_ports[2] & DP_PCON_SOURCE_CTL_MODE) ||
	    !intel_dp_is_hdmi_2_1_sink(intel_dp) ||
	    intel_dp->frl.is_trained)
		return;

	if (intel_dp_pcon_start_frl_training(intel_dp) < 0) {
    ...
}

The function checks intel_dp->downstream_ports[2] & DP_PCON_SOURCE_CTL_MODE
without first verifying DP_DETAILED_CAP_INFO_AVAILABLE or that the port is =
an
HDMI DFP. If a branch device without detailed caps has 3 or more ports,
downstream_ports[2] could contain the capability byte of the 3rd port.

If this port is of type NON_EDID, bits 4-7 contain the NON_EDID mask, which
could naturally have bit 5 set. This could lead the driver to assume the br=
anch
is a PCON and erroneously write to PCON-specific DPCD registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026080539-uncross-=
canopener-192f@gregkh?part=3D1
