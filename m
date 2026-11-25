Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC55606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S2nQLhZT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5B110E310;
	Wed, 25 Nov 2026 21:56:43 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A4410E310
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 21:56:36 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ba078f26f4so44735425e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795643795; x=1796248595;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9PE68dNtC/k/Esp67FurgmP7IWjKQi8+eTRAEPekc+o=;
 b=S2nQLhZTCz+LIGq/PGcOJQLldpADpJS+taKhcmdFnSrGytG2iTNYCqp6lS7mcsIyuD
 nmvS/baEntGPv4E6RvyKoGiYauulXqpVi46+C+deET70c1pK15GgDV38i7znMwCinl3+
 g+PvpCeYprmItSnCxogLbNq4hiGKrN7W7Svy1Z/NsOiklly8zralEbP68pXlF4sf8ZWQ
 1AEv+GUpTKUm+uK3+FXr7ejbSP4Z1ZAYa1WheJT7xu/cQZnyDLwJZLDVVFAGzqv1arBR
 LrpKemJftiGmcq7ginCAlo7CP1OkYBzv/2EBUvC8b/xk5hUOEzJDVvD1VeuZmeuHojVQ
 /Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795643795; x=1796248595;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9PE68dNtC/k/Esp67FurgmP7IWjKQi8+eTRAEPekc+o=;
 b=CJaZkhRcLeUG3oCPUEBpyaffOl6/ND3GEQasak8gsIxts7aoQCWHfuWNHZC8/VTVME
 VyIYKrp5V5l8mSgm9Dk8OOod1TMtQeznE+v1m1yj2gtVYyBha7cF4+Q5vFsPcoNg3f9i
 +mAmWqc91xGiTQA6US8L4xxJILSPegTlTDiK3JXFJE7WsLTMCPc4jyyCdKhT9kXJyf60
 WuTp3ui6pIfvXawLW8H5PU672P/BzFqC2BdnfpWdkPzMtsicVmT9aqvWEDw8Up2UBkeL
 lCI/N9MkvgZWSVCFsX3uMsgsst1dthuYQnIBSB3KQ028OKI6fp3hGWaKVk8nbHzAmIyd
 KV1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHWT6mQsb8RdRbJxS7LLKBCJ/YLBP7Hk54RmtzCeFy3FfLXQIrGfpp6ulhdwirFfdoBh4K9f1aJc3I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+67vOWxF8Yc9d8qUStWEFCuZABD3FMSfxVpJ9gooDi7TcNUz4j
 jG+bXxj9Tge/0vLABtAxEvWUOUG7n2C6b80gdhXGGAuWkU+C9cvuDVSM50L7qgLJQIwh/N5lDgJ
 i8GXVYSImcZe1+coOxQ==
X-Received: from wrf5-n1.prod.google.com
 ([2002:a05:6000:43c5:10b0:4b8:33ad:b766])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46d3:b0:4bb:5c92:ce12 with SMTP id
 5b1f17b1804b1-4bb88812200mr409757855e9.17.1795643794950; 
 Wed, 25 Nov 2026 13:56:34 -0800 (PST)
Date: Wed, 25 Nov 2026 21:56:34 +0000
In-Reply-To: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261125-b4-va_bits_clamp-v1-1-07e2bb33eb50@collabora.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125215634.2399752-1-aliceryhl@google.com>
Subject: Re: [PATCH] drm/tyr: clamp va_bits to available bits
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sunke@kylinos.cn
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

On Wed, Nov 25, 2026 at 01:28:20PM -0700, Deborah Brouwer wrote:
> Tyr creates a virtual memory space using the number of bits supported in
> virtual addresses as reported by the gpu. But the page table mapping
> operations limit the width of the input virtual addresses to unsigned
> long. This can result in tyr creating a virtual memory space that is
> larger than a 32-bit system can support.
>
> Check if the virtual address space bits supported by the gpu are larger
> than the width of unsigned long, and if so, clamp the virtual address
> space bits to this smaller size.
>
> This reproduces the clamping that already occurs in panthor_mmu_init().

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
