Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A00C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7C410E1F7;
	Fri, 31 Jul 2026 12:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="VUbIQ/Rk";
	dkim-atps=neutral
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB9F10E1F7
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:59:47 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8580ed9eso1136034f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785502786; x=1786107586;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P9eJPXgMx/k8Zzskbe/ENfQg92M9fVEFYQJ0hF5Ni8Q=;
 b=VUbIQ/RkT2QQts3G1Xj6rYwPCubhdZ+xfHO0DLfVFmCb8a5xaz0f+8A8WHNCrBiHRE
 MN0riLcp6RVvJaSzNBpIR/7KU2aj0zNWnj29H79kTpfI2oC01nKalI08/H3DtYInrmCb
 fUAeBcBK0XejtftU1cxcDzZ/Fiue62ycQPws8q/gproj8LmaeVqVQBfOiAk7V3kXIDgk
 xWIjyCs8RLC+pEp0pg6WlNTmUGw6vP7xWwU5XnzVbtqju8FAW33toEyNzKH1S9DOiPpI
 f5YOQ2+hqaGPJCofe+S2m1HufRnXL5BkY6jh+lEmXJHn37RIN+zQL0dfD/6MUilWOkde
 aUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502786; x=1786107586;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P9eJPXgMx/k8Zzskbe/ENfQg92M9fVEFYQJ0hF5Ni8Q=;
 b=sBhoYNLSs/1ryTKisz8lzRXtWsehfcTPSKWfHcrUpcQ+gZElnC7R7n9Nww43yasWOD
 aDZ8qAmK9zvKqUSRCOwMZ4P7hMYkYonApKEpby3Y/u51Fqz5r4TSSDTQ2OVSHmoukvLc
 nVBPB1kMlm36fUGK0IpeVsknzkwyM+e7T9GXbMbne0/YzKQXFR3wpLS0cxgg+gV2TjSk
 oLv2szbiOUIJA4GM+E4R7rTQes3f+pBap2DJ6xNjzngyGkGX2y0bGnlTEILjB5Y8IFs+
 //LnTigfBTRk4n2VupBrigKWc1vHUIdTqJCyLoC/ORRTqI/1Nmc5jwLaobrfS2JW3MYi
 AmXA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roo2QZXDf8huK2UlPV9A9I81JGpQqcVUQI7w/yYirMtORZTjEeqD7k4EJwDVE4by5uLV5DGhm/ECSU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7BLkgEU/kvNVnKoCF0ryxnY9PNigZ9Hu+bAfhF09JVgXrDWWs
 hGViM74lIRc3gX0xjYVWlbuAfExz1IanExZU8KxBRwv7sEXmPUZdgs8AtQZTbeRWxtj0Vu3bBA4
 aBaqVxWxjn8YgcTLzmg==
X-Received: from wmbdr14.prod.google.com
 ([2002:a05:600c:608e:b0:493:af1f:8829])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40cd:b0:47f:6d9a:d7a6 with SMTP id
 ffacd0b85a97d-47fd2aed4ebmr4411247f8f.25.1785502783123; 
 Fri, 31 Jul 2026 05:59:43 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:59:42 +0000
In-Reply-To: <20260731-tyr-debugfs-v2-v2-8-aea19eccb996@linux.dev>
Mime-Version: 1.0
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-8-aea19eccb996@linux.dev>
Message-ID: <amycPnwWUS1qwGs9@google.com>
Subject: Re: [PATCH v2 8/9] drm/tyr: add gpuvas debugfs file
From: Alice Ryhl <aliceryhl@google.com>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
 "=?utf-8?B?TWHDrXJh?= Canal" <mcanal@igalia.com>, Melissa Wen <mwen@igalia.com>,
 Wambui Karuga <wambui.karugax@gmail.com>, Eric Anholt <eric@anholt.net>, 
 Ben Gamari <bgamari@gmail.com>, rust-for-linux@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Fri, Jul 31, 2026 at 01:05:46AM +0800, Alvin Sun wrote:
> Add a gpuvas debugfs file listing all GPU VAs for the Tyr DRM driver.
> Collects VMs into a shared list during firmware init and renders them
> via dump_gpuva_info on read.
> 
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  drivers/gpu/drm/tyr/debugfs.rs | 65 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tyr/driver.rs  | 16 +++++++++++
>  drivers/gpu/drm/tyr/fw.rs      |  8 ++++++
>  drivers/gpu/drm/tyr/tyr.rs     |  1 +
>  drivers/gpu/drm/tyr/vm.rs      |  5 ++++
>  5 files changed, 95 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tyr/debugfs.rs b/drivers/gpu/drm/tyr/debugfs.rs
> new file mode 100644
> index 0000000000000..d381b1901bd08
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/debugfs.rs
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Debugfs support for the Tyr DRM driver.
> +
> +use kernel::{
> +    alloc::KVec,
> +    drm,
> +    new_mutex,
> +    prelude::*,
> +    seq_file,
> +    sync::{
> +        Arc,
> +        Mutex, //
> +    }, //
> +};
> +
> +use crate::{
> +    driver::TyrDrmDriver,
> +    vm::Vm, //
> +};
> +
> +/// Registry of VMs for debugfs access.
> +#[pin_data]
> +pub(crate) struct VmRegistry<'drm> {
> +    #[pin]
> +    vms: Mutex<KVec<Arc<Vm<'drm>>>>,
> +}
> +
> +impl<'drm> VmRegistry<'drm> {
> +    pub(crate) fn new() -> impl PinInit<Self> {
> +        pin_init!(Self { vms <- new_mutex!(KVec::new()) })
> +    }
> +
> +    pub(crate) fn register(&self, vm: Arc<Vm<'drm>>) -> Result {
> +        Ok(self.vms.lock().push(vm, GFP_KERNEL)?)
> +    }
> +
> +    fn for_each(&self, mut f: impl FnMut(&Vm<'drm>) -> Result) -> Result {
> +        for vm in self.vms.lock().iter() {
> +            f(vm)?;
> +        }
> +        Ok(())
> +    }
> +}

This code maintains a separate list of all of the vms for access from
debugfs, but I would have expected that this is not necessary. If we
already store the vms inside the driver's private data, then can't we
just access them from the normal storage location?

By having multiple copies of the same information, you risk that they
get out of sync. In this case, you never remove vms from the list even
if the vm stops being used, which seems wrong.

Alice
