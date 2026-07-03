Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F53FC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 21:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4B6C10F96A;
	Fri,  3 Jul 2026 21:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KBcOODum";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2C510F96A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 21:36:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9356941AD3;
 Fri,  3 Jul 2026 21:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF271F000E9;
 Fri,  3 Jul 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783114589;
 bh=on+0HpAgKQyhjJn5Dg1ZrUTYDAf4czl4d0n8uNA+Vjs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KBcOODumzVQoMm+3+oN9E9Ub9STXhrK0iBJrbB/BNwbG5S9D4mcEu6zjGoGi0EO/A
 s2WVZonQv9nyY6W9gMIdxqmvh4rQNK3DFUpCBhwR0dR6PA71pIsPO0vVwXkL3bOyub
 M3l+o47PtT7iGWLkrx8W/vfnMvqouIJL/HyMob6ZtyW9yrP3gVJLAqqfy8pkalALI0
 8oP4mfZS1hqi9CDDt5E9vslf1jxxB+Yez0zB20Tni44cf4bu0Bnm7bNe970/yLrvL3
 s3oHMo8QM3s3bXrcAZ4Z/F7mG55QtdOKog1iDbJkbn9A2qeZLN4bW4M01uDh7/QAVV
 m/MFffwMl42yg==
From: Danilo Krummrich <dakr@kernel.org>
To: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 0/2] drm/gpuvm: Delete some dead code and fix a comment
Date: Fri,  3 Jul 2026 23:36:23 +0200
Message-ID: <20260703213623.1224109-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
References: <20260608-gpuvm-minor-fixes-v2-0-af07ef9ca969@collabora.com>
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

On Mon, 08 Jun 2026 23:33:51 +0100, Adrián Larumbe wrote:
> [PATCH v2 0/2] drm/gpuvm: Delete some dead code and fix a comment

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/2] drm/gpuvm: Remove dead code
      commit: c4c4434e41e5
[2/2] drm/gpuvm: Fix comment to reflect remap operation operand status
      commit: 49d0307c55c4

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
