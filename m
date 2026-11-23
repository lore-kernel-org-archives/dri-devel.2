Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D5606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EV17Nl5i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876A210ECAA;
	Mon, 23 Nov 2026 21:24:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1663610ECAA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 21:24:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D069140AC9;
 Mon, 23 Nov 2026 21:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1661C1F000C4;
 Mon, 23 Nov 2026 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795469086;
 bh=cq6IKWIDbNjpXPFLCpPgSkSFMVQEhppjAvx+3Gh01GM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EV17Nl5ivxnSJlgzd4GoYSA8ryGBP8bq1rrmS/gqJDgnxd/lG1tfJqHo24NdJM8Dh
 yr+svb8zeViArD1Wpdtnz3lWYq3EhpnOcZynuRXzvkUz7akiPZhgxOB1sp0rdcB41r
 QdEUr+8X2y9zWGM1YO7g1vZo2Xq3GudzIQD0bsVTSJGU9fP0MkNxVuVBMj5Te9iwYg
 E6pE49bAUkkuisy4cNLu0XRzO+2qA1ugZ4vyPQqauKT1jalA/LXhkY50bTkrPsQzAw
 wHXvHyM4CwTyMjuahnUntrNSTKLVW1YSKUJnpXQEbdZhm9WDm3oDXJ9zlVnoMqjyC2
 llBB7cPIJLN0w==
From: Danilo Krummrich <dakr@kernel.org>
To: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Joel Fernandes <jfern@kernel.org>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] rust: gpu: buddy: store the allocator inside the Mutex
Date: Mon, 23 Nov 2026 22:24:41 +0100
Message-ID: <20261123212441.1649255-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
References: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
X-Patch-Reply: applied
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 09:20:07 +0200, Ivan Tverdokhleb wrote:
> [PATCH v3] rust: gpu: buddy: store the allocator inside the Mutex

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: gpu: buddy: store the allocator inside the Mutex
      commit: 4325f4aad972

      [ Restore intra-doc link for Opaque. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
