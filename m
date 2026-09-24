Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8739C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D42610F4E8;
	Thu, 24 Sep 2026 12:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OOpPNhu6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55ED010F4E8
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 12:47:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7341400E7;
 Thu, 24 Sep 2026 12:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B511F000FF;
 Thu, 24 Sep 2026 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790254077;
 bh=Uo4K0i/gBEUW1Q+qAYIun3zP3kctoFJRwk+eY02oYxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OOpPNhu6nRCzH9NPWhMEw4lOwWgGt2U7hgenhl8jecBDWyYD2WZ1kXX3cQgTYtXDY
 AxDtHsF/dnyG/ds3BIN2VDHzjfXLAYKyBaFMUfpIbSAnH3zD6rHCnMpY34kKfyds/T
 +AFwU1KQM1Bn33NY4dG8SrRR16x9WaTFZnAOWSuGIeath2TwOoDr/roEyStm8soo4n
 G915S1yfqtKTcav60zVWETVX7rnph4jCjotcCZNoif7kPom3VEYgWSAf1i63bJ3JiX
 57hbEPpxEEPKLxBQqtBKGEmTRrvjoAPKbsfy6ZCT/xHf/6Sy1izAsmW1y1Ium7GBWw
 sLTc/6hn180XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: validate client monitor index before access
To: "Jiale Yao" <yaojiale02@163.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260924123731.803007-1-yaojiale02@163.com>
References: <20260924123731.803007-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:47:57 +0000
Message-Id: <20260924124757.86B511F000FF@smtp.kernel.org>
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

> client_monitors_config is allocated with space for count heads, while QXL
> creates qxl_num_crtc outputs whose indexes range from zero to
> qxl_num_crtc - 1.  The monitor count may be smaller than qxl_num_crtc, but
> qxl_update_offset_props() and qxl_conn_get_modes() use the output index to
> access heads[] without checking it against count.
>=20
> Starting QEMU with "-device qxl-vga,xres=3D1024,yres=3D768" provides one
> client monitor while the driver creates four outputs by default.  KASAN
> reported the first out-of-bounds access during probe, with
> qxl_update_offset_props() inlined into its caller:
>=20
>   BUG: KASAN: slab-out-of-bounds in
>   qxl_display_read_client_monitors_config+0x2379/0x2e30
>   Read of size 4 at addr ffff88810403e170 by task swapper/0/1
>   Call Trace:
>    qxl_display_read_client_monitors_config+0x2379/0x2e30
>    qxl_modeset_init+0x6a6/0x7b0
>    qxl_pci_probe+0x150/0x2d0
>=20
> The same configuration reaches the unchecked access in
> qxl_conn_get_modes() when userspace enumerates connectors.
>=20
> Skip offset updates for outputs that have no corresponding client head,
> and retain the default preferred mode dimensions in qxl_conn_get_modes()
> when its output index is outside the client head array.
>=20
> Fixes: 7dea0941f880 ("drm/qxl: use suggested x/y offset properties to pas=
s guest prefs")
> Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924123731.8030=
07-1-yaojiale02@163.com?part=3D1

