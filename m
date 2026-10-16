Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB350CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0558310E34C;
	Fri, 16 Oct 2026 13:55:10 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CE0C11285A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:50 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1af80b913so41010575e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158889; x=1792763689;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Q2telF00vVM3XLDo3RDg3FI1UZeVzx7pDk2LUXQEFH0=;
 b=FR7+8mPTXlQIICzywoZw6VfPNxoFLjWBDENgGpMoFfptTPETh/GNqEQ6Ih5DU9+Di8
 AmVZR/eZOAldZns//UPLhscRribAniol4vePA8Em97lBeRolxC6COKi6qjx3UTSCKoA1
 ZuSNculEzBUucONe+a6rUWXSkDDS8wff43GnagWJFgtYeLevoLClB00gCo6YHmx5O9T/
 LpRjZhdyNhGsbrYc4KJ/3xHpDXt/o9QNgXXIIcMzw/AOUO5wxdkAUoaEA8VyrYsUmS1M
 N6N/DpaE9sF04/kQ1Q2iTJudwYShDIObqZ6h+aVC4B2toRODbH1ieh2/ba6Pqv/C00Nh
 u4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158889; x=1792763689;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q2telF00vVM3XLDo3RDg3FI1UZeVzx7pDk2LUXQEFH0=;
 b=XaUwUQ6BGbHH7NX6RNVZIGEz2inhaXUAaZcAw6c4CrVpuDTRLHu2Nyoe95/Yp93MdT
 P2foUhQBYwqwBo9ih425kI0U/z8R4VKSZsDMVFGYJHOOtstfcsV/K912JaRlaFQWx4ew
 wGZG62DI6KyZ5drmQ5UYwfpckpuRN9zJYNkwJLKwmR0SFpakBesVOO/FkeqZgmjURsBn
 lcsbgLDLUmX2Qaz22jx20WcC1wkmof8cDeysgXc5cz99JVFdWXnAjgV11WXPdh8quVjZ
 1bHOzrx5vD7a11uoHYIFonUIg9FxC6yd3uycbXWx1uNCJ/RJ7WKQ83Uty5BN45FL2yQ0
 g41A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvEdQY8iGgJlqSiMe750GMZArpQPgj8GQRQtMmIrKmj0iF+tMbNMa9eFqUeF4Gj40ymZK980gKsh4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIDSu3JoDjG4T+lWwK4qeTVSVkEGvsZCBwphI1zx0EM+s4E/DZ5
 fmvEmZ2Z7gTRANbePKTUNYf4aPO0cfiB3uAT78bGt4EfGQSrH1J94C4YPVjt3LnLrAdhteJIbar
 4LkN3EFH8WZwQ0zbj8A==
X-Received: from wmf1.prod.google.com ([2002:a05:600c:2281:b0:4a1:91fb:4150])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8d:b0:4a1:7701:f863 with SMTP id
 5b1f17b1804b1-4a18e4aeae4mr415823135e9.15.1792158888314; 
 Fri, 16 Oct 2026 06:54:48 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:39 +0000
In-Reply-To: <20260814230923.1292966-8-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-8-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-7-aliceryhl@google.com>
Subject: Re: [PATCH 7/7] rust: drm: return impl PinInit from DriverFile::open()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, acourbot@nvidia.com,
 daniel.almeida@collabora.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, 
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev, 
 deborah.brouwer@collabora.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Aug 15, 2026 at 01:09:05AM +0200, Danilo Krummrich wrote:
> Change DriverFile::open() to return impl PinInit<Self, Error> instead of
> Result<Pin<KBox<Self>>>, consistent with how bus device private data
> works.
> 
> Drivers no longer need to allocate a Pin<KBox<_>> themselves; they just
> return an initializer and the subsystem takes care of the allocation.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
