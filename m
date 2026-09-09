Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A2C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F24B10F041;
	Wed,  9 Sep 2026 09:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KEdtIu5E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBF310F03F;
 Wed,  9 Sep 2026 09:18:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92613601FD;
 Wed,  9 Sep 2026 09:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C841F00A3A;
 Wed,  9 Sep 2026 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945529;
 bh=TxQ1SGVg5bf3+jdluA66EMwI/A8dCOwuitYEA/8Ik30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KEdtIu5EsimEJjwrs4A1JJMAIrfPyFZtTT4WGJAgu7Qm1RrxfHK9SVCfzLvdjiUhU
 5Lh32qMVt/PCDMfvbjXQN4JdFt0FW166yKhgyC4AUyz66LJn+liOOgz1jyOsfbmYsy
 E2zU0RxR4ANnEIfD/A5q6vLhv5/FVhNh7k33QD824d3PvWtqXcORnUlLBY4VpyW0OD
 Dj9vwi5j4b4h9uopFZtgu6STlFABjJ3u49EpP1oalIocjA5TF48HPEvLgI4gbA1qy2
 8pDn9KatKk195qrAWPn852P9ilzL4GpOd01NziOmllqOQIBEXOZ39I2btz2Raftdj2
 5CXraxBTo5LIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/14] drm/panic: Return from screen_user if display
 is too small
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, imx@lists.linux.dev,
 virtualization@lists.linux.dev, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, gary@garyguo.net,
 intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, ojeda@kernel.org,
 intel-gfx@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260909085826.64529-8-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:18:48 +0000
Message-Id: <20260909091848.A0C841F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D7

