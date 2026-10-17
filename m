Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CB5CCF2C9
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 21:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B987810E00A;
	Sat, 17 Oct 2026 21:35:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7A910E00A
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 21:34:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D72160142;
 Sat, 17 Oct 2026 21:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1361F000C4;
 Sat, 17 Oct 2026 21:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792272894;
 bh=b3tNsw/rufkVw2FNUIlrH38fofVkuarcnlw5luS4Mz8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OR8+RvZxJHGOW7Sd3HpJ2zdw8XaPtmekJ9tzoawMjzBEe8DIjfp3YXmsAcsdFnirS
 kjHS/rcg9SGvv1BPOn6Ev3Z91kzQDq6f5tZyRgw4E0IlJWWtH0o3DyrtMJOowYYlYZ
 StzWP+/CnFTCqC3d/A4rF62S5AZ5PhsYk1dDXudr0rc5CkZWkLuFtsfew4zmFQn4j3
 zrR8ilD7oKlLLZogh4JPruSiIwbKTbGxSMKobAkJu5+bIG3YAHqC3i/xIcSObyg/NJ
 ccLoi4qHA+mtUPMzWKxwW7rd+4d/Uy6BZxv5E1E19TQClqf7ok7TCUWGqhL204aNUg
 oDvqrPSnMoxHQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/gpuvm: skip setting kernel_alloc_node range on
 overflow
Date: Sat, 17 Oct 2026 23:34:47 +0200
Message-ID: <20261017213447.12656-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012-gpuvm-reserve-overflow-v2-1-519ef15e2172@google.com>
References: <20261012-gpuvm-reserve-overflow-v2-1-519ef15e2172@google.com>
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

On Mon, 12 Oct 2026 09:22:05 +0000, Alice Ryhl wrote:
> [PATCH v2] drm/gpuvm: skip setting kernel_alloc_node range on overflow

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/1] drm/gpuvm: skip setting kernel_alloc_node range on overflow
      commit: 5780281c4588

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
