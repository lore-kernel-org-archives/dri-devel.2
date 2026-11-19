Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1693E60A2634
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=J9ZBkyKg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD151124FC;
	Thu, 19 Nov 2026 15:06:29 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529991124FC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:06:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5BD791A1710;
 Thu, 19 Nov 2026 15:06:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2F6A060237;
 Thu, 19 Nov 2026 15:06:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AEE9911BC0B70; Thu, 19 Nov 2026 16:06:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795100776; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=PYdbLxmdk/8qOjG5FWZLrPvxAWLQknGLIEUkZq+DJkg=;
 b=J9ZBkyKgYsXFwUrJWyzw/XKZYLs9EBM3jI29J7vfGjkYNaTJMWHWLK+C4QO+aFDDAlvi1T
 uzQHUNU3mo6HHBtSVqDU4U0W6b6G9F1oR6FoBQJH6jZq6B59rin+WPAas46Dr+4lp4mdBo
 +L5nL7AwqfL4ddZpkPaJQV9tlW4Jmih4o17VBHOQMdXpOO1BhhjTWwakRnPAZBSno/9rGn
 2MVNV1ueioUjyLGUNhiLEmXnslKvZDvg3v6Y2gFwA9qySCoCph9QEBEN/ydoW/9VGbLon6
 JjmiR0UM+TAmqUW0b11ZdoY34F3TXVrWfeEPtccMbpSJkQ2yMiKNlYe1AvY5tQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Oarora Etimis <oaroraetimis@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261116091020.88281-1-oaroraetimis@gmail.com>
References: <20261116091020.88281-1-oaroraetimis@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a VKMS reviewer
Message-Id: <179510077276.1768931.12196809812489564460.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:06:12 +0100
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


On Mon, 16 Nov 2026 10:10:20 +0100, Oarora Etimis wrote:
> VKMS has been kinda quiet lately: the last VKMS-specific change is from
> 14 August, and the commits after that are tree-wide API conversions.
> There is little review activity on the VKMS patches too.
> 
> I would like to try reviewing VKMS patches and help move things along.
> 
> Add myself as a reviewer so I get copied on VKMS submissions.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Add myself as a VKMS reviewer
      commit: 2ec7c9c965afaa07fdd88501e8785d840bc2384a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>

