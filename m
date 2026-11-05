Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A2606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RDsozRIa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD5A10F138;
	Thu,  5 Nov 2026 14:55:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426151124D7
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:54:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id ECBB5C6915A;
 Thu,  5 Nov 2026 14:54:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9E0125FF85;
 Thu,  5 Nov 2026 14:54:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B854510329267; Thu,  5 Nov 2026 15:54:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793890486; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZDxZ7RX2/ymgjxVbx+JIPdpnH/+/BkjYeGDXGjXFH2Y=;
 b=RDsozRIa7cj3ofNrlzP+QIib7JJXVKOXgJ3bRpa8CI22FeqG0DKo8IqqIKrmW4rutpCQNf
 qqDL5kbjKl+AMerqGW0jHzwcIdOTGvWKtHdfecg3jbk0zuj6zSXkxvQjTThFVPl31TEJHA
 nBFj9mH5auPwbWSa0MLD5OLtjxZC+Rn81fqg+Rl0wAuQyKniH0lvzyee0EzlOJnBSymibp
 jieBqyVxdkzcNHQ3iCgP1HaJTseyA9mJCsS8gx0Wq6VLYdFDAVfWNrrUmbvdmr6/+q6iJp
 yHEsCnL+ytT5V5rcuBjjYU6eZORcC3pckBTp9USlzjhobS9wfGl02oEDgxZTcw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] MAINTAINERS: Move armada DRM under drm-misc
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Russell King <linux@armlinux.org.uk>
In-Reply-To: <20261105142127.708219-1-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:54:39 +0100
Message-Id: <179389047996.1070495.15570800337696693660.b4-review@b4>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 15:21:21 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> The armada DRM driver has its own tree entries in MAINTAINERS, pointing
> to Russell King's drm-armada-devel and drm-armada-fixes branches.
> 
> However, the last pull request from that tree was sent in July 2019, and
> more than 80 patches have been merged through drm-misc since then.
> The driver is de facto maintained through drm-misc already.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

