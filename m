Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB61C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 00:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003D310E03A;
	Sat, 12 Sep 2026 00:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GechBcEA";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99DB810E03A
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 00:38:14 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2729774a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789173494; x=1789778294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yZQfj7II/byHNXuSfY97UNVF+e/8Sy7W9P4BrNmI8r8=;
 b=GechBcEAbNLgf8wXQnexBs8cxTcmfMQ44ndZnpsL0iUdtzv4/oPVqHqkZBK1ogEWoK
 afK6cITtpE0u1MIrkSmyLcTdz82qnWwRx8gmaFM4Svm47aUkr5KHjgDo+EngBgY1F9JJ
 otl/ZhtPcb9++TMe3kL+NaXu3VBW6ijXYca8OOPrb3hPcMPzm3LQmAo1hg3KYzQU1HmU
 x2eH8ml8e0jRes7lQsyJbkMsRwZK8zrsLSbzS89Drm5E9IzHUC52y3rLz+juWrjAuzB/
 pdPs7osCmAQ+FMMS9jiCqGoLuXRcQmmUeBhD2+DBBjJvQnOtBNjETW6d44AZcuUiEOR3
 GrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789173494; x=1789778294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yZQfj7II/byHNXuSfY97UNVF+e/8Sy7W9P4BrNmI8r8=;
 b=fS1KpBzJ1Cu+KbooXZuqYMdlUydQZGIvfYaIERdNhJ4J5JZCYVsAYaxztlOMDOugrV
 RNjr0h+YkpS2nRwlKNeTZ2QgNCZVJq98VGM65fAX723epSs9Qnb2WujoE70eEkFtwh9L
 wnACVo/a+CAh0oYvcY5s0t7LByFiCG1DRikftuiWy/84LSvu4FT2oDKiitArhH7nHPG2
 oVGHo801sjXPzhA4WCuz9i657G6HaumuA7/Z9JOQRZ3c2oO8uFz1kI4jsuuxHwY4dSTs
 mh3jHsim8eXnnjj9ZIe0tD1RXmUhnpIe7tDMMI7VY03EL2jHH57P73xDi3eIAn2Flb5f
 DVfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4sy9TyMSq1PbKAzpJ1nGRZ6ZSX4EPODenm45g7ltBKIkN3p2cUbixrFjAgAmYYMDQE5S1V1DOr5w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++khkmyWcPjR/YH3l5X0Nvy8ai7e+zPw7/q2lcyvnm85iPKA4A++
 I/+eS+2yO3ekd268ZIfIisRkD8w6VaigZpiwgQWB+gAtyxrz4dD6z/8=
X-Gm-Gg: AYBFou1EpCq6u2lU8EncDkWm4eQr6SypzHos4FrfHdQn39eogRzO7XMAGkSxJIlKugQ
 ESB9Yp+7IkGSQ9SMVgW/bG6fcIcWExWu851tlo9Wc2yFsXICUGO/atJirVPWM8qQ+SR41orBEYL
 WpOjfQ3+o+BEEoqb1cDSii4pa+hQJGJ3YoKuvXnZxSo0LkXqkmXPGCtNlPDt7eYOi9pgNrE5fsX
 UO4nDkXfDS52PI1sTGdqqx/Rpd9+b187BEs/9+5Q9OiOKfujmvoIPeSLfGSnfPfJidLaFoqAiaC
 UKipTgsfF919CQOXl6E2bOELHIubKKzJjkphXiBMX/AGP2VXD0KCGBU5qGZhhtf+7+VmooTFX4D
 L7dFXHnqaoowzERUewZE263hpSalHrKEq4D+GiAH9fqpP5ECVJwg65lFDWEMMD+qWC0RBu28HK8
 R0EcLh0X9PQcSiFfa2KAraUewqrG111rhIyL2i7ea6g1qR75B+ARMOC0Z4gdOEP6gjr4M1CTriH
 bzfnZbxV/OWwB9Xx/OGjlADbg==
X-Received: by 2002:a17:90a:e7cb:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-39d9b960826mr1728046a91.0.1789173494034; 
 Fri, 11 Sep 2026 17:38:14 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db113a3d0sm2808801a91.14.2026.09.11.17.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 17:38:12 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <ltuikov89@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sched: Free the run queues at the end of
 drm_sched_fini()
Date: Sat, 12 Sep 2026 09:38:05 +0900
Message-ID: <20260912003805.1900119-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910123736.6EB8D1F000FF@smtp.kernel.org>
References: <20260910121601.805032-1-donggeunyoo.kernel@gmail.com>
 <20260910123736.6EB8D1F000FF@smtp.kernel.org>
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

On 9/10/26 21:37, sashiko-bot@kernel.org wrote:
> [Critical] Potential Use-After-Free of `sched` and `sched->sched_rq` if
> `drm_sched_fini()` is called with pending jobs and `own_submit_wq` is false.

The chain is there in the scheduler. drm_sched_start() queues work_run_job
unconditionally, and drm_sched_fini() destroys submit_wq only when it owns it,
so a timeout handler restarting the scheduler during teardown could leave work
behind that later reads sched->sched_rq[i].

No in-tree driver reaches it. Of the four that pass their own submit_wq:

  - panthor sets .timeout = MAX_SCHEDULE_TIMEOUT on both its schedulers, which
    drm_sched_start_timeout() tests before anything else, so the TDR never arms;
  - powervr refcounts the context, and pvr_queue_destroy() runs only after the
    last reference is dropped, which in-flight jobs hold;
  - nouveau waits on nouveau_sched_job_list_empty() before drm_sched_fini();
  - xe never calls drm_sched_start().

Both drivers named in the report are covered, for different reasons. So there
is nothing here for this patch, which only moves the run queue frees within
drm_sched_fini().

The one thing worth recording is that the protection is per-driver rather than
structural. A driver combining its own submit_wq, a finite timeout, and
drm_sched_start() in timedout_job would have to drain before teardown itself.

Regards,
Donggeun
