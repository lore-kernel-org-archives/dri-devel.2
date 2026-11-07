Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F6606D806
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KXpyZeSF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D3810E0B5;
	Sat,  7 Nov 2026 15:43:05 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0956A10E0B5
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 15:42:58 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a210f93860so13447305e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 07:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794066177; x=1794670977;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EggZBsns3+rf0UaTI6t/NW4lmqRaDYkATIDcO9ZRpSM=;
 b=KXpyZeSF0B5ahxTXRpuqDzokj11G9EzWqbxBH7ldDk3MkALSuILmE7hq+pW2TETaHX
 e4+ahJsiey8h0kYB4H6bwuDXmbdoz5XKZI0zr1aHwVq4zxBSwMsZReo3nVoQw3Ylr7LR
 2leO3ye6dA0/DiTGf5jaBMCgZ6PWIZt2dl5i0yhmVtY08VI7jv4g6TUzwWmvFZLEmcQM
 yNXSCL7DM58GNHswk3bqxh3/NJB92APY480RwSshbHAOkSXQk7LtguNkMfd19gO1zZ5N
 HZ7tOs3bE6s57XhuHDXqsi6GNC5tSikwsXyFmbPkfh5sBZVqbWEF7LL+U8bxCJyRY4hF
 uBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794066177; x=1794670977;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EggZBsns3+rf0UaTI6t/NW4lmqRaDYkATIDcO9ZRpSM=;
 b=opOgeYkbF8mUWmEZ6x/fO38CfysNzFncjewxl+pu3s8XcIjIWbtCrqUInHz+p15tJY
 Lgt33nQLBEE41HXq+G6Fb3G0N34oLg7B2wh8xP2UNf8Mf6zN+TrvKDVYSvMQ8+sjh3D1
 XrNT/i81QZTPcyMooAsNgu8Y6t8Ee+cUF2Kj0YzWD5vB2MzKou8z+BlnTtMcg9dIjj7R
 iQaNzgyJBTxggRYdDC0ttu8IXcGHLc4j/DNcVCzEOu93PXsec6L8dfPJe73EAu9XebEP
 bJIXjb8Rbv54lFIO/jMz3aNGDcv8xPFMA80BmKF+KhyjTUETckWhST+En508+nNfwT3I
 yJpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTdpoWpkXuIJGFg/v0kx9vxZIsUpU8Tng+BZ7NGO+EA0TIQJ6Pfjb2VlfyNrSGPg9ujigWA9rO+/U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8AAFWajIJL+cjKR+Bwk85Wi52VNJQ0ZMXPlCHEk+p3FlmjtIIs
 jJiavXUICr72+4kd1xXZQmgLFPVEz/xpvAlow4RLUZXOZEsYvFBjg5dwdz1BoWAt3wZk1sEmZ/+
 xfpxwV4s2qQLVfukP6w==
X-Received: from wmri27-n1.prod.google.com
 ([2002:a05:600c:8a1b:10b0:4a3:5dec:ff72])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e0e:b0:4b0:9803:dc8a with SMTP id
 5b1f17b1804b1-4b6df7d4a32mr98531565e9.26.1794066177054; 
 Sat, 07 Nov 2026 07:42:57 -0800 (PST)
Date: Sat,  7 Nov 2026 15:42:55 +0000
In-Reply-To: <DMOZR1THYXEZ.138HB6J6HIMFK@nvidia.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-1-67de9180b4ed@nvidia.com>
 <DMOZR1THYXEZ.138HB6J6HIMFK@nvidia.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261107154255.3547388-1-aliceryhl@google.com>
Subject: Re: [PATCH v10 1/3] rust: use Alignment size constants
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 Danilo Krummrich <dakr@kernel.org>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Sat, Nov 07, 2026 at 09:52:13PM +0900, Alexandre Courbot wrote:
> On Mon Oct 19, 2026 at 1:29 PM JST, Eliot Courtney wrote:
> > Use `SizeConstants` for Alignment that are implemented now.
> >
> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Danilo, Alice: could we get an ack for the buddy and io parts, in order
> to push this series through drm-rust-next?

I'll defer to Danilo on the splitting up question. The change itself
LGTM and I'm fine with merging code related to this through
drm-rust-next.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
