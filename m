Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A61606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrYN+lxG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B3710ECF9;
	Tue, 24 Nov 2026 22:21:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457AC10EFED
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:21:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 355D561F12;
 Tue, 24 Nov 2026 22:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ABE1F000D0;
 Tue, 24 Nov 2026 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795558908;
 bh=oKVvl+Rf2neqQIoPuWXSrWxr2CVrLHBFoRvvQa6Paew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IrYN+lxGsElt2tX2RKLt0jlr8DGHREKvRQCsdfuzj4oSeVObDlg+GTaS4E4ItmK/O
 GTnQEl9OeUwZ8FLbgZlBuY7mktztTpKEo8DxWIkN7obYttTBrSW0QSdccKOFGDLSAb
 cuSoVic+zf16VLR/VqHem6u9YOXinT1xxIq2ogCMd22cS27piSIXouNYQ1nYVdj/d5
 9y3dS+qAw6B6y3NiEqErSqa1lTbyuxe/u39MKemD/VBpbvnlXEFS6sPkIjmXQpC/qV
 rjIasUIJiWdEtLcZo6YTpq1iwphq14J0UeqU/nx/GX/zMYnM98sZ7kHGy8Il7LvmXg
 EeI37NNYWXCLg==
From: Danilo Krummrich <dakr@kernel.org>
To: Simon Song <xinmengs@nvidia.com>
Cc: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 linux-pci@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com,
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, jhubbard@nvidia.com,
 ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org,
 zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev,
 jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org,
 dri-devel@lists.freedesktop.org, peter@colberg.org
Subject: Re: (subset) [PATCH v3 0/9] Rust VFIO PCI support and NVIDIA vGPU
 driver
Date: Tue, 24 Nov 2026 23:21:36 +0100
Message-ID: <20261124222136.2363532-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
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

On Thu, 19 Nov 2026 13:50:35 -0800, Simon Song wrote:
> [PATCH v3 0/9] Rust VFIO PCI support and NVIDIA vGPU driver

Applied, thanks!

  Branch: topic/pci-sriov-7.5-rc1
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/9] rust: pci: add VFIO override device IDs
      commit: 50e74d48053e

      [ Slightly improve the doc comment. - Danilo ]

[2/9] rust: pci: expose the VF index within its PF
      commit: 563a20c3c250
[3/9] rust: pci: allow drivers to manage DMA ownership
      commit: 867380955ea7
[4/9] rust: pci: add reset callbacks
      commit: 4db2aa70fd43

      [ Slightly improve the reset callback doc comments. - Danilo ]

[5/9] rust: pci: add an error_detected callback
      commit: 817438b2de84

The patches are in the topic/pci-sriov-7.5-rc1 topic branch and will be merged
into the corresponding target branch soon.
