Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9602F33805
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BF210E336;
	Tue, 17 Mar 2026 06:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="k21xIKlT";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1682210E336
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:47:17 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-4853a9467c5so29951425e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773730035; x=1774334835;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+LfXYyK2K5YV7GwOcQbmsbmYUjdllavbSwogkW6CuYU=;
 b=k21xIKlTd1Pm5qrLJvqROOCXenDBDvKedLnV+fmYY/mZe9v20KbLamFUmyvOVXL/L3
 j1giKNtnxkQ6AaKTy8yw8YXPcTYBNMDHXdZmYldya5fNbd3s5DsEAr3QUpxxWsX17ada
 nqdqzioeS9OhYnGEW3j/CT1Qp3Z20m41NHYfxmNFSdPp+kZNdBQoapYUL+4GRISa1sO9
 Lk986fWNUwgvksMoRxHR2kCEDWgiIrQ+Gd6TuzIDO20n2rBUmPzs5aJrtBPu23cPH0uo
 +/RPpMW+XTOiAKrGmxc/MK1ezXN6gcZekAxArHkWaAyDZq2K21dTk9kS8fHgJIqhjJhk
 VYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773730035; x=1774334835;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+LfXYyK2K5YV7GwOcQbmsbmYUjdllavbSwogkW6CuYU=;
 b=Nc81xulDVMugUbLL2rB238nQHx2MyNbhsz5S7/mBJxbOxXi7TLv6gMYhEKIodcMYcM
 gRRf6Nvcp21oI0agjgc50yilnzMhndzmsvRtAoRTNPAkrMrtBe1Wbft+p1Pl4WVLo+7q
 viauK5UcIXhNpySXSLosCOTlgM7CbVShYtsx+D1KjKKoV3JsvgRVdgNCEr3DgTdeLnyk
 cHEQ6alVN4gta74urbb/UoIGQo8ZIdY634d2IBGNdbCZZQrzz6hVmekIHpv50wPC3SwD
 SWMNUewzc/JbUqNORvvyXnDctDqq0Z5uNPHcACeej+kSPvHVj//0eee8bcEHRJ0hT8ke
 HTcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmUuKD9BTycpkNuxuvlAQhH7XO3iRm6enlp4eC9JYffHbOV3G4p/YiQt4IMGXgM6hk8fdrj9r6+DA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiKoPzx8teK2MN2v6X6fSiv+VfadE0bVN/oqUrUDmC8WDQMDc8
 z2mYxd5dK2hf/T1lu7URJlYM1xz/ThuEODyu/LW/KPxn9GYLmMJcoP/OsrIxBrdZuJPyv9uQUEg
 9Yv14sUR8ibT34+ZU1Q==
X-Received: from wmpj3.prod.google.com ([2002:a05:600c:4883:b0:483:509d:729b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8a0c:20b0:485:54cd:6e4e with SMTP id
 5b1f17b1804b1-485566facebmr200570335e9.18.1773730035474; 
 Mon, 16 Mar 2026 23:47:15 -0700 (PDT)
Date: Tue, 17 Mar 2026 06:47:14 +0000
In-Reply-To: <20260303162314.94363-4-dakr@kernel.org>
Mime-Version: 1.0
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-4-dakr@kernel.org>
Message-ID: <abj48uggZonBXPsf@google.com>
Subject: Re: [PATCH 3/8] rust: dma: add zeroed constructor to `Coherent`
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
 robin.murphy@arm.com, driver-core@lists.linux.dev, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 03, 2026 at 05:22:54PM +0100, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> These constructors create a coherent container of a single object
> instead of slice. They are named `zeroed` and `zeroed_with_attrs` to
> emphasis that they are created initialized zeroed. It is intended that
> there'll be new constructors that take `PinInit` instead of zeroing.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
