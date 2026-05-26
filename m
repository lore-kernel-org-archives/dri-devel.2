Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0416CCD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 06:42:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FEE10E1BB;
	Tue, 26 May 2026 06:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="evwseG7k";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64EFC10E1BB
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:42:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A69641705;
 Tue, 26 May 2026 06:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBB1F000E9;
 Tue, 26 May 2026 06:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779777734;
 bh=lWCr0wfNh5QTh0SmkZIX7ZvQkTjjhyDs1VLraREYjyc=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=evwseG7kuNBk0DcNQKTjg0KewN7GR7hJD8k+q389h0tQsjvWyWeACLvhylbbChavm
 h4EKI7klewfTaIjkIm710qbkmyr7PoFGTHsPSLIkBsxq47ZVlOqH5vGFTz+RdwYjHM
 iAgWU57vOd7HjOdqO5RQbkQPrtuu1jwX0W3mGIOP/Y44Ky9Vlm3ZPTxPDmutJQu2FC
 a4yHn+l+YOmTXlDYFJoBvh85QnJVK/iDlerdIkIInDEArx9rGL9WKBgGM7vS/jfQXn
 sqrc5pjjaaChQD8qEZofWs45lKn7IFsLcyKtQ68H9Z2XFskzu6PfeCVsYKK14qpzJp
 87oEbe+AwZuZA==
Message-ID: <1f0d964dcf8a32297b9d5a854309c736@kernel.org>
Date: Tue, 26 May 2026 06:42:10 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Javier Martinez Canillas" <javierm@redhat.com>
Subject: Re: [PATCH v5 0/3] drm/bridge: ite-it66121: Switch to HDMI helpers
 and fix DVI output
In-Reply-To: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
References: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Phong LE" <ple@baylibre.com>, "Robert
 Foss" <rfoss@kernel.org>, "Sen Wang" <sen@ti.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
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

On Sat, 23 May 2026 12:40:57 +0200, Javier Martinez Canillas wrote:
> Display output does not work when connecting an AM625 BeaglePlay board
> to a DVI monitor, because the DRM it66121 bridge driver assumes that
> the sink type is always HDMI. This patch series fixes the issue.
>     
> Patch #1 reworks the driver to use the HDMI helpers instead of open
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
