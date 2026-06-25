Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F9BCDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1610410E2A9;
	Thu, 25 Jun 2026 21:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aXaG0RFQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496A310E2A9;
 Thu, 25 Jun 2026 21:24:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E224341707;
 Thu, 25 Jun 2026 21:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2671F000E9;
 Thu, 25 Jun 2026 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782422656;
 bh=wImZ55sVV9nR2X0lKBaLNBzw+hjAxNnCMhbKwyH8aIc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aXaG0RFQ2QD6DQCWgtnBEW1Fo/ftIhfkexvZt0D32is5v/ZS9+MlTaUQxnm2VZTtM
 31Usjl5AD3CIpRNfKuLtC8jRxljf2PvrSCxTddGaQjlQdbzll39yCZ2MmRqGRigE0g
 pRhiopc5kg8pPWvHV19qK2yS9tSQd/yhOTthcgysbZ1QpJYUEfnbKqKJIjL3f3UTDw
 +HlM5LHosr86Kb5JwdOTzjOKmdrpkYiVceZlFFLGul9zpuSN07HYcEVb5q45eEV/f8
 lAezZYXiEtZnmvqYFKw5mfV9phwf5qNel1z4R7V+EnnjGYn/Y8sg/YRk9vg/XcuVIz
 8tgYvK0DJe8yg==
From: Danilo Krummrich <dakr@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Danilo Krummrich <dakr@kernel.org>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: (subset) [PATCH v21 0/4] Rust bindings for gem shmem
Date: Thu, 25 Jun 2026 23:24:08 +0200
Message-ID: <20260625212408.1618423-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612194436.585385-1-lyude@redhat.com>
References: <20260612194436.585385-1-lyude@redhat.com>
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

On Fri, 12 Jun 2026 15:43:32 -0400, Lyude Paul wrote:
> [PATCH v21 0/4] Rust bindings for gem shmem

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[3/4] rust: faux: Allow retrieving a bound Device
      commit: fa8cc4e3067f

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
