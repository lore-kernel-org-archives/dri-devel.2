Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E7FFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C05810E10E;
	Tue,  5 May 2026 10:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="i9tLm2KI";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478C510E11C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:54:08 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-44a122a5128so3062650f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777978447; x=1778583247;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=h801/7LXCD9kwNe9ms/6qfnOisrQsjId3Qwf+1jqbR4=;
 b=i9tLm2KIOpV7gVNxee9Oz1l4uCTkGiC6OLD1GKUdHNKM0RuD76uHRIT8L7rMjQk9vN
 szYaWpcZ/PjnN+Zjo7PGA40nLLytWC6P7xuEvaRDh2nONmNYscGFeyWmRaS09BzwwaEw
 bYf5WHtX1vy5KDLXmEc7FeqMZy7NjtnvprcSj3jI9EuXTMgfEfOwzlos6tLplkZJZbS2
 AeSyhxCWjRexAB2hy1+PU+VTCtPbovbUc4/eo4rNP4VH/eDi2nhh6ieA0I2CQmwQe+xi
 QvGCxSdpIlWbVtpzkYlXos2OUsxaIgbuOtQSVsXItNGgCMr+/JMhpxgxzCw7tVQO1gNm
 LIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978447; x=1778583247;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h801/7LXCD9kwNe9ms/6qfnOisrQsjId3Qwf+1jqbR4=;
 b=AWwU9DruIYIn3IlVwX9gQa5deINTJkgEk+UV2/yPe0vwbVKAOD2kPcmplb8glk0DCn
 cQlVyX9VulXHbx0/ugYFNp6Q6Xz9my28wpMa7uqRDmQrzThbG6dLrVhLZQJxtwqtCXN2
 zOez8sXOa+Yztn8vsZ7IjI/yO1n4nGapNuuq9KtKYCzAOlPiH8hITqYLNoqGQej666DC
 0pjTARu1FLeTaX8q9ce6IMC2Z0nq2egYWouPTtn64cdPhG8u25AzC6zpnwisYmXB1lkS
 dX8CHo8rLo6FG8BS4qz09bjFlGRnHpQ9CTlB8rQm5ZNox8T0Kbisfnp7Nr+90Ez/yrGY
 igDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Uqks83bCB8ogdpbMvBsecXBjnFYaNx4NwRIszO/NoQXTSrtS09fEsW/f3SHBMcL7PATPMJDpDEnY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBfTp2xcQSr9M5kRTXW2Xwcz/fINzvzFkgjFCWLWb9c+aahi0D
 8FjKpZ1NR6vbs5zx7cKjuGKq+d+9uLfaVsRhvLNF0YNWBoM73AtU25FsIN2ihxToTV9nDXsrl1/
 sD7TevVXRlfLa5Xi2DA==
X-Received: from wrbdx9.prod.google.com ([2002:a05:6000:e09:b0:44d:9f32:eb86])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f55:0:b0:44a:1d55:1e20 with SMTP id
 ffacd0b85a97d-44bb2d37c7cmr23705090f8f.5.1777978446484; 
 Tue, 05 May 2026 03:54:06 -0700 (PDT)
Date: Tue, 5 May 2026 10:54:05 +0000
In-Reply-To: <20260505092304.108262-2-laura.nao@collabora.com>
Mime-Version: 1.0
References: <20260505092304.108262-1-laura.nao@collabora.com>
 <20260505092304.108262-2-laura.nao@collabora.com>
Message-ID: <afnMTfVfGq_iLXov@google.com>
Subject: Re: [PATCH v2 1/1] rust: drm: add RENDER_CAPABILITY flag for render
 node support
From: Alice Ryhl <aliceryhl@google.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, kernel@collabora.com, 
 Daniel Almeida <daniel.almeida@collabora.com>
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

