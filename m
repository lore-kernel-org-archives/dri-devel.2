Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B861CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044A71126F4;
	Fri, 16 Oct 2026 09:37:51 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC3D1126F4
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:37:45 +0000 (UTC)
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c25edb54d22so747744066b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792143464; x=1792748264;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kkFwVtE/2q4IWQT4lJjpaObOEOcr4IQSF2aZLb9aFIE=;
 b=PaAjHfeNLblym/lloBgyw51aomUiCsA41tgROrMhHp7nQc91V9VUeIwvA+lHy4bmcK
 i+6bAY7DKct60R4YG/tifB4wVsaIjpiy5lkK/4k+7tNfaGApKWLS3S/2K9SeERdciZSQ
 lacmUyXPxvIWZRlrqyvTDwyzggAc4Mz9PHaiv16tkvV3LQXoXsMkVYMfGROp4Vhk/SRm
 4hn9Fgf8f5pCxLVryWORm83HRB0gqBI2pqZP30jPdFf9oC8QvpE1GEQN++UcGUCoZQHx
 TJmtV4+nGDhQCfV7AK7SmWGqY4/mHCEIGk/3GeDmAvw2SzgRLvWTmnJjZylsYKJ4MAkV
 dsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792143464; x=1792748264;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kkFwVtE/2q4IWQT4lJjpaObOEOcr4IQSF2aZLb9aFIE=;
 b=vbDXi4O5Bs4Hm5dWTc2da4zNNzIY1+uQkArYLc296lPz5rBaojqU09lDsqgwkEhzwS
 n9XWIuCWhMJT2tyK59ThVVwlCqakBHQPdwOTMj+vhPkB4PRpwx+3dp0BPUcarE9Dw7tp
 VxFSB/9ae4sYVemCXg9+DUmh1uCBpbzp3VjmxiBYJodLl2a5NB6CDiGu+7byxkV2djTs
 n8lSlL2ml6krnEAtRebxturU7sTUzIS+v3C8b8Z8vvw5jhxqIzhgzU/U5CrruSnOP+7/
 iPalGp4J8PX6k/BCIyvUnkr8Pu4L5t6z2eg7SXhDguPSK3ZKL2S094nWBx472GUHlfQb
 90IQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByfe4rO+yzq83fK+fYdnVMb0gNNzPNPRWICI/ORmrdF6d6C02ES+wjvYedAYIi4KsWxo0wriap7Nk8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIE2QNM/hGO+XqktuuGPZDSCl3CFQjPWB8g1BnMMyY3eKjVsxc1
 +Pt9NKhTMH2xAkOULGQ/sMlHMHKjIZw4CP9aVjJfWNVFgbZiG9bZVg3+ZGZq0hrmRv4nYcL9aMf
 SL04hPYUfN1LeLChcBw==
X-Received: from ejux4.prod.google.com ([2002:a17:906:4a84:b0:c3f:d648:42e3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c610:10b0:c37:8c7c:a840 with SMTP id
 a640c23a62f3a-c378c7ca8d3mr619539466b.18.1792143463574; 
 Fri, 16 Oct 2026 02:37:43 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:37:42 +0000
In-Reply-To: <20261015-b4-dev_query_fixes-v2-2-e3e6d25050cb@collabora.com>
Mime-Version: 1.0
References: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
 <20261015-b4-dev_query_fixes-v2-2-e3e6d25050cb@collabora.com>
Message-ID: <atHwZg245MM7l9Ty@google.com>
Subject: Re: [PATCH v2 2/2] drm/tyr: allow userspace buffers to be mismatched
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

On Thu, Oct 15, 2026 at 11:35:21AM -0700, Deborah Brouwer wrote:
> +// If the user buffer is at least the minimum required size, then
> +// copy as much of the kernel object as will fit into the user buffer.
> +// Don't fail if the user buffer is smaller than the kernel object.
> +// If the user buffer is bigger than needed, zero out the remainder.
> +fn set_uobj<T: AsBytes>(usr_dst: u64, size: u32, min_size: usize, src_obj: &T) -> Result {
> +    if (size as usize) < min_size {
> +        return Err(EINVAL);

Use `kernel::num::casts::u32_as_usize` here.

> +    }
> +
> +    let mut writer = UserSlice::new(UserPtr::from_addr(usr_dst as usize), size as usize).writer();

Avoid casting to usize twice.

	let size = kernel::num::casts::u32_as_usize(size);

Alice
