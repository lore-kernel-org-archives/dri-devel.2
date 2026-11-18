Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65371606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hs+BZK3j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E7810E7FE;
	Wed, 18 Nov 2026 15:29:10 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8702910E7FE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:29:04 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a20e41008cso8998905e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795015743; x=1795620543;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WjQ+lJ948dIG2BXocv8WBAwSlCVPjavCtkad1QsAfjU=;
 b=hs+BZK3j7jqOW62tnknO6llSLvEUe9c7UVZXMedrVqTfwiDZ2igDKbCbUdlF8plO1u
 gQBnmLgg4LTHAtboW8IyseA8BqR8PV3aMRYS2zMwxhyLWn7gs+t41uRhvuSJ7L/saoBN
 k5S7ocm4wAKhLuqpvPDeFYBFIsU1vtLCGK0ZPfh59gr9m+vwdIV6/WDtyzDkUEfSo3I9
 +Ef+qj9GL1MaiKnYsgdRIX0LiEjdu34moC66SojARVNf+EuDzubgnCSCFqGJZ8A5lEvt
 4EbSovY5b8w1+SVx2epstHQsnzk7ZTZci1/KRJgnYyd7cEgCHDslNmSmDBdz9ewVNYCL
 miVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015743; x=1795620543;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WjQ+lJ948dIG2BXocv8WBAwSlCVPjavCtkad1QsAfjU=;
 b=Pb3ONo1Y0harU4w4lAZJWK+PLZmTlW+dyn+1SOZsxa8t6s2ZF7PeIAH4dhzpXXG68a
 9OKhSEp33eUfq6DXeQVF5z51wOWMcvIyZwXWujjw1PC0thEpcDHcGcJ94XppHr62Rhtr
 Cpkr7MmQHj62224cYNhh4LXjbYiVlbR4NF78idKfm62TSkq4RClzpA3fOmUa+7Faugmw
 2mWq2pyc7d08W3i5/L5EMz1xlQ+BLhdDfFBx8RuFWfbuH4pDIwQeDZfqJaFjsBbCKa6D
 djLAWnZQl789kks1AGgLhO0sOQK7f+QYbNMzWqk6atK3cdh8IQ0nmVDspAAUp1bUxlzs
 LkLA==
X-Forwarded-Encrypted: i=1;
 AL+hErFhplNiRNbxN3b4rf37QCRuBSpSceh7Wnd5vBdzayrIOrStooZxQzaMJuj3yii/onDbM9D9TtVV6W8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ZKsrSj1uPkgd3+vi6HUfNFA5HG0psUsm1FmCx2LGkl+gEjHHs
 3/36loK74rnueEJFUVFPcVcpQ8S/b6f7lay/O/mIQcUbPR7KlkZoKNeK4ysFUh+If8YokV9qBFY
 9kw2IudrDGSZG8I5wiw==
X-Received: from wmbeb10.prod.google.com
 ([2002:a05:600c:678a:b0:4b6:5d12:e070])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a55:b0:4b1:2026:6b41 with SMTP id
 5b1f17b1804b1-4bb7da2bd37mr54038905e9.30.1795015742420; 
 Wed, 18 Nov 2026 07:29:02 -0800 (PST)
Date: Wed, 18 Nov 2026 15:29:01 +0000
In-Reply-To: <20261118133232.48603-1-vishal.moola@gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118133232.48603-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118152901.788942-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: ioctl: fix call to unsafe function
From: Alice Ryhl <aliceryhl@google.com>
To: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:32:32PM +0000, Vishal Moola (Fractile) wrote:
> Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
> Signed-off-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
> 
> --------------------
> Based on drm-rust-next.

Note that patch commentary needs to go after a three-dash `---` line
rather than `--------------------`, otherwise `git am` / `b4` includes
everything above `---` in the commit message. No need to resend just for
that as we can strip it when applying.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
