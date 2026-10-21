Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB3606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhJ+4UPG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C890610E013;
	Wed, 21 Oct 2026 09:56:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C281910E013
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:56:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D304660052;
 Wed, 21 Oct 2026 09:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE11F000C9;
 Wed, 21 Oct 2026 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792576599;
 bh=hU7HzZLc83zMlss5+YNu7AzVpfMiuG6aVIeozN0rE1Y=;
 h=From:To:Cc:Subject:Date;
 b=RhJ+4UPGwpJ38DZCMD/M/c23iamaCl6vhuqwHYSVC34qAUTTU554hnLqgRkuBMsS8
 yAOzALhvRZhRyZx030tv7Fzzz5cdJhgT13m67qW4lWcExWH1GrdXUES1luuTqtmVDx
 cxgbhjKut0zlnwMCVYUTqYFwlEXFhKtCGTfF25Ocy0idyzdmelDI4D0q4h+tBSEEAe
 YBGZN5ra5yzvn7A2EULSRbBdd+vbA+eJjd3D4s+RM7PcI09giLrXcSVP3PbcnqOlQc
 nCERN0fhUIYSlJIMf6q033bQwIJAuVp0+R0FZVCOBLyj+0ONaitQ9bxtbXFaovVugk
 TpotKukLzsl7g==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 0/2] dma-fence: Order is-signaled-bit
Date: Wed, 21 Oct 2026 11:55:11 +0200
Message-ID: <20261021095512.1345191-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v2:
  - Add a set_bit_release() function for proper ordering and use it.

Based on the DRM branch drm-misc-next

Philipp Stanner (2):
  asm-generic/bitops: Add set_bit_release()
  dma-buf/dma-fence: Order setting of the signaled-bit properly

 drivers/dma-buf/dma-fence.c                      | 11 +++++++++--
 include/asm-generic/bitops/instrumented-atomic.h | 14 ++++++++++++++
 include/linux/dma-fence.h                        |  6 +++++-
 3 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 1ecab8b0bad393750c60cc3819ce9c256595463c
-- 
2.56.0

