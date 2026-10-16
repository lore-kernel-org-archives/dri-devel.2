Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB285CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 12:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212BA10E294;
	Fri, 16 Oct 2026 12:31:31 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696F410E294
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 12:31:25 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1ad49096fso10174895e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792153884; x=1792758684;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7GYnwhI3jVn6b4pynLH+o13sxdIvDiuogpoaPN+NUKU=;
 b=NCej9ljQuQaWGU5IE75bum96ZxxatpSF5ubrbDRYsJfi2tgSvq8teW98Dp7h/ukhJu
 kDeKnQ8BFyItHEdhFJTzJqUpn8mlQuwQEZ5SAYd0kpOSvK1LeVxFJ0gb3EONmgxWBQBC
 7hU75InE+N2/X0fLVcx5kQqdWj4Rdjx97Zl9uKyaD4dZ3BKglMmQ1KSV2DIxxLSeZPhN
 mA8d6+VKnBSiPaBS68Vi+C5XxBgX9lRirYcPeAV3k52rg9U9T2qEml4jEZeksDpNGOr+
 OW2IRRBo2bF27tvU1LHx20I8etevePgJhHqKFGDj5ai936vuWXEHFc5IeWYWdIGr9BJP
 qf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153884; x=1792758684;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7GYnwhI3jVn6b4pynLH+o13sxdIvDiuogpoaPN+NUKU=;
 b=VbrL028aqfUQO+RQoDA3CM2f77i58UfmGTY/rpQz6+ceEyQg7Xy822URsXjY7uSvaT
 87OvDa+GtmOFE9vXPH9FJO9fxG2E6fQ+qLIVE561oRBHiEGzVqasLn0xKYNQZGkuoxJ4
 hp77MnzBRRjXZ9HlQyQNfxa/ADEK5U+Txf3Al8C+CtiAXghb/YLNvCSNGo3WCtr8vV0T
 zRV1QS88LrZ7O1MJvZJh38/nx6YIqoCUzxv2CpHqXZg2uJNczPWM5OY5ghm08MLheh2e
 tLrNUICndaYf6WUkaG+wdqo7nsuKGmiiCdLNBFAqLfYCgcWgwiC1HhRJwlFzmSw8kHCW
 Po8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwD/NalhD0sXoNmoOyJ/s2Sfb4sJBVxW4RLvi/WohmOZ93CUWrNkBpJe8LYds/6PbWltmZtLMgkk38=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLrcNO6dfLn3+8pNmwNCTBo3MbPeOXQGsB5VdMi1xDJO/gY273m
 FKQ9Aq8o44QrAgww/WF7uyJUdUEYugMuZ4GU6FXcXZaK5i4z6BjFN2nNvJ8BR5Agbi/ZFgBRJlM
 tuS64oiVyYmRwLRDlYQ==
X-Received: from wmee11.prod.google.com ([2002:a05:600c:218b:b0:4a1:bd96:2aa0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c106:b0:4a1:7a1e:6910 with SMTP id
 5b1f17b1804b1-4a1c6635d15mr53398115e9.4.1792153883281; 
 Fri, 16 Oct 2026 05:31:23 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:31:22 +0000
In-Reply-To: <20260930122755.1657820-2-phasta@kernel.org>
Mime-Version: 1.0
References: <20260930122755.1657820-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016123122.3744636-1-aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: DmaFence: Remove static lifetime
From: Alice Ryhl <aliceryhl@google.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 30, 2026 at 02:27:56PM +0200, Philipp Stanner wrote:
> A FenceCallbackRegistration can stem from another party than the one
> that has created a Fence. Should that party forget the registration
> object (for example through a refcount cycle) and then unload the
> module, a fence signaling would run into the unloaded module, causing
> UAF bugs.
>=20
> So far, this has been solved by demanding that the payload data of the
> registration object demanding static lifetime.
>=20
> It turns out, however, that this is harmful because the static lifetime
> bubbles up to all users, ultimately potentially causing a large amount
> of driver data to be static, which renders the lifetime obsolete.
>=20
> Solve this issue instead through an unsafe requirement which demands
> that the user does not forget the registration object. This is also the
> solution chosen by ScopedWork.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Applied to drm-rust-next. Thanks!
