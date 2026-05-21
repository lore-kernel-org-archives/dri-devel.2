Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910D2CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EDF10E261;
	Fri, 22 May 2026 14:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oSQIwrDM";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044B410E18C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:28:19 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2f7020a928eso8607385eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779362898; x=1779967698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtjszhJJZ/cWn5ctRzPZFVh9lS+1tvhxhH2pqInaGro=;
 b=oSQIwrDMv/GshPb0niXz3KaMq6TstmGIr/WUymxkxjIrenYump0IZna2BljFXTgAzO
 Hc20YZX5GNWHfTpe1QEdqzbI6qoUTMpJvtriEsttGI+pAfP5aRwC2WLAd8O7bO9OTk63
 z7V4jGZ1++aau3zWMBNegYbp/u3TIx3a6QWJWuF0PNJjQJsgPZ+tlYUdCD2ZovldgCQ6
 C5Up57B/usqChhsPMVaV7YawI7qthOZxyKbyJNBgFFai5Ia6GZ/CKt1RQrPeofY8N7pf
 Of+0Oyw5xpUHjSEh42AXaugGaB9q3JIEIwfhg8xrHkYxlaGfJ8j0Uk1s8fbVVyd6G21I
 4A/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779362898; x=1779967698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VtjszhJJZ/cWn5ctRzPZFVh9lS+1tvhxhH2pqInaGro=;
 b=Nf6R0BuR/fQm6+JmUWKmFGtJuRrftr8KJWmKQ8G3KAJxjtHsKkGVlnOP4w6E794oqJ
 EfxTXNE3sg5XYb5OM+dhBpJysFcouEQgJfnSaEmtvKikXH644Rpe1DKLGyscZD/hfICM
 AK1iGhI0+/9+mSIQZ5QEnldSzBSW+Bc+w7b781mVFWqcSTp+Z8WL+MKJCNquijZzmnZp
 rIV0lCJvNFFilAH0VhEDikVie6mPtTexadxJTPLZx03bVgpCQn3mrozKLQSJBquEutTK
 9nApzY4tnANfGlyUiBq06tNvZr3iXzXCrWVfQDN8OlMTyP2ddb77s5Bov6ez8zBmh346
 YT/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Lla1mxhI7M++57QLXm4x7V4u1AVoAuGDZMAM5dtUmV9Dva/co9Dk1LAQBiIXMh582FMueSCIaiJg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUXJPEFrNuNQH7Bf3ZmnJ9ia5V7LAVSazymr9gzWjTuWAw4g+4
 XAA4xWubHqqJhJ12cv0ojOc0HYOJMvDM4WoGOLlpaoO7ojEp4ed6RMaI
X-Gm-Gg: Acq92OGl4dItLSsSA546jq52ZFD+4sTyvLwkk0TqRSJnXyq9IaoCZd0Ip8BDx5HHJmo
 siguz5ypjwnVoEcdcHd6U7zECLsi+xoz49P748fS5dZMG+n2u4pKAl3zxVbPwrFLorHDT40rFrz
 XwSGHqsNofYKOwOiKb5uZa0BwS88hM474uos6zOOMoFoGjE69pj/KTBqDF5GMgKC9vDaLFw+793
 DMWq0ifYeO6EbDyhKDBD12XUIEwAkvW1cCwPhaUoUeVC9PrW0gG/G0tL0a/bIQpe1QMrkEYw94y
 UOc0x25lnHY0AL8vmXeuDNneMjmQnhnFND7MgEpmsXk9ytf9oFmUIfZIfOsBBMYh6oXPRYIFD2x
 qkxoVE3oS3UUEY0AuYBaKtNUxLDDpxxW+XGABlnpQd3lkw8UlV76Zl8gChRdKEh38O47mn9SwQc
 HHudiU1YPNMjK0gG0u+NZHmI/ajkaSHv/ROowCcJ6I4UVirNb+iFg5
X-Received: by 2002:a05:7301:6509:b0:2d9:db50:c6a5 with SMTP id
 5a478bee46e88-3042ed45707mr1596574eec.0.1779362898201; 
 Thu, 21 May 2026 04:28:18 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435be3ffsm270167eec.26.2026.05.21.04.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:28:17 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: natalie.vock@gmx.de
Cc: dev@lankhorst.se, mripard@kernel.org, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Date: Thu, 21 May 2026 19:28:12 +0800
Message-ID: <20260521112813.62104-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c9eeee76-25a8-482e-9ef4-74971537457f@gmx.de>
References: <c9eeee76-25a8-482e-9ef4-74971537457f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:05 +0000
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

Hi Natalie,

On Thu, May 21, 2026 at 10:52 AM Natalie Vock wrote:
> Interesting proposal, but inserting sleeps on allocation is never a good 
> idea and doesn't work like you might think it does. In graphics driver 
> land, lots of random things may result in buffer allocation functions 
> being called. 
[...]
> Your approach could lead to every single 
> submission sleeping for at least 100ms, thus permanently destroying 
> performance.

Thank you very much for the detailed explanation of the impact on TTM and 
Submit IOCTLs. You are absolutely right—injecting sleeps into the charge 
path, which is hit frequently during buffer validation and residency changes, 
would indeed be catastrophic for GPU performance.

> Maarten's suggestion of preferentially evicting memory that is over the 
> high limit sounds like a better approach.

I agree. Blocking the submission pipeline is not the right way to apply 
backpressure. I will abandon the current sleep-on-allocation approach and 
focus on implemented prioritized eviction as you and Maarten suggested. 
This ensures that reaching the "high" limit triggers a meaningful reclaim 
action rather than just stalling the GPU pipeline.

Best regards,
Qiliang
