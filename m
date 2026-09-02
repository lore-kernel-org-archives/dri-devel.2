Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB28C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A2210E187;
	Wed,  2 Sep 2026 10:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OBSVFzGX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1061010E187
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:06:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E908241A9A;
 Wed,  2 Sep 2026 10:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0E51F000E9;
 Wed,  2 Sep 2026 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788343592;
 bh=ufLAySM7AAtOX70lZUDTqhAg0NA70sDLC1WuvXPgccw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OBSVFzGXlIgc+mvttW5VInpnc6S1Ck7qUdjgdhQDSjH69DtIDuDAuC3bXBSF0EIN/
 vWLtRO3kmt1tZu4kS6CW3C5NzmbM1KyGN6YU2WgswnQJ4omSlPNDr58qCo01xyAXxl
 2+T1iT33AFv/6z4gtbDnTrprn7+8MF3h5RQ0CwWkWr4VKZYoNKOwtmSm2WghGYBRJw
 sD10BBcoc/1eDjP7uXysNjpIJNlTsweyrp2Ig9g5tvS/GyMZBoMokdWZ3EqV3Fhz2l
 +cww+rf4ebEC0S+fifrS/TCdraZJCrR9fiW+NLkjcR2GfAr2nMrgKUie9HNt9wnWap
 NWqPDzp0zXRYQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] gpu: nova: fix incorrect GSP barrier usage
Date: Wed,  2 Sep 2026 12:06:23 +0200
Message-ID: <20260902100623.15225-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
References: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
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

On Tue, 01 Sep 2026 21:59:31 +0100, Gary Guo wrote:
> [PATCH v4 0/2] gpu: nova: fix incorrect GSP barrier usage

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/2] gpu: nova-core: fix barrier usage in CPU->GSP messaging path
      commit: 9e270c4fd863
[2/2] gpu: nova-core: fix barrier usage in GSP->CPU messaging path
      commit: 6cb331644c44

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
