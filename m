Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33359F88092
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DEB10E81B;
	Thu, 16 Apr 2026 07:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="G4TlGwnr";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95ED710E81B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:14:33 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-6712cd7ccb0so4651218a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776323672; x=1776928472;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GtvMyyx9perCSSdK6F2JuwmKCFC8HVERv4ogEceJbg0=;
 b=G4TlGwnrAPOp/UZjgsuPG6u7TNaSI0dd9/s+OKoMuoWV4HyNH1XnZ8AzhJZnkkztKn
 AMDEaM75bfGGScX1WZ0bPXLIw1m6L5lfE9elUpj57m26JRIpCY54qIO2Gbw8PlF2hPll
 gN8/INzPJ/px5ZMwrTjSFIzSQGENJ77i8TkbF76GExLPnUG+ZdAB9HUEtu/5wizv62/s
 qwE9QzDOUP+rPpIKGAbJ6Zg5a70VGCsR0vIr/IUOVfvIPCytPKM3nTJcyL2duAtv84f4
 2b7urShoZTr4Ry/Bxp59NILYlMQ4aWpgFOGTMEfMHN9RPEmjHBdDLHv95k1e9DAsFI0Z
 FHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323672; x=1776928472;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtvMyyx9perCSSdK6F2JuwmKCFC8HVERv4ogEceJbg0=;
 b=LTKHOeJSfKD8htkceswE92fECPtn26xfb8+TMp2m6b0ibP0EeK5zibyK+razJFQqZE
 vDI8+Kxb9bqMzHVYiUHhiVs89kr2NoX9lW+/URaClPNKvHJ2eJn2jpaoH99+5gjBA+8n
 xocbJskKQeZxCqN94WbzRftf+tOc/XsAbkiWDzNL7ZTbTcJ8f/Yy+ZOmfGJKyu4Ncbom
 jW/rJGM6b9sqQ9nECaPKy99T3PKooJq8tg8cNp51sCu4x1h3LEBgaUWPJz7jsXgasRrD
 MqiaAi2LmUgQsWnsCKble9BIFxwFfi994y9ZHMxPOMxwp7Np53RW+YvuMIGIcED1aPbB
 XAHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/S3GyxfLmKmot4SugcBiqsFN4qANhYeXYHq6J6MHPPIB/OsGZP8GT4vO0ul3MIXQEq1HUoxArgIiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfL69OENM3HqKehY5tZkyZ60JbHtopDls9A6n2DHpEegUJ9i6S
 OHoYaieIcfAJ49EFUNMJKRPJz6VO7/126uZQU3TdxzqwQv05yTmy8ZbzDwIMtXKXACA5Vjb1NwT
 ZWPQ6WLgv5hgeqYZfMQ==
X-Received: from edwo26.prod.google.com ([2002:aa7:dd5a:0:b0:671:2fcb:edb8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4544:b0:66b:aa56:ee5b with SMTP id
 4fb4d7f45d1cf-6707b1067d0mr8867411a12.28.1776323671860; 
 Thu, 16 Apr 2026 00:14:31 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:14:31 +0000
In-Reply-To: <20260415-projection-syntax-rework-v1-4-450723cb3727@garyguo.net>
Mime-Version: 1.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-4-450723cb3727@garyguo.net>
Message-ID: <aeCMV-5V6__ptj5N@google.com>
Subject: Re: [PATCH 4/5] gpu: nova-core: use pointer projection for command
 queue code
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 15, 2026 at 08:57:15PM +0100, Gary Guo wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> This has been previously attempted but missing compiler optimisations for
> older LLVM versions cause build errors. With the panicking index projection
> variant implemented, replace the manual pointer arithmetic with projection.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