On Tue, May 05, 2026 at 11:23:04AM +0200, Laura Nao wrote:
> Add RENDER_CAPABILITY bool constant to the Driver trait to control
> render node support. When enabled, the driver exposes /dev/dri/renderDXX
> render nodes to userspace. The flag defaults to false, drivers can opt
> in by setting it to true in their Driver implementation.
> 
> This is then enabled in the Tyr driver, while it's left disabled for
> Nova for the time being.
> 
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Overall looks good to me!

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  drivers/gpu/drm/tyr/driver.rs |  1 +
>  rust/kernel/drm/device.rs     | 12 +++++++++++-
>  rust/kernel/drm/driver.rs     |  5 +++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index e20a5978eed6..b7ae37ce3a1b 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -186,6 +186,7 @@ impl drm::Driver for TyrDrmDriver {
>      type Object = drm::gem::shmem::Object<BoData>;
>  
>      const INFO: drm::DriverInfo = INFO;
> +    const RENDER_CAPABILITY: bool = true;
>  
>      kernel::declare_drm_ioctls! {
>          (PANTHOR_DEV_QUERY, drm_panthor_dev_query, ioctl::RENDER_ALLOW, TyrDrmFileData::dev_query),
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index adbafe8db54d..e121303d88f0 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -80,6 +80,16 @@ pub struct Device<T: drm::Driver> {
>  }
>  
>  impl<T: drm::Driver> Device<T> {
> +    const fn compute_features() -> u32 {
> +        let mut features = drm::driver::FEAT_GEM;
> +
> +        if T::RENDER_CAPABILITY {
> +            features |= drm::driver::FEAT_RENDER;
> +        }
> +
> +        features
> +    }
> +
>      const VTABLE: bindings::drm_driver = drm_legacy_fields! {
>          load: None,
>          open: Some(drm::File::<T::File>::open_callback),
> @@ -105,7 +115,7 @@ impl<T: drm::Driver> Device<T> {
>          name: crate::str::as_char_ptr_in_const_context(T::INFO.name).cast_mut(),
>          desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc).cast_mut(),
>  
> -        driver_features: drm::driver::FEAT_GEM,
> +        driver_features: Self::compute_features(),
>          ioctls: T::IOCTLS.as_ptr(),
>          num_ioctls: T::IOCTLS.len() as i32,
>          fops: &Self::GEM_FOPS,
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 5233bdebc9fc..92cbc26ce11f 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -16,6 +16,8 @@
>  
>  /// Driver use the GEM memory manager. This should be set for all modern drivers.
>  pub(crate) const FEAT_GEM: u32 = bindings::drm_driver_feature_DRIVER_GEM;
> +/// Driver supports render nodes, i.e.: /dev/dri/renderDXX devices.
> +pub(crate) const FEAT_RENDER: u32 = bindings::drm_driver_feature_DRIVER_RENDER;
>  
>  /// Information data for a DRM Driver.
>  pub struct DriverInfo {
> @@ -115,6 +117,9 @@ pub trait Driver {
>  
>      /// IOCTL list. See `kernel::drm::ioctl::declare_drm_ioctls!{}`.
>      const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor];
> +
> +    /// Sets the `DRIVER_RENDER` feature for this driver.
> +    const RENDER_CAPABILITY: bool = false;

I think it would be nice for this documentation to elaborate more on
what this feature actually does. After all, it clearly took us a while
to understand it, so probably others are confused too.

Something along these lines:

/// Sets the `DRIVER_RENDER` feature for this driver.
/// 
/// When enabled, the driver exposes `/dev/dri/renderDXX` render nodes to
/// userspace. The render node is an alternate low-priviledge way to access
/// the driver, which is enforced on a per-ioctl level. Userspace processes
/// that open the render node can only invoke ioctls explicitly listed as
/// usable from the render node, whereas userspace processes using the
/// master node can invoke any ioctl.
const RENDER_CAPABILITY: bool = false;

Also, I'd probably call this const `FEAT_RENDER` for consistency / to
make it show up in grep.

Alice

