Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB34C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBE410ED01;
	Tue,  1 Sep 2026 14:04:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Un8UzOe7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D9010ECEC;
 Tue,  1 Sep 2026 14:04:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C399F416C7;
 Tue,  1 Sep 2026 14:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD371F000E9;
 Tue,  1 Sep 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788271492;
 bh=jPLfUhAriQbeMNme/A39zpXETQORrdj67BYHQz8lV2w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Un8UzOe7yvDiZlaJZYrUAKFkDH0TegzfLYcYwy+uq6CIxgPM01vHXE/PBTJaAXpT+
 8RD+s30Zgh3pa1hXsVaQ1qrZywD1ADplz+F5qoyL3AmIgUCjpgRaQoJ6H5Zo9/U8oA
 UatVwWKsocdWy/GE2xJ/pSlMMVpbC12NG/Y6dyfRtKvKASHCcP0nlcgNkdWWjUlDLK
 vWoFZc732Pz2vmoSXttFuMD93jSLT7QToAF3Kpd8tL4lKGThza1Z7hF/7/8am6ufN6
 BpjGPsn37pyqDkFAgL+6EqgW2FBfuytFEx70wR/cF3SPuiXzYolByTX7WNHJpXcLCw
 8fhzaK4ghHrNA==
From: Danilo Krummrich <dakr@kernel.org>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <balbirs@nvidia.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/nouveau/dmem: fix DMA unmap size and callocated
 accounting for THP
Date: Tue,  1 Sep 2026 16:04:42 +0200
Message-ID: <20260901140442.4036-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
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

On Tue, 11 Aug 2026 22:28:49 +0800, Zhenhao Wan wrote:
> [PATCH 0/2] drm/nouveau/dmem: fix DMA unmap size and callocated accounting for THP

Applied, thanks!

  Branch: drm-misc-fixes
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/2] drm/nouveau/dmem: fix mismatched DMA unmap size for large folios
      commit: caa1bc2a0a6c
[2/2] drm/nouveau/dmem: fix callocated underflow on large folio split
      commit: c2256c044a1d

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for Linus's tree and should land in the next -rc
release.
