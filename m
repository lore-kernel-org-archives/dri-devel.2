Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C9C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2605A10F046;
	Wed,  9 Sep 2026 09:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZVxWZoFY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F64B10F046;
 Wed,  9 Sep 2026 09:22:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE2F54069E;
 Wed,  9 Sep 2026 09:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F331F00A3A;
 Wed,  9 Sep 2026 09:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945773;
 bh=ge/1IGXJ4zYvxqcd4Aw09mlZOq8fPEmfY+YddOC4X/g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZVxWZoFYvMMY9fkqVEG5Xr0jZ+fkWw5/kC4NUYisO29JiI489kt42kKCHIYSRFQJV
 W3C17ZC1Zd85U+uMltTNG4WqqsJSaEmWbVcFbF3vLD+0Byke5boxSc4lktGkDRhpHF
 hWDaN13d0NGfmaLqLcbec1DuDW5pbvwq5FvHxUzRsO7yje1rcRU2KRnhYU9BhKyJTK
 NPrz5d13SQ7rrJ7zB4nXHQiQRDmr3E8g1lblESvFRuhJNQb/8a7JT7God9KfjJgXDz
 ++++lNmQ1J3ch4y9F7WY13aw9DmgNJhjVDFUi7JsrgnikGXK6vp1PXYYTnP4kAH8Td
 fkJchNC093GHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/14] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, gary@garyguo.net,
 virtualization@lists.linux.dev, ojeda@kernel.org, linux-hyperv@vger.kernel.org,
 wsa+renesas@sang-engineering.com, imx@lists.linux.dev, Frank.Li@kernel.org,
 "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-7-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:22:52 +0000
Message-Id: <20260909092253.29F331F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D6

