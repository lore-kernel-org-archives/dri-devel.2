Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E5AC5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 15:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E30910E108;
	Sat, 22 Aug 2026 15:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B/AIdr3W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F60410E108
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 15:15:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A13FE60008;
 Sat, 22 Aug 2026 15:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A0C1F000E9;
 Sat, 22 Aug 2026 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787411743;
 bh=GXgvhAlmfCinodnHR+X44bxvw6RTzEoghxEh/0SzjHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B/AIdr3WcxOUwH7FxiFNNMwnD0viCY1EN0Qw8c0aHH9pnH/Wce+vHfZHue1F86pzj
 xzDq+LsALI8sWTEiLi0U+R7KDBVK1XX3PqRQ1XEXEvBWntNOBfThMLMBh60MDlYQXa
 UgsnoLCXGBjmDdMy3N4IBUskMp0HrsbpnVb/kw8+QHrp32to/im4ZK5qIIdq3znJIz
 pGFnw9j5TW5XvNTtTbXklOF3deyglPhj8oBc6LIUcIRcBNafxLH5qblw6JLxJJnWfn
 8aS1FTPc9SJ2DMIqvQ0Us1h2vaO3PWtdRgMqqnY58wWxaiWVNFWtMMzSlBqow0NnLw
 d9jQvL3CQ62EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: fix division by zero in
 get_estimated_bw()
To: "Hari Mishal" <harimishal1@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260822145751.42328-1-harimishal1@gmail.com>
References: <20260822145751.42328-1-harimishal1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 15:15:42 +0000
Message-Id: <20260822151543.30A0C1F000E9@smtp.kernel.org>
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
- [High] Uncapped request_bw is assigned to allocated_bw, causing an oversi=
zed value that leads to an integer underflow during bandwidth validation.
--

--- Patch [1]: [PATCH] drm/amd/display: fix division by zero in get_estimat=
ed_bw() ---
commit d3870b3b2da2897f934f4033da62b969b6443914
Author: Hari Mishal <harimishal1@gmail.com>

drm/amd/display: fix division by zero in get_estimated_bw()

This commit fixes a division by zero in get_estimated_bw() by returning 0
if bw_granularity is zero. This prevents a crash when a connected DPIA
device reports an estimated bandwidth change before reporting a capability
change.

>     link_dpia_send_bw_alloc_request() already guards the same
>     bw_granularity division; add the identical guard here rather than
>     introducing a new pattern.

[Severity: High]
This is a pre-existing issue, but since the commit message references=20
link_dpia_send_bw_alloc_request(), I noticed a potential integer underflow
issue involving allocated_bw.

In link_dpia_send_bw_alloc_request(), the uncapped request_bw variable
is assigned to allocated_bw:

drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c:link_dpia_s=
end_bw_alloc_request() {
    ...
		temp =3D req_bw * link->dpia_bw_alloc_config.bw_granularity;
		request_reg_val =3D temp / Kbps_TO_Gbps;
		if (temp % Kbps_TO_Gbps)
			++request_reg_val;
	}

	link->dpia_bw_alloc_config.allocated_bw =3D request_bw;
    ...
}

Later, in link_dpia_validate_dp_tunnel_bandwidth(), remaining_bw is
calculated using unsigned 32-bit subtraction:

drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c:link_dpia_v=
alidate_dp_tunnel_bandwidth() {
    ...
			if (router_sets[j].cm_id =3D=3D dp_tunnel_settings->cm_id) {
				uint32_t remaining_bw =3D
					dp_tunnel_settings->estimated_bw - dp_tunnel_settings->allocated_bw;
    ...
}

If a connected DPIA display requests more bandwidth than estimated,
allocated_bw will be strictly greater than estimated_bw.

Could this cause the subtraction to underflow to an extremely large
positive value (~4.29 billion), thereby bypassing the subsequent
capacity checks (required_bw > total_bw) and allowing illegal
configurations that oversubscribe the DP tunnel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822145751.4232=
8-1-harimishal1@gmail.com?part=3D1
