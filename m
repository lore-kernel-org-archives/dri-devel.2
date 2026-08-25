Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4976C61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F49210E0EB;
	Tue, 25 Aug 2026 16:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V9aj1li8";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C725710E0EB
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 16:09:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1430E4E413AC;
 Tue, 25 Aug 2026 16:09:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB426604C4;
 Tue, 25 Aug 2026 16:09:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 531CF11C7A655; 
 Tue, 25 Aug 2026 18:09:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787674154; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=W77A+K/6FJx4qNGB/jQpfdXEPXT+m61Z/FpSeqbC+/M=;
 b=V9aj1li8jabD3JCnu1ZpkXwDu38ujwpEdx5aTWJHFyv6KwATWmzOGUBc7hlWFjLT3TZ2yH
 yqvwrRPjau5oKazbu1P3NCGnr5ZJvoJ6sA5OKfm4b9Jd1yozH21oN41Mc6HgCnNCMVu8ub
 vfG7b3MagFJRPssVicUKVtiATS4nGqcn0hNBBmFsYqqMz/IfCMNwkrpbM/t424T4kIkElV
 bOdgnJtB3P5fAVBZnV0u5EZamX/TqaTvwefiT9f9SOWvjmWQXGH+6Rj8/MSKzpgRpId4Rw
 FakxLzV+ssMfZ+ys51NR+5rqQqnFiH6SExC9Twfg/Si/ZOPtD6/oXuJgbHIhLg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:09:02 +0200
Message-Id: <DKY5LFIQ2JV1.3AL0LVJOYCA1@bootlin.com>
Subject: Re: [PATCH v4 4/6] drm/panel: Use managed helpers in Himax and
 Ilitek panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Ondrej Jirman"
 <megi@xff.cz>, "Javier Martinez Canillas" <javierm@redhat.com>, "Michael
 Trimarchi" <michael@amarulasolutions.com>, "Michael Walle"
 <mwalle@kernel.org>, "Dario Binacchi"
 <dario.binacchi@amarulasolutions.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260812151000.74799-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812151000.74799-1-osama.abdelkader@gmail.com>
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

On Wed Aug 12, 2026 at 5:09 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in Himax and Ilitek
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
