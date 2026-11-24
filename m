Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32545606A337
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cjyfmzjg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDD910EA13;
	Tue, 24 Nov 2026 16:53:12 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A27D10EA13
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:53:06 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so28991835e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795539184; x=1796143984;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+6XqvUEASgW1nzq6zUn3qY0teVOPvQxrwEX3381OA8Y=;
 b=CjyfmzjguZ6NashjgAh1P6CgVLzHfoz39FoeIEOnER+a/MylKUmAMHiBHEGHyLVIpO
 8LXN8nCQH30RD4lPRGQbZZekK66h9DM/R8YzLbKKwaMHqd7s7OwMOvjYrxIScaMX+2zB
 lZIi7v+1EZymGTInHwpr48h1Ruba+UBqD3Pg+jaHbn2oglfZ910pq2cjY1yQq4bGmoyk
 IiCIQDIPgleptbHVuOOmH2UcEO5jRhFhhOzMdUTBg6Wnam/wj9ogmw4G30a13/C69aJs
 OT3W/h0cWWMSvKt4RIxeHbWZvkOrGdohaxu3j8Om7Hn1w7fceFDYB5sG7KFGVo5R2myY
 UnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539184; x=1796143984;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+6XqvUEASgW1nzq6zUn3qY0teVOPvQxrwEX3381OA8Y=;
 b=ZXedyzVWYR5RNVPrerqzSzcO49hLyPTnh6/A3UxsxHkJXygcXce4E5K4mLYo1O3zVd
 Gk1WvQMTspsGQQFHGWaYOBnfgm5av72CFtafHrPLIn2WRrvUwcr0iqbBQvsW6CcNyQJb
 GrMAym3rVJMpWL80kFPekBb9kUujIuJ5LB2Hx0ea1kn4WgAuhvewnXZ3CptrCPfivlIw
 FwTX9LNBcSjJJwD11I62c6PqedKjon7ukunWYrsSEB/VBBnRCadIytiTrmAcc0lrn6EM
 99udskr0m2wrIdL6Y42DYTXh9U/kD+hK2gvny2ovKu3G33B4Sc2kInn/iwS1jPRm35A6
 zEeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErESeIJZ9z2ckjGWaFavwCZIMq0pxHC5yIrq/ZdLh/U20dWtn6BPgkijIc0aKncBSEHNh6mWIYD3d8g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/eyBXeGsehYgWV8IL6tFWCqpWDkXDuicIFc/xCpY3zYKzf1lb1
 1XQr2VjxJzlntGyEME6KIPxZhugoN9fp87dVwHVt4CSvQGdU37FlXKY33TsaMCkFEgiUEM9IyPY
 Bh4TN2EndqSdetSiUXw==
X-Received: from wmik5.prod.google.com ([2002:a7b:c405:0:b0:4ae:362d:4d6c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154e:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4bb887c3b63mr334954395e9.4.1795539184204; 
 Tue, 24 Nov 2026 08:53:04 -0800 (PST)
Date: Tue, 24 Nov 2026 16:53:03 +0000
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-3-000f7a9ccb8d@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-3-000f7a9ccb8d@jannau.net>
Message-ID: <awXA70GWssuU991c@google.com>
Subject: Re: [PATCH v2 3/5] rust: drm: gem: shmem: Implement
 prime_import_sg_table callback
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, stable+noautosel@kernel.org
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 12:37:45PM +0100, Janne Grunau wrote:
> +        // SAFETY: The DRM shmem helper only invokes this callback for a registered DRM device of
> +        // type `T::Driver`, which is `Self`'s driver per the `AllocImpl` impl below.
> +        let dev: &Device<T::Driver> = unsafe { Device::from_raw(raw_dev) };

`drm::Driver` in `rust/kernel/drm/driver.rs` currently declares:

    type Object: AllocImpl;

without any constraint that `T::Object::Driver = T`. I think we should
introduce one similar to how Driver::File constrains this?

Alice
