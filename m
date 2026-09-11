Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA305C88E58
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3D110F614;
	Fri, 11 Sep 2026 12:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cxHdELyr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7E010F60F;
 Fri, 11 Sep 2026 12:59:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 997C0439A4;
 Fri, 11 Sep 2026 12:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04FC1F000FF;
 Fri, 11 Sep 2026 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789131553;
 bh=RSA3hwWiVAI5e8mD1BhxYsRZcuSF+Yldi10e6XniacU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cxHdELyrmgeHyggNnfNgrFbzttzDwx1l2WQF+TteoyRW3ixuHS786L7eXq/xf4xon
 LeUQIRv5Fq243Uea7+9aARuhTK1GVqGKN/Lw0oWTxihYgRE0kWa2RxHU6xngEM/lxJ
 66B4zWPeaegkTl5gDgGGosDQe5ebULIjoCh4n0LdxekILyV4UP13nkvQydEMaat3zo
 FET2TqZI/PJfrqwuQ0GFk4VvsD9Feqooo5aWIIZR+qVfj6y1QemWz0EsNPZbNVaLbF
 1DhvVfdgkW3/cfBhhkLolN5aD7OGdSduj/orAFrUhA6lPQ+cm1C1h4F8z4qrOKncFn
 rNWZ+xMqaFYlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/14] drm/panic: Internalize panic locking in DRM
 core and helpers
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 Frank.Li@kernel.org, intel-xe@lists.freedesktop.org, gary@garyguo.net,
 "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 ojeda@kernel.org, imx@lists.linux.dev, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260911124540.279841-13-tzimmermann@suse.de>
References: <20260911124540.279841-1-tzimmermann@suse.de>
 <20260911124540.279841-13-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:59:12 +0000
Message-Id: <20260911125912.D04FC1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911124540.2798=
41-1-tzimmermann@suse.de?part=3D12

