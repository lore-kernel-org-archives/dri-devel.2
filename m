Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B53606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NTQRnXgH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041BF10E038;
	Wed, 18 Nov 2026 17:24:12 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6492A10E038
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:24:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 749D6C4F77E;
 Wed, 18 Nov 2026 17:24:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5CD055FE9B;
 Wed, 18 Nov 2026 17:24:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 890A111BC2A95; Wed, 18 Nov 2026 18:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795022642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bXJhc2GJ3SoNUrj/9e522XwJhUasaZSujwRhO/k1tMw=;
 b=NTQRnXgHCWqG7o9tbC42FLXK5PpAFGMnTAI0uUA/GGHoGblunBp2oS3Mu+P53fLI9paj9E
 umYpObsieiuiLzXh31R0xEcuIZ6UzR623o1eQ2vcz9qVbvwY15cNwo8HFD4BJDiNYgnSy8
 +cdvTu/yMs82bG9Ovw0hQcyDQPpnz0Vh7briEKYkZ/yvQouzeHbxFlzlmtPZGaaiwUwoAE
 KvVJPOXZiwiUNCQMFB0P+D/3v3wNDENgbpeQX5D8HffKFbWROiGYQl4LPugxFbXpdAY+kd
 1GGC0yfiCdetKKQbZtLF2Yo65Qat8BSnUIe9qRBN9dgC5PFgmKjZEplanO4kkQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 18:23:52 +0100
Message-Id: <DMYIF16G9BI6.22TYKMLFPA3IM@bootlin.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix DSI host node reference leak
Cc: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
 <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Doug Anderson" <dianders@chromium.org>, "Haoxiang Li"
 <haoxiang_li2024@163.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261118150045.2414052-1-haoxiang_li2024@163.com>
 <CAD=FV=WQQyw8_bhVi8Y0JbxXB8XP62ivBPUnfrgWGMcLo7qLtQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WQQyw8_bhVi8Y0JbxXB8XP62ivBPUnfrgWGMcLo7qLtQ@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 18, 2026 at 5:42 PM CET, Doug Anderson wrote:
> Hi,
>
> On Wed, Nov 18, 2026 at 7:01=E2=80=AFAM Haoxiang Li <haoxiang_li2024@163.=
com> wrote:
>>
>> ti_sn_bridge_parse_dsi_host() acquires a reference to the remote DSI
>> host node with of_graph_get_remote_node(). If ti_sn_attach_host()
>> fails, the probe error path removes the bridge but does not release
>> this reference.
>>
>> Call of_node_put() after removing the bridge in the probe error path.
>>
>> Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI=
 device at probe")
>> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
>> ---
>>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

> I'll probably let this sit for a bit and then merge it in a week or
> two. It doesn't seem urgent, so I'd plan to land it in drm-misc-next
> instead of -fixes. If anyone else feels like landing it sooner, feel
> free.

Agreed.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
