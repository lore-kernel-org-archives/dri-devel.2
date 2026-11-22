Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361E606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KZuWbp7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A126B10E431;
	Sun, 22 Nov 2026 16:35:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7321610E431
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 16:34:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B86E60F9F;
 Sun, 22 Nov 2026 16:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538FD1F000C6;
 Sun, 22 Nov 2026 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795365298;
 bh=frqLSKxdb4TD6+ImaJKDNUJhKNAv5G/KX6Pf1cnjYIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KZuWbp7zHOTaHce3aX8HCT+nYzblWSjnop8TvVDgDh9Z3fgKmHY6C6cGtgt+keq/O
 hAskLZs8J6d9+Fvmw91DrnOGAiHcTjhHromX2DRA6QeQI3bYCqVaQwd8ijnh4LTquk
 MbY+Q29TuhB7v64uiI17NAdH37QUjkIUtMjSajcxHgzKYWdikCaCxCX0vCprt+kmYO
 qSuewqezcSIfxIYq/8TUJOeoS8o0aHPBiAYT+ZeadGy4juSllYpW619Sf5P1lZHzd5
 2Bn6ggpDEWtvrLZE7kVXLnpKS9rlkYGXQtD+PbzABMV8UCv+9y5affZnHFdjJz8Dwl
 ci0GPNAk/SKhQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, aliceryhl@google.com, abdiel.janulgue@gmail.com,
 daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, driver-core@lists.linux.dev,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] rust: scatterlist: tie owned tables to the
 device's bound lifetime
Date: Sun, 22 Nov 2026 17:34:52 +0100
Message-ID: <20261122163452.927512-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114234324.82387-1-dakr@kernel.org>
References: <20261114234324.82387-1-dakr@kernel.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 00:42:53 +0100, Danilo Krummrich wrote:
> [PATCH 1/2] rust: scatterlist: tie owned tables to the device's bound lifetime

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/2] rust: scatterlist: tie owned tables to the device's bound lifetime
      commit: 0504beeb95d1

      [ Remove stale documentation. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
