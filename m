Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96184606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GC6u7YxK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26BB112737;
	Thu, 19 Nov 2026 21:57:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536B8112737
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 21:57:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF303438BA;
 Thu, 19 Nov 2026 21:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525801F000C4;
 Thu, 19 Nov 2026 21:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795125436;
 bh=RcfbHFH01RzSHnJPgcknTLx6N5kKgF6XGMIscWY4ydA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GC6u7YxKJsHQfjm6YLA2+C4TCzramwpUjurE42mn73YzM2q4iiTSl+fGKk9FqWFBE
 LaXK6V7vXBs/7fpnLdVkfuocbUX+ToQpIT5PeVxUk1uLPs9utrNVak5PUzJUTgjpBn
 bLsIFOBqvhXRPdLTcedv+m/eXoXfxatEPoQv6c3Hf2J/0bXsdTw5FL5bcbd2/u3pGX
 hRSE5ghGJC6QrmDdK5MGzfsf1hsiZ6Wg8i6XmiJD+4qvtPu6+FkAEp+9EhXfSZAo8d
 U+S9ad6q7t0jas8URUV/NPjMnK0on0DINsT5OlHwlos8zpXYj8VNgIuX86YtR6UkW1
 uURwWuthRnZiw==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, acourbot@nvidia.com, daniel.almeida@collabora.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev,
 brauner@kernel.org, lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev,
 deborah.brouwer@collabora.com, laura.nao@collabora.com,
 beata.michalska@arm.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] lifetime-parameterized DRM File private data
Date: Thu, 19 Nov 2026 22:57:09 +0100
Message-ID: <20261119215709.3691076-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163203.2483856-1-dakr@kernel.org>
References: <20261118163203.2483856-1-dakr@kernel.org>
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

On Wed, 18 Nov 2026 17:29:41 +0100, Danilo Krummrich wrote:
> [PATCH v3 0/7] lifetime-parameterized DRM File private data

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/7] rust: drm: rename Ioctl device context to Userspace
      commit: 69976e5f24ed
[2/7] rust: drm: gem: gate open/close callbacks with RegistrationGuard
      commit: 6f90031b5cf9
[3/7] rust: drm: move file_operations from gem to device
      commit: acce9c14569d
[4/7] rust: fs: add iminor() helper
      commit: d63e44ab58dd
[5/7] rust: drm: wrap fops open with RegistrationGuard
      commit: 5a31079c7c5f
[6/7] rust: drm: return impl PinInit from DriverFile::open()
      commit: b8ab877d7b44
[7/7] rust: drm: make Driver::File lifetime-parameterized
      commit: fed919c71b52

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
