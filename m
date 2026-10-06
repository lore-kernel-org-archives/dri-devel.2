Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA93CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 22:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A569510E397;
	Tue,  6 Oct 2026 22:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H2mrwbAz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E4CF10E397
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 22:19:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 418C740143;
 Tue,  6 Oct 2026 22:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516D61F0089B;
 Tue,  6 Oct 2026 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791325159;
 bh=yoz81NNJye7tqFJfq6/+j2f4bS1mDaz+zAr4Z6WtmlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H2mrwbAzBClnxhvRFMYxigOuYhKMn7ijXwR8Qrx7baAJeXzyic/m6tBEFFcdbAJ3b
 VoCFMck86sbcQ3B473rFsrdvf4oTRZTMQgy6o0h9fJO2AeZTRbWkrueUiOTZl9s20l
 I6tdnlA9vDXHWCbkYTmomZR0lddNauOLZb+hrjh6llY+36qmnCopBV4T9kdkXh6vSH
 iDEQPZlOMuV11SGYuP24gpM1HFEtioraOxddAeH9jR2afox1U77MeFuxi9BtHvm/8G
 OogBj/0hmXTmNeEAfst+35IcVpHnD1COUz/PbhXCbNU/Hn04yU2nK3aYqq0BgZVuMR
 CKG0HfgpwfgyQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Gary Guo <gary@garyguo.net>,
 Tim Kovalenko <tim.kovalenko@proton.me>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: nova-core: fsp: use KVec::zeroed() in recv_msg()
Date: Wed,  7 Oct 2026 00:19:13 +0200
Message-ID: <20261006221913.41298-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006065437.58408-3-blum@kernel.org>
References: <20261006065437.58408-3-blum@kernel.org>
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

On Tue,  6 Oct 2026 08:54:35 +0200, Thorsten Blum wrote:
> [PATCH] gpu: nova-core: fsp: use KVec::zeroed() in recv_msg()

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: fsp: use KVec::zeroed() in recv_msg()
      commit: 3e3404c52370

      [ Avoid the unnecessary turbofish syntax. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
