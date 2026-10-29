Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D19606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h4MV+ZGp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2584710E7E6;
	Thu, 29 Oct 2026 09:48:32 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF92811213F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:48:26 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so1095737f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793267305; x=1793872105;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FGbueYQO3ZHl/HehdiAMR3NdzwozdadRj7RvSHj/9W8=;
 b=h4MV+ZGpor76ySdmuHctG+0yDpYKmPpRUHoc0VmIjge1qECD2rrotPM/uZEB9jJjLs
 yIisPgSP15D5AebR6LBVX7qFHFr5+iYUOlxe3I2Ds45tU5WlXRHBUpNAhHhutMoRyFqT
 FLUN2wJM0bSNX9te654sp5e/NhVVzWmwEmObKSM6UClWkvZLo0ae5py5izUpCwn8OQVI
 vqvf/c6uHqHzaIH7F083DDzAVhjx8xu+MXNgS70rkfzTMnurUqOdq0xiKF/uG//w2fM+
 XGS+94Iz0RW0vMsLTiAMJT5sJODWjf9GE4WhQhbjBfLLNQu7OTNMd3BWBdc0nJFSHutJ
 ADWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793267305; x=1793872105;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FGbueYQO3ZHl/HehdiAMR3NdzwozdadRj7RvSHj/9W8=;
 b=N7nzw+NEyOXU+DsdVeLlQzpEVyCHIQRnxDUMx9Y+4gHS6sreYhHyqGgaimbLtKobIg
 IE3hjr4MP5a6Ak7CLIUfq+4emO30oyQ7aX32ucVoz9onUwWxKvCwztmWX4u25XXJNH/6
 L7r8hqX0WCHvfNzBcK50h77zRBL+R2qxwTZUjMyq802FJaJ1RrF+WOyROl8DB2YqLj7K
 4Sg6d+mfvzv4HxysSBgNVxRY+9uvjHaHBi1RRCZiDuNsz7812v+jed6znlNR7JWDkIYA
 HttLqNFHmKniMAe0fuarGAqd6TJqJs6q1SSFVr9ElvGqp0WLNWpVmTDqjXU1wD4F3jDL
 K6eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmOXzlyHf/130XYQ0Bas5akNpFmD1mqLLp2kAi1vA1cEx5HywfdT0axQmWtLgza5+YsX8cczstu/8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqAJTqSOkxTOywZHLkHtpDPPI5CF85j5kmt/PtoTscfj238oZb
 s6LhK6yeYANoUzTXtb0XMPv0yR+B5rIaENbZnmOlmaXfCtk1FdZPgLvHf2/u1hMlifWMaJiTYke
 lxdaYcPMxy6uvSXaTpQ==
X-Received: from wrvs3.prod.google.com ([2002:a5d:4ec3:0:b0:48d:eee6:b19f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25ee:b0:48e:5fd8:5822 with SMTP id
 ffacd0b85a97d-48e5fd85ac5mr9739933f8f.18.1793267305063; 
 Thu, 29 Oct 2026 02:48:25 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:48:23 +0000
In-Reply-To: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
Message-ID: <auMWZyxtC1d_BUgN@google.com>
Subject: Re: [PATCH RFC] drm/msm: move VM_BIND op validation to Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

On Mon, Oct 26, 2026 at 12:40:02PM +0100, Konrad Dybcio wrote:
> +#[no_mangle]

If you use the #[export] macro instead, then it has the same effect
as #[no_mangle], but it verifies at build-time that the signature
matches what's in the header file.

See for comparison:
drivers/gpu/drm/drm_panic_helper_qr.rs

Alice
