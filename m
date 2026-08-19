Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A859C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878BD10E0FC;
	Wed, 19 Aug 2026 09:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bZwzvpcG";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED2E10E0FC
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:16:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BC17C1A1730;
 Wed, 19 Aug 2026 09:16:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8CC5D5FF42;
 Wed, 19 Aug 2026 09:16:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE2F511C754FE; 
 Wed, 19 Aug 2026 11:16:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787130997; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FLEQGctqRH4mPSfpL7F8ZM2AFKMq7I+grExzdkihmlM=;
 b=bZwzvpcGW8jwCbXD57DGEAWj9t4LuJ0rG11nW17psURE5XLjkh1J5+eporpb0qkf9oZ9Fu
 +e6+WiJ4kVgKPquwnrTU/CS1a2ZnpLGq7k1NZxSu8waoNCAiJyGgpvCJ6lhhYlUiOde0/Z
 hWDtdXsua0dQtnrEftamxjJc1ikS5+ctAmnD3DKYMlbwhajAPRB7v+ehUcw5oJ90nKGv+Y
 EhuhaPCGnt4lEPj9sM3UUIkc1ma2Azv8GW6rh3YBxUHl1NRGkAdftzLu+vmSp257iPcb2z
 fTWf23wTAhMBpxiwCUM3CNcwrIc2QZp/2GZJ8zLibakQvc5e0DXAvIScHBKpWw==
Date: Wed, 19 Aug 2026 11:16:28 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
Message-ID: <20260819111628.7c7a28c6@bootlin.com>
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Esben,

On Mon, 03 Aug 2026 16:57:03 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> callers has a chance to handle the failure.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

With fixes tag mentioned by Luca added in the commit log,

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
