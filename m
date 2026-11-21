Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DB606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNB23B8y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A20D710E5EA;
	Sat, 21 Nov 2026 14:13:02 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BBF10E5EA
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 14:12:52 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4a589b28bddso1001677f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 06:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795270371; x=1795875171;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kwU0uvZlqUjWSWVM4I5jaqBzT9+TKQG4/BkygdKEJxw=;
 b=dNB23B8yP64CJkydX1QPp44liaH5jhgrWgJR/STL88VRggqVw0HQd9jfX/5uYQXNfS
 SRxFxD/bwsOBQFIEkzwoh7Q+wzUa1IgERM1Z9XArPkN2EZMqTvnTi/4bL1TY/uW0k0Mc
 7pwBfJNF83GUkazHM/zqg2ZO68rQE+9f60ACeRv5BX6LWjKmC3ADqvJwuuaQVF9bWBWN
 I6auT6ADE+2mJgiovrtH89/YNo05HVGk2nNVL5QQayIpSlp76+lCmOj4+cCMdO3o4f7u
 c+sgONpO4qKUz2/h5cUqQoRexow3an+Sb+boH7gBfKET5OwgOFCLvz1U0L4lylktk7LD
 O6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795270371; x=1795875171;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kwU0uvZlqUjWSWVM4I5jaqBzT9+TKQG4/BkygdKEJxw=;
 b=1AaZp1pJkMzJDt0alhLkZ0Z0DQEzO7PScsGJ6vEzgtPwO7cuZhhSRMHw4/vex4WBJS
 edLT5drsgoN+2V2iyzKeEtoa+v0NrHAcuxU9EYcMzl8rEwiLgelfqQ+t0mUnA0VM0WR2
 /gVjJymVCNP3Ie91zMcGTR2GYO4QKQtBCTMYaClf2zpA9f2pMp1S3YYx5ODOMKEiPnfg
 WPq1PKJKVIjedtWUzQ27P3BtT6pds7rhUJOsoWLufJzTbW1NQ8xnI4DVquw7lMyx2fBf
 tWtPUaZuBqlf5xgkdvsEJVWb6fRknYfLHme4oP+gApVfYvA+oAXPsEcZ+sIJuJPLsET0
 sI1A==
X-Forwarded-Encrypted: i=1;
 AL+hErEinXTt4cL8A5wEdBnDy8OZEUHfDSF04xDcIzaSOVFM+Bf2lCuEG8bC7HeP+yS4SOB2WPjYYC7Y41Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jDmxvuxWrhYEASDaWnBAUUYV9RXhRWnCLYZoJmVZ6vCQIQb0c
 xYUE+VNe4ApW5nim6pFPdc2HoqnnVkagt1QyMUfUciwUp9fvR1ESWMu4ElLT0D0oYoYkEcBDk41
 pgpn0hCEzyC/vQXAskQ==
X-Received: from wron3.prod.google.com ([2002:adf:f083:0:b0:48d:f857:4141])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4b1e:b0:48e:7e1f:8cee with SMTP id
 ffacd0b85a97d-4abb0f3c23bmr13133773f8f.12.1795270370489; 
 Sat, 21 Nov 2026 06:12:50 -0800 (PST)
Date: Sat, 21 Nov 2026 14:12:46 +0000
In-Reply-To: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121141247.142001-2-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: gpuvm: rename UniqueRefGpuVm data accessors
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Brost <matthew.brost@intel.com>,
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, 
 Sami Tolvanen <samitolvanen@google.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Nov 19, 2026 at 04:36:54PM +0000, Alice Ryhl wrote:
> `UniqueRefGpuVm` currently names its shared and mutable data accessors
> `data_ref()` and `data()`, unlike `GpuVmBo::data(&self)` and standard
> Rust naming conventions. Thus, rename them to `data(&self)` and
> `data_mut(&mut self)` for consistency.
> 
> Link: https://lore.kernel.org/r/20261118111653.448550-1-aliceryhl@google.com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to drm-rust-next. Thanks!
