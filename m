Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A6606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opC0cO78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73E310E0A7;
	Tue, 24 Nov 2026 23:28:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6529210E0A7
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:28:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58FC960D12;
 Tue, 24 Nov 2026 23:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA681F000CF;
 Tue, 24 Nov 2026 23:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795562885;
 bh=e08IKl8cuBBIsRhTefRMXH9yyrlJ5903Bm6C16lOTgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=opC0cO78hR5M0GxIiFgeUlDOJYGAjpNo00je0ZS+32Tw1bHsTDC9+VWYDnI5bTUdG
 x82rcEJqjVFBrR/gavYI+bdes2Z8LWb3g/BZIxIH5fiVpz7ch/RgLaJtAwSyJqUVou
 ExcKrbpD4jnVjVGUCT6HAVN4RlFIT3ZTyC913Qhxm10dK+zoycDp1bcd1829W0QJHJ
 D7bmKf8SgFo3y7XNzHjI8ECLIjRB+VqJUFbvJfur4L78QQ4YsYmfeETI+W+fKSSHnH
 wqC8DIZZ86ctR2jYGQZzYZOrjzu3i36kR/5uYo9nv9B5pToBUz5Vz4aa/viSThR0yL
 cQOMWZqx3o6Lw==
From: Danilo Krummrich <dakr@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] rust: pci: add a prerequisite for the r000 GSP
 firmware
Date: Wed, 25 Nov 2026 00:27:57 +0100
Message-ID: <20261124232757.2443082-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111200549.160806-1-jhubbard@nvidia.com>
References: <20261111200549.160806-1-jhubbard@nvidia.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 12:05:48 -0800, John Hubbard wrote:
> [PATCH v2 0/1] rust: pci: add a prerequisite for the r000 GSP firmware

Applied, thanks!

  Branch: topic/pci-sriov-7.5-rc1
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: pci: add domain_nr() accessor
      commit: 002b9422b314

      [ Move domain_nr() to Device<Bound>, since pci_domain_nr() may access
        host controller data through bus->sysdata. References to the PCI
        device and bus do not necessarily keep that data alive after host
        controller removal. The bound context guarantees the required
        lifetime. - Danilo ]

The patch is in the topic/pci-sriov-7.5-rc1 topic branch and will be merged into
the corresponding target branch soon.
