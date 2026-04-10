Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0114F36BAA
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E16210E0DA;
	Fri, 10 Apr 2026 05:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Azw85VCH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F71410E0DA
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 05:20:21 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 42E37348;
 Fri, 10 Apr 2026 07:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775798330;
 bh=brWxWAEWV83fdekCQcetNGlEbink0WMdXxS2xDyQDCc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Azw85VCHgDNZFuS0Q5cj46c0WgbxjY/WffG2NMaAWQf9oT43PnMiG/FdSESK+QmhY
 BIkS6AaL/EyZjeOHF38ZpYIULsBMMQnJLB6jSzfbeiEpPiofOih72wZO6+qBeN8f7R
 5wyhp6gJq9pxzRwhdOfh+1ouYx+4WcnPVpeK4E0Y=
Message-ID: <9d2f6113-bef8-46f7-a989-4003270c8f4a@ideasonboard.com>
Date: Fri, 10 Apr 2026 08:20:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: rcar-du: Fix crash when no CMM is available
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20260408124205.1962448-1-laurent.pinchart+renesas@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260408124205.1962448-1-laurent.pinchart+renesas@ideasonboard.com>
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

On 08/04/2026 15:42, Laurent Pinchart wrote:
> Commit 3bce3fdd1ff2 ("drm: rcar-du: Don't leak device_link to CMM")
> refactored CMM handling, and introduced an incorrect test for CMM
> availability. When no CMM is present, the rcrtc->cmm field is NULL,
> testing rcrtc->cmm->dev causes a NULL pointer dereference. This slipped
> through testing as all tests were run with the CMM present.
> 
> Fix this issue by correctly testing for rcrtc->cmm.
> 
> Fixes: 3bce3fdd1ff2 ("drm: rcar-du: Don't leak device_link to CMM")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/dri-devel/CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
Thanks, pushed to drm-misc-next.

  Tomi

