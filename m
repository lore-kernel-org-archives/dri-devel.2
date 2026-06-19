Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7976FCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149A610E095;
	Fri, 19 Jun 2026 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1+wijf1k";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B160C10E062
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 09:53:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8BACEC06CD8;
 Fri, 19 Jun 2026 09:53:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C0DEA601AD;
 Fri, 19 Jun 2026 09:53:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE210106C893D; 
 Fri, 19 Jun 2026 11:53:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781862811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=73m8X7tBYSSumVWkvx9MDN1jdOTQZt/hH/3vwN+HHRw=;
 b=1+wijf1kiX2kgBi40K4x+/I769WQqqYBtdDTJX6kTFve8e8nZurxu3lBXqxBvRZtOX6hJB
 svT/D8cf6+H7lLm7YwwUUdy0fPupG3XEa2txFpgUBaaMrWlufSA90JnO+wORouEDtL1CBJ
 zq2x/pBq99XqDhugR/Jg2pfd+fV6lw3eDZ2PBqXtvyMzWcKzPzRiT1PqYj8bn6FzoZlVpJ
 VJGMbTC5zM8uluOPAqCKIcGrpFKanJC3FdKvUBUhXs+IZ10yYY+Vr9s3dysayL3vn+QOH9
 RDElkcjVagilYFVm2UD2BmPoIC7Yhjwec874oBczDdXhj7F2CvxLwgUeA3G9lA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 11:53:24 +0200
Message-Id: <DJCXNBT4Z9TL.NSC9B3CHXGFE@bootlin.com>
Subject: Re: [PATCH v2 07/78] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Dmitry Baryshkov" <lumag@kernel.org>,
 <dri-devel@lists.freedesktop.org>, "Laurent Pinchart"
 <laurent.pinchart+renesas@ideasonboard.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-7-0a91018bf886@kernel.org>
 <178171213665.312625.18415471327369488806.b4-review@b4>
 <20260619-provocative-mindful-boobook-d7d2c8@houat>
In-Reply-To: <20260619-provocative-mindful-boobook-d7d2c8@houat>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Maxime,

On Fri Jun 19, 2026 at 10:02 AM CEST, Maxime Ripard wrote:
> On Wed, Jun 17, 2026 at 06:02:16PM +0200, Luca Ceresoli wrote:
>> On Mon, 08 Jun 2026 16:35:49 +0200, Maxime Ripard <mripard@kernel.org> w=
rote:
>> > The drm_atomic_helper_bridge_reset() helper is deprecated in favour
>> > of the new atomic_create_state callback.
>>
>> I understand this series is eventually removing it, but it does not seem=
 to
>> deprecated (in the kdoc at least). So maybe the commit message should eb
>> reworded as "The drm_atomic_helper_bridge_reset() helper is about to be
>> removed..."?
>
> Sorry, I meant to reply but forgot. I guess it really depends on what
> you call "deprecated", but it's very much something we want to move away
> from when creating a new state only. It might not have been as clearly
> documented as one would have hoped, but I don't think it's worth
> documenting something we'll remove in this series, or change the commit
> message.

Thanks for the feedback. I guess this is not the easiest series to rebase,
so I'd say it's fine as you are removing at the end of the series.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
