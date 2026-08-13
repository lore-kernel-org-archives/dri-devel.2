Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CFCC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D975F10E529;
	Fri, 14 Aug 2026 07:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d9X7pXWM";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6C210F2D2
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:27:00 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso1625576b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786620420; x=1787225220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NnsKlsQfAgw4TYphFLbsBTyUS9mLXz1EROz2+K+BZeY=;
 b=d9X7pXWMRdgQtSk4EKmHoRHrNslaRra4TyANwEalINqMX0Xfu8wre0QhT4Rpultdh3
 EE2B9AqzyTVhfdC/llD9H909WwQ5aAc7dU4pDYMZZ5vdpZzbPdo77pS6K/gTmIQ2QNTd
 hlPr1JEnOXn4tFG7osLwn7q6COps1iUhfla1Kiokl8Rk01m9JLZj1nTrul3CxuYIjWiR
 PI3wLesnagdrPoE1dFCNfl7lr6yzdaB7XO2zxaXE1UzC19tn8TdnNqOQePw7bTGHstGi
 OQanLjdntu6WTEw0MGwMjU0M31ITzrs7riiz+7fn07gn1mK9jXgeWovQYEe/ggpTlu5H
 fNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786620420; x=1787225220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NnsKlsQfAgw4TYphFLbsBTyUS9mLXz1EROz2+K+BZeY=;
 b=Rfakh6s8J2og882Yr8kFW+mhzCGVleNQz8jHt5fBmNydCCh02v1Lnp1jDQ6YXtaUq6
 nJ5DqL7+W7OEIeoK7hX/qCb6lTGmIIIyDu0pUpcR2toEeuizEPARRnEGeYiVe+DR8wFe
 670DztlD20BVGrkDXSWUT8iRy9VDiweigmw4SAiKVaDuI5Dg5uJnnbIMU8p244aYEJlM
 bbced4fAVemR2PvnDpCqW2ij1t9i+nCpKe0YxnURDOaKr2hMnoz9A5DSGtGb5tYOW8T3
 u75Ub9uyAvTQ9ahyMQYWYqdwM8CMb48NyqrDUvCQXcyKswmrwhd3gSPJsH3hKxT0girK
 wLaA==
X-Gm-Message-State: AOJu0Yw6EM9+uXq4eU0Q55OVRKYhcAVf48xVWL2QHnqpgp/Dai6Bcilc
 IX+v83e4UlJqiq1xSwS8MCjLR4lZVUS4R9JSnGiEe5T/iixF8RSX5tBl
X-Gm-Gg: AR+sD13D83Igt0jtICe2KezrobQ+sMVudku/vhs+hTAqKtlEFdu5N3XrhLDaIUL8flm
 sDdO6HQcPTAOACppJyCVTG/mu8j8+6exV9L0NSkt2Fn0/r3NWigFsATu5tnXxRavOxTLWVVXNsZ
 QbRGrAORiUWMCOixmtcfO64lRjJUwPhwQ+SZCSFpdl19wTXilt+gjBm20mJS1Tu+1myaL/bIMiO
 4KI1DuO0PAPu/L0el1ugkNtwYt2xMHpgqCrxLwWVwWofHUAl4CizUyFeqBck73i06BAu8ZH8RxY
 1zKDOxaB1xCDmoPHTSD8pxT1bdTpYHUCxR8kVIAEH4LnKdth433sKiWzuZvLDgVfz4RHtMa32fR
 X2kDV1hqgq5bBjXPDUWAwXY1MRnpJEHQt/KqQzuzEt1izsuHWbyt59/3Gjiy7xb7276+TkTKKGN
 AR5QzQso4rm1+ZqzLnws68giG7O6Mz4KttjqXb7D/m+DlwPtYz0qZpPa7bMUbEP/FgQ9kDI/sHA
 Pk0inxtLQ74m+2m3s6ZBvRN
X-Received: by 2002:aa7:88d0:0:b0:848:70dd:f5a9 with SMTP id
 d2e1a72fcca58-84fc74958c7mr4544635b3a.38.1786620420195; 
 Thu, 13 Aug 2026 04:27:00 -0700 (PDT)
Received: from localhost ([64.176.39.245]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a59d80sm894282a12.11.2026.08.13.04.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:26:59 -0700 (PDT)
From: David Weber <weber.aulendorf@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, David Weber <weber.aulendorf@gmail.com>
Subject: [PATCH 0/2] drm/amd/display: Fix streamless connector update and ABM
 modesets
Date: Thu, 13 Aug 2026 13:26:32 +0200
Message-ID: <20260813112634.11455-1-weber.aulendorf@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

Hi,

This series contains two independent fixes for connector property updates
in amdgpu_dm.

The first patch fixes a reproduced NULL-stream dereference and is marked
for stable.

The second avoids the visible panel blank caused by modesetting for every
ABM level change. This is useful for desktop environments that want to
adjust ABM dynamically for AC, battery and low-battery profiles without
making the screen go black briefly on every profile transition.

It would be nice to have the ABM fix in stable kernels too, but I am not
sure whether this behavior issue justifies a stable backport. I therefore
kept its Fixes tag but did not explicitly Cc stable.

David

David Weber (2):
  drm/amd/display: Skip connector updates without a stream
  drm/amd/display: Avoid modeset for ABM changes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.54.0
