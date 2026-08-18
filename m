Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D3C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C8910E1D7;
	Tue, 18 Aug 2026 07:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UNZ20DWu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B1289F35
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787037649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AH2rzIzO8xOuQwuHw1E2qkQOPI5JqW1bPKl2RlhocFw=;
 b=UNZ20DWuiEwFN+15v4ASYhRe6pRY6hr94OrkE7B6Agw/auVJJYuFASB96BjWJkcRTtWua1
 moSVtZM+WBqeuV70kT5KiK7UAk1RETa+MjV6cy45f8jcr3OA+BE7ynPof0LNO3d3QwKLAj
 YuH3qAr0LwfoFKHAzmEkSXFPICDJjZ4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-tE2mG18LOa-Xe9FK2JT8hQ-1; Tue, 18 Aug 2026 03:20:47 -0400
X-MC-Unique: tE2mG18LOa-Xe9FK2JT8hQ-1
X-Mimecast-MFC-AGG-ID: tE2mG18LOa-Xe9FK2JT8hQ_1787037647
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-836cfd56077so61547327b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787037647; x=1787642447;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AH2rzIzO8xOuQwuHw1E2qkQOPI5JqW1bPKl2RlhocFw=;
 b=T+fAJTIpHvAwi0WMVr/+D4oOVHbESnTFBQWipyTLhaFlScZQ0gkaCwmCJnMll4EEau
 gOHq21L+lYfyMJfY8HLU0AkvVgJ/EUsEJ3srwt1Te2Mgp1OLP6neGg/brsKtxBijMO+A
 GOP920tRZHOnmcIqFzYpYUUwsdGSSPMU+1PWMyxp9cbJ6KTzbwFif2WNzv24yewB7lwB
 nDRMUIlEsRyq3OzOZmV1UgsefGAOEhwnZlxSQKHFSD8yLC4Wc1Va2Byy5CckkyrNPjEm
 XSP0QkIgMaX5LEg+NPjpFqIgii02WY0j1znpQhqf25StoZpEdWjatj0ZddfxD3AnPh0B
 IH8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoekuvijrfkzFsneMmJ4h9Uk6TrRVINQbWqdzW4erbjimNVd/NSlw+V03j0857/WRkOtBvo680H76E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyN5N9tFRKIYImL/2bApcIHFPXnDk0jmVXWhxKh+e66Q+cNczKB
 zRVTdwEUEz4Q+HYQnQx2P1z9nrsGR/D5x4lDxRcw7D0CGi5PasLj/USxVXsz8sFq6eoi9ZxzT1O
 HB16j217GmV46XgkHFPVHJAFmB0S8/zIQLjyqNoOlg5Dz/ZMQgGvs5Nv+gRq/xmQraPit+A7YlE
 gH4fNywqCcZOXZfIB/ZJQ3SgbBBjZdMv9ybSuL85Q2goaB
X-Gm-Gg: AR+sD13EUVr3N3qpRz7phfBoBvSONiCpd1ZbPsdoHe0yDaEqRTDX9CIjgpx8S9kMADW
 8IHMlemUXWkZDUSMCxdfR5oNP2zE2u4nrpZZT67FKqeByD2ByzXdtblvjmpfwxoO5YN9h19kOq2
 YX5fqIElpCzUT2vG6moPb/U9ORQAOHi04fDnN3gBVqrqICM9X2XLErfdc=
X-Received: by 2002:a05:690c:e1d5:10b0:81e:6a10:f90f with SMTP id
 00721157ae682-8371125d508mr80483337b3.17.1787037647082; 
 Tue, 18 Aug 2026 00:20:47 -0700 (PDT)
X-Received: by 2002:a05:690c:e1d5:10b0:81e:6a10:f90f with SMTP id
 00721157ae682-8371125d508mr80483207b3.17.1787037646635; Tue, 18 Aug 2026
 00:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
 <20260817-drm_panel_bindings-v1-1-1f974508a31c@redhat.com>
 <20260817151815.GA757484-robh@kernel.org>
In-Reply-To: <20260817151815.GA757484-robh@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 18 Aug 2026 09:20:35 +0200
X-Gm-Features: AcwNN1XPNBWCoPE2Nkai9E-mE_8PW-Et12-aqT9wAxfp7sMMAA08KesO-xwraw8
Message-ID: <CADSE00Lfh=8CSsadEoiEAd3Ld_0=nphkYGnxNH1v1woNPbF_bw@mail.gmail.com>
Subject: Re: [PATCH 1/5] rust: of: add Node type
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mripard@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nm_l-94bGBi7gDPdFzCY98bPMxYdfbIBcpzV8uM0_z0_1787037647
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 17, 2026 at 5:18=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Aug 17, 2026 at 01:40:46PM +0200, Albert Esteve wrote:
> > Add a Rust abstraction for `struct device_node`, the device
> > tree node type.
> >
> > `Node` wraps `device_node` type pointer and implements
> > `AlwaysRefCounted`, allowing owned references to device
> > tree nodes to be held. To do so, add C helpers to make
> > them always accesible from Rust bindings, independently
> > from the configuration.
>
> struct device_node being refcounted is a kconfig option
> (CONFIG_OF_DYNAMIC). What happens when that is disabled?

With CONFIG_OF_DYNAMIC=3Dn, both refcount methods (inc_ref and dec_ref)
become no-ops. Same as with C code.

Since Bindgen does not generate bindings to inline functions, the
helper functions ensure that bindings::of_node_get/put are generated.
Otherwise it would fail to compile when CONFIG_OF_DYNAMIC is disabled.

>
> > This abstraction is needed for subsequent patches, in particular
> > for creating drm_panel instances from a `const struct device_node`
> > pointer argument.
>
> My intent is to make struct device_node opaque. We may never get there
> with C code, but please make sure Rust is that way from the start.

Got it. I will reduce the visibility of the raw pointer accessors by
making them pub(crate) for the next version. These are the only
accessors added in this series. Future methods accessing struct fields
for 'Node' will have to rely on C accessor functions.

BR,
Albert.

>
> Rob
>

