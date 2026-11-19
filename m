Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC09606CB1A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lPn+qSfH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034B5112508;
	Thu, 19 Nov 2026 15:06:42 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8189C112508
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:06:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4FAE01A1710;
 Thu, 19 Nov 2026 15:06:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1CAEE60237;
 Thu, 19 Nov 2026 15:06:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6AA7F11BC0C8B; Thu, 19 Nov 2026 16:06:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795100786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=clVRO4n/YgzV7BQnfL/nP3g53VntNfFFRk6rM9i6WUY=;
 b=lPn+qSfH9qzPIahNDYLH5YwIouK9yKi/FYCKNasW0yZoz/2zH0OnZAf4pLIKGbV0Ozhj8C
 2gBBVeWMR6B31/qov6AlFJCYf9r1QCrjUuL4hivpi6c3VglwS9CMzLWRjD3CRyfmb4yxaY
 zbOao19oDqmpmETUz362stWWYdh109rsNissDA1iocz5eaDin8DgfpK3DtGBriajFRWUxC
 RgCAPJmPpkeweeySQpTLjHdsSDA15JdkxMK68jnzTf6/VbC4I1GgmKSdc2aOtC7bjtQI2F
 ZoLICTS27GofQbTOOs9he5sO0WH399jfHS51LkmJeYlLmFa0qUleYop50nS3xg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261012154449.42015-1-sinha.aryan03@gmail.com>
References: <20261012154449.42015-1-sinha.aryan03@gmail.com>
Subject: Re: [PATCH] drm/vkms: Fix kernel-doc parameter and member names
Message-Id: <179510078399.1769064.18348312937674902862.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:06:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 12 Oct 2026 21:14:47 +0530, Aryan Sinha wrote:
> A handful of kernel-doc entries name things that do not exist. struct
> vkms_output documents encoder and connector and misspells wb_connector,
> struct vkms_connector calls its base member drm, vkms_crtc_init() lists a
> crtc argument it does not take, the CRTC plane helpers say crtc_config
> instead of crtc_cfg, and vkms_config_plane_get_type() is written without
> the get.
> 
> [...]

Applied, thanks!

[1/1] drm/vkms: Fix kernel-doc parameter and member names
      commit: 55f54b0dc193f4c9a78ae3390e3b0da6b228b4a4

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>

