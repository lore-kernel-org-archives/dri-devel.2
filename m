Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD71606A8A2
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3pbwZsz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CDE010EB02;
	Wed, 11 Nov 2026 11:45:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2538A10EB02
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:45:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4456B600E2;
 Wed, 11 Nov 2026 11:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AC91F00A05;
 Wed, 11 Nov 2026 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794397518;
 bh=9odmmksbvbXK9RpsONFmoCAl5mLWfbpD2OKCSrcI/Ng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E3pbwZsz6ScOB1sFCMSC8hMZAbKKzFDZi9iab8fbnpunpZlywdQ/WPNumIn5dMaeX
 Vdy2qAASqhIbJhv0bKzVWqQ+u70Dqnzp/3yMMdkWwqyFiRwfy/61+El+WXVq2OVrlS
 EZvtNABcLiRoCIPc/KT0MTFehP56I48ZjPiPzagAfcm1AV1J6LUW4iUGUVNZ/q3gr9
 MydRvthWo7O3BlsrSZOj2GIJyjXrj41ZbP3OpD99qTLawM4H24jXG2ihscwuqZ1Zpg
 78B2nHYAHY9MwFlS05aYiyjtwaUrXNzg5RPK5PkkRLE2Zy72tz/u3MdK53rNqu2VAD
 fJLn4qw4wXDwg==
From: Danilo Krummrich <dakr@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] gpu: nova-core: add two prerequisites for
 the r000 GSP firmware
Date: Wed, 11 Nov 2026 12:45:11 +0100
Message-ID: <20261111114511.562279-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110033655.148487-1-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
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

On Mon,  9 Nov 2026 19:36:52 -0800, John Hubbard wrote:
> [PATCH 0/2] gpu: nova-core: add two prerequisites for the r000 GSP firmware

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[2/2] gpu: nova-core: factor out and expose Falcon::is_processor_suspended()
      commit: 6e557330b874

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
