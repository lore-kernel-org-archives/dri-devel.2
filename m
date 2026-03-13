Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF96107BCCC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EF510ECF1;
	Fri, 13 Mar 2026 16:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vtMfS975";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3E610ECE7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 16:57:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CC6F31A2E1B;
 Fri, 13 Mar 2026 16:57:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9A9D560027;
 Fri, 13 Mar 2026 16:57:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED4C910369F5B; Fri, 13 Mar 2026 17:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773421043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GunX44sdPxo3G2fzl0sFW70WnjttiuYI8fYE7rzWEf4=;
 b=vtMfS975zyzcnz+C61KB4ixj6CvyQQGeK+B53NG7Gihhsh0SJzpyneDfJBbZm7KrJfX/FL
 Bxu+Nerau777hOQ0wWVMY5mzAb0+qOcYixcxjqNZhY/Br+3qZmu7ZyMoV9g45dMiDrBQTU
 y+XsZHVki3dxTL/4uGrRVGxv+yDiRkTeCQlsBlD6E+8dtm2aVQwpb35o3F7izif28vC4Ax
 Grf4Ec7PjfAuorssRR/J8TFmnC6PoNrzOitQeemDPgwKJJLAUy9O6Im0fInyGe3O0EPISE
 H0Y+KOrIoaZzeAQfvuJS7u5Ml24WbqHEYVs5T1q9rMr1x3WJfO0C3e2Ci/0tGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 17:57:17 +0100
Message-Id: <DH1TAHMJZPCX.F7FMMA3LQ2NO@bootlin.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Herve Codina"
 <herve.codina@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/tilcdc: Fix type mismatch
Cc: "Bajjuri Praneeth" <praneeth@ti.com>, "kernel test robot"
 <lkp@intel.com>, <thomas.petazzoni@bootlin.com>, "Jyri Sarha"
 <jyri.sarha@iki.fi>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20260305163907.717719-1-kory.maincent@bootlin.com>
In-Reply-To: <20260305163907.717719-1-kory.maincent@bootlin.com>
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

On Thu Mar 5, 2026 at 5:39 PM CET, Kory Maincent wrote:
> From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
>
> cpu_to_be32() returns a __be32 big-endian value, but the compound literal=
s
> passed to tilcdc_panel_update_prop() were typed as u32. This causes a
> sparse type mismatch warning. Fix it by using __be32 as the compound
> literal type to match the return type of cpu_to_be32().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602200130.LjofC7YE-lkp@i=
ntel.com/
> Fixes: 0ff223d991477 ("drm/tilcdc: Convert legacy panel binding via DT ov=
erlay at boot time")
> Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
