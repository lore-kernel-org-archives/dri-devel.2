Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C198606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reznichenko.net header.i=@reznichenko.net header.a=rsa-sha256 header.s=google header.b=IL5dpG5O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C9210E08E;
	Thu,  5 Nov 2026 04:05:35 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A823710E08E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 04:05:29 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cdb5d64fb9dso31823a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 20:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1793851529; x=1794456329;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhXzNT85syfQsWP0/fY2t6PKYwrrbIrshv8CnCw1QDI=;
 b=IL5dpG5OeVYlorDRYU8ugTLOSSghOlFKY9YYrcveA8U4OUx2j/+i0c3TR75rDj3AS/
 aBekiYtT8zwewM5OCP0I4yfEdldkokBcIKsTJnqpsEjRWG6AvuKIPbxZa20bkBx3kqEH
 OSsLChkGsoMII79e41OpDRj/lluP5aMheg4az5ZPjiater2Zcsapb4blYbcBnewRRDuL
 rr6k0KRG6DSlcyp00Rm9lTQV0UNRfcXDWeUllGWgDKjxo28nHz4iZ6xRIRrwTeZUyCIU
 t3qY452RCiyRq+BRHsFiVY6W7am05/qblxZ5zSDfJvqlPP2LLMQSHkUAz923ue8yf29u
 yNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793851529; x=1794456329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhXzNT85syfQsWP0/fY2t6PKYwrrbIrshv8CnCw1QDI=;
 b=V30GPFMpTdOoq4LukIZhBRPUf+QNszRcU7LefJhcVxowYz9HCo6nIAazNMlmJRilPT
 3Znq+lRgv8Vnv6HtsTAh6MQbQCpm/l0I8+S/eUBc9+Sjk312P6tUMuxlZjNqld8GuEbO
 8n5Y3+vKLnY6xJecB5DH2NEYh0wdOmc/zDowiiGo8p5s1XrrmvLgru8ju55i5qMnLc3R
 xoUdPmx9Barf5lpDlVs/6LsmLqtfQzdR7DeB8O9EJ64HsWUxbBmg8kNl7aJv1yVRH9T+
 LdRrJS6iIA2oHsdXNnZuBUFXv1rUzDRnZ9+mpz4nuApLeQu0iiGl6YxdM7xvSe9ZkGmx
 GhjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJTciDmf/l0ud0lnMcQkgtxCBxUeDUpTqVmXBOk1nSix3NenRS7fDo8u18IaD9P/mZ4Krj5saADWw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z86c2Balk4iC5AE4ReKT9x2raD8h52LRejcoxm1fwVapIGUP/tO
 wL1J03ltiJf0oLTHwwLVc1W2/FmPMoyt8oPNVmRWf5BjzGbWS/DwJRbcx9J5fSJMV8c=
X-Gm-Gg: AYBFou1U6hDkRs3HvOEJmlRAvCPIYgMbTDJXbYkf5b+XiyO1ajOFz2AWhef/rCS2/Tk
 X2GN+u9qvdbZUzo4YfEdoBuec95EQP2czrrt9CXA1BKVxUCitXvxTjy/LyYFD2nALcSHpKFd/I/
 /O3isZaXx9RdMOuEDmWaXwZvreyqZfQAQW5n7mKtRQlpMbqRva1GvsHbXDRfkxUVoW0NnWhZiT8
 k7v9ygKeXtwNsVxz663Qcy5FZGXr/NrXupuEDCk9Xuyq5BD8Bx7lLlnObxtkgcYhcWLe3hc/wh/
 1vX8hFAi9RGwWyQS7XY9kLXkxcuL9la5BE9y0IXaWk3upn1p+T0WLZwsOBeTfUcoedHIsRVUXGr
 uluj2qESQRJSASfqbv6eNsZ0ad56/l8UxEnKUtWZzwRZXtm7/Jf5+Vpy6+E9l4+Afz4Geu+j4fB
 AIQzcb13zFXkS9hoTcMJ3IYCyV/2YsZC9BgGf1I0mYJLunpMUFPJnzmv89MA21k3oCffcj2tqH6
 LLUUWVO/7k2QJJ1CZc0SeL0iuDECSmDw2ZbYzkV4ZpmA6Z+G0YC0Audmiha7+u94EiIFQqzY/Lc
 2hoHwMXMVQI9wLeMs8hc
X-Received: by 2002:a17:90b:3142:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3ae897f3919mr15959327a91.28.1793851529190; 
 Wed, 04 Nov 2026 20:05:29 -0800 (PST)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b90def97sm952109a91.7.2026.11.04.20.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 20:05:28 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: romain.tisserand@gmail.com
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, igor@reznichenko.net,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 4/4] drm/panel: ilitek-ili9488: add the PocketGo S30 panel
Date: Wed,  4 Nov 2026 20:05:26 -0800
Message-ID: <20261105040526.26323-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103110524.2812831-5-romain.tisserand@gmail.com>
References: <20261103110524.2812831-5-romain.tisserand@gmail.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> As on stock,
> the panel is set to the 18 bpp interface pixel format while the DSI link
> carries RGB888, so the panel shows 6 bits per color.

Minor suggestion: please drop the implication that COLMOD 0x66 causes DSI to 
display at 6bpc; the datasheet doesn't establish that causality. 
I think COLMOD only applies to DPI and DBI, not DSI. The initialization 
sequence can remain unchanged. Non-blocking.

Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
