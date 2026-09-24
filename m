Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B22EC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD0DC10E348;
	Thu, 24 Sep 2026 15:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iDR2bj4E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F1310E348
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:51:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1833F415D4;
 Thu, 24 Sep 2026 15:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA371F000FF;
 Thu, 24 Sep 2026 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790265094;
 bh=3UvAeCPkumitIVweVNw8lQWGNCzkNqkC9oqTuxhecZA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iDR2bj4Emd18d4ZRFVP7SInUoSNDbs0E2W6YM7La8ufGrBspNrvprqm48RIbA1xb8
 k6rWXRzcCMsR4xBZ2SQPiGAB2WMBQubhv+ikZQaz5CexlPw0VEN7TGiZMxnlMOVe1R
 kVCg7L1eubknEiL0VRNbci92eU//NJQCPt7t8eW0tjTa/gPaeh/JJWHeY1pE0njWK4
 hDxBmumdJ/043wjcbEERIBfdqO/OLZOndjhR0/FakY8e9GYPZIVqx9Q0vIa99v6ved
 g7Au1m/4GiFI7Qx+qVpoQuOiKc/PQo+g/y8mx2sSlVcD9fQNMmApURcOaAw26KY0Qr
 FB9Stu7SJge7g==
From: Danilo Krummrich <dakr@kernel.org>
To: Matteo Kloiber <kernel@matt3o12.de>
Cc: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 ojeda@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] rust: honor the maximum DMA segment size
Date: Thu, 24 Sep 2026 17:51:27 +0200
Message-ID: <20260924155127.96245-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913210828.125655-1-kernel@matt3o12.de>
References: <20260913210828.125655-1-kernel@matt3o12.de>
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

On Sun, 13 Sep 2026 23:08:26 +0200, Matteo Kloiber wrote:
> [PATCH v2 0/2] rust: honor the maximum DMA segment size

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[2/2] rust: scatterlist: honor the device's maximum segment size
      commit: c15c5befd6d6

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
