Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EC7C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 11:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DFC10E32D;
	Sat, 22 Aug 2026 11:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="i3p9nmAJ";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D7D10E32D
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=q/82qXQCdNW2X0LkZzIrKAgGSD0VEdBo7O7SAFurDlE=; t=1787396729; x=1788606329; 
 b=i3p9nmAJ+YgaAqAPOtgXzZ11X2tbBGcyGoApnypz6T3xKEYSZLRtAh/elTEYhrVsvufvpI/Mf/n
 lmK89MRB+Q3O3L1yhztFQDI8Mb9mGapvStulV2MiYnxi1oDFaBLD3y+jbST9umyuhu20nrk8YTIBP
 +6lPDpaXANjVVoUZ2rNmep6jn7hk7tHghJcwvugQfMRq9BmV0McN+RvhRmf1Jeu+wAv072LWABmfq
 1xGbo+oZBmPQKydFENujdBRPQ2EZQzZwDhi59A0cCWXkVxCcNoQi0aF0vHOPfZWR0JtWtFQTXnXRf
 L8j0KBTqF7ClzPSuzS6jXzmj7HRa8f9zPU+w==;
Date: Sat, 22 Aug 2026 13:05:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Helge Deller <deller@gmx.de>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org"
 <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in
 panel_enabled()
Message-ID: <20260822130523.116aa1bd@kemnade.info>
In-Reply-To: <cd542bf5-775e-407f-88cc-4cf18305f2b3@gmx.de>
References: <20260822094805.421002-1-deller@gmx.de>
 <20260822095809.1D0651F000E9@smtp.kernel.org>
 <cd542bf5-775e-407f-88cc-4cf18305f2b3@gmx.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 22 Aug 2026 12:23:35 +0200
Helge Deller <deller@gmx.de> wrote:

> CC'ing the linux-omap mailing list, in the hope someone with omap
> knowledge can judge if the sashiko AI bot is right with his analysis that
> acx565akm_transfer() might be wrong on big-endian systems?
> 

well, it sits behind the spi interface, which should abstract hw oddities.
So wie should not ask about omap specific stuff.

BTW: same issue in drm variant of the driver.

> On 8/22/26 11:58, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Hardcoded little-endian assumption when transmitting the command byte breaks the driver on big-endian architectures.
> > --
> > 
> > --- Patch [1]: [PATCH] fbdev: omapfb: Fix __be32 sparse warning in panel_enabled() ---
> > commit a9e06be56fc1b74d7c6e76133e9ea1c25675a615
> > Author: Helge Deller <deller@gmx.de>
> > Subject: fbdev: omapfb: Fix __be32 sparse warning in panel_enabled()
> > 
> > This commit resolves a sparse warning in panel_enabled() by explicitly
> > reading the display status into a __be32 variable. It then converts this
> > value to CPU endianness using __be32_to_cpu() before checking the bits.
> > 
> > Closes: https://lore.kernel.org/oe-kbuild-all/202608211811.lps93xao-lkp@intel.com/
> >   
> >> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> >> index 8f430d9e80549..0202ca8cbfc23 100644
> >> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> >> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> >> @@ -210,12 +210,13 @@ static void set_display_state(struct panel_drv_data *ddata, int enabled)
> >>   
> >>   static int panel_enabled(struct panel_drv_data *ddata)
> >>   {
> >> +	__be32 disp_status_be;
> >>   	u32 disp_status;
> >>   	int enabled;
> >>   
> >>   	acx565akm_read(ddata, MIPID_CMD_READ_DISP_STATUS,
> >> -			(u8 *)&disp_status, 4);  
> > 
> > [Severity: High]
> > This is a pre-existing issue, but while looking at endianness fixes in this
> > file, does acx565akm_transfer() have a similar issue on big-endian
> > architectures?
> > 
> > When acx565akm_read() calls acx565akm_transfer(), it passes the command as
> > an int:
> > 
> > drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c:acx565akm_transfer() {
> >      ...
> >      cmd &=  0xff;
> >      x->tx_buf = &cmd;
> >      x->bits_per_word = 9;
> >      x->len = 2;
> >      ...
> > }
> > 
> > Because bits_per_word > 8, the SPI controller reads the buffer as a 16-bit
> > integer. Taking the address of a 32-bit int on a little-endian system yields
> > the command byte in the lowest bits. However, on big-endian systems, &cmd
> > points to the most significant bytes (which are 0x00).
> > 
> > Will the SPI controller end up transmitting 0x0000 instead of the requested
> > command on big-endian architectures?
> > 
Probably yes, at least if I do not see uint32 * as a pointer in the tx_buf there.
The more interesting thing would be the 9th bit. There would be some requirement
neded and documented in the spi_transfer struct to put things into 32bit words
if bits per word is > 8. Nobody would forbid using u16.

Regards,
Andreas
 
