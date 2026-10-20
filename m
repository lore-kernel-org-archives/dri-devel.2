Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED61606A33A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wv8lJx0y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A867810E0C6;
	Tue, 20 Oct 2026 12:23:45 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D0C10F52A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 12:23:39 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01ba12198so5028365e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792499017; x=1793103817;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I42Z3b+yPEBavpF4t/N9DKKu9fZtHkDth+tw3l5ORkA=;
 b=Wv8lJx0yztvxNjAEk3pK8+/F5MowN5/Nbl5xUNJusajaGNsrf3zxHTYJcaM7HsG236
 wkA63IE8SsefkjgF73wkW8z9YoLY6wMpI7gA3KEn3kPHMmbvO0GJI2cBStZcViZVmoxd
 SGS2nue8Hjf4R+2Wlapcl286heuAjdtSPkE3w4rRypoIUEzdIjw6fnDUsCEzlLYxluU3
 Tm4WWTHNjM87vmckp4XLG57DhRMybtOMM0VOP96jxanR23gpJvb+HOjXiSPrCKrvQYhI
 x8D1YQ2x7DBVvh0CbwFzjEaZeitAoddb1TWYBk6+WBUoq/gFVZGBCpxFE2rapvAshqVK
 MlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792499017; x=1793103817;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I42Z3b+yPEBavpF4t/N9DKKu9fZtHkDth+tw3l5ORkA=;
 b=ZtxuXX+FhBusDxTBoc9v/7XaGw2BOYvU4oaXrFdRkPggwxY7hPIITSIvztm/lOT+2/
 BSF/3yOa8dUkGU0sts37xgqH9syw5cYxTG9Fbf8HV2ps8cS5sRxlLhTv8CqfJQmcEGjT
 HuAPtBmgO7BhwcOms5f35MSd8sGnQM35OC/DiEMotFqR1OvzhCLJxra/eSOWzbVmGK5J
 ht90niwd+7aCBRvrR4ZOdNs5N4lY264QXbejyJ2CYhI3g9SJKMARd5Em8t5WzRs5TV5c
 vHx6P3BgxeJ75uymcqVYWbSNYzL6SA2z9C+KpFnej913CMwoqHbNXpzBWSV704KbzIjt
 28bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxeWAG/x9S1Qnk545ROdYngap6DtNcabthm+Ji1i1LiaseE9wQHvkctJXbTUjkGQbv0BvVhbIveZmM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKueTdWDXelgEkXEVpPWwUuIFST5bdtsNAMYgRFysVmXik+pji+
 Gw99Ny2njsNlvDnxzOss1lgh2FQi1kOQBUHkAs3Ji+ar64K9l0WYho0kslb+k0eJZJeHrh5HBjn
 FHPdBxQ7ymO1/BV3pPg==
X-Received: from wmbz19.prod.google.com ([2002:a05:600c:c093:b0:4a1:e348:29f1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6610:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a1f4fa26a5mr45442095e9.15.1792499017228; 
 Tue, 20 Oct 2026 05:23:37 -0700 (PDT)
Date: Tue, 20 Oct 2026 12:23:36 +0000
In-Reply-To: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
Message-ID: <atddSMMpb3DUauWH@google.com>
Subject: Re: [PATCH] rust: drm: gem: shmem: do not leak pages when sg_table()
 fails
From: Alice Ryhl <aliceryhl@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 08:21:52PM +0000, Sami Tolvanen wrote:
> `SGTableMap::new()` takes a pages reference and maps the table before
> `Devres::new()` allocates. If the allocation fails, dropping the map
> frees the table but keeps the reference, and the next `sg_table()`
> takes another one. `drm_gem_shmem_release()` puts only one, so the
> pages leak.
> 
> Take the pages in the initializer, after the allocation.
> 
> Fixes: 616c229ab010 ("rust: drm: gem: Introduce shmem::Object::sg_table()")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

LGTM:

Cc: stable@vger.kernel.org
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Looks like there might still be another issue when Devres drops
SGTableMap, leaving a handle to the GEM open.

Alice
