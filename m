Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D98606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iRP2DrLH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A208810E89A;
	Wed, 18 Nov 2026 08:23:06 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FD010EBBD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:48:07 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-8b4d86f5328so1923907b3.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794952087; x=1795556887; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gWhTP+MsEZH11Xk/IKOvm1ABoNQtFuyWT71ie9/W1Ho=;
 b=iRP2DrLHguamb7gbYu3b9fVynTuXFGzKeiBfeg32Xmx+DjAx9BGJPP5l6SdN0sRIpq
 FhqBe146hkFHZrB2DcuME1+iTM+EwEDFA9i7OjCBOa4xlHULU0IjPw4z8KhzblJAxz+O
 Z3wBoaDzAPPB6xnIegHNzoCvnz2EnveMyBYdcwMMhS4L0vKJ6YvLFsIueuuClMEAqfbp
 bbTVhb6CF348Qz9u3f+yrKh8u+6nG7ro0pAotOk3BnXA8FJpKf6CpkUdsaKhIXQpnoPC
 xH9h653o3TLfZHqykFEbtTnH5mlpEj9CDGPH9P1jgwQ9H7hQcsdQhsM/qhj8NjHfvh+6
 nhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952087; x=1795556887;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gWhTP+MsEZH11Xk/IKOvm1ABoNQtFuyWT71ie9/W1Ho=;
 b=IVvehRGLFhXgeHinOB933Qo7dIqHw1nWrlKoIU0qtRDmRUoyDWo+3Ksl4PksO6bWl0
 +/hmjYRKxscCO34tkysMKxT0BhEje+vrsRNdcw/LcybAEeDyCT5QRSf3xkLE+Da3aBTJ
 NkObb/SwAUamUx2OLYEiNXi/h50DEiNgUK64MNPTcp41nceKmfnH7SqwxCccCqjF5khS
 XkZZGFt5hyTs2FMK2lcwFPF1AW3ss5PboGJ16qZvOWSdKQlM5Rd+etWZMruq57r0yB4g
 vjEwC1tN4N9GvAGxXVIU0DxDwEieC1Inwye4iJYVMr41HcyrVBZQ9A8COwEJbGavv8cx
 o16g==
X-Forwarded-Encrypted: i=1;
 AL+hErEb9WEvRhRBIctIgz1MOstnwgopG91uOrY3XdaAYpLIVaQnkP8/J9A0smlCzpnwl1PNE7GHJVyLlzE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+WawEJC0YuP04AkGfjQTpUVztWxJn/ZRbaSQw4RXpKZwD0fU8K
 2i3jwspfwrS9EK8a9s07pFr7qvF70oZTT7SBqbT525PuklVRguHYQclf
X-Gm-Gg: AZFdTZeDB/dBOlZpyoBVb6sbmO0Qn78NfnCOPGfwV55jeFqgJ/OZp10y3BopHPXaqzP
 mwCa8W16ii7g7cTt2wzUQeabCNpOsC40xoXk22uqB4gdJKoU9Q4JXBaehSEd25IRmPXsHlGmsKO
 xE9suHAbIy60ZdrIyGon+MihS3ro9E3vT41E+lL2C4UeZnqqEfh/BD9NHDmYJ5g1m4LhxWckBeh
 3MxqB839cIlJLGotA+eRLBCNpWrMyMwUcGj6rIFf39kvmIIWz7i+u62WaQqC/OZrRh7bbhFWi5N
 hYSs33y8TAmz2MoFDBcIeGJH3d0WWZxew5o/ZK386kX+91G3UEl+hSoN1Gz++LsU/mZratVtwSs
 Xe8Ra+Dk3Fv7XJBB2R1tCQlkak5fJ+S7ZG9Joya7khrT2IFoAzdeXJXDm0qa4qel2ofuEVGf6nC
 1cwgbdpWis1pk3j1Rv6PVGT/dD+ocrA/BZwFsxaJUm/DLoHvN05SxwLGDg5e3yaO19WpIZ6QpZL
 g5qDwtP4mraNQ4ZvmMP1a/VMlxlZGoyO1hUGzyt4xgy78KTObfgmmeSFQ24zfGsoDnd5fEc1IJI
 vGRRvE3LRVQeaqJciTySD8K6
X-Received: by 2002:a05:690c:6502:b0:8b4:e2dc:3f2e with SMTP id
 00721157ae682-8b4febccf0fmr3038007b3.8.1794952086607; 
 Tue, 17 Nov 2026 13:48:06 -0800 (PST)
Received: from localhost ([120.244.9.31]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4fe030a65sm7195267b3.15.2026.11.17.13.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 13:48:06 -0800 (PST)
Date: Tue, 17 Nov 2026 16:48:02 -0500
Message-ID: <19ceb44df3141049a955c2c30fe64766.docular.xu@gmail.com>
From: Guodong Xu <docular.xu@gmail.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Cody Kang <codykang.hk@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yao Zi <me@ziyao.cc>,
 Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 07/17] drm/spacemit: add Saturn DPU register model
In-Reply-To: <edd7ae1b38ebc687d0b2bfb2509c40fb8a45e625.camel@icenowy.me>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-7-327d7910bf71@gmail.com>
 <edd7ae1b38ebc687d0b2bfb2509c40fb8a45e625.camel@icenowy.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Icenowy,

On Thu, 03 Sep 2026 20:08:10 +0800, Icenowy Zheng wrote:
> 在 2026-08-09日的 21:14 +0800，Cody Kang via B4 Relay写道：
> >  drivers/gpu/drm/spacemit/dpu/saturn_regs/dpu_int.h |  25 ++
>
> Is the slightly different K1 Saturn DPU registers considered?

I compared them with the K1 BSP you mentioned offline [1]. Judging by
the block, field and interrupt macro names, I agree with you that the
K1 and the K3 use similar IP. But there are also important
differences between the K1 and K3 registers, which is why I would not
propose reusing these tables.

For example, the blocks sit at different addresses, and most fields
are at a different word or bit. In dpu_int.h, CFG_RDY_CLR is bit 4 on
the K1 and bit 5 on the K3, and the underrun bit is 9 and 8.

IMHO a K1 port should add its own compatible, its own field header
and its own backend file next to the K3 ones. What do you think?
Hopefully you agree with me.

[1] https://github.com/spacemit-com/linux-6.6/tree/k1-bl-v2.2.y/drivers/gpu/drm/spacemit/dpu/saturn_regs

Guodong
