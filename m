Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59273606BF65
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EjfTl75B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801AD10FCF0;
	Wed, 25 Nov 2026 15:42:41 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9549310FD04
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:42:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 18E654E41601;
 Wed, 25 Nov 2026 15:42:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D95E360480;
 Wed, 25 Nov 2026 15:42:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 236F611E6A0D5; Wed, 25 Nov 2026 16:42:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795621351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=QrZy3+lhRmQHvF7PcBAfYtc4rhFm3+J8F9mGHGADgfY=;
 b=EjfTl75BrRCZYU4JoDWaf/E7vLb9RVOGESPtlMBMI8u0yeuDgfEBvuVHBguGYUU/OZFbD8
 GS5b1O5X7znThnWGHfAR1E/2N8ecGmSVFSP9QFPb9ovlwiOQhQBMoHjiSzINKvgCW++ngj
 9q5EEszawlsT/mbl1cbTfIhMJEIsfHgmfxWwqSQbXJ70UWiX63TrxMGOUWGzAksFtBH+U3
 bXcGcanETFVbzGZfuvomNhxZteNr2duXK/cW7G7SmZ0juePS6NYAe3gE+W156h3u7x2yaE
 IMUHUqTlgrPxDfhYPfS/lJ3wFYQ5GZPB4+b3Vh00sweAdToxY4IoXw3usy1Qlg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 David Lechner <david@lechnology.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261111092404.2117072-1-arnd@kernel.org>
References: <20261111092404.2117072-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/mipi-dbi: hide unused mipi_dbi_dcs_read_commands array
Message-Id: <179562134757.656989.4812864039990894547.b4-ty@b4>
Date: Wed, 25 Nov 2026 16:42:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Wed, 11 Nov 2026 10:23:55 +0100, Arnd Bergmann wrote:
> When -Wunused-const-variable is enabled and SPI is turned off, gcc
> warns about this array being unused but defined locally:
> 
> drivers/gpu/drm/drm_mipi_dbi.c:79:17: error: 'mipi_dbi_dcs_read_commands' defined but not used [-Werror=unused-const-variable=]
>    79 | static const u8 mipi_dbi_dcs_read_commands[] = {
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] drm/mipi-dbi: hide unused mipi_dbi_dcs_read_commands array
      commit: 75f3faa2835c9bf588caeedabc10d5676aa01f79

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


