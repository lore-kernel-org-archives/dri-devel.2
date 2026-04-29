Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BF9FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BB110EFAB;
	Wed, 29 Apr 2026 11:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="n5XYwwFy";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E7B10EFAB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:42:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B05C74E42AF1;
 Wed, 29 Apr 2026 11:42:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 83FF8601DF;
 Wed, 29 Apr 2026 11:42:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 64DC710728991; 
 Wed, 29 Apr 2026 13:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777462943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=anO7aaWdLJW9UNfbjRUxW3fts3q/GaVgmDjzm3sUBiw=;
 b=n5XYwwFy2JBRaWNCzH23eSoWSmDz9W3kO1w+FyeBbMb+KFFSZdL/o7wLcMGxf/kg7e2SLW
 XkVaLX2FhWJnsSESYhbs6X5W24ciSh8rCRXzyU2A/LRg/MvhK5ztYQHbPuWHdsySn5yQUr
 QG9Txq5sV/TbqbkKa0Ah8SFYxRUFJ8InyzYo16JQiCrPhKtYGdZ5AKZQcH8wB8tU7ku5bO
 p3r3rX3/McHTW8GXBx2crkQi2YSO4bFXOOBhVoXEsZIPh8k3a3eBQOY/0fFgaLdBSRnscJ
 QDzTb3NJfxoZ6fjAsgQ4SmhYTcQ51rXj9XGF3uawNrVH+wljRuPHJx7hJbQXPQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:42:20 +0200
Message-Id: <DI5M0YBPLHZC.PKAWCS7KX9XG@bootlin.com>
Subject: Re: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda
 component_add fails
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
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

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
>
> Check the return value of devm_drm_bridge_add().
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: d28726efc637 ("drm/sti: hda: add bridge before attaching")
> Cc: stable@vger.kernel.org

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
