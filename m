Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E78C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC5C10F5C4;
	Fri, 11 Sep 2026 12:53:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibpmoWmh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD09510F5B4;
 Fri, 11 Sep 2026 12:53:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 992C743B8C;
 Fri, 11 Sep 2026 12:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D6C1F00898;
 Fri, 11 Sep 2026 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131186;
 bh=umlie9Ka1hcJSUZ7ZKyqCNNpcg//Teh+0cvmbB1lL8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ibpmoWmhg+SiRt337t11Ih5xOAS0iJINn7ItR8apM3HUeu2hgGD4ohSs9nXlsjaX6
 qthWkwyPHE7FpmpzCru6JjLNkKi/GjGaI6EZHUpwyrUMPBB8hTMqd+cUnnu42oElh8
 JXwKEjaeUN54ZCiYlWpeeONfWrwhM3h2SG/isng4loZwLY6hpg2rfTsU1hgi6Z5j/Z
 EIlyYAqLoOQ8o1rbRtnGkTD0+r9OpQc4ZsfwmQvjoIuieLwvCKvNtViLTRnKktGE44
 W3CDXtHNmE2cq5ImiXKhH3uryXj4GvWi5r+3qg/XQN0Cwsw30m5k8gzTN2xV8slrIu
 ANxs4RS4mzTJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/14] drm/panic: Return -EINVAL if font is not
 available
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, imx@lists.linux.dev, ojeda@kernel.org,
 wsa+renesas@sang-engineering.com, intel-gfx@lists.freedesktop.org,
 virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, gary@garyguo.net, intel-xe@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org
In-Reply-To: <20260911124540.279841-4-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:53:05 +0000
Message-Id: <20260911125305.C6D6C1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D3

