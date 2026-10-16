Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16962CCF2C1
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E851010E1DA;
	Fri, 16 Oct 2026 13:54:53 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA00210E1DA
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:54:43 +0000 (UTC)
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c2942fa0995so690015466b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792158882; x=1792763682;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xqeqqSt0YOpLVQ4yu04gr8nCmmHhkZ/s47wtOe1ej+o=;
 b=s1OzGaLFVSwJWZEhm003dnX9XLAX80bixfJm9oOdTCtBQUq5vLqIVSl+00TGhqsWLp
 SHRjhz83hUBCWbpI6ng9ZCmOpCSeOiNm7Ey69PxbZ6+uKN5BVtk75U8/iu+WFJBAjL89
 xFOWZlG0oMK6m3ieQ/a9/4Vufd82aot6ATwvCpVTnjOJ0WLKjWRhxFx/tAUMNJ4fPdkA
 d5Y8hC93m0KPMld6evlKBTnUWBn27aD06MrHFCYtI0g6Z8dvute5ncp2nkslsQ2++bn6
 eick+RDzaqGa322eYyZVAi/9dTOpY4RBSH+H3FPf/+nGgNGwdE4pZloFdn2ib+GTu7w0
 4uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158882; x=1792763682;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xqeqqSt0YOpLVQ4yu04gr8nCmmHhkZ/s47wtOe1ej+o=;
 b=HdV0qbbXO4pQHjvlcVSbGc5yJ9rD4MBGRnRMKpideh/GiFju4C95EmWG+RPXfeINJw
 43hSsWO+Tf4SN0eTCt/owTci1pXfdQUJ1YbeXhBJUYvQmFfpaNRRHBFajQuvXIPZMazf
 xWRowo5sMRVCgMP2eMogvqU5A5Sae7gOq5OqJw7qn4o93gGtAWy74FVMiIzHW+39rM/D
 rDpKZ5gPank9vjo6yw4Gr6aG54f9qYTCLe8WmqqDvRsaFH50k2homRESqI8/7vAnFCbJ
 wgiTdG5ERRtdXxaLE6SzW55ZHuUGxc7+XYPSLPzgKJT8RCWASSmykA0p5RM0ga6M4+7T
 oa5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKVJezw1YWgQ8U1VpOKAHGFJvAT3n77SsRKvz5KkOGWBT53NKD69pfAt8rM+gU5VrFuY94+vg3HUE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIwOgDXfaMNjJqE0hRrf+ZE038F7w0A/Trbm7xMnhBGrmvckJOW
 QSCyT2VA7rCa6JEhspe3vjg3MGJLfJJslq6ywlF/h9dDKPa5Am7sWYoHZfEIsjy4lqimpNRRaFo
 ziYggI4wmNIZzPaQs5A==
X-Received: from ejbrh8.prod.google.com ([2002:a17:907:20e8:b0:c35:81ab:15ef])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f20:b0:c3e:e726:9548 with SMTP id
 a640c23a62f3a-c3ee7269fcdmr508329766b.14.1792158881705; 
 Fri, 16 Oct 2026 06:54:41 -0700 (PDT)
Date: Fri, 16 Oct 2026 13:54:34 +0000
In-Reply-To: <20260814230923.1292966-3-dakr@kernel.org>
Mime-Version: 1.0
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-3-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016135439.44716-2-aliceryhl@google.com>
Subject: Re: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, acourbot@nvidia.com,
 daniel.almeida@collabora.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org, 
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev, 
 deborah.brouwer@collabora.com, laura.nao@collabora.com, 
 beata.michalska@arm.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Aug 15, 2026 at 01:09:00AM +0200, Danilo Krummrich wrote:
> Wrap the GEM object open and close callbacks with a RegistrationGuard
> (drm_dev_enter / drm_dev_exit) to ensure the driver callbacks only run
> while the parent bus device is bound.
> 
> If the device has been unbound, open returns -ENODEV and close silently
> returns. This prevents driver code from accessing device resources after
> unbind and is a prerequisite for making drm::Driver::File
> lifetime-parameterized, since GEM callbacks receive a &drm::File that
> could otherwise be used to access invalidated file private data.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
