Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F76CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 19:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D9EF10ED54;
	Mon,  5 Oct 2026 19:34:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kA6pMauX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5347810ED54
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 19:34:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14DEC4090E;
 Mon,  5 Oct 2026 19:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB60A1F000FF;
 Mon,  5 Oct 2026 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791228856;
 bh=gDFT2yZzDGeZYymSPwekJ7FbvmPKc+UT1GuzyaabfV4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kA6pMauXx3Gc9gfQ2ST8ypnmG2GV+jn1PT8qcSpBO9Q37Sv+EN0f30JpY1qUg2EsU
 /8ifPWyR2NZu7PX9Hb2ksdnVHvmD6jZvKA1+yHYvchxCY++fXqL4TbxfHmOW/JF+tw
 A1opD+0fXv8mDE7KiHkeCrkTOh5qsoRvGB5wac+g558vo0fgYVLwb28kSPUKaA2AgK
 Dn0P7YIsBf/VifxU/ldt0onkQbEbpG1HNZMRW2AwcyxySkrKKFyMWCTz5YoGTIBeWk
 BvuSm2QudwSx05KtyCnizaod+w78dwNUVNRNOwLNlzX33OC9WoqEPo3IVZ8ZUf0xtW
 8ECr8KxFWmk7w==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, gary@garyguo.net, acourbot@nvidia.com,
 apopple@nvidia.com, jhubbard@nvidia.com, ecourtney@nvidia.com,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: nova: Move VRAM BAR size query to GPU info
Date: Mon,  5 Oct 2026 21:34:07 +0200
Message-ID: <20261005193407.26849-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260927142258.1260711-1-dakr@kernel.org>
References: <20260927142258.1260711-1-dakr@kernel.org>
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

On Sun, 27 Sep 2026 16:22:09 +0200, Danilo Krummrich wrote:
> [PATCH] drm: nova: Move VRAM BAR size query to GPU info

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] drm: nova: Move VRAM BAR size query to GPU info
      commit: 04476103b7bc

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
