Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25C8606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lZM+voav
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE2110E3F5;
	Wed, 18 Nov 2026 11:17:03 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2CF10E727
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:16:57 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso7774535e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795000615; x=1795605415;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VdBK9iPCpdL4SaGML/svEnUVQsDV7jsVMj4rTVCaMEQ=;
 b=lZM+voavRrgae7YJjwz9xQwV0ROWpkgoNvZnaYKf394Izjr7865cbwbqCHlyv203T7
 nFDkDbF32VKrQ9NElI3iW9cUWm9zCp2g0k6j3jgCbLo+exYJLjPjVcj8F/kAPfxejvn8
 TgHwJkzY1/IHEw/t6lXZ9dvNDd1XnM/jO5I8A7ETDYMw9jVOxzQghdkbvqrLoHHl2TNm
 Vx46FIqBpMozDxZYbKfuR1owQQZjcWo998R4hsajnqMluIqLk+FclEoY+b+bngVwLQkm
 mhptu+xQgzIPrIPi+rAh8bRHpuRd3pNAhV5QEt28TNrf8Em87rioKv20rgZ9R1eyPtAn
 2vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795000615; x=1795605415;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VdBK9iPCpdL4SaGML/svEnUVQsDV7jsVMj4rTVCaMEQ=;
 b=Syawxq3Ckiob4NosBe8h22KEtOhUoIRWt4nxEYdmhYrEXIwgra8MMN0Ylfb6iplrUv
 7ISlJndThkFoAys5q5yS22KjiI0gWPnZwEOUOCGaR2Yc/BWBk5mDIRyZA1uLRsiJAQNM
 HRshtlxt598vO8qsKnUSOFnKThY48Z8E+JeUyJHsRZqoMuMe7pqyGGSACzIMwsCb/8CE
 8Y+ko7WcszqF72Bg2WpgfCSga67j3XMMTH3y7BiSVyZoprvJwTlUwEK5H1/VDO0lJdIt
 C+Ae2UUWynWK38zqTWSccH4xsJYYSZhfbZV12LnH02AiPex078Q/WpPH/+jeygY9STnA
 aiRg==
X-Forwarded-Encrypted: i=1;
 AL+hErEsFy+wb6OOPWw1GvUL1nNfVgx18OBKV3ns6Jh/FTNCF04xGtP7l6VMPi/JXLaM83/+HqZVgrEqw0g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9/Lpu4LKkCjZNRMCSfBFscVByzbdcA03MPe/poePjO+9tnWj6a
 lZnSwvl/UaYfnvAY9fGkh3HVO5FWdWz4swBXcjImuhxSMJbU1qZ+r7giQQdPFAA8yINnGAHG1rc
 DYHBo637zY8+YW/WluA==
X-Received: from wrsw6.prod.google.com ([2002:a5d:4b46:0:b0:4a5:1c26:11b4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d06:b0:4bb:6f45:2a6d with SMTP id
 5b1f17b1804b1-4bb7da14a3bmr43246995e9.12.1795000615091; 
 Wed, 18 Nov 2026 03:16:55 -0800 (PST)
Date: Wed, 18 Nov 2026 11:16:53 +0000
In-Reply-To: <0d26baaa-92ae-43ff-9a76-a81cad624dcf@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
 <20261117-tyr-remap-2mb-v1-1-2a8efd4c8180@google.com>
 <0d26baaa-92ae-43ff-9a76-a81cad624dcf@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118111653.448550-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/4] rust: drm/gpuvm: add GpuVa::data_ref accessor
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 Sami Tolvanen <samitolvanen@google.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
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

On Tue, Nov 17, 2026 at 08:40:20PM +0100, Danilo Krummrich wrote:
> > +    /// Access the driver-private [`VaData`](DriverGpuVm::VaData) associated with this mapping.
> > +    #[inline]
> > +    pub fn data_ref(&self) -> &T::VaData {
> > +        &self.data
> > +    }
> > +
> Why data_ref() instead of just data() or a Deref impl?

I guess this came from mirroring UniqueRefGpuVm, which uses the names:
data_ref(&self) and data(&mut self).

I think it makes more sense to rename to data(&self)/data_mut(&mut self)
for consistency with other similar APIs. But we should also update
UniqueRefGpuVm if so.

We don't want to go the Deref/DerefMut route because mutable access needs
to return a `Pin<&mut GpuVa<T>>` which doesn't work with DerefMut.

Alice
