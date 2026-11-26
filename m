Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE4606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VoiPkqPK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7837911227A;
	Thu, 26 Nov 2026 10:03:04 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3561511227A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:02:58 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so52913315e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795687376; x=1796292176;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yz3Fvi0Z1WbpqBTLJfHCJBGO30gXD4l/AgDztFQ3PBw=;
 b=VoiPkqPKyo9OK3J/3XJCLDTsZKQeeqvAM+peSpIUkSc1CD2nwikYNr640A+NDq0u43
 Zl3DyLffUJK2srqWhLzp8p9yh8tcywcgsj2Jw4q0TlmPFaMeQJkk266oa5zTBhh0SntF
 F0w0JheTNT4SP6tcTVFOF5ruzMuLpLmfR30X2fGYGg+VsUQ1cC8u1SJQJid7Z3iLYvZ/
 YkU6lg0yd0Xh1wy2fYwrgtnKYsVOlIk1vw5O1Dhjp2VB/TQvQBMKTXj8K/8dT5OiHfkq
 uaiJbJ+GDPtUzvyvuCA8WflGPR8pYRA2bQpDFvd9wPNpdPcAChOlgw/o71Pt511rUsOi
 7rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687376; x=1796292176;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yz3Fvi0Z1WbpqBTLJfHCJBGO30gXD4l/AgDztFQ3PBw=;
 b=hFVPoFZmSsyM+DwExjXxVobaDjDLgY4Bc+mCdeIOTnQYMbufe/5WQSVEQaffiRD/5e
 1lsPjZCS7IoR3sdSIm7ATmqJgPl1JhPQ2yibLHOxLGh8quiS/ykrfpAa18VIy/S/v3OI
 mFnTDbAlUZpevq47xUuWPGziyqfuC49Ty+bB6ZzSolUOkNCx1ubN6AyddM6UKmbcQCSZ
 zVsG1AXqSIKVNdZZf6I6+nkRpwDwV3VV8ftNUEt5NlhGPqsQ7fIaO/NJqYYbEEbXpKvi
 DY3FeNbKqes/lV/EmPvcriZqU6xkSmoS3p7NFj2IuAnAubzCE5NMcXwTOxbWTZ8C+dsz
 yWPA==
X-Forwarded-Encrypted: i=1;
 AL+hErHqkj1ZlrLr6bdNBqOHIpKAd46PN9TseL2i2p6+iLWlLoTbip/F5/RSXxj245hyFMUHwvXMBqj743g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/kgWYdzfR0SrQZG5vChxWbT48qPZvQR4sYZpp76mPjT2IXLsdr
 qUVIARdRlKWLDVO1zgq5rNeyuFr2NItykugf/VtmogGjIw5341Q5tLzQ4Lt6sCNQg0ke2hR4i99
 h9CypNSBzJM+T8SawgA==
X-Received: from wrmk10.prod.google.com ([2002:adf:e3ca:0:b0:4b7:f63a:77e8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:600b:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb887fb6e7mr422669095e9.6.1795687376087; 
 Thu, 26 Nov 2026 02:02:56 -0800 (PST)
Date: Thu, 26 Nov 2026 10:02:54 +0000
In-Reply-To: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126100254.3642219-1-aliceryhl@google.com>
Subject: Re: [PATCH 00/13] drm/tyr: reduce the number of `as` casts
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, 
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

On Wed, 25 Nov 2026 19:46:51 -0300, Daniel Almeida wrote:
> An `as` cast silently drops the bits that do not fit the target type,
> and nothing at the cast shows whether that can happen. Tyr has 86 of
> them, as counted by `clippy::as_conversions`. This series removes 62.

Looks great overall. For the whole series:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
