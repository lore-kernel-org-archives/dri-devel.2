Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB613C88E56
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5D210F5CF;
	Fri, 11 Sep 2026 12:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ELDlWdVU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B70710F5CF;
 Fri, 11 Sep 2026 12:54:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BB5B42E34;
 Fri, 11 Sep 2026 12:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488361F000FF;
 Fri, 11 Sep 2026 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131248;
 bh=DH2MgrmSNXSwGj0bQL9pRyfq+FBusWHHv39MC6losiw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ELDlWdVUj6rgI+ydpmIjWkjnEdvZLRbKOl9eMPpsBv8gkVjX5IdGm8WCvrKeiyoAY
 HVNHKsG0q4NkwWM0I5rXrAbZGpDFh2nPIy0cgvoFYcPOjsy2QKBET4VUTVjrNhFbT3
 +8Ecf90MtkFqFMPL1Dns+txKCWPD/3QdjWI0lBYFxXnw9spprxsAMQ52r83yapwiUS
 iSd0VPLtIc/UFUf6Y7UnHfr1A/2pVFrpYO+KYSIsnOQF3A5YBLOjamUSB8Uxt0LVWX
 kF4duXEesQ4E4C5IbzIscCTE01FF79eb8FktH/UkyDkpMFDP1ouiUn5HasSmGl+JI0
 7nI/r/lNhpYRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/14] drm/panic: Retry in dispatch function if panic
 output fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, Frank.Li@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, gary@garyguo.net,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260911124540.279841-9-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:07 +0000
Message-Id: <20260911125408.488361F000FF@smtp.kernel.org>
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

> On failed output of QR codes and kmsg buffers, fall back to a user
> message. QR-code output already did this internally, but now formally
> support it in drm_panic_dispatch(). Streamlines the existing logic.
>=20
> With the implicit fallback removed from QR-code support, the tests
> cases fail for thr smallest output size (300x200). This is because the
> QR code requires a minimal output size. Increase the size to 494x494,
> which is the minimum supported size for QR output.
>=20
> v3:
> - update outdated commit description (Sashiko)
> v2:
> - fix minimum test size (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D8

