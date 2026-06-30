Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215A6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CC910E8A5;
	Tue, 30 Jun 2026 15:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FtXTYPA6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F9210E8A5
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 15:11:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E88840AB4;
 Tue, 30 Jun 2026 15:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9631F000E9;
 Tue, 30 Jun 2026 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782832308;
 bh=tHx6QjzlTysC3HMIn02JH9TQ38baeE5KHmTu5p7RfJ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FtXTYPA6MEzHciTkZa1zS9JK+ndypv9T7KqxBYC5tyYHoOHGTODuUjx/if3dutgGn
 Vpu5/7sIS7YC4rbr3+AOBU+a6AkzeSQLOwfbQN5c6X0KLoAJ+Z2t1a70fy9nrU5h/w
 JrFm7iIYEBeERozdRN4+/i528vk02Gc7nQZjSjQpX+vr/ZHQ0LCVWeq7vgxJETtd9D
 XMWg/MMn/tDwMzWf7bjl3rcq0/34iSri2ERtfMgeKfrCddzN7PvldOStxpxf7yv9BK
 0hsNdhh+G6SsqZVU6KsxrPT1aCTxBnVpc3JmEpj1EThQ64PxTqoAllW5SmCwCiC1kv
 osj19LWj2EMBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display:Check
 dp_128b_132b_supported_link_rates.raw before link_rate setting
To: "Jackie Dong" <xy-jackie@139.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630145955.13994-1-xy-jackie@139.com>
References: <20260630145955.13994-1-xy-jackie@139.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 15:11:47 +0000
Message-Id: <20260630151147.CB9631F000E9@smtp.kernel.org>
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
- [High] Checking `dp_128b_132b_supported_link_rates.raw` before it is read=
 from the DPCD register completely disables DP 2.0 UHBR support.
--

commit 11d06153280ec5dae6682a402606818b4f84b79d
Author: Jackie Dong <xy-jackie@139.com>

drm/amd/display:Check dp_128b_132b_supported_link_rates.raw before link_rat=
e setting

This patch modifies the DP 128b/132b capability check to also verify that
dp_128b_132b_supported_link_rates.raw is non-zero before attempting to read
and parse the specific UHBR link rates.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capabi=
lity.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -2079,7 +2079,8 @@ static bool retrieve_link_cap(struct dc_link *link)
>  	if (!dpcd_read_sink_ext_caps(link))
>  		link->dpcd_sink_ext_caps.raw =3D 0;
> =20
> -	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
> +	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED &&
> +			link->dpcd_caps.dp_128b_132b_supported_link_rates.raw) {

[Severity: High]
Will this change completely disable DP 2.0 UHBR support?=20

In retrieve_link_cap() in drivers/gpu/drm/amd/display/dc/link/protocols/lin=
k_dp_capability.c,
dp_128b_132b_supported_link_rates.raw is now checked before it is actually=
=20
read from the DPCD register. Since the dc_link struct is zero-initialized a=
nd
the read hasn't occurred yet, won't this raw value always evaluate to 0 upon
connection of any DP 2.0 monitor?=20

This would cause the if condition to always fail, bypassing the actual read
block below and permanently preventing UHBR feature detection.

>  		DC_LOG_DP2("128b/132b encoding is supported at link %d", link->link_in=
dex);
> =20
>  		/* Read 128b/132b suppoerted link rates */
>  		core_link_read_dpcd(link,
>  				DP_128B132B_SUPPORTED_LINK_RATES,
>  				&link->dpcd_caps.dp_128b_132b_supported_link_rates.raw,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630145955.1399=
4-1-xy-jackie@139.com?part=3D1
