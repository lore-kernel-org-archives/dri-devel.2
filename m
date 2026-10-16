Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E392CCF2D3
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F83C10E693;
	Sun, 18 Oct 2026 14:53:56 +0000 (UTC)
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CD210E047
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792169900; x=1792429100;
 bh=sdidUHHaw9wa6g9W7a3mjfR2MSS9GT2Fsx2RaFzHYK8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=UaxTjVaf7U4SI48KUi4MOxnLqzHm/hraLYRWrE+n6HazQNRkS1M0liTFs4qwSQjNq
 VmNMp0gjwFnYYhdNXMbtzu5tRm8z0gqIumic2EWyjjo20DmstDiW9DpZ+yXcQjL+8/
 2XXmNOrsar0M6QTf8pp461fBbsBvYtJnJX1Gmc2rRj2wLuE89QpUCOTFFOEyYqls+f
 ou3Zao0eCzyzpJ0OcRF51Lk93g1YefbRNsgOUJQm2BIsVu+F6VgZuZP/odmsa1V3mm
 fP3JAeEBuo8Bgk8QPsyCS+wHMJHupl3PgCX+6K+p9FLu7d8xJan8x8MiRwCSPNO9wJ
 wFeFcRM3pxTIg==
Date: Fri, 16 Oct 2026 16:58:14 +0000
To: Ryan Brue <ryanbrue.dev@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
Message-ID: <5YDZiRpFJP0aWb7TVPf0B1RZnD7z_d94cL8JhkMGSFrplp49jELQy6a9qKP4NsVXpqlTzh20O8pRoR0S3XBB0powa7ajhNmLIupt54ldTIY=@protonmail.com>
In-Reply-To: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
References: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 67cb0910836930895d2ef1e4849652f6d1d2aa8d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

On Sunday, October 4th, 2026 at 11:49 PM, Ryan Brue <ryanbrue.dev@gmail.com=
> wrote:

> mtk_dsi_reset_engine() does not touch DSI_MODE_CTRL, so whatever the
> bootloader left there survives power-on. On boards where the bootloader
> lights the panel for a boot logo and hands the DSI over still running, th=
e
> leftover value is a video mode, and the first mtk_dsi_host_transfer() the=
n
> takes the "already streaming" path: it stops the stream and waits for
> VM_DONE, which never arrives, because the engine reset has already stoppe=
d
> the stream. The panel's very first command fails and it is never
> initialised:
>=20
>   [drm] Wait DSI IRQ(0x00000008) Timeout
>   *ERROR* failed to switch cmd mode
>   sending dcs data 8f a5 failed: -62
>=20
> Set command mode right after the engine reset, so DSI_MODE_CTRL describes
> the state the reset leaves the engine in. The video mode is programmed by
> mtk_dsi_set_mode() when the stream is actually started, exactly as today.
>=20
> Seen on the Amazon Fire HD 10 (2017), whose LK bootloader draws its logo
> over DSI in video mode and never stops the stream before jumping to the
> kernel.
>=20
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

This is useful for quite lot of mobile SoCs, at least mt6572 and 6768.

Acked-by: Roman Vivchar <rva333@protonmail.com>

Best regards,
Roman
