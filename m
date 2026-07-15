Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D52C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4011210E19A;
	Wed, 15 Jul 2026 12:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Oxj58E8W";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A8A10E19A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1784119998; x=1784379198;
 bh=xEwViipQaJZVXM9xLdF3SH6nxkka6iIr7lgTdrGkvYI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Oxj58E8W3hKQZu0gvkYqCUZNpfUbBQ78VVenN6g9RIw4JHwjrEft/SGwCNV63zM7a
 2Q7xDkapC/pwRDIyAOJX+qhgp7mkaYQ1WRaknqg0zER/f8uics62usPnCFmLtM++hz
 chlq7llvfrhyONj4ef/FcqTEwPVbOJEW8CHgUmMXqrRzQU9CN4tVdvulv/1XxFgLSu
 fY64gkXv2/1oav9kvx/MgaFCP/rf2z7oobqsuuBKCEb5kUSI63K81kkyuM6Wggw/H6
 /+5ORu5ZuFxMRgJD7ayok7sl81etN/EQmzfVHek4fpQ7OP3pU+uq+23iCpjeLRS4kv
 CMe7pHG2/1yQA==
X-Pm-Submission-Id: 4h0bgw0Q0rz1DFTS
From: Esben Haabendal <esben@geanix.com>
To: Gary Bisson <bisson.gary@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>,  Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org,  linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
In-Reply-To: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com> (Gary Bisson's
 message of "Tue, 20 Jan 2026 12:36:59 +0100")
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
Date: Wed, 15 Jul 2026 14:53:15 +0200
Message-ID: <8733xko1ms.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Gary Bisson <bisson.gary@gmail.com> writes:

> Some bridges, such as the TI SN65DSI83, require the HS clock to be
> running in order to lock its PLL during its own pre-enable function.
>
> Without this change, the bridge gives the following error:
> sn65dsi83 14-002c: failed to lock PLL, ret=-110
> sn65dsi83 14-002c: Unexpected link status 0x01
> sn65dsi83 14-002c: reset the pipe
>
> Move the necessary functions from enable to pre-enable.
>
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Hi

I have run into the same problem, but in combination with another
pipeline. I am seeing same problem with an i.MX8 using the nwl-dsi
bridge and the dcss driver.

I have submitted a fix that adresses the problem in the ti-sn65dsi83
driver instead. With a bit of luck, it can replace the fix proposed in
this thread.

See https://lore.kernel.org/all/20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com/

/Esben
