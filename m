Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C677CC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3646910E26D;
	Wed, 26 Aug 2026 11:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="m3RQUdcn";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BA010E26D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:36:04 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso934899a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787744163; x=1788348963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gxuuGjx64HHjPINtAtl6gH3Y2mM/pzADeTGiTnvpMS0=;
 b=m3RQUdcnJ9JFWTNyGReQHNWTw0AoTzXUi4N0vJbLFHYqyTRVCrSubSpt7wJpvl0+4g
 qqTttZBz2zFCm2Ius4z7ORx5iShbpKyOz5a2c7KsWg+95FwQX5Y3Xx6BJIe9bV4fzbfj
 TYgyRq/oiRk0NqKfMVhMbaU1OcLgxpKKcADkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787744163; x=1788348963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gxuuGjx64HHjPINtAtl6gH3Y2mM/pzADeTGiTnvpMS0=;
 b=sMGx9c9dgjs0ux9/831bWNYFxY0iWkLcXoxPbbxD7pZJVIZ3FjEsa7Jcel8olNC40o
 p1aKoLlKq/7FSaaGG8I1l+XUHrvTAR6QJ79zSeKvir33+1GhfEu1q7HbjxN0kwExRfNI
 kYxUXvdw1Q5LEGRTZB/+fJmnWPsaWi2vqscxNrYzLTFQWGM7i7DVZkdq3eFjb+zD5fBF
 anxNLBfcpx5sazgkisALoXeDd+FrooI8+bPY8k9qnyC8nLSmE8paUfD1Bbepsz+sv7WD
 8TopXRzD5CEwsd0cks+/rKpBhktp77SdD7j773DDSvI9Qxy8qPNChhzvQF/1qaZZmjVu
 RfdA==
X-Gm-Message-State: AFuF++mfiY/vm1+nFbfRgB2GEZ+MNWSRQhtk2c58mYUFIKfAk/QQpj2R
 tfbLrEc6vXFVW0+nvJhl+SnVG+UquJ8XeXOnvokcNHdchjPOYD3nx+1cxm/D6NUSzhQ=
X-Gm-Gg: AR+sD11ogqq+r8cbdLLgunaq2pSaUMuSEYV7w6e5D/uQghSsHUYRRMd5/w8DHFf0TdM
 IgEqcU6AaI4ZmFZ2j58UhCUjw6SIDCBvonHEBMdsXsOa/tzLrp+fx9CerYj1Ax96kHj1hlpP3im
 1WXAJR9HSA4VXosLR81Od/xd8MuZ4qEQ9UDML/MmO5WwQ2K7xkNlgBpvomQ9UZjp7GbeMSTNMpi
 ifytrVwGwHTyI65PgCAi7rB9x59T/7aqGeS2R810SOjvPKvNsZOidDhEHqrYhmimJ1l6oYl6zns
 5eiNmE7WlHjOe+L+g6M2FOakGBSsVXoKxrvvA5UQRcO8jLt7PzyErZXJzH7PWes/8jgdF4jHN0J
 nyaRR7Nwao47kQ9yWjUstnypgF/9/8UOioLcuwZOI+xSvgSJ4xuIREXyGVJGxZrMWvFZO0GWgW4
 9pTz2kLkQVM/xMmFwjtk6mvXfjj72gNp7eiU41oIfYeCPZDnkKruob+4bwfKBgCcU=
X-Received: by 2002:a17:90b:3d81:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3966d3d1262mr7778096a91.3.1787744163543; 
 Wed, 26 Aug 2026 04:36:03 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d989cesm7634294a91.16.2026.08.26.04.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:36:03 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Triet Hoang <triet.hoang.dev@gmail.com>,
	royalnet026@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, tomeu@tomeuvizoso.net, markus.elfring@web.de
Subject: Re: [PATCH v5 1/2] drm/rocket: Check allocations before use
Date: Wed, 26 Aug 2026 20:35:30 +0900
Message-ID: <20260826113538.42111-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260818041505.1579320-1-triet.hoang.dev@gmail.com>
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

This does not apply to drm-misc-next, which is the tree accel/rocket
goes through:

  error: patch failed: drivers/accel/rocket/rocket_job.c:189

That is the rocket_job_push() hunk, already fixed there by

  https://lore.kernel.org/all/20260524155716.90955-1-meatuni001@gmail.com/

with the same NULL check, the same check_add_overflow() and the same
Fixes: tag. Please drop that hunk.

The rocket_job_open() part is still needed. I forced the kmalloc_objs()
there to fail on drm-misc-next (debug-only module param, this kernel has
no fault injection) and open(2) oopses on a ROCK 5B+:

  pc : rocket_job_open+0x64/0xd0 [rocket]
   rocket_open / drm_file_alloc / drm_open_helper / accel_open

With your check, open(2) returns -ENOMEM and the log stays clean. Worth
mentioning in the commit message: rocket_open() calls try_module_get()
before rocket_job_open(), so that oops also leaks the module reference
and rmmod is blocked until reboot ("Module rocket is in use").

kfree(scheds) on the drm_sched_entity_init() error path is right too -
rocket_job_close() never runs if rocket_job_open() fails, since
rocket_open() unwinds and .postclose is not called.

> 	if (WARN_ON(ret))

Since you are touching this line: ret can be -ENOMEM from
drm_sched_entity_stats_new(). That is an allocation failure, not a driver
bug, so a plain if (ret) seems better than a stack trace.

So a v6 would be just the rocket_job_open() change, rebased. I built and
tested that (this patch minus the push hunk, plus 2/2); happy to give a
Tested-by on it.

Nit: the prefix in this driver is accel/rocket:, not drm/rocket:.

Thanks,
Sidong
