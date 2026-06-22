Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23969CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F11010E4B3;
	Mon, 22 Jun 2026 06:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T8e2mjqW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B48310E4B3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:50:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 25D6841757;
 Mon, 22 Jun 2026 06:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F1B1F000E9;
 Mon, 22 Jun 2026 06:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782111059;
 bh=NVnyTRPD61W0aRoePmaoS6KjQ8NYkowKjU8NWMyJDUE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T8e2mjqWHrwlUeI7CmUmYa27JevODNTsqtQsq4r4mXosCju3/qoeFU36cj19otCSR
 KNwYhYLppbB5TeIdAG4XF3E34sfx1uD+2Pzg0OqFralM1SwnlU4k4BwvhXXf+lFhse
 Ft6Q8MmB1A2V0OqlU4LAacLotE8QXkpjiNdcsAeRph+2nzPwgNJEYDpWSa0mK5sy3m
 +uI62ikyrRDAf8lUIhGgYMI+ouAxn0aF9gf0l1OcuQ08RquUP4jBQ4bvjVqxp9EwEv
 aFZBnah1Hm71Bq6sTLlyporP+X6vS6R0RkDxt7fRiJwLR/BqaAWtdmBazajduWDE5Q
 YSVShrHAyxdFA==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Fix a strange error handling path
Date: Mon, 22 Jun 2026 08:50:55 +0200
Message-ID: <178211096494.2479863.16578340445085955696.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
References: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Thierry Reding <treding@nvidia.com>


On Sat, 20 Jun 2026 21:23:14 +0200, Christophe JAILLET wrote:
> The resource freed at the 'put_aux' label is "sor->aux->dev".
> However, this resource is taken after devm_tegra_pmc_get(), so there is no
> point to release it in this error handling path.
> 
> This is harmless because put_device() will be called with a NULL pointer,
> but this is confusing.
> 
> [...]

Applied, thanks!

[1/1] drm/tegra: Fix a strange error handling path
      commit: e60d3f9b4c89ffff5472ddc2829d5e29bcb153fe

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
