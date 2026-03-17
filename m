Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E7FFED9EC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707E010E6EA;
	Tue, 17 Mar 2026 16:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RXB2bP+k";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D26510E70D
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:42:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6A1A0C5505E;
 Tue, 17 Mar 2026 16:43:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 400A95FC9A;
 Tue, 17 Mar 2026 16:42:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4220D10450641; Tue, 17 Mar 2026 17:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773765770; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bLsc4+8qs5+50vcwjOtVmeMNN9UxwhJGOEwDZgFbCOM=;
 b=RXB2bP+kuU66BG+G/eM5WL41ypHQeXLDBGCGUuyoibrZgwQqlGF18zD03uaz5B22bvHk1c
 /m8/iSuUZPbGrJZSBh9sLU3NGrbZiHji9VwlnL0jEuYdNYlIqTTvokMC/4sSvj8uj8SyPj
 o3ExMXqVsORT/LCC8SByfqg3XA1EhdE/PN8qAf8BqkcTeq2FHg0P3SV8kmXQN4G1i0s/+H
 XL0U5C78QXnj1EezRAl/1jJQLD2X57055zA3BOTIFSq4iFNSXx/y5TPTkzEj66eVQJc395
 Pt2GUY+VhV7GQ8q6g22oXurjHNONGe3igsChs1cyzT7sww6E/eVPLQ6y4edMSA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
In-Reply-To: <20260305155921.659550-1-kory.maincent@bootlin.com>
References: <20260305155921.659550-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] drm/tilcdc: Remove tilcdc_panel driver reintroduced by
 a merge
Message-Id: <177376576631.1805576.1908129871551790151.b4-ty@bootlin.com>
Date: Tue, 17 Mar 2026 17:42:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Thu, 05 Mar 2026 16:59:19 +0100, Kory Maincent wrote:
> The tilcdc_panel driver was removed by commit 8f1e1ab9c794 ("drm/tilcdc:
> Remove tilcdc panel driver"), but was inadvertently reintroduced by the
> merge commit 8b85987d3cf5 ("Merge drm/drm-next into drm-misc-next").
> 
> The regression went unnoticed because standard git commands such as
> 'git show' do not expose the change. It was only spotted via
> 'git show --stat':
> 
> [...]

Applied, thanks!

[1/1] drm/tilcdc: Remove tilcdc_panel driver reintroduced by a merge
      commit: 1d3864cf9cac2562d018f080982c231a64dc6cfd

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

