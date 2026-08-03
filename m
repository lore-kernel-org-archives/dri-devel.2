Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB34C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28D5810E711;
	Mon,  3 Aug 2026 15:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JDK1fEpj";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067EC10E711
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 15:06:10 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1783122f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 08:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785769568; cv=none;
 d=google.com; s=arc-20260327;
 b=psskZ+fp8cNAwRwRC1tTsHIk+HSXPBQTC4QQQpmURUOuzYEqHSqXaDLoJz22lTaBNB
 VhuU5wRM+VSI3UiGVrFIGHBU/DxyyHrDYMaq1Ui2bpAZRaoOzfaZ0q1LRcXUFGgsGHrU
 jP6sfGutuN50dgnS+H7RsJFj4/ZFDfxBaWDfxFsib4qIQFOv9lAeRfba/xjSjs5z6rZs
 KakbzwC8DiLvV/YxcOHdMKdLM8eNTHSWl89hJIUEgzuhM1jsgL65TK467BumKZBmrt25
 WUiks4cmGXWzE+q73DSog5hmLJP+MZ9E6kDI3HWFfbGta4DBS4et4eGlEj0I3XUef6i8
 LiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Q8NiBv1owB+m2z5E0qzw1M2JQ8N4hGqbVT+Vkq10LI=;
 fh=Fsjpfb6Zm79DhYN57JYk/j8Dc9on6vxiWm5IIBxo1Z8=;
 b=YnFT34+lz68hWihPg9X7Pdt94s3ZC53gFrQ0MHCbrudECGmJuXRMysePgFjHr6JiH6
 vkXUwa/exbpGXi0R32onlrkTI7BcRcY7KXNEeCbJUUOls+i9RZEP1A8wXqg+AEsObGj1
 fDTw6VYO1sK76/1GNF2LdFtV/FIONytJI6WzRLrGCXQUvXV8oLVVmwkjwcIHOhcqBuoQ
 NQLj0TIFcijcP5APLK1GbXf4zPo4tyX/69bl6GCu7ntIrhvygXAi0QbOtYfOUPgPLeE9
 64mPv29lCYBEI1DtfhoqZ2UnKCJBFAtgBb7Gyo8+PRZh4Nq0kIOj9kjWF+54nBc2cVMq
 8GLQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785769568; x=1786374368;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Q8NiBv1owB+m2z5E0qzw1M2JQ8N4hGqbVT+Vkq10LI=;
 b=JDK1fEpj6cvIWMaNRc47loC9r6W5bUmeDxHfJ6001gkG4O5Tom+FQgQBFdMi27t+yj
 PlAUkz2a4pUQGHRI6RBtaatMUxbID4ZunOSOzr+Jwks2DzX4FnXBENQpWEb5KK3NIecr
 4yySAdGGTH6lSPKqqIoPHuTj1pH+BSaMJz1pyu++VGO9AwLOYhbLvppx4sAFCZ0qZi5N
 S485JJlwrqC80PbPvBdPwtABTTqpgA9qE0k4XavcNAgZ3k7DMFyH/9XVOSkEbK8OkIaC
 j9Ng0gWNuY4DAGe2OT7P06GpfbcrB3D/+4Ha8Ky2mexCIpgKd7i73XTdPt6k6ftfFMJr
 VQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785769568; x=1786374368;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Q8NiBv1owB+m2z5E0qzw1M2JQ8N4hGqbVT+Vkq10LI=;
 b=c328nfunQ6cfersxyYnQOqLNSD72mU/oVUOF4csq5ikW9xATlY0GgfvP8nyJ7Icx+L
 77TojeA1jk23pihz0RNIRakT3TPsboEhwFFjnmEQwnJlvHvK2WmyEpwDubdiAw94Saz/
 pw5pXC5jYHHnmtjKCK1GbKcHhrZ2hvKAdEyfsKx8HTUCjWMWLwKC+HYJUgnee939KUmz
 Xvj8UvPtrvwSyClFlWMa1mS/UX+SXjjObmm6IHlU000Qh2tTOesJF4ANRrLCAo7S2sC1
 CSUugeipCNBSmcd0RXmYFJKXKNhe230FHUzF/llnqsrCyYC8KAr2w9qshtU3LfSWaQJ8
 Q3Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRiG6f0OK4VW6vgvZx0CIeu2xRLkhKWz+6iYzjmppo0UnUSH/yZaQVAemcYUdqXj+7Lwka9NJf2ws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6RnIAtay0n63W6kBC942Ji0t4Vvq5gLjSYiBuSS87R3O8mG2t
 kx+j638B8Y+vLRl9VnTbBX82Sl9rjtMTtv/tIFUKc2g9+qS1OaEwWHNZgButWrR1hW3N2PNyZ1D
 qqzHVL6f8iq5Xt9aWQZmf2Od7xsyGm2Ld8JdqSdr9
X-Gm-Gg: AR+sD10+abAbn/n6EO5vg10jiN13yqUKUdv7Xog42Xxr/qzS/fPQaYJZlQvWSJomlB7
 WQ/Lmkj7lqDixA7JkrzN7WmGdtYpH+zXF+vd5E+bCrXoF1bcx8WKEKXUGZIUWaWCR9+MnLeGNWd
 CwaB5LlnugBrzO3O/WeY4ylG4FH7esSaqUoSA69bdtcxYohvDPw4H35ONgrZL9PTu1pGZqgno6+
 ychxst2fGnGI7/t3fWhn+cdP3v9ZrnEz3dQdGqGTUCjwqNhga4cv5qkG5tsHv+fnDnBjZEArbyM
 gJhykv7KHhcpUvpYkBwJ4CBVRio+eTfPzq+YH5phMW/aHfNUJGBSGWncwOR8MYYavYm3zyDxoXg
 =
