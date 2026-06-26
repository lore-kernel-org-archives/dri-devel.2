Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1341AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B72710E3A5;
	Fri, 26 Jun 2026 12:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcENZC9I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7ED10E3A5
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:55:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A6B562120;
 Fri, 26 Jun 2026 12:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5821F00A3A;
 Fri, 26 Jun 2026 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782478541;
 bh=8bXxKogbrKSv1DbLJlT8YpC0seiTiOZQ0APALxns1GA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bcENZC9IJJudKRvNso/KZFD/CcMuqQo4Y70IviW90My/LGxg6f0iTL9qUCXENEALb
 X0HWweammLh7TSZUAuFk+wnchuBoGsvc+WvmIwnpscdrM012xGp+dry+k8W3MFY7ku
 vGAO4FudV/OqXqtGwTKIz1hT6bJUcePEqp6bDcJOp+W/tqC5rnMd7N+TReRYfBrEag
 h4ylS1FJPyiZEdngJKw+EdnwoQr3lXISi6xce2hiKRKHiRr6x9wqUYH2uNytpmvj77
 bRD2KHnY6AqwF1WOWcaDQb5MYQzsWNWcTu79CIzRFG7QmYj9UF7n3tmTRmezgBH267
 4QTF+90IHB2Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/amd/display: detect_link_and_local_sink: DP
 alt mode timeout   path leaks prev_sink reference
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626124555.36910-1-vulab@iscas.ac.cn>
References: <20260626124555.36910-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:55:40 +0000
Message-Id: <20260626125541.1B5821F00A3A@smtp.kernel.org>
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
- [Medium] The `EDID_NO_RESPONSE` error path for HDMI/DVI connectors return=
s `false` without calling `link_disconnect_sink()`, leaving `link->local_si=
nk` populated and leading to a false-positive connection state on the next =
poll.
--

commit c7392818ef1ec0f54b3aa58060b607f2f261bed1
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/amd/display: detect_link_and_local_sink: DP alt mode timeout path =
leaks prev_sink reference

prev_sink is unconditionally retained via dc_sink_retain at function
entry, but the DP alt mode timeout path inside SIGNAL_TYPE_DISPLAY_PORT
returns false without releasing prev_sink. All other return paths in the
function correctly call dc_sink_release(prev_sink), making this the only
missing cleanup.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index a3212fd151d16..7d8951fecd570 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1164,8 +1164,11 @@ static bool detect_link_and_local_sink(struct dc_l=
ink *link,
>  			    link->link_enc->features.flags.bits.DP_IS_USB_C =3D=3D 1) {
> =20
>  				/* if alt mode times out, return false */
> -				if (!wait_for_entering_dp_alt_mode(link))
> +				if (!wait_for_entering_dp_alt_mode(link)) {
> +					if (prev_sink)
> +						dc_sink_release(prev_sink);
>  					return false;
> +				}
>  			}

[Severity: Medium]
This isn't a bug introduced by this patch, but there is a pre-existing
issue further down in detect_link_and_local_sink() related to sink cleanup
when EDID reads fail.

When an HDMI or DVI device asserts HPD but fails DDC/EDID reads, the
code handles the EDID_NO_RESPONSE case like this:

drivers/gpu/drm/amd/display/dc/link/link_detection.c:detect_link_and_local_=
sink() {
    ...
			if (dc_is_hdmi_signal(link->connector_signal) ||
			    dc_is_dvi_signal(link->connector_signal)) {
				if (prev_sink)
					dc_sink_release(prev_sink);

				return false;
			}
    ...
}

Does this error path need to call link_disconnect_sink(link) before
returning false?

It appears that link->local_sink is populated earlier in this function
when dc_sink_create() returns a new reference. By returning false without
disconnecting, link->local_sink remains populated.

Could this lead to a false-positive connection state on the next poll,
where amdgpu_dm_connector_detect() sees link->local_sink !=3D NULL and
short-circuits to report the connector as connected, potentially causing
the compositor to attempt modesetting on an invalid, partially-initialized
sink with no EDID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626124555.3691=
0-1-vulab@iscas.ac.cn?part=3D1
