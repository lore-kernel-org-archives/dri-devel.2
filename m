Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F17606BA45
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYEp1CcF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C7F10EF98;
	Mon,  2 Nov 2026 15:08:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2523E10EF98
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:08:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4ADB66053D;
 Mon,  2 Nov 2026 15:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8636D1F00A18;
 Mon,  2 Nov 2026 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632082;
 bh=x9Hqqsl9MJqk2+H/AcnqKEgvlj98SIvK5idOHtd0XmU=;
 h=From:To:Cc:Subject:Date;
 b=kYEp1CcFjkvMSgj09SKJcdpImoLX9XUhUobPf60D4GoJpnT98QSJjfg+vekciPWiV
 rgW9ws4KeSCMJkBaEZqRh2YrrawQzdGlhp1j4Y6CWP+8CmudCiCOMe/5VeVyXrcU90
 aOdwd+2jH0jUO3mkuAnfPjLwQpBfukf5SzGRba0Bmb54x3SAa5WvO6tjOlNafNfyCA
 WfqGJrvZfQS2jQ8NWjxTMWutFVlaiDGef8rDgKJVO+02Ui1LAiJ8mjRA1fIocI0cyF
 CWfScizMrADBLO8piHcZsL7UY1PWx4JyB+7czTeYGh2C9GwkicYfGJNmNHX37rjVAE
 NLRJ/IcOLGoWA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rust: Adjust dma_buf::DriverFence::drop()
Date: Mon,  2 Nov 2026 16:06:16 +0100
Message-ID: <20261102150617.527772-2-phasta@kernel.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While moving our collaborative drm::JobQueue draft forward, we
discovered that some changes to DmaFence are necessary so that the
design fits into various requirements regarding atomic context.

This mini-series is a requirement for upstreaming drm::JobQueue:

https://lore.kernel.org/rust-for-linux/20261016085724.1031766-2-phasta@kernel.org/

This is tested with current JobQueue and a dummy driver.

Philipp Stanner (2):
  rust: DmaFence: Don't drop on signal
  rust: DmaFence: Replace call_rcu() with synchronize_rcu()

 rust/kernel/dma_buf/dma_fence.rs | 100 ++++++++++---------------------
 1 file changed, 32 insertions(+), 68 deletions(-)


base-commit: 9fe580fd90e20c8432832c5f9a7e92b049ae9af6
-- 
2.56.0

