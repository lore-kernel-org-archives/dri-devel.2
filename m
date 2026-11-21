Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65650606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JFOpkJU5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD1510E35E;
	Sat, 21 Nov 2026 14:18:39 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B93B10E35E
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 14:18:33 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48fcb657f32so1040383f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795270711; x=1795875511;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dCAFzOhTnSyNCAJ1uIRHjqbjpv162MEYCH3m4VjXm3w=;
 b=JFOpkJU5SOvJ7fJwewN/igPI4fFImdO7XFzie2Rx9+silorbxAmn75DGA1G7gXb2qS
 0RBaGMKMJcIHrVda97TwraHxzzR828PeOze6LjBLgiWKCrLj8pjaMCL34s95mYZ3+Odp
 8HsGW48yLT1XPNYTjXqIrJRihll1wIh6x+AddT0t+cd99CnzFM6LenWeUPwNetXU0t+o
 1/F1whPYxxxdApPaDeZgCo7c/NXAnNY5Z/kOsTzEZWz0+5j3DyB9pLL2n7oo9yWZxizn
 xnjLByAfEL+xWXmbuJXgQxHK7vDNk6FMiJHmzyFc51u9sOhtxNRB9dbw+f8MXjUxUxfz
 VSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795270711; x=1795875511;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dCAFzOhTnSyNCAJ1uIRHjqbjpv162MEYCH3m4VjXm3w=;
 b=dmL2kxlvBqx9ydD5wdTbn64RYx6B8rCUAzt3nxdywSC+BeWm5q0IyJKeGwKcmYzFfm
 ULAisyAQMFYqflxg45U+ywgIHJXVr+8MLy1yTRskWKfg7HSxqBVLhXOaaaeFVJ5xcXVc
 qPxIttZGwtkEFbZWs9aDOWuuSsIT+f3pUATt1Lm2HWlmmO0o4D9QlqNnYoThseXqj4Ia
 bAOXGtZHNb38DTVnlsfco/uueqx1Z1BW89hYU/MNuJpTvRe1tT31xlf/WZh6eFLIJ9BN
 yPFa18sZAPL5407XhP8clX18vioLxnyFfQNlWkfsNkZfHgCFGpaKZ1RhW8GPxCwVyCe1
 glPw==
X-Forwarded-Encrypted: i=1;
 AL+hErHP/RaCvOHPiQskI6X4X7dzE6Zg01KvdUmFH99uRrM8XJmSTFZsyOh9NKXRp0b6Tu9v/Dz9devuJiI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+IZo3g5i6Nu+1WLdQeczJirlEeTpOiEEocnAoKoK9ZJpXygMww
 SlpwjJKgASemOoSAB+XO53lQmsnAtV+NtYgXlfhfQJJPoQtZo4FOZ6WvMdrt9IxJpJCHk4bCSd7
 corqaibHwt5dyC7oUGg==
X-Received: from wrnb18.prod.google.com ([2002:adf:e652:0:b0:48e:d59:85ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4312:b0:4a7:2673:ad2e with SMTP id
 ffacd0b85a97d-4abacfea57emr13722499f8f.1.1795270711197; 
 Sat, 21 Nov 2026 06:18:31 -0800 (PST)
Date: Sat, 21 Nov 2026 14:18:30 +0000
In-Reply-To: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121141830.171033-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 0/3] drm/tyr: allow mismatched buffers for dev_query
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Miguel, are you ok with me taking these uaccess changes through drm-rust-next?

Alice
