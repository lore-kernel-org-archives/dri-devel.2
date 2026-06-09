Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DBBCD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD2E10E31A;
	Tue,  9 Jun 2026 15:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Y0wWEGSd";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF2B10E31A
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781019986; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TdLep4iIGLSFu6R6E+jR3886lqG+OCDS5MpX71CqM5XqrBFMH6NI971iK6Zrw2sZp4DZdjL3kSYImAEobCmzF1GGrm0KbOcsoGfUouFdsYjO0j5O6CTtkUiYT9C+2iW9QzVExPSYbJYFxEuHM26iQKH8UKj2EBqNypqNVuYsvtU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781019986;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Yq0YedSy2ltlmXQkVjO4DFCO6XZqNvukn5YvwkChBo0=; 
 b=kLTPWdCmRv3sP4u1sMo4Xo7gXrW4tY8VPaRe7Ka/dk7nDgYMHYAGHK4BLZoRpZUuYlTZn+fIb1MUgmSf2eNFLo7N+TS/3V7MzsVaxqEpiI1Oml98WdiPZvTBVjimIjrLaPDCNcEVOxaHSfCJvaxOcpRu1TdD0j70HX0Zmz/nAE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781019986; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=Yq0YedSy2ltlmXQkVjO4DFCO6XZqNvukn5YvwkChBo0=;
 b=Y0wWEGSdYOaBPbbzztYdYHB8/7iolZvaVNz7kXmENCdgsQmoA1EdTTPZwue0bbDL
 ZALT8mu5mpD40W0nn87vsxx3k11co/M5zAE7AcePsVriPJae5qy4ruAplPF+HGsPD1B
 OuWxlL0KRD1PTXNEaHJL2ZPy14B0WXMIRqRucpkI=
Received: by mx.zohomail.com with SMTPS id 1781019985329809.925765084812;
 Tue, 9 Jun 2026 08:46:25 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 0/2] Make HDMI state helpers handle odd max bpc requests
Date: Tue, 09 Jun 2026 17:46:20 +0200
Message-ID: <n8gESqWZSRS1IhbHdJvkLQ@collabora.com>
In-Reply-To: <20260609-orthodox-cocky-bull-5ddef8@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260609-orthodox-cocky-bull-5ddef8@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, 9 June 2026 14:51:12 Central European Summer Time Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jun 08, 2026 at 01:19:06PM +0200, Nicolas Frattaroli wrote:
> > With the "max bpc" KMS connector property, userspace can arbitrarily
> > restrict the upper end of the bits-per-component range. This is fine and
> > good, except the HDMI state helpers never considered that max_bpc could
> > be influenced by a userspace setting, so assumed it'll always be an even
> > value from the HDMI standards.
> > 
> > This, unfortunately, is not the world we live in anymore. Patch 1
> > corrects sink_supports_format_bpc to return false on BPCs outside of
> > what HDMI allows. Patch 2 then corrects handling of odd-numbered max
> > bpcs by rounding the loop start value down to an even number instead. It
> > also adds a KUnit test to make sure nobody breaks this again in the
> > future.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Do you have a bit more details on the world you live in? :)
> 
> In particular, why would erroring out on setting an odd value in
> atomic_set_property not work?

It would work, but it'd be an inferior solution IMHO. (If the intent
was to point out this is already done then I can't find the code where
such a check is performed.)

It's perfectly fine, albeit weird, for userspace to say it wants a max
bpc of 11. That HDMI does not support 11 bpc isn't really something the
upper end of the range should concern itself with, much like we don't
error out on a max bpc of 14 either even though HDMI does not support
bit depths of 14 bits.

By counting from the next even number, we don't leak our implementation's
choice of trying every other bit depth through the uAPI with an overly
restrictive constraint being placed. In an alternate universe, mirror
world Maxime may have decided to i-- in that for loop instead just in
case, and the second patch wouldn't be needed.

Kind regards,
Nicolas Frattaroli

> 
> Maxime
> 




