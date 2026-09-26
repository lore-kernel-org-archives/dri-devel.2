Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545C4C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B198410E22E;
	Sat, 26 Sep 2026 16:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gc3YlU+Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE7F10E22E
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:42:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5028243941;
 Sat, 26 Sep 2026 16:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E801F000FF;
 Sat, 26 Sep 2026 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790440920;
 bh=U89+kmtfsOWlRFigA3CHEGQ2aPXOnjJ5VGEkFsbUFxg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Gc3YlU+Yr5R8VzXFSSDTF2gVpx4HpXhK5sX2IIOrUZoN0Of0NnrwlUWIjs/rSZzCU
 xq9nGMeBevFelRBGZWMqGBGFFOU4F/Ws9W7587QgDMkedQ7f2/NanqIp7o/WsEQpL+
 eajpnsr5xph/ob0jaj+pvEGquSDKbvo0I2Eo8pBTIl/4R1Wnaten/ZPugAtNFmS0qH
 WSTOh//zPqS9z4d30AYKvnkh5TMutDS24rXnLC9sk5x/atfwAHyZqyJdwpUBzVjI10
 Mcn6J3rumdcE2W/bWjC3YUeKs2y+JAB1IiZBnlIEHgEyJ9PMm2HU7dXLY1CZdf99Nj
 s+6yIAnUXq+qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/qxl: own packed primary shadows in atomic
 plane state
To: "Dillon Amburgey" <dillona@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260926163123.39217-5-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
 <20260926163123.39217-5-dillona@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:41:59 +0000
Message-Id: <20260926164159.E6E801F000FF@smtp.kernel.org>
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

> Preparing a dumb framebuffer changes device-wide layout and BO shadow
> bindings before the atomic commit succeeds. An aborted preparation can
> redirect live framebuffers to an uncommitted shadow. Per-plane cleanup
> can also remove a shadow binding still needed by another head using the
> same framebuffer.
>=20
> Give each prepared primary plane state a reference and pin to a shared
> shadow. Compute the complete new layout and prepare one matching shadow
> without changing the displayed states. Include all primary planes and
> CRTCs so replacement and repacking redraw every head under the same
> commit dependencies. Release each state's resources independently.
>=20
> Keep the primary while any new primary plane remains active, and destroy
> it when the last head turns off, including DPMS with retained framebuffer
> bindings. Route DirtyFB clips through each matching active plane state
> to its packed slot; copy clips before the draw helper translates them.
>=20
> Retain allocation-based packing and full-framebuffer drawing here; plane
> source geometry is handled separately.
>=20
> Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
> Assisted-by: LLM sparse
> Signed-off-by: Dillon Amburgey <dillona@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163123.3921=
7-1-dillona@gmail.com?part=3D4

