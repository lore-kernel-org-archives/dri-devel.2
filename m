Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C915C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4FC10E5A8;
	Sun, 27 Sep 2026 12:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MLk5Bag7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD7D10E5A8
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:17:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 689A7418A6;
 Sun, 27 Sep 2026 12:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DB61F000FF;
 Sun, 27 Sep 2026 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790511465;
 bh=xqUE0FvGfdn5OiuSuPy19yIzKGKDP88UyxFWANSnq/s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MLk5Bag7wHxI3dJM0t9PJz4F2e+NVdZV19mbINhhK/kYuSHzH8BZpwDk/Y5tIER/S
 m1HVieCPTX9A2AKHOD8e4jww1HoI6EZyrYi322EcvBOd27x3rnjVoIih0akEhB+7mK
 ZM6+riKOQOfyiqOdw/0T/lSGmJTZrOW/F2dh1mJgfdDEw2zjhbXW5HRp8hWReRRbaM
 qYo+NsR0jM2hxy8HtMPVPne+DHMoaGlXXwVjD0zSRKV8H95r0h19CZAIyqOfKrAwod
 h/BnSAGuqayDQP1P4fDQWbZpQrjbYKDtW/sPbtJGlE9DgLP3kWw51v5NHGdVXSCOSM
 g7qh83mw1jupw==
From: Danilo Krummrich <dakr@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, nova-gpu <nova-gpu@lists.linux.dev>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to
 nova-drm
Date: Sun, 27 Sep 2026 14:17:36 +0200
Message-ID: <20260927121736.1186364-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
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

On Wed,  9 Sep 2026 16:44:53 +1000, Alistair Popple wrote:
> [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to nova-drm

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/13] rust: auxiliary: let registration_data_with() closures return covariant sub-fields
      commit: 4075acc9d489
[2/13] gpu: nova-core: Add public driver API to nova-core
      commit: 6e70b1719991

      [ Rebase and use pin_chain() for Gpu::run_selftests(). - Danilo ]

[3/13] drm: nova: Add DRM registration data
      commit: ecedc604e0aa
[4/13] drm: nova: Add GPU architecture enum to nova-drm UAPI
      commit: 342aaa7bb3cc
[5/13] drm: nova: Add chipid enum to nova-drm UAPI
      commit: a1678ed1f8a3
[6/13] rust: uaccess: add UserSliceWriter::write_truncated()
      commit: b40f5ed85c5f

      [ Inline write_slice_partial() and use it to simplify write_truncated().
        - Danilo ]

[7/13] drm: nova: Add an info ioctl
      commit: ce6e59897ba5

      [ Avoid 'as' casts (add From<Chipset> for u32, From<Architecture> for
        u32 and use IntoSafeCast, IntoSafeCastArch); improve / simplify a few
        comments. - Danilo ]

[8/13] drm: nova: Add usable VRAM size to GPU info
      commit: d9886a1a06cd
[9/13] drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
      commit: 7edc491f6fca
[10/13] drm: nova: Expose a render node
      commit: 843bb3ccde8e
[11/13] drm: nova: Report GPU name in GPU info
      commit: 391cc215d22c

      [ Use ..pin_init::zeroed() instead of ..default::Default(). - Danilo ]

[12/13] drm: nova: Report GPU short name in GPU info
      commit: e6d9c5b08c23
[13/13] drm: nova: Report GPU GID in GPU info
      commit: 10a6623a24a8

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
