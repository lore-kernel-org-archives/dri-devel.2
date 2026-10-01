Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3ECCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11C410E253;
	Thu,  1 Oct 2026 09:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WqBd1SuR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C2110E253
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:30:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C53F26022F;
 Thu,  1 Oct 2026 09:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA61F000FF;
 Thu,  1 Oct 2026 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790847043;
 bh=99LV95f1xIKtrMVKjb5aRj2PTIljFKM7rgYHI41gAE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WqBd1SuRgTSK+7cAvzz3T4w2lVVpV6TvMkXKhkhWyXS/raBXIbFmMdVmwPjqOmBVy
 ycQPc2yvvrzZxnY7gMsrg+QMQIo/REqgwvdKN4QRkBWhStePy2dZaH536oobk98fKS
 70NIr1gRXnFLj4DitwLtEOwA+wdPigU0yx6gWQYNQkjnQSeRTBzDY39QKlNZicdWO9
 ZuCrOVGj6AB2qarTqkNJtHsJCoTWTWcIHQRekrMjOAoz/jXGbCbbPx4AvThbnr083+
 /Mjf+RCNhDIcUY5fK6qER1wxHKLT0brLganLigvEIHCRRua7HWzS+6vcOHwrCRh+Sa
 DYXxGeXFQ6J9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/qxl: return -ENODEV for unsupported revisions
To: "Matheus Alves de Almeida" <matheus.aalmeida@inf.ufrgs.br>
Cc: "Eugenio Perez" <eperezma@redhat.com>, dri-devel@lists.freedesktop.org,
 "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261001092506.76201-1-matheus.aalmeida@inf.ufrgs.br>
References: <20261001092506.76201-1-matheus.aalmeida@inf.ufrgs.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:30:42 +0000
Message-Id: <20261001093043.30BA61F000FF@smtp.kernel.org>
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

> The qxl driver currently returns -EINVAL when the emulated qxl revision
> is too old. This is not a driver initialization failure but rather a
> match rejection, which should return -ENODEV.
>=20
> Change the value returned when the qxl revision is below 4 to -ENODEV.
> Switch the DRM_ERROR() call to a dev_err() call.
>=20
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092506.7620=
1-1-matheus.aalmeida@inf.ufrgs.br?part=3D1

