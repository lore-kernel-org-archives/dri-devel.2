Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91A7CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CEB10EE86;
	Thu, 11 Jun 2026 11:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AGjwJLap";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422E610EE89
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:07:24 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-bebacba844bso580590566b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781176043; x=1781780843;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SLWe+2FcDOwhw41u/Q69O94pEc+gWeJDYXa+4qvlFG8=;
 b=AGjwJLapWHoRl8nUQgne96j2hrfb/ie92AqeZWlK2IOWBwJPdQ7MIZI3KLYZwSFhl7
 diQYdUJDEPfP/ZJi7U9MEC7aIi7istRsKqdhRbcxYMtsz3xb9kXxNaXQ1/G3i77T7yKI
 h6z2/iEFY9fa8nkbqjMJmAaWmYUkxWahmhunfZ1lBBBX9E7XEifjkfRudqubZ3g5ltwE
 Iou9cFfXWv9rgA3699n13QewAdaawYQdH10pcuoFDzlwypL7Vp21ChqJR0vpkJ7JNCnc
 vDqyVy1saXz+gUouxTaTsNVJ01TLoZVFItLGLkyE0Mak1LvZbuTg+SjZCZXx6Nlyv1ms
 15Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176043; x=1781780843;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLWe+2FcDOwhw41u/Q69O94pEc+gWeJDYXa+4qvlFG8=;
 b=QD/3Dci3qylPB+s5maM2rD3pOOEpPUjRc/zbsAIg7X7/KzeYoRXZ8Pcae6ffkS9/p5
 rDW6CftLvvseS+/PSlFk6kkVqb9iApgYD9dwuRp2AMp5tckvbNfWkBGO6j5GBXUX2n45
 Dg5rjyh75RMZYCcJnqgbqcANqDZUdorn8CKNayFbPYJZl9GbStLVq10uUFWKSFRsApTV
 XadGhcsQxijy/hgtntPx7/enSGPXZrn7Z8VyeGHwpD/spj5jpV3Vk4zYOZv1mhwsAXeJ
 U3DQo3Nfk1ZnLwBgXVzeQjf+xb8pAgYYa1XgLkSJcbHHDxoT+42UKXXZelzvRoFKXK8q
 8boA==
X-Gm-Message-State: AOJu0YwTC6Pvg7kzPcxpmIAP7bDe2YBZmWUr1ibrYZv240v0c5+GVJVL
 DoCIoMW/NTgpLQhoKCaGksxyh8DngwYWPLyWqXYptKERagS50AnscQfSpi7q9ZIJJsoGp3EEsMj
 zue7cFEZr9hwutA1tpw==
X-Received: from ejad6.prod.google.com ([2002:a17:906:406:b0:bf1:4fcd:aef0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:72cc:b0:bdb:4cf3:7035 with SMTP id
 a640c23a62f3a-bfc85745bd1mr113064466b.4.1781176042458; 
 Thu, 11 Jun 2026 04:07:22 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:07:21 +0000
In-Reply-To: <20260610162433.923550-2-lyude@redhat.com>
Mime-Version: 1.0
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-2-lyude@redhat.com>
Message-ID: <aiqW6WcagiyiOAKZ@google.com>
Subject: Re: [PATCH v20 1/4] rust: drm: gem: shmem: Add DmaResvGuard helper
From: Alice Ryhl <aliceryhl@google.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 nouveau@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>, 
 Gary Guo <gary@garyguo.net>, 
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 driver-core@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, Danilo Krummrich <dakr@kernel.org>, 
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Wed, Jun 10, 2026 at 12:21:28PM -0400, Lyude Paul wrote:
> Just a temporary holdover to make locking/unlocking the dma_resv lock much
> easier.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-authored-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
