Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F89C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A7410F88D;
	Fri,  4 Sep 2026 07:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e42yl5o2";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7148E10E52B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:56:15 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cc891373e0so21601405ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788422175; x=1789026975; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sRqkFHuZea5AlRR5uQ7C1BJC5FSBvAR65ffCkEIt+cQ=;
 b=e42yl5o2aKKOa7TvT9NccvaFIWuFr55GmuRNf1WjMCXrj6YEnLJeeYTQSdCAv7HOvd
 a3kr9ygXkEQNIcvxY9rCRILpwQhCX1MA75AoNxfgdAcTdDL3YaZL7fTyL1XdhaIwJbg/
 8Js6w8284bNxvKVFtZYK3RhPtivd3v7TjCk2McMh4y5MOPRjTA5yyIMhLKIiSXWr3Oj0
 ZwWU3cd4Js0Uu3YZ6KVeYeXmTTc8nCR/L5/+YancBs+a3l1ae0s9AHtYAzt7u6hJ3tPX
 n0QJuUqYfhGZuusdQ5/Aoyh0aC2GZvFWYvX3hrJfYAzEKTlS7ai0FSvNPZr57feTHdJk
 Mpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788422175; x=1789026975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sRqkFHuZea5AlRR5uQ7C1BJC5FSBvAR65ffCkEIt+cQ=;
 b=TFvSN7JBOH1tEFdokNprHFzrYFGBAfH8Esg7TVFb7Z+1TPBE7EqvSUQDhPu6vpBl8T
 hNpvD3yU+ifWEQB+5Z02Pe2t+tFP0uN0/+SCoV0dAro44ZbkR0VOp0oUebnLe6xMVjRS
 ooPgawl4BEmpqg7h08gewUNc5Okczn7szG5pKSVvXI4yXq4S0tuO9i0NwBok/tUZX0/2
 UeRedo07HjdoRbHB1aiozsaSPWq2O2fRpP5vdawxgYnPbRfjSk/hgEcQdOovk8iLFXrc
 tB0B84FNjZ53PqLNhjexBWiaTQ0e0fdtylby9CPMnlJ37/QvXjsEUsf44x7Q38kMf6wD
 nKaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkuejUK9xDAPSjPJqCr/DSG3s6IU1qlp9rfScUjxqMHfddv23IwBAHnxEAN+Rpe8O1AMfJZjjCz6E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDF3I85wh+vTGDjPuWM3ad5q02sW26yoFEGLsIY+EUpFolAHCn
 Xr4UBO3KswX0JXxugorZlii4wyFicypWQU5H/dfo/q0yrKmGWgjevcW9
X-Gm-Gg: AYBFou3NogoZO0ZHKZ/rGOZAcboMjc7nvSwR1nJLYmxXeI75+UMFP3rc+zeN/eeat60
 VGKSH/QmdQIkb+ac+PVI1H+GDrnIISdjujz64jdt41CZBzKA4RtKOfOt+6/nRqpladqrA/nO/2V
 n394hoRu3mDFC7xO04FohV5UtDRcRa8Wc7eT2EsdUz8o2AqGkJd57tDRp7YirpUhQDJr5kgM5Vp
 /7BI98/CANPxuW3kWx0kY4ekxgPuRTevWwXVuIuPJDQTKGQ5SbfjNOvg5gZpGdW9+B+MXsAMGRC
 MZ6Z4WMYXENVayOBgrmajPeOzmkmN4gdkhqiLK31YUQ7V3JQJvhnNgUsCqCNKBgrYfMbTRYCEUU
 4lASNZr9DwA8RYKVnUg68vYqILUucBRPfud5P18X/CSYhmg4lKZFwR8dG5fDL8zneCB9jKyqy5n
 H1WGTW2oHgTKjyJ9bfKWOFrhSGTcMh3L6ApYWckCMQIopPlUyNevXugo5skn3jE+ZX8T9sBI8bD
 GsiD/2xkOOTDKzplpwo5UcpJQoOGGqlPZ2Bi5G5dPpVMp+avdYkOqmasa3p7zvOOOcOLw==
X-Received: by 2002:a17:90b:17cd:b0:398:9beb:5c19 with SMTP id
 98e67ed59e1d1-39aee178f15mr12943740a91.20.1788422174836; 
 Thu, 03 Sep 2026 00:56:14 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm3771943a91.1.2026.09.03.00.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:56:14 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, sashiko-bot@kernel.org,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
Date: Thu,  3 Sep 2026 15:55:23 +0800
Message-ID: <20260903075523.5182-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074152.456231F00A3D@smtp.kernel.org>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
 <20260903074152.456231F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

On Thu, 03 Sep 2026 15:41:51 +0800, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but could this calculation trigger a division
> by zero kernel panic if denom is 0?
[...]
> Would it make sense to add an early return to check if refresh_hz evaluates
> to 0 before proceeding with these calculations?

The arithmetic is right: refresh_hz == 0 gives denom == 0, which divides
by zero both in the div_u64() and in the 100000/refresh_hz check a few
lines below.

As noted, it is pre-existing.  The original code divided by the same
denom, so this patch does not change that exposure in either direction.

For it to trigger, refresh_hz = pix_clk_100hz * 100 / (v_total * h_total)
would have to truncate to zero, i.e. a mode below 1 Hz.  This block only
runs for a single active stream that has already passed the MALL
eligibility checks above it, and with VRR the v_total used here is
adjust.v_total_max, which corresponds to the panel's minimum refresh
(48 Hz on the display I tested).  I could not construct a case where a
live stream reaches this point with refresh_hz == 0.

I would rather not fold a guard into this patch: it carries a Fixes: tag
for the underflow, and the two problems are independent.  If the
hardening is wanted I am happy to send it separately, something like

	if (!refresh_hz)
		return false;

before denom is computed.

Thanks,
Francis
