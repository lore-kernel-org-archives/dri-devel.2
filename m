Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5FBC9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9603610E17A;
	Sat, 26 Sep 2026 16:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QjNLZRf+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4451B10E17A
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:38:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FD1E600C8;
 Sat, 26 Sep 2026 16:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF71F000FF;
 Sat, 26 Sep 2026 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790440715;
 bh=UKd5EJx9RhEc5mhWrlxsoYjk314pmwYozNNFOokkaP8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QjNLZRf+FOmpyjTGfFOQHqhxXrPreLJjZzuvfTT7Y6UIQzfVZlYSuFiQ9ftOrBk+K
 mEONsPGShW4MjOmLdYqDzRTuYoQ22W3i3mEgCB48E0tdkXraRlx7uIE94ho9mTVICy
 yIlL1wF4sR14BAT/jQ5bdwdkFN8abtCyzbMVoVatYaKQPPx13v4xAQYF98bdf5g7CR
 Nootl2zqSIs5DBFwDhwKTiyIOWcVkURfGvtwvkclqKhXn97toh7Ps0Jo7+crA62cWH
 N/fL188vG2V3uVLrfFWQzU0X1R1AhRnda3rRFisQ2PsTWg5HLjc974rm0TGyd1m+Nz
 mJrb6MMTVa8zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] drm/qxl: unpin the framebuffer when plane
 preparation fails
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
In-Reply-To: <20260926163123.39217-2-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-2-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:38:34 +0000
Message-Id: <20260926163834.B1AF71F000FF@smtp.kernel.org>
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

> qxl_plane_prepare_fb() pins the framebuffer before preparing its GEM
> fences. If GEM preparation fails, the atomic helper cleans up only the
> previously prepared planes, leaving this framebuffer pinned.
>=20
> Unpin this plane's framebuffer before returning the preparation error.
>=20
> Fixes: 6071c4c2a319 ("drm/qxl: add drm_gem_plane_helper_prepare_fb")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D1

