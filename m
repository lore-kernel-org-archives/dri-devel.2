Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE8606A338
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X4PPoGho
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC3F10E171;
	Wed, 11 Nov 2026 10:02:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B249710E171
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:02:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id EE8E34E41571;
 Wed, 11 Nov 2026 10:02:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A34686017E;
 Wed, 11 Nov 2026 10:02:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2702111BC163F; Wed, 11 Nov 2026 11:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794391362; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=C/ZzCoSTLGLL9NNSJn3WeO3M+A/iJcirek8/MKvgyvM=;
 b=X4PPoGhoRxeBJW+5FTCNAMpgxfexvQDcRK0yPdZCyLxFpEFdOlo6WTX0v85qWELsJbC9dK
 AM97nlZkzwYTAeb/QWUdnR1ilp7LEO3E9SRnoW5EVIDWrdNo9TJHumngf6dEfyP9jJHMya
 nzl33y9p5PqsER+qUnx7BroWvm48Z14thRsFi1J58OlOyLiY9Y6sqHQ49G1Klrc71X5iRf
 SO/wnY58NyhrFoiIASHZoUWJf3j34R+Kpj1irK2be5+KyMww0ubAA0+XW4RIjhqpdgqSb0
 cDZgjnts7kTzGirOVnLrdZQ+cw6tqHhyeH3W7F+3pQ0Orv7O9EZCZ6i9vlscPA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, Pengpeng Hou <hppiscas@163.com>
Cc: neil.armstrong@linaro.org, rfoss@kernel.org, 
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260920034833.18874-1-hppiscas@163.com>
References: <20260920034833.18874-1-hppiscas@163.com>
Subject: Re: [PATCH v2] drm/bridge: sii902x: validate I2S data lane values
Message-Id: <179439135576.1435014.6150001319087782287.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:02:35 +0100
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


On Sun, 20 Sep 2026 11:48:33 +0800, Pengpeng Hou wrote:
> The sil,i2s-data-lanes property reader bounds the number of entries, but
> does not bound each entry's value. Those values index the four-entry
> i2s_lane_id table when the audio FIFO sequence is built.
> 
> Reject unsupported lane values before indexing that table. Report the
> property name and invalid value with dev_err_probe() so the diagnostic
> identifies the faulty configuration.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: sii902x: validate I2S data lane values
      commit: 444b7116e7ef1fdb5f7db3bc1f74b20098d062d4

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


