Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987ECC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8DD10E1AF;
	Wed,  5 Aug 2026 21:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="jQBEO/WO";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="Bu+wOcYj";
	dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBA410E1AF
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785966374; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=XGC4FilKmjn421mrT8a6WFtwB5uiUMb9PTyCy4opGMOzXIdrSXNZ6B4CEc+V2o0ror
 2UE3MTXTKSuVW29qraXAG/F4AFKDBd3NdB3u4ATtFesrHlzdUXm5VC42XB25Pcs/dtbg
 KqbNIxMj348NVat82/D2DHfyJqnF2VuMnf2og/BJ12POXht9DLgj+QlfobUG9+uUZUDV
 qzWqd3v7VXsMeUw/OERG1iEm5XPh5XsYGM+rTGKRGfYFPEWba33IDDFPXOptRwcswU33
 KCwjMxTJiO4Q7ZcHojbcZWsZvFub2frZAVxhZ3+BgQa97nNnbILwsjsfS7zFjv3Tl/Qp
 XfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785966374;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=GuN8MV8+WpguvnvoA19q3S/k3/z11yozT5q2QZpB/J8=;
 b=KPaZ4oGW1h/yKllx/lZw91hi71FdoulitmWsOwwOmfGsYVKouLuhXjJ3sXT27hOJVx
 48nuhlL0io8O3o8T4T3Da0AmcoC0BWiCtMF5JsfaB4iuuzjBWN9azXT+tFNCXMUQ7+f1
 esWzV5T5RL8N6HreFbXHUfnyrFDHXFPmudNibHm2eYNBA6CDdJzVnAqXmMfBeoJppNS7
 U53RtdYphop1Mk54oN9pyR+EuDJir16xi08lOz5X6EiBtYP/H0BNMMAu8DzZVpkCOmO1
 5x+uh1InKPqv4zBGCPZAoo/ebnF2uKOI1DCdRKCEJgAVKE6lbituLPQhSi4vHtwmzg2N
 dZtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785966374;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=GuN8MV8+WpguvnvoA19q3S/k3/z11yozT5q2QZpB/J8=;
 b=jQBEO/WOugxisv1Y+4lAvT8vSEXT5/jRHCb4UzA7CkKUFg90eW9riQ3LgCtFFI8UDf
 jUsZNqR5mcdwdDxx62I5Morbe9a1WJXlrT56SoDifO53io/T1ZgCLHf9z+FPJlGnlrHp
 VOeHWa9rMJAKgYrFOJZf4JAPJs0iXvIgKZJs83rmUsPxqqH2adOQK/cXMMUEXxey+bxq
 S6nzObSc9M+dZ0WoYACNZl+VLW6mAGeqGcTfBfJhr+8LbfIselfK+09BJCozRpkVqZM9
 bcYXTCdOhh5cy8V2Nn+g57MSGxImEq0oboSUEAb9KMEl2O7tey+CvO+GvFsKWvEzIP6m
 TfSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785966374;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=GuN8MV8+WpguvnvoA19q3S/k3/z11yozT5q2QZpB/J8=;
 b=Bu+wOcYjHxYQJBmdagkO5TcFDfkEKYEjCwOvmTcqKCLutvp87Dz1PEK0ceEh9X3sAQ
 +nx1/foj3JL7SaGxoEDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrQ25oGlciNdEAAfky2+DDg1anEjIRYC+O6IISs"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.5.6 AUTH)
 with ESMTPSA id Q58eac275LkDRQh
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Wed, 5 Aug 2026 23:46:13 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v6] drm/omap: dsi: avoid sending bta sync all the time in
 writes
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
Date: Wed, 5 Aug 2026 23:46:02 +0200
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Transfer-Encoding: 7bit
Message-Id: <76783B3E-BE29-4FCC-AEC6-9D4866C8D461@goldelico.com>
References: <20260804-vm-upstr-v6-1-1bf3748b2fa3@kemnade.info>
To: Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
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

Hi,

> Am 04.08.2026 um 10:37 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> Some chips need configuration commands to be sent first, before they can
> send data. TC358762 for example needs PPI_LPTXTIMECNT configured
> and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
> configure such chips, do not send bta sync during writes if no acks are
> requested. Instead just wait for the packet to be sent to avoid FIFO
> overflows. There might be more to do about acks, but there seem to be
> virtually no users of that flag.
> 
> This came to light when fiddling with the Epson Moverio BT-200 display
> which consists of 2 TC358762 bridges with SPI funneled through
> to the unknown display chip. With that patch the bridge can be accessed,
> Reading back registers works, when the above-mentioned registers are set.
> 
> In Command-Mode update, there was a nop sent, apparently the most
> relevant part was the bta sync to actually force low power mode.
> 
> Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> 
> Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v6:
> - clear errors on every write
> - remove unneeded forward declaration

Tested on Pyra 5.3 (video mode). No side-effects visible.

BR,
Nikolaus



