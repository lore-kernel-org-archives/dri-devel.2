Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9306BF483DE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C7610E011;
	Mon, 23 Mar 2026 17:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="Nv8MHeXf";
	dkim-atps=neutral
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CE4510E011
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=default;
 h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
 To:From:Date:subject:date:message-id:reply-to;
 bh=EtCsnBnZz2wovDVb2c1WqzkKZB1qCNcO5X2CZ7cgDMk=; b=Nv8MHeXfYy1zDbtwL544BfXXL2
 xUDpz9v2/6kr95JFN3HJAZ8/g8Ss8JhcYSEGO7/HSyZVKhCgf+fieiT2Dq1z8hz5mOzbSmtNwgHod
 GeAmspCxs6Q/PuX5+h1F8BcpQo6CWFJAJj5O5evhQ96LIHTayRPxp7WsuwZjNssoIfPI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.98.2)
 (envelope-from <hugo@hugovil.com>) id 1w4jH1-0000000028R-2NHB;
 Mon, 23 Mar 2026 13:41:07 -0400
Date: Mon, 23 Mar 2026 13:41:06 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: biju.das.au <biju.das.au@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chris Brandt <Chris.Brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sam Ravnborg
 <sam@ravnborg.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-renesas-soc@vger.kernel.org"
 <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase reset
 deassertion delay to 1 msec
Message-Id: <20260323134106.a439ffad5d1ff6927e0c549f@hugovil.com>
In-Reply-To: <TY3PR01MB113460833AFD4BE4422E5E737864BA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
 <20260319164833.409126-5-biju.das.jz@bp.renesas.com>
 <20260323102015.957b2f855b7d54aa5d33869d@hugovil.com>
 <TY3PR01MB113460833AFD4BE4422E5E737864BA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --
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

Hi Biju,

On Mon, 23 Mar 2026 15:19:27 +0000
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Hi Hugo,
> 
> > -----Original Message-----
> > From: Hugo Villeneuve <hugo@hugovil.com>
> > Sent: 23 March 2026 14:20
> > Subject: Re: [PATCH v2 4/4] drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay to 1 msec
> > 
> > Hi Biju,
> > 
> > On Thu, 19 Mar 2026 16:48:28 +0000
> > Biju <biju.das.au@gmail.com> wrote:
> > 
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
> > > requires waiting more than 1 msec after deasserting the CMN_RSTB
> > > signal before the DSI-Tx module is ready. Increase the delay from 1
> > > usec to
> > > 1 msec by replacing udelay(1) with fsleep(1000).
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > 
> > In your first submission, I commented that "...this should be backported to stable branches (missing
> > Fixes / Cc: stable tags)?" and you answered with "Agreed, will add fixes/stable tags".
> > 
> > If you still agree, this patch should be #3 in your list, so that it is easier/straightforward to
> > backport to stable branches.
> 
> The patch order is changed. that is the reason I have not added any fixes/stable tags.

This is not a logical nor valid justification if the change
merits to be backported to stable branches as you indicated in
series 1. Why have you changed your mind?

> The if check in patch#3 makes it is not backportable to stable branches.

If you put the delay patch before that "if check", then it is
irrelevant, no?

> If I reorder this to patch#3 it is fixing just the delay mentioned in the hardware manual.

Yes, and that is also exactly what this current version does, no?

For me, it is simply changing a delay from 1us to 1ms. Whether you
change it before or after another patch isn't supposed to matter in the
end, unless I am missing something?


-- 
Hugo Villeneuve
