Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C33CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A9510E269;
	Fri, 22 May 2026 17:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="HP61vkIh";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BC610E2D2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:58:39 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so5419134b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472719; cv=none;
 d=google.com; s=arc-20240605;
 b=SR3rfAoWzWTC+MbsT+Qt8rCrxxFWoXqk0UdW7YA/uDHw48cgKFJXCJg9MmTlN8OqY2
 wNlBhW+r6xylXaz7XJbS/aPwcjyuBdO8RmtV1++SHdNQ2CCTu/ef7MFPmQmg1fAOCch8
 kad4cBwgOz8+yzHMxdBQb5jn2tfP+0AqvnFPQL5WTlPorcDa2czhl1WB+mM/14wlFSu+
 oO8C3iWiN1EfZo26rgR/jOH9nVdaTGWKY1VPAFndT5IHjGk5PEZO0BdrjDlL5cZsCN+M
 D2rXhgVbBs9YY00i9fyNU7gIoeDScVbjiGiM0euPteY7K6R9RQ0UpXQBNrO7/PR2EZXN
 g2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q0lBqvcy6P0lZlsnxlMUwiTxTM/BFgqyHSYrkDZVWMA=;
 fh=f/IHby4agDVuTJbbz4BfvizcJDp4Za6ssRuz/WkTaow=;
 b=Mkr7PkCXvoKk+2S5iH3amOvM9SO+kBKSuyiJP2PQCL/reugMuVzGzWv0F5TbhHFL/X
 adnqQ9ulf5vg8+6xXT6etOuxajvpHCtgVFGkADwDt96n2LzwCO5QySv+EZJq/cmtjtpF
 ZNLcqSPm0jYl+8hBdUjavnhgXhfHWA2Z171yLWhBzyajwfoXQPrfJPE48zlNiqRE7H5f
 4FjCJrcQnIyKzA97b4frLYIYGUqZcz5M5aYuh5POKGLna3zFmsk4jYARD443wwDtwlaZ
 ejsAIBCrwjIdNPfVtOpAwWkuMBd6dBN0Mc4lZnwKai5nZYou++rUY9MDDoCedeMaVf+M
 A7cQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779472719; x=1780077519;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0lBqvcy6P0lZlsnxlMUwiTxTM/BFgqyHSYrkDZVWMA=;
 b=HP61vkIh/ZWasZh/b+SEG3LjOyynaeao2P9QJrL2ZLLyhI/KTcMK672sYJD5rtEE1Y
 d7/MJP3+oCihx2hgYcSm0XKEM8zsRmIz68bDK9e7Fy0MzBBn1+a++yley2IbrELic769
 VdtHUlvuGZ/w9CRTyjwurffi13KMKlWthREUMU0j9FLuPJ+MlX5FnelmVTPLftRFi0B3
 Oox8czt6dqGAJUpw9QL8e4MjSkPrGedXHJlP2axlrubu/qknw/sCJcNt9nbnleFFvIBh
 vUYA7jqCEX4JUQMnSxDAVmY8RH3a0wiOIZCVxmrdfhPCPpYFOXMy6q8EeGa4Hy7UlQlu
 gedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472719; x=1780077519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0lBqvcy6P0lZlsnxlMUwiTxTM/BFgqyHSYrkDZVWMA=;
 b=XV3pzqCEJTBetD4XfJLU4spZNuyMbUN4eeptOO9iCg2rVDNizQ8APno4DjYc1u8qx5
 CURaWdAPut/+pEWOfMd4zJBZZ+m+ro8aPYY05GWu/LuvhZny01drhZS8u7GM2tRIiSaG
 HZEjv6PNw8vhHpqIwZZTrcTX9E0iEDF8QOa/D3onMaruqbAZWSGmYvDBuLtOkgf+sHa/
 RYb/W1YabI8I3hOgF1xC8W5LmjjJJMBHQPRc/9pjVDmDcWkhxI95Oji2dL1GUWs42gb8
 ZjKrpzCFs0/+IBDD4SC2hz8RAF8YvjLw2mAMWPARzyK8Dfw6cCgiekfx5SpRnV0JpVOI
 9GAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8dqKSEMSe700Tx4pCj6zLGIv+OdOzLhs3xySjIed4oxQHP6u3xPktwN326fh/4OOzzl4TyYsvaDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOqeU3QyJNHqqp9tQwcHw6PKlJFlvbnNNeSOO+HW+4qm16oLHv
 WdpPfjrLg8t2+dxZRp5pE2GdsFpF+3b231OlHRBtuliksFZJXY3f2vWLWWC20GoRy+saNcqUV0n
 Bb2QarAxAocxaC5leylWAamktgW4lf+9AaT9eTYbltw==
