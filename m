Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC83606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMpjP3mo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC7A10E446;
	Thu, 26 Nov 2026 22:24:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A771810E96B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 22:24:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1ABB611C9;
 Thu, 26 Nov 2026 22:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E986E1F00897;
 Thu, 26 Nov 2026 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795731854;
 bh=zKh8bGgPjNUn6eijVJOarVjoGuOWzL0hg0ZPVgpp3Yk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IMpjP3moMBy8eR/4+FgXApC4ZJuospR3X4WEgkuC33APmBD19LHU/WsOjDLq3MK9s
 s+FiX00MR0fCXb7fSED/v0NX+M3HI1jU57GH8C1iNcqqZtaMerhF2GAUpxVyhS//Vr
 yIyGMQIj2Vjzrf4myvcIQf9p4fZMpcYMYCkvQcgIKtFqnmttWNtmxv3t5xSyEPqSvJ
 iTRWaweXGvxFd6kSLRgDzj3xfQ/cXXv+BKzmBuaaG5KbbSxGcSxrCymHR8AT2mvmZx
 jbii3FQNO6w3MqrmwrUtjkvl3+DowNkDpDgSHYqwZUn3sVkfH4D4rIyUB5CyE21+z7
 pWmzbyocd2g7g==
From: Danilo Krummrich <dakr@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: drm: gem: shmem: Drop unused unsafe for vm_ops
 assignment
Date: Thu, 26 Nov 2026 23:24:08 +0100
Message-ID: <20261126222409.3819227-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125-rust-drm-gem-shmem-unused-unsafe-v1-1-d6c5cb0b391f@jannau.net>
References: <20261125-rust-drm-gem-shmem-unused-unsafe-v1-1-d6c5cb0b391f@jannau.net>
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

On Wed, 25 Nov 2026 13:24:28 +0100, Janne Grunau wrote:
> [PATCH] rust: drm: gem: shmem: Drop unused unsafe for vm_ops assignment

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: gem: shmem: Drop unused unsafe for vm_ops assignment
      commit: 335792313aa3

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
