Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40EECA9EC5
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 21:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE02710E056;
	Sat, 10 Oct 2026 21:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IOU1OmL3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990DF10E056
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 21:27:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 99E16600AA;
 Sat, 10 Oct 2026 21:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47691F000FF;
 Sat, 10 Oct 2026 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791667655;
 bh=aBOErNgj41UkSd+ckoD6Tnh7MLen1S5T/m2ZSiZ/A58=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IOU1OmL3weTIU0MAQOnGsqgyCc1AGFSvDtAO3qreXjJ43hAx2tKhZR0qKM8yqvlZq
 cO7bQR28+IbL5qkK9MCFKPph6e5p6+bTYbVBqMtiX8GFlWT9dqpYR3cC19v+2jN/Vq
 Kux0ZN7GgUP9zcgJXqhaP0WlsKMwG6BX/RGJrJJEcs4iHMXcYrx0OU6LKE1HxRQJ23
 xOFKG/5rser1Ar6FA5HwglslQu5WB/YmN4mYD06Y0WLAPkBwwPMe0BH1FAQ9eNHg95
 YQfAq/p1yoA/QcIFyEoNnh2RrCj97VD17UXbZ+q1LksPhTQEPgnHBSPvQxW9lKBpFd
 Iq+HOqunULTPA==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, acourbot@nvidia.com, daniel.almeida@collabora.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: drm: Return impl PinInit from
 drm::Registration::new()
Date: Sat, 10 Oct 2026 23:27:29 +0200
Message-ID: <20261010212729.590021-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260929190024.2248099-1-dakr@kernel.org>
References: <20260929190024.2248099-1-dakr@kernel.org>
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

On Tue, 29 Sep 2026 20:59:30 +0200, Danilo Krummrich wrote:
> [PATCH 1/2] rust: drm: Return impl PinInit from drm::Registration::new()

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/2] rust: drm: Return impl PinInit from drm::Registration::new()
      commit: 700eed1364e8
[2/2] rust: drm: Remove unused flags argument from Registration::new()
      commit: d511064b2e73

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
