Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF453CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 08:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DB410E148;
	Tue, 26 May 2026 08:22:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NFohwz+B";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C669310E148
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779783739; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ktYCr4xCIJP04F83YL1EmHtBs8t3tAaYqkOlZ8l9gKiCQghmbDyadoni0bFs1P0xHpDPv/h8aW5UiTzf3QxuQ94tIFRv7T4j3kxTvydMv7iBm/CzLQ0XF+rPlPZTALfELjJhZT2b5par5Lh11flGQnkGO/V3Pjo/GvWRnN7E8fs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779783739;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=N1n3Fs1hye1n8WQ+9B4xXUDm3+q2mI4xG7vxT0L2VPs=; 
 b=IRpICoA0iTmmHngWDnyl1l1H+D8Z1TfjCiW1uUcAK3N55eb5p/gsjcmspfQfJzXcswUpUfH60xCeCMKnIw9mToqOZzIV+I/IjCCNE62d/hKeK7XQ+JQsdPM4mq3J84Q46EZ49TYLD/SyO+2CClr/02y/YSp7tGmG97S0ZCil010=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779783739; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=N1n3Fs1hye1n8WQ+9B4xXUDm3+q2mI4xG7vxT0L2VPs=;
 b=NFohwz+BxwN19rJgJK4gpSPAihDiCmyHB8KynAHIAnuoN8GXmQsW1acKO6ivIKfD
 VM08AoMw13ogMhcUcmA08KR8vZNE66BtbsIAAxMAjGyuTIcUbaJ5AFbut5AnyFBB3yi
 mPimTu6VKhUdihomQw3tXGw1euoejAD1Dj/Q8j00=
Received: by mx.zohomail.com with SMTPS id 1779783737862838.2646396623846;
 Tue, 26 May 2026 01:22:17 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/3] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
Date: Tue, 26 May 2026 10:22:11 +0200
Message-ID: <JO-iqbj4QxiNxPkvtLngHg@collabora.com>
In-Reply-To: <CAPj87rMe_oOR66uBE1PpNq4oMgpw_XhAbQit3tohTQbUD2dPdQ@mail.gmail.com>
References: <20260520-scdc-link-health-v2-0-511af18cd64b@collabora.com>
 <20260520-scdc-link-health-v2-3-511af18cd64b@collabora.com>
 <CAPj87rMe_oOR66uBE1PpNq4oMgpw_XhAbQit3tohTQbUD2dPdQ@mail.gmail.com>
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

On Friday, 22 May 2026 19:38:24 Central European Summer Time Daniel Stone wrote:
> Hi Nicolas,
> 
> On Wed, 20 May 2026 at 14:36, Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> > -       for (i = 0; i < ARRAY_SIZE(buf) - 1; i += 2) {
> > +       for (i = 0; i <= ERR_DET_OFF(SCDC_ERR_DET_2_H); i += 2) {
> >                 if (buf[i + 1] & SCDC_CHANNEL_VALID)
> >                         counter[i / 2] = buf[i] | (buf[i + 1] & ~SCDC_CHANNEL_VALID) << 8;
> >                 else
> > @@ -355,9 +433,15 @@ int drm_scdc_read_error_counters(struct drm_connector *connector, u16 counter[3]
> >                 buf[i] = 0;
> >                 buf[i + 1] = 0;
> >         }
> > -       buf[ARRAY_SIZE(buf) - 1] = 0;
> > +       buf[ERR_DET_OFF(SCDC_ERR_DET_CHECKSUM)] = 0;
> > +
> > +       if (num_lanes == 4)
> > +               counter[3] = buf[ERR_DET_OFF(SCDC_ERR_DET_3_L)] |
> > +                            (buf[ERR_DET_OFF(SCDC_ERR_DET_3_H)] & ~SCDC_CHANNEL_VALID) << 8;
> > +       else
> > +               counter[3] = 0;
> 
> I get that this is separate from the loop above because it's
> discontiguous, but is it also missing the validity check? I mean,
> lane_count == 3 means 'fsvo 3 which may be 1 or 2' so have to check
> SCDC_CHANNEL_VALID there, but if we have 4 lanes explicitly specified
> then we are we missing the check for the valid bit, or is it just
> always valid / we shouldn't check?
> 
> tbh having it separately is a bit messy. I half-wonder if unrolling
> the loop wouldn't be cleaner, e.g.:
> #define GET_SCDC_ERR_CNT(c) { \
>         bool valid = (buf[(c) * 2 + 1] & SCDC_CHANNEL_VALID; \
>         if (valid) {  \
>                 counter[c] = buf[ERR_DET_OFF(SCDC_ERR_DET_ ##x _L)]; \
>                 counter[c] |= (buf[ERR_DET_OFF(SCDC_ERR_DET_ ##x _H)]
> & ~SCDC_CHANNEL_VALID) << 8; \
>         } else {
>                 counter[c] = 0;
>         } \
> }
> 
> GET_SCDC_ERR_CNT(0);
> GET_SCDC_ERR_CNT(1);
> GET_SCDC_ERR_CNT(2);
> if (num_lanes == 4)
>         GET_SCDC_ERR_CNT(3);
> else
>         counter[3] = 0;
> 
> Up to you though. It's a messy format, with no objectively great solution.

Yeah, I think you found an actual bug here. Maybe iterating once over
i = 0 to buf_sz is the better choice here anyway.

I'm also realising now that for lane 4 I'm not writing 0 to the fields
after being done with them, so that's not right either.

Thanks for the review, will send v3 in short order.

Kind regards,
Nicolas Frattaroli

> 
> With or without that suggestion, series is:
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> 
> Thanks for pulling all this together!
> 
> Cheers,
> Daniel
> 




