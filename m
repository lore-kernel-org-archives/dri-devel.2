Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C32C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E83C897F0;
	Mon, 13 Jul 2026 15:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="k9dHKgQ5";
	dkim-atps=neutral
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D620897F0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:35:44 +0000 (UTC)
Received: by mail-ed1-f73.google.com with SMTP id
 4fb4d7f45d1cf-698b899b53cso3292414a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783956943; x=1784561743;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UZgc/vupwsueMqB4x7/Q5vvpLkG8Vv1Z1ubKbDy/+14=;
 b=k9dHKgQ5zXv0bBLepFMokWjTZxKHCQn6mzm3OkhnGysUow4PfVxx41ZNujMf3KB/Ml
 SfRiLyBXqP759xBlTKpENqGMEfZ/B6BFxkhQwQ2IIinrYzHQgmb6f9a6QgG17liZxwtx
 3Kl/9W7KxU/HhYv2WSshRIwCTyikv/ejirylQXMseJzx9aNUi8JMe0tJDXS5E78sCW8v
 oI1PqOUWN+jSQvxanMTUnm3c8oqqvLNh165mtO28/7WF1G2b1om28ojt2z3EedDpla7X
 8ewMvOVVgOBRQ0oOVRf1LyN4XUp9qeJZDu2btvPqFTBWIgvBAF8zh+PWU7VNcffTq/hd
 VlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956943; x=1784561743;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UZgc/vupwsueMqB4x7/Q5vvpLkG8Vv1Z1ubKbDy/+14=;
 b=KOM+Dqj75oDU1DC7O63jUAVc5baDmMsv6IK+aSvFI8QuqKf8GHVgWcCcATX5Zp6oaW
 G8twmHX+hz0w2RirxIVUPF2WctEHI/dpL9qnErvEYOeUW2xZ4dhChGeN3tnDp6OeRf/z
 wK65BDJQLJNqAFdj1U1es3Nzc4b0YxF+R6hy44q7FIc2zKcvUD1MUChu0gSEWy0Sfy6e
 TLGEEj/kUTQ4I0ZT3nRjWSJKTXXvmSPgzkgdMLn+H1UlkwGQPHFCKVVXVmKeDPenm6R3
 +I8OePA7Vp90NFb81HY8gk+8i6IhlgDG4Uf49eR+GveukgfFwnuMZy/ue9oZVcSwlYax
 4xFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOtfJf2I/4sSqefmZbvV2gR3H7EX2YdLIpkbBTChaW7X7X1+8NDghApcNMLgjbTcT4wv3c7L26ozU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE7tIgcuzR0HpPryC7WvVF+DAZ/3gJJ37FDtLvo/9YcOpG5GTe
 XQuXn0RRSgkE9qTlaQtQmDUZsVeditarvtzJqOEvRMTeuwJ0v0ZRbpZHVnkKfaBjJLQ1OhACca0
 X4tZKcUhpSBycFiScnw==
X-Received: from edbif2.prod.google.com ([2002:a05:6402:5d82:b0:698:bf45:cd4f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2686:b0:698:87ac:33c2 with SMTP id
 4fb4d7f45d1cf-69c5ef830e2mr4273388a12.9.1783956942642; 
 Mon, 13 Jul 2026 08:35:42 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:35:41 +0000
In-Reply-To: <tencent_4426892E62B77DEA2AE898E899A871940005@qq.com>
Mime-Version: 1.0
References: <20260707160200.2798072-1-1479826151@qq.com>
 <tencent_4426892E62B77DEA2AE898E899A871940005@qq.com>
Message-ID: <alUFzVNxNHlmZbMJ@google.com>
Subject: Re: [PATCH v2] rust: drm: fix GEM object pointer safety docs
From: Alice Ryhl <aliceryhl@google.com>
To: Yilin Chen <1479826151@qq.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
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

On Tue, Jul 07, 2026 at 04:33:33PM +0000, Yilin Chen wrote:
> IntoGEMObject::from_raw() receives a pointer to struct drm_gem_object,
> not a pointer to Self. The previous documentation used Self even though
> the function argument is the embedded GEM object pointer.
> 
> However, the pointer must not be any arbitrary valid drm_gem_object. The
> implementations recover Self with container_of(), so the GEM object must
> be embedded in a valid Self instance. This patch documents that requirement
> explicitly.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Yilin Chen <1479826151@qq.com>

Merged into drm-rust-next. Thanks!
