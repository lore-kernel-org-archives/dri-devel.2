Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36781606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=hSvD2QSK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DD810F34F;
	Tue, 24 Nov 2026 08:39:52 +0000 (UTC)
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9B610EC4B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1795453851; x=1795713051;
 bh=R+hYscy3U84QnW7zu6bGSQcL4RGK1vCUM0ausGDfOc0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=hSvD2QSKHYNolGys5Y4iMnN9e40Ri3so19Na5pz94+2LmJbtzXUl/Hl7E6zX1MfJ6
 1/2xNT7mWn72aVyzd9nJPdip3QQTEjZ/t+SHhcrYRCpk1otYdYUTsIWHte152COcr+
 7ExIBC82J7oxEC0kJD096fiXsv65D5Ok3Pwtn+2JJKpNKGGJCjnePBqvTmug9OymfG
 AZwC1/1kL0vChtOTe5bmcmx921L4Y+7KXgyi+dSGTpgcCUkZf9UubhqoJ5x+BVdDuE
 HG7M+Vf4ItJCI36GZazTM+RpWkv2qN4abeM3T0OZ5mgdk9a2c7KPjPz1g6qdBvNxJc
 gLOpsRcea0tgQ==
Date: Mon, 23 Nov 2026 17:10:39 +0000
To: "johan@kernel.org" <johan@kernel.org>,
 "lgs201920130244@gmail.com" <lgs201920130244@gmail.com>
From: Norman Herms <dockseed@proton.me>
Cc: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
 "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown
Message-ID: <bKXiGbjWVw6RVBUFNVHEum6OPpzcYgrpzQTNKG2mnqCes5jzQJiN7BGGbNyJBjsS6UVFLV7wz3dFm7R8vaJoplZn1FI8WjOgk7Vg3WSuwBI=@proton.me>
Feedback-ID: 144388465:user:proton
X-Pm-Message-ID: 190d6561639f5f1148682b9d8edbaa5cee8ee21e
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
https://lore.kernel.org/all/aoQZ3zhnyRuiHJlF@hovoldconsulting.com/

Hi Johan, Guangshuo,

For the remove hunk this is more than a cleanup: without it the GPU
clocks stay enabled after unbind.

__device_release_driver() resumes the device and calls
pm_runtime_put_sync() before ->remove(). With the 200 ms autosuspend
set up in etnaviv_gpu_platform_probe(), that put only arms the timer,
and pm_runtime_disable() in etnaviv_gpu_platform_remove() cancels it,
so etnaviv_gpu_rpm_suspend() never runs.

To reproduce, read clk_enable_count of the "reg", "bus" and "core"
clocks in debugfs after each "rmmod etnaviv; modprobe etnaviv" round.
On an Allwinner A733 (NPU on etnaviv with local patches) they went
1, 2, 3 over three rounds; with this patch they stayed at 0. I have
not looked at the probe hunk.

Measured on my board by AI agents, analysis with an AI assistant;
a report, not a Tested-by.

Thanks,
Norman

