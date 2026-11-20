Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC7606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QC0LLIX0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4613411283B;
	Fri, 20 Nov 2026 09:53:42 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A7711283B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:53:36 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4bb818d8dcfso3140825e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795168414; x=1795773214;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wU4LlfzaVTfqT9FAZ2d8xCr1YhlqLtpgo7yVgEhBPXE=;
 b=QC0LLIX0kcBCWPHmaxIqrPrKMVE7upZvt7qY1FLhYIflLAyQIaVBjv1Dpo0gVEbqiT
 rLpA9o2YxYZFv0p+HIvAuZ16s2U7I5nexnFENqnOU7eyfJR1hyC+CrsZc1CZY0sOrz9R
 D/nITfVoizd+5JNTC4uFV5Ic6A6oNr8rzjaqxM6eqIZDQKbyeF/z5RJ9BLf2ZiQfSROj
 KTaQS78fFvNx7WzCLr3WxGT0xcRdFs+oT4a5jT5zTZdyETy6uNdt2edbPkF+7tQob88k
 Y1ECoKthCgWeJY0KrN6JEaPE0TQLUiqiEcFdpx1q0YMd3aN6Ih54PgEYG049zMBZeLg7
 3TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795168414; x=1795773214;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wU4LlfzaVTfqT9FAZ2d8xCr1YhlqLtpgo7yVgEhBPXE=;
 b=gXtIWsQu4qT1mxRW7rKtP4iZvS0Yq2/KTq5HiQFTsQCNn8QvLHnsASjVqGOjYNKTJ5
 UjKvObwx/E2tDEmNahpDyoZ9PzsegXxdehv9cgwoK0+B9CWcQYexHmwVgJK13KhCTIMu
 gIRx+Ta16pazU5XSkbGgl2NYP07mvGQX8sD7Kfe9hSz1uV6ZWIp5GktJC3WayGxXo730
 JFCXJuSVBJzx47aSfK4G8hzT4EDem3r9vGK/XmKQr+bfb+2rMV6GuiZHkY+fPiC9JaPE
 j7G6TCDbjxutiacIX2yPWf1t1ZfoNGXrDvVrccoyGNZzSO6WRqQHuSVfBCXlfcWdh3yY
 jvAA==
X-Forwarded-Encrypted: i=1;
 AL+hErGap4/4XOzzyui67NagpFQ2Ekf0AUCkZ8r85d/J7SE59akYon9UdUfuaitZomqYSPPo3PlvgexnPCY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dmionwAkkVpfEJq8FsDs2BXFbPvsB4urk9F84YbIbvKvAJnN8
 Y6nDsd8SZIsqlbY6pLm+26yiGuThrlQjRPxU31H6u1O8KJEBTM8sEooT1UdIpsjaZWwC392jRYX
 v3O+xuUlaIzUhctVLmA==
X-Received: from wrud2.prod.google.com ([2002:a5d:4f82:0:b0:48e:3c17:c059])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e4c:b0:4bb:6238:cd81 with SMTP id
 5b1f17b1804b1-4bb88807dcemr52539295e9.10.1795168414195; 
 Fri, 20 Nov 2026 01:53:34 -0800 (PST)
Date: Fri, 20 Nov 2026 09:53:33 +0000
In-Reply-To: <DMZD4TXCZSRX.HN0ETV0FWFIY@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118181245.2583303-1-dakr@kernel.org>
 <20261119111746.3049044-1-aliceryhl@google.com>
 <DMZ5ER6XTNLG.2ZJOF7F4100XW@garyguo.net>
 <CAH5fLghc63zD9c1F437pQiX+ohgSkYQe4nt3xP4gSTsqAVLzBA@mail.gmail.com>
 <DMZD4TXCZSRX.HN0ETV0FWFIY@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120095333.2135217-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: remove DRM device private data
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, 
 simona@ffwll.ch, daniel.almeida@collabora.com, ojeda@kernel.org, 
 boqun@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, 
 acourbot@nvidia.com, work@onurozkan.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 06:28:07PM +0100, Danilo Krummrich wrote:
> On Thu Nov 19, 2026 at 12:49 PM CET, Alice Ryhl wrote:
> > Good idea
> 
> Indeed, what do you think about this?
> 
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 774db3acb15a..8c48dcfdecec 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -158,7 +158,11 @@ const fn compute_features() -> u32 {
>          open: Some(drm::File::<T::File>::open_callback),
>          postclose: Some(drm::File::<T::File>::postclose_callback),
>          unload: None,
> -        release: None,
> +        release: {
> +            // The DRM core frees the device without running a Rust destructor.
> +            const_assert!(!mem::needs_drop::<Device<T, Normal>>());
> +            None
> +        },
>          master_set: None,
>          master_drop: None,
>          debugfs_init: None,

Looks good to me.

Alice
