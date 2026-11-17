Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2889606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmM2Fw9g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1C010F8FD;
	Tue, 17 Nov 2026 19:46:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52C8910F8FD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:46:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 37F7A42388;
 Tue, 17 Nov 2026 19:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2031F000C4;
 Tue, 17 Nov 2026 19:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944778;
 bh=ExUxqEZt6CeU083ngWOHRCSyuGGcbWbRoHP3g8HyKtM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LmM2Fw9gfbDi+AVGhDZOn7ni51zlC4OkduYjfN3OBYRvdmfWDKkYPZ/YqivYYyoVB
 CPf2z2Kj/kRf6q3kLA8XGFBtr9+0qUQ7N6QBOKcni0jUtLOTVjlnax82oAHDwjWu4Y
 Wb/G/WW/jrS4grELIH7dPPX8KpI4RSnenwJ2u0vE1UMJbXLlfbrq3lsTTF8/u/aQaP
 py54S1IeA7dJ9DDvZVOHfdEFotBHUh3P15g7p+6QfaC8hZOljl4qxGzF3SnwRoxEAw
 a3WHCXcVXjBDOwKAyeOJdMeQpeaFQxF+dvYI0bItFrVlWpjOm3fNdphqpArg4MrbaF
 sFIqZRxnLbXMw==
From: Danilo Krummrich <dakr@kernel.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 linux-pci@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com,
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, markus.probst@posteo.de,
 jhubbard@nvidia.com, apopple@nvidia.com, joelagnelf@nvidia.com,
 ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org,
 zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev,
 jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org,
 dri-devel@lists.freedesktop.org, peter@colberg.org
Subject: Re: (subset) [PATCH v6 00/11] Add Rust PCI SR-IOV support
Date: Tue, 17 Nov 2026 20:46:06 +0100
Message-ID: <20261117194606.1892840-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
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

On Wed, 11 Nov 2026 14:33:25 -0800, Simon Song wrote:
> [PATCH v6 00/11] Add Rust PCI SR-IOV support

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[5/11] rust: device: clarify the drvdata_borrow() safety requirement
      commit: d66d8bbb0316

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
