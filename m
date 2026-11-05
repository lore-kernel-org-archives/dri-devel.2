Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D3606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=27nxKHnl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9238210E209;
	Thu,  5 Nov 2026 08:01:21 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78EBD10E209
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:01:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DF856C69153;
 Thu,  5 Nov 2026 08:01:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B30CA5FF85;
 Thu,  5 Nov 2026 08:01:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AAE9210329245; Thu,  5 Nov 2026 09:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793865671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xPeXs/cCgecXVh9tV+AI0gUUFEPocWOjRn6uXkww8Us=;
 b=27nxKHnlXDS3AgWkXuSqNIp4q7lxFVvtyzlfZ/j8Jit2M2nM8L4IFtf1g/YXI33wgZIT4h
 DAYpQpFoenE1rYvAKiPQ7jg/42XnHix0aliANc0kKo6jwJM/Qf83GQPeKnbE4fiYJyLm4x
 JnJzMTz6AofvsqNmrrj/ZyVxgRvNn2VJ2moprvkwvq4tZjmsPsi9FT+UEZSnbspD8Ny5ec
 tHQxn3mmNFnQ3K6mPfqv2/wJZnPgU59oRqXvv9NtxBiYnnmQiGCA1ETDXSMuRva9QQQxz1
 iC4lnW/tO5Pl/fTvSkvlTHwvGhyEZRftsU2Y9jVkK8yjJrb4wQSb2nU6cyURFQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 09:01:06 +0100
Message-Id: <DMN4B2PHU3MM.KQ59QQ6P4FCO@bootlin.com>
Subject: Re: [PATCH] drm/bridge: fsl-ldb: Remove panel naming and use scoped
 device_node cleanup
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261030163254.3175671-1-laurentiu.palcu@oss.nxp.com>
 <DMMMCJHUT8EL.1L6VS1X1K2BQE@bootlin.com> <auwrIKJi-v9svTdW@vm>
In-Reply-To: <auwrIKJi-v9svTdW@vm>
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

Hi Laurentiu,

On Thu Nov 5, 2026 at 8:25 AM CET, Laurentiu Palcu wrote:
> Hi Luca,
>
> On Wed, Nov 04, 2026 at 06:56:41PM +0100, Luca Ceresoli wrote:
>> On Fri Oct 30, 2026 at 5:32 PM CET, Laurentiu Palcu wrote:
>> > The remote endpoint node is not necessarily a panel, so drop the "pane=
l"
>> > naming and refer to the next bridge instead. Update the error message
>> > printed when no output port is connected.
>> >
>> > While at it, convert the device_node handling in fsl_ldb_probe() to us=
e
>> > the __free(device_node) cleanup helper. Since remote1 and remote2 now
>> > stay valid until the function returns, pass the selected one directly =
to
>> > of_drm_find_and_get_bridge() and drop the extra panel_node reference.
>> > Do the same for the dual-link port1/port2 lookups.
>> >
>> > No functional change intended, other than the updated error message.
>> >
>> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>>
>> I wanted to test this patch but it does not apply on current
>> drm-misc-next.
>
> Sorry about that, I made these changes on top of Dario's patch [1],
> touching the same file. I thought that would probably be applied first.
> FWIW, my patch applies cleanly on drm-misc-next if [1] is applied first.

Ah, indeed, thanks for clarifying!

Next time you send a series depending on another one, please mention it in
the cover letter or (if there is no cover as in this case) below the '---'
cut line.

Dario's patch applied right now, so I could apply and test yours:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
