Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90B606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgONRcJC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30EB11258F;
	Thu, 19 Nov 2026 15:44:39 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38B611258F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:44:33 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ba01393800so15631595e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795103072; x=1795707872;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=plRJXSHLssMK20rYzYBE8Y5/bfsmM0mbLiVQroO7VYE=;
 b=VgONRcJCcJfExhY/Om2oRj3kVECx0A8F8FhS9Qz3oGA1zqQHa+wXUCoHvvKqjA7mzW
 XPYe6LFIGXxWF7nayKwFmyKP5lbRANgTf8GNAHS12aldDs/yAmM0Zx49RTticnRy/Nz9
 F39CefDYIXL42YKt0gb2GJEqaYhOkGDzZX8wyydntrgWmZU4QAuqH/euEMPsK1+b4SJG
 HsmhD2DTEJG5TTxvSnPtEqRvDFYRiqwoOxH3qtVIryxFUWAM3oQTWB3Gtrlav2fjtwFI
 K7yng2t9GxrOfBnlQ0EN0S36+BIfc/nMCnGwAU9AriXaR5HSjRQ+Unkfv+IjMyp4/gAe
 1ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795103072; x=1795707872;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=plRJXSHLssMK20rYzYBE8Y5/bfsmM0mbLiVQroO7VYE=;
 b=XwUR6nszeY/uNoW044VP7iaR/7WbjolnKxGiQFdDSaNw7iDAuH/37/KZpb10Tz3/U4
 94XfuqZ4ad/pAOIy0BFii1gc5Z84TF+IwzV4G4m7ARlsa/g0FCxrQmakbfJ8QXzct/Pr
 pzjIivOO9GoZF6JvAvt/6DELvafzeHTwkq8q5KJx3gL6jSoYcGO3aexwp2c/H8Rvzf/n
 74JDnSW6TeP7kq38Gk77NrzDhbDMCQ66XDpklc/IbmmcAzJUWbp6tVoexdPpIMULsXfC
 Zc1xR+Sda3abpqbTTrGFjtUl8VH+fBYWyBSXhkY0dkLQRSdXZ70QmF80tBtgPHxdEk0L
 fdDA==
X-Forwarded-Encrypted: i=1;
 AL+hErGtHwDCcK8w0OaeWw6NwkH6sthfu/P+oppS+eQS2fNRd0toMv5sJPeLhCJdTLQz/OjNFp6m9hFJPqE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95HXuskZpmb5ITU6eUHLobulwRtj7LHrvSSlV5+2hc5BhUCZHr
 hTqd6hL5YUf2Yeb5cxOjNrWz1TFE3CU7M3/EuSYJvyDikogtTvpX2A3NZ9RT2+NNwGQljPoEaz9
 phpJkUFxPWP48pPNGvQ==
X-Received: from wrsr11.prod.google.com ([2002:a5d:494b:0:b0:497:e67e:6f53])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f93:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4bb7da1c549mr137461195e9.16.1795103071706; 
 Thu, 19 Nov 2026 07:44:31 -0800 (PST)
Date: Thu, 19 Nov 2026 15:44:30 +0000
In-Reply-To: <DMZ8NNSPL36I.15O2JQR7M65T0@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
 <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
 <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
 <DMZ7CHWBWU4O.3EA040FFBVCLG@garyguo.net>
 <DMZ8NNSPL36I.15O2JQR7M65T0@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119154430.918072-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
 daniel.almeida@collabora.com, 
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, ojeda@kernel.org, 
 boqun@kernel.org, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 02:57:37PM +0100, Danilo Krummrich wrote:
> I think in the end it comes down to personal preference, so this is fine with me
> too.
>
> Though, I'd use a generic name in the latter case too, such that it doesn't need
> to be changed once a second resource is referenced later on.

Agreed, using a generic name like `'a` (or borrowed-resource names for
invariant lifetimes) sounds good to me too.

Also, when updating this for v2, note that `VmAsData<'drm>` in
`mmu/address_space.rs` and `GpuVmData<'drm>` (along with `VmMapArgs`,
`VmOpType`, `VmOpResources`, `VmOpRequest`, and `PtUpdateContext` in
`vm.rs`) were still left using `'drm`.

Alice
