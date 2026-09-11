Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4E0C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862A310F5FD;
	Fri, 11 Sep 2026 12:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aj+W32BT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D59310E3A7;
 Fri, 11 Sep 2026 12:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A46216020C;
 Fri, 11 Sep 2026 12:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D861F00893;
 Fri, 11 Sep 2026 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131390;
 bh=FAY5lyJ7IDLBX0N86QizjsEGHvzbqF2RXoIapFP/Rts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aj+W32BTkOVtHhWDXjjWNDCMVmF4gX4IJQclEHwOWPN2gSByAhxi4QlntgEOjprxU
 M/r4Dbz8YQtgC6yBxObRSYqMJ85Fe0H4Ki2/CpUMZy4TtkqxJ6XHu0ZnYSfaZOtMpF
 gihQ57u6LpVMq2oRF+wJN7IXEPcDiPeFixc+hsh8U28nxkjOW0dWHALZ/iUJ3P0PNB
 YijPyVGmHksc1dCecaUYj0UfJDR7tYSkVXBUgd3L0wDLk0pdQlhdbdyJ4lm4JsR3y4
 aBZN+YDUzmYoEY+IjdTnkXsdxWWPye2P17N7X1bp7IATaYvTeRMmSaQq1NoZBN/PvY
 jdiftp8hpic5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/14] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org,
 Frank.Li@kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, wsa+renesas@sang-engineering.com,
 ojeda@kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, imx@lists.linux.dev
In-Reply-To: <20260911124540.279841-7-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:56:29 +0000
Message-Id: <20260911125629.A9D861F00893@smtp.kernel.org>
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

> Set the panic type and QR version in draw_panic_plane() as a single
> point of truth. Pass the values into the individual drawing functions.
>=20
> In the test case, always create a QR code with version 40 (i.e., the
> highest supported version).
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D6

