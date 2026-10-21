Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBA606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PNW1svy2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C114C10FCDB;
	Wed, 21 Oct 2026 08:53:01 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB33110FCCD
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:52:21 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so363176f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792572740; x=1793177540;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SEtvLlHPZX8KBMC3GTWr7jAy6Jfm2stXMKr2M6fDZ54=;
 b=PNW1svy241wbelwQ5G8Z0g7BfWVj538LVhkrElPzVcGiHdyeHD0ktZnbI4Vd4Z5d3d
 HWeygMzJFHtgZMF4zrdAyThgkAUHLV/Ax0iJbBtZOmbiDDmydMKS52NPZAlIm96jqoqy
 lE9BZM1rGghDcJ/+fof+CTRv6y6Sh7FT/hAEiT8Ryg/CB55ZzLIpG0Tvu5d2DYAz2k36
 cbqq3g+k5pVWcIp8TazgT4cttfbIET4vUL65JmNrJW4DQvVsOddMbju/3s81ZqUCsktI
 7UhmljkHpNigGf7bHZi16ftJlPKgToc6kOH6rXymmQklLC0kxqzyLwc3qaq9AM6IFjaU
 c6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792572740; x=1793177540;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SEtvLlHPZX8KBMC3GTWr7jAy6Jfm2stXMKr2M6fDZ54=;
 b=XCDhP7tPHRVyF61ZLi43JXtQ/PvoqriAPE0rhNohqZxSTJoWfmoXM4ZxUUSePh1wxX
 y6C3Hr+h4u6Ua1znZHrDlocgqd7NeFYZoTEo0cyrdPDXQP546EM65T6bFh1XyV/MSwef
 cQ5fBgaElWHl2U11fBixqcwh7hI+Nek365zBwcwMEPtr2KvOfvFSbZLewtdA7JBiPoH1
 PCL7H63xIStLNka9Io3SHv1B0oJxVw7m8eVToQ8C55Owq6dIN114ZDXLYogff/rScRD6
 9JzceSqb040UtE2rhSsGLYNVaxwYHA9hiHZOpz8mdncv1k/DgdKYKkJx+XA8IgBUlzec
 /qEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/yKn5CTBtlXk2cIHayBK4zCWkj8f48rZQytVJWjWN/HBKB9GoIzaPYomd3/iVsBqozu+ghxg8CHc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPumGalOhRl7M1Mn6+pIWh5J+7FaFsscFKm3OUAT+FoiPG7+xO
 B7k5lBkxcGIBYdLIVtzXuK/qJQzA9vreLO1Et4PT57tLgY0kwRGUSwaWffOOF5P+YmIFo5i/eJb
 pZmsZsLFkoncKRe76pw==
X-Received: from wrqr9.prod.google.com ([2002:a5d:4989:0:b0:48d:faa3:7b10])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2283:b0:48e:fdd:41d9 with SMTP id
 ffacd0b85a97d-48e264958f2mr3332623f8f.31.1792572739863; 
 Wed, 21 Oct 2026 01:52:19 -0700 (PDT)
Date: Wed, 21 Oct 2026 08:52:17 +0000
In-Reply-To: <20261020-b4-dev_query_fixes-v4-2-df66b4c98bc6@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-dev_query_fixes-v4-0-df66b4c98bc6@collabora.com>
 <20261020-b4-dev_query_fixes-v4-2-df66b4c98bc6@collabora.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021085219.426333-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 2/3] rust: uaccess: add method to get UserPtr from u64
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

On Tue, Oct 20, 2026 at 05:06:46PM -0700, Deborah Brouwer wrote:
> Currently a UserPtr can be created from a usize integer representing a
> userspace address. To create a UserPtr from a u64 integer, the u64 must
> be cast to usize. On 32-bit systems, this cast will discard the upper 32
> bits of the address.
> 
> Provide a new method to create a UserPtr from a u64 integer. This avoids
> the caller having to cast before creating a UserPtr and also clarifies
> that the truncation is intended. This is equivalent to the C-side
> macro u64_to_user_ptr() that provides typechecking and casting to a __user
> pointer.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
