Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F1606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mOyHtKtd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2928C10E58D;
	Tue, 20 Oct 2026 14:02:00 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F8610E58D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:01:53 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so27706425e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792504912; x=1793109712; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4WqTnmYwNtZuc8yE6m3Wj6x4W67f77rHRf4agpevk0c=;
 b=mOyHtKtde+JFGEE7Hojx++gIG8d6Vj5k2tRFdb2P4QgikOWn5rLh0Xi8x/4nSN1bAa
 9OYZG2Eb0FUOTdsG2d49Sktryzo1y5UB9EAR/j+T9eov1P9LyjRdpb8HlL1/qn1Q9VPD
 PcQhWbsbQEGouZ0DF0X9/lwkAULfsVZNkgXYJWR2bT3BddiDixxILcyd6ntKNkO5DWMP
 JH/Up78eax60BUMkrc3NfX+OIXWOfcAb9nrjKZ4/GDJLATUy9Yx7XRmmyOvAxQ6/V2q0
 k9imXLo4saUEtFCFi4h0WCCTasN8/5E3YTacdg/XaZlNsCTmziMzlhv0RXN+9gzmboyD
 guWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792504912; x=1793109712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4WqTnmYwNtZuc8yE6m3Wj6x4W67f77rHRf4agpevk0c=;
 b=2mFfmoGxCyRKVuZkKYffWQpVtUvmOdxEplQdDTrVM06/rVMcVn3LXvVGRnf0P4QYlO
 CCqB2APwNTyp6ynSmtbIcuM3tIY4y5gmfmNbtUVk4t+0BP3AYwN4OGcndc/Hcyh3La/W
 6WnAetTjFzf4Ai9Mmg4o7sOIpfF20u7KMtQd+05S1An9N5B8FT1MF0Nk9blboFpUsCCN
 GoGDHj5JQPxaHuDlcN5yH8aCZYPEkx91+xzOo5MNCx8jh20Gi5GYgc+xw8kMediQlZiJ
 gsTzmduCEm+n63krNyGQhJcehZrAi6vclSLQLb0BRKOPPzjO5m932Dr1DJO/iwcED/X6
 iO6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZdIjcrdvOPAMQwRynJd31mf6Xg79zG11t5pHPnNbmhL0edsM98T24LGYebbbbBjCMVuiEYSALXrk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL8PirFQC9DyZJ9IB/WTu7rgG2Ut/MgDjV0H2ysB31RE2tP7Jbe
 PySHO4RSGucrojnfSYlYfYrsS7kgMrsWaZyxvAXnG7jgN66IAE+Ls0iZ
X-Gm-Gg: AYBFou1eMskNdMv7ePcPl9R92fN70lq+baVBSS7Wp+/hOyKb+AtFhQ7AfvmdETYpPl2
 IVGM/WBUoDep2DBQqSeNr9zuMdN7aKu7P2uQyhq+H0Ke6d5IQNcs+LMOwwGaoOqj5pN2HDvmo+i
 HkTNQORpXQSoIK8w5Tjazy3OpMnmVtz5k+pi0OxlG/nV1LkOYkvaLyUbBEtACf/98ieY093/DdG
 7X6vWQb44e4l8rTR7mjiZGd9Kh0V4LyOxH3DuU2bLewIntVXGIqYfJIEafDzrYMPO4g7y52wN2n
 uIzBC0LfVnAi44pn1LD6J7aztKzPAWx1tyFrEUfpoynKDbP+tDd4omfPBbnMao/Ii9KpOiU7zkB
 9+xNhkqfgzxyTKAKCZu+sO3mQznmZXK49jvXiynMycVWGBcNjPYc6SQbHlNKZkUXjPc3JKtNCPQ
 9XmP89zzqBjmrmL/QTkEZ/iuxIJQMNn0Yg3hUMTuZkrUdBUScFWUGVvC2xynx10SC82sDwuwzH8
 jp0ml9GzDXfc5GyKIVrX7n1M1TxvzNoa9rXIdTWyw2t/foG4G7Tpem8Nz4=
X-Received: by 2002:a05:600c:4f95:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a1d75e3c9amr244362825e9.9.1792504911471; 
 Tue, 20 Oct 2026 07:01:51 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([150.251.170.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d324f8sm67581075e9.6.2026.10.20.07.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:01:50 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:01:46 +0100
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] rust: io: split IoCapable into IoReadable and
 IoWritable
Message-ID: <atd0SnEL1ZLXHxVU@C422HJQPQG-Fractile>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
 <DM9NGD5R8AP9.C4K59HIUYFDQ@garyguo.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM9NGD5R8AP9.C4K59HIUYFDQ@garyguo.net>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 01:04:03PM +0100, Gary Guo wrote:
> On Thu Oct 15, 2026 at 1:39 PM BST, Daniel Almeida wrote:
> > `IoCapable<T>` provides both `io_read` and `io_write`, so a backend that
> > supports accesses of type `T` supports them in both directions, and every
> > (non-copy) `Io` method that reads or writes a value requires both. There
> > is no way to express a backend, or a view, that can only be read or only
> > be written.
> >
> > Thus, replace `IoCapable<T>` with an `IoReadable<T>` trait holding
> > `io_read` and an `IoWritable<T>` trait holding `io_write`, and implement
> > both for all existing backends. The non-copy `Io` methods that read a
> > value now require `IoReadable` and those that write one require
> > `IoWritable`. `update` and `try_update` read and then write, so they
> > require both.
> >
> > The copy methods use `IoCopyable` and are not changed here.
> >
> > No functional change intended. This prepares for read-only and write-only
> > views, added in a following patch.
> 
> I think by Rust convention these should be named `IoRead`/`IoWrite`, but we've
> aleady named this `IoCapable` and I further made the mistake of adding
> `IoCopyable`...
> 
> So I guess I'm not in a good position to ask for name change, but we should
> consider it. Apart from the name:

IMO the -able part is quite important. As a reader, seeing `IoRead`/`IoWrite`
doesn't tell me enough about what they actually mean on their own.

> Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> Best,
> Gary
> 
> >
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > ---
> >  rust/kernel/dma.rs    |  12 ++++--
> >  rust/kernel/io.rs     | 101 +++++++++++++++++++++++++++++---------------------
> >  rust/kernel/pci/io.rs |  10 +++--
> >  3 files changed, 75 insertions(+), 48 deletions(-)
> 
