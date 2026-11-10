Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D8D606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DneqA5f1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2578010E9A6;
	Tue, 10 Nov 2026 23:26:02 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1883410E9A6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 23:25:55 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794353154; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:JW1wk08NdD1xOn/tH7Cjaw7YYc44
 lVG0JD20T974MrViaKrTQf7WwW0WesIKiu6c82WglMj9I1M/ZcQIoD0lzcje+L2sC7+J7TyWRcX
 E3AEiyPty4F54iIIwF+cDv9yl8no8TrZck4o3St/YfT1TCCG8/UMbvzihw0XlJzUAkrkK+Usy8K
 sS+aM2OvZTka7j2uhDzDwe5UDkMok2qgIuglzIPVhZBCA+5OItlUeQG/ewktmPRN4QwfSjn1cM6
 5KsQiks/H/FvZXx9yPJ1RTm1YDx88ou1ytl1NNLSpFw2t6Vx0peRTei8Mu7raL/4QW0nPRnGE8+
 5/RmFi2GzDnFfw==;
Message-Instance: m=1; h=sha256: 2knI2DMm2Au90LOUjIDDyFuseLYGF1U6o+rE1pEST5s=:
 AXE3aRuP2GTjyoHEXcCH4mJpybncyaF3j/HbC+VTl84=, sha512:
 0GlVN7Ru85lvL4Bm8bxAFu+9pCt2udfzsxEwXOJhhDhZqe/q33pGps8ttxX9+2ao+2LyehKyxxGYHB7pxfqUVQ==:
 n0cg1bgOenoWeFi66q7f9PT3XKY/Ys5HePKhZMVst8cWYaBrYD5N3IcKjPCyRNqT93j4ve/7yBdu/pGTrBemEA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794353154; x=1794957954; i=deller@gmx.de;
 bh=ot4bM++AZAe01UoYyChThNyXoXgWtsDIovxJLVTOOz8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DneqA5f1Gqca3rJfi/vWvCqzG2Tyfme6NYAf2V5rPL75Qllh6jp7UtQRC94cRSYV
 dYup9AFKp5qkWHE+3XaEUDcUZhT3Cc+HZMlxCJ2qNweJk1K9BZ0Z8xpDv6kifnJHg
 d2XcYfO0lwrNdYFLmeWbe4wjVI3r82/YEwcSYk4AgWUgc7xvXJVdO7SiGPNOFkiv7
 SZKmv2C3Wxynk7OYyIbUL5GRP3ogzyogRK1Y27uX6tX24yQNtNj/Y5RFjqSB8ebQG
 mur6Cs215ocfXGX1aR0bugwgYcxzjM3MTIwxiPVeFbkryI7w7qT+ZbVxknHdG8E9y
 ARHdiwfHcZM9HfZyWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1xEoHm109E-002axS; Wed, 11
 Nov 2026 00:25:54 +0100
Message-ID: <16220356-767a-4f1d-9b24-5b1f960e04cb@gmx.de>
Date: Wed, 11 Nov 2026 00:25:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: simplefb: Add mono framebuffer format
To: Sebastian Raase <linux@sraa.de>
Cc: Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1793758480.git.linux@sraa.de>
 <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OIaIexKO5Zmlj7Em8/vSNnVPBZPgcNKzkLp2cCoVtMUimM6xyZ7
 6hyt3VfqezzNoQZfXBDoMOf6+ytepPqkbS42hcX19HvQqEf3+CJRFtBf4Fmk/ZV+hjjUlnd
 Go1jNfHaSJ/0v/jaL+Q22JLpdg+VZHXf6odbiZF/IUkllTtzEoV6UwcLZ9RKmKjyP1Uwsl3
 mmOcHdaK8O3+8PHetQOEg==
UI-OutboundReport: notjunk:1;M01:P0:qWQPCJJHRjM=;84aSH2JxiKqeZ259Q6o/KFrFTp9
 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
 jrr+IXA32qb1YpncbIo9Mr2hfGDH+iLz
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 03:34, Sebastian Raase wrote:
> Add a new simple-framebuffer format for monochrome 1 bit-per-pixel
> framebuffers. Monochrome framebuffers are not true color, so their
> visual is set to FB_VISUAL_MONO10 (set pixels are bright).
>=20
> Signed-off-by: Sebastian Raase <linux@sraa.de>
> ---
>   drivers/video/fbdev/simplefb.c         | 2 ++
>   include/linux/platform_data/simplefb.h | 1 +
>   2 files changed, 3 insertions(+)
series applied to fbdev git tree.

Thanks!
Helge
