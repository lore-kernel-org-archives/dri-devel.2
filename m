Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2010CC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC2310E21E;
	Fri, 31 Jul 2026 12:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Fpv+1Ba6";
	dkim-atps=neutral
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9887110E21E
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:49:26 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso748034f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785502165; x=1786106965;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jqfAaz1EDz40TU79ACF1Zesj56aNpbSFHPja1epTxcg=;
 b=Fpv+1Ba6QuH+RmS5HI5IIW0SgNn2Xh7p2T+V/zEoAkdMWqUvfaCw19ngYelvLlPayF
 DltpTdMNu6Fw8iDJnzNnnWfr081mR2igq1v4U0/pi/05cv1yXRo6OacgPO4CQrOnZd+9
 n4V+HXmJNey6u+XT0T5dLgCD1KSFT87rQBlsCtSc9SwVg8QvAPyEYtOs1/Hv63cB0pTB
 98qZsw0WVnWGLWZdIVXzLwGXhSxK1pfhTpxGPktZevDpgWxcKkjAel3OVBU9LEgjP7f0
 EOzsZxsc8vTG9q3yPtT/q1ZcNmDQ/ahlukw+fbtw9moTwyV3uL7fE2/ENJ9ddmJhjTgS
 KNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502165; x=1786106965;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jqfAaz1EDz40TU79ACF1Zesj56aNpbSFHPja1epTxcg=;
 b=ELD3muwIVdhhYzGMKKFeWrIjIvsmilT2Cg/iUCbrai05bmI/WObdRKw3P+lg0DDEqz
 vE4vp1sMLCuzJpUg2xnQ4TMMkqZWFXX4gjgI/9+lkT9zMeCz/2OXcBFtkAngD8IBkvj3
 s+rKgIPAuktlbzxKw+xHogRd+CXCFl5Uq1U49dvPrEP6scbxG2lRQxMZx2QZdIp8pUBD
 qHUoJjO5N4JW+l+z9zIQqeqEk2umkYpV7vNVK910KfTMqQ+8R6qMv5WxByBoTpvVr0xf
 qM5/iokj9fe7deuDKA0cNX04C0nxyPMkGadJNmJ6hlNkpI8wHlrQs+ofUQmnUxW5PP/I
 zOOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPBrnQiO1Yk5XRgz/7EOh4221YyDO2cYbupedbKc0M+YN3V3UiSNJqZtNDla2WTaND/Drj2S3eyFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUj06ej9nwB39dvlw64nBSoqvylS1XpVf1t8mNV3Gsve0bqL1/
 +N/3ShciB62ZIoWPZmP3HvJh7P3jqUlhaZo1neIs++0/V/u89BiPFhz+upaM+AxwcpKd5DDY6m2
 i6t5QW9ZhkLjeblDhLg==
X-Received: from wmpr10.prod.google.com ([2002:a05:600c:320a:b0:493:b301:e269])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:38d:b0:47f:90a4:ff42 with SMTP id
 ffacd0b85a97d-47fd2ab7ae6mr4641063f8f.5.1785502164625; 
 Fri, 31 Jul 2026 05:49:24 -0700 (PDT)
Date: Fri, 31 Jul 2026 12:49:23 +0000
In-Reply-To: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
Mime-Version: 1.0
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
Message-ID: <amyZ0xD3BTKeVPSS@google.com>
Subject: Re: [PATCH v10 0/7] drm/tyr: firmware loading and MCU boot support
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, laura.nao@collabora.com, 
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com, 
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
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

On Tue, Jul 28, 2026 at 11:39:22AM -0700, Deborah Brouwer wrote:
> This series adds firmware loading and MCU boot support to the Tyr DRM
> driver. It includes:
>  - A parser for the Mali CSF firmware binary format
>  - A kernel-managed BO type (KernelBo) for internal driver allocations
>  - GPU virtual memory (VM) integration using drm_gpuvm
>  - An MMU module and a generic slot manager
>  - Loading firmware, VM activation, and MCU boot at probe()
> 
> It is based on drm-rust-next and also depends on:
> 
> [PATCH v3] rust: iommu: add device lifetime to IoPageTable
>    https://lore.kernel.org/rust-for-linux/20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Applied to drm-rust-next. Thanks!

I fixed up a minor build failure with 32-bit arm on apply.

Alice
