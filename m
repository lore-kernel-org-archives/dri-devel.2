Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D35FF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 00:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920AF10E50E;
	Mon, 27 Apr 2026 00:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cQanYPIp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB1410E245
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:19:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B06C60138;
 Mon, 27 Apr 2026 00:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56B1C2BCAF;
 Mon, 27 Apr 2026 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777249186;
 bh=pQcztVIYnB6HM81PuBatMXyzSIxW/tn0+1fHdpnZNBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cQanYPIpp1Ms8FDiRaJyeabJVSVixFFsvXNPYTxrgUObPgVJkYiGLOXjrTwIOvxtw
 bRQab7txEy+4WvLZYDT0VyqH/k2sWU5Td1a/vACQFX/M+wfASPEUGA9zUYjfZLNTR+
 08b6Q5FosCD6frDh1HLoO/Sl8w2alxh2H1vyYFfLaXBtDtPVzmnDY3+o5dI/RDSPUI
 rafJIedYMVrDxScxG7Bs9up+gpcCXDuzRHNnVOxBteAIaRLWo5zV31HiuMZiHjtYJB
 miwdP87OsDv3QVqz8q/xG/bMYZbLGYc94DLy91HxswN8pIGtQxT03G+hTUXwof0c4w
 HwzXsnQ83iagA==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, jhubbard@nvidia.com, ecourtney@nvidia.com,
 joelagnelf@nvidia.com, apopple@nvidia.com, ttabi@nvidia.com,
 zhiw@nvidia.com, airlied@gmail.com, simona@ffwll.ch, aliceryhl@google.com,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: nova: update mailing list
Date: Mon, 27 Apr 2026 02:19:34 +0200
Message-ID: <20260427001934.1562415-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423124649.38793-1-dakr@kernel.org>
References: <20260423124649.38793-1-dakr@kernel.org>
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

On Thu, 23 Apr 2026 14:46:35 +0200, Danilo Krummrich wrote:
> [PATCH] MAINTAINERS: nova: update mailing list

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] MAINTAINERS: nova: update mailing list
      commit: 15e8bae5d930

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
