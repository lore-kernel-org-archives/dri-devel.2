Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC86606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=DMPilbVb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED55D10E3D4;
	Wed, 25 Nov 2026 08:41:19 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F3F10F02B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1795543228; x=1795802428;
 bh=WFgX3x5eyxWwyTxwugRpUhXKTL0HEYgKi55nzSl82IQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DMPilbVb4kwszWRaXXs8RUgLpD5TddAlBgYCekXW1AhNisfVYnnfI9pKENQfCcb0O
 8+b2W8533inftOx8RGCVI+9pup7uJEC8mPZ8eMm4V3av/3wSnG/CpEjAtpaqlR2tZF
 hEs1LfXH36OzyvuY3dFnD+sf5huCH5AoI8SSq1illJaiAwJAPV0D5z7TiR6aKd09wV
 oe5YiSSe5hofWmla658pwyF14Icv+SQbwTAiqsqzFB3jEJfCzTybTZfxp8T/BHg1HV
 SH2bi2WSb5ZmAEbDTZQO0uqhsxfrqBbJ5Yd8M7Uz7J+MpBHJNnCHewCXA2brcMylSH
 U7uF3F3QW1D2w==
Date: Tue, 24 Nov 2026 18:00:13 +0000
To: Johan Hovold <johan@kernel.org>
From: Norman Herms <dockseed@proton.me>
Cc: "lgs201920130244@gmail.com" <lgs201920130244@gmail.com>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown
Message-ID: <ySgHadEeohoYOvbeB9Lx491WyBk6wXL4K-5n9o5_hiC2pAVbZ0NkOyMqG8VXQEUncvhhEivrHxGc-Js9m3vJcKrqvxOIL5tBm4z6rjtEMhc=@proton.me>
In-Reply-To: <awU8xkTrwuJyKJbA@hovoldconsulting.com>
References: <bKXiGbjWVw6RVBUFNVHEum6OPpzcYgrpzQTNKG2mnqCes5jzQJiN7BGGbNyJBjsS6UVFLV7wz3dFm7R8vaJoplZn1FI8WjOgk7Vg3WSuwBI=@proton.me>
 <awU8xkTrwuJyKJbA@hovoldconsulting.com>
Feedback-ID: 144388465:user:proton
X-Pm-Message-ID: 4675662c6a9cbc669dd988807e83ba879c8f3f00
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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

In reply to
https://lore.kernel.org/all/awU8xkTrwuJyKJbA@hovoldconsulting.com/

You're right, I put that the wrong way. The clock leak is a bug of its
own in remove(), and this patch only hides it.

I tried what you describe, in etnaviv_gpu_platform_remove() after
component_del():

=09if (!pm_runtime_resume_and_get(&pdev->dev)) {
=09=09pm_runtime_disable(&pdev->dev);
=09=09etnaviv_gpu_clk_disable(gpu);
=09=09pm_runtime_set_suspended(&pdev->dev);
=09=09pm_runtime_put_noidle(&pdev->dev);
=09} else {
=09=09pm_runtime_disable(&pdev->dev);
=09}
=09pm_runtime_dont_use_autosuspend(&pdev->dev);

Same board and test as before (7.3.6 with local patches, rmmod and
insmod of etnaviv, clk_enable_count of the reg, bus and core clocks
after each rmmod): without a change the three counts go up by one per
round, with this they stay unchanged over three rounds.

I left out etnaviv_gpu_hw_suspend(): the component unbind has already
freed the command buffer, and the resume only brings the GPU to
INITIALIZED, so it would do nothing there.

I won't send a patch for this myself, but I can test one.

Norman
