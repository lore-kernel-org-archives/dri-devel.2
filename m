Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54387C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88BB010F45B;
	Thu, 24 Sep 2026 10:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="L58Wfz7d";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F2210F45B
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:33:30 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so1345063f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 03:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790246008; cv=none;
 d=google.com; s=arc-20260327;
 b=MhvsqAc89L++UheLJftU1sX1JeQloBRN29JMcCwHsVewJZi0Q+zynHNmuTnQWOGP0O
 Wq5JB0A5IAn0ItARaaHN/CdBaKQiaMSQKTbjJUfZwjVDRzLCeGHSpb8tbSL9aJir007W
 HXXWO4z7EltwXftoEfWRj0EPpG07AnUh8/ELR8LKGbNSh46xchT1DnH8pQAZrLWtiEgl
 /l57y2oGA5Soem87OGSKA6bwYFx8NNwyiG8fErwYZ5ABJL06oNcKwwPtnj+YvPYQ/0MO
 RQSrHEZR1oiyfpHbc6/3laKuEpwvrCSZvWoFQzaw8N98QJ20kkpXu8D8v6avApL4d/vq
 Oqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B2Y2KJCyXfWZMz2HsqnglDrl7rh38AmDRqjeiA7oS9M=;
 fh=Ok+rHjJHFp2WYzChU8imsdv9/vdIMG7/uAKtXlOMFso=;
 b=YFochcflE/USvlnv+BbeXS4aal9n/rSG6K2FONxhRntWhT6tCCyRSz/Ddf3CnOTCGr
 cFPvPivIt9xAW5+qeapKM54YqIyEpPTTjtSejiVAqNb5DFJ2En0BeyM8NyIwGRqUfHsc
 qXIOG2q/PedAKXb8bYPTqOlRzwbw90E1ynQwaOTfaFp9alxIpr4nVi9+RAb9iEpSGhj0
 1WH8SNQjjoGazEV2gIS3WbCr79RD42ppUs3dQO6605q2D6fri7Y6r66vH3bomJ5h4VR3
 wbxSqYdiHN8AIHA6zpqYSXbDkIHPZH7EY1p+rrBK+spZk4jDmU3VNdM482PN2Wcg8IoL
 hyiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790246008; x=1790850808;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B2Y2KJCyXfWZMz2HsqnglDrl7rh38AmDRqjeiA7oS9M=;
 b=L58Wfz7dvyPf/A63ajRO5andp7OsIEs/MpyRMDT3jYtC1JTn7gHIDufve82KurUB6w
 F+eCM7gGOevnC85VaPTRSi3PL+m1ANbMWqiSRJy0kt2nzzHuzMYjl/VrmlX8+TTsuskf
 UvFdH+vpXth7ffr+Ym+NYviYPI37wjj9BU+UZ+U1tXakBtZhxnMOPJG1PwPsux+BVEwe
 lqM/w/KCRP+TNYxX+KHK/OWKmGnRGLzAspuU1xXdyP7nM0UiRx6jZo76mD4KbIuGchrQ
 cV0R9RsVj9v5Lt/dU5IzUiG3TuUI4ShJCgge2UoX+5grFDEva1YhULzZxGgAAemG1N4T
 tWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790246008; x=1790850808;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B2Y2KJCyXfWZMz2HsqnglDrl7rh38AmDRqjeiA7oS9M=;
 b=h/BzEIgxiQOVC4e0K+/HItTmiEZDYkkgY4zH5qL6D2/apnEq7lJQUgYK3D8XL1Ritl
 1RlLGzLVGwASwBRQaoWeaNzs1f4fbRUww7xPTiTha2PG70tEB9+9+iYHE8NrRVa2Elo9
 kbDXA3XTv1Y3pkJku+spGH2u+HQSya4I9olj2HaZMyt+0LxmVJ0DXl3C4yiAeNqmg8VV
 WvKhCJqktT+xvfeTHxStuqWCkdgZuzCa+WQn1/xTrpxio5LQDSiGnRnRlRejDC+KTjOD
 a1FXDnH2YjV+Kj4pMt/bidFo0GR2QTZTsWfmkcAr8KN6BVifJgSlrlllSs3fN1FvvvZv
 OLOg==
