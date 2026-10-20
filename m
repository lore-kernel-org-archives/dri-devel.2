Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468E606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=uqUE+pgo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D7910E9EF;
	Tue, 20 Oct 2026 08:34:04 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D7C10E9EF
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:33:57 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so19560535e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792485235; x=1793090035;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iTKxLK7MUSiAzkn1IgcQvxPJWtCNPLN0//THVXyyz5c=;
 b=uqUE+pgoGy330xOUBazLT+meumeauo6M44cxCQQrkAOp7ufNPYyhsJEScXg5yvTxip
 SN3qr9527UR5dCsYQtoARxxZXiDg7Hp0frHBPCBgb95ME9ZiAeHpHTdsrYiWYYi+H9Eh
 29p+ulH2twmXo1wr6FMi/6/IlHqLqE0RZd0PmBJSRAwerCqoNTDcrHq2RBjQAOVinMkq
 bEAjGepOj9Ty09bNeTEpd5BZxB/v5xgI7JNkwhDPuWxqAl8cwNNMH6H6IUn49CFlhyW3
 684E21FDkjJNZZU4/gY/b+V+wDyNkBRWe+oO4iOJ2UV3mjO9v6DjgE9dI6AXBAM7PKzw
 izHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792485235; x=1793090035;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iTKxLK7MUSiAzkn1IgcQvxPJWtCNPLN0//THVXyyz5c=;
 b=spENdqaRjxvKpFsG7DcTP6XPGDF/OTvNl9frNk3cwnnWIS1ntwriMA50inWO/7G6aW
 eXPRmXwvim1BwpK5LME4OVyNcuZcU3lWaTOpBE9XtAza/dHUVxIYgm3XAM6eB+qovoRI
 JvVcdixNI7SQWlUG5zIzOz5ghICpWMnYWE76+UfzccJXZhIl2rRIcznn4x+uE4PQ7amC
 RhctR0AUA7aUQMce9rordArkYDkoHToKQY+BgUnEnXcAn1v4z2W/PL2qhXHg0hLKbqHT
 5H6NUfuT03rHriGHXrSZV+CBP+QidSDMoloV2Y8ehf8XYYErJpD6lS1ZQRgB3HrZN746
 2SnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQx6b+gbjT43YNdpihKQOsQ3Ucz6ugWMYE1rjhO0d2kSGCOkEtDHw/i5UFu9oJgyE8nKriWJNW3kA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIM+/JRv2HmlrdD/Ib2J2tHZh44FD84AiW2ta5Yc/BK7GpOFhKa
 JuyCaB46Y5ar79s8QyljVSXUITOXpy26dz5S/hl/kPJhZIOSAuflw352+dcl8D4Fovo4HXrJeXi
 9yuFRcINn03Q+egXlTg==
X-Received: from wmbb17.prod.google.com ([2002:a05:600c:5891:b0:4a1:e474:4216])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e11:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a1d75f24b4mr207613465e9.9.1792485235001; 
 Tue, 20 Oct 2026 01:33:55 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:33:53 +0000
In-Reply-To: <atarvxFKYYuHhXGQ@um790>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261016-b4-dev_query_fixes-v3-0-f8071cda3515@collabora.com>
 <20261016-b4-dev_query_fixes-v3-2-f8071cda3515@collabora.com>
 <atXOd-EeFkdA-trn@google.com> <atarvxFKYYuHhXGQ@um790>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020083353.1821078-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 2/2] drm/tyr: allow userspace buffers to be mismatched
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 04:46:07PM -0700, Deborah Brouwer wrote:
> On Mon, Oct 19, 2026 at 08:01:59AM +0000, Alice Ryhl wrote:
> > > +    transmute::AsBytes,
> > 
> > Usie the trait from zerocopy instead.
> 
> If this other series making zerocopy available to Tyr gets merged,
> then I could rebase this series on it and switch over to IntoBytes:
> 
> https://lore.kernel.org/rust-for-linux/20261019-b4-gpu_info_intobytes-v4-0-0bc04df46549@collabora.com/T/#m9a9a24e0cf1ae10451e3fc84955873b405d0da0b

Rebasing this series on top of that one makes sense to me (you can also
already send v4 based on it and note the dependency in the cover letter).
Note that set_uobj will need T: IntoBytes + Immutable and can call
writer.write_slice_partial(src_obj.as_bytes(), 0)? unless write_truncated()
is also updated to use zerocopy.

> > > +    let mut writer = UserSlice::new(UserPtr::from_addr(usr_dst as usize), size).writer();
> > 
> > On 32-bit this will truncate upper bits. I guess that probably matches
> > what Panthor does. Is it what we want?
> 
> Yes, that's what Panthor does; it uses the "u64_to_user_ptr()" macro to do
> this deliberately.
> 
> Since UserPtr only accepts a usize argument, I have to cast in Tyr,
> but instead, what do you think if I added another method to UserPtr
> to accept a u64 address and cast it to usize just like in the C macro.
> Something like:
> 
>     /// Create a `UserPtr` from a u64 userspace address.
>     ///
>     /// Deliberately truncate upper bits for 32-bit systems.
>     #[doc(alias = "u64_to_user_ptr")]
>     #[inline]
>     pub fn from_u64(addr: u64) -> Self {
>         Self::from_addr(addr as usize)
>     }

Adding UserPtr::from_u64() like that sounds good to me! That keeps UserSlice
construction infallible (matching u64_to_user_ptr(), including when the slice
length is 0), and we can also use it to replace the existing `as usize` casts
in drivers/android/binder/thread.rs.

Alice
