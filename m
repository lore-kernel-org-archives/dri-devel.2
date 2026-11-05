Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F48606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=k2lqRhYQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D38A1122CC;
	Thu,  5 Nov 2026 09:58:12 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F341122CC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:58:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E04DBC69156;
 Thu,  5 Nov 2026 09:58:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B759D5FF85;
 Thu,  5 Nov 2026 09:58:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E876103291FD; Thu,  5 Nov 2026 10:57:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793872682; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GGwd10+UV7oF3yQFv28KX3rG/BdRDcdmvcHFRYR63Gw=;
 b=k2lqRhYQYGiir1oyFjpLl2b0S8lmp9L62kTX7RsYNETHPu0Rf4mZM6EjLHqe+9kAMFNqnB
 6WwpR5/iAZtbP3Iovf/lp1cBufy0K9OHNw9MN9eXiITUKm4gViBsbT0t9skOrOZDZxitpR
 sVXEnTlOVz8qosxjU2hZ50UKMzarXH/kTT6ti23csYW4UMvperkeM00LHf9uI20HxbqB9n
 S1HFZh+MyP5cQvt9rThxXVONSrwYMBp6jh0wpG8s6QbK8vc6VhD+dWNOuvE/YcddORBEXK
 g2HGtqEKWoeQS9Vpoge20gnbb56aHVaYIDFm2OeZHGDV9/UG4TmSqac+9Z9SHg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 10:57:56 +0100
Message-Id: <DMN6SIQLWFK7.2O38VBNNDP1RX@bootlin.com>
Cc: "Paul Cercueil" <paul.cercueil@bootlin.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maxime Ripard" <mripard@kernel.org>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "Raspberry Pi Kernel
 Maintenance" <kernel-list@raspberrypi.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 3/3] drm/vc4: dpi: inline vc4_dpi_init_bridge() into
 vc4_dpi_bind()
X-Mailer: aerc 0.22.0
References: <20261013-drm-fix-of_get_bridge-build-regression-v3-0-0b4c0b65be82@bootlin.com>
 <20261013-drm-fix-of_get_bridge-build-regression-v3-3-0b4c0b65be82@bootlin.com>
 <1202bdc6-afde-45e1-8a32-c64f9424a65d@igalia.com>
In-Reply-To: <1202bdc6-afde-45e1-8a32-c64f9424a65d@igalia.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ma=C3=ADra,

On Sat Oct 24, 2026 at 3:03 PM CEST, Ma=C3=ADra Canal wrote:
> Hi Luca,
>
> If you go ahead with this patch, could you merge it with [1/3]
> Personally, I prefer to keep it as a separate function. vc4_dpi_bind()
> is already a big function, with several initializations. I have the
> impression that vc4_dpi_init_bridge() makes the error handling more
> clear.

I agree, and that's why this inlining was not in my initial work. It was
suggested by Paul, but since there are other opinions against it I'll just
drop this patch.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
