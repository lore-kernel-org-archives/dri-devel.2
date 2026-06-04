Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E42CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11A9113F99;
	Thu,  4 Jun 2026 11:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SN5rpTCy";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B000D113FA9
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 11:49:31 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-490b3ec3f7fso4658445e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780573770; x=1781178570;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IDsisrKoiSBYw8b45wvLvNabX1p1YR55LCjFQrLjodw=;
 b=SN5rpTCyFr9AE/eIjmM6WzlL1iOCeDE4MnmWsXc+aDnszcxkvHCUFCS4dCytfd9Soa
 ruYJYnSYb9tMxiBxlhigtJXW0QeUn2a9K8wnroJMEgUmSG4VCvnloiIz6YWZLw4R9sy4
 wUlh1nOHkOFDmRucYWgl64DICe/Mep2uLy7xzlrQRXnTlIOXltoJW7CGaNEtUvoPS4q3
 x2b9kzcsTwnDdLmtbEc/y4Cok8+Gbgq0RPFpXyExJkM4PZ1x7kA8TZaoGSpKIOnK0pS6
 759S21f85l5x6696grRJu1HCkImIWMvAM/qQE/q6l5vRzocV/FXYknxSGgfl707itOal
 N9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573770; x=1781178570;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IDsisrKoiSBYw8b45wvLvNabX1p1YR55LCjFQrLjodw=;
 b=SXnwvb4LSf3CCXAqVlQ+CAHpBooPVNlVASyoREGcQ8i6sAjlFCrUoP6XNYHv2Y7xiC
 h7NKB+jvQ0EXM80tHzPPpiH9HnDPDtd34/2R1Miu52A8BkzdUtRRqOXBWlo0XMDExNys
 ORPknmXpZuRvnS1eOowoBMwmH46gwPaa9K+XvAH4jDM+vo98AzijrY2CTMhkMQm0fRPK
 lsml/N6xfNMeAfLLMZYV5k9f4W/qx3UWrjFmo3MNxYnzfQwjnqe71aU2DNiNNTG3ZA0P
 sBZ9dLUSP9eZ+Nf8iRUpVMcgzdM9ioGOuUAsEYCKT8POd1pbDl/4m/hxYv4TBW31pTRH
 BKpA==
X-Gm-Message-State: AOJu0Ywdb3luCmyMK6Xop/eaL97RkckxPOz5ZxKVMvCqE2pO69AdHM5J
 Q1zAf3rM+DHVMqtFa8QMzBHjh4H7juUmR3i1Obzh4qsaYQc2hxEOYOgOZy7WM2tc1Ws1jYfVzC1
 dB69/DqTvqbpWzvmfKQ==
X-Received: from wmbc9.prod.google.com ([2002:a7b:c009:0:b0:48a:7f8c:a95a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d86:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-490b5fe79f8mr132548195e9.30.1780573770264; 
 Thu, 04 Jun 2026 04:49:30 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:49:29 +0000
In-Reply-To: <20260603195210.693856-2-lyude@redhat.com>
Mime-Version: 1.0
References: <20260603195210.693856-1-lyude@redhat.com>
 <20260603195210.693856-2-lyude@redhat.com>
Message-ID: <aiFmSUi0ZHVIj5Q1@google.com>
Subject: Re: [PATCH v17 1/6] rust: drm: gem: shmem: Fix Default implementation
 for ObjectConfig
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

On Wed, Jun 03, 2026 at 03:42:30PM -0400, Lyude Paul wrote:
> I completely forgot when coming up with this type that #[derive(Default)]
> only works if all generics mentioned in the type implement Default (and T
> usually doesn't). This being said: We don't use `T` for anything besides
> using it for a reference type, so whether or not it implements `Default`
> shouldn't actually need to matter.
> 
> So, fix this by just manually implementing Default instead of deriving it.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

This one is so simple I went ahead and applied it to drm-rust-next right
away.

Alice
