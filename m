Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F44CCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E029113FAC;
	Thu,  4 Jun 2026 11:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="QDtOojWP";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 817DD113FAC
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 11:58:12 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-68cdfbad902so666288a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780574291; x=1781179091;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tsDBf51o8QHp6SAQ5/8ziLKktk7y3LjUQBohqdmyxqM=;
 b=QDtOojWP8WqmKQDlCXhLBgfVurGfjDE4QYRxSQHc5MpfyRP8Bdu3RaInbtDLXmZSU4
 fbJlLNliALWfvBTYH4ESf9QLUKx0LzW0fr/TIZR/VRWHinTdFFqZmg3YCM33MkbDUUTL
 tDVxr+BW//YGOiTppSzanvMcLAbF3yZ0ct/9z649eXwndSJBDTpnLmxf4pfSsFEad/Ms
 FHpVUew/kfu1ULvREtT3XeNauLAAziTm4hMVTfcD9PZEx1tvsPGUZ2faS6gwGeE6fCCI
 2ySilosVVklX1SPPR9FvLULoKq0avgHBap5dC/nDnUVgGsEnk8FK8vjNrwuqBfpKo2yj
 xGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780574291; x=1781179091;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tsDBf51o8QHp6SAQ5/8ziLKktk7y3LjUQBohqdmyxqM=;
 b=hTwn5LMvuJ8T0zPaSvm4SGT6CORjqbWfJDeqcCutrmKi5OQGG0Wju3fstE6Cm0GW6F
 rJ/CcY0rNEhN96HYDRlDj380wCdpgtrdZdaYjEmWD6QwCM0PgKnSEX+bbcydHGldTCV7
 vLMesiaeXh0tMCJsmXpEOCODMI33wqHGs5UW9xGnDhai0FDiWeQJrbgNDEj2uKEJnOIL
 kiRQjWyRggm9ZubAAlIVWO4iiIwsnyqkrm5Z4oS/do8lvp5OUSEs1JLvYMPb8KQ6Wahw
 oTfc/buo3p07UOmbR2CVbT5QM0rsvAWZpQeGVi3ttSWf7Cbl4oR3o8P6yn3bWAdCYmk/
 07+A==
X-Gm-Message-State: AOJu0YxczhNl/ygQDsx8h7AK5Hd2tnDJ2Bz/AE/1e+zVtzw0vvy9LIAI
 9j7oxrvPoiw3BY5AN7VLuGrGK+aCcHt8dCvFoPRPqJTXK4YxHpzWe0zkuk4ARCZTO2nK48af0II
 2VidbPlVqYbXSG4AhTQ==
X-Received: from edrm6.prod.google.com ([2002:aa7:d346:0:b0:68b:163d:99f3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:27cf:b0:688:1d5:44c5 with SMTP id
 4fb4d7f45d1cf-68e6f79352amr4016032a12.2.1780574290900; 
 Thu, 04 Jun 2026 04:58:10 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:58:09 +0000
In-Reply-To: <20260603195210.693856-6-lyude@redhat.com>
Mime-Version: 1.0
References: <20260603195210.693856-1-lyude@redhat.com>
 <20260603195210.693856-6-lyude@redhat.com>
Message-ID: <aiFoUauWYLz-Oyrx@google.com>
Subject: Re: [PATCH v17 5/6] rust: sync: Add SetOnce::reset()
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
 "Rafael J . Wysocki" <rafael@kernel.org>, Maxime Ripard <mripard@kernel.org>,
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

On Wed, Jun 03, 2026 at 03:42:34PM -0400, Lyude Paul wrote:
> This function simply drops the contents of the SetOnce, given a mutable
> reference - since that proves we have exclusive access to the SetOnce.
> Additionally, update the invariants for SetOnce to make it clear as to why
> this is safe.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

This isn't needed, you can just do:

unsafe { (*this).sgt_res = SetOnce::new() };

