Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4288C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D93410EE87;
	Wed, 19 Aug 2026 16:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bb9BiTYC";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ADE410EE8A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:35:35 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4957952e0f8so1441195e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787157334; x=1787762134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uRNlMwmCjbqHgtHpN1vZdEKI12CeBu5+r/vpcSQGSVI=;
 b=bb9BiTYCkB3YbFvQ9e1CTidC8ttQquFUjSJaf+FdVlZ7htg6Yhs0QFV07BnFMdUpr0
 2cUEOpxRaka/d+/xlyvUMMgtw1P31/XV6SpTJhpcyzYRSD+19JrNFNsWo7Aa7T9mLo4n
 z1w3/bEbn0Qu6MVG+YcvNjWPkG1X8qWRodkQbja/PNeNrhISxLH+Szj6rFBfP2h5ptyB
 znf0yMEflm3UCSehezH7y3yRbXp5ppZFjre5Q+tm7dsrDo9sDynL6ykK2atwKp3gRP+N
 mIuAmWufqS4gNEiU+7rnZWNBgbfDO2Ie/6l5/s00AxbSBcCpJYj8XzOmg70XMDCUlmpm
 B+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157334; x=1787762134;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uRNlMwmCjbqHgtHpN1vZdEKI12CeBu5+r/vpcSQGSVI=;
 b=I0izGAFwc0f/j6t4jMM5HAJEgWQ701yKzTE6o1fOprxFDHohGV5/JjtBpkVxMVATjC
 A9ZGoLiH58PHRm5TwWOuQR6v92Wd2OdHI1cwxWYK6K84MYwqXLxRdcJNeVOWK/ycWMWg
 Wywac15kdK/RNLDld3/RCZdRxg5WSs2bsGOzOm2FYM7zIofLWNW098ziiB4OD8xb7R9Z
 p8UBs+ippmBDWkRWK7riNATixJ2d3cpcdcBtcVG+200oBY7Of21JsfsIiLbWxQgb47dw
 YMkYyBClyeSZRzq1o7qPO3oKB3msJAIP+tArt6rFSELSEKIy6p86ru3FDvHKUqTTZTNq
 yzEg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBt5FFcgD04me3+KyK8THf48rFQX3xETgkht+AH/tHN/HmZ+pNQh5pDINoAei62tMmPpGM4ScTKVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzELuWq+4FyQCJBdPOOfzibg2ddGNPRAC4DKLcNSUMXKv66+dvb
 QiOx4RGDt1sqNmXgWFwE4iM3UoxLBaJvBx8yTdc8eEd05ZhebgvsgwJ8
X-Gm-Gg: AR+sD10CbUp0vYStOgzIIf2RWhEQNokLwCrLJuz1iSSG2RTrpMyxrnHd3C6W/0JkVQt
 Mc/dBeOpKCMPvcJ3c4o4kgq7uv7bCRYuB/sP8r4zkd9gSmSSeB5YFsSaa5mQd/lnNHzZOH+Tw69
 X9diV09heqoZS+qY7Ip50u/9j9bFbi8b13PGU9/7pXqCBVrjKHnN4E9jxBiDT8PUyx8Zi6KWDRZ
 oyCFJjry7aobpEpvB2RLoY/MfTErftNoDsi4zcNv6l7JpAt4Of6GaUze3NuBuv7kl5tGZVCtjUc
 k0uC5NyktmQs8Wrv1JvzbgpBbR3xoOxL54I3I2Cv8iALyRmeDRmrC8w68EFedEBD+IqBJDswf2F
 nhePIeSsJGnrahZjOq/+q40aBj0liXROvd6WlcfyloirP4+oxWxaorSbTFHDw33VNx2jKe7G/Kh
 vWYbvuM/DEGq7ZL8D5opYEmKFRpXcgxO6d0nnyWNVfauKYVHmBLqcuYPLX3J3WwWJWHCPPn2O21
 vlIJvD30ky2sapmiCDYgBA/SAam96JVo9oFg5qkmjWfk1bM1VULuy2edh/MKotFvZC2c7iP46vd
 F+Qv
X-Received: by 2002:a05:600c:4f4a:b0:499:59da:12b9 with SMTP id
 5b1f17b1804b1-499aa0e0f8emr68914225e9.0.1787157333638; 
 Wed, 19 Aug 2026 09:35:33 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9296004062FC4B2781498E.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:4062:fc4b:2781:498e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17e241sm63656765e9.12.2026.08.19.09.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:35:33 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Markus Elfring <markus.elfring@web.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] drm/rocket: Check allocations before use
Date: Wed, 19 Aug 2026 18:35:07 +0200
Message-ID: <20260819163509.5743-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
References: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Triet,

Ran v5 on RK3588 hardware (Orange Pi 5 Plus, all three cores), on a
tree with PROVE_LOCKING and DEBUG_ATOMIC_SLEEP enabled: 30 sequential
client cycles (open/submit/close), 10 pairs of concurrent clients, and
a round across runtime suspend/resume - 45/45 inferences bit-correct
against the reference, zero warnings of any kind, cores returning to
runtime-suspended cleanly.

One honest limit: this exercises the success paths your checks guard;
the allocation-failure branches themselves I reviewed but did not
fault-inject.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, functional,
                                                 # no fault injection

Regards,
Igor
