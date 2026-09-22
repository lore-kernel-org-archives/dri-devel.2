Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011A9C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A89110E44E;
	Tue, 22 Sep 2026 08:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jmrz/OuT";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD72C10E44E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:12:50 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48436686a40so358050f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064769; x=1790669569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=60x8O/YrRot0F50Ltg76B2oYgHHgxNBmBw6ELDymd/c=;
 b=Jmrz/OuTRuqkJPux77vMWUMEywfjvF/ISPDLq/C71ynKqz+I9N7y4yaTiipacFy0Q/
 qHW2OQA77oaTTSIIHlg92e+L9k4zdNEY49W+Yxi1Uan7Gab0Fjr8jbD3vZIDcGAP+Y7F
 l4g05dHaGEVnw/1nMAlorQcnh2O5VjVeT22jGVjymlxwAe3mZd9HeaGyfIjvNZ7H0QKf
 Sp9KNiWcdUAEuEt+zwBMNwa1MgfIxfzOsU5ha4+uLya4QfNYbzySBIW0qbhGF6aTJZKn
 O6qXCwEHAzTqVcwqFo12NkePVejM6YFIBizp+qiDRArYGb/oId2H0htJeB46Mp5/CvXa
 9/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064769; x=1790669569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=60x8O/YrRot0F50Ltg76B2oYgHHgxNBmBw6ELDymd/c=;
 b=KoaVcrN7MNMQMqHxkM6W8rtBVbzjUmVwk45yu+vXPVU3ZzziCisVuedNwwPTG7uptW
 LmyNyBEb/a/4wnM6lM915dgQBJJsLOuhKBJO5BvbK+tiSfhqFnMXAbaSl4ZiDn/xIz/g
 8zWRInijjrXB9uQ9fqFwvpd2RyHxPChn2e7PcWxJJJItQZaLg+1zw/NjQe+ZZhS3b/dd
 R37qcFn4imzWS8VqO792nFWis5lzKHuVEg0R9dHkOnUazBMtQ/9SyOT+P4VrdiuZRjfs
 lsb4n+6cSTy8ZvXE5N9A8C7GqSqhAMelX5bJaBSzarTlDYu0D6w2G7V+KQ4hSu6O/rWs
 BUxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzFXzU7vFRnH0ZdbhwlG4O7s21JCgDjJPKm7BOWfFO7JEHFUjmtmuGPo7aOznDRsuryU6GneoG8T8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kviEaYQSmEXi2qRTJKtRJwzofmYiWCBicCDQ1xdwIS8QstKlpc
 wmPOT1RaB83g48FuAJZD5GCunam8R5mHGk50bCb/Ye6ZonPrVPSOPjh1
X-Gm-Gg: AYBFou0tbxoAZo2MQeczPA3hLXfHnogLo7cGOXUSqCaJSw6ZVGTV6gdKISe+2ylNI4a
 tG0oJ6qChahvr7oIVpJPIbiCksT+rWr6K5WQhtStnQzNpdedKW7j1VuOWWw7iFRX38mdaF2n95E
 HhG84DKLqONB4xTGXxuJcg5cQt41JJDFTSC+TgOQJDytEENqelxEDG5tl0wh6o0zCf636fLiKZU
 hY+11eTMMI+qjySm29m4jiExhd1FEABcSnnBSKH2GGv1Kw7kCVXwFD5SsvSq5fJbKRR6pDQX1Wq
 vN7aMtl7MpF2Qi9QTOp8qicwT1uDe9cSZf8yOvvWCC63h0syBzasgOIuVtPwREvvsgS79Ljmga+
 bqMFuWLm86w5ImCN4GgsK04lnUnwWNRLLq/vavFV7QErU9ADNBqbcOBgVDNOwR8gA+4me4LEwnw
 r2fuDTL8tFHeEdoZ+VbE59Us//RELRVGKTLvn0Ao2HxLE4t04YA6Ki9o3P1V7JbBIUNw/TjUH/2
 TyXH87nN+lTxGpazejb2kyvT3jTp6IvdjfC/cmyNE4aSqHujBXoaGAVUXTGEKTbRSU7D7eTN+gQ
 hIySFiMBNdJwAg==
X-Received: by 2002:a05:600c:609b:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49fc7f2bdc8mr199991445e9.2.1790064769228; 
 Tue, 22 Sep 2026 01:12:49 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdad6306esm34086575e9.15.2026.09.22.01.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:12:48 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Guangshuo Li <lgs201920130244@gmail.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] accel/rocket: fix shared-device lifecycle on probe
 failure and unbind
Date: Tue, 22 Sep 2026 10:12:41 +0200
Message-ID: <20260922081241.46091-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812130311.8252-1-royalnet026@gmail.com>
References: <20260731064933.12548-1-royalnet026@gmail.com>
 <20260812130311.8252-1-royalnet026@gmail.com>
MIME-Version: 1.0
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

Hi Tomeu,

A status update on this series.

2/2 now travels as patch 4 of the DVFS v2 series, as v3, rebased onto
the slot fixes it builds on:
https://lore.kernel.org/r/20260922080114.44662-5-royalnet026@gmail.com
Its commit message shows the crash it fixes, and the notes under ---
list what changed since v2. Jiaxing, v3 changes the code you reviewed
here: the scheduler list is checked for allocation failure and freed
when only one core is live, and the patch sits on the slot fixes before
it. So I did not carry your Reviewed-by; a look at the new version
would be welcome.

1/2 is not in that series. It builds on Guangshuo Li's "accel/rocket:
clear rdev on device init failure", which is not in drm-misc-next yet:
https://lore.kernel.org/r/20260708062845.716487-1-lgs201920130244@gmail.com
I will resend 1/2 on top of it once that one is in.

Thanks,
Igor
