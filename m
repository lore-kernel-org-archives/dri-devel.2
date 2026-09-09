Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FB0C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD36610EFDF;
	Wed,  9 Sep 2026 08:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EtDb5q1B";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC1910EFE8
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:57:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 85FC14E415AB;
 Wed,  9 Sep 2026 08:57:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5295660448;
 Wed,  9 Sep 2026 08:57:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44EF211C7AF3D; 
 Wed,  9 Sep 2026 10:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788944255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=K7WgL6+f8K1l1YGJqgjd7QzcT6qrbNoACdHiMJAEzPA=;
 b=EtDb5q1BHwJtbKr940+G+p3VavVP9PvV2Va29CQOwusfoH7HTAiJfQb7AuSXrtb9k0yXjY
 OAWxxv2MmstQzUAwZwK4oDfTpTRWrx7c40sM6ykmlS7VTNBEV/lSqP7xiLHZKo1kEiVZm5
 7NQDGeJFU5dB9Nj4Kc93oXJO2LVJ6COFsonqwzKklur1JBEl78mbtjtxvTPV46aPJlff95
 m0G36VjqjeuWnRZG64lIh7kO1TUJGp7hcySEPci1XU9QoaGxru2XZPwkXy3PVTeesiF904
 56aKpze2LTIL2i0nqbgYNso/cfcbJB/FGKmyyqeTorItvoez7Sv+PnD5fDxhtg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 10:57:29 +0200
Message-Id: <DLANT6TWBSJ0.2C6STJ9VSJU8Y@bootlin.com>
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags
 via atomic_check
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <tomi.valkeinen@ideasonboard.com>, <francesco@dolcini.it>,
 <leonardo.costa@toradex.com>, <stable@vger.kernel.org>
To: "Leonardo Costa" <leoreis.costa@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Jul 6, 2026 at 3:24 PM CEST, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
>
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
>
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
>
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
