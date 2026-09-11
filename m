Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCE4C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33ABC10F5EC;
	Fri, 11 Sep 2026 12:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IVJa/NO0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77AF10F5EC;
 Fri, 11 Sep 2026 12:54:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B00DC41702;
 Fri, 11 Sep 2026 12:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE541F000FF;
 Fri, 11 Sep 2026 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131294;
 bh=jWbxLHEaLpiGf2wWhzOi2PAKcNMBoXCPv2UhyZjIbrs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IVJa/NO04B0FF8fW1pjOaZiTDk/HG7CKpaAyhVW8pobq4XwTIya40MJw9nDRS+Ags
 OOOGIuCWN9TmYOmrrWqXIhMsRfsQl8G2z7rOhuoi3yQIb2snOQ6vJ4z812Wlkal3Su
 8SWULZVJ5KTGjnpCJTRwMgrjhJw5lO54SHtwuHSKW2wBbc3yO0yHUrd0pMkWjJN7oC
 lpZSzTBwMobvX4dkU8QseOm7soR8RN2WiqFGOPmSdZY1WgCQ5NblfkDVhM3f0M1T8Z
 jl9j0MqpL0bjfL71+JX4HVZIpWfbeDqHFHnCtHMEi0yDCZm//cjKqL60Cg5ZePc5+D
 U/Ezs6sBr+RKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/14] drm/panic: Return from screen_user if display
 is too small
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, gary@garyguo.net,
 linux-hyperv@vger.kernel.org, ojeda@kernel.org, virtualization@lists.linux.dev,
 imx@lists.linux.dev, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260911124540.279841-8-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:54:53 +0000
Message-Id: <20260911125453.EEE541F000FF@smtp.kernel.org>
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

> Return an error if the display is too small to display at least a
> single character. If the panic handler cannot display any message
> it does at least not destroy the current output, which might help
> with identifying the problem.
>=20
> v4:
> - also check font height against scanout buffer (Jocelyn)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D7

