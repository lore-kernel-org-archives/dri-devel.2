Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38960FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7369F10E43D;
	Thu, 30 Apr 2026 08:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="IvGgb56a";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CF610E43D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:59:47 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-48a7994e8ddso5457325e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777539586; x=1778144386;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0mEMfx8leu6g7NgiHRZ9yJ+jKk4ymcYL2rSstPz5qTo=;
 b=IvGgb56aKZe4+dmdDtWnqZeNu5mO4AmdpaFtYWhQnm3U4YxVNwj+J1ViTyaKvjBLcH
 0yWfURQG6UGcaEXYSY8SUu+O8tVcEQAeqIrBx0dKJxtOFEfi8MQA2C8osORD+chkgFfc
 dEns/ELK27nlkhVRhpnAab14JB2OxpdkS6UHedEOK8T6F46pyhPeOIeEvepllIF/Iejy
 jTkpirdBAeWupC10BT/vaTi3wG1c6yJOC2DJkeY+U6EnJKBxa3NvO36v6OSBh8SyT8On
 4oraAwHJygK1tIFeb+mpgbwlsNmgmQfEM07fjPDCpsRBYInaH5/mfIJVKpppT20KBF/E
 SwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539586; x=1778144386;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0mEMfx8leu6g7NgiHRZ9yJ+jKk4ymcYL2rSstPz5qTo=;
 b=IV74pxTOTqCAemg5m1QOPyMCGNfGDCbzecrRf0eTLNure4fKkohSJ6NHYsp/ysLYAL
 dxx0OnbjtXMrMjzIJLPEe/K4Otr2X47XAlNgklrc4GR7XvFyHJOH387oBRA8skOStEBv
 bjWrWOoh+5gg+/leGtpmxk33LePac34ISkhS6efDeDS1eV7dr2Mx8JenbDXvyyd+D/hJ
 gri91+7etTVZRL0sJl6Zv20JjWTNKx2QgjeXnG1eqVKWpBvuvPRQhnqxHb5fsT8DOC/F
 7bUbEOzFYIeMarfXP/eKmsqn6J/rrWCZmdYQ0KSnshV3PWoalPNO+UvAnoTzp+dz5bjO
 v49Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GFOu2SEJPdd3MXpLzLC22PSHUlZsNFmor6lqohecjb1tLiEkdPJ6QM1K9m5aU89i4PyJFQxKvIyw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo6mOs2Vf7zzYtF74lSKOOV7XdqYItf9dvW0zACwxu+yns+YNa
 GyQHYcIzQjBRFs/gLME53xtTF9UmxlfGFwqc+mFnamw+xatwvmtUXspDQFqQeql7jbEYWxc/J0m
 JJacWqMOvJHWiOapbGA==
X-Received: from wmbb16.prod.google.com ([2002:a05:600c:5890:b0:48a:65a5:c693])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8206:b0:485:17a7:b9c7 with SMTP id
 5b1f17b1804b1-48a83d6c224mr34454735e9.10.1777539585931; 
 Thu, 30 Apr 2026 01:59:45 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:59:45 +0000
In-Reply-To: <20260427221002.2143861-2-dakr@kernel.org>
Mime-Version: 1.0
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org>
Message-ID: <afMaAfcxpDR3xIE1@google.com>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
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

On Tue, Apr 28, 2026 at 12:09:40AM +0200, Danilo Krummrich wrote:
> Add a registration_data pointer to struct auxiliary_device, allowing the
> registering (parent) driver to attach private data to the device at
> registration time and retrieve it later when called back by the
> auxiliary (child) driver.
> 
> By tying the data to the device's registration, Rust drivers can bind
> the lifetime of device resources to it, since the auxiliary bus
> guarantees that the parent driver remains bound while the auxiliary
> device is bound.
> 
> On the Rust side, Registration<T> takes ownership of the data via
> ForeignOwnable. A TypeId is stored alongside the data for runtime type
> checking, making Device::registration_data<T>() a safe method.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

So overall I think this patch makes sense. A few comments below.

> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index bc09b55e3682..4e1ad8ccbcdd 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -62,6 +62,9 @@
>   * @sysfs.irqs: irqs xarray contains irq indices which are used by the device,
>   * @sysfs.lock: Synchronize irq sysfs creation,
>   * @sysfs.irq_dir_exists: whether "irqs" directory exists,
> + * @registration_data_rust: private data owned by the registering (parent)
> + *                          driver; valid for as long as the device is
> + *                          registered with the driver core,
>   *
>   * An auxiliary_device represents a part of its parent device's functionality.
>   * It is given a name that, combined with the registering drivers
> @@ -148,6 +151,7 @@ struct auxiliary_device {
>  		struct mutex lock; /* Synchronize irq sysfs creation */
>  		bool irq_dir_exists;
>  	} sysfs;
> +	void *registration_data_rust;

Is this really Rust-specific? Would you not want C drivers with the same
pattern to do the same thing?

> +        // SAFETY: `ptr` is non-null and was set via `into_foreign()` in `Registration::new()`;
> +        // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0, so reading a `TypeId`
> +        // at the start of the allocation is valid regardless of `T`.
> +        let type_id = unsafe { ptr.cast::<TypeId>().read() };
> +        if type_id != TypeId::of::<T>() {
> +            return Err(EINVAL);
> +        }

Right, okay, so if you put C stuff there, we need the layout to be
compatible with Rust type ids.

Still, we could have Rust expose a couple methods to allow C code to use
the same field with a null type id.

But I guess this is all future work.

> +        let data = KBox::pin_init::<Error>(
> +            try_pin_init!(RegistrationData {
> +                type_id: TypeId::of::<T>(),
> +                data <- data,
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;

Use __GFP_ZERO here instead?

> +        // SAFETY:
> +        // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which
> +        //   has been initialized,
> +        // - `modname.as_char_ptr()` is a NULL terminated string.
> +        let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
> +        if ret != 0 {
> +            // SAFETY: `registration_data` was set above via `into_foreign()`.
> +            let _ = unsafe {
> +                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).registration_data_rust)
> +            };

Nit: Please use `drop(unsafe { ... })` to explicitly drop.

Alice
