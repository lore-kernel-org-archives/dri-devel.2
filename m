Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF1606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYtBzAdz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CAE10EE86;
	Tue, 10 Nov 2026 08:16:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A7910EE86
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:16:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C964A61E91;
 Tue, 10 Nov 2026 08:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4701F008A1;
 Tue, 10 Nov 2026 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794298572;
 bh=TGAZTkhJnUI1ihUpMOxp2tl1gYGK8OAJcAa5Mz5YvcA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AYtBzAdzfbkAYrRe1qkxgPUicLo59w+htuYtFW8ibF7zlHHv1c99RfL4GZkOh0NQt
 Uk/WnbqZX+WgNdrLN6VSn0r812OrIeAqrc8Q4LgVts1XlVZ+8B87N2Ddx7K8piXO7w
 dCXZZd/jU7pgWKbpCoPD3Q+KuqjTChjxpz0KxEb65fCazcxy3t+/OvJc87534LBBXP
 nwgtFg+A6wcAy/fNx0l6OsGKBFstQ/mgaNDeQ1wn+ViwdS5nPVcuXpliM5zoRBu/j2
 pzuf33g1wkK9pqTuE7ndaKEXKkCgiJJm2M9b2YCo2MPKYsJBhCxIQqEySGiiIXxiia
 lQ+rTf9/sbh/Q==
Message-ID: <sashiko-outbox-206583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] drm/rockchip: vop2: Find the first mixer of a video
 port with Esmart3 too
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vop2-fixes-v1-6-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
 <20261110-vop2-fixes-v1-6-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:16:11 +0000
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
- [Low] drm/rockchip: missing Fixes trailer for
  vop2_find_start_mixer_id_for_vp()
--

commit bef29062242358932c819e26dffcbfccfee3a800
Author: Arun Iyengar <aiyengar1990@gmail.com>

> drm/rockchip: vop2: Find the first mixer of a video port with Esmart3 too
>
> vop2_find_start_mixer_id_for_vp() looks for the first layer that holds a
> window of the video port, but for_each_set_bit() takes the number of bits
> to search, and ROCKCHIP_VOP2_ESMART3 is the highest window id, so Esmart3
> is never found. A video port whose bottom layer shows Esmart3 then starts
> its alpha setup at the mixer of a higher layer, or, if Esmart3 is its
> only window, past all layers, and programs mixers of other video ports.
>
> Search all window ids.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

[Severity: Low]
This fixes the window bitmask search bound in
vop2_find_start_mixer_id_for_vp().  Should this include:

  Fixes: d3fe9aa49585 ("drm/rockchip: vop2: Use OVL_LAYER_SEL configuration=
 instead of use win_mask calculate used layers")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vop2-fixes=
-v1-0-d336e9dd90d3@gmail.com?part=3D6
