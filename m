Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F508606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EvnVaK+l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB78A10E224;
	Tue, 24 Nov 2026 10:26:28 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C3110F478
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:26:22 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso3139317f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795515981; x=1796120781;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rjPQj6M4ULtn6j0AWEkFprT+kxdBF0dsfklPDyAkphE=;
 b=EvnVaK+lCsrNmxMPJtX1XOuzcXkZ9N8Xis1rS0utlOEn9+fUEZFdohG7/GTk8kAmBS
 y2lQu2lGh9jPFl72Rv3z/fJhP8/MGn/5E2D+49BzpGl2VMJTMnt2FhNU7J5HRvGIEzKq
 eQ9ZaAra+AZYOJZSLv+AvrrvIkQX4pCSDwqFPA3gywOR2t84B25rJ/chTFt2QBqwaNT4
 NvIN+cJWr4mPcd6ImLc2HPEkG0Od5IhCd3MHpA1pc0LaJjHBW+Slgp1399ogbI2juXGQ
 RoefDpgd59nxnNRPXU2xL4H4T0fhSnS2VUg7lCy3eZ2ooggEAdUYnzXUESrh6xtpQmC8
 eXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515981; x=1796120781;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjPQj6M4ULtn6j0AWEkFprT+kxdBF0dsfklPDyAkphE=;
 b=NLY7vXX7DoLhZqtDXnmWLmkpH4fMLd3GYMbYSRM/EqonTx4xuvocMo3kilgouG0qeI
 nMn45niBfo1/uSisxl8RiHUpE77r9dZzv1x0v0LOokVab5BckPyRKV5Kw0i7SlIQiEBO
 zZen5gZ/XDT6k6RkJSiIgelrrca1kvQyOtlK+tlHP7pEOdxmH0fUeaT/wCNXB+LGz4mT
 uOU+KSmNd3FoGpDo2m5zVrQIghfo2n2qQGKZzAy0VeCSsksIluMo3cqXhXB+fk2bSFQZ
 3h1jCpCrZLyPQ5jgbDIDPep+tAcN4HiRSsyCZSymcZWKFGkhCU1EpZhhqdUJ/viJLh8i
 tMHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErErvaZdOcmh4lokYtkbGQ375RPQOnh6wUqvexbX7g6urWlHJ7+/nUvg+bypehhEmSTnGWklC86RI9k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9CUR0f5hqGNMykquTv+ArcBHsT6kRGPJt9vTDO4C4H6J2Khmnz
 AVB7mPuwduHXYc0zuKoQvvZ8Dq8LYG7w+cRWgqPJbLLchTYjUVF4IsT/oR0HfmxhGHc=
X-Gm-Gg: AZFdTZcMplcIksNq6Weo2wBoP03qVqzgLcRBLfuAJ+GPMvDxsTQJoywAG7GXj0tqjbW
 ZZAYo15gQQqihldAG+56hgiXGHsd5MEQL2pMzHLhw4gDz5nqW81PkmzTmKDbjjnFPjt9fRoMbmj
 YTTJQyoGoEhV9+iH9wiJ5+9ogWp4104Y4CnhjCWxmw9yQeju7KgYww5SiU2Cg2XR9ky8NsvEnkI
 2+jHk4v55wFlV6tvdMg/hyK4wxGC0o6FsR50OFaok7eyslVfvazr7ArpbTQd44XpKO/jdGWpA3/
 NZS6JjX6vkWflc1H7ByB3OMNfrYVUeJFdVhZau95Ab2StgxZrA0cEGztlp2ZYautZrVwwun/asC
 5X9NgskVoUn8PfIuEUOIpmaFa5u7l0WnPytom/c4SkNAjAYFtiLxAbpGXUe8ZKiDgKI6+l1oD1W
 1IOPIVwnYwwi6OJc5Uz4ZvK6rNCnBX46jxdb84/kTG8oBRqMR3lxMyOmmb8EZjxusDIyMgZ/glV
 V2cCaY/qRiwAOZBEkOsftKxqB6zIGZvSqPzriS9BHKtPyH/TmxBe3hxKqxxfQgueoKxf0GbsjAm
 2Mu3b7G9n+wB+yMgqXzAEUoluKIDUpkgE1lbZJ+Mr1aQ8d8cmzYZjrT7X62rZ3nu99msS1A/gyS
 yKA==
X-Received: by 2002:a05:6000:29d6:b0:48e:20f9:8d75 with SMTP id
 ffacd0b85a97d-4abb58ec00dmr16232655f8f.48.1795515980993; 
 Tue, 24 Nov 2026 02:26:20 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989eesm27197538f8f.50.2026.11.24.02.26.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:26:20 -0800 (PST)
Message-ID: <13dfc467-1f95-4f86-9d01-8a5830007d51@baylibre.com>
Date: Tue, 24 Nov 2026 10:26:18 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <c57db6883bb9c977f65d34569f1ed9cb5405bdda.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <c57db6883bb9c977f65d34569f1ed9cb5405bdda.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 00:01, Jiaxing Hu wrote:
> Add the RK3576 NPU. Its PC_TASK_CON has a 16-bit task number, with
> pp_en, count_clear and last_layer_clear at BIT16, BIT17 and BIT18, as
> Chaoyi Chen confirmed:
> 
>   https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/
> 
> Add it to rocket_registers.h as TASK_CON_RK3576, generated from Mesa's
> registers.xml, and use it on the RK3576. Count the cores in rocket_drv.c
> against the match table, not only the RK3588 compatible.

In the corresponding mesa change:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43804/diffs

You had to tweak the header generator to allow two register definitions
to exist at the same offset.

From what I can see, Mesa has another way of allowing hw-specific
variants of a given register: variants/varset used in freedreno register
definitions. Have you explored using that?

