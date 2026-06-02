Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07252CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D93C10E5D4;
	Tue,  2 Jun 2026 21:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h4l3MyzV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90EE10E5D4
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 21:07:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A8DE44567;
 Tue,  2 Jun 2026 21:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6211F00893;
 Tue,  2 Jun 2026 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780434426;
 bh=DX7aQVZtVpsdM/RCECISKbiWk2U1XLyBOjRx65HmhIc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h4l3MyzVzZPPdBXqFarUf5KwwJu3EUiM6Ue2kf/367heW/5is0XWYQSNEeRy6h5Rh
 wEOsE/KBezpouAP3m9sG01b913V/3jzSzDESGF8lX51wDBeB/tr9vXeh6Pip2ouxo2
 wZUkjeYKlk/0aOpDjz+sK5dcctZaPwxmnVDEm4sQXmXmrzPCjRtxwf4CErTzMcaTsY
 J6twA1BBssw4l+dxUrzNY+PGXgXFqSh7vMz7hM4CEXkeLKXprsWzuUBjTTbaDTmbqh
 LGKVVOjMm3Vhr2EmeOZTP9j2h/xtZZ0p9c9oclVgKba+Hr/gxnjftcYAGpytaCbvf2
 LvwarXhlsYVqw==
From: Danilo Krummrich <dakr@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Alice Ryhl <aliceryhl@google.com>, Nova-gpu@lists.linux.dev,
 Shankari Anand <shankari.ak0208@gmail.com>,
 David Airlie <airlied@gmail.com>, Benno Lossin <lossin@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v6 0/3] Introduce DeviceContext
Date: Tue,  2 Jun 2026 23:07:01 +0200
Message-ID: <20260602210701.1705071-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507220044.3204919-1-lyude@redhat.com>
References: <20260507220044.3204919-1-lyude@redhat.com>
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

On Thu,  7 May 2026 17:59:18 -0400, Lyude Paul wrote:
> [PATCH v6 0/3] Introduce DeviceContext

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/3] rust/drm: Introduce DeviceContext
      commit: 571d4242c466
[2/3] rust/drm/gem: Add DriverAllocImpl type alias
      commit: 43a5d04a743b
[3/3] rust/drm/gem: Use DeviceContext with GEM objects
      commit: 0023a1e8d01a

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
