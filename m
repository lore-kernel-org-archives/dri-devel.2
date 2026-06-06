Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A605FCD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 09:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E946310E781;
	Sat,  6 Jun 2026 09:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YWMEY4bn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E89B10E781
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 09:22:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 672D2600AE;
 Sat,  6 Jun 2026 09:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF411F00893;
 Sat,  6 Jun 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780737756;
 bh=UwainE0uO1uQUQ0e+u5Yn0Axg5PLcden/uTQxcyLrWc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YWMEY4bn4Ja3WDt0Nbh/kd8J/1EGqsH/XIZCzLG2JRadHralLusGoNtYyuCavgEt7
 8DNwcl1xURBgV73M5mHEUt0vg23KOoA2zkDhkQGHUVSSIcyrCA6pb79xNTgSQMRiwi
 jrBPFDOO27O3jF5PGCfdYgEMbdxNB2yKYvoA3nUBPpX5ZpqdvqgSSzUcbEUnX3mBPt
 GAzHq2RCLiZbpKwmnUyHvVHCRd2LPvwmXoMff81/q2xXXam6qYBW0wuExwBeByw3Rd
 Cc2AQxTjzc1YdyTs8V3S/4bp3W2zg4y3eW4U91c1IoWGZk88gGIKsHFKe6TxXzx6wM
 DKMcE5tyctYqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix refcount leak in
 detect_link_and_local_sink()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606091731.21183-1-vulab@iscas.ac.cn>
References: <20260606091731.21183-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 09:22:35 +0000
Message-Id: <20260606092235.DBF411F00893@smtp.kernel.org>
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
- [High] The patch introduces a NULL pointer dereference by calling `dc_sin=
k_release(prev_sink)` without checking if `prev_sink` is NULL when DP alt m=
ode times out.
--

commit 341dc989b4f07001883ab7ee04e6a4e4cda21615
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/amd/display: fix refcount leak in detect_link_and_local_sink()

Fix a refcount leak by releasing prev_sink on the DP alt mode timeout path
in detect_link_and_local_sink().

> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drive=
rs/gpu/drm/amd/display/dc/link/link_detection.c
> index a3212fd151d16..0d1352bf1da29 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -1164,8 +1164,10 @@ static bool detect_link_and_local_sink(struct dc_l=
ink *link,
>  			    link->link_enc->features.flags.bits.DP_IS_USB_C =3D=3D 1) {
> =20
>  				/* if alt mode times out, return false */
> -				if (!wait_for_entering_dp_alt_mode(link))
> +				if (!wait_for_entering_dp_alt_mode(link)) {
> +					dc_sink_release(prev_sink);

[Severity: High]
Does this code introduce a NULL pointer dereference?

Earlier in detect_link_and_local_sink(), prev_sink is initialized from
link->local_sink, which can be NULL if no display was previously connected.
The other error paths in this function check if (prev_sink) before calling
dc_sink_release().

If prev_sink is NULL, calling dc_sink_release() will crash because it direc=
tly
dereferences the sink pointer:

drivers/gpu/drm/amd/display/dc/core/dc_sink.c:dc_sink_release() {
	kref_put(&sink->refcount, dc_sink_free);
}

>  					return false;
> +				}
>  			}
> =20
>  			if (!detect_dp(link, &sink_caps, reason)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606091731.2118=
3-1-vulab@iscas.ac.cn?part=3D1
