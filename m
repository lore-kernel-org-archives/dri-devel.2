Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13067606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fHGme+Fe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35068112679;
	Thu, 19 Nov 2026 17:09:06 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB086112679
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:08:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id AA322C2F4C7;
 Thu, 19 Nov 2026 17:09:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 331455FF9A;
 Thu, 19 Nov 2026 17:08:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 36FBD11BC0CE4; Thu, 19 Nov 2026 18:08:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795108136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=sSp9BDWg5ZWFhbGy2avp73yaoxaLBJeVqHeVZVAC8aY=;
 b=fHGme+FeT4WFj4gL/EBFNAceg+tovjWRrktsMkMdUypxK7Y5Q7hWo94Gbp/y7F378ps56J
 ueaxPgw4CQl+CyVEdpn/jzVPVGrQDD0Sfj5UgkA1K+bRMGhqlkeqNCSrxYTi857zRooHuP
 XyiA/Xw5HQqLUOEUnBMJ+ejOdJ4PYnG9VO+wwj1sAGNIN+VG4imd5KOOKevT4weNepw3ql
 a0aDhOPA1s5cs+S60sZJfEjglMMoKFAHgFuGsTRzf2u22mAAmUSsBAkOzY7Ahb3mr8l3AL
 3yatl9n6UFeUv1dVFv2YythyMCmYdxO0Uk5b7UZW8DWZ+sgSjJDjLuXJZToebA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 18:08:49 +0100
Message-Id: <DMZCQ276BVDA.2K9ZE12X5VF97@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Hermes Wu"
 <hermes.wu@ite.com.tw>, "Allen Chen" <allen.chen@ite.com.tw>, "Pin-yen Lin"
 <treapking@chromium.org>, "Chen-Yu Tsai" <wenst@chromium.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
To: "Daniel Golle" <daniel@makrotopia.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v8 06/14] drm/bridge: it6505: bail out of the IRQ
 handler when status reads fail
X-Mailer: aerc 0.22.0
References: <cover.1790552614.git.daniel@makrotopia.org>
 <2e003c2e6fdb56d03c3a6effdf090079afb2ffaf.1790552614.git.daniel@makrotopia.org>
 <179251509977.78870.3399297204284524303.b4-review@b4>
 <179481904177.211952.7029866729856302771@makrotopia.org>
In-Reply-To: <179481904177.211952.7029866729856302771@makrotopia.org>
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

On Mon Nov 16, 2026 at 9:55 AM CET, Daniel Golle wrote:
> Hi Luca,
>
> On Tue, Oct 20, 2026 at 06:51:39PM +0200, Luca Ceresoli wrote:
>> One first question it whether a read failure is realistic or not, and
>> whether you have experienced it on real hardware.
>
> I have not hit it on hardware. It takes a failing i2c transfer, e.g.
> the chip NACKing while held in reset, which can be provoked through
> the force_power_on_off debugfs knob: it6505_poweroff() only calls
> disable_irq_nosync(), so a running handler keeps reading from a chip
> that is being put into reset.
>
> And hostesly, my interest here is basically getting audio going on
> that Lenovo Ideapad, and for that
>
> https://lore.kernel.org/all/cover.1784561622.git.daniel@makrotopia.org/
>
> is sufficient. The 12 other patches are what Sahsiko has been chasing
> me into, and all the complains it had looked valid and legitimate, so
> I took on writing the fixes for that as well.

Ah, well, I understand.

I had missed the initial history of this series, thanks for the recap!

>> I would consider replacing all the 3 it6505_read() calls with a single
>> regmap_bulk_read(), making error management cleaner.
>>
>> What do you think about this option?
>>
>> Perhaps the three it6505_write() below could also become a bulk write.
>
> Makes sense, INT_STATUS_01..03 are contiguous and the driver already
> uses multi-byte transfers elsewhere. I'll switch to a bulk read and
> write in v9.

Good, thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
