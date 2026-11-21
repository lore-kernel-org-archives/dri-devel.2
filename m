Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F93606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OFxfKRUq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F055210E903;
	Sat, 21 Nov 2026 17:43:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B26010E903
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 17:43:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77089600E4;
 Sat, 21 Nov 2026 17:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADCB1F000C0;
 Sat, 21 Nov 2026 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795283031;
 bh=udZYC2uR6LZTSAolq679zGOSTIouPHY9Kp8cjPhFlOE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OFxfKRUqQ/rPfpfzPrGG5zhws5OxiZuH6d6OH0IuJUHatAWD3K8AlrVvOdpjT+ty0
 SlDoKsjA+9hS7LzQSJBDwCc3Iu729GDBecB/KERnFIlETnUdF53DL8naq2BRfZZPxy
 BM37Vn/numrxqjVnS1mWNozRPt5ncjPcDff6HLwK1NrgmPM4A//11Vyp3MFPaGDfwD
 wwI7OsqRq9NP8c9l16AVk1cHN/2b1qHztHah0i8X+xC23OcdCEFfy99R4Fw9AIuAtJ
 1wp3Aq18jjzUgS88yLuS+fMrzAK33FpqFlTy3VFAeQzpoWCMUZ/D7UXaI5cu0L69tj
 YxPUFb9VVb0rg==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: drm: remove DRM device private data
Date: Sat, 21 Nov 2026 18:43:45 +0100
Message-ID: <20261121174345.29747-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118181245.2583303-1-dakr@kernel.org>
References: <20261118181245.2583303-1-dakr@kernel.org>
X-Patch-Reply: applied
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 19:07:35 +0100, Danilo Krummrich wrote:
> [PATCH] rust: drm: remove DRM device private data

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: remove DRM device private data
      commit: 0694e2390c5b

      [ Assert !needs_drop() in drm_driver::release(). - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
