Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7460FED7B9C
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A7F10E5B9;
	Tue, 14 Apr 2026 10:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JdIl6pFb";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2710E5B9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:27:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D2C801A3296;
 Tue, 14 Apr 2026 10:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9A2245FFBB;
 Tue, 14 Apr 2026 10:27:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 351B410450970; 
 Tue, 14 Apr 2026 12:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776162458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=h8ey9CmN38Fhwlg8yQDoqTDnddfyH7yrk+3c7ZyI9Ls=;
 b=JdIl6pFb9bdbuXpenlZl46AJrCBnaogmstXLpxMVMJNeW/ib0YQorQO4t42dhhwhfc/qNI
 900ZBrGyy1QLL7SrPWsWXNmZnqMjZm/V58EGxI23pHxtxSXgLGOZCJTkGVDPbaf5M84PPi
 Z9w/i7dN6FJypePxDlqQ/74HBlFXWO+NwYV9L/cCE9X8US0/i05r4zTCEUleWHsbSGs3Me
 ZnhuwKewgVdYRzt8iN+o+3abC/Q0RO1kby8wbfmdcJMzgE4rMxuR9Y8FssoQuWpA4baDJb
 rx9YXkZl690Y/o9ov7Tk3rUpWH5Hps25hoI5Y3ZML395ChLdxZ8q8W2UnWpHuQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>, stable@vger.kernel.org
In-Reply-To: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
References: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
Subject: Re: [PATCH v2] drm/arcpgu: fix device node leak
Message-Id: <177616245447.642738.16922563942350413002.b4-ty@b4>
Date: Tue, 14 Apr 2026 12:27:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Thu, 02 Apr 2026 18:42:20 +0200, Luca Ceresoli wrote:
> This function gets a device_node reference via
> of_graph_get_remote_port_parent() and stores it in encoder_node, but never
> puts that reference. Add it.
> 
> There used to be a of_node_put(encoder_node) but it has been removed by
> mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
> arcpgu_drm_hdmi_init").
> 
> [...]

Applied, thanks!

[1/1] drm/arcpgu: fix device node leak
      commit: ad3ac32a3893a2bbcad545efc005a8e4e7ecf10c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

