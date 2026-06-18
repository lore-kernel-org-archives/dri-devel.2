Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC17CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4EA10EDA6;
	Thu, 18 Jun 2026 10:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kroah.com header.i=@kroah.com header.b="giUpVldr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DV9Hxf1t";
	dkim-atps=neutral
X-Greylist: delayed 642 seconds by postgrey-1.36 at gabe;
 Thu, 18 Jun 2026 10:46:07 UTC
Received: from flow-b1-smtp.messagingengine.com
 (flow-b1-smtp.messagingengine.com [202.12.124.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5B510EDA6
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:46:07 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id 295211300A85;
 Thu, 18 Jun 2026 06:35:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 06:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm1; t=1781778923; x=1781786123; bh=c+JFVYRbkx
 6rCQdKVL0JqSwq3chaKNZzvhRn0PAwsOw=; b=giUpVldr5njeIFaRPz2fkJfBjT
 GhKbRWCiVZKb4jS8dX4t2KoJ9VQX7slJhG+hwWwM4a5/PWEcYmHfsfuMCXw0oxBW
 tmrYE9MmuJSaf/ZiDWKMo8WuD7ESHJLSLbAx4AlSPIqutIsDH5+K6UIjKCCgPyjD
 5q1DaE+UYnWko3qz8eD96eXhMdEcwpP5HDtMFQQ2OY8kEr7KkPo82oRbm5USmTue
 2C+oFj6auO1JiNPjeoAItiBc1mhXO43IIelpS3Czt16ytHBaeBcxOynCWjepa8Q8
 lcFlP5aeYHB92gqfkeECduY/JRYe+/lYpI/dqNM5sLcflpdYN+8AdX58tQSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1781778923; x=1781786123; bh=c+JFVYRbkx6rCQdKVL0JqSwq3chaKNZzvhR
 n0PAwsOw=; b=DV9Hxf1t9L2Aywf1VjFPD4vnhnRw9AWIBtfWpXtbTCy8kSto64S
 TIT2HabyGQ0H27FI6IGLNX2gDz1a8/ynkMWgkqCOHc1x7xwXxQKP1ir96ssL/3Mr
 Wk5AG6GSA82SPlfksMeUrkuWbpTnL/akRh4gQqMAcyGszYahvFiiQG1ZaL4xJkEE
 o5FPKjsf7lm+yrpqvniV/VnRBnau0x3yU3US+8PBlv6F0gl946OF2THWGgNlxn0c
 ongIlAghgq1nLanj//cWto3TKttcxim6EXE4MDrH+sras/Qw8f5Krul5Bq/Z5exN
 SJOv0pVhZvRnTGlM/nMBVgP+uH4S6J+QJpA==
X-ME-Sender: <xms:68kzat-I270Q1pj-MjYOL21Vj4OeBqz1-9AR2ZRrUskb8KfkKhkeGQ>
 <xme:68kzatnvCH8slU1aCoEuzXfBv1BnZIFV0MdbUeG7rCwovH-ZHq67nYEZw5tCU6I_R
 3dAqsxbmuOvMxonJXAr1gipV4ai_sZOnrXYs2TeB0rUF8ttyg>
X-ME-Received: <xmr:68kzamj8anE5ePz182Yz8jn61bkh5I3sRPOuLk3U9D6CswgngBXj4y5scoMfBT7nXuXrES0z5qp4VPfPkSpPFaZ7Xw>
X-ME-Proxy-Cause: dmFkZTEOAOj02d/ZKUn9vAh5IMWX/a/uWTsZrk95sDIEQElrszD8yGRvVRq+MI8mGf8LjP
 RQVAV4njIE8vYUg0goHwoGnl1iWxq8UGXbDqqjrag/z22f0/NhXpEN6hcQjlDAy9rpmdwq
 Zr4XhfoQV5UBarJI95cR+MDwdvIlZYvLx/eI5R2J+F8RJio5GUOKD3Pf32WygkS2LK9naU
 VT5X+URE547nGLXQVfokPS0MKuxGGSt+bF3NPPw3TdMwn9OwZNPBkNzoSam2VcrZhZDp79
 pP6QHUG+Wt9kjx7pEc4SaEPdDTYuonhGN44aBOEqoW9U4OEjNop98QT0CgsFAGlh+EdaBU
 aznMH0YR6o4dS6lzTzQcx/EY1/dFQ+nbru5vUO9GIHrFmwT9LKxuZtBlugvIyGblR0VnB9
 83A7yQ6njTnM1nUg9zNNAodmzzySA7Umh9Kmzu/vOmHQM6mQ3bMZUrrvCYV8cGoH8r8n81
 NSzfkBZnopQiCr3LbRnglYY/uPaVVBJdolSFmorJbDosmG/g/NJcRTZ85xYvq5Ilh8ADFc
 DgiW94m7dD9oIgL28h73pIj4FYWydQvTRuHDsEChOnvYfS4zvXHzJ+xUKAhFhY5NMDGA6n
 srVAAjZuQIr5n5249kEjmd/sYUDeCkCt7lf0V+V6vuJC4c6U91y9C/o2wuvQ
X-ME-Proxy: <xmx:68kzalbSpZznxiMMdkYpxB_L_TLpY49c3pYnbAPw6d1IG9gDwhgpPQ>
 <xmx:68kzaqGLR6TjdFE4ZmSPcUebQhfcVoUbxkXLsD7IMLwCosZsFux1VQ>
 <xmx:68kzaiawsFDcMdl35khrpckGfKR4BUdG1gxvWn2M4YWHbq_RFDJ2FA>
 <xmx:68kzar1FT3olSv0W8VVzCgp7R3w2K515k-rH261mx7vlhIWfiuyFqQ>
 <xmx:68kzanBDuY2CPyhevtmRL9HcntqUlK9ytbnx3BpDRbwP-kG8INNXDES9>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 06:35:22 -0400 (EDT)
Date: Thu, 18 Jun 2026 12:35:36 +0200
From: Greg KH <greg@kroah.com>
To: rdhan@smu.edu.sg
Cc: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>,
 stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] fbcon: Avoid OOB font access if console rotation fails
Message-ID: <2026061826-yield-reemerge-7fe9@gregkh>
References: <20260618-prep-base-v5-15-209-v1-1-cfcf596dca7a@smu.edu.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-prep-base-v5-15-209-v1-1-cfcf596dca7a@smu.edu.sg>
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

On Thu, Jun 18, 2026 at 02:30:17PM +0800, HAN Ruidong via B4 Relay wrote:
> From: HAN Ruidong <rdhan@smu.edu.sg>
> 
> [ Upstream commit e4ef723d8975a2694cc90733a6b888a5e2841842 ]
> 
> Clear the font buffer if the reallocation during console rotation fails
> in fbcon_rotate_font(). The putcs implementations for the rotated buffer
> will return early in this case. See [1] for an example.
> 
> Currently, fbcon_rotate_font() keeps the old buffer, which is too small
> for the rotated font. Printing to the rotated console with a high-enough
> character code will overflow the font buffer.
> 
> v2:
> - fix typos in commit message
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
> Cc: stable@vger.kernel.org # v2.6.15+
> Link: https://elixir.bootlin.com/linux/v6.19/source/drivers/video/fbdev/core/fbcon_ccw.c#L144 # [1]
> Signed-off-by: Helge Deller <deller@gmx.de>
> [ renamed `par` to `ops` to match the v5.15 local pointer name ]
> Signed-off-by: HAN Ruidong <rdhan@smu.edu.sg>
> ---
>  drivers/video/fbdev/core/fbcon_rotate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

What stable tree(s) is this for?

thanks,

greg k-h
