Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5F606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hZYSWg1e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882A310E369;
	Wed, 25 Nov 2026 11:12:40 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0DF10E0EF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:12:34 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4903fc8537aso3746047f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795605152; x=1796209952;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lmO9qlZWx0TKcaEyqSHqDwn9dZMk6HPcgLTZNeLkLbo=;
 b=hZYSWg1e/D6tok3wdhi7hMsUhvxye2iNV3kdsMvOco61AECCzTAXVCuwFW2rnrCk2d
 RDoVNdfpRCCWhqbRannhUgicI3bPjtxm2mL9IuzesgVXEzBbcydbMOhBdlzzfFceKQ/1
 iVrC66+EJ2Kx+IWbhU16CvIPQImFsOouIaRAZ5Syz2T07t9MNFDLDbuiS6ZoHHmEDMDP
 LtIxGiJn8oI6ilsaJqjJ8ckIJQ5qcXieLFgO7dZ2mXpb6EqNVbT/xANKmaaO5ZbnaX9X
 4A266LjNiSP+sjw3I4cvoUiCf98JHkxNQIHWE3zOtzmzCTC5APH2yVsPnCaU35yZa9b3
 Bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605152; x=1796209952;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lmO9qlZWx0TKcaEyqSHqDwn9dZMk6HPcgLTZNeLkLbo=;
 b=C2mSyXcxYqIJ1YFY/txT6AsckQgStaqkXtVsgb7MqRCD1utRy4e1Ru2If1PvgM4Vr0
 S+gzINm9mM3ot1FoHrb+cO0yz6N5fToQf3mkFm9VQmB+Qa5erBpJ3G0ZUmL35hdK728m
 l74XKiPjvA4HS2AdVS8LXscbYIV79kumU3ap+p2wD311rHLOqk90AQOZ3Hvc339RIHiz
 rHcV+2cUbkkoRSyDVbAHmpXXvpxiiHJFd8VJWtDAUtO51COr86d8Ojjrg5ekUtgwHweY
 JvtlX2q0Qhy3hk+t9hkdqg8L3WKdBsEKu/N12AyqTa7knenE48GNDGildbfGD3Q0tliL
 YWzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHQgyfGFwznmJkYN8nOGF5cZosAZy7jvhgYvn0RYsxIzkhkNDuDnPA2bOxW0kTABEnjeWzdio/7f2c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8pnhPmusf09HABtkf22vECMOYAKuJ2zQudEoNPPALlJpKdJGiW
 lgDNS2XUFwc4xyosHT8BuB8c+jn+DA/yXcX5Qusz1lldxP31KRkMERyY3TW+CKVnWJ/x7WNs38V
 ieM46ytZoCqbKhmpAyA==
X-Received: from wrmk12.prod.google.com ([2002:adf:e3cc:0:b0:49b:2420:f8db])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1788:b0:492:3176:3d6f with SMTP id
 ffacd0b85a97d-4abb400aefcmr32875648f8f.47.1795605151706; 
 Wed, 25 Nov 2026 03:12:31 -0800 (PST)
Date: Wed, 25 Nov 2026 11:12:30 +0000
In-Reply-To: <20261118133232.48603-1-vishal.moola@gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118133232.48603-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125111230.1082141-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: ioctl: fix call to unsafe function
From: Alice Ryhl <aliceryhl@google.com>
To: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 01:32:32PM +0000, Vishal Moola (Fractile) wrote:
> dev is created via an unsafe pointer dereference. Following the
> convention, it should be wrapped in an unsafe block, but it is not.
>
> The compiler only properly lints declare_drm_ioctls! when its defined
> in the same crate as it expands in. Since upstream drivers are all
> separate crates, this is silently ignored.
>
> This has been present since commit 9a69570682b1 ("rust: drm: ioctl:
> Add DRM ioctl abstraction").
>
> Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
> Signed-off-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>

Applied to drm-rust-next. Thanks!

I stripped the commentary below `--------------------` from the commit
message and worked around a minor conflict due to the `Ioctl` -> `Userspace`
rename.

Alice
