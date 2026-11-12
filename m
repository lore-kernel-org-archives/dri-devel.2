Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DB606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ma5SSkSS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD1D10E3E4;
	Thu, 12 Nov 2026 03:16:30 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C2310E3E4
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:16:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2288031f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794453382; x=1795058182; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B1+ma03bcpp5acNonkpy2s1c2LTj/v5z83tVJvaJ6z4=;
 b=ma5SSkSSJNo+LGWNkr5vFUecMRdqZ4x55R7ZWkYg54XiFnGBdNaphsiBR14pJrCCi9
 PG5V+QZZixoAU62dWijhyXZF5zcUYFEATaWDxST9FE5nzU+8hREF6r1yVmYBdx7X0tkP
 kzKY5UhFh310OC+JPnw1sxqgRc1n9FKXFMyhydJP1pUlz7pUyXGVvbKyuuHDFwHcjqhv
 lhEMrcHkrpzl0/mellmsmaXUMGV2l1fDjaCqLsHZDz8zaQGoe3aqjhr/lG17Cj49wkIK
 dbi61XINiGb6ZKxt+KekDZpG9Nfbb6ouwjXIBqvHrvzJpP6b4+nnAJSckYmPwGxapqTQ
 HMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794453382; x=1795058182;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B1+ma03bcpp5acNonkpy2s1c2LTj/v5z83tVJvaJ6z4=;
 b=h1uSe62uaQySHihvYBpqT4TLAFhaSoHvzY3YVdRhoES3+du54dTQC/DCCQKvOnfoMI
 cO0Q450d5+f/QwGyBxq7qk1/Yzmm4UoqQsLAd7ZJYA9ZD21Ird8EAgnNUUcrIrCMlaXW
 VnJZzxAQJtK/fblTtWeaM+iZrWU8nVCYTlZF/WNLRZNL050/T81zcusiOgo8I+3wwREK
 iKj/LneURhAGJ4CrS4MziZE6iUbzYbDK3bbMK2x9XRD9QH3jSTxPGTskUsdhGNOX41GH
 FKPgR8x0mzvMBCawLlCBsqPUu8lC/f1urCdL/5NeZVg+BvA2i6b+vWVunBysGnfzyj+N
 W5rQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFjmknjov48+JBHkHv0xWsq4AhhGrL3l1IJ3NBhSd4goufaMPEEvuRNY96RYtP06Ob2JaWaO/eCn4A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9fT6SqDZ46SPi/dDVGIVuthr8Yl2/GK03+xPtD8nEm5e316PKi
 3pl6c7+2QG9c3OfO9TOMfx0YPnW+xTg+BfUIKLs5qmM2czNLaWTN8Ap7
X-Gm-Gg: AYBFou0dybQH9M2uQy9OfRXjtPMLpR6zw5OZe0hhO1Xww8K7fK8ZwDYn28io0oGlWqb
 UUaE57SbqvB42Hh/PIsxW+q8YvZLm6GXaOZhDl0T0/Tg5LsH7msScXqrRSD8yxyn5/S1B3h2GOv
 qMrO83qPO826k27Lro2uXEuhW16zNFYq8qVm3KpES2HztRNoFQUwKJeyYodAauIWRD5rR6ltZ7k
 MnSK+uWnYj9Pp6I9jInk20weuE2ArDdKfKDOIPVTwQXQLtJLhopJyDddXksXqNsawEBtut34p0d
 RN3kxkqIQ+XyAlXJ81qa3QJZ1cm37+ZbYowaxRuqoPpFq9HqKjr7FfHGQNRlsa9tSk1qetiMoXx
 5DEqv2eAWRASO1pVUySd2yKs6SSlPCxw6n58eHIiLZityXoTJ7tX0+3j59JMoMMyDqhQYMB7gFJ
 Q9XWRgs9OupqSIMDQCQ7f097jaYsg491eLmMgWserXDn/EkxiW1Ni8zAWKpDc0EmkeCCQ522DQk
 zCA9AJuGg60Foc631qyynJxt9zYJ5KmB7RordxIEdF0WcP4ojvjEzNi3Q3Pc9ocWRh+QU5LYBqL
 hgphMscPhR6vJm1p2YpA747tJbVVp3EIn9p8apCrwyT7caQlWkUuOkTBSNlqXg1AVWWR+z7dq6k
 z9FafjDwPUaAd9Ni2SGbezweBVQranv1kJpjpW/oH98ARX3n5FAYlMErFCPxYbrPYXyFSts9v78
 W4C6nR2bVbRl9/fdpuPiI94BrG0/2fqQ==
X-Received: by 2002:a05:6000:401e:b0:495:5c83:51bc with SMTP id
 ffacd0b85a97d-499c3b9ff3emr7370230f8f.5.1794453381449; 
 Wed, 11 Nov 2026 19:16:21 -0800 (PST)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-a181-4b01-25fa-1a8a-4f45-ba49.310.pool.telefonica.de.
 [2a02:3100:a181:4b01:25fa:1a8a:4f45:ba49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363dffa1sm13523836f8f.39.2026.11.11.19.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 19:16:20 -0800 (PST)
Date: Thu, 12 Nov 2026 04:16:19 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Hans de Goede <hansg@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, 
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] media: synchronize CPU access to imported DMA-BUFs
Message-ID: <avUvHGb4talXW7qS@gmail.com>
References: <20261107104703.44111-1-kmehltretter@gmail.com>
 <20261107105946.GA96745@killaraus.ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107105946.GA96745@killaraus.ideasonboard.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:59:46PM +0100, Laurent Pinchart wrote:
> Hi Karl,
> 
> We discussed in v1 how this is not the right approach. Why are you
> posting a v2 without addressing that ? You need to go back to the design
> table.
> 

v1 ended with two conflicting positions on non-coherent DMA-BUFs:

- Laurent [1] and Nicolas [2]: end_cpu_access(WRITE) only marks the CPU
  cache dirty, and non-coherent DMA importers clean before starting DMA.
  Persistent DRM/KMS imports then need a sync call on each submission.
- Christian [3]: devices must access DMA-BUFs coherently with the CPU,
  using begin/end_cpu_access() around CPU accesses. Importing a buffer
  with dirty CPU caches onto a non-coherent device is intentionally
  unsupported. Today cma_heap and system_heap sync all mapped
  attachments inside begin/end_cpu_access().

On my Pi 500+ with a USB UVC camera (640x480 YUYV) and V3D on CMA
DMA-BUFs:

- Without vb2 CPU sync, V3D reads stale data on 8/8 zero-copy frames.
- With vb2 begin/end_cpu_access() on cma_heap, zero-copy V3D is clean
  (0/8 stale). CPU capture takes 91 us/frame without a V3D import, and
  144 us/frame when an idle V3D PRIME import is attached.
- With a test heap that tracks CPU cache state and syncs imported BOs
  at V3D job submission, zero-copy V3D stays clean (0/8 stale) and the
  idle-V3D CPU read drops back to 89 us/frame.

Question to all: should I look at opt-in cache-state tracking in
dma-buf (with a sync call before DMA submission), or keep
begin/end_cpu_access() as is and handle CPU consumers via V4L2 cache
hints?

[1] https://lore.kernel.org/r/20261021175900.GG15441@killaraus.ideasonboard.com/
[2] https://lore.kernel.org/r/7e4c7707880e9092180d28484ecf674be29b40a0.camel@ndufresne.ca/
[3] https://lore.kernel.org/r/1e798600-5a76-412a-959c-94313629baf4@amd.com/

Thanks,
Karl
