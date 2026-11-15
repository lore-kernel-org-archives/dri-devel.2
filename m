Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B923606A329
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fmn3QQly
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036FE10E041;
	Sun, 15 Nov 2026 22:42:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3912810E041
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 22:42:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65B5C62503;
 Sun, 15 Nov 2026 22:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54EC1F000C5;
 Sun, 15 Nov 2026 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794782566;
 bh=HWNQezm7qiydS+vQaHkitAC+iC5yiaIdb2/keFM0doQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fmn3QQly2We+17+W+XKakioLjkdgvsXQRlDaJvcOcwk8L7mSvWegmKsy67KEEokAE
 ybsSrc7qxZIW+zA4ZW5C5AgnP77anhlfu5GjxL1YxE0bRT/A0jSmzD9tWtr8RRZ0y7
 FYL3R3OSc4ZPcGhgIlaBuKXQx5X3i9mIXQ8phtNDcKjsLokVEDKcffm+q/3xmhL7kO
 YZzpggbPILKPGszDZdwSXSmkrR9knRzv45ZO/PbJvRc++f9I4zd3Db9xhMyY1NmmL3
 UDwuayA9vyi+qQwKvHZwyFD1I5qVqCqrcyQFkWefoIRjIzWFsjP/JybVfFbXceCTEW
 nsC+hA5u8kFIQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Vladislav Zaharov <vladazaharova2018@gmail.com>
Cc: dakr@kernel.org, jhubbard@nvidia.com, acourbot@nvidia.com,
 aliceryhl@google.com, ttabi@nvidia.com, gary@garyguo.net,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 0/4] gpu: nova-core: retain the GSP-RM log buffers
Date: Sun, 15 Nov 2026 23:42:36 +0100
Message-ID: <20261115224236.65017-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114044304.245684-1-vladazaharova2018@gmail.com>
References: <20261114044304.245684-1-vladazaharova2018@gmail.com>
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

On Sat, 14 Nov 2026 11:43:00 +0700, Vladislav Zaharov wrote:
> [PATCH v8 0/4] gpu: nova-core: retain the GSP-RM log buffers

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/4] gpu: nova-core: move the debugfs root into the module data
      commit: b9a34b6ac2f7
[2/4] gpu: nova-core: gsp: move the log buffers into their own file
      commit: 35d780c3c9c7
[3/4] gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
      commit: 27b10da20729

      [ s/scope()/into_debugfs_scope()/; drop unnecessary explicit Infallible
        from into_debugfs_scope()'s return type. - Danilo ]

[4/4] Documentation: nova: remove completed GSP log buffer task
      commit: 8045d0e7d208

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
