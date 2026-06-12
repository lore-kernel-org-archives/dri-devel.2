Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF25CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D2010EB70;
	Fri, 12 Jun 2026 20:55:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AdyP5SMB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60C210EB70
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 20:55:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A31260008;
 Fri, 12 Jun 2026 20:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C881F000E9;
 Fri, 12 Jun 2026 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781297718;
 bh=iCD70DUh8GsBEQIl7jFunndrZwyktErUOz2kaJjSLO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AdyP5SMBxoQmwUxAYAsCtfbTuHIeupqTy6Bw/dKFOOnVjjm3GP9mH52RW1R1Q/oAW
 L0C2I6UUMQNSpwujny51K2FRCC6i0+Aj1S2QMjU6Z56UkxvEisR2XENqzn86Rh1Wtq
 xYEVx+KjcXCn6UN3YYo81s5Bdo4ygY1+Qn3FeiwMWOozEMqVDQ4iHoV70/dpthpTTl
 O/EpAmkGvd9ZC0eBkKnuX96rMtwK5jAp/5+hRHwQJ/zBQEgTfNcAWuPcXYsR22AdNH
 hXQt9ECqX8g8PcQM4e4Cw9yDaUyEbD31uLjN6BEzTbKiC5t0Rl0Eph4FX4c0s6iiZV
 3AZF7+TbKX7KQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 samitolvanen@google.com, laura.nao@collabora.com,
 boris.brezillon@collabora.com
Subject: Re: [PATCH] rust: drm: gpuvm: update DriverGpuVm for DeviceContext
Date: Fri, 12 Jun 2026 22:55:05 +0200
Message-ID: <20260612205504.836026-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
References: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 10 Jun 2026 17:01:26 -0700, Deborah Brouwer wrote:=0D
> [PATCH] rust: drm: gpuvm: update DriverGpuVm for DeviceContext=0D
=0D
Applied, thanks!=0D
=0D
  Branch: drm-rust-next=0D
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git=0D
=0D
[1/1] rust: drm: gpuvm: update DriverGpuVm for DeviceContext=0D
      commit: 20003c1a1fd8=0D
