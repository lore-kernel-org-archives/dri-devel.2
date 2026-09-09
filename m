Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFBCC79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5647010F02B;
	Wed,  9 Sep 2026 09:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HnBsI5IY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BA9810F02B;
 Wed,  9 Sep 2026 09:08:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D38C442D81;
 Wed,  9 Sep 2026 09:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF031F00A3A;
 Wed,  9 Sep 2026 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788944927;
 bh=aGy2CgXcDQ+imoqZ54TQ20ORwgTZS//UONFDVx4wO38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HnBsI5IYLcvodTY3L4QakZStEfXVkXUh40PEmUWn2q/7weiPCHjjC9aU0A1ZFA3Nb
 dQJ7ae9zuyBeSVtlPLhR0bquvmOVpEjaRKw7YNEujmIlo6am3iUMD/7qw4tNL+IiOr
 JNh9QQKANjGx7x4FAyyh2/bH+QdxbJmj/LOYqrS2IQlI/OX+O2WEzqJd3JnZwy7Hzh
 HZmvTaeGylVIDzEI44+zOdvqPxBoVU5MdsEwNeWBP6se+abqAHncGy4w9nearuE+U3
 E7yxTq2XE9HZWJSf4RjexKltwSB/ElGUxIkc6vu+Nco0G+ahjpJD8d+U34xZpNYkOZ
 p4o/h7hvh9ghg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/14] drm/panic: Return -EINVAL if font is not
 available
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, Frank.Li@kernel.org, ojeda@kernel.org,
 gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, intel-xe@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260909085826.64529-4-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:08:46 +0000
Message-Id: <20260909090847.0FF031F00A3A@smtp.kernel.org>
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

> Font lookup does not allocate memory. Hence reporting ENOMEM on
> failed lookups is misleading. Report EINVAL instead.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D3

