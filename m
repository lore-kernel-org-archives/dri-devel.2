Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041EEC88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063D410F5DF;
	Fri, 11 Sep 2026 12:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aC8PyTEz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AAD10F5DF;
 Fri, 11 Sep 2026 12:54:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FB8A40708;
 Fri, 11 Sep 2026 12:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0791F000FF;
 Fri, 11 Sep 2026 12:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131260;
 bh=8hLvPolZrAyN/rGoUtfPMpPK6CQmAiX4OmkzSPa0rh0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aC8PyTEzip00grSpA+yc5tO7c3jmNteMdmDM0X5/VHKM2PiIZumdVT/KmF1mNdeo6
 zqP191S/Gr9ThbJlxqUPTSsk0BpY4NYEJ018FyM2mCyhzy8GbgJP2xMWSzx07fccF6
 nYesRYaQ15i3irzA7SaB42uN7vEvLlPagZcD0aF/esvBkLhJUyPjYFhtVb63/uBmnV
 FDR/448pL+TgpGos274erhNm5/jpIrPj/CbYrYEI0C4byipOE1t0UI4GbRHzNqb1yG
 hWL14aKE5ODKIFJxaOiR3MPqv/gvhnTwvcyq/UH1Hqw0aLYREkuQVFg6xBZzh+LPen
 D4g9IZXxXowZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/14] drm/panic: Pass colors to draw_panic_dispatch()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, "Eugenio
 Perez" <eperezma@redhat.com>, ojeda@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260911124540.279841-6-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:19 +0000
Message-Id: <20260911125419.6D0791F000FF@smtp.kernel.org>
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

> Set the panic-screen colors in draw_panic_plane() as a single point
> of truth. Pass the values into the individual drawing functions.
>=20
> In the test cases, replace the Kconfig-defined colors with white and
> black. Allows for removal of the tests' limitations and dependency on
> the exact values. All tests now always verify the generated output.
>=20
> Hardcoding the test colors will later also allow for building the
> test case without having DRM panic handling enabled.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D5

