Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80EB606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eO5F6/d3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE3810FCDE;
	Wed, 21 Oct 2026 08:53:01 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F1510EBC8
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:16:07 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so5645264eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792494966; x=1793099766; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BKNUIkvvRElNLCz/nkWKn3YDTekvBpvFpeCv+ciRNW0=;
 b=eO5F6/d3J2O05raS6vTXoKeg+No/EzKDrotLkjAeq3W8EseWrK1RXcQrKvBiYDbO21
 n1LH719Vsf+Vk+ugGsV44lNWGjd7TbHi0/GI3/IOtMXRLi45d375xzF3vUwpgeqem/aB
 81lDuVTz3zy7276vjMbOonYfAZF2rjaXRr7AaaFkFJJ7jP7+6hKCO2rLbrlR/T7m351x
 l+ODz9O+Y7VyU4nNnQQPGaKH0VDMZO82BHI8LG/WOhI6fGpJzmgE5A0pb6PqRoTViWoX
 35CtDFFRAthQuAawJqGIvYhkYdEKkUkDg+zWt0yczLTc5c2iLxcQRzen1TcE7Hgt8+xr
 WeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792494966; x=1793099766;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BKNUIkvvRElNLCz/nkWKn3YDTekvBpvFpeCv+ciRNW0=;
 b=0ARgWTGMxOYFrJeKCDWOp7G7mKEG/4IYw/PYFaxoZXixYtlnbDoX7h3j5TmRH1jmRp
 CnpOnVK1sAkEz3W25vFFAPRAUmEy5HpNugwygzf9CQUvWjukJSMEbHcMiunRGGYEwl5C
 iruXCHmO77TV7ZKN5ohNpWr17ekTeeoPGTU54VDtBDNFC00b8VL7zMjFGu3ezgf3JMF6
 zJKzNnhCWKMf0WGP1h/xcrRSYVsA7CN9qjJNyMwUUHIaUzvY15uQwkMANSzKhfzfzfhA
 wcpWKoVK7GGQvxuoDtmQRgV5uNENt9Fqnb4PeIALOvA9Q4/fqLR61uYl5wmYv0zm50O7
 lIrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBLmzVyntycIfP7R+LJuVRps2VvQ9yYD2WtfwTacYKc6HySQRnjG1dGe6ZP/6syJHKnAg/xAwq3Jk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJe/BKMKR5Y/BWQVQ6/A9s9hIR0kM6qCojyB2gt9USd87a3ehyv
 1m77gbu2UYtGPmJw1sWEe4wOOA9/YBZZvX4D7htXLvgnBwGE4np4TzWs
X-Gm-Gg: AYBFou1AjJN8NGAh9patp4QDdpKKx6FjscFcTtTrGTAHLUkQqrSZh7Zl7KBhTjBBKvQ
 Bvo8mvdjWq8V3T9DLXlfjyQmakeDjJNkNyn5YpPX8DYyhyLYuEperYPnwaOmdUKMIFx4szUsmGI
 dKwxQAANSHxv6oAzbslUNARXZtBa6MSUnZYNCO9QN2J5z8HvNXC0smdZlzc1qvBEzTQZ+qsIDN9
 JNPUG7D5nvbjpRuWnkmdUDwHLA73JjibsfBWMecbjI63mgb5jhOrSvRyFZ8JVViwEKria1MmGld
 w/xkySQxE6qBlEIGTkRrUpblgClttUusZwwur+uHOv/d1XfxxILTIf5VW3/DYkZsYPWuTUfnN10
 ho07Ub7+CJuEogEdBAeg8Ulr4osnoXwJh1iur1ZY/jK0HB4vtfvwrgIiJ6P7AGWgJ6yDgpMFctH
 szzVaBtam93CWEhtMEW99SgaHD6Ym3dZ5scIMIlB89MqbVEsldx6YQG07G0oh2p/3/qQXsUu5SO
 0gq
X-Received: by 2002:a05:693c:42ca:b0:35b:91da:7cb with SMTP id
 5a478bee46e88-361a284198emr14197128eec.35.1792494966059; 
 Tue, 20 Oct 2026 04:16:06 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36081fa5a6esm41461147eec.16.2026.10.20.04.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 04:16:05 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:15:57 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v2 2/3] drm/bridge: simple-bridge: Support
 data-enable-active endpoint property
Message-ID: <u3zistwpxmtjstw6lqh2qfvr3mrj5ozflxfnrln2qqitjnj6lw@5ea5j3zmonw7>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-2-ef6a3a780472@toradex.com>
 <atZ0jECm5BDeROSI@SMW015318>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atZ0jECm5BDeROSI@SMW015318>
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:50:36PM -0500, Frank Li wrote:
> On Mon, Oct 19, 2026 at 07:17:15AM -0300, Leonardo Costa wrote:
> > From: Leonardo Costa <leonardo.costa@toradex.com>
> >
> > Some simple bridges, such as a resistor ladder DAC, may include a
> > data-enable input that must be driven at a specific polarity.
> >
> > Read the data-enable-active property from the input endpoint and fill
> > the bridge's input bus flags accordingly, so the upstream encoder drives
> > DE with the required polarity. The property is applied only if the
> > bridge doesn't provide its own timings struct.
> >
> > Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> > ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Hi Frank,

Sashiko's comment regarding atomic_check was a false positive, but I
wasn't too sure about the one regarding devm_kzalloc. It seemed to make
sense to me, but I'm not too familiar with this subsystem yet. Do you
think this was also a false positive?

Best regards,
Leonardo
