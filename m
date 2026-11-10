Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CA606A321
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcjjf7qr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6D910E09E;
	Tue, 10 Nov 2026 08:22:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FFA10E09E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:22:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 548C7605F9;
 Tue, 10 Nov 2026 08:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1EE1F0089F;
 Tue, 10 Nov 2026 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794298967;
 bh=zb4BIc6AQ2AqTKlVp9wzIP/5OHpNuZgTSqPBrrItc2M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jcjjf7qrP/KDO1fUjqhdJ+kCd2VI5GfCdoUbt3FQ2q9V38AtgGehf0b4Ibd6+M1aU
 E3y0QxDYy98WetV9wMUgyCmd9SRn2mNF03lZDxmwLd9ga8UBgT5yCG2u/qh0YHygjM
 bT+5oKaxidzsUFwV1gQM7ml9Mw0mtiMUQP1lxfkKHo0JPg71nBeeVkfyUl7t8pYYXQ
 DYKRDBRoSRYwqVuBWZPMhYzyXmNyoChouiOziKcdPHzx4fRylyPLKAJhVa0bRsSiEg
 Q3x3ZIZcE4SHt6F9TDAsXrdFIpMxk69HPfn8otSrW0x6MuqXnSWDJ7TowAbZlejNm5
 tGPfTeSkJ85Xw==
Message-ID: <sashiko-outbox-206598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] drm/rockchip: vop2: Keep the other LUT_PORT_SEL
 fields on gamma LUT updates
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vop2-fixes-v1-7-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
 <20261110-vop2-fixes-v1-7-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:22:45 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/rockchip: vop2: missing Fixes trailer for commit
  4f537776340d
--

commit a8803c2d42085266d5dfa3113cf2bcad402ebf13
Author: Arun Iyengar <aiyengar1990@gmail.com>

> drm/rockchip: vop2: Keep the other LUT_PORT_SEL fields on gamma LUT updat=
es
>
> On RK3588 the gamma LUT of a video port is written through a window that
> GAMMA_AHB_WRITE_SEL in SYS_CTRL_LUT_PORT_SEL selects. The register also
> holds the dclk source selection of video ports 0 and 2 and the enable of
> the video port 0/1 merge for modes wider than 4096 pixels, which writing
> the whole register clears.
>
> Only update the write select field.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

[Severity: Low]
This fixes the full-register write to RK3568_LUT_PORT_SEL in
vop2_crtc_atomic_set_gamma_seamless().  Should this include:

  Fixes: 4f537776340d ("rockchip/drm: vop2: add support for gamma LUT")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vop2-fixes=
-v1-0-d336e9dd90d3@gmail.com?part=3D7
