Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58629C79F9F
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F8110E3E6;
	Sun,  6 Sep 2026 15:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dzrt7sQu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AA010E3E6
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 15:38:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C354600AA;
 Sun,  6 Sep 2026 15:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A361F00A3A;
 Sun,  6 Sep 2026 15:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788709079;
 bh=qujTTAenY66iMBvpfF/wGhfpHa/+EVc6m2bRgKRS1Vk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dzrt7sQuiawS1ShvEX7c3FSn2ooe75+eWPwy2HBqP4pkoMwnUcqAbEhguTMz0VZCm
 11TRp8LSMajjJGz4m+PS8eA0lSrDQs7Z6qjh4GU3jCixw5wswRil7VE7/Ex4cWIpqi
 KYwy2xzIwWQZ+166H2lou0b3nohO/FnzVztmIDXMNyBz5cHNl/kl8FClCdO7p+2NcG
 CxBZh8ZmyldiV/5CpoJ44aJswJA4CIlF3qCI2ss4jcLmCr2JaQ0hCJ9+5gMOQW3wu2
 KUS7qv0TSg4jdkBURv3acDeF9SX65q02/gUMJDPqwMWlUbqd+o+W+iYoB29zHiTp9F
 Cy0wFSwtEImlA==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, mmaurer@google.com,
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] rust: dma: tie DMA allocations to the device's bound
 lifetime
Date: Sun,  6 Sep 2026 17:37:53 +0200
Message-ID: <20260906153753.3207797-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193824.471089-1-dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
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

On Sun, 30 Aug 2026 21:37:12 +0200, Danilo Krummrich wrote:
> [PATCH 0/4] rust: dma: tie DMA allocations to the device's bound lifetime

Applied, thanks!

  Branch: topic/rust-dma
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/4] rust: debugfs: drop 'static bound from ScopedDir file creation methods
      commit: 9dc6cedcd971

      [ Remove unrelated change from Self to T. - Danilo ]

[2/4] rust: dma: tie CoherentHandle to the device's bound lifetime
      commit: f6b56da8e1b8
[3/4] samples: rust_dma: separate driver type from driver data
      commit: c3d4fd0e9d27
[4/4] rust: dma: tie Coherent and CoherentBox to the device's bound lifetime
      commit: bed87375f90f

The patches are in the topic/rust-dma topic branch and will be merged into the
corresponding target branch soon.
