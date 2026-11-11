Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E9606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqbqQfkk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B0410F931;
	Wed, 11 Nov 2026 08:22:54 +0000 (UTC)
Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2744A10E025
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 02:26:56 +0000 (UTC)
Received: by mail-oa2-f8.google.com with SMTP id
 586e51a60fabf-4ac019524a3so492420fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794364015; x=1794968815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D7F3TwUQ6dGzsMiU+yMtMue/xeRnuQuD+BhRm+g4jhU=;
 b=NqbqQfkkRMSe7BTpFL8duJ0dQiQZr3CCzxWLHszR0zJ+rrVlW8f9QiyT6iMvrLnw7+
 HD2NznyR32jwRSFDeaNcEK/b3YiKdPSqqn3BKZXhfnl4sogJ9MPuonsZ0YqgLX/n6FhV
 eFFH4U2dyUevwYbPlZCwIhjx/vXA2kZlmQF6BM8rcEmq4EFg2xwHCglPvOhjdiUkRenS
 LGYXsmqD/9RlWVo/Re9pzMWD6HFIryXp0Xv3mrOopokEVosA6FBRfnjCANzQ9h5ysI4p
 sZnfumAwu6bP3A1KI5WDHCLmBAVJSJSt8YjJDdcHPZC9WwDjGSF8qOZvD5llAApl3U/X
 DYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794364015; x=1794968815;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D7F3TwUQ6dGzsMiU+yMtMue/xeRnuQuD+BhRm+g4jhU=;
 b=YpHK5Pu3d8lEjt0FPoKWQX0ysW7dL/JKxDplbmTz+5ECDgkqk91mmNkzqn8enccRTI
 +U34AFl777ExFPmApeqDf1Ccf585NjS9gXGTGYNc+esKWmx2Vwy2aA27C/FTO9bBwcpM
 251VEBDIOHhFadqbN4Q1vTst1lNtri6RE7IJteVwcmhwhtpv8qYJQts65dyVUIXMW4nJ
 hozNVgv3J5OV4hrzSe9D8yzIJH9nsj/E4Ch6D/WKNX5oKFdesieTYfogz8QkOL5kcC8U
 /7r1lbP0moquPtc/iQWiEb22DuW4fxMvIp9thkjlzxTK6QeiRE3o3Sc7ooYmaoZsxDHs
 TW3g==
X-Gm-Message-State: APuU4Z85Zw2gny/z+ajFRjQGXlnt4k7BFESyvZ/b/i7fKuFi7f31jokb
 hrqmSYgdrc5R16DRtpj1vqjKehyNbm6plSFs2TC81dKXtjvQ1l1R1R4o
X-Gm-Gg: AYBFou0bobNYD2zu8yI6+ykJDjaPrZn6XvrxYhtgRI1AygrjliXZdUnddICS3Bc2nFP
 SFZwKbBy9x5mK5mC4MI0ALZo3NPf+gTvnGzE2ziOb06Iw/MB1dJZ6qI1olAvIqpzOcWdhRmfB1z
 OUeHyHygKi5+CGh9uYUdt05axXsb2xVlyDpcv7/pcoRrD6bWKQxK8OPjbgu7xzEOBixWzAkRDHE
 IL3JMhB7ONJJ8IE65QljmKTZPFkIP34Q4rtNy1nLSF5luZGl73lBueXicSuOpcqEwqQPULLnuST
 UQR8XZD5buhr4zGXzA8aHj1Hrj6tIMzWRPRBmxGPOjvdChbghtMceBvc8yz/seBKrTeIJzdXKhb
 potfxnrrnB4WNKMO9HuuXkIwfyz7NYEuJCqPX2KMT63CC5pYKV9xEvl+DIWUE7DdaekUyhiO3lW
 gLmoqKNzOBR+Oj/Puc6V+ZYA4DZ3xRFgvT1epBQhzp4T/GcWKo1Rson4mpntvJKy0qZCokBPErE
 6TN4/R1jx2OizpmEfibK6tDaR1JA2locTjMN9st/Z0ndZOUNtRvq6LkjqyU+wPc2oNceYv8EOGN
 8vDnGg2jK3xQbrsXCfcQDBNIB1fyJc0BQk9RIjbL+WtuKA==
X-Received: by 2002:a05:6870:1649:b0:48f:e0f6:c45c with SMTP id
 586e51a60fabf-4ae46c42d59mr1213442fac.42.1794364015190; 
 Tue, 10 Nov 2026 18:26:55 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::f01a? ([2600:8804:5716:d800::f01a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae22d1d541sm2789026fac.2.2026.11.10.18.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 18:26:53 -0800 (PST)
Message-ID: <8c8ff7e2-d1a4-45c8-aacf-bca93439a32d@gmail.com>
Date: Tue, 10 Nov 2026 20:26:51 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chun-Kuang,

Gentle ping on this one for mediatek-drm-next now that 7.4-rc1 is out. 
It has CK's Reviewed-by and Roman's Acked-by, and it still applies 
cleanly to v7.4-rc2 and mediatek-drm-next. I can resend it with the tags 
if that's easier.

Thanks,
Ryan Brue
