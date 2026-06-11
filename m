Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB36CCD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5683910ED62;
	Thu, 11 Jun 2026 07:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FG941Fdw";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9B410ED62
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:55:23 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-490bfd70b0fso76768445e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781164522; x=1781769322;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=AXZxyRMFccdWt/MQKRyDlJE1FTaAohbihCXqfQGqWSs=;
 b=FG941Fdwcyu/X+DBPRGYNYJP5IOjq+ijhj1nBLy2gL56UOhKRvLSNrDX59bdP2lUrF
 6dDobXiedeHXbdg1SMmr2XLwLU1dV/236gmbMQ15JYKrTVSaP53+enOCYlSOTB3ev+tJ
 P8VsFAm8nqbyihcXeH5Ygyo7Xn59XB2RZ391anAiL+L8gvLlATT+zjLalQ+AOjVoBn94
 0pFIfj4HPYvCJ1pn/bS/bwmjWkjlydZU0CUx0vxwirRaQmoVszW/wdAsQhGzu4q3Xg0B
 jqCrYAmfmDqQMBvfqO+CR92MH60Jds6YXzYplKdPJzP86rBKOPnw50SzxGtRlu0HPOuZ
 FTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164522; x=1781769322;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AXZxyRMFccdWt/MQKRyDlJE1FTaAohbihCXqfQGqWSs=;
 b=bF7KcgFdn1+lhEeVBBTmwZu0axbitCdEIDvvPGvpdveeixed0Q1pGu2tCcVZoCK1rk
 cX++rzgEYG+G1ttesNyelAIotiWuBNtFO5MLClH+RdZZ1178FrOv/T9xRO3s2DPbdwxh
 52twZdNb66xKsoeFDBerOMLxXgAj89Uf+tERZgKI6ItIBGPgzbmNHGnhE09+640jrzPm
 Ux1Cb5Mn0Yj2F4Q+eO2bMH1q4yWJQ4mPo7Ee7E9XX40bgtwnUtbkVJuuwObujeKYu30r
 VdZ3zcnItSY2IzxheM+VcjRxbnQAKcS4eSQL4KB35AhxbNWKXALobMoCAbeekFDNgOO+
 7Qzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ze8AhuLKaQqqlPxCCr9K333BOBu/WzRkGhsFBbPeiuCX5HtqMwvv5quw/RkQV0l8ytYFcPQ8DY2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZkeaLpGdATS7P7KclHU2Z31nyzgPS+KcMBflyIT5jqMPa+eil
 2ZWM7zKOZfz/H9uKVD3a+01JmMuazXue5i47mIxJBXJCOEOwx7+pTHCiT1x0VJNpb0gaijakQ/m
 rf1JPrWYh8Cf6noAwzA==
X-Received: from wmbg11.prod.google.com ([2002:a05:600c:a40b:b0:490:b22d:da02])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4455:b0:490:c2a2:e91c with SMTP id
 5b1f17b1804b1-490e5642822mr18384385e9.34.1781164522238; 
 Thu, 11 Jun 2026 00:55:22 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:55:21 +0000
In-Reply-To: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
Mime-Version: 1.0
References: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
Message-ID: <aipp6chnYAUQ8LOv@google.com>
Subject: Re: [PATCH] rust: drm: gpuvm: update DriverGpuVm for DeviceContext
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, samitolvanen@google.com, 
 laura.nao@collabora.com, boris.brezillon@collabora.com
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

On Wed, Jun 10, 2026 at 05:01:26PM -0700, Deborah Brouwer wrote:
> Since the introduction of DeviceContext, there is no longer a single
> driver object type to equate with the GPUVM object type.
> 
> Instead of threading DeviceContext through GPUVM, remove the strict
> identity between DriverGpuVm::Object and drm::Driver::Object and
> instead tighten the requirement that the DriverGpuVm::Object be an
> allocatable GEM object associated with the same DRM driver.
> 
> Also, make GpuVm::new() generic over DeviceContext so it can accept a
> drm::Device<T::Driver, Ctx>.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
