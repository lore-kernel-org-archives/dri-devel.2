Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E12CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3C810EE98;
	Thu, 11 Jun 2026 11:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oQDbrg9V";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C8910E1C1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 11:57:14 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48A2F497;
 Thu, 11 Jun 2026 13:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781179003;
 bh=GayVEXmjspQCJ2oKuic7KfnIc/ANvTHDE1M6PULQaTU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oQDbrg9VRiflCx4NQDPol/QNPs421dw5QYBIOkR6UZ4k820yrSWkT/pWDJ/wasY9n
 0w/DfxgU7MFVB2sB4RfczbIKzBOaq8JpIZklovpWkErcOFBT4kSSm9CEvCxeNehkNS
 XhvrbpBPRSOQ1xyu51apoWO7ZuGYAMPV1gGu8kds=
Message-ID: <dc0b6669-c7b3-42a1-99fc-c7850ac69abe@ideasonboard.com>
Date: Thu, 11 Jun 2026 14:57:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rcar-du: Drop superfluous spaces after assignments
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <80e30578b6dd86664112320616c460c48dbd79f6.1777881435.git.geert+renesas@glider.be>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <80e30578b6dd86664112320616c460c48dbd79f6.1777881435.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 04/05/2026 10:58, Geert Uytterhoeven wrote:
> There is no need for a double space after an assignment.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This started with two instances, and got copied each time support for
> a new SoC was added...
> ---
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c | 20 +++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Thanks, I'll push to drm-misc-next.

  Tomi

