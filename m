Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2187606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OUWAP86I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C48510E268;
	Tue, 24 Nov 2026 18:54:36 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB9310E268
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:54:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4b0a307487aso25536945e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795546468; x=1796151268;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JlXoPCsikAIAHDol8QyOvxuGmdfr1LiWSUW7tFYnhrg=;
 b=OUWAP86IeWO7oDZsqdGh4bFoAJEdMW8wEQUInhFfD/qYIoAhIAR8s/YlcUK7449NhY
 nMjexRhQ6atfhkUEIMmoeCpASaBk+GJB2QZ9WKMeSkYraebCnjNBvAk4UENZ1P+3VykH
 d1hh5u2QFDvN36/FSrhR7IBtum4KgUXWV5o21EFurUdDl2wDnC0wPJYRJie+vf8aWLbH
 2bTgjuEa4eHafrFssPZt869sKkyO3cYLuU1nX1B4KawEpc3ocauQTbO2up15V9L/08D7
 5zUafs6RH2Po1iyFi58/wWgD/wYqyrEj5KPR6gvSzToa37Bt4NVSm57rwIPSzS8QBEYs
 x7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546468; x=1796151268;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlXoPCsikAIAHDol8QyOvxuGmdfr1LiWSUW7tFYnhrg=;
 b=U6kyRLzQt765CHKd62vj0XZABZZ5hKzKQ/w2AAEtoMC9vP0OwHmGoMO9HKx71DH7XN
 MA9dtEaJIhWFbAYJKUet5W2fJP7yqbr3TNBO2ySnv8J+L/tJgNtyDvafpJO776N1Oa55
 fDlZW1gNsUu/+z74LI3J5CJz6wdL4UbtZWOxoRqqyFvtHujkxk25k5Hje8txXGfvfK23
 F1vahUZ8PHKkFS5AqUMK3nfBZTW6eofJhqDZUZdck375VpJGpHKESlaExMaD6ZQkO0Ez
 JEOFrgDAFYJ0TeWvmllKxLU1kXuDY5yJS9Pe0s2Dop7k6DgWfADz3AMKSJNDFt11a2MY
 xb7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGWI3foVcE3OcFLOfds4PjSJOxJDeS13ckuLZFP1IwaejUIcflnuHBOgZ6jCo1O1brK0ad9mm1PhDA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81oVPnJjjKutVL5YvelisU4qbDVx9otBw1G9aRNpIo9xuowDux
 DI82igqlbyAIOUkTeSIDdL+jy2ItHDTFkmHNLyesukvyZWPGE5B3AHWdcq/e5oNYFUQevkwphA0
 JZVicbR4yrr2kJbSWWg==
X-Received: from wmbje17.prod.google.com
 ([2002:a05:600c:1f91:b0:4bb:5e69:8177])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82d0:b0:4bb:818d:8d8f with SMTP id
 5b1f17b1804b1-4bb88818955mr377886255e9.23.1795546468273; 
 Tue, 24 Nov 2026 10:54:28 -0800 (PST)
Date: Tue, 24 Nov 2026 18:54:27 +0000
In-Reply-To: <20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119-fix-drm-rust-fdinfo-v1-1-c10f4134488d@gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124185427.3821700-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: enable standard fdinfo for Rust drivers
From: Alice Ryhl <aliceryhl@google.com>
To: Peder Bergan <peder.bergan@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>, 
 Janne Grunau <j@jannau.net>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:48:47AM +0100, Peder Bergan wrote:
> DRM monitoring tools use drm-driver and drm-client-id in procfs fdinfo
> to identify DRM clients. The common Rust DRM file operations leave
> show_fdinfo unset, so these entries are missing for those clients.
>
> Set show_fdinfo to drm_show_fdinfo. The DRM core helper emits the
> standard client information and calls the separate driver statistics
> hook if the driver provides one.
>
> Fixes: c284d3e42338 ("rust: drm: gem: Add GEM object abstraction")
> Closes: https://github.com/Rust-for-Linux/linux/issues/1266
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
