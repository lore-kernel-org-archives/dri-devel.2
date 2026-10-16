Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDDCCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4172110E286;
	Fri, 16 Oct 2026 13:55:13 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118FF10E301
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:49 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a01c621dc2so49830435e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158887; x=1792763687;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fRibYQQCC8wRNRgMBFml+aQKdotOmpVfSxBareZMh+o=;
 b=cZ3jNRXmS7Rboou6jeVr4KYVRB1B+HoyuBlD6HVuCoppneivDQF91Sg4dHZZnpm5WC
 vfySd3INOFHnmLIR0OdZZychCTj16TVjKFiXDx/rYEgxC/HVPaRKOXyTaa8BuAJq4XDx
 YcVh4tFXoKi6E096W45iyPU7RDLZ0tKblXg+IstUnGgd6O8HceIYaJe6rFH9dJ6Lol/F
 Qxwwbj6VdVkStKuLnbf4/uWM1yPTdY+82fcNnH+oq9FOx0V1EMjNf4UFE0//2OmOT+NX
 EPkq+cvTCopWshgyujLOiM9kIv9NDdd7QO7eDp/XtoHkmEJJVpqfm7142ZchW0rPXm6F
 igSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158887; x=1792763687;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fRibYQQCC8wRNRgMBFml+aQKdotOmpVfSxBareZMh+o=;
 b=nK9OMSqJ/Ug0uu8VxYr99i88jWth3Zo4nftpcDibTWjaCOR3GR45o49A4fgDlj/8rV
 pfkMdjf3BjEyAUR5UFPT1ha+t+5WMFpKdRPMH/4s/zgQkLdvrAxxJa/yRlblhoY73iwI
 MTQcSyi7FtFo30+56pGvdFKFqQoTq2eWZiO2hExLhqee6ynfMeKyh0f3ABXta3GWOXxE
 jOzb+ZQbzdqJV7HR7l6xZt2I++69A7RlBCe3ZOy4m9xjp5N57KSDcgq41b0h+3ANRxcG
 qFTMgqbypvSLhJ/MjB6TOfmIDNMYGLgQ5mDPzTGMRzH08eInuOKn6lMhXWN0X67jiz7F
 nJeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdWLsDUR0XHVqfs+pB5wSJAatvgZT/e0tvVRKjudGyAKcHP2txgB3B6cfNKfocwHBBvJ3u+xEQjfU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIvuwLaYwT1ovZ7GB/nZQhugLYkpU7wuPWgU2UgFeqeLT/UgbTR
 Zg4TE85sVTmep0JiYvZ86HPcDWgY0S5E4se3ytKDsHN4cAMC29qkLQ7BnoNSHI0tZBpkI80kU6M
 DY7mwDDARfV+W55dOuw==
