Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD8BC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6A810E240;
	Wed, 26 Aug 2026 11:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="YL8cSGOw";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2589010E467
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:36:06 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso602606a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787744165; x=1788348965; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qgFsXhDsJkFJhJ+ciJcglHTEsr6ZDltVDS+SXgw7Qko=;
 b=YL8cSGOwLRa2+OauXWh3434rmGNQC0yQA80FaD9Z1LanE9hpsbxIA/P1XyuDmr9Yy/
 HXm/o9cmN1Sb7ViHUynK/Gb+lXZaewX3F53BK3Wzg0vlgMREq8gdw0HxSgATUpTyqrHu
 CmTKATv2psMFsvuvvCxDRlPdvY1q57pkU2eyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787744165; x=1788348965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qgFsXhDsJkFJhJ+ciJcglHTEsr6ZDltVDS+SXgw7Qko=;
 b=qQtoiCE41oSoJ65yd652bb/RwevjpQy2rn6PosxFwC9951KwZ9vJktRrJsYEFxo3B1
 Dq4d4avk/yO3twG5znuEeoSaw38ir47CFclTOvHN6fa0epAJVTAIFFTaXBuFt5KMJ/QH
 phxeWFBlZegvqAQT3xgP5Z1KH9VT574MuzOi/cA9WqM//4b+2+UoegWDStu5QLcS5Wf0
 QFrMdH0bmRMdRVA6fz88/JxMpD6KXi9lYZIo6skuYrUAS/2EEM8/oG4c2lsMZI7IDqe9
 Q0FQGl6i2+SqD642fFqY+6g1w4KuERA4POf+7UB1Cgn4o1a4Ov15J8KUDXNtU5/wnCvg
 rdRw==
X-Gm-Message-State: AFuF++kYL1aiyOSZ+G4FBDCAxvcHHQnWmWoExjJSe+8Z7Eu7GEZXJZBY
 bVLStcqgAtIN1wySDH8AXMWxYKSoep1M2ogjG1h60Wn1gsWgPxk1TS+WhShIv/ZtSsI=
X-Gm-Gg: AR+sD13GxPSmNJVKKxqw0/pWi06ELD76QNia0/vW5enz/FHl8MAYRg/j/SAmpbEjR5p
 WWuxd0mPN0AJmzNLELH1/9BYZp7rKAirqYV1RtfmHRp0Jlma6qskMbp0H1P3lZOimR1rbmD1YSr
 aENVSAKPK3pydi8hXTWcTjAOSUAwIe76qOs3s1OgUvtfphX805sybKyYxq3OYiPyBwwKnG7Ie1Q
 MeIGrA/Z2TluyNRp5DDP/p1cvpKa1ynVlYXFXVhbR+MubK7KHUbzgAu5KZz4kErvMjbOALtWdzM
 1pfxoe19bLq2E9YdtoC/DFyJEyNkXzQuYE1qSzDc/EwedA2YG/h11+GDWSUJD3DS9dP70h28DYq
 3Z6CverdBHCQxfGtW3zK5m3WyPaB4V7FLupCXkOJIz1CeT1LO/09SgO8hNs0WZh20dHMWYVM10A
 6/dJFf1ILIGAdw25pyeMJjCd7EfG+hXT7e9zaoRg+BQJieYEcxCrBcoZsKoT9ooDTX5SZIltVoK
 Q==
X-Received: by 2002:a17:90b:3890:b0:395:bbfe:fc6f with SMTP id
 98e67ed59e1d1-3966d401db6mr12655903a91.3.1787744165623; 
 Wed, 26 Aug 2026 04:36:05 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d989cesm7634294a91.16.2026.08.26.04.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:36:05 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Triet Hoang <triet.hoang.dev@gmail.com>,
	royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, markus.elfring@web.de
Subject: Re: [PATCH v5 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
Date: Wed, 26 Aug 2026 20:35:31 +0900
Message-ID: <20260826113538.42111-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
 <20260818041505.1579320-2-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Triet,

The code looks right to me, but the commit message does not say why the
change is needed - and that is what stalled the same change before:

  https://lore.kernel.org/all/20251107024620.912403-1-liqiang01@kylinos.cn/

  > Are you sure of this? The list should be freed in rocket_job_close(),
  > just before freeing the entity.

Fair against that patch, which added kfree(rocket_priv->scheds) while
keeping kfree(entity->sched_list) - a double free for num_cores > 1.
Yours replaces the free instead, so it avoids that.

The missing argument is why kfree(entity->sched_list) is not already
enough. drm_sched_entity_init() stores the list conditionally:

	entity->sched_list = num_sched_list > 1 ? sched_list : NULL;

With one scheduler it keeps only entity->rq and drops the array pointer,
and rocket_job_open() has already let its own copy go out of scope. So
for num_cores == 1 the kfree() in rocket_job_close() is a kfree(NULL)
and the array leaks unreachably. For num_cores > 1 there is no leak,
which is why this is invisible in normal use on RK3588.

num_cores == 1 is reachable there anyway: rocket_probe() registers the
DRM device when the *first* core binds and increments num_cores as the
others follow, so an open() racing the probe of cores 1 and 2 gets a
single-scheduler entity. rocket_remove() also decrements num_cores with
the device still registered.

Independent of the leak, the driver reads a pointer back out of
drm_sched's own struct field to free it, and what lands in that field is
drm_sched's decision. Owning the allocation removes that dependency -
that seems worth stating on its own.

Two small things:

 - No Fixes: tag, although this fixes a leak. Same one as 1/2 fits.

 - kfree() still runs before drm_sched_entity_destroy(), so
   entity->sched_list dangles across teardown. Not a live UAF today
   (select_rq() is only reached from drm_sched_job_arm(), and .postclose
   runs after the last fd reference is gone), but the order is backwards
   and moving it after destroy costs nothing.

Caveat: I could not measure the leak - no kmemleak or KASAN here, and
with three cores I cannot open the num_cores == 1 window on purpose. The
above is from the source. What I did verify is that this plus the
rocket_job_open() half of 1/2, rebased on drm-misc-next, builds clean and
does not regress normal submits or the malformed inputs I tried.

Nit: prefix should be accel/rocket:, and "Changses" below the ---.

Thanks,
Sidong
