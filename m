Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF8606A331
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pSOxUHET
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FC610F5DC;
	Tue, 10 Nov 2026 14:40:13 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248CD10F5DC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:40:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5E82C1A1606;
 Tue, 10 Nov 2026 14:40:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 29B1D60012;
 Tue, 10 Nov 2026 14:40:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B66210329446; Tue, 10 Nov 2026 15:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794321604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=zBf1r9G6tN4PCGIwYFRHeaYpu6V24z2k/HtpPlR30Ug=;
 b=pSOxUHETAlFXI+QxO0WW4FSJeKEr49FdqteBMPfEWL9KNskt/L/e3a1+LI/AQszsy21LOC
 1NlT0H0HWtfK7Uv+GJVVShyw3iLtz3RJP9EnUPdgZDIcu404+Kra9omYZcJJ6FP/07d4dB
 gw+sxlsz/yd8NwY5Xcd152RP5ZfQ3457JmWq0R7BsLnd0C7hUtafcRkHfMuQT5y8MyJcPw
 KEuZWxhpLrdRaSGGrLm564bOifDacEA1Ueh1k5Hb6onexyivMRFUttRIIpMAC7v1o5005T
 BN4G+ai1XlVkiEsxqBir7KO4J5pU9NWMEV5Q7UYT2Tv5PHbXsBm2mLPZK9kZ/Q==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 15:39:57 +0100
Message-Id: <DMRLX6IMODXH.1Q23T2VEIJVWI@bootlin.com>
Subject: Re: [PATCH] drm/ingenic: Allocate and register the internal bridge
 separately
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, "Paul Boddie"
 <paul@boddie.org.uk>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "open list:INGENIC JZ47xx SoCs"
 <linux-mips@vger.kernel.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>
To: "Paul Cercueil" <paul@crapouillou.net>, "Florian Fainelli"
 <f.fainelli@gmail.com>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261105203517.2293404-1-f.fainelli@gmail.com>
 <fb84cd36838875ccd2530b9e3983700fbd23eb3c.camel@crapouillou.net>
In-Reply-To: <fb84cd36838875ccd2530b9e3983700fbd23eb3c.camel@crapouillou.net>
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 8:46 PM CET, Paul Cercueil wrote:
> Hi,
>
> Le jeudi 05 novembre 2026 =C3=A0 12:35 -0800, Florian Fainelli a =C3=A9cr=
it=C2=A0:
>> The LCD controller's internal bridge is embedded in an object
>> allocated
>> with drmm_encoder_alloc(). This initializes the encoder but leaves
>> the
>> bridge's reference count at zero. Since drm_bridge_attach() takes a
>> reference, probing the CI20 display produces addition-on-zero and
>> underflow warnings and fails to attach the HDMI bridge chain.
>>
>> Allocate the internal bridge with devm_drm_bridge_alloc() and
>> register
>> it with devm_drm_bridge_add() before attaching it. Keep the encoder
>> in a
>> separate DRM-managed allocation: encoder cleanup can drop the final
>> bridge reference before it has finished accessing the encoder. Find
>> the internal bridge through the encoder's bridge chain during mode
>> setting, and use the bridge argument directly in bridge callbacks.
>>
>> Fixes: 94d50c1a2ca3 ("drm/bridge: get/put the bridge reference in
>> drm_bridge_attach/detach()")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Looks like I lost my commit rights to drm-misc-next, I guess for
> inactivity.
>
> So I'll ack it (LGTM) and let someone else (Maxime?) commit it.

Ah, OK, I'll add it to my pipeline then.

> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Thanks!

Cheers,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
