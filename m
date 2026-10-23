Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F520606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MFealBUl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B325B10E5D6;
	Fri, 23 Oct 2026 08:28:46 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6AE810E5D6
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:28:40 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a16faefac0so4288765e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792744119; x=1793348919;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JZl+HfrWAJtYCbAOILKeb7E857EVkTmoggdAs0Ji4mw=;
 b=MFealBUlVC74TdX1aUT3crXaGmquZrwuOPfCpbKpn5G6feu5XACxReMiWYCOV5x/Nr
 DOuexrcIgs/ac3WcMrxDiSnip+6cg596ApbLrs5acZnuy8siYZqdthU8Cu09T0achuYo
 2EMDOCmqrnP1dYXWJpmkAiwuqeNPEuCPByGRY6Cw+pWUQv43m7vUQ3aTks1JKjzNv97z
 YOYO7PS3vQID3efzgjZZe4uVOFM4PQh2y/XVYywZ6nwbk7SA11k4C1dnb8UuTGV5dTDk
 shfvI8ZTmiVfzhj83bPJhLBGrzyYFHRZGAwlqP12ggux+RhqfXP14Fuf+CmB9G7e8+vB
 Cvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744119; x=1793348919;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JZl+HfrWAJtYCbAOILKeb7E857EVkTmoggdAs0Ji4mw=;
 b=SzzIqD0BKZzYbjHk0tGU31moNYPdyQgSTBz+8M5ZtmVylHf2j50q0bedEzDWlULocV
 sUe6OSr9rHA1vFkTVncThudJoL04DR2NE1OT+tmgiTxndZFQhVtHZcQCQafwBPVaNM+F
 WFzR+Tz0Uikcky0XibSFD3FBqSUyledc5TEpStPTzV7Q9aK0eN2uCqiNFtns8wrrM0V2
 +SJlJFOEEL93PoD5sAhv2jJDxfZYJg68jXcf6KhKtF+HdlWC36QmEZQjMAvCL93GTPI4
 aeTjNho4MeGdgfBfmrc/NN3Prat0PNYCG3Xjzrm+/nbZLvwFaNzQYNl4dUTsxsME9nu9
 tqWw==
X-Forwarded-Encrypted: i=1;
 AKwUvByafrdhcl6CYM9vMBmoMzSSdZKXOtoWo0Zrk0UXAG5A65DthhsDB9giAr7ZszMNSgN4MR/WPC2Dut0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJA5oR0CaMsGr0XF9VoO25TTURwdPvmeJi1emk8Vm3U3EUid+66
 IJS+f/iXoU44/ckIWUp0J/DC1E4NWFXYs5THjomPqBmBLRZwwt1yv5LadDk7N+XC1ff/e5OYrqs
 IqjyCzcY3GdHepJFlkg==
X-Received: from wmc9.prod.google.com ([2002:a05:600c:6009:b0:4a2:d3e:ee4a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8a:b0:4a1:e7ce:10a4 with SMTP id
 5b1f17b1804b1-4a211eebdc3mr25679015e9.29.1792744119032; 
 Fri, 23 Oct 2026 01:28:39 -0700 (PDT)
Date: Fri, 23 Oct 2026 08:28:37 +0000
In-Reply-To: <DM9O11JY63Q2.1U3PB5GL0JYOQ@garyguo.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
 <DM9O11JY63Q2.1U3PB5GL0JYOQ@garyguo.net>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261023082837.1250172-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: gem: shmem: do not leak pages when sg_table()
 fails
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Sami Tolvanen <samitolvanen@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:31:03PM +0100, Gary Guo wrote:
> On Mon Oct 19, 2026 at 9:21 PM BST, Sami Tolvanen via B4 Relay wrote:
> > From: Sami Tolvanen <samitolvanen@google.com>
> >
> > `SGTableMap::new()` takes a pages reference and maps the table before
> > `Devres::new()` allocates. If the allocation fails, dropping the map
> > frees the table but keeps the reference, and the next `sg_table()`
> > takes another one. `drm_gem_shmem_release()` puts only one, so the
> > pages leak.
> 
> Sorry, could you explain it in more detail?
> 
> Creating a SGTableMap and dropping it doesn't restore the state? If so, it
> sounds like an API design issue.

Yes, there are really two bugs here:

1. `SGTableMap::new()` returns `Result<Self, Error>` instead of using
   `init_scope()`, so `drm_gem_shmem_get_pages_sgt()` runs eagerly before
   `Devres::new()` allocates.
2. `SGTableMap::drop()` (`__drm_gem_shmem_free_sgt_locked()`) unmaps and
   frees `shmem->sgt` without dropping the `pages_use_count` reference
   taken by `drm_gem_shmem_get_pages_sgt()`.

I'll go ahead and merge this patch since it fixes the first bug, unless
I hear any complaints.

Alice
