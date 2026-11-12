Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913DF606D55E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=CfQymQcn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014F610E5D8;
	Thu, 12 Nov 2026 14:18:45 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B62C10E62E
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:18:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 699A34E4158D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:18:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 356AA5FF85;
 Thu, 12 Nov 2026 14:18:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 591BC11BC04F1; Thu, 12 Nov 2026 15:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794493115; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3Y26hQ4GBfC0y7Md5mdtfAPI7BfM2am8ejTyNSm7PVs=;
 b=CfQymQcnMNPEoq8O7tqc0VmobtUb8luPkxpUWVF6dle9DZRS9AX4BlEBKEkReL26+NKa+S
 Qs5UdA2bDHst3dk79WYj8I8jzJX7bS0Iyj/xsFi1yKrKQX67p5E7IFzX3RnQVeYAH8Sffe
 kh8e+yBm2ZGEEq5r9xw9Xb8VbcJXDLWLzJBD7sAxznzpUs0mhze3KjAwC82gLfIpfLCHEv
 bpX9oi/Vjx6kCwKzEJUrbRVW+8wfZn5lZedH1JIpVHJ92BnkAkKXzJrG16pmKBNNvT+NiC
 ZGlHrUrtpbbJwaAc8C4/j/WVpmHQly61B/AYW8bzH/BwlB4FBXdGSpVfUEkvrg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 15:18:29 +0100
Message-Id: <DMTAPTXHND0A.2MQ607DNUS9ZD@bootlin.com>
Subject: Re: [PATCH] drm/mipi-dbi: hide unused mipi_dbi_dcs_read_commands array
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "David Lechner"
 <david@lechnology.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Arnd Bergmann" <arnd@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261111092404.2117072-1-arnd@kernel.org>
In-Reply-To: <20261111092404.2117072-1-arnd@kernel.org>
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

On Wed Nov 11, 2026 at 10:23 AM CET, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Wunused-const-variable is enabled and SPI is turned off, gcc
> warns about this array being unused but defined locally:
>
> drivers/gpu/drm/drm_mipi_dbi.c:79:17: error: 'mipi_dbi_dcs_read_commands'=
 defined but not used [-Werror=3Dunused-const-variable=3D]
>    79 | static const u8 mipi_dbi_dcs_read_commands[] =3D {
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Move it into the block that actually uses it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Could even be moved inside the only function using it.

Anyway:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
