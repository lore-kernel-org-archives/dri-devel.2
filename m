Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78FBC44515
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 00:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C40310E22E;
	Tue, 21 Jul 2026 00:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KCTO5gGm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3FD10E225
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 00:01:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFFBC60A7A;
 Tue, 21 Jul 2026 00:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC64D1F000E9;
 Tue, 21 Jul 2026 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784592099;
 bh=W3vyD/7t60LbCA/yrBlYWSeKqmBr5qpMh3Ao4f4ubW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KCTO5gGm3QvfswTvqNDSICGaIFIn9IW/ZasYg8APPK4R1EBzVdqdj2S5lc4SzVnUM
 2/kqdeBs8EqMYNdXFzZxeWhbMbPBliV3vyl2U9/Wg1WNTkukwWqhVS1Gg+P89fhWE5
 ifyCbTWwgUKQEX6bt/hSVJvPOEnE2TMN+ersuwzbtdWn6mVuTOQUD4wWoB6HAMC0km
 BccSEsUDH5luV8MMG6HND1yDSMj82fK+Abd+yX62hCP8RNAH5dG7wCBfzTz1NHJQuO
 b4wMQWd6AbT3cvyz1GOPhwk6L8gw/k48aKg3tqB0DxVlpk2dd+zvOOQ04wOgRbnlii
 g+vs4tSDje0Hw==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and `CoreInternal`
 invariant
Date: Tue, 21 Jul 2026 02:01:32 +0200
Message-ID: <20260721000132.1304294-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713201455.640151-1-gary@kernel.org>
References: <20260713201455.640151-1-gary@kernel.org>
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

On Mon, 13 Jul 2026 21:14:54 +0100, Gary Guo wrote:
> [PATCH] rust: device: make lifetime on `Core` and `CoreInternal` invariant

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] rust: device: make lifetime on `Core` and `CoreInternal` invariant
      commit: f7acb19abcd8

      [ Fixup the debugfs sample to use an explicit lifetime instead of
        Core<'_>. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
