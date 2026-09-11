Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1A5C88E56
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5E510F61A;
	Fri, 11 Sep 2026 13:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jIHTr6sS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5361310F618;
 Fri, 11 Sep 2026 13:01:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 394AD41709;
 Fri, 11 Sep 2026 13:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EEA1F000FF;
 Fri, 11 Sep 2026 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131682;
 bh=njJNqx2xN32J4SV/wSn1hvanaa80mVzmvuVh8G0EjAo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jIHTr6sSpk5e//l7q7kerPPajxMrnRUkF2npfHv6BrMyq2xheK/KRFkXkiwLsQap2
 r2S7ppJiminXJFI58jHPB6HHOXQLRU/NmNjfEA89U5p5qfNqAYjByd6qJ1lRGeJAfy
 mrIZsCBIJMygeXjpXaqmTATjbdPd9bmI2ueM5hDn92YMb0luJQR+4qdUKqqnarVQbm
 w6fGUr0/5SnvtcHikUWUaFFjAIrsgUB82TXZ+1D2fAI5Yvlpmk3YBRGVxzBCybLJRH
 gzMEZbfycDDCSWxyXZEwUufA5JjuNx6Z/hoL6IO8w9oK91UUVYeBWJ6P1ntwpijDY4
 F8dllB0p0thSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/14] drm/panic: Compile KUnit tests as module
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, Frank.Li@kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 imx@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, ojeda@kernel.org,
 "Eugenio Perez" <eperezma@redhat.com>, gary@garyguo.net,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
In-Reply-To: <20260911124540.279841-15-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-15-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:01:21 +0000
Message-Id: <20260911130121.78EEA1F000FF@smtp.kernel.org>
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

> Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=
=3Dy
> and make them build as a module. Export the necessary interfaces from the
> panic helpers iff the KUnit framework has been enabled.
>=20
> Select DRM_PANIC_HELPER from DRM_KUNIT_TEST to meet the dependencies of
> the panic-helper tests.
>=20
> It is now possible to run the tests by modprobe-ing drm_panic_helper_test
> at runtime.
>=20
> v5:
> - clear test description with drm_panic_helper_clear_description() (Sashi=
ko)
> v3:
> - clean up after each test case (Sashiko)
> v2:
> - fix parameter order in decl of drm_panic_helper_draw_screen_qr()
>   (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D14

