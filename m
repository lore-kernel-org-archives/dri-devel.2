Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C02606B1EC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jCkrKTkJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D83B10E5EB;
	Fri, 13 Nov 2026 08:34:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD83D10E774
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:34:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 087824E415A4;
 Fri, 13 Nov 2026 08:34:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C8B28601D5;
 Fri, 13 Nov 2026 08:34:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6D95C11BC06F0; Fri, 13 Nov 2026 09:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794558882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nLcP4qFeNLouEfcFHqryAopJvdLx1pDFyoiPx7iQi5s=;
 b=jCkrKTkJ6QntopfsCVx823gb7wx1QWSubytve2jZR5DHrBI86oUpTLuYKxTJcyOckDIn8Q
 hqgT0HrVRA8aF33hwVhKx9bEnJVwBm3JeV5zNlcSSur/y+LTadEhSR0RFX92RHAUgiOZdP
 L1WMeUYmc5CuO6R70gWZwGvtr672ys3rO5jewh1rk/E9I+K8Hk1sq146EGEnaOVnP54zvu
 EbAXMMD3j1EOmhqA+E4rje/6WcR5uT2EglFv65T5WQjOqzU6r1a2V3KJHp+imahldsxXG/
 WdiJyhA+zX0X35beD1SFoa4eT3te76FuG6568Kelqjz7cwy+Y+xEhGpG7mYXxA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] backlight: Fix kernel-doc
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112192744.850142-1-manuelebnerli@mailbox.org>
References: <20261112192744.850142-1-manuelebnerli@mailbox.org>
Date: Fri, 13 Nov 2026 09:34:18 +0100
Message-Id: <179455885818.1992209.12136301208667386859.b4-review@b4>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This comment describes a struct as a kernel-doc. Format as such, fixing:
>   $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
>   Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * CGBC backlight driver data

Please add driver name in commit title:

backlight: cgbc_bl: Fix kernel-doc

-- 
Best Regards,
Thomas Richard

