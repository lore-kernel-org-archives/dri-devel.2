Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD72606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cA1+ABKb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31E010EA20;
	Sun,  1 Nov 2026 12:02:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5BA10EA1B
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 12:01:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DC1F602C5;
 Sun,  1 Nov 2026 12:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDDD1F000C1;
 Sun,  1 Nov 2026 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793534509;
 bh=wS9o+NwMaRYVgY9LbC6icY5Ab6GErT53mpUdVJfCXH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cA1+ABKbo731ffm836OwKT/1bK9PZFnZehcIBETxJtBu/2KsRnSrGqz9MOTazR2p+
 M9FvCeSZJJRqdWPGRYVXvcCu+pMiThTWeYxaAUXJ8xfOnTTMQMKSDau5Xl2gf8j84W
 /MzO9MUGztPe1KmjIcoRCgBwmTP6ZiZlP6jZcuiyPS8YhaEy6OCmt95RYW+oKdYtt0
 Sb4peCb0ovcIxeQcMSSye1wiMeeMrPLKWaJNrs0vduNM3lrXZXSzVu9pxDPLdLEMZy
 B573cZVc+FO3CBdRZUNvxIy1AmO76Ddu6C2NSz09Ps/VIoSk9bbEE4QvNsRx76Z4DG
 Pnc0oMnosSL9Q==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, jhubbard@nvidia.com, apopple@nvidia.com,
 ecourtney@nvidia.com, lyude@redhat.com, kherbst@redhat.com,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] drm/nova: make unstable uAPI use explicit
Date: Sun,  1 Nov 2026 13:01:37 +0100
Message-ID: <20261101120137.6074-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019212535.88390-1-dakr@kernel.org>
References: <20261019212535.88390-1-dakr@kernel.org>
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

On Mon, 19 Oct 2026 23:24:44 +0200, Danilo Krummrich wrote:
> [PATCH 0/3] drm/nova: make unstable uAPI use explicit

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/3] drm/nova: mark the uAPI header as unstable
      commit: 4e85d5f62ec4

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
