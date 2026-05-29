Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EC3CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0DB1120EF;
	Fri, 29 May 2026 15:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ccZIdb7/";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AEA1120EF
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:27:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id F26D8C6245E;
 Fri, 29 May 2026 15:27:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 23B09601FA;
 Fri, 29 May 2026 15:27:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B3EFE10888CC6; 
 Fri, 29 May 2026 17:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780068472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=F4uCdXNfiwQNh91uOu66OPSrfuykGxUfPXJDYP1eNqI=;
 b=ccZIdb7/N9sh4PPCDmvqdPiCH2jNyxQOsI+0/L31EBuPan4F7KWbRxtniLYHngw8HfTelW
 ub2hGIPwYVawr1nm+WNWS2Pqz3K7nH0jwy66vd5fv41D3MncW4bATXXuwDBZYdZt71+roi
 IopjOjIcHveNcANRR1Lq4VP4kMxqkK6pKUsjrgUI4d65WnVzOR6RlafUTU2Oe/VaDoMs9/
 iXzWTt4axrwmrOikZGqLulEBj9/Nw4FlT8tFnfXZ3LwavtlcjXyODt6YJGRXRCRjcz298l
 /+AzY2jMp+6cZyvCP5bZM+KaYhJxEGlyAgsprvkpgxM/ANPMJfrtGiyKYfK7XQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] drm: bridge: ti-sn65dsi83: Remove NO_HFP and
 NO_HBP mode flags for LVDS stability
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, alexander.stein@ew.tq-group.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260527085736.920390-2-tessolveupstream@gmail.com>
References: <20260527085736.920390-1-tessolveupstream@gmail.com>
 <20260527085736.920390-2-tessolveupstream@gmail.com>
Date: Fri, 29 May 2026 17:27:39 +0200
Message-Id: <178006845995.48869.11860516429821760319.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Wed, 27 May 2026 14:27:35 +0530, Sudarshan Shetty <tessolveupstream@gmail.com> wrote:

Hello Sudarshan,

> [...]
> Remove MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
> so that HFP and HBP timing information is transmitted to the bridge.
> 
> Reference:
> SN65DSI84 Datasheet, Section 7.4.7 (page 20):
> https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=1776924088430&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84

Everything starting from the '?' in the URL is unneeded. I can fix it while
applying this patch (next-week perhaps).

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

