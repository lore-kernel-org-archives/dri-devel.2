Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F60CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 11:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D64B10E04D;
	Sun, 11 Oct 2026 11:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eXfrgyYs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A165C10E04D
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 11:07:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B6D2140242;
 Sun, 11 Oct 2026 11:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58FA1F0089B;
 Sun, 11 Oct 2026 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791716842;
 bh=Oik8iihpD7ypx2jJq/lf9p4T0lstK2shbSri1jc4hJo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eXfrgyYs3nldRI9/PyJ7IZn6pt9uf3Zp0qyTodFAMB0+kXiNPpLKFPKwS7j8v4aiI
 m6O9GzU8YoKUss9rfh4cplxrY3eCVDHhxV3G6xaBww5QRmGCV32ERu6FuMp/TVdIn4
 pOexm76lagOSA5LNdaXRfmrLWow4c7ZX446DDQiuCjY10Na/6zQgjN/s8LgJHH+Yqt
 NH6O0HzexQTDEgAaG/OnZHQ6g76Si4XU/jBIpL3q7QgTPBskyXeeTZldHOnMSKzTKD
 eiiHiuYpzhszph+TLhj6EHpDnK+ZXOdu4rC1/+xw7XGEH+h7v1CNwYdkalRDcP0QaI
 NVfjq2rq26E1A==
From: Danilo Krummrich <dakr@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, Timur Tabi <ttabi@nvidia.com>,
 Tim Kovalenko <tim.kovalenko@proton.me>,
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] gpu: nova-core: firmware: fwsec: use KVVec::zeroed()
 to zero-pad buffer
Date: Sun, 11 Oct 2026 13:07:18 +0200
Message-ID: <20261011110718.724831-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007203035.162075-4-blum@kernel.org>
References: <20261007203035.162075-4-blum@kernel.org>
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

On Wed,  7 Oct 2026 22:30:29 +0200, Thorsten Blum wrote:
> [PATCH v3] gpu: nova-core: firmware: fwsec: use KVVec::zeroed() to zero-pad buffer

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: firmware: fwsec: use KVVec::zeroed() to zero-pad buffer
      commit: 5a1b7121a6c4

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
