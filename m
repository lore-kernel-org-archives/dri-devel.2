Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14891CD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 11:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3F610EA47;
	Tue,  5 May 2026 11:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kWdzXtP6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFEE810EA47
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 11:07:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C87C542CE8;
 Tue,  5 May 2026 11:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD805C2BCB4;
 Tue,  5 May 2026 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777979250;
 bh=+mbJVJDz2rcaV2Rf1wlZKgi0mA8pPdu5ECdaV+S2Tgw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kWdzXtP6UXfm/8sG9MhvRxaCCy/suLmBTIPHXRThX0U1riRxAojXd7JUJz9x7BhnB
 p60YXNWnMB+7HyqoN3CNCSCic9zs3Hva8jM5sDf8IlHpeNSvwn8zoBoTiDMZTU5MmU
 spcFiOLQFVSLcIKbs7EPZtiZ+6XW98KWOQliMdXoY70jV+JdR0R9WJA0oCxSfWQqyk
 KEC1oY8TAlU5yMwoY/Yxuo4JM6lMrsPec2uDBp9Sd95IYouRkcfKrTUt1s3sQSGHj9
 vOe6hmYl8HgIxu6EZ4tRB7mg040RwCZkK7KmY4DWsotnK8VP9P04cJDZckMro9FrJH
 72Bt3t72V0hzg==
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] drm/gpuvm: rust: add RUST_DRM_GPUVM option to Kconfig
Date: Tue,  5 May 2026 13:07:24 +0200
Message-ID: <20260505110724.3690888-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427-gpuvm-config-v1-1-8ece03771f8a@google.com>
References: <20260427-gpuvm-config-v1-1-8ece03771f8a@google.com>
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

On Mon, 27 Apr 2026 10:54:51 +0000, Alice Ryhl wrote:
> [PATCH] drm/gpuvm: rust: add RUST_DRM_GPUVM option to Kconfig

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] drm/gpuvm: rust: add RUST_DRM_GPUVM option to Kconfig
      commit: 37f748ed0c19

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
