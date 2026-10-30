Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46433606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KfhHfXEE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9390A10E4C7;
	Fri, 30 Oct 2026 00:32:23 +0000 (UTC)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130F91125E9
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 00:32:16 +0000 (UTC)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso63793a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793320336; x=1793925136;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=lJPkDhyAkNjmbSthLTTE4/n2dvLRSQqU2uvMVXVTtz2xXJgBKukNdE13qrF61C8tzQ
 RYDdOCH9ozwVvFEso3/uxJrU1wAC02AQpmxXUzMayP3qi+jMM3ye0m8smR/2CJ3AURDd
 R6YrMqw8Y4SzQ6BCNC8rFUjA10okf5m1FEb5d0HVETcXD3JlThiAW5eeMzJkRQQ1nSyW
 sk4HvmrdQNHAedQ+lwQgiFcQLJxMz4hA9mhOWhJoynVXZLtQWj67Gyy9FFs5sZvTbvOR
 GBRay0apcxtoIYWlFa3VIznqnWMX9uOjiTx6iZ73qUVRw7/u4voQEPWbwk1gnFMFdRyy
 bEVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeNWqKGkq6AjWMlcUfYMjzMoVjfCTYre0PFmar70grogf1t2yJmrr08bXW+gcdgYIOJTNCxlnlgzA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjjVdAH9J5fVFENxTHXi75rc1oj3VvURRktD9pVmdx3RjLF13R
 GISy4CYHTJh23Y4wI0f8UJ4zeE/653RiyVJPJtACItCWQKZOzRr2c289Spm0G3Ya4Cwb1BqmpIQ
 LJLJMqnEZl591RG81fxxEk3hHOPuQQYbrUvKZd5ytjhL5e56rZx1o0kaCR8wwSYcFerCzTXnICK
 CxPPGSq78XdE/VPwvmBlXaq0bp8YbJeLnubX8cvYweYi4hBJ3DVEhoSh24OmOL6QUDC+cLj98Ad
 m0Tix6ce2HKUCGijHCr8xkGqWoI
X-Gm-Gg: AYBFou16LUsvrDFCRM33mTV03IbTzB19aLmp5EbZIWzE3s32VHCEWs880ACCfAJFs5C
 30oT5VFhJiC7tekgs1KsasBI4wD3uCBxXOuJOVC+54GWvp9LKOvqu8omoveHywlTp2a2NVcCHBN
 EmB3eWTT18zxRjkY7RCOz6j5JZVF57We3Ssx7RRHXiAAT921THCu7YmvCcaIpKpG4rXFQ77/g4c
 rCFUK3jY4xZKL5NVZZZDaWhx4KDOgC9pQ2rwuN2qpL5iW6afVpQbPiKozygNPwiZobG7BPwX1F2
 bF9kKmwUiiAdn/+27gwx+LJKlD9ZFPzzkkQ7iwMl2x6557hkYu4AHztXMKEEkgoOL0N1b9b0Xbu
 JY+EXVzNeu5IhXRFD09Kh3sNP8G67B++08av8mrexb/NJVPWLwe6bvl3rltuzCGve5iWKJpxBUf
 zEZE2bHy+OXrvFocIMXu/LA67eRra8Z9jiiTJ0dvEA
X-Received: by 2002:a17:90b:2c8d:b0:3ac:b048:fa13 with SMTP id
 98e67ed59e1d1-3ae8987e32amr444703a91.67.1793320336192; 
 Thu, 29 Oct 2026 17:32:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae85fc9450sm319963a91.2.2026.10.29.17.32.15
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:32:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f13c143c8so21929785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793320335; x=1793925135;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nfv6FKqQEehlYO6PakQvy8xnbRMYCGdZ1UXiFqagoN0=;
 b=KfhHfXEE5dmPbiaDJIu3Bu3xvq6PA0JtvuIWUU8Lav085wAdYodOW3rzd5KYh2L/dg
 3mGUXq1+eBSUmA5ZG50bLJXMp8Mpwo+IbYHOq7SzCRO6dYDqJS17XSYRUYkU00D3RI8g
 CbSppUPY4ETbmOKrZJYsnh/S0kUGorMp3Gabc=
X-Forwarded-Encrypted: i=1;
 AKwUvBzqqUlhUS7QbUzb7GBFItxNd/m1jFUJ0Q7zwbQBiUFPnv+cj8+obkb49OvBg9C1+4JC8IdRvXnuGNU=@lists.freedesktop.org
X-Received: by 2002:a05:620a:470d:b0:93f:1936:b206 with SMTP id
 af79cd13be357-94421806bccmr157804385a.83.1793320335068; 
 Thu, 29 Oct 2026 17:32:15 -0700 (PDT)
X-Received: by 2002:a05:620a:470d:b0:93f:1936:b206 with SMTP id
 af79cd13be357-94421806bccmr157800885a.83.1793320334561; 
 Thu, 29 Oct 2026 17:32:14 -0700 (PDT)
Received: from localhost ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425a8e035sm2896785a.32.2026.10.29.17.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 17:32:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 17:33:35 -0700
Message-Id: <DMHR15GMR99A.UXVBKXLO7PNA@broadcom.com>
Cc: <bcm-kernel-feedback-list@broadcom.com>, <zack.rusin@broadcom.com>
Subject: Re: [PATCH] drm/vmwgfx: Remove fence event code
From: "Maaz Mombasawala <maaz.mombasawala@broadcom.com>"
 <maaz.mombasawala@broadcom.com>
To: "Ian Forbes" <ian.forbes@broadcom.com>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.17.0
References: <20261029165417.249123-1-ian.forbes@broadcom.com>
In-Reply-To: <20261029165417.249123-1-ian.forbes@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

--=20
Maaz Mombasawala <maaz.mombasawala@broadcom.com>=20

