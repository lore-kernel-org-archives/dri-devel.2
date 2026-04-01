Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142DAD35162
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F6210EF29;
	Wed,  1 Apr 2026 11:43:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rN0EYP7l";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F64B10EF29
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:43:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id DA1534E42491;
 Wed,  1 Apr 2026 11:43:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 860DA602BF;
 Wed,  1 Apr 2026 11:43:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DA561045013D; 
 Wed,  1 Apr 2026 13:42:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775043781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/dGOsN+Ha1KnNF3V0hpjrjlsWOPxWmORU++/RLEZRAI=;
 b=rN0EYP7lzgcxmAhA6isrn+hA4waEanFywvN/k2glNG1U3/MCf4ezX5/bJLCs4C3PJLDKzU
 XG3BdfLdV7mdWI4kbOEfPLGgMEUxApu9Y5GXYHYeW32yjtTqZatvWFM1aEAu5e4/xf4x3A
 +ZKFbM70Lg5zWDfisPrVffdbmFMGuEz7jKW+Ea8L7R8GjzjT1SjJp3r6WBwfwzxau1WFod
 NhyvLu+D1j3YqjSjyrIX5+Qnt3MVPndcwgrGc/6PQMVIwNJ+tsDmaBNjEXewON6mua7vOW
 G4MrBOB0+vMeOigiA/yXWaRuXRP+bcFHfHqBDgt5bbJ8Ne2QB3klyjSFrxO1Fg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 13:42:56 +0200
Message-Id: <DHHSI5QRUDJQ.2IE96HSJ2SD7P@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Jonathan Corbet" <corbet@lwn.net>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 2/2] Documentation: drm: Remove drm_atomic_state
 rename entry
Cc: "Jani Nikula" <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Rob Clark" <robin.clark@oss.qualcomm.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260331-drm-drm-atomic-update-v2-0-7e8fe6ddcd32@kernel.org>
 <20260331-drm-drm-atomic-update-v2-2-7e8fe6ddcd32@kernel.org>
In-Reply-To: <20260331-drm-drm-atomic-update-v2-2-7e8fe6ddcd32@kernel.org>
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

On Tue Mar 31, 2026 at 4:41 PM CEST, Maxime Ripard wrote:
> We just did that item so we can remove it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
