Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F3CCD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 22:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E10810F6A0;
	Thu, 28 May 2026 22:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FW2IwTF5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7EB10F6AC;
 Thu, 28 May 2026 22:29:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DAB4460565;
 Thu, 28 May 2026 22:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118821F000E9;
 Thu, 28 May 2026 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780007340;
 bh=AcmcKtW66rkEfNJaPB3hjWA/qrjMeNxbkC1G44RKtHU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FW2IwTF5y9ZTJHIUsJ2SS3nGEQy5vUaaBxX8bfIoe4NiHEvLjMAxJFtWijE0kOL0o
 DlwBmtz+uBzA+RYuar+B2CvYv8buHUqFwQj+JZIOQy6zbxLfoqW2IdVyNMJ3hkb6zz
 0GHVni9rBrJj14wdOuxBYq95Zhqp/5ceCowk8iHappxHh7uO/rAjH88BmivtumwsrW
 GcnH9kRUukwlWWGw+pxf7uXqS5BrU4h7+BTIznifQeucJw50GDkycao+ZC3AueXhn8
 p8RDOQ81JPE2Xty24VUsG+khyywa/ya162f3Se7MTc4RD1qGqGsM1rJutYosnTUu7Q
 mCWFeH29qG2LA==
From: Danilo Krummrich <dakr@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 0/1] DRM 'feature' support for DRM drivers
Date: Fri, 29 May 2026 00:28:54 +0200
Message-ID: <20260528222854.2129473-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507080914.95478-1-laura.nao@collabora.com>
References: <20260507080914.95478-1-laura.nao@collabora.com>
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

On Thu,  7 May 2026 10:09:13 +0200, Laura Nao wrote:
> [PATCH v3 0/1] DRM 'feature' support for DRM drivers

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: add FEAT_RENDER flag for render node support
      commit: 9c81596851a3

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
