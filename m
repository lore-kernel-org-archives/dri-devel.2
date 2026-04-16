Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1B0F88092
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848BC10E81E;
	Thu, 16 Apr 2026 07:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="LmT4VTtK";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB9410E81E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:08:20 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-66e2f867f97so8833395a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776323299; x=1776928099;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=jl2zYP8ItHo8A1Pr9lCgwMtrzp2rEjUaJnpjqviDWB0=;
 b=LmT4VTtKac3ErlJMdFV8lAPOkG5Nsw9aGZMo+CBVzvZw3mXEHhU84A30LhuHfKyVwl
 +Z+f6rpE7ia6ElepwGXKxWueia6+47V/COkBZSYY2tY/I5kDGsqs39tXwOhAwYjfkD1L
 ECxzlaEznAmS2zj5wSsTIJbuzqE/nQPSnL17KHaro3jVujjBiBUV/H3HHKjKQZiWg+Ik
 JgRHa5S+yvqOjdJARh+SH2gIT9KpYohpQwnnleUI6K0HtXB1bwTw3/YRyx8P1DwTm0R8
 iYqRt0imQAMN8aoW4hP/X1ul50yUve74TvDeOWOLFlT1/QCp9nwoJ1Ww4rw+Hf8jcdvf
 twAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323299; x=1776928099;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jl2zYP8ItHo8A1Pr9lCgwMtrzp2rEjUaJnpjqviDWB0=;
 b=CvB9yEa0ATcQWtvh8MlVYN56FRI6BiI6sYNRF0on+tSeM5xfxtD1D9j6tN4zuL2sXf
 vx+PQJiq4JU25ZPP2lCKKcUBZ7iUtOVkimCOTPZ1ZLEEDKGjA7wbJoWKlMcTIUi7zDcn
 oDIgvvDkym6MIXu7yvUeOJRPV7ecpgKbPNmCwOADXGoxJklcKjB6c7Mq4IzLnvDwRRHF
 IetvDjus5xaYasuTJSgad0n6GA5Mh/h45j4Iu20yG7hPMtsxJMm52ZfLM71uUzaWfCm5
 t3TV8CqYR5WmzXQyAJ2ivjrYIXok3R1MRjQTGcnXR7O5uqhZ3kRVEwWcdTg+E6J0gOPn
 ErMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5VmxghEg8T0k99mCwJdq0QByE4oyXUyV7/awohnlcWblcSAKgFYL7IkLvFFBX5tO5/tS8jc1s3UM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLT5GXV0Uwf2wDxqKFXsjQSz5SpTGliBHONbq1rPKNKWcaMdmg
 ORGk1YiwNCqnnQ8EkZVTZpJE0BtHG273LHD0LKgL3CyDRVbb1H7HT3KlUGHBFK886ifOWhESu49
 4D069RT9o6AVyHZwAKA==
X-Received: from ejdcm6.prod.google.com ([2002:a17:906:f586:b0:b9c:5eae:2e29])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:86a2:b0:b98:7e20:b25 with SMTP id
 a640c23a62f3a-b9d724c8f5cmr1366009766b.20.1776323298770; 
 Thu, 16 Apr 2026 00:08:18 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:08:17 +0000
In-Reply-To: <20260415-projection-syntax-rework-v1-3-450723cb3727@garyguo.net>
Mime-Version: 1.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-3-450723cb3727@garyguo.net>
Message-ID: <aeCK4cLHsM7jbWEl@google.com>
Subject: Re: [PATCH 3/5] gpu: nova-core: convert to keyworded projection syntax
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

On Wed, Apr 15, 2026 at 08:57:14PM +0100, Gary Guo wrote:
> Use "build" to denote that the index bounds checking here is performed at
> build time.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

