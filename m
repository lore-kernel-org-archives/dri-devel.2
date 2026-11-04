Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D0606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=g+E50zIf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E395610E880;
	Wed,  4 Nov 2026 10:16:46 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084EB10E880
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=hGoF+Ux3/C2DVxPoGimJzT2bsRivtHVvoj8jLzbT9PE=; b=g+E50zIfhYHSxqKnfX7DkcQzlX
 cEto4q6vRSnDqE7UsTJBYOCSE4IGm7pYvK1w3Oh//NGAbdEsWVShoQlwkXeczeTwJ+FHOmmd/4iF9
 WpgVsoKeh/pgyX9e2XWsNThyMaX/m6mt97NxivncogOAig4W8fp1rGBDGAu4GaOjlDBpdsFLMq1WN
 BLBP2MPgocj7g8uCHxPd9eXkhtIRqfcuIfbSze/ncsp0jT866953UAjdD0yviaOYyDjLiliO7phYg
 97poZRA2DpS5RD9sfFz6D9LsetmTfSt4UnS6nZTIm5D8Jwj2sgUwGDvh9QeyII0AzULZyKIiD01p1
 gLLJH2Ww==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Igor Paunovic <royalnet026@gmail.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Guangshuo Li <lgs201920130244@gmail.com>, Jiaxing Hu <gahing@gahingwoo.com>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v2 1/2] accel/rocket: release the shared device's devres on
 teardown
Date: Wed, 04 Nov 2026 11:16:37 +0100
Message-ID: <1888503.5KxKD5qtyk@diego>
In-Reply-To: <20260731064933.12548-2-royalnet026@gmail.com>
References: <20260731064933.12548-1-royalnet026@gmail.com>
 <20260731064933.12548-2-royalnet026@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Freitag, 31. Juli 2026, 08:49:32 Mitteleurop=C3=A4ische Normalzeit schri=
eb Igor Paunovic:
> rocket_device_init() attaches its allocations to the shared "rknn"
> platform device via devres: devm_drm_dev_alloc(), devm_kcalloc() for
> the cores array and devm_mutex_init(). That device is registered at
> module init, never binds to a driver, and is only unregistered at
> module exit - so its devres list is not released for as long as the
> module is loaded.
>=20
> rocket_device_fini() only calls drm_dev_unregister(): it does not run
> the drm_dev_put() devres action or free any of the other entries.
> Every fini/re-init cycle therefore leaks the previous rocket_device
> (with its embedded drm_device and all drmm state, including the accel
> minor number), the cores array and the mutex devres node. The cycle is
> easy to trigger: unbind the last bound core and bind one again, or
> fail the first core's probe (-EPROBE_DEFER retries included).
>=20
> Observable symptom, RK3588 (Orange Pi 5 Plus): each unbind/rebind
> cycle of all three cores moves the accel node forward -
> /dev/accel/accel0 comes back as accel1, then accel2 - because every
> leaked drm_device keeps its minor pinned.
>=20
> Wrap the initialization in a devres group and release exactly that
> group wherever the device is torn down: on the rocket_device_init()
> error path, when the first core's rocket_core_init() fails, and when
> the last core is removed. Each fini now frees what the matching init
> allocated, and the accel minor is reusable again.
>=20
> Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>

not to self: patch 2 became part of the dvfs series
this one (patch1) still seems relevant


