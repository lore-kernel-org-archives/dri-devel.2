Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3D0606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kAF+QGt7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7C210E927;
	Wed, 25 Nov 2026 15:03:30 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E33A10FCEB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:03:18 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so50034265e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795618997; x=1796223797;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8Jz8ssl/IqO+cdkuoUF1XK1hhhFDc4ccWMMZLEDHfAk=;
 b=kAF+QGt7OgdAvmXdqe6YA0E8X4L6YiTnr5C8UryEPApbCev9jV9mx06o2rCOerKRG0
 HhajtlETPBX+zrnEVE3Y0dcT1zb+N0NQV8OI0owdfC/R2yYIDdHiTRycAYdxGxi2GwjI
 OeHRlkdx7I2b8RrOSakiu6pEVz74rq/7wcxyeJpnKTtJkvotuNGKqDrpGR9tZ8NvYt5v
 GjU0sOucvc5x88zY3yexQSpvNYj6p/dtEcYO+EKFWeW663HOOBzdtRXLdFE+SoGI00bN
 BgaH6ZmbxCQ8sqHKlVlUAT4chIM22zhQBkMX45lDcZoyg1nSpurabOj1zE3JsXXEb2Dv
 XQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795618997; x=1796223797;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Jz8ssl/IqO+cdkuoUF1XK1hhhFDc4ccWMMZLEDHfAk=;
 b=t5q6V4vE4Y+tLL53WS4S2fAWtWr7bc0YQUtqgA+ieer7lMx/KG+Le0yLp+mbTFLgDN
 CuK/IZvQSVi8QlTuv1QyBGR++7+DWOS0WGuul8heMiBHV545kVCzQbzd9ULwmYgx/+Qs
 GHOxw67HNELsCCWvFoV9nenb9VtCOQSncAWcKBFEKpNRowyREZNepD8IjGrjLBAYyOpF
 5gS+fQrRvtdYsrxq+Eeba43oWzrHrMBb/bYtGrS9Xac60TCyBYzvSHVDU5H31+MkFLHA
 7KP4qISL3OWcGqgNppoeRATQ4y7zdNe1e5tVSk2eCQw0B5qEBfQ7H+vVDpGy9HhzOApK
 /izg==
X-Forwarded-Encrypted: i=1;
 AL+hErF7H6w68WjVeLmkcLSj8xao3E0hroShXZLX1FnWyu2TCJXoj1utYyIZ/WuvHMQ7yeQCJNvWCutAt08=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wmk4muJICdjBb3cKwr1tiASer8xvTr6URQ0bwE60qDLzJDCtK
 ybDSkysFtZnZ94GmrkqWMDYPGT0PsJ1ig3CRn8rakiZkwJZk+jS08yLBNyTt70ZiAEgJQF6GBkX
 XXc9MnqRetoFjfzOJvg==
X-Received: from wmpr23.prod.google.com ([2002:a05:600c:3217:b0:4a2:e03:1f55])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d08:b0:4a2:392:9de2 with SMTP id
 5b1f17b1804b1-4bb8882bd7bmr363816705e9.28.1795618996639; 
 Wed, 25 Nov 2026 07:03:16 -0800 (PST)
Date: Wed, 25 Nov 2026 15:03:15 +0000
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-4-000f7a9ccb8d@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-4-000f7a9ccb8d@jannau.net>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125150315.1587936-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 4/5] rust: drm: gem: add an is_imported() accessor
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 12:37:46PM +0100, Janne Grunau wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
> 
> Drivers need to check whether a GEM object is PRIME-imported.
> 
> Add BaseObject::is_imported(), wrapping drm_gem_is_imported() through a
> C helper shim.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
