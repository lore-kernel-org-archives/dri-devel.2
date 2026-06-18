Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C78CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7DD10EE2A;
	Thu, 18 Jun 2026 15:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XGxQ4Kt2";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A4810EE2A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781798241; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D8TC5fxlrQH1UmbzTs1z8ZoXhGxgDkEbmjF002X4/pgpC/FHUzOeC3ejxvwpY0KhsDTRrIPrue/6yQUA5/a8cifr7uIUppCVfKqqcMHqvgYgRAHAl94p3w3eWTQ3i7tgqJPkKqdjQJ84RYbbRKvUnl1vjJjo2b+sczGE9ZfFBfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781798241;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=r3+n8ej6Sz58YoVVYlXnI0Hulp3Bo/WB+dn5ZJeHFjo=; 
 b=Io3biqGD60qIc+ipLBSynf6ctansGCSwUUz52sSdddIIbYxW9T+Frn1R9Ijhck2xn2zErCxtz/00W06/r4Kyo68GBliEZ522XnWTL1R9z7Q3PaFQKC9e0+MkUEL2R/mqv7Mdz5dehiV+BLuUKCx3Ezj5KCSz9mCFtNt4YRi+G8k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781798241; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=r3+n8ej6Sz58YoVVYlXnI0Hulp3Bo/WB+dn5ZJeHFjo=;
 b=XGxQ4Kt2JjFTbMtfg/Up6lBReoWANQkzwN+mIDHSjEW8fQO29291ncr0QD24Mh/k
 cP8+zPoBz/3HwbcE20k9NOJy5Y+vPyD9jq04tJ0vQqTI+iaXo3hCUMvayTmxSZqedy8
 b6CaOGkhbT60stN3+yCOn/4QQMxudqTcRoySLjUI=
Received: by mx.zohomail.com with SMTPS id 1781798240234605.3926258420676;
 Thu, 18 Jun 2026 08:57:20 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 1/2] drm/display: hdmi: Only allow BPC values of 8, 10,
 12 and 16
Date: Thu, 18 Jun 2026 17:57:15 +0200
Message-ID: <4EJZUiv5QMWxvIU3-IRSPw@collabora.com>
In-Reply-To: <20260618-lemon-carp-of-acceptance-0ee7de@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260608-hdmi-max-bpc-fix-v1-1-6e8dcebc7274@collabora.com>
 <20260618-lemon-carp-of-acceptance-0ee7de@houat>
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

On Thursday, 18 June 2026 17:47:09 Central European Summer Time Maxime Ripard wrote:
> On Mon, Jun 08, 2026 at 01:19:07PM +0200, Nicolas Frattaroli wrote:
> > As per the comment in sink_supports_format_bpc(), CTA-861-F defines that
> > only bits-per-channel values of 8, 10, 12 and 16 are allowed for HDMI.
> > Allowing more than this has surprising consequences for the atomic check
> > phase. The HDMI state helpers may accidentally conclude that a sink
> > supports 11bpc if a caller asks for it.
> > 
> > Fix this by exiting early if the bpc value doesn't match one of those
> > given in the standard.
> > 
> > Fixes: 26ff1c38fc29 ("drm/connector: hdmi: Compute bpc and format automatically")
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > index a331ebdd65af..8303475ec021 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > @@ -420,6 +420,16 @@ sink_supports_format_bpc(const struct drm_connector *connector,
> >  		return false;
> >  	}
> >  
> > +	switch (bpc) {
> > +	case 8:
> > +	case 10:
> > +	case 12:
> > +	case 16:
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> > +
> 
> That might be slightly personal, but I think if (bpc < 8 || bpc > 16 ||
> bpc % 2) is more readable

That would allow 14bpc, which wouldn't be correct.

Kind regards,
Nicolas Frattaroli

> 
> With that fixed
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> 
> Maxime
> 




