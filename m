Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD4C79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F04810F054;
	Wed,  9 Sep 2026 09:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hAKpJ0Ag";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF7110F056;
 Wed,  9 Sep 2026 09:28:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9722D403CE;
 Wed,  9 Sep 2026 09:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E7E1F00ACF;
 Wed,  9 Sep 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788946111;
 bh=aLbBfRJEp3WkQmrDf0sL5UEtU0iBuIQVBgcKCZ+7awc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hAKpJ0AghOH/HlRGM0QPco4xreKy79RLfvi6V3hNnP+GmIl+rV7B8nfLEJo5VGKj/
 dDATMbNT8XlvGp06rDYROP+YEeYubN3BEMD1lgUp5cb0HbkJ7KlKsIjIk2HPAUOSke
 yHHs5/3K3au9fTiUPcGaMvAXpsRN6qZQwBWCEjOwrnI0ii8ifc41zx4WwUuBu4kzet
 nawIQVO9R3RA320A4lTdT6jWs7Q+8DtsdgR4FpLXP2BIvajFfrSUVCwANZZ4NMVI5r
 j7btl8CjQTkAg8DUZU3aUuRtDcMb7u4uV+6NeNC9RkSGVrXpP4Vme4Gbie/X50FT0/
 dx+r2vWBiP3cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] drm/panic: Internalize panic locking in DRM
 core and helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, ojeda@kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, Frank.Li@kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 gary@garyguo.net, intel-gfx@lists.freedesktop.org, imx@lists.linux.dev,
 "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-13-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:28:30 +0000
Message-Id: <20260909092831.02E7E1F00ACF@smtp.kernel.org>
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

> None of the DRM drivers handles panic locking. Declare the interfaces
> in an internal header file. Move the trylock required during the panic
> into the DRM core's sources.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D12

