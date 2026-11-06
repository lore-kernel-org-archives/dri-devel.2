Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85551606A32F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MBXWhteI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E384610E374;
	Fri,  6 Nov 2026 13:54:56 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D51010E374
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:54:50 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-491971ac844so585052f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793973288; x=1794578088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YhC969aoZeZO4EN87Pr8flhLc6MwVIFADHN+EJfduEI=;
 b=MBXWhteI62uU8vLtY55Pp1cry9jdiFQrphfZagoq4mbiia5MwsUTM3P/1gqoRyTg34
 VivV80wE0qy2jKNXZ5jSzIBoc/4Ak9TPDJx+s2imAx0ckero3/LJ+urSf8pZ/jqgvM4A
 pqLlgO7/hgE2qtkY3sIKrhW9iZmkXGGMJHQXOfCkKx6s6qqIepkoEgcjHJ0hv0BvGLTK
 //P0g8HldnjNGkuUQZ1geMj85iqGa0e1m5JVU2RlKWLYUU2WEx8xps2ZHYe1weeecltZ
 KV3sWGTDPBiN/o9/wO+v3Mk7hdMLsbZoh+YAnTTdzHvG9DQj5vj8sngRFdL/QduZ9Uco
 yGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793973288; x=1794578088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YhC969aoZeZO4EN87Pr8flhLc6MwVIFADHN+EJfduEI=;
 b=oIE1BKIjg2nq6TErcTd1U8CktRmNTGh/cjT+XxnnD+nuh3UjZr+mzWTMSWoYqfj5c7
 iTswIfADjdZ2skL5CEZZ2DtD5NIl5FFZjC3MELBN8SBex9eaByVJycIrCyng2DFpuBbr
 zMdcubJGdLFVGgJEt2jS20+oX4mJGxNbH4CJNmxecwD8vWGLIzqhrExnw6RwEI1d+zGg
 IrdQ14QTw8V/1keQWMjPW5TBCLERQmw25G01efAKJ9r5G8IgxQP4A6EbmRJbNxl2JNn4
 kI1ImWO09HBD+jWKzW6M2mYM94Si1YjpMIZd6EotSCjsFdqfp0BGv4y0Mxt9tlVbezTe
 D3pg==
X-Forwarded-Encrypted: i=1;
 AL+hErHHK3Of+CWP8UltfwSg9aVs92IytlAK2xSJTMLdP+0qkw+6fEFejsU+eW3trF9HThljpwtCUGZ+jBY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9k/O1MtzjHHj/tZrLnak7bZ+KjITzmVcprtNf2F8Meag0w8HMT
 BOCzAbY/aNlaWSg166Cs6EdMG1+1lnq9Z/GMy+528QiO0kqPXVzF6nzY
X-Gm-Gg: AYBFou0Q1QoBeP5BKFmfspm1P98aaQxI1sUXHXwvHYoBgnwABbZWbQ5iVPK+qAWZEtP
 T8qOnD3bMTd8iWmZJkkPfs/A+pzquIQ9lGEBbL19Us612iiRQhvptwf08cQZgwWKYeDWvCMzFya
 qovL6j4Y62wtVU8KzGX9zzDrXjvfKXeHwJ6M7O2b6XbgpyhB4zRV4yM82lvAKSuMv+qs8AiXidg
 qX8vDsnUbblb9+s34i2NMK76S02m7JbOzX+p9O4v0h84jWLd0dPqis/+/jwpyZwLFeRAo8H+0m6
 4gn0q6aAa6TbB/2kZ83S0HneuIvGX9LVqMBxPxZEkfiAfR9e6khpxVOPaS7r2hQk4/ENMxAJO2O
 Pf8uyaRSxj/r0h2pNRXas4qhz3J7V4nkoi7qFSAVbJ1roVbvvXabAk5Zi8Zp14GxfolCCGMHOcl
 9LOcpolgPU2a+MEM3S5p2W34faDREhs4rOaxlvzgqP1BnCnxNvM0O8fsk5w5MRCUrgqEUInx4e6
 QD4lqF1C3TIc8hR1sOE5BSjeUvFi/ZFQox5BsqscrHgpGqeo6ra/WYhOcmKcRBSp4ygDimlmRdV
 NyRvfy1VbQDG3Zq6uLOphUo+LwCLS2bLWNDuKTbP7Whq6UZtPV7uvwOjAr0lPU5i91XUHTOSchN
 +qF1QOqZOCJgPx4sw2eUKHA5ypUM=
X-Received: by 2002:a5d:6f0a:0:b0:48d:dfff:fe6b with SMTP id
 ffacd0b85a97d-492760da71cmr5896957f8f.34.1793973288307; 
 Fri, 06 Nov 2026 05:54:48 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.lan
 ([2001:861:39c2:e340:6118:66fe:a6e9:e648])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d087a3c5sm3393124f8f.0.2026.11.06.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:54:47 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, igor@reznichenko.net,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: add PocketGo
Date: Fri,  6 Nov 2026 14:54:46 +0100
Message-ID: <20261106135446.1334980-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106-gentle-shrimp-of-weather-dde4f4@quoll>
References: <20261103110524.2812831-2-romain.tisserand@gmail.com>
 <20261106-gentle-shrimp-of-weather-dde4f4@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 01:58:02PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Nov 03, 2026 at 12:05:21PM +0100, Romain TISSERAND wrote:
> > PocketGo is the brand of handheld game consoles such as the PocketGo S30
>
> Vendor prefixes are for companies and I cannot find anything about
> PocketGo, except it is a brand. What's the website?

You are right, PocketGo is not a company, it is a product line. The
S30 is made by Bittboy, which is Miyoo, see e.g.:

https://www.retroshelf.org/devices/bittboy-miyoo-wolsen-pocket-go-s30

I will drop this patch in v2 and use the existing "miyoo" prefix
instead ("miyoo,pocketgo-s30").

Thanks,
Romain