X-Gm-Gg: Acq92OFGRo8aG5VPMOVgI7z+GKBXj73BlgWllv6kqyrzfZgBJjcON/1SlKlDrsoKmZI
 HAN6DAP/Nl8CNryZvGlE1E1r/c32TtqLQFNTKIXG/zDtAnUauvuD4flj5SWFko1wXw1YSVc/Q0B
 tOS2PEM2nQoK3DveIBZgGfIIa0WvafmqW+LX/B9g3fdQW1nc+2G4U9e8s4A/0j/k4bwWTrWO1K+
 D5diLldPkFx1bX6oraqFf11MHM5B9TG/Ze56wT6hXxB40h0MuLP/gLjmB3brpZKCsaYm86I9DYo
 ZnQe9LI=
X-Received: by 2002:a05:6a00:ad06:b0:835:405a:7e69 with SMTP id
 d2e1a72fcca58-8415f421239mr4910927b3a.16.1779472719246; Fri, 22 May 2026
 10:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260422-hot-plug-passup-v9-0-aef804255986@collabora.com>
 <20260422-hot-plug-passup-v9-2-aef804255986@collabora.com>
 <CAPj87rNHsa2TKMcSMHeq3M7ZfyZp0P_i3FtjxQp8Qk53UwXGLQ@mail.gmail.com>
 <ZSuf-ENwSXWZM2puVBDxGQ@collabora.com>
In-Reply-To: <ZSuf-ENwSXWZM2puVBDxGQ@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 22 May 2026 18:58:26 +0100
X-Gm-Features: AVHnY4KLBBRBdDrQSQksZ9MWFv3tLc8bBlSnhslKVo0xHOZp5wL-_ZFDDtp2kxk
Message-ID: <CAPj87rOiq1i6ZFaeYoeu3jhCRdZPiwdfffHBJ97ihTxmgMJ_VA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] drm: Send per-connector hotplug events
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 22 May 2026 at 14:06, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> On Thursday, 21 May 2026 17:00:17 Central European Summer Time Daniel Stone wrote:
> > On Wed, 22 Apr 2026 at 19:24, Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > > +       /* Pick up any changes detected by the probe functions. */
> > > +       if (dev->mode_config.delayed_event) {
> >
> > Not your doing, as it was just the same before, but doesn't this read
> > need to be protected by the mode_config mutex?
>
> It looks like the fuzzy meaning of the mode_config.mutex came to
> bite here. It is set to true with the lock held in
> drm_helper_probe_single_connector_modes(), but set to false in this
> function without the lock, and always read without the lock
> (drm_kms_helper_poll_enable(), reschedule_output_poll_work()). Some
> of these calls happen in paths where it might be inconvenient to take
> a lock this coarse.
>
> Specifically, drm_helper_probe_single_connector_modes() has this
> comment right before setting delayed_event to true:
>
>         /*
>          * The hotplug event code might call into the fb
>          * helpers, and so expects that we do not hold any
>          * locks. Fire up the poll struct instead, it will
>          * disable itself again.
>          */
>
> So there was a problem with accessing parts under a lock before,
> so if we're reintroducing the coarse lock wherever the boolean is
> accessed we might be going backwards here.

Yeah, that makes sense - those are definitely called from an IRQ
context so it wouldn't be safe to take the mode_config mutex.

I wonder if the safest path which guarantees eventual consistency is
to change the !trylock(mode_config) { goto out } path in
output_poll_execute() to jump directly to the schedule_delayed_work()?
That way we could read and modify delayed_event under the mode_config
mutex; the if (changed) path will not be taken if it wasn't possible
to take the mode_config mutex.

Cheers,
Daniel