X-Forwarded-Encrypted: i=1;
 AKwUvByiFdtWe3AQYZ8NQj3qzudXV4xgAOqPrTFZv96foXg3eybMupMIvQft80bq7u85HdQrDaB1Snaus4s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mo/INvhiRrS5E6+zg1hTP7cPsW/tcBuSaFf2HF47+48eJtfgF9
 3WULQCv1ZRxoKkKJ4XMWqCUFCBIe8ofNWzTXa0f6+jFFfoUM08q5DqNGSv3+gp0rvBSMV3ElvD8
 2vZqfzbCJxroFbb8rXMDu7BzfYZ1sGs2k0w+SU/A2
X-Gm-Gg: AYBFou0vXiB+UL2/C2wdE5fJ70UbTHET3kQCzSPWPoP5B5q/rASKLd6FVgMstgjwP0w
 wm2TmhXIhhRQApMdlp4Tkwzwv8KYW6RmZBMu/iSO3bDXTaI4Eg4AkCjZXV6o+JQDb5OAQDYTuX6
 WWY4gRPcG2Mi+CteWHshXelG+kAbFo+KiTy7SQfEzxc6BRX0rCo5WVLT+iwogfJp/vuXbx8beCm
 P4BSf+CvzNMBpJajCrXXixg/hfrkMzZ12/Tm/pvFPO6IISzu8KM+HLzdb0OxOm7JtrempN9a8GY
 l8mAJsdMCbWm3M4nOixxAJ/yvfTZaU3JGwy0Tf5bDff73dTuKKvPjkaAvMtnxqSLGR82f022J8f
 nbRq9oo3bqI5jLA68ugSj5mKu6MiqdjvL3KL+Yx/Ro3CqRe9pcHOw
X-Received: by 2002:a05:6000:4a0a:b0:487:1084:10f7 with SMTP id
 ffacd0b85a97d-488716a5f1amr3158902f8f.28.1790246007990; Thu, 24 Sep 2026
 03:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-b4-gpu_info_intobytes-v1-1-bb2173f91e11@collabora.com>
In-Reply-To: <20260923-b4-gpu_info_intobytes-v1-1-bb2173f91e11@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 24 Sep 2026 12:33:15 +0200
X-Gm-Features: AclHuK804AwDAE6HGEoAUsZfzHXQ3A-22uNDOLxivpJVZwrsF_RPFfFu1xUpH0s
Message-ID: <CAH5fLgg9xCmiN=MdNpxCLOO5zByVxrPNxhqCeiEQNpb-U2AooQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: safely write GpuInfo to userspace
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Thu, Sep 24, 2026 at 2:21=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Tyr creates the struct drm_panthor_gpu_info from the Panthor UAPI
> bindings. It initializes this struct by querying the gpu and then writes
> the struct into userspace memory faithfully byte-by-byte.
>
> Currently, the struct drm_panthor_gpu_info does not have any implicit
> padding, but if implicit padding were added in the future Rust does not
> guarantee that it would be initialized. Then when Tyr writes the struct
> back to userspace it could expose uninitialized kernel memory.
>
> Tyr implements the unsafe trait AsBytes for GpuInfo whereby the developer
> guarantees that struct drm_panthor_gpu_info does not include implicit
> padding, pointers, or interior mutability. This allows Tyr to safely copy
> the struct into userspace memory. However, relying on the unsafe trait
> AsBytes is fragile because if the Panthor UAPI changes, the SAFETY
> guarantees may no longer be accurate.
>
> Instead, use the macros provided by the zerocopy crate to safely derive
> the traits IntoBytes and Immutable for struct drm_panthor_gpu_info. This
> will cause a compile error if the Panthor UAPI changes in a way that the
> traits IntoBytes or Immutable can no longer be implemented.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

I checked it myself and per-type declarations are indeed needed. We
can't use most_traits for everything yet.

> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 8402b0c93545..65d913181eec 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -71,3 +71,7 @@
>  # Structs should implement `Zeroable` when all of their fields do.
>  --with-derive-custom-struct .*=3DMaybeZeroable
>  --with-derive-custom-union .*=3DMaybeZeroable
> +
> +# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3DIntoBytes
> +--with-derive-custom-struct '^drm_panthor_gpu_info$'=3DImmutable

For this case, I think we should just do:

--with-derive-custom-struct
'^drm_panthor_gpu_info$'=3Dzerocopy_derive::most_traits

That will automatically give us these two traits.

Alice
