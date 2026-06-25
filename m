Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFEFCDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB23810F142;
	Thu, 25 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="KrzK3w2D";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoHavp4c";
	dkim-atps=neutral
Received: from flow-a5-smtp.messagingengine.com
 (flow-a5-smtp.messagingengine.com [103.168.172.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A2010E16E
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 04:13:17 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 6782A13803BC;
 Thu, 25 Jun 2026 00:13:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 00:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
 cc:content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1782360796; x=1782364396; bh=oIov2InzFrXnsVaxp1cxfQru10Cyooue
 4oYFo+7Wk7k=; b=KrzK3w2DKxlOenpxJAYpTHLM9ErKVFlS5Caxf1zO+H45fo+w
 7iIVyhDf8b0jutCASaH9wZ0Rwoo69XdkOeHIBRBM8bjKdbZmDJHxjZgP29CNggkr
 i0V4MdcVVPSL9AAwF/yHRkF0wX2hEG2ti3Snbe9QPvl8uIDcg1ys3ReeX80zZ3ec
 ZvADrXmu2LpgGRE3b6dWL9ysnwcXPQDfaWR8tCYLteKV/MWaDF55SiVY4kkZTzLz
 RTxO06hbY7CBjcedH83QPWlmT3Q1k68a3+u1gPKgIwNRAYW92YDxEtUdaTyRSYRQ
 YbxswP/zg33EHJeJDrN9VN3jPAWi8yjBaUuK/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782360796; x=
 1782364396; bh=oIov2InzFrXnsVaxp1cxfQru10Cyooue4oYFo+7Wk7k=; b=V
 oHavp4ctilH55rRx19FnNJlt2S1fUBJ43KKBoXKhPqSvi0vPxOiVKho8ye6DDAeg
 cnPfureFbJI77vaVQDaKlVBgpsglAzW3vn2PYpTUOmGSOFY8hX3eNaGRTU1jIgg0
 7Pi5R8d6I5/P0k6GLybsQVtkzO5FeBg1HETSG+oXm6iRcSV0Nan1pLry1mWbHwxN
 SnOlRaRVm76xMnWJk0MpurSh/oUElY/z+0nV1CjRjYsAK+wU7200XKLTJU2wT0b2
 dR4HeScN9Zn4bMIBbiAL+/MdVmjOfidigLNn0wcDUSaJ4T7uCJPeQg/JaY4I9SJE
 9ragUg6u9ls83A+yt1g4g==
X-ME-Sender: <xms:3Ko8aj3LThjdokhwSNQo3yjsSeLrz2yJDD5RaC6r_Rvd2QTWDYslSg>
 <xme:3Ko8arCwXWrEAUWKUeSF8vW-j4UTFgbQi7Ew0YOcsW55LfRwbcdgtN1b6vmzLuPjX
 D6T2kyrPLnohemDDTSOLfDQvLaFmorghaNJvpRi62bAJt7Ojkg803c>
X-ME-Received: <xmr:3Ko8aveiG087GwMF-wRrfvar51ljffeShJiRPK7Y294hSvvZMlQpvtWOE0s>
X-ME-Proxy-Cause: dmFkZTFFDB7hD4CYMJYInpomOqdKSTXPf1B9fZNTsvQHvPJKV2pMaM6uhg4aZF2l9g7Wqi
 0BkvuDexx3wnoF1UlBS/yVt75HgPvZh2aNB5ISjgaZ2V/n2EVyDcSGKHnwDfRkA7YCSMEa
 C2dg6dX0b5tMSPkHx+iBRIT8HjPmdMsp1/SZMVRw/IoIHutCl8FnncI2ikijbClOw4/4Pq
 Frra+ShyAhLTmnUy58ziFg3bo0WQIJV69RQgAMN4GDl2gkC7i9F7ZO7yESTONGxg15hCdF
 VZ4+0miwQmCG2uE5jjkA5E5Ejo6gQk8LR6NshEiFDXzypqD6cQDNDJwBgcosIIswGlb8Ne
 1z68qiYw0fNwyEH8c/Tjd87jotovmvSILACF9nejwEGMR+IkOtAfHVxwTZ2PbmKslKusNF
 TCt9p8dZzQ8v2zMqiWIBBmQNBnFIXqb2iHKy2pVtwpBaNm6BXxXS7JkyJlbFD0YQyLzrJ/
 f0w3zojbsz283FOV2TH5bYyFigZaU1ZYr+MYNdxWJevP36dXxtAuLTmMdnFpQ7yTL2PedB
 R32S7VvCuXgVG3OboAQG3gknUuxk+KCuHa4XnPyhnKb8UWl1FEcB2BdLM2vuSQ4L//hy3I
 hv4csw87oygv0jZwOIWa8TrcArJL0VbpLW7TqE+Do2JIOInSgSSODz+bWWVg
X-ME-Proxy: <xmx:3Ko8ao6OU-hPHxVT38Pkd2rOZKhmnXEJDLTtRLkCC7uAeJRoo_-M0w>
 <xmx:3Ko8aiWhUtX5lK1ShLzg-SyOnemqOq1jmVZCaCzVHmdecMPPtxnHFg>
 <xmx:3Ko8an5K_5iVny4Snuz0c4VsxFLO0UkyqVoe-gI00S7TmfIrQ1D38A>
 <xmx:3Ko8atq6PdgFzl_AeiGUiI5gvoB_YilGeeud4tEyF8cT2vKmURge-w>
 <xmx:3Ko8as8u-VwL5k_gdk6IPKYSFOUnXHirWe6wpQhBKVjSb8Z42kWTtZVI>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 00:13:15 -0400 (EDT)
Date: Wed, 24 Jun 2026 23:13:12 -0500
From: Ian Bridges <icb@fastmail.org>
To: Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Fix fb_new_modelist to prevent null-ptr-deref in
 fb_videomode_to_var
Message-ID: <ajyq2Fr-2fMfftGC@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

info->var, a framebuffer's current mode, is expected to have a matching
entry in info->modelist. var_to_display() relies on this and treats a
failed fb_match_mode() as "This should not happen". fb_set_var() keeps it
true by adding the mode to the list on every change, and
do_register_framebuffer() does the same at registration.

store_modes() replaces the modelist from userspace. fb_new_modelist()
validates the new modes but does not check that info->var still has a
match. It relies on fbcon_new_modelist() to re-point consoles, but that
only handles consoles mapped to the framebuffer. With fbcon unbound there
are none, so info->var is left describing a mode that is no longer in the
list.

A later console takeover runs var_to_display(), where fb_match_mode()
returns NULL and leaves fb_display[i].mode NULL. fbcon_switch() passes it
to display_to_var(), and fb_videomode_to_var() dereferences the NULL mode.

Keep the current mode in the list in fb_new_modelist(), the same way
fb_set_var() does.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
This patch fixes a NULL pointer dereference in fb_videomode_to_var(), reached
through the framebuffer console. The fix is in fb_new_modelist(). Sashiko
flagged this dereference while reviewing the fix for a separate NULL pointer
dereference in fbcon_new_modelist() [1].

The dereference happens when a framebuffer's current mode is dropped from its
modelist while fbcon is unbound, and a console is then taken over onto it, as
follows.

1. With fbcon unbound, a write to the modes attribute calls store_modes()
   (fbsysfs.c:91), which replaces the modelist and calls fb_new_modelist()
   (fbsysfs.c:108). fb_new_modelist() (fbmem.c:746) validates the new modes but
   does not keep info->var in the list, and the fbcon_new_modelist() it calls
   (fbmem.c:770) only re-points consoles mapped to the framebuffer. With fbcon
   unbound there are none, so info->var is left describing a mode no longer in
   the list.
2. Mapping a console with FBIOPUT_CON2FBMAP takes the framebuffer over,
   set_con2fb_map() -> do_fbcon_takeover() (fbcon.c:930).
3. The takeover initialises the console, fbcon_init() -> var_to_display()
   (fbcon.c:1113). fb_match_mode() finds no entry for info->var, so
   var_to_display() leaves fb_display[i].mode NULL (fbcon.c:988).
4. The takeover switches to the console, fbcon_switch() -> display_to_var()
   (fbcon.c:2181), and fb_videomode_to_var() reads the NULL mode
   (modedb.c:905). This is a NULL pointer dereference.

The faulting line is not touched by this patch:

    var->xres = mode->xres;

mode is the fb_display[i].mode passed by display_to_var(). Instead of guarding
this read, the patch keeps info->var in the modelist in fb_new_modelist(),
so the mode is never NULL here.

The same dereference, fb_videomode_to_var() on a NULL mode, was fixed twice
before, by CVE-2025-38214 in fb_set_var() and CVE-2025-38215 in
do_register_framebuffer(). Both keep info->var in the modelist, and both are
already in this base. This bug reaches the same line through a different
path, a modelist replacement, and this fix keeps info->var in the list
the same way.

It reproduces on a KASAN kernel with two framebuffers:

1. Unbind fbcon, so the store in step 3 does not re-sync the mode.
2. Set a video mode on fb0 with FBIOPUT_VSCREENINFO.
3. Write a different modelist to /sys/class/graphics/fb0/modes, so the mode
   from step 2 is no longer in the modelist.
4. Map a console to fb0 with FBIOPUT_CON2FBMAP. With fbcon unbound this takes
   fb0 over, sets the console mode to NULL (the mode is not in the modelist),
   and switches to the console.

The reproducer was written with the help of a coding agent (Claude Code). The
patch is against commit 3726ce7f6cef on the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git. The
file offsets above are from that commit. The defect is present in the initial
2.6.12-rc2 import, so there is no Fixes tag.

[1] https://lore.kernel.org/all/20260624213027.6C1E01F000E9@smtp.kernel.org/

 drivers/video/fbdev/core/fbmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index e5221653ec2b..2f1c56e5a7a2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -767,6 +767,18 @@ int fb_new_modelist(struct fb_info *info)
 	if (list_empty(&info->modelist))
 		return 1;
 
+	/*
+	 * The new modelist may not contain the current mode (info->var), and
+	 * fbcon_new_modelist() below only re-points consoles mapped to this
+	 * framebuffer. Add the current mode here so info->var keeps a match
+	 * even when fbcon is unbound.
+	 */
+	if (!fb_match_mode(&info->var, &info->modelist)) {
+		fb_var_to_videomode(&mode, &info->var);
+		if (fb_add_videomode(&mode, &info->modelist))
+			return 1;
+	}
+
 	fbcon_new_modelist(info);
 
 	return 0;
-- 
2.47.3

