Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1ACC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B671310ECCA;
	Wed, 29 Jul 2026 16:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sYxaD8bf";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01EA410ECE4
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:16:20 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-69f7130b47dso1660154a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785341779; x=1785946579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eMJlBiwtyHistA8GT4XhygeFXexQs5/OtNgJ+24npX4=;
 b=sYxaD8bfGW6MVgjaddgvchrHWgkOmKFwOaN9fIfU4Qkk43MJJwWXAmDdmmwAfmHMu6
 nES661hfXLeLLvE0403t6tuqKEhs1WOsCnGVQUQzXWd5JeB4odJEzCgekL9tc+YtcWjX
 bic8lqW9WgUiBhlj1JY4RUVon5ryN59P5NHzwFGBcu5vN3jefWKDUvvNcN4+0QMikGPI
 eBDEsd98It9wr7QujcHsuNyrIVrxESE6ZfBXqF/0mskr3Ox0qKcali3O8ipSeXfodiiD
 VMKIKcHBCplIC9YpSPmExrh9r3oMTK1hDFomS0RdlY958BJ/BnPe7dXYYWW79YKRuqub
 59yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785341779; x=1785946579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eMJlBiwtyHistA8GT4XhygeFXexQs5/OtNgJ+24npX4=;
 b=Ft0p+veSdzJ8BzokNjZa5NdbcrKysCl23v/F08Ww4i75Nka2aJIupHCv3xAFHaoAKw
 y2nW+1z+InWAUoHZPpFJxK3n/C7//4Sacmq+TquAZ2FTS3PqJk6OiUQNxfjdAddHS/r8
 8jU43Bucdv6bWQ/9a7RO1Lfok+bwt+Prsr5IHfA86bk32kY31gAUH05c2mAFw0xA7ZWY
 GlLBQ5MWS52tWHuQFOCbhK/Url5dryIrWZSlHvmqBxEbjDOWZ5zVY7fnElFxBlv0ahEr
 yF+AuZI7GTUK1tNgy799S5NPeVEDlai03msh5RdkyX8onkD4IKn4sbBPpy2RIbVn49+V
 9zxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLlD8n39/y6uzku2x4rlHtOPZ1hv7gBFP8PLuqGVJHb4a5TriQ9Ub0o3m5G4W56Cw1JYLlotjNZgQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6CljQNq4gpEIKy1AmP6Dz88MAAAfxzm8iUUcYkJ05u+8NtoZj
 xBmJ7TLqqRCM1l9NF47fIV7GqN/LdTk2O6sgd7960oZtDSDmITchHSEq
X-Gm-Gg: AR+sD11rJAFuJlk7TZHzNkYu/FmdCA+Iftrd5jXro9rG3Or3gccqALVCisxHlL8S0v7
 2V9XkTtFuSFTUwSfWKhyg50D5L/QkpzzE6h1DznD8RSVdELMUpai0pX+8tgTixgaIuTdP9mUClR
 nA/Gx6sS0lJObXS3lWsTTAVsFJnnlITqgVw8P3JuYkN56a5Ts0m1NF0KyEjucFVYigD9PZiaUuD
 4gp7Z2I8lQKbaxkArHrr/8MKOa77umRdYiaM+OEEDaE9+N96Pvxmb9lV5pzUzMkW6CCyb6jlBlF
 J35JVV0rlLOvf7LUxNwjKjYr1s6PRnrPLD9GZSJkQeeOhJoMqXdkktd8QMCCyTa/zeik+kXXeAc
 s6H9fKyctvFB7VVy6ZFRwSZ6zZdqJtZCGLKjidHUgL/w0B8rZjOFw9r3TLlMAu4TuT3Zs9g7Xo0
 XpGO9O9BaNtby0mk16kqYvJrfiyVrv3XqStyPCAQ0kuBrkq8GmU4GK+TqtgaRVuVU7H5Z60d+LQ
 x7qm+6zQeKJI1ZYjlZ5mXKeuwvr3cS1dFsQdZ55atfbNOQ=
X-Received: by 2002:a05:6402:20db:b0:69f:c197:9e8e with SMTP id
 4fb4d7f45d1cf-6a034a345e5mr3985008a12.14.1785341779258; 
 Wed, 29 Jul 2026 09:16:19 -0700 (PDT)
Received: from JTOLLET-M-FKW7.cisco.com
 ([2603:5004:2080:100c:3523:a231:e3ca:acc8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050c60154sm1030511a12.24.2026.07.29.09.16.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Jul 2026 09:16:16 -0700 (PDT)
From: Jerome Tollet <jerome.tollet@gmail.com>
To: jani.nikula@linux.intel.com
Cc: ankit.k.nautiyal@intel.com, ville.syrjala@linux.intel.com,
 arun.r.murthy@intel.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Jerome Tollet <jerome.tollet@gmail.com>
Subject: Question about drm-intel-next vs drm-intel-next-fixes for HDMI
 scrambling patch
Date: Wed, 29 Jul 2026 18:16:06 +0200
Message-ID: <20260729161606.81668-1-jerome.tollet@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Hi Jani,

I would like to better understand the i915 patch flow, rather than question
the decision itself.

The commit b7d51d65e4f1 ("drm/i915/hdmi: Poll for 200 msec for
TMDS_Scrambler_Status") was pushed to drm-intel-next on June 11. It was then
included in the July 2 drm-intel-next pull, described as the first feature
pull towards v7.3.

However, it was not included in the drm-intel-next-fixes pulls for v7.2,
including the June 25 pull, and it is consequently not present in v7.2-rc5.

Could you please explain how the decision is made to route a patch to
drm-intel-next versus drm-intel-next-fixes? In this particular case, was
there a technical or review reason why the patch was not considered for the
v7.2 fixes pull, or was it mainly a timing/queueing decision?

I am asking to understand the process for future contributions.

Thanks,
Jerome
