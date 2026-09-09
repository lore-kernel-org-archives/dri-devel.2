Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD865C79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D2A10F03A;
	Wed,  9 Sep 2026 09:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pk1G4sHW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B0B10E4AF;
 Wed,  9 Sep 2026 09:13:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8741F40398;
 Wed,  9 Sep 2026 09:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34441F00A3A;
 Wed,  9 Sep 2026 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945196;
 bh=hli6ez5KjFclPn4AlwREO1zYzgchjZ11BhJABfXphx4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pk1G4sHWsG5uNAiwHqW4cbtZ6YQzGiYxFMWWrbXaKXHPIn0+3cPc8O8Mlzzofhb4I
 RFAvh6B5ODHkRdrPV5ErVwxltF686pM02/X8tOi1vkuQTyfAEv8Z/3MmA4tTRkJ0vy
 S+dOCt+k7RBh4bRHLydLxAREX7YZAwRoTChpOTEIAMJyD7c0SHfe71e2HXz0x0jfvX
 0rfVrcRn33euDpiB0VcCo0eYGtUCMU1bjCgvgvqZveKZLX8k0uJka1syQefmdlxBzB
 mKzwu/OrkVkNSBaZye5F9w9DtUGZ+f6zB0ZECzHs3cPAFi+KAMVkqt/yWtlFI4Ibe1
 yw4se8pM/9uKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/14] drm/panic: Pass colors to draw_panic_dispatch()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Michael
 S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org, gary@garyguo.net,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Frank.Li@kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260909085826.64529-6-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:13:15 +0000
Message-Id: <20260909091315.C34441F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D5

