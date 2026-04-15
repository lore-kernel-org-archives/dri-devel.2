Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DCFF433CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255FB10E1F8;
	Wed, 15 Apr 2026 22:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iOucmPgH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDD010E1F8;
 Wed, 15 Apr 2026 22:14:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EA8144289;
 Wed, 15 Apr 2026 22:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAEAC19424;
 Wed, 15 Apr 2026 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776291297;
 bh=dx2/GieGQas5ZAKeKK6KdkErC4+FKtE6PISPEw+PXos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iOucmPgHfgUrblt1bPIRS6oWss2sOJ4NWc5Vxpcu0s6lthbWz290pmsndn0G4RTAs
 OdxSLVdzrMWchbGqbvB7Y51Z5LrE5F6tkfvaebzqpSHx9VHD+/owzxjFfCKmdnAgs+
 H8Tzq8B3IxBORhqYP5cmCyaGFS3QmcLKr3+9cyQGMUJbHPT5D9PBgCdZ26XSoULSYm
 Klaypqqhxckw1eo7Jn3wrqhIK7/0iG1wr+ERmfDftaA2/MgQwDtGiQbz2ZoODs0mri
 4RSVhzKSIOyQKqsr7jLGB+KUOM9UBQXKS58byATbrOIEU36wqpHCHBM+KnXDTKhtu3
 a+6sFuphHXKJQ==
From: Danilo Krummrich <dakr@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: dakr@kernel.org, lyude@redhat.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, bskeggs@nvidia.com, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: fix nvkm_device leak on aperture removal
 failure
Date: Thu, 16 Apr 2026 00:14:49 +0200
Message-ID: <20260415221449.2911692-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411062938.22925-1-devnexen@gmail.com>
References: <20260411062938.22925-1-devnexen@gmail.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sat, 11 Apr 2026 07:29:38 +0100, David Carlier wrote:
> [PATCH] drm/nouveau: fix nvkm_device leak on aperture removal failure

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/nouveau: fix nvkm_device leak on aperture removal failure
      commit: 6597ff1d8de3

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays.)

The patch is queued up for Linus's tree and should land in the next -rc release.
