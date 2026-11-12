Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288C606A8B2
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OIp+F1cv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9954510EB60;
	Thu, 12 Nov 2026 17:39:44 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECEEA10EB60
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:39:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B3ADA1A1639;
 Thu, 12 Nov 2026 17:39:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8771D601AD;
 Thu, 12 Nov 2026 17:39:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68CF311BC0CAE; Thu, 12 Nov 2026 18:39:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794505171; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=u2jZcK7Wj9UhBcZRbPziQwkmCc362+R71+IxAnGwCHE=;
 b=OIp+F1cv2PtidDaPvQBP2de+3+8Q8B3yCZCdYxXMRGUSQUnS7ceMzjA/pEyjEQ792nA1Ur
 6mkEFUT/ixtfxD7fhpGaqrlrWGP5I4ZD7+Jd2LdCJCWvWWWXxbZxzaQ+3s6J/+aODJmMSW
 PTN5U2SmC+7OncJmY3OQflaqVByjZGUD2e8pi1HISH0YOTlbmDOWPfWLe/Q8vLxId5uLlW
 Znuo9bWwuKoQHjCEQ6oHYsL0hK+JWeVZlHRLXEBWextbGcwHYtfe4I40Dm+VnqHCj73180
 dxO3Z4exklU636ZwWLgLhOV5SEaBGU8eWD/IHlA5FLR7Rc5TpbrrGCSSuS+vmA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 18:39:26 +0100
Message-Id: <DMTEZOO057WM.1VQK936FVSLQV@bootlin.com>
Subject: Re: [PATCH][next] drm/bridge: tc358767:  make read-only array
 ext_div static const
Cc: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Colin Ian King" <colin.i.king@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261112162127.1592210-1-colin.i.king@gmail.com>
In-Reply-To: <20261112162127.1592210-1-colin.i.king@gmail.com>
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

On Thu Nov 12, 2026 at 5:21 PM CET, Colin Ian King wrote:
> Don't populate the read-only array ext_div on the stack
> at run time, instead make it static const
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
