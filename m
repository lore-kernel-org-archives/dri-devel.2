Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87458C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EBE10E223;
	Fri, 31 Jul 2026 13:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="RI03w0Yc";
	dkim-atps=neutral
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B38F10E223
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:01:29 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-69fc66f110eso1701732a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785502888; x=1786107688;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FBHJGJamcmVHqk45wC3+3WaZ921glxpmyO6R7cNL6rM=;
 b=RI03w0YcbkhodWf6kg7sEtccN3+HH8190MC+Rkixs/JhphQeIp0udurB5DRWtqq0RZ
 00iTbRPLjAmJetbu/Rcwmi611R4xg2jRD37lsB32tWsThJhghVv8XwFXSE0uRRemxzVR
 5M0GA1GQddvEoSZxqiXFp5ugi44ihRAqP6AkpIGUsu6xTFN5rB7Ec6+fJ9fCWP+gFQCu
 t8gTFutrcDaLNc5H5AWa1lp6JDkQgSuvEOPxHwmSu930t07IKGohukjK93bENUaSDhgd
 0OOie7LDwMrQPXpNqF2+hu39pVJsecHwzKYKJjG1DLjQnxEQHdaKmsry4A96i/yiE7Mx
 VYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502888; x=1786107688;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FBHJGJamcmVHqk45wC3+3WaZ921glxpmyO6R7cNL6rM=;
 b=H8mwRXrp1e5LrNjGQchC2G3+nFa1dS6iG/bwqRcXUxMPSxU8o1EgB80/EvUFrx/PaY
 OqhAjm7jVHOS7UrvPZNTWNdMHu5INmOfhZYPFtesFilBaHO4OlXzmdfYD5rpvp9lGEOv
 4ie5OZu8aMcYUKLQPY7byWR6bFjqln/y8zZXIiFDYxYCwBIH0nNEvusUeDJtYi28gYyq
 2jYuJn3fHmgx9rz21hEtCTaSqRb8dz6WSLyigniYJ2Zf4uUUn/Jq/DZDCwYbzVPRDS+b
 eKay0M8N/kjLswhq0lcPPNoOJHzKEK295wYh1x0HxQTQejNsi/oeO4EYv1tTRXOJ0MvJ
 tU0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMLziHaJd471o2Q+SN0rEen4HjkdfNkHJLfi28D+noy+/NjBlhR5yOEMwxM/xA3xpOgTlftUpWL4A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzyzz+dCft9eRBDXyK+BPd2RbeuhXR4PwNjo/51fB0Sf3L+F9Mo
 KY7NXoTJAn1bUhtmBkJGo2bI3ALDyn5E77iKYMCa1wPKF6yy4TwMLki5pLiC/bLCApb5CXFnXle
 ZNoJTROpAgr99JmvkuQ==
X-Received: from wmbeb18.prod.google.com
 ([2002:a05:600c:6792:b0:495:5dfe:fc5f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d3ce:0:b0:6a0:7a26:fc88 with SMTP id
 4fb4d7f45d1cf-6a09b14436amr755660a12.17.1785502887568; 
 Fri, 31 Jul 2026 06:01:27 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:01:26 +0000
In-Reply-To: <20260731-tyr-debugfs-v2-v2-7-aea19eccb996@linux.dev>
Mime-Version: 1.0
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-7-aea19eccb996@linux.dev>
Message-ID: <amycptp9uZOUjMJ7@google.com>
Subject: Re: [PATCH v2 7/9] rust: drm: gpuvm: add dump_gpuva_info to
 UniqueRefGpuVm
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

On Fri, Jul 31, 2026 at 01:05:45AM +0800, Alvin Sun wrote:
> Add method wrapping drm_debugfs_gpuva_info to dump GPU VA space
> mappings into a seq_file. Needed by the Tyr gpuvas debugfs file.
> 
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/drm/gpuvm/mod.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
> index 20a08b3defeb8..9da88501a4206 100644
> --- a/rust/kernel/drm/gpuvm/mod.rs
> +++ b/rust/kernel/drm/gpuvm/mod.rs
> @@ -312,6 +312,14 @@ pub fn data_ref(&self) -> &T {
>          unsafe { &*self.0.data.get() }
>      }
>  
> +    /// Dumps GPU VA space info into a seq_file.
> +    ///
> +    /// Wraps the C `drm_debugfs_gpuva_info` function.
> +    pub fn dump_gpuva_info(&self, m: &crate::seq_file::SeqFile) -> Result {
> +        // SAFETY: `m.as_raw()` and `self.as_raw()` are valid by the type invariants.
> +        to_result(unsafe { bindings::drm_debugfs_gpuva_info(m.as_raw(), self.as_raw()) })
> +    }

This can be marked inline. Otherwise:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
