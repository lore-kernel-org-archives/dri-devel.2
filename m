Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DE2C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E675B10E135;
	Tue, 25 Aug 2026 06:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R2BG0jY4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F0A10E135
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:31:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A1E043C3F;
 Tue, 25 Aug 2026 06:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453D41F000E9;
 Tue, 25 Aug 2026 06:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639472;
 bh=KjZrP57ZU+DM3j+jGBhwPMmD35cCb2vxUh+Ws1UXizM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R2BG0jY4RddYc7BWKHoxL4TazT3xOo6mB3i9rS98jXFltWr1ZP8QRuk1hasKxvvDh
 W/8zvEbcA5tLp6KREgyZx+mTkRoSXWDBhq3cjhm2WI0K8MzOPkj4xqslq5qHyKUsQF
 1hBZlETjR5YulW/HAaEYgjBaGHmbOfXQSblJWweN7iLgxFqeqAraFP4+zhUPqVuxTX
 ZXFEln3n1h4rvCp0WiB+OppdkinKGKABdPVfeIWKeSLJnZhF9v9n95O689F/6BVFXQ
 G1MbGDN9KnxxVpk+vVGVFxGTEprf6eXQY1jLpgZJOrBqzD56bkD8LrrKVBDR2SSKWz
 PgrhMP9k5OYLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dma-buf: Document how exporters and importers agree
 on mapping lifetime
To: "Leon Romanovsky" <leon@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:31:11 +0000
Message-Id: <20260825063112.453D41F000E9@smtp.kernel.org>
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

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Pinned, revoked and movable mappings are selected by which optional
> callbacks each side implements and by whether dma_buf_pin() succeeds,
> not by any flag or enum. Nothing in Documentation/ says so, and the
> rules are spread over the kdoc of dma_buf_ops.pin,
> dma_buf_attach_ops.invalidate_mappings and dma_buf_invalidate_mappings(),
> so a driver author has to know the symbol names before finding them.
>=20
> Name, per flow, the callbacks both sides have to implement to end up in
> it, describe dma_buf_pin() as the runtime negotiation, and record that
> the pin is what tells a revoke from a move.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-document-d=
ma-buf-v1-0-5ecfb3e1371c@nvidia.com?part=3D2

