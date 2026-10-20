Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2853606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tiOtnJhK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E7910F344;
	Tue, 20 Oct 2026 08:02:07 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C3D10F34C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:02:00 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso25341515e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792483319; x=1793088119;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a5szgawaqFYahDoR6WgawlMOYcIGKmjMs7XIVNwb/WA=;
 b=tiOtnJhKIU1ydo9DUPrqweTfVEBzhNNJQybBMmv/XiIrVM4u2A7S1XzUEI0sw6LIO6
 PRAdGRsXLC1RPWyEQRqHGbfXilCM3bN1FFsw5LxbDiUYjApTrmqVwQuRBmvQ2QUULC8c
 2vZhmVjGcaxzsXGch17S7vdCc12w777luYI7DCtqpcxkFzktJnOvm3HGqvSfRD1xma1e
 8c0kWkdHEG4Wmkbe2eTI8PWXEo9Waj6K23njserLDLVy9jawsw0aHV9c4kOxnJBx5YFp
 MEPr8XHZ2Nq8E4q5xEptcLuAl+tascVXPrPTaeNFViTrDuXw/6XHj6e+K2DyNGjNQ8mG
 0LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483319; x=1793088119;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a5szgawaqFYahDoR6WgawlMOYcIGKmjMs7XIVNwb/WA=;
 b=EQHe944WQPlXCR8JKUZs6uje7p/W2iwfp3vKPRI9Wr9ROsfxTXEiIUTd/4c6GvT4fN
 Gmn429gHJm7V7mXhqXUU3r3KW9YEe1kq5J+4VDwcmOKFfYWSRqmy6qk7dybPIEbQde7n
 izzyKJlMcb0oCgR8YgvEUXEGgJ6J1hafK3Y1wbbyUUb3a9pCwQF/LkX1cqb330jqRbKe
 Zc6cyVQ9gCM0VmzDDlwpDWEv1VgCfXtzUq7vz2iYZc7bL/lOPCRYfiGFCRPbPooQ+KQZ
 1lvz3+N3V1O9R3m7Hj+PKN645wrRJ/Jrgn+KNFY8Vc5dCTtfPCcs0sUN9eKrdpNK4Aie
 8X5A==
X-Forwarded-Encrypted: i=1;
 AKwUvByfqgtqTYpuM0OC8yHB1Qppn+vVLQ4RYAg1M+8KObND9ts8SJiLwSjTLLJlzA0Xcc9l8IEE0Pwqbqk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI0h1olLQLWOWElge875wuu6PfFFeCm5JsrKdxzCwIJt5eefY4H
 ga3m+/hJTlOYyTLsDcL+q3FAkRpcFvltpDxa/UYRQ6mapzXRfr41ccdFj8aV0+2ElSJVEm7eQlz
 +Y68p1Rtp9+Dn17K9Kg==
X-Received: from wmcu7.prod.google.com ([2002:a7b:c047:0:b0:4a1:f37f:7f0b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:638e:b0:4a1:e6ad:baa3 with SMTP id
 5b1f17b1804b1-4a1e6adbbe4mr113338955e9.15.1792483319125; 
 Tue, 20 Oct 2026 01:01:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:01:46 +0000
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020080147.1743459-1-aliceryhl@google.com>
Subject: Re: [PATCH 0/7] rust: io: add read-only and write-only views and
 registers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, Oct 15, 2026 at 04:19:40PM -0300, Daniel Almeida wrote:
> This series adds read-only and write-only I/O views, and the #[ro]
> and #[wo] attributes to register!. An access in the wrong direction
> then does not compile.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I heard a suggestion that it'd be better to drop the Io from these trait
names so they are just Readable and Writable, because not all
implementations do IO (i.e. if it's SysMem it's arguably not IO). Not
super important to me, though.
