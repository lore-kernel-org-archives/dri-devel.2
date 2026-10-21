Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143A606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dK+e8XRF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA2510FCE0;
	Wed, 21 Oct 2026 08:53:42 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267D610FCCE
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:52:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a028616bebso3283285e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792572741; x=1793177541;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eyNTpdWYX99+7C9MN8TAB1uHP728SkaAnyZyPKz7OOE=;
 b=dK+e8XRFnYP0BZGWTOdTPIudcmY31Se7PSPGqQEhJSEPZVeP8Ba5w9DECN99dQgnu7
 dEJiyV64gJFP6s2p5DBxbWbfsI5lh8EzNWcDHPklbY6AdROIvTcYGrunxZ7HiD1xL3bG
 LPJhFFKubqyQzSgfcEt6tV4JZEoIpefYxpq9IGEAJ+UcdAtkuN9VB5O5VsJ3JadgLK5G
 V44RAzkPVI73jhXxMjygpP7II4M5EzZw3BqKQ2eHyDYNtDWgr11BvbGiZyp3tGy92PRh
 BJcsHMZByQlvN5YsCF99oJhAmeQib4LPnijiGHtYN8VWJ4IToUdLuEHmNPUDvHyzKLly
 jx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572741; x=1793177541;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eyNTpdWYX99+7C9MN8TAB1uHP728SkaAnyZyPKz7OOE=;
 b=0dZO9gbD7WMMRrS/LXOFn0Tk9jc9UsPR+CJfsil+P7RYB8SAKFxvRaqKUW7e311sa0
 +mrSyhG2Kcf83gH6PsJ2WcQCLg5kahgrdqlTzZrWVK0HNlzwX7GU4SHU8gYTPeUA/6sD
 OTku8U/XqXvGOU/KWyvPJ/sxA6TibWwz18CQEsJuyfxO6OBq31l2bSPM1t5ZhAN/R5LS
 k2OWStU3Gf9NULShAIxVHvHF3fGgDGwcuywxhVXAAjCLZLCV0PlvdY9bsb/A0xA1AYZW
 Kc6ZGK9uIMI24z7xAT5pdn1+MMYJ2WqJe6/rk4wcVb8tybcBWdVrXFphUnW53IrSx52i
 8xiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe8wwsXCqhQbiI/qHLwQSN0v7Cgo+QwklGmyW338HGZQS6jPnRj8iU1rhovJMTLn1RgIApGoA4oY0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLOWHRnud3pDim/NJccuegLB3C4dAQOLQJpgEPepuweWgZxVSd4
 qItc/LrZogQH8alhSFrdWwUgcSYAhHDuJ1ojQTsBMzRb4LqV88JQSxL+ue1g8LQ9/29CAKOIsW3
 LluRhfjs0mn5zu3sy8Q==
X-Received: from wmro19.prod.google.com ([2002:a05:600c:3793:b0:4a1:e34c:d989])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1391:b0:4a1:fc0a:8b75 with SMTP id
 5b1f17b1804b1-4a1fdd483a6mr24969595e9.24.1792572741168; 
 Wed, 21 Oct 2026 01:52:21 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:52:18 +0000
In-Reply-To: <20261020-b4-dev_query_fixes-v4-3-df66b4c98bc6@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
 <20261020-b4-dev_query_fixes-v4-3-df66b4c98bc6@collabora.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021085219.426333-2-aliceryhl@google.com>
Subject: Re: [PATCH v4 3/3] drm/tyr: allow userspace buffers to be mismatched
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Oct 20, 2026 at 05:06:47PM -0700, Deborah Brouwer wrote:
> Allow userspace to provide a buffer that is smaller or larger than the
> object that the kernel expects to write into it.
> 
> Set a minimum buffer size to match those in PANTHOR_UOBJ_MIN_SIZE. If
> userspace provides at least the minimum buffer size, then simply write
> until the buffer is full.
> 
> If userspace provides a larger buffer than necessary, then zero out the
> remaining buffer.
> 
> This ensures UAPI compatibility with Panthor.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
