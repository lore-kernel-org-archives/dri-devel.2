Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A67CC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5802C10E7AA;
	Mon, 20 Jul 2026 07:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SPMv6jzZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D260910E7AA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:46:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8499440396;
 Mon, 20 Jul 2026 07:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677321F000E9;
 Mon, 20 Jul 2026 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784533614;
 bh=UBc/yWJmyhiDlZn1np7aMFU7W0x6UxAAdGnPwptGW9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SPMv6jzZn0dpM8V5G+tqDB6k9osY0zBMqNnwVN16IBfeSRe3VZx8YeHOwDBSw9JcG
 sLDo4EOb1UT6hyPpEjM3kv+mn7xra2s88/SeXdVwZ49io9yAk43pj4AjAXjoQXlabY
 BW/DhjzLijdMfvcTsUDD508OfZXnVz/AwISXv37sHFEX4GUHpUIfINJRoVN4btLjeP
 VVL4w6IzYLGPrkrmFnOO1/qNX5XueoENNQCZWLF/5BvW4igopX+w/DxmcKgCcFYzii
 H7dd7tYtX3TZShsgEpgwzb1O8UolQElLRkulsVBTK64c/cYMAgcMmk6HUJAGoVkyXI
 vBmGyh8LFS56Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wliiB-00000008VGh-3CWA;
 Mon, 20 Jul 2026 09:46:51 +0200
Date: Mon, 20 Jul 2026 09:46:51 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe
 failure
Message-ID: <al3Sa-l3Hq9fxZJp@hovoldconsulting.com>
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-2-johan@kernel.org>
 <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
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

On Fri, Jul 17, 2026 at 10:03:42AM -0700, Doug Anderson wrote:

> > @@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
> >
> >                 if (!panel->ddc)
> >                         return -EPROBE_DEFER;
> > +
> > +               err = devm_add_action_or_reset(dev, panel_edp_put_adapter,
> > +                                              panel->ddc);
> > +               if (err)
> > +                       return err;
> 
> Yeah, devm makes this so much nicer. Thanks for fixing!
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I'll plan to apply this, probably to drm-misc-next next week. Unless
> someone objects, I won't land it -fixes because it's such a corner
> case.

Sounds good. Thanks.

Johan
