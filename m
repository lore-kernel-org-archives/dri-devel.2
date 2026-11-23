Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADB606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1KAIw7x3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7436D10EDD5;
	Mon, 23 Nov 2026 13:11:04 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE4A10EDD5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:10:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 407C11A1797;
 Mon, 23 Nov 2026 13:10:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 13063601E1;
 Mon, 23 Nov 2026 13:10:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A658D11E689D2; Mon, 23 Nov 2026 14:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795439454; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=iYTNCDdhiKPgMC3oUL4xKYF1Z1+fSJpoO0nf2r4oKIE=;
 b=1KAIw7x3WCOP+VMklmFO7H9LvbiZTkrdRWb9qNp49RSl+AScir3UsUK9/WvuRGVSZrFx/g
 j15CsuSslue+kOdwUh7fzTRc5MpyYOFhdFsVlH2G7n38KNbp2BQOyjSF86x9ccgXBvUxX5
 j4K+cMYTuP6Sy9aZ7Ipi+LbeJHcHDG4/k25O4VT3FKdsI3LKIaK0NxMJyUJ6sIE1MMOLZA
 f5MiKCllX4OBXQhfCcMhNkYvXBcJfnoqiwpfTJwIeQf6FAlrmpqsxwEIdJxzRUP7ZQFBde
 k1Mo1Wn/oYJBDHEk71QJ1zQdeyLSAY8uoKYMcBT/PkUUs7XrTTd1AIKyiZOMIw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
References: <20261106-drm-panel_bridge-remove-drmm_of_get_bridge-v1-0-c0ea3382b798@bootlin.com>
Subject: Re: [PATCH 0/3] drm: remove drmm_of_get_bridge()
Message-Id: <179543943896.276287.6561955057050063323.b4-ty@b4>
Date: Mon, 23 Nov 2026 14:10:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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


On Fri, 06 Nov 2026 17:17:03 +0100, Luca Ceresoli wrote:
> drmm_of_get_bridge() is deprecated. By now it is just a complicated wrapper
> to of_drm_get_bridge_by_endpoint(), and it does not implement bridge
> refcounting. Replace the only user and remove it.
> 
> == Grand plan
> 
> This is part of the work to support hotplug of DRM bridges.
> 
> [...]

Applied, thanks!

[1/3] drm: adp: stop using deprecated drmm_of_get_bridge()
      commit: 8c3eaa2149c1852a5701831bce07fac6cba98bf4
[2/3] drm/panel: remove drmm_of_get_bridge()
      commit: 01f2c4238fa101fd58696d0f0671d1edfaa247a3
[3/3] drm/todo: remove drmm_of_get_bridge()
      commit: 0bd6e1ffd6a85914092b110b08f5a19271f3dbd4

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