X-Received: by 2002:a05:6000:4615:b0:47f:8887:3b07 with SMTP id
 ffacd0b85a97d-47fd72d320amr27491657f8f.13.1785769567433; Mon, 03 Aug 2026
 08:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-tyr-debugfs-v2-v2-0-aea19eccb996@linux.dev>
 <20260731-tyr-debugfs-v2-v2-2-aea19eccb996@linux.dev>
 <amyeMmmfEBpuVclw@google.com>
 <d42d6ce2-7160-457f-be04-ff84551e9b9a@linux.dev>
In-Reply-To: <d42d6ce2-7160-457f-be04-ff84551e9b9a@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Aug 2026 17:05:55 +0200
X-Gm-Features: AUfX_mwlQH6Z-tduzlfCZ86MznBGj1HOcIQs7EHUIsZkQr1iKQzeu-QfbRXr-F4
Message-ID: <CAH5fLgh9oZ9jRATbLM+s+tNR_KjJvdYuJ4w_vxXKwCmRd28E5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] rust: debugfs: add SeqShow trait and seq_file file
 operations
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Wambui Karuga <wambui.karugax@gmail.com>, 
 Eric Anholt <eric@anholt.net>, Ben Gamari <bgamari@gmail.com>,
 rust-for-linux@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Fri, Jul 31, 2026 at 6:52=E2=80=AFPM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
>
> On 7/31/26 21:08, Alice Ryhl wrote:
> > On Fri, Jul 31, 2026 at 01:05:40AM +0800, Alvin Sun wrote:
> >> +/// Show callback for `SeqShow` types.
> >> +///
> >> +/// # Safety
> >> +///
> >> +/// The seq_file core guarantees that `seq` points to a live `seq_fil=
e` and that
> >> +/// `seq->private` is a valid pointer to a `T` with no outstanding mu=
table
> >> +/// references.
> >> +unsafe extern "C" fn seq_file_show<S: SeqShow<T>, T: Sync>(
> >> +    seq: *mut bindings::seq_file,
> >> +    _: *mut crate::ffi::c_void,
> >> +) -> crate::ffi::c_int {
> >> +    // SAFETY: `seq->private` is a valid `T` pointer with no outstand=
ing
> >> +    // mutable references.
> >> +    let data =3D unsafe { &*((*seq).private.cast::<T>()) };
> >> +    // SAFETY: `seq` points to a live `seq_file`.
> >> +    let m =3D unsafe { SeqFile::from_raw(seq) };
> >> +    from_result(|| S::show(data, m).map(|()| 0))
> >> +}
> >> +
> >> +/// Renders `data` into a seq_file.
> >> +///
> >> +/// `data` is the value stashed as the debugfs file's `i_private` at =
creation
> >> +/// time. `show` is invoked on each read to produce the file's conten=
ts.
> >> +///
> >> +/// `open` and `release` are optional lifecycle hooks called during f=
ile open
> >> +/// and release. They can be used to manage the lifetime of `data` (e=
.g.,
> >> +/// reference counting). Default implementations are no-ops.
> >> +pub trait SeqShow<T> {
> >> +    /// Writes debugfs output for the file.
> >> +    fn show(data: &T, m: &SeqFile) -> Result;
> >> +
> >> +    /// Called during file open, before `single_open`.
> >> +    fn open(_data: &T) -> Result {
> >> +        Ok(())
> >> +    }
> >> +
> >> +    /// Called during file release, before `single_release`.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// `data` must point to valid memory, kept alive by actions take=
n in
> >> +    /// [`Self::open`] (e.g., incrementing a reference count).
> >> +    unsafe fn release(_data: NonNull<T>) {}
> >> +}
> > Hmm. So in a later patch you implement SeqShow in the following manner:
> >
> >      fn open(dev: &drm::Device<T, drm::Normal>) -> Result {
> >          // Hold a device reference so the device is not freed while th=
e file is open.
> >          dev.inc_ref();
> >          Ok(())
> >      }
> >
> >      unsafe fn release(dev: NonNull<drm::Device<T, drm::Normal>>) {
> >          // Drop the reference taken in `open`.
> >          // SAFETY: `dev` is valid per this function's safety contract.
> >          unsafe { drm::Device::<T>::dec_ref(dev) };
> >      }
> >
> > I don't understand why this increment/decrement pair is necessary.
> > Just based on the code, it *looks* like you have them because otherwise
> > `show()` might get called with a dangling pointer to the drm device, bu=
t
> > the inc_ref() in open() ensures it stays alive.
> >
> > However, earlier in this patch you said:
> >
> >> The seq_file core guarantees that `seq` points to a live `seq_file` an=
d
> >> that `seq->private` is a valid pointer to a `T` with no outstanding
> >> mutable references.
> > So based on this, you are saying that open()/release() do not need to d=
o
> > anything special for the value to stay alive.
> >
> > These seem contradictory. Could you clarify the situation?
>
> You're right. The `SeqShow` trait documentation was inaccurate -- the
> framework does not manage the lifetime of `data`, so `inc_ref`/`dec_ref`
> in `DrmSeqShow` is necessary to prevent `show()` from accessing a freed
> device.
>
> Will fix the doc in the next revision.

I'm not convinced that works soundness-wise. If I just leave
open/release empty, then I will be able to access a &T inside of
show(), but there's nothing keeping it alive, so I could dereference a
freed &T in safe code that way.

I think we need the seq file to instead own some sort of value. Then,
show() can be passed the a reference to value it has ownership of, and
release() can be said type's destructor.

Alice
