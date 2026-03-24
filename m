Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1992F532EB
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2519110E5AD;
	Tue, 24 Mar 2026 08:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="OKioKiBA";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2751B10E5AD
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:20:31 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-486fc42c83aso11644725e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774340430; x=1774945230;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rmKn3DTyzERwdlhCSakIzT6UnoUWWIujEFwhVV176J8=;
 b=OKioKiBAJcC7odfTTtrycgaOzLhMju+r1gaE4XHNRPwarTCLNiLt75wGERppiwEl8h
 +EBmj/w4bCaVCV9LgPVWkObXn86wcCWRqyX4lfQ60vbm22GEudDXCNJidH+KEWIlpSZk
 R+wArDPxmX/oX3SMJgj4RMHpQJk31y48TX4ul2KaBKl+CMdFxMPMZD3pBh5z3x99Yru7
 MMFw4ToTZJW1kva2L/qJDQ/Hgkz3xfZuktUHSo2j7uiHGOYg8iSWv5MYOiFtryPgZ47A
 EF6cOLteTPQft+Q4m5oAjFX5VvKiFKmtJqEKmFD2Wxe3SZY7JadUvsbJkvj5iK8v1Cuw
 1+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774340430; x=1774945230;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rmKn3DTyzERwdlhCSakIzT6UnoUWWIujEFwhVV176J8=;
 b=jn5QTjMxU3L8Dvf8j9vgWMj4nmpo4rKaVAEqwC04fK3tOEyKtuOvmFNqgiftj7nOv2
 XjaKyVX3KeXI5hP+nQJirXwbSXvHCxqt/tqZrkjyWUXj+YM7t3Rxcw75DoE85NiFZ038
 u6yPPrUDDDlGI3tykpzuUV40bmkQNzBax6FoN7hP6zXe4Le97V98P0IFY9sHPVu8aLxO
 msX9X71VEgXjAVTc5bIjyJG6RXY4z9GvTSljzqBwC5b4hDiTL8tePQMkZPG17BXfAk5k
 dmdi0ZVQPMqo04l5pD55AFgooQSI24cbID8vBW4LovLkOMMUmBkg2lvwVWXIFe0NTNrO
 3cng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOMpHdTL4llFx1Asz+tmGkYUNMivTEwy9rV1J6u8nFIFX8Cgjne44IaUbtQQ6L1LjPHnmHv7rdcKY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGlQqz/9YMSBk2MpiVeAC7J+A1RIo/qM0zu0X5rCLbf4hB//BC
 23JM2e5FFtN/ZbQDf9OXSozpV+l2YAtl4dbERKeJgxhNOAzcHXFYr8z9W8BF4qobrAYkAO5ozSj
 mHww+WSMv4r9pi23YUA==
X-Received: from wmsu11-n1.prod.google.com
 ([2002:a05:600c:c3cb:10b0:487:1c3:7963])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1615:b0:487:18c:7acf with SMTP id
 5b1f17b1804b1-487018c7d7fmr119524405e9.25.1774340429538; 
 Tue, 24 Mar 2026 01:20:29 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:20:27 +0000
In-Reply-To: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
Mime-Version: 1.0
References: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
Message-ID: <acJJS-vz6YHDw-iC@google.com>
Subject: Re: [PATCH v3 0/4] rust: Add ARef support for work items
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, Tejun Heo <tj@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
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

On Mon, Mar 23, 2026 at 08:26:58PM -0300, Daniel Almeida wrote:
> This series adds ARef<T> support for both regular and delayed work items.
> 
> - Patches 1 and 3 actually implement the support in workqueue.rs
> - Patches 2 and 4 adds a corresponding implementation in drm::Device that
>   dispatches the calls to the underlying T::Data.
> 
> This was tested on Tyr, and is actually needed in order to obtain a
> &drm::Device when handling work items. This is then needed in order to
> allocate GEM objects inside the work handler that processes the tiler OOM
> (out of memory) events. The current series sets the stage so that the above
> is possible in the future.
> 
> ---
> Changes in v3:
> - Rebase on rust-drm
> - Pick up tags
> - Fix import style for drm/device.rs changes
> - Link to v2: https://lore.kernel.org/r/20260204-aref-workitem-v2-0-bec25b012d2a@collabora.com

Thanks!

Tejun, is this something you could pick up? If so, please go ahead. It
looks good from Rust perspective. We can also pick it up through drm if
you prefer (in that case please provide an Acked-by).

Alice
