Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B8FC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1965D10E915;
	Tue, 25 Aug 2026 06:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wdotlt63";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCB010E915
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:29:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 271E740685;
 Tue, 25 Aug 2026 06:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FC61F000E9;
 Tue, 25 Aug 2026 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639381;
 bh=MW+kIda9mc2VpVFV9Y+rTGTjgmHQN2vbXA8UZx1K1sw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wdotlt63Folg7dj0lbjDEL3hVs3NETUQwxnStXmLhizOYoUGcpCdEs2w5gHpjqU5d
 j56Apju+0WwmEa7d2zdirPauoQp5DY1VkyhbjUwB7fbKjSqheYN0pyvEkD1InQ5G+G
 nO37ZvMQQzuoyjjvkZhSmlseowNUlxx4y4zVkqmK43u1JDwEcKHTfjqN2URZyJAv+G
 /RlAB2AcvxzQO0TCfIRRsk40eZN/UQ/nHhZ7PZiVqjyby1ja+IwuFnumETdtaUltq+
 dwSU6g0TrkUXlU4mtZttj9NLVS8uw2dzK5C5ihGSjzMGRzgk+T8f0RfudA9hPZea4u
 M14GUcpd3xvZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
To: "Leon Romanovsky" <leon@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:29:40 +0000
Message-Id: <20260825062940.C7FC61F000E9@smtp.kernel.org>
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
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
>=20
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
>=20
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_in=
validate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-document-d=
ma-buf-v1-0-5ecfb3e1371c@nvidia.com?part=3D1

