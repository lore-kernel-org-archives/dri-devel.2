Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C2F88090
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4BF10E816;
	Thu, 16 Apr 2026 07:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="l8e4mmMZ";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A517A10E81B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:07:05 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-43d02fa5860so6862968f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776323224; x=1776928024;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LaOBwnvL+3ZiQiKDgJF56Y+WbgUuOyAOdvpqNZ0KUjw=;
 b=l8e4mmMZ5AlmxlsQx2djcFYksVm3JXd/macMVKZqMdXZk7oR+OXJ18Tt8IGnubNo7Y
 OsLTW5ol4CwtCYsymnbCKmu6bL/1Ng6KzddXsh0TWa9moxifQnEaBpN3EjzyprnO/wut
 3wH+ly4b/vGJu9Nomb6ewCruY7H8q2jail902XGi7V8hdBfQ6v1kUWXqPnbX1tiFGN97
 WP9rSwp7ozliUtzkLbrc4KSQ7m84w+ydDqeWsBc0IeH7ncmoI//gm0ps/sAG1WeHcNb6
 6mi/6u5kN+h0DsgB8eUvYnM/b3BeACqGHKQTbJcXUa5qjSWfaSEqrr/VJFyY0jJdZJvM
 Pmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323224; x=1776928024;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaOBwnvL+3ZiQiKDgJF56Y+WbgUuOyAOdvpqNZ0KUjw=;
 b=ZNt9mMW5WQw5LBlmQZfARfxTvgpeXMLfW4XbmcfvkBwwKSrJsmqsJU82v/V7vp/OIS
 yHPdGQm41dWj6j/c+7c9H5w2yAdwFD6UWVxgY98rU+upSXSgRSKKnGfCl5KEoyxvNM05
 +YS12L2CdfeMpmJPEnFnNq0PeJPeIQ7ZFpnSDA+o1OorYszNMRhxU/xEIA+vjcBJMuxU
 88Vnp0oOewpyww89GpqHv4JlKPUY3qJmWY3D8cozVpKztCpauqczEe+fmT0PWlTPsUYt
 J76LQXcm+nHt68Ay0Asymb4i6HKGY1794+YCdBr/VQyT47hKPkQRZL4I7NsU1YrGeh3D
 5JGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87U/vGtiwCFjC/xjCngl6cxwnBij3hRv65iKtRShwatbIi8BFsnfyDwh4rcfF2dPKBpCKZ/bBYgNI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyw3qbqfOxPowz61FfVvMgup2WPGta7QkakBF5ZkRhG53sedHuS
 VweOH13khMKb1EE34kpL0+a7qa6/Cy+7mJvqPqK/+K+V/ZXwmNz81bXQIbYUfruvwbd2vZDOZjR
 s8JF/GbVlx5ovRBX0+w==
X-Received: from wrbdl17.prod.google.com ([2002:a05:6000:b91:b0:43d:505:35b0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2888:b0:43d:73d4:b27 with SMTP id
 ffacd0b85a97d-43d73d40fb6mr24546466f8f.32.1776323223526; 
 Thu, 16 Apr 2026 00:07:03 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:07:02 +0000
In-Reply-To: <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
Mime-Version: 1.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-1-450723cb3727@garyguo.net>
Message-ID: <aeCKlut-88SbNsyW@google.com>
Subject: Re: [PATCH 1/5] rust: ptr: add panicking index projection variant
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 15, 2026 at 08:57:12PM +0100, Gary Guo wrote:
> There have been a few cases where the programmer knows that the indices are
> in bounds but compiler cannot deduce that. This is also
> compiler-version-dependent, so using build indexing here can be
> problematic. On the other hand, it is also not ideal to use the fallible
> variant, as it adds error handling path that is never hit.
> 
> Add a new panicking index projection for this scenario. Like all panicking
> operations, this should be used carefully only in cases where the user
> knows the index is going to be in bounds, and panicking would indicate
> something is catastrophically wrong.
> 
> To signify this, require users to explicitly denote the type of index being
> used. The existing two types of index projections also gain the keyworded
> version, which will be the recommended way going forward.
> 
> The keyworded syntax also paves the way of perhaps adding more flavors in
> the future, e.g. `unsafe` index projection. However, unless the code is
> extremely performance sensitive and bounds checking cannot be tolerated,
> panicking variant is safer and should be preferred, so it will be left to
> future when demand arises.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

>      /// Returns an index-projected pointer; fail the build if it cannot be proved to be in bounds.
>      #[inline(always)]
> -    fn index(self, slice: *mut T) -> *mut Self::Output {
> +    fn build_index(self, slice: *mut T) -> *mut Self::Output {
>          Self::get(self, slice).unwrap_or_else(|| build_error!())
>      }

This is pre-existing issue but IMO this should use match instead of
unwrap_or_else() to avoid potential inlining issues.

> @@ -208,9 +251,12 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
>  /// `kernel::ptr::project!(mut ptr, projection)`. By default, a const pointer is created.
>  ///
>  /// `ptr::project!` macro can perform both fallible indexing and build-time checked indexing.
> -/// `[index]` form performs build-time bounds checking; if compiler fails to prove `[index]` is in
> -/// bounds, compilation will fail. `[index]?` can be used to perform runtime bounds checking;
> -/// `OutOfBound` error is raised via `?` if the index is out of bounds.
> +/// The syntax is of form `[<flavor> index]` where `flavor` indicates the way of handling index
> +/// out-of-bound errors.

Missing colon.

Alice
