Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2440C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 04:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA4A10E38D;
	Tue,  1 Sep 2026 04:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YDrV4kOc";
	dkim-atps=neutral
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A2810E38D
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 04:50:44 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-90e8535619bso23657876d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:50:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788238243; cv=none;
 d=google.com; s=arc-20260327;
 b=E07poh/RL3RHwX0t2B4KJjafXPeKodHpisvGkD8UkA9sNWzlQgjF82bjETu0kfhGn4
 22FbqrhOzHZS6Z8MLKQYPdWNFg/qE1jv75IVR8kc/idGA6aqKvfeDyZZl/GWZOHc830X
 5lvoxWYTjKyrBWQU/sIOWIw2EhPqH6Z65eD3PVukW+H0SVPkKHgRijmh5BgsdCkUjgRb
 MjFlOd+Z5IIyP2YRmfkbahpuOH4oWCv12YWoeN/pIQhs6aUtXa4eFoP0yD9sUt1knYFo
 tDVyI0LGdEkdkEt6KYwd+rCCiagedCfNZkmFcuA/QuaWXAyRZxbBCs9DdAHfPlVHEkJp
 Mb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xQOAFB2GujcBxNli5xeMXaMaXjpMEs7ZhLyYYxFWIos=;
 fh=4gqI6t5d4PZz23CjjtIdhJqK4wIPwLkncv7y0vCQ6Rg=;
 b=FHxtjN6CRq5Ir6sICeR07xM9cZeoABalC5RV7D/p42Cj4gb6V6dzrC95BRfxD/c3FY
 rA0QOqjZsPjJtF3y8J0TesREGGuBFK+1iMn8yb27sD3+7KyHGNBAnUTqH97bixXwZjDB
 LaYqYZy/2RmVslVEVJt1PHm3jfE9HP37MVa3xmjlTp4K30L68mUbSJJzJ1qR4XEV+e2I
 3maLSs4pzDJy5ut7gq4orz72bDIwJKpUzc1Xcn50p/yu5zDyyyWNOu5itfwoU7zfXnvP
 74oFg5qAdbiSZSpn/sOHwpWEaDTLMgPHR/gw86v8IYoWLLRMVaUHz4UCmvkaX6s1AQE8
 J6DQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788238243; x=1788843043; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xQOAFB2GujcBxNli5xeMXaMaXjpMEs7ZhLyYYxFWIos=;
 b=YDrV4kOc4zBwNKrasUT3kJ6ALKpwB2ynCii2uiHE9wmTOCHJ6awpEPYKvFMN3fff0u
 Q+VJHPQHgBQsc5d1aF5T6xLi59frOiSKW/LyXWzDXxaJ6O0O9tfs3mCNaVrRwSpmZL+S
 F85sVOcrUc29vMuJ1tm5GzHYQHdw/d7+c5jWzl7586HKxzQHQvFIfXaYAPOo79M9W+kt
 66CeGr01XzU409pUgrBuuUpU6ImXqZ/o67Ur4v49Wl4msmxhnj+hVoEiB4ElFDwUFKX8
 LMVrsNUYOyMeRS6nCZfHcaa5Mfps1tPeZaJ6jS/AVWZTqpLwdw3iZsuDDZrRBRcnB5ng
 QC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788238243; x=1788843043;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xQOAFB2GujcBxNli5xeMXaMaXjpMEs7ZhLyYYxFWIos=;
 b=pf7nbJ1q/kBLYgb+2tHjJZHczcKbLSrPLi2CCxtmEsE/503pZVkRuciI0NM0XNdaub
 JPO8qHHpLcPDUpVNbA1WfJE5FEcxFRkdDj25aKQfAx30ZqDUhVqHwNG9/D2Cre08lYJp
 Th5zBb+IB9nsCklND17jTfVM8zTBfnLnC3giZPDuNPY63lRM+uFoVqHRjxcb/OPctNyd
 8No7CdRFUWZyiYUZJ7iBCD93HaciojAaItE0Dtdn/xka0+dRuA4gxbPT7MWli+Opyy7W
 KyHTDSTmQFEXxeRXkPuBV8E//Es3DGAGCLKqla3S7AY84d3zQa33vHyRREP/Nx9hJZce
 GaUA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQxPlMWKfiLieveD64bx0NV6/Fz41cmPKQRkbI2lp2M0xIUzKiujbNR2jYfRHR4cBcxHO5cBDtFM0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9nLvPX2TAD6JzXlV13iQYqe7iEn/7QETT+uuVGcAbkj1gSAWi
 oXSIbEIyMbGEAPNYNpdGNwD7EWgdDhlj8PUJqRi8Y9EfpXWu/SSgTea8ccOd4/oHgxCXBJzaDMM
 Z8dI/F0iEj4quhntV9VGgzVwaZiQ8dHY=
X-Gm-Gg: AYBFou09Ixt3kdtgI8Qns47VEzne35PeTZUj00WesXs4OJE8VPyj7At0u9ro9m22DKu
 D1ulWL84p1182HsuL5baGLvoD9mVdfTq6sT1GoWA525umRIHUgJa84zOHN+GRoffRBtc5dHIxkN
 RqYYFaYQATOUP8aF/30/HrlP30qk9ComPxF+GBZ9c+FyipSee3ixanFbP1RErj0jlowt6DK3oGg
 TApbl+DorRBsCHJ0Jp1WWxLB3wzQF5mwXhPzcnDkmID4vVGoVYoWrMg0+TdMKzJzPVjsTYzblRJ
 B01lMfTy0ez6vkWprqokV6FxHvVHr6ajW+0hzI8PaY0Kjr5lNSHz0tkAMyJZOiMwmgM72vqy5TJ
 7UK7OsZPeRI9CkNLalt7TP9ThMtnQvQ==
X-Received: by 2002:ad4:596e:0:b0:90c:c53c:a032 with SMTP id
 6a1803df08f44-90e9299d230mr66652406d6.25.1788238242750; Mon, 31 Aug 2026
 21:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL373JA1ZANX.21L51RTEUQ2UG@kernel.org> <apZCTUYiN5FHCkCm@nvdebian.thelocal>
In-Reply-To: <apZCTUYiN5FHCkCm@nvdebian.thelocal>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 1 Sep 2026 14:50:30 +1000
X-Gm-Features: AcwNN1XIuYNBe-g3Y3LazWrOuydw4Epc379VZwO4H3KcbFvHD9yFkSuEhDJtL5I
Message-ID: <CAPM=9twQxnx5DDkjwXWi-vXM4kqUQQdPaL+=1ASS0tpf2GmnYw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
To: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

> >
> > We should make the NovaCoreApi just provide an accessor for &Spec and make every
> > subsequent method we need public. Otherwise we end up with endless forwarding
> > methods. We can also add as_raw() methods to the specific types as needed.
>
> Ok. This is where I don't have a good instinct for what we think should be an
> accessor/forwarding method vs. where we should just expose the underlying data
> structure and required methods to API users.
>
> In the past it seems there's been some resistance to exposing nova-core or gsp
> data structures like this which is why I added the forwarding methods. In future
> we're going to have other data-structures that NovaCoreApi will need to access
> so it would be good to understand what we should do here so we can keep things
> somewhat consistent.

We can expose structure defined in nova-core, we cannot expose
structures defined in gsp bindings or firmware.

In theory we can internally between core/drm but I'd really really
like to keep that boundary as the limits of GSP for auditability
purposes.

Dave.
