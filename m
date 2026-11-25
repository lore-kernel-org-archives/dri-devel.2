Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A0606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lNm17mS0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CEF10FEB1;
	Wed, 25 Nov 2026 18:05:46 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF8010FEB1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:05:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DEC97C2BB3C;
 Wed, 25 Nov 2026 18:05:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E8C0460480;
 Wed, 25 Nov 2026 18:05:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3289711E6B08C; Wed, 25 Nov 2026 19:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gjJnzkcMPhEPJ5/q666Im5Q4FNxL6hZMRuK1yLefp/I=;
 b=lNm17mS0qvqEwvboUKPMid9SQ8CpkX8eQqI7GQDWRSmDkLE8f7U+brK688OGcnnK5igGZT
 2SbRz9c9mGnneagQcttxjU0NPGFtpfTBPT2BKMOHp8W9OluUMBoO95tN6xC27vlrPbx+zK
 J+kqtI/88n2fZMufcyEpxxAeV1J9dqjL7x6WYsepiaSbVpymESWecm4JRQuTBHXzOB450o
 OCDucrEeNc029XSVPqHLoYmuGNPCJl/fpqfKLZC+knKhugpO3UKANhiOJtg4Ho3x+JlLfx
 HzZ7WRBYaMoMnrmiA1aVQi2lkQl2tsG+Mv9KrdnBhBq8MeM4SZnKslVRrr1GNQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v13 5/5] arm64: dts: imx943-evk: Add display support
 using IT6263
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-clk@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261120-dcif-upstreaming-v13-5-966ac248773f@oss.nxp.com>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-5-966ac248773f@oss.nxp.com>
Date: Wed, 25 Nov 2026 19:05:04 +0100
Message-Id: <179562990453.846133.15615766820554855508.b4-review@b4>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 12:50:40 +0000, Laurentiu Palcu <laurentiu.palcu@oss.nxp.com> wrote:
> The ITE IT6263 based NXP LVDS to HDMI converter can be attached to the
> i.MX943 EVK board LVDS port using the mini-SAS connector. Since this is
> the default configuration for the EVK, add support for it here.

Acked-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

