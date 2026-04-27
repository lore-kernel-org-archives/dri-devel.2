Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A753CFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB48410E8E6;
	Mon, 27 Apr 2026 18:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cv+CNXCO";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3366110E8DA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:49:21 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-488d1b5bca0so62860815e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777315760; x=1777920560;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=kR4KO50jdZd8//Zt2cnARbtQ0o4oMYRnBX3J0b8EqXo=;
 b=cv+CNXCOR4MUyMPBhqbP38CWo5cToVTRSR+D4VHXV6rYg02rwiqUTVBbSEQWpBDX7p
 0jdM+sn7N/78sOA8QyOZaNfihxHD9C2DOfr9INT9Q1nQZfs0bCcUe8xDw2h30P2tkYK8
 VVgyDxP2Ox0MfMEEteUZUj5e8XUJuc7z4Zz6/tJSgjw99aSzCHaBhAfishhfOxIHsIDc
 ZWJu0YZ0S4+CH9QcBI9xEGyM/2LJr80QnTI/gV0bvzSGwTR+9fsHfp4BjBb3IQ/hI7hg
 hIecqDlOlwn+QxyQJHX24U3GbHADjPyu0xLTZftfGkARIRuOITDTymkGsf0ds5UOfaHV
 iPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315760; x=1777920560;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kR4KO50jdZd8//Zt2cnARbtQ0o4oMYRnBX3J0b8EqXo=;
 b=J/pljRLbpYfBhnZPJKMeEKKsLzPH/92kaNx3FQ5yJPPsiCytN6hfxnJ4RmJyL1Zmqe
 W1W/y/w3bqrC+rqprA7rFcbBOekP0A45V9XPSOu3HLSU0sB2sgAbx/5LgecA4GlqDnPF
 iHdAXBYx85U5XgVC7BJBizMLtQHybH5j6jx+c9y7BS9oh72bgLJ9vzY7dsFSbFduHNT5
 gdgPAdcs7EFcJSSvcq7lVrbIIcYuW5CeWqMrdBVfVA5MGojEMr9ptCLmJeqciqHUckFP
 dLrqz3SxjrSYryqWDCL/7JxymBavF9gZQWI6sxFqRFgajQjjfQqf4j2DAq3WwKP0+a8C
 Ivlw==
X-Gm-Message-State: AOJu0YyvvquBUOHUkoh+WWHuOBVGxFR+hLA44qCETKglaFy7KrgpZ/FD
 Hk98lqLHIPySZoDrlNwHw0DGk59X47lHrPxDPGXsp+0D/+DVz5s65w6eZupLdZFQB1oLk2XKYOp
 eiTen72gk/rZG3hZr9A==
X-Received: from wmqm19.prod.google.com ([2002:a05:600c:4f53:b0:488:a636:9e46])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1e1c:b0:48a:563c:c8d6 with SMTP id
 5b1f17b1804b1-48a76f53e47mr8138875e9.7.1777315759678; 
 Mon, 27 Apr 2026 11:49:19 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:49:18 +0000
In-Reply-To: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
Mime-Version: 1.0
References: <20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com>
Message-ID: <ae-vrtEundNmLEh0@google.com>
Subject: Re: [PATCH v5 0/6] drm/tyr: Use register! macro
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
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

On Thu, Apr 09, 2026 at 10:51:23AM -0700, Deborah Brouwer wrote:
> This series changes the Tyr driver to use the kernel's register! macro
> for hardware register access, replacing manual bit manipulation and custom
> register structures with a more type-safe and maintainable approach.

Applied to drm-rust-next, thanks!

 * drm/tyr: Use register! macro for MMU_CONTROL
[aliceryhl: reformat long comment]

 * drm/tyr: Use register! macro for GPU_CONTROL
[aliceryhl: reformat long comment]

Alice
