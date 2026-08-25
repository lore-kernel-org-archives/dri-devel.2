Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AC0C61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6553210E1F0;
	Tue, 25 Aug 2026 16:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0bTge3mj";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D98410E1F0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 16:12:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id F3E6D4E413AC;
 Tue, 25 Aug 2026 16:12:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C9675604C4;
 Tue, 25 Aug 2026 16:12:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9966611C7A69E; 
 Tue, 25 Aug 2026 18:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787674373; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dzDMQ0w5QtWUlP7xIKvzzUBI4k5tUc5QhJim+fpevt0=;
 b=0bTge3mj9DArhJKfj6WVCLWlPP0W210S+QEx7NoC4/NSi9rSAIt6rzZvY40KcxTIsRNmjH
 o1pyOgWNlcdER4NR6pwcNBsC5VVK+YHEoOAQt6Mp9At/zhjYRp+zfgVUh8aeY6RRaEHNYL
 cMRZK7hbt5K0dbakOmiFTYu9MnUOT8tqzRX+x56tYIrEfE9ayF7HS8q18mpMObvCaSPuX6
 akPVykHfoFWfV/YBIERrIDnksKSxomIgL1V/JR/U8T0Ucr4jTn4AcwReXp6Ww2RpReE2By
 HHaKZ7UTeGAPeGMaEV7SRN3hkB4x2ycbkJRVC0JUCSa77G02WUeb7Vc6fNf56Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:12:45 +0200
Message-Id: <DKY5OA542PBJ.31B7YE52RGVVN@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 5/6] drm/panel: Use managed helpers in display vendor
 panels
X-Mailer: aerc 0.22.0
References: <20260812152535.82238-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812152535.82238-1-osama.abdelkader@gmail.com>
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

On Wed Aug 12, 2026 at 5:25 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in display vendor
> panel drivers and drop the corresponding manual detach and panel remove
> calls from remove paths.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
