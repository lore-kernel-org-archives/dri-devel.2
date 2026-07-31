Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB8C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC59010F359;
	Fri, 31 Jul 2026 16:52:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="tw0fBVmA";
	dkim-atps=neutral
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B439110F359
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:52:45 +0000 (UTC)
Message-ID: <d42d6ce2-7160-457f-be04-ff84551e9b9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785516763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xWkD4jlIKLHWvPRjV0QmKvuYD4Xxyf9krdRe4eLcDvs=;
 b=tw0fBVmAHcUXZ7EyOQ7pyMrimPCYLOkU5/RHBTtdmkcGGYTVYktilu6Dt4cd95LFOpxMyx
 zi1m2M/5GXO4iE9fdtnAW4EffxYHAUkWE/2Z9itCgIUFo88sErfYnGryS8S87roMxd3eCw
 ls1W3ST343itFRpTm7rbr+AyeKMo51k=
Date: Sat, 1 Aug 2026 00:52:06 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/9] rust: debugfs: add SeqShow trait and seq_file file
 operations
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Wambui Karuga <wambui.karugax@gmail.com>,
 Eric Anholt <eric@anholt.net>, Ben Gamari <bgamari@gmail.com>,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-2-aea19eccb996@linux.dev>
 <amyeMmmfEBpuVclw@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Alvin Sun <alvin.sun@linux.dev>
In-Reply-To: <amyeMmmfEBpuVclw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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


On 7/31/26 21:08, Alice Ryhl wrote:
> On Fri, Jul 31, 2026 at 01:05:40AM +0800, Alvin Sun wrote:
>> +/// Show callback for `SeqShow` types.
>> +///
>> +/// # Safety
>> +///
>> +/// The seq_file core guarantees that `seq` points to a live `seq_file` and that
>> +/// `seq->private` is a valid pointer to a `T` with no outstanding mutable
>> +/// references.
>> +unsafe extern "C" fn seq_file_show<S: SeqShow<T>, T: Sync>(
>> +    seq: *mut bindings::seq_file,
>> +    _: *mut crate::ffi::c_void,
>> +) -> crate::ffi::c_int {
>> +    // SAFETY: `seq->private` is a valid `T` pointer with no outstanding
>> +    // mutable references.
>> +    let data = unsafe { &*((*seq).private.cast::<T>()) };
>> +    // SAFETY: `seq` points to a live `seq_file`.
>> +    let m = unsafe { SeqFile::from_raw(seq) };
>> +    from_result(|| S::show(data, m).map(|()| 0))
>> +}
>> +
>> +/// Renders `data` into a seq_file.
>> +///
>> +/// `data` is the value stashed as the debugfs file's `i_private` at creation
>> +/// time. `show` is invoked on each read to produce the file's contents.
>> +///
>> +/// `open` and `release` are optional lifecycle hooks called during file open
>> +/// and release. They can be used to manage the lifetime of `data` (e.g.,
>> +/// reference counting). Default implementations are no-ops.
>> +pub trait SeqShow<T> {
>> +    /// Writes debugfs output for the file.
>> +    fn show(data: &T, m: &SeqFile) -> Result;
>> +
>> +    /// Called during file open, before `single_open`.
>> +    fn open(_data: &T) -> Result {
>> +        Ok(())
>> +    }
>> +
>> +    /// Called during file release, before `single_release`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `data` must point to valid memory, kept alive by actions taken in
>> +    /// [`Self::open`] (e.g., incrementing a reference count).
>> +    unsafe fn release(_data: NonNull<T>) {}
>> +}
> Hmm. So in a later patch you implement SeqShow in the following manner:
>
>      fn open(dev: &drm::Device<T, drm::Normal>) -> Result {
>          // Hold a device reference so the device is not freed while the file is open.
>          dev.inc_ref();
>          Ok(())
>      }
>
>      unsafe fn release(dev: NonNull<drm::Device<T, drm::Normal>>) {
>          // Drop the reference taken in `open`.
>          // SAFETY: `dev` is valid per this function's safety contract.
>          unsafe { drm::Device::<T>::dec_ref(dev) };
>      }
>
> I don't understand why this increment/decrement pair is necessary.
> Just based on the code, it *looks* like you have them because otherwise
> `show()` might get called with a dangling pointer to the drm device, but
> the inc_ref() in open() ensures it stays alive.
>
> However, earlier in this patch you said:
>
>> The seq_file core guarantees that `seq` points to a live `seq_file` and
>> that `seq->private` is a valid pointer to a `T` with no outstanding
>> mutable references.
> So based on this, you are saying that open()/release() do not need to do
> anything special for the value to stay alive.
>
> These seem contradictory. Could you clarify the situation?

You're right. The `SeqShow` trait documentation was inaccurate -- the
framework does not manage the lifetime of `data`, so `inc_ref`/`dec_ref`
in `DrmSeqShow` is necessary to prevent `show()` from accessing a freed
device.

Will fix the doc in the next revision.

Best regards,
Alvin

>
> Alice
