Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823D4CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF42310EAC8;
	Fri, 12 Jun 2026 16:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kSmGtymw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2101A10EAC4
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:46:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98DE160008;
 Fri, 12 Jun 2026 16:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101121F00A3F;
 Fri, 12 Jun 2026 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781282790;
 bh=xlJzuU6TmaTLYEzbxxkSEEA1MjWF3vrZvIvvsp6g9LA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kSmGtymwTPk7yibzEMj4XckFr+ejhnLcHAUdL7SaOYU+QVBMjtCCpkUWadBbsXvXO
 16B73Dom+xa2vJgFhaPfHLjLe8WUF5igAuyKnvOcUy9rSDXurzmya09yyDqes3obUW
 DK9WTFKZ3hGunfOJzS86DkHh5GP6S6I0yU9aMeRxlUX6lyo4gRAvaPKjEs9B7Lg1/g
 OcnmlDKhS/QBNQQKyV6cNfITsv+yPCTawZLsln92nZ6qsMcBd1nYql0sTbwgQq4tOq
 vsxbm4AXa2a8i7iRxZlAEBtTqQ4jFL4vxD3Da4J5OugVAgIAI6uv0XMe7uvXzPQICT
 5BLNJFt0XsiYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260611161546.4075580-4-zhipingz@meta.com>
References: <20260611161546.4075580-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:29 +0000
Message-Id: <20260612164630.101121F00A3F@smtp.kernel.org>
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

> Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> wrapper for importers.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> the importer requests the namespace it can emit and the exporter
> returns the matching ST/PH tuple or -EOPNOTSUPP.
>=20
> dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> when the exporter lacks the callback and requires dmabuf->resv to be
> held while the callback runs.
>=20
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> mlx5 as the first importer.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D3

