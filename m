Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DEBC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D548D10E227;
	Fri, 31 Jul 2026 13:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="q0Cvs1nb";
	dkim-atps=neutral
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927F510E227
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 13:08:05 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f726186c4so797950f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785503284; x=1786108084;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vKUpFb/0BO0No/UvKwO/5M2fcWH3/wzCNVF4fPxlP2k=;
 b=q0Cvs1nbxvAHiOB006UBvYHMn2k9dkD49Jd+WRl0xQQaaKp9/2w10UR1PvofciVMJk
 OzFCgZTkfhJZv9d+KmyBrhRsKMOMeq2i8yQHQm0X6ukVlsQhiENVsQSarIXEliI2aP+V
 kuydJInNLRCCyWyvRku/zEaxCJbvt7eUuW36l1+2yP4Dsnm/gG9U6fddUxn22sH5OGJm
 PXchTeOlYbmCFw4/pBW6eXDyFYRv40kdZ7DO2b3Ez0uH1z8Tu1XZOfvl3afKm39TvL34
 qHLMBZ2PAvVscfKMlFd25lDIyQGM8BbdNUaos6I7I0qPbk7c1CFAE2OMZPtqddPOgBmm
 UeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785503284; x=1786108084;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vKUpFb/0BO0No/UvKwO/5M2fcWH3/wzCNVF4fPxlP2k=;
 b=VqSXABN4Ut2bM7WMQlwRcW2rCrpJ3YNd2fH/zi3apkb8faUJlQ9EsZOB5eBN+zJXbo
 DjN/h2Arwnro6qrGMwVwY6UaLa+U7oNy5dxnUAlUUodLjLSkxGvxq5ZGWls0jqYFSB95
 yjGetbUwqO/h1rGHk9SpDvJ/bs4vdBj62vgop9HwEQ0usANYozZQ8mSPzsirErq6HIu5
 0k7X+eBaeD/YTxpnzo7vu2e7J+tmfN/rIVD8moBHM1fL5ZhVu3+a+071PrC3n4FAohZb
 N/gMoQI6kvXI5SMQjoeZoqwekRCm7zGTcYi6kVyXSFPkeV3RqDF+QWtzyY5u4k5ZVFik
 rwhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbVxzvyMtLZ07s8i1daFlKH6OQ9OU7QUkjdbWhSXCpB/AXK9XHhmLubE4yGdABjVrr4JXS63W4iB0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzqn7MhujVf4MeS+ngmAA/4OWch49Py4bytVrS40SUv7y7+OtyG
 r2bov6rqfSpYBjTUtB00W3PYDbSxLmy+Flq05Vklidin3wh56rCjUcZthic/UmSftAhVzK+PbKj
 9KTbCze8v4vr4Gyjutw==
X-Received: from wrui12.prod.google.com ([2002:a5d:630c:0:b0:47f:4f56:2046])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2882:b0:472:3090:d878 with SMTP id
 ffacd0b85a97d-47fd2ab92c4mr4245682f8f.4.1785503283539; 
 Fri, 31 Jul 2026 06:08:03 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:08:02 +0000
In-Reply-To: <20260731-tyr-debugfs-v2-v2-2-aea19eccb996@linux.dev>
Mime-Version: 1.0
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-2-aea19eccb996@linux.dev>
Message-ID: <amyeMmmfEBpuVclw@google.com>
Subject: Re: [PATCH v2 2/9] rust: debugfs: add SeqShow trait and seq_file file
 operations
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

On Fri, Jul 31, 2026 at 01:05:40AM +0800, Alvin Sun wrote:
> +/// Show callback for `SeqShow` types.
> +///
> +/// # Safety
> +///
> +/// The seq_file core guarantees that `seq` points to a live `seq_file` and that
> +/// `seq->private` is a valid pointer to a `T` with no outstanding mutable
> +/// references.
> +unsafe extern "C" fn seq_file_show<S: SeqShow<T>, T: Sync>(
> +    seq: *mut bindings::seq_file,
> +    _: *mut crate::ffi::c_void,
> +) -> crate::ffi::c_int {
> +    // SAFETY: `seq->private` is a valid `T` pointer with no outstanding
> +    // mutable references.
> +    let data = unsafe { &*((*seq).private.cast::<T>()) };
> +    // SAFETY: `seq` points to a live `seq_file`.
> +    let m = unsafe { SeqFile::from_raw(seq) };
> +    from_result(|| S::show(data, m).map(|()| 0))
> +}
> +

> +/// Renders `data` into a seq_file.
> +///
> +/// `data` is the value stashed as the debugfs file's `i_private` at creation
> +/// time. `show` is invoked on each read to produce the file's contents.
> +///
> +/// `open` and `release` are optional lifecycle hooks called during file open
> +/// and release. They can be used to manage the lifetime of `data` (e.g.,
> +/// reference counting). Default implementations are no-ops.
> +pub trait SeqShow<T> {
> +    /// Writes debugfs output for the file.
> +    fn show(data: &T, m: &SeqFile) -> Result;
> +
> +    /// Called during file open, before `single_open`.
> +    fn open(_data: &T) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Called during file release, before `single_release`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `data` must point to valid memory, kept alive by actions taken in
> +    /// [`Self::open`] (e.g., incrementing a reference count).
> +    unsafe fn release(_data: NonNull<T>) {}
> +}

Hmm. So in a later patch you implement SeqShow in the following manner:

    fn open(dev: &drm::Device<T, drm::Normal>) -> Result {
        // Hold a device reference so the device is not freed while the file is open.
        dev.inc_ref();
        Ok(())
    }

    unsafe fn release(dev: NonNull<drm::Device<T, drm::Normal>>) {
        // Drop the reference taken in `open`.
        // SAFETY: `dev` is valid per this function's safety contract.
        unsafe { drm::Device::<T>::dec_ref(dev) };
    }

I don't understand why this increment/decrement pair is necessary.
Just based on the code, it *looks* like you have them because otherwise
`show()` might get called with a dangling pointer to the drm device, but
the inc_ref() in open() ensures it stays alive.

However, earlier in this patch you said:

> The seq_file core guarantees that `seq` points to a live `seq_file` and
> that `seq->private` is a valid pointer to a `T` with no outstanding
> mutable references.

So based on this, you are saying that open()/release() do not need to do
anything special for the value to stay alive.

These seem contradictory. Could you clarify the situation?

Alice
