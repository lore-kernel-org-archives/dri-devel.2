Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE970C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA69110F273;
	Thu, 13 Aug 2026 09:43:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rTxGvrnV";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB7A10E426
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:38:23 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b3119957f0so936345e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786545501; x=1787150301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jad1CR0C8Q0HksEqx6zI+IQmNo9dkOO0wB0n04Xx9DY=;
 b=rTxGvrnVB9/fFBLZfKSrBvAOKBtfXSJBLzEcScXqGvJVcNpaFOX1/AQGCnrwy5ITeN
 I2MQdz7lD/N2CN6+EC0KsYqOKT6XQQwiNhkqxkLDRqE6aq8jW4aqtpE/0tYOXme3ies/
 EmT3pEPuXC0LMvz6YxSLWGzESxV0PVdOmlz/naaFLMiNWEqFU3XLzPPTwjYR7GSpBsBp
 +NnBuvxFZtl4BWomnt4MJSt/m+NNL2M5tLELvEtfd5mBgdtJr8vA+HsKHXDQIyvZkPxr
 SnHsLj3JMwoDmmitnnhE5mPcOZ6NPMFiYt5bvMrQshj+vtlh/7fGw0lPEv0eRAJdjPMp
 7UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786545501; x=1787150301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jad1CR0C8Q0HksEqx6zI+IQmNo9dkOO0wB0n04Xx9DY=;
 b=LVby3HcZpstZ4I91nILRsC1s/tfLjQl/IMx4QP7X1z001yEeGfXym88URc130P7q5N
 HEzJTXtNIRDumBXcWXcbwD+6GP/DI9Qhzwbqd26Gjfy/B4mDv/IIY25lE+W/nP73ld6M
 yjkGYLBXemmwE62BU1quC+nLECPd9JvmXBLLFbR9X/xzmCcnnd23FLmCmqA0o+LqEpJ6
 hpZ7UBUshvCurW68hEqypfZtBW4Gyu5UJwppjq2OR3OHKc7x6UuxJ55GyVOAxOJ7dRuZ
 WyqdF619cEUywBYpEGQLRbapR0UBnaW63Yw1uP1gNbGWlV8kYzUbPINrRhmPB4AbWYco
 y2fw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+CP8RkEN8GJ1hMlt/Z8Jm8vcJ97RUg4iGRKAnXer5lsIKYJtnq80UKR6RQUOZP1vtDWIYO8aCoOg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo1zjGcGKlAeBqR216T2EgwJ0uSaAm6vSifa3iv8T+weubfh3f
 HR10vrgWoyuzdOr8YyYeOwKbRt4H1dKG4qzHiRJ9ZaDvF9pdXMi1bHcZ
X-Gm-Gg: AR+sD10PL2oFzu4NT88TIPEYftTnmFbJu4/GmF1wAz7aF4ClhMdtnsen7IDYqMSP3N3
 7LRdsGYmY0xX0cvwiVE1vRX37t6zKSeIiF09UAe/3o+2aE1sJDNYSp0/kev639N5/2BY4gMkEKu
 ZAgpozlXo9zGmmV6lSpN6o9fTb58y/G64TGhyrgQsLXr/+3vA2KezYJ5+dwNSA5fB+yB9kuiwjH
 qdhFqrv/ZZLaen1WdG8JycBSQTMDCXW+TF/tSVXh8YJ9fcaO3zG+Fc9KI4xi6Lnndv+uF219zG6
 K+LQIau9Oj2rLLSLpuTC3MD9g8s9UM2rb8BAo/36hPDwDOBG4b0VeAfeckDYUhqsEjx8FW/Z7dW
 Ulk0pIzk1WXqmdVedNIn883gmD7LFk0fsjWMBS87NcfXa0eNo+sNqkSx7wD5H/6hYWSQKHyjrO0
 bVwnErRbs29+h42FPdd9v1wuQUM3bBVzmSCWMWUaYrh6JF8K9sXocMEaIbZJnubPJEI4w=
X-Received: by 2002:a05:6512:3184:b0:5b2:a68d:2763 with SMTP id
 2adb3069b0e04-5b44e0ddffbmr1014753e87.12.1786545500989; 
 Wed, 12 Aug 2026 07:38:20 -0700 (PDT)
Received: from localhost ([95.190.110.153]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b44d024bf4sm564235e87.43.2026.08.12.07.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:38:20 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: gary@garyguo.net
Cc: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Date: Wed, 12 Aug 2026 21:38:19 +0700
Message-ID: <20260812143819.1330350-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DKN0Q8TTO2AN.1FSUS3RCSAB2U@garyguo.net>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
 <DKN0Q8TTO2AN.1FSUS3RCSAB2U@garyguo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

On Wed Aug 12, 2026 at 3:00 PM BST, Gary Guo wrote:
> The abstraction part is being upstreamed via tip tree, so they're not
> currently present in drm-rust.next. It'll be there when the next
> backmerge happens.

Thanks - I only looked at what is in the tree today and missed that this
is already in flight. Then there is nothing for me to add: I will wait
for the backmerge and use dma_rmb() in snapshot() in v2.

> Sashiko is a patch review bot so you won't get any response by asking it
> -- although I suppose this message is written by a LLM too.

It was, and so is this one. The patch carries
"Assisted-by: Claude:claude-opus-5" for that reason, per
Documentation/process/coding-assistants.rst; the sign-off and the
responsibility for the code are mine. Fair point on addressing the bot as
though it would answer.

Thanks,
Vladislav
