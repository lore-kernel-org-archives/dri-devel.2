Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CE606D820
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dHk6l3LZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3BB10E43A;
	Sat,  7 Nov 2026 15:43:06 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D57810E0C8
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 15:43:00 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so1455696f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 07:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794066179; x=1794670979;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UtE4jHZNbkA3H0t8CQNNqyMHOp5CvbRXgZpzIPjWa5Q=;
 b=dHk6l3LZyahRaRR+MTYTe730NB5Qjhj5PjxuL9W0CzvxH2Lqq+27VUNwXGPlfn8SFB
 TRccip3eCNiR5s3VWHpMZSC+zkQ+3VaTWmb3o84OHTssKFOU8HnLBTam+P7+QYhpnT5J
 DNsjLoIR+Nw2ma0IP5Fi7KVHf/SV13Uyza+mZcmdiJvRuC2F+02S92t2UnNb5c7iDAgX
 ohKGsdn9x1vkaC/ihOp1sDM1utWrU6gdY2bFLfp7Upetm62fo6lP6cMtWApQdGyyyx6L
 yyk4kqtg5BB2xDLvMGkc1lrg5/ZsA53rJdEEeO67qxBrkPUgB/VxAjNcuDm4loiztUxg
 +5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794066179; x=1794670979;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UtE4jHZNbkA3H0t8CQNNqyMHOp5CvbRXgZpzIPjWa5Q=;
 b=bLIDXsLS/+QYqwLZdJvrprOaFz6ksA7g+9yi4QNIBFr6O1TmOXblaaizHBhOX0v32A
 mc3nsGFwwY/9kOiqfPy1QFmEYm3jQ89Tp1Vzif95Za7dw5W8mIQgw3e1hjyixJHu6ha1
 3ZEB1YBPaWURthc9VQQZ8gTows+4y0oC22D9XLgbNVDA8ZeZAI/+ACCFRYjXbdciulV2
 X8DnjtieIJtjV4egqZOaKrAeeROwZtZnLjZ3aJ75YfL4LOnHl+QFW1b42gFyO58dbptm
 H7iQo38ufy44pcwLhcqSIFLI7CragLfTHwCb9LKWfbRW1ZO/0TrHifO1+OPKwLiOiLYP
 FpFw==
X-Forwarded-Encrypted: i=1;
 AL+hErFDpOUx8/yDQ3SlKlCjUpy4ypmd0dxOO6/465R7YrALhRvwt7qpa7rsWdbxKA/KPQN8OgoSjI7dvy0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/144knYqcmpad4hWAowurX+c58Fmfb5SILv2fRFX4nVXuVIPuL
 K5avx8FroLtgNhzLUKzbGBAnSAdpTWcDRN40AZW8lP6wbvsSa0vf2gnhoa9GkYuhiymeP6VlMDf
 JMriLrnRdwtDoAfiBUg==
X-Received: from wrwn9.prod.google.com ([2002:a5d:67c9:0:b0:493:5480:e00d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40c9:b0:48e:6812:5ef1 with SMTP id
 ffacd0b85a97d-492765a3fcdmr13214907f8f.25.1794066178310; 
 Sat, 07 Nov 2026 07:42:58 -0800 (PST)
Date: Sat,  7 Nov 2026 15:42:57 +0000
In-Reply-To: <DMOZVVGB0O5E.1XLZHZVLFYBAJ@nvidia.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-2-67de9180b4ed@nvidia.com>
 <DMOZVVGB0O5E.1XLZHZVLFYBAJ@nvidia.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261107154257.3547546-1-aliceryhl@google.com>
Subject: Re: [PATCH v10 2/3] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
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

On Sat, Nov 07, 2026 at 09:58:31PM +0900, Alexandre Courbot wrote:
> On Mon Oct 19, 2026 at 1:29 PM JST, Eliot Courtney wrote:
> > Current code in IdPool::with_capacity rounds the capacity up to
> > BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> > smaller than this and still uses an inline representation. Remove this
> > behaviour.
> >
> > This allows specifying a real capacity of 0, which was not previously
> > possible. This breaks `grow_request` in this case, so change it to grow
> > to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> > `shrink_request`.
> >
> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Alice, Burak, Yury: I would like to get this series out of its current
> limbo. AFAICT, Alice and Burak are ok with the current design [1][2],
> and Yury's request to change stop using a zero-sized pool in the example
> has been fulfilled by this patch [3].
>
> This series would need to go through drm-rust-next as we have
> dependencies on it for the 4.5 cycle. May I ask for an ack on this patch
> to push it through drm-rust-next?

That's fine with me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
