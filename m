Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D68606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reznichenko.net header.i=@reznichenko.net header.a=rsa-sha256 header.s=google header.b=WMqssEp4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358C910E8FB;
	Thu,  5 Nov 2026 03:50:35 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B0810E8FB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:50:28 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so14165625ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 19:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1793850628; x=1794455428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FTQt/DKzExkg2Hajv9Ngnf1BFMIHptWE7Rva4W1+tQA=;
 b=WMqssEp4fnIQvP7WcUmYT42zIz/61wySanLDmfrRghYXY3DDAyeFqbvBCr4as/mvu+
 RsKviuIRFy4xDZSvzCuRBKAi60orV8yoPGmQLrJp+UtchIA6BigrPmjwQrhpCn4Qedcp
 q0qvfi5HYlwfhvmtbq80TS2Pv4f6kzHpSJgzJ91eYS381Ied3eLqFGYzqNN7b200ILmS
 sC9J8BCoOY97UgOcUObBQNvAy4f/IDzySQcqxrF56K68cyt20un57iUTeAnXhkcZhxC/
 /s8NotuzeiAMNyD3/g0X/sKuA90joy3VUAHDtHSQxXn0vpbskwOgS5x3ci7JW12S31Jn
 xeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793850628; x=1794455428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FTQt/DKzExkg2Hajv9Ngnf1BFMIHptWE7Rva4W1+tQA=;
 b=ouPQFS+9Q6Rhg/PRS5WwlF1dpn+w7jv/zs8qUk4ql3S05lyRkK1dqh47GlsL5Rvcv5
 dSodkLgwl+MVDepB2Dlh9NFZ16MNsXMp72UxQg7G7NRVxY0K0kA7J7Vt5TGENJ3UXCI8
 Vl1Y61OrIJAxT9lkuhthjZcGaHB6+O0JV0oT+dEDe9HMcA9lcOI2QJWRV/c3I5GliU6x
 Zlq0UR5fotV3TYpDkn2+pvZdH5AEN7cAfd6Jq6gEy5TAHxxpOP7ZW4GgZE9/cm+GA7wY
 TrZh/O//A/q0lvxVcAYkbD1kl/uDFW1Lx667LWSsRD52l07dwktM0n+klpXA7du6KRko
 0A3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7clj/2I8kE9KW65zNVIeGnZ2unbQ6J86ZDp2tDMHO0UOOde2Vp48BJdW1xq0cGaCStBVXYFPxQog=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+y473K4y+MUnZ/7poyM4xCs1XIxeRJ27eEuJ78KwD+Gogmp30u
 aE2s4S+oYz65jP8uA2Ota37lmlLUH1Z4wvmglcqg+4k246BMQoNaetJsYHfroKf0wZY=
X-Gm-Gg: AYBFou1/rvnEa5jqLtjU4k7HNasbvAl5cLHkwyqb4WYZgNfYLsuD6AZRj48pH+zf411
 FD9RX2zDG7LgVjlpNyy3Hv8k5WQn7ON0hoBjyxgmVLKxl4uqELpQDGnvWEPQX478wH89Ql7nIQZ
 Uh9WDvf0P7jHPoDfJeeozvDCtiNhTeUrefHMx66ck8O4JGi/xkwi/k5lPswWxn7vpS6mGUVl85g
 7rjyXuNtc61okNu3A7kc/ccON7UgDWj4Mgj+CbLQkaNTLvMH43MPY10MH+nBWx+VHTOV4Lh6XfR
 6kWdJB2o8KfXs6qZz4uhUYKOm2sc3WRbnyLIImXFu17614+mJi37xvcEfBvRpOKSq6OfrWaTj2u
 RBh7D4kFgTX/KkWVSM5O9IueOxU+FWD73XaAWB9b7T4O5R6LDXME+JAPnoC87ShDtYmEbs3rTca
 EH4T/Uy6mYV5UFGNwquNpg38N/AxaXzjAb+QCmxNG1h+zSF3AfQJbTTkncP1Oo6iKugGx1MpTza
 AVLdB1jvWn0yAEhYEzZghPNhMDL7l89NFgR+NB0ky6x835dT17A5+UZcDO3mSjj9oyfZsMMEqJw
 Tu+nGdt6RUIEoCg97QW2fVk=
X-Received: by 2002:a17:902:ec85:b0:2e9:a23b:643d with SMTP id
 d9443c01a7336-2eb364d253fmr159592395ad.35.1793850628135; 
 Wed, 04 Nov 2026 19:50:28 -0800 (PST)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed09127d9fsm12557955ad.51.2026.11.04.19.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 19:50:27 -0800 (PST)
From: Igor Reznichenko <igor@reznichenko.net>
To: romain.tisserand@gmail.com
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, igor@reznichenko.net,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org,
 sashiko-reviews@lists.linux.dev, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 3/4] dt-bindings: display: panel: ilitek,
 ili9488: add the PocketGo S30 panel
Date: Wed,  4 Nov 2026 19:50:25 -0800
Message-ID: <20261105035025.25540-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103110524.2812831-4-romain.tisserand@gmail.com>
References: <20261103110524.2812831-4-romain.tisserand@gmail.com>
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

Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
