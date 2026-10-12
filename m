Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EB2CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 19:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF2610E474;
	Mon, 12 Oct 2026 19:18:35 +0000 (UTC)
Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C73110E474
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 19:18:29 +0000 (UTC)
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
 by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id E75B0121120;
 Mon, 12 Oct 2026 16:18:25 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
 s=dkim2026; t=1791832706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLwzKw255x2Ho+brc0LP/HOoYhbCyaMdf4o1Ck8r4WQ=;
 b=sZtJZbucWJAIyNzvIH/IDUrL5x1li1A9zubNutfoU2e9GR0Xdv7YTZWpQTeG3U6Sa/xL6y
 EtoYEYxvj8acqI75Yo4rPSZjsa0kfpweu/N63YGiZaG18YnRHd4fkC9STgZTlBYnZNC1Xw
 2mKkrhAqhMwHfUtyT5ZopNTMPNp9UkzNfDlrIwy25KX60wP/CRJ8M8Lwz3KhIJZrb2QKjw
 jTwYz+JMZePZ0rBFEJOMbHYkpTIifP5c0BWAKGxWxOey/6mBlDK1SSgw38PJh6B9CCcr2O
 1DvuDAXTrJy3lmINple2ikR0m+WFmQjBL1cZgKNeIh/z42Q+INjisvRtzs3h1g==
Received: from bd06e904.virtua.com.br ([189.6.233.4]) by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Mon, 12 Oct 2026 16:18:25 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Oct 2026 16:18:25 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Louis Chauvet <louis.chauvet@bootlin.com>, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, Melissa Wen
 <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/vkms: support more formats and fix RGB565
 regression
In-Reply-To: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260928005301.367977-1-matheus.aalmeida@inf.ufrgs.br>
Message-ID: <1bec074941eca133b8d555ff57b1e14e@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5
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

Em 2026-09-27 21:52, Matheus Alves de Almeida escreveu:
> Hi,
> 
> This series adds support for RGB332, BGR233 and BGR565 writeback. This
> is done with new helpers added to make conversion easier. It also fixes
> a regression in the RGB565 write conversion.
> 
> The argb_u16_to_RGB565() code currently truncates the resulting
> channels. This behavior was originally fixed by commit
> ab87f558dcfb ("drm/vkms: Fix RGB565 pixel conversion"),
> but the fix was lost during a refactor in commit
> cc4fd2934d41 ("drm/vkms: Isolate writeback pixel conversion functions").
> The rounding behavior has been restored using the new
> argb_u16_to_channels() helper.
> 
> Matheus Alves de Almeida (5):
>   drm/vkms: make argb_u16_to_RGB565 round resulting values
>   drm/vkms: support BGR565 writeback
>   drm/vkms: add a helper for channel to argb_u16 conversion
>   drm/vkms: add support for RGB332
>   drm/vkms: add support for BGR233
> 
>  drivers/gpu/drm/vkms/vkms_formats.c   | 136 ++++++++++++++++++++------
>  drivers/gpu/drm/vkms/vkms_plane.c     |   2 +
>  drivers/gpu/drm/vkms/vkms_writeback.c |   5 +-
>  3 files changed, 112 insertions(+), 31 deletions(-)

Hi,

Gentle ping on this. Has anyone been able to take a look at it yet?

Thanks,
Matheus
