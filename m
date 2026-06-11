Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05C8CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 22:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3840410E0E6;
	Thu, 11 Jun 2026 22:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UcoJBiKK";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A35710E0E6
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 22:15:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id ECC5D1A38BF;
 Thu, 11 Jun 2026 22:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BE4326000D;
 Thu, 11 Jun 2026 22:15:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3BB11106C8443; 
 Fri, 12 Jun 2026 00:15:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781216146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9J4tpQdzIFOSElx0nw+VDp1461+7Fmjhu65i3k+M360=;
 b=UcoJBiKKCfF4Hyva0GVbYiSeV9Zp5nfLIL6iAUyskVhmqmcalSCBSY8Il34aLNgEuwsY5d
 IHHLxSBdNJ8IC+tiPFjyGdoZsakDQ1DIo4Yv3stdHgCvkwh97Up0GMGw29vv6k+djXfg3l
 fFxgjfzcYIU6m+eOyb4E45NKo+XgdHlgzkabeCE3+mab4iiP+wz82o1U9L/Mpx0tIFhL8+
 Il9lU8xiIjLxEAHb5zIP81/5UE0Z/gIJIjOlOSrLKOjNXVHQ3Uz3XlBElmGypYLRHgFHjq
 vsanWML48LtS0+9hGujXVSuHDR7wL0BD9j3OORMbutdTMDXdqRZto6leQL3wcg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] drm/tests: Move test EDID data to separate .c file
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniel@fooishbar.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com, 
 Jani Nikula <jani.nikula@linux.intel.com>
In-Reply-To: <20260610-test-edid-array-definition-fix-v3-1-8ba947c1c453@collabora.com>
References: <20260610-test-edid-array-definition-fix-v3-1-8ba947c1c453@collabora.com>
Date: Fri, 12 Jun 2026 00:15:33 +0200
Message-Id: <178121613344.363421.14550491021391307675.b4-review@b4>
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

On Wed, 10 Jun 2026 18:43:43 +0200, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> drm/tests: Move test EDID data to separate .c file

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

