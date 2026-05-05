Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23462FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 11:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3960810E122;
	Tue,  5 May 2026 11:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jzfwOzLH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2AD10E122
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 11:06:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CDA060125;
 Tue,  5 May 2026 11:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33282C2BCB4;
 Tue,  5 May 2026 11:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777979207;
 bh=0onDcxTBodQBgwwSm0B30wMaMYyRLfNlGLGhPMg4+X8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jzfwOzLHqtdrA5emAGfmg/YQ8rlXS93MHOn7Yr44v12fqm18Mn+NAKdmmvigAb7/x
 syomzHMbz0VZ0+JvPgFWiwy8Tm1Se1st6tPWizr82MgX7sUfi0bqAiXjcxKv50Ldyd
 HobVWPinvUpf0oaUt3pBitO+xtmLMZ7rI64zrxxqWn24apSvThx5EOZu5muPq8nNE6
 1QUnI3KJstNZWYJRb4u/5SbBCXiTLLDHBl8wgcmWwgoXoC5Vwc8CKRgow2hm5NMukN
 u4HlErkqDFGXJNOFv+ukvlV/wUu9YpmatyB6LOHhPPFSccU4wfxQs+IzHJTylbyqUV
 +7m7Xn89UYIYw==
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
Date: Tue,  5 May 2026 13:06:41 +0200
Message-ID: <20260505110641.3690508-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
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

On Thu, 16 Apr 2026 13:10:54 +0000, Alice Ryhl wrote:
> [PATCH] drm/gpuvm: take refcount on DRM device

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] drm/gpuvm: take refcount on DRM device
      commit: c2d72717e0a9

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
