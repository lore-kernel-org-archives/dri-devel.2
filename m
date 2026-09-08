Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAD8C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0503110EAB7;
	Tue,  8 Sep 2026 08:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ku50boC1";
	dkim-atps=neutral
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE4D10EAB6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:00:06 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-939adff838bso115678885a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788854406; cv=none;
 d=google.com; s=arc-20260327;
 b=NbsHG8rNoI828hqQjHH7wirT4ppR9KW2DNd7i7RC84GSChzlO23PnyH5Em4nr7jZ/l
 2yBIsqlVY+Y9BajD5boFaQ7xr5zcnM+cq4Zq+Se/zEzGZEBoZBMaeB/8hcdQFLLKA5i2
 egyEDKSvqIuXJ9Jt1nxDZTHEGz9y9bCepzWBSNb6cHZrt0Hvt/3tlu0c7eJu6tgTacLe
 oaaQgGe9cc06kjAz7+2H22aOAQ4cnaW6R95FB/ZPtl4jY2kqKnWtRi96Rse4NJ0pYExj
 xI+dzM9UFGWsHuIQDbOF0LdsBl8xqlCL2mpTOvUl2IBRdjs/pCv+99wIeHL55UWiqPaT
 lSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=guaq+VGBE5xuZsh8TwFyvRdWEV5RQewzlTdQ0HnyLyg=;
 fh=eq3kMOvXY9vLmcFSrkfrVQDV7dU95r8dtQGW+JQA5L8=;
 b=kj8T2ouXUmYvzwYirHVWmFQrtD8/JsKHtZF3q6aHUyV8imXm52uKZJ2tFN+lvxol1L
 Qvzv3VnXOtaHjl4UiCEyYc1f2P9lrhYRQWY+IcLS1iw3yr8lYYpDmnXTl0c2XAamkq6A
 dtJQTC6qyVmtaIkfenOpwjocO0H5PfgJD0X5OJZV38/yoaOkT/v33kzjNfLnEoMcsFx0
 bFdlaU2UBarBRw3nLHdQIX7SUeF4KRWp/K+2X5xhXVjq95nwQnuRl+QaUTlDWfm53Hox
 Pu1tdGA2XdryS7rlm2Z+eKAmBCPFQs9Ah6C6+LxaBF/74cmbOS9iK+sfago/SDOCbcqz
 /t7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788854406; x=1789459206; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=guaq+VGBE5xuZsh8TwFyvRdWEV5RQewzlTdQ0HnyLyg=;
 b=ku50boC11UPwoG95nRqR8YxIlb+ihzUEUotnn55DkXGiCJKpNNgzHzJFn+lrBz5ax9
 AS8/34ksttcksv1i+oBlOa57cnWCkCoAzfjKJfk4nnM1eKrZ6fZEwJIK0vMurDlKfnxx
 H7oMYFEZNJ6Zx4jKhXg4XX5gPJ5gEkoIEQF4OhKOEnslxNwllRtBRhYcx9OM6GQVV+I/
 00izzIkqANTMkiD53ZNM6QWHVwlnmAYIH+xk7G16+YgGJwPBmNmor8sW9F82j8k8laL2
 LFSEpA9ma/C7e6oRUqIp3M2Vjv1XjKuP95K23ksdqqVWi5ZBQBgg2Qq77s8M1bIXG2rB
 G0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788854406; x=1789459206;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=guaq+VGBE5xuZsh8TwFyvRdWEV5RQewzlTdQ0HnyLyg=;
 b=KJs8AXCc4ebfvmvV1nvtlu9nq03K+SpFWPd43Qny/gZQx7WCyXAO4rwsnP/LE2IAnU
 yJGC9GYXR+GYzDRxtnX13kk8zFTintvblZ4Mxh4nz1xdNHg5SzkE1uBl0lJcCpnMu3RX
 1rRo7D7bacK4j+h/qclqVh4EUixOTiI069aKG9oVJDZyOhV0OfQnCVQW7tjrsSqlxOwN
 gx3ym+a4iiBB3OOBnuJ2qwR/IEtDdmsmKVEE2/TdlZl4Ks2UPhm1PAgZloKqrPifmE1J
 dnmfcUS7KJldLg4fzims/2Evhu2WUR7yDlvx3QqHvyCvqJjbqx5Ou6oWieKArhTD93rM
 lzQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXyirmsS6jQhPzhIJfP6Glk9iqDPv2S1/iOFGrw4MYrvgQ5GRHOgX9i9XkraaRj5rNpnwBcKkPJzE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPIsW8F5T1UiRq2nObpGixc0mJzS/zJ/Kz0/zyHAomoFJ7bdvq
 uTG0uDgLVl0RWPdDN+ZmpL5vz4BBDxDW1IyZAwJGqpNr5tKo9VO04K4komk5B7Nd21n4D3hGVFa
 cvBNEW5nsyV/tWPotFYwUx/3hyh1J/f0=
X-Gm-Gg: AYBFou2QyetOQX4/M3M7hVkm9J1Qoafza5AsYolKOF0sSJkv6NXDxytgsFaaJFwDMJ5
 g4nEkeH734ea94mbvaC6JcaIr23iXknAkaawYHAsL1/NYkgaJhwa0yEnf57ahxzyq8e7EnyF6jm
 CGSlADQs7s7rLEcEq97LPF8Rq/E7t6n8Hn0enXszKM3XmUu21eDSRB4zFjhqvJnyDlXPAaBAtpc
 l7Y75RYwaPUnozxJLmtSY1dSalVhJo7uRwChLhxTjxG1MMYDoWIM7nNGGq2477torXl4pDCYaY6
 z+YLI8ZIwknopFvqEJ1nlS2SE8xTMl9vo4fOwibzaDyk0IgW14II3p3Tt8xGYFR+e3j/YDZvejf
 xRtn7KhwkUec2DCajT+DoQ6cW8oOGY8a/nby6d8xt
X-Received: by 2002:a05:620a:8386:b0:939:6d22:6fd with SMTP id
 af79cd13be357-939803712c1mr2713471585a.18.1788854405591; Tue, 08 Sep 2026
 01:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal> <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal> <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <DL6HKYRXHNFK.1D9HYNEPH4GCR@garyguo.net>
 <DL6IQKQDXY7P.1F6PSERSJ64PN@kernel.org>
 <ap-vnh7KFJGJLW1s@nvdebian.thelocal>
In-Reply-To: <ap-vnh7KFJGJLW1s@nvdebian.thelocal>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 8 Sep 2026 17:59:53 +1000
X-Gm-Features: AcwNN1WfQW84CsExuRlle70Uv_VaeE2kPFpysKqrhKzJ84K5F_EcHs0pQw3o8S4
Message-ID: <CAPM=9ty74336zKWvS0BPVDnsczCPOPg_Lc0VsZnUfe8Yc=F1Yw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
To: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
 nova-gpu <nova-gpu@lists.linux.dev>, M Henning <mhenning@darkrefraction.com>, 
 Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org, 
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

> > already provides it to us.
>
> Yes, I did look into this. Unfortunately the SM version GSP currently reports is
> different from the SM userspace code generation tools need (I have no idea why,
> there appear to be way too many SM versions).

Here's an example:

https://gitlab.freedesktop.org/airlied/mesa/-/commit/2f0724ef6b739c26ebd8b0828c93c51b137d7a9e

Dave.
