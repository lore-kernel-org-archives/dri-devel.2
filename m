Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7E0CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 12:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6373A10E7AA;
	Wed, 27 May 2026 12:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="B7/oJzEa";
	dkim-atps=neutral
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com
 [209.85.208.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82B810E7AA
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:16:26 +0000 (UTC)
Received: by mail-lj1-f201.google.com with SMTP id
 38308e7fff4ca-38e9589b7c7so5184251fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1779884185; x=1780488985;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3GySeGqKvH9w0k+SKK+eNFV995XnhG9D+usTEWb/rPg=;
 b=B7/oJzEar2T6mEt6lwclf9dK1ECEPsOWfVQDOhGjS5coyL7wAXkC+Bas2zK+x7DYZX
 kGLFYzfM2HVwXor/zTt/Td0WkRlhQFQONlZu5NUobLWkuDmgEoziDzgZIjDMlC9WK9P+
 CzsXeHzwMCg7IFGQ1gHFPDMTEOfh2af9hhWhZ70LcuR4lh+rveR5NW9XeDsCB5ro6iD5
 wqR2BKmfSTRhFK4BxL20uyOLAmdqlZkbuoJd/xnvyLSJl0j6Tbw5yIO8XCnEI+PHOZuK
 iJF+OhJS2amFyx0dRLrquRs3QORdOb1w6kiXzUrQnFj5EjV5LRSZxFq51JSsNjljIH2f
 zAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779884185; x=1780488985;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3GySeGqKvH9w0k+SKK+eNFV995XnhG9D+usTEWb/rPg=;
 b=E/5jLR0XtSm8jo4o4ZhPP0b5JmtLm9OzwP2WaZ5YK0eFa7J+HU5L2uh8EiqUS+1MgG
 gVZf8uQ/BBcXWP5tuTXBrbmn4892+Bhn3z2LKns3MhLJupMedRNDjW0MGGz8gmDxIBpW
 MKslJzl+tbJPSRd2bj5NPiZ1zJzZfQ4pHYnX/dFHHzhrokEDzzSeEmFtHUk0cD2K0LNQ
 A5pzGBqSjRYC3/0Qui7FluBhFVCoG00w6YArHUU58wR8tFgCd2XyroV7mtzLZCwDfYlN
 MszL8z4q+was75i7hkOhU7rVG0N95mqHXem6DC4/Aj8K0wMhIt/+8qDM5xSxKQQjYxEX
 phVQ==
X-Gm-Message-State: AOJu0YyapGYn2NHvKIH+ugcQDL2KPW1dVT381tjoepWvNwlWRh78yb3H
 YCIC8C3wQzeWRAmOGT3txRzRguU70tE3yt/9gHSr/QesVxB+o5iaxgWY4ZBglDDV9HsFoNTdF+u
 NwRsmrRGhEva8z3RxOw==
X-Received: from ljey13.prod.google.com ([2002:a2e:bb8d:0:b0:393:7fb2:6b5a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:651c:907:b0:396:c3c:d27e with SMTP id
 38308e7fff4ca-3960c3cd3femr45362351fa.12.1779884184566; 
 Wed, 27 May 2026 05:16:24 -0700 (PDT)
Date: Wed, 27 May 2026 12:16:23 +0000
In-Reply-To: <20260526212857.1158294-6-lyude@redhat.com>
Mime-Version: 1.0
References: <20260526212857.1158294-1-lyude@redhat.com>
 <20260526212857.1158294-6-lyude@redhat.com>
Message-ID: <ahbglxo5yePyjE81@google.com>
Subject: Re: [PATCH v14 5/6] rust: drm: gem/shmem: Add DmaResvGuard helper
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Gary Guo <gary@garyguo.net>, 
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, Danilo Krummrich <dakr@kernel.org>, 
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
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

On Tue, May 26, 2026 at 05:28:56PM -0400, Lyude Paul wrote:
> Just a temporary holdover to make locking/unlocking the dma_resv lock much
> easier.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-authored-by: Alexandre Courbot <acourbot@nvidia.com>

Missing SoB for Alexandre.

> ---
>  rust/kernel/drm/gem/shmem.rs | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index 116ed0a13eac2..1b24cb1129a8b 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -27,7 +27,10 @@
>          Deref,
>          DerefMut, //
>      },
> -    ptr::NonNull,
> +    ptr::{
> +        self,
> +        NonNull, //
> +    },
>  };
>  use gem::{
>      BaseObjectPrivate,
> @@ -233,3 +236,29 @@ impl<T: DriverObject> driver::AllocImpl for Object<T> {
>          dumb_map_offset: None,
>      };
>  }
> +
> +/// Private helper-type for holding the `dma_resv` object for a GEM shmem object.
> +///
> +/// When this is dropped, the `dma_resv` lock is dropped as well.
> +///
> +// TODO: This should be replace with a WwMutex equivalent once we have such bindings in the kernel.
> +struct DmaResvGuard<'a, T: DriverObject>(&'a Object<T>);

Is this missing a NotThreadSafe, or is it safe to unlock on a different
thread than where it was locked?

> +impl<'a, T: DriverObject> DmaResvGuard<'a, T> {
> +    #[inline(always)]
> +    #[expect(unused)]
> +    fn new(obj: &'a Object<T>) -> Self {
> +        // SAFETY: This lock is initialized throughout the lifetime of `object`.
> +        unsafe { bindings::dma_resv_lock(obj.raw_dma_resv(), ptr::null_mut()) };
> +
> +        Self(obj)
> +    }
> +}
> +
> +impl<'a, T: DriverObject> Drop for DmaResvGuard<'a, T> {
> +    #[inline(always)]
> +    fn drop(&mut self) {
> +        // SAFETY: We are releasing the lock grabbed during the creation of this object.
> +        unsafe { bindings::dma_resv_unlock(self.0.raw_dma_resv()) };
> +    }
> +}
> -- 
> 2.54.0
> 
