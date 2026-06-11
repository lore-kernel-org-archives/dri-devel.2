Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED5CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CA210EE8C;
	Thu, 11 Jun 2026 11:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="T1uilIgg";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D93910EE94
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:10:07 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-490b3ec3f7fso49888455e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 04:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781176206; x=1781781006;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=YpGjHsDNrecPmydKZbz+npt4P/d2PQgzeW5pneBmX4A=;
 b=T1uilIggIilzLD8Ep7b0pUTjJlBeRH7SWQMbj1RWNsZ6Ew5geteE7JXQA55edulGpM
 RQjtX38SBf9bJG9V2orwC10kBOek9STfMkGLwjoIxOfKxEOqQn88a89jo6926+Lz2maI
 XnxLNdybZOvbezc/cleGMFcyawC5La2CgvZAtNrmCJIqo6IiKo0zzj0EajMofxL9kUCO
 jbHADZeSK8x3ncHi797AaB+yiktF3b7RG0SoakjPX6zQv35AGnBFgbpL0QY54l9ukDK4
 cGcVtlzraF+kQRzUeAlYC1MEB9XR0mpFwD4DMZ+Owuq2OU4KG6PpyzCZoNZkiIVR7iKU
 ljDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176206; x=1781781006;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YpGjHsDNrecPmydKZbz+npt4P/d2PQgzeW5pneBmX4A=;
 b=IFAGF+u1gvJuXN8UeI4cMvue9xehX4aCntp1F+rF8Bx5xEtm3nWrHXeWho1V5XLfxm
 thrVbllRnxqX+fhRpYjg4awWdlG84RKGCNzeHluRXd+7wsrdv75Ur83MoBPgfNpPHZoy
 3zp3xxJYK/voobA1inxQwCycVemVgPWT0gCA3/DlSpu0jLHfaQnjkFpuf/CUdHkf9u+G
 o4iWfyFUtvOIgABOVqZcU9clSy2EymChWTQgDX1BJM8+igityLGyQiJZabeci2YRkWCI
 lHKeJYRVx52ZkR9f0zHQj7bWcQjgLGm1nmYhJOPhpjrSzq5gpVx1WoJUrJj/MiOLRB4Z
 Iq0w==
X-Gm-Message-State: AOJu0Yxqo0hLmyYWQ8ZerhEeL43/acN/E2sQ52DvREnFvK1UBS9AOHsr
 yNwlz8UkmENYmais3lal/GloWDfw8zo8YoCwKrWJHZf4TaPCs0YZ7q4JjCvEnaidDfua3H7497H
 e4oB9jpp4E+DNRzyYHQ==
X-Received: from wmqe21.prod.google.com ([2002:a05:600c:4e55:b0:490:b058:c623])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:ca59:0:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-490e561ee97mr20621955e9.25.1781176205567; 
 Thu, 11 Jun 2026 04:10:05 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:10:04 +0000
In-Reply-To: <20260610162433.923550-3-lyude@redhat.com>
Mime-Version: 1.0
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-3-lyude@redhat.com>
Message-ID: <aiqXjAPQCQ7POxWS@google.com>
Subject: Re: [PATCH v20 2/4] rust: drm: gem: shmem: Add vmap functions
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

On Wed, Jun 10, 2026 at 12:21:29PM -0400, Lyude Paul wrote:
> One of the more obvious use cases for gem shmem objects is the ability to
> create mappings into their contents. So, let's hook this up in our rust
> bindings.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