X-Received: from wmsz15.prod.google.com ([2002:a05:600c:c16f:b0:4a0:2a5:ce1a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0e:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a18e4c3f32mr512182645e9.22.1792158887232; 
 Fri, 16 Oct 2026 06:54:47 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:38 +0000
In-Reply-To: <20260814230923.1292966-7-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-7-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-6-aliceryhl@google.com>
Subject: Re: [PATCH 6/7] rust: drm: make Driver::File lifetime-parameterized
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

On Sat, Aug 15, 2026 at 01:09:04AM +0200, Danilo Krummrich wrote:
> +    /// The type used to represent a DRM File (client).
> +    ///
> +    /// File data may borrow from [`RegistrationData`](Driver::RegistrationData). File data is
> +    /// guaranteed to be dropped before registration data, either when the file is closed or
> +    /// when the device is unregistered, whichever comes first.
> +    ///
> +    /// Drivers set this to `CovariantForLt!(MyFileData)` (or `ForLt!` for invariant types)
> +    /// and implement [`DriverFile`](drm::file::DriverFile) for their file data type.
> +    type File: ForLt + 'static;

This looks like it can be

	type File<'a>;

and if so, then I think it should be.

> @@ -221,6 +237,51 @@ fn drop(&mut self) {
>          unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
>          // After drm_dev_unplug(), the SRCU barrier guarantees that all RegistrationGuard critical
>          // sections have completed, so no one holds a reference to reg_data anymore.
> -        // reg_data is dropped here automatically.
> +
> +        // Drop all remaining file private data before dropping registration data. This guarantees
> +        // that file data (which may borrow from RegistrationData) is always dropped first.
> +        let raw = self.drm.as_raw();
> +
> +        // SAFETY: `filelist_mutex` is initialized by `drm_dev_init()` and remains valid for
> +        // the lifetime of the `struct drm_device`.
> +        let filelist_mutex = unsafe { Mutex::from_raw(&raw mut (*raw).filelist_mutex) };
> +        {
> +            let _guard = filelist_mutex.lock();
> +
> +            // SAFETY: `filelist` is a valid, initialized sentinel `list_head`; the mutex
> +            // guard prevents concurrent modification.
> +            let filelist = unsafe {
> +                clist_create!(
> +                    &raw mut (*raw).filelist,
> +                    drm::File<T>,
> +                    bindings::drm_file,
> +                    lhead
> +                )
> +            };
> +
> +            for file in filelist.iter() {
> +                // SAFETY: `file` is a valid `drm_file` on this device's filelist.
> +                let priv_ptr = unsafe { (*file.as_raw()).driver_priv };
> +
> +                // SAFETY: Setting `driver_priv` to NULL is visible to `postclose_callback()`
> +                // through the `filelist_mutex` acquire/release chain in `drm_close_helper()`.
> +                unsafe { (*file.as_raw()).driver_priv = core::ptr::null_mut() };
> +
> +                // SAFETY: `driver_priv` was created by `open_callback()` via `KBox::into_raw` and
> +                // has not yet been freed (the file is still in the list, so `postclose_callback()`
> +                // has not run).
> +                drop(unsafe { KBox::from_raw(priv_ptr.cast::<<T::File as ForLt>::Of<'static>>()) });
> +
> +                self.drm.open_count.fetch_sub(1, Release);
> +            }
> +        }

Using `drm::File<T>` in `clist_create!` here creates `&drm::File<T>`
references after `drm_dev_unplug()` has completed and while `driver_priv` is
being set to NULL and freed (so calling `file.inner()` inside the loop body
would dereference a null pointer).

Could we pass `Opaque<bindings::drm_file>` to `clist_create!` instead? That
way we never create a `&drm::File<T>` when its `driver_priv` is being torn
down.

Also, this drops files under the mutex. Could/should we avoid that for deadlock
avoidance?

> @@ -27,17 +44,17 @@ pub trait DriverFile {
>  /// `self.0` is a valid instance of a `struct drm_file`.
>  #[repr(transparent)]
> -pub struct File<T: DriverFile>(Opaque<bindings::drm_file>, PhantomData<T>);
> +pub struct File<D: drm::Driver>(Opaque<bindings::drm_file>, PhantomData<D>);
>  
> -impl<T: DriverFile> File<T> {
> +impl<D: drm::Driver> File<D> {
>      #[doc(hidden)]
>      /// Not intended to be called externally, except via declare_drm_ioctls!()
>      ///
>      /// # Safety
>      ///
> -    /// `raw_file` must be a valid pointer to an open `struct drm_file`, opened through `T::open`.
> -    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<T> {
> -        // SAFETY: `raw_file` is valid by the safety requirements of this function.
> +    /// `ptr` must be a valid pointer to an open `struct drm_file`.
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<D> {
> +        // SAFETY: `ptr` is valid by the safety requirements of this function.
>          unsafe { &*ptr.cast() }
>      }
>  
> @@ -45,59 +62,94 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_file {
>          self.0.get()
>      }
>  
> -    fn driver_priv(&self) -> *mut T {
> -        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is always valid.
> -        unsafe { (*self.as_raw()).driver_priv }.cast()
> +    /// Return a pinned reference to the driver file data.
> +    ///
> +    /// Only available when `D::File` implements [`trait@CovariantForLt`]. For invariant types, use
> +    /// [`inner_with()`](Self::inner_with).
> +    pub fn inner(&self) -> Pin<&<D::File as ForLt>::Of<'_>>
> +    where
> +        D::File: CovariantForLt,
> +    {
> +        // SAFETY: `driver_priv` was initialized by `open_callback()`. `CovariantForLt` guarantees
> +        // the lifetime shortening from `'static` to `'_` is sound.
> +        unsafe { Pin::new_unchecked(&*(*self.as_raw()).driver_priv.cast_const().cast()) }
>      }

Relatedly, since an open `struct drm_file` has `driver_priv` set to NULL (and
its `RegistrationData` dropped) after `Registration::drop()` runs, the type
invariants of `File<D>` and the safety requirements of `File::from_raw()`
should also state that:

- the `struct drm_file` was opened on a device of driver `D`, and
- a `RegistrationGuard` is held for the duration of any `&File<D>` reference
  (ensuring that `Registration::drop()` has not cleared `driver_priv` or
  dropped `RegistrationData`).

Alice
