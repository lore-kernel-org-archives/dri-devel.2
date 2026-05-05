Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85A6FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 11:07:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CEF710E15F;
	Tue,  5 May 2026 11:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iZyuQTWA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2F410E128
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 11:07:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E6ECA43727;
 Tue,  5 May 2026 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1D1C2BCB9;
 Tue,  5 May 2026 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777979235;
 bh=wW+Y7jhvehp4RpHP43OlmUCCpw/Ci9kVuViYSSsX8zE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iZyuQTWAj9LvurqQhPNVGSCSelmuixLByfHQE98AZXVKgBjeCOE+xf5RBBlfVDRiP
 yzxwB5gyRLVDW4MA6+PZXEW8OUAlSuKc0ppq7VXAjJEnQr9Jsuvm2KJCEGKSpfsdhU
 Ja/oLvLwOOCLJsJ9aMslIBYn8jtJV5gQzJL0CbDg3p7Pdd0WenkPmAG9vW9FdY9Tkl
 S2Rn6LT8r6bNrx23jkmH72vRPOL5FFlC7ZKk30pAvnx96YPISmp9wuXkwx4CZ3CDPs
 Ed4RDp9qZTOUo2PpEB3hoWZVIgZgPxwuqp01rXxbsY0cRjSULgh5uIesm4YPYqdMsI
 yj0tR9/WdwpRQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Lyude Paul <lyude@redhat.com>, Asahi Lina <lina+kernel@asahilina.net>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Rust GPUVM immediate mode
Date: Tue,  5 May 2026 13:07:09 +0200
Message-ID: <20260505110709.3690737-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
References: <20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com>
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

On Thu, 09 Apr 2026 15:26:05 +0000, Alice Ryhl wrote:
> [PATCH v6 0/5] Rust GPUVM immediate mode

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/5] rust: drm: add base GPUVM immediate mode abstraction
      commit: 82b78182eacf
[2/5] rust: gpuvm: add GpuVm::obtain()
      commit: 71a3921111bd
[3/5] rust: gpuvm: add GpuVa struct
      commit: 5540a9c747b3
[4/5] rust: gpuvm: add GpuVmCore::sm_unmap()
      commit: dc3846045f69
[5/5] rust: gpuvm: add GpuVmCore::sm_map()
      commit: 0b715b1e382b

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
