Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3F8CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B735010EE8D;
	Thu, 11 Jun 2026 11:10:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="mvYZPebW";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D6F10EE95
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:10:38 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-490afe64f26so4160355e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781176237; x=1781781037;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=B2hPEJWO7zc+9d/tXPog7CgsAXE7dhbuzsNKzaOmhd4=;
 b=mvYZPebWz+OLCN9bf5pJQwWLzygtkanmRaGfBcnkuB54505WqZOwhXay6NJXgMkQi9
 qVX0QuT/bTC4U/Jk0UxYQQjzKD5emVAO+btOcVtUrRheNxHulXghu+G1puoiucOlSRFR
 PF23CAZ04ZUeeTloVYe9T4YsOmmb9Sn0k5NXbOg5TYllekPvNoyyUcEw+UJqyCeP+s49
 IR9nc5/XpBQzBz7xLCaFlCsrGoeS2w72TmuiPWnyax3h+aK8OrmGnbvRaoYDFMWGZL8R
 Qk1pR31SLkUbqLYu4MXOXzuGCHg9cIgAfpsZUmQBxIZJmzz229qDZiY3IQmfYxOEv607
 zNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176237; x=1781781037;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B2hPEJWO7zc+9d/tXPog7CgsAXE7dhbuzsNKzaOmhd4=;
 b=Q1Z1I5qMvR+wC73QvmeBAHZ/xYLWU88T9MouQp2UjwHpfi+u35Ej8RSXogGesdbxHL
 kFnjrIHW/W3oC/nyd8tbToaf/5Gv2/Tu9bwO6sxXZUOnU2aeNNHZh+uMQrCGJQOcmfq2
 uh0XRgXxQnHXa627Gt+foc6AHTKWxIyJHx1Qwlxf/QDqhOrHAOY7ILNh6BqXtny5zQsM
 oMvnBdcp39qYZHGBFVRU/67Ux2snetxE+AfsKGbp5Dj8JFbcBrXXNw6HgFPqyqblwW8k
 4F4llkvgz2AjxJX5YVKJzS90LUl1vPCwr+VqMI9OANYb3cwPUHa+mTw/tNWZubfqXYVy
 gq+g==
X-Gm-Message-State: AOJu0YxbpMeBhQvNoDEj1lGtB84HG7/J7caMchs/oKDiX0MzCjJhYHKv
 IqBLglbZSysvpsWMr+MndmeMAPyS0bIaNtKHk+zO2Uu8ymIqDfgZbeJ7nB3P5QCXzUo0toJv3VS
 6TZntRCL8RIb4AXIXQw==
X-Received: from wmbgx15.prod.google.com
 ([2002:a05:600c:858f:b0:490:b1cf:4fed])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc8:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-490e52df887mr25369835e9.7.1781176236585; 
 Thu, 11 Jun 2026 04:10:36 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:10:35 +0000
In-Reply-To: <20260610162433.923550-4-lyude@redhat.com>
Mime-Version: 1.0
References: <20260610162433.923550-1-lyude@redhat.com>
 <20260610162433.923550-4-lyude@redhat.com>
Message-ID: <aiqXq_ufWWztHPQ6@google.com>
Subject: Re: [PATCH v20 3/4] rust: faux: Allow retrieving a bound Device
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

On Wed, Jun 10, 2026 at 12:21:30PM -0400, Lyude Paul wrote:
> When writing up some rust code that used faux devices for unit testing, I
> noticed that we never actually added the Bound device context to
> faux::Registration's AsRef<device::Device> implementation. This being said:
> the Registration object itself is proof that a driver is bound to the
> device - so this should be safe.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
