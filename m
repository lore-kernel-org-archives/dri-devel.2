Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F741606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jreWHA1+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AC0112F34;
	Fri,  6 Nov 2026 17:06:04 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EB710E436
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:05:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 124624E41474;
 Fri,  6 Nov 2026 17:05:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BE1A05FFBC;
 Fri,  6 Nov 2026 17:05:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 29147103291BA; Fri,  6 Nov 2026 18:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793984750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/PEI2oIc4mMwtb7zmvNQaJQdzbux11a3bM6llbnSv/Q=;
 b=jreWHA1+3fmEtiYod9TgBtP1CemHbyDLgWzjWCyz8cBoHblECxeVS3IQXUv5+oSLWPNqWE
 z5IUkFsbwjXA9h6+L2Ux7xBBB9AYPw4kIEFiyvu866BxfA+xisOZ6WbK845XmowyScxn+g
 bnr7kOvOg3m6PXgUpIxUbPGWjxIHapIwnhHlbESHq0bHUU1icQzIMhHv/V5p/CW3Xa5jX6
 jswLVrLhpGDZxShjiqF7FCM3PWpj09bvQ26RE3E8HTw6K0JOpgGMVErDkqKjL0/APZa0/N
 Wm4r+dtjEeZgLesoHEkgfj/ux4imxRR7CJJkntvJGBagXhA19HooKj4Rbb3+gQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 18:05:43 +0100
Message-Id: <DMOAILVQDY3B.14KEVXYVAW0HV@bootlin.com>
Subject: Re: [PATCH v2 1/1] drm/bridge: tc358767: register DP aux bus even
 in DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Alexander Stein" <alexander.stein@ew.tq-group.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260929130701.1029644-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20260929130701.1029644-1-alexander.stein@ew.tq-group.com>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Sep 29, 2026 at 3:07 PM CEST, Alexander Stein wrote:
> Even if DRM_BRIDGE_ATTACH_NO_CONNECTOR is set the DP aux bus has to be
> registered. Move the flags check after registration.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
