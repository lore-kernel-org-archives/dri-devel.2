Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2677C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1666810F8A0;
	Fri,  4 Sep 2026 07:19:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mV1kV7Um";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF7210E0B5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:02:49 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so694581a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788422568; x=1789027368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3NJLiu+EaUZYTx9JK9o8V3S8dlOMXCZdqBmUNi5lURg=;
 b=mV1kV7UmYZtjAm0wVIedmwu2sc3o+26keT2kOjb5XMPbgFII/yWduGnE+qspkJ9SOB
 QI5rQjt4U0gHQS6IQyZqtFEmUBn3nXUWNoCVT3uM92d5oAXxdSnsb1wX96W05wl6MSfy
 12Sxvpfka4d8siL3zfWPpP/eeEOycaya4paIbTcwBkFM/cTUepS2dCdiBv90vQ+HBinT
 pvErjEH+WWpfs4R+V/MfdM04Yc7tiB3L3ft3qy44wGn8UD/7WKIzH1X4YjndOrY7QLZm
 Ay6fGV/eT+B7jR/foI/58i0LHPsezH/gQwVh/pB0Y3D3/ec8m0JVNMXs6Xecg1QTJfGo
 SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788422568; x=1789027368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3NJLiu+EaUZYTx9JK9o8V3S8dlOMXCZdqBmUNi5lURg=;
 b=fwx1i/rMlR5j/Munbx/CyVKVhW0YkrtRCIKvtk+M6Av860/apdyLu0dKdY5NZuTIg1
 pIGO4QWKPRsX0aXwQ3QHjKe5uo6KCcYYQvppJsRJXYC+E+icJ1rel8UT+T/ofeFEhpQG
 RafTyYgy5wLM3UutQEjfhJcRaxaPyXUXzA1hANmpeONT2ii/Byry5bgEmaZ86vkF1zR6
 DF/nO4FNh172IflJtQJBVilj0hXW9Lyp1tudWp3Qqd4gFRYu8RhWJ8hs2JbhJc7xfaR3
 LjKiJ0SIj5Z+fyyRH5wxUm1pRaZmqNMfkbGTF5BSdnI3h64eQfVSYbxOJsyBZr/UtBlW
 xB3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8BegXQZwYq7QrlPm53vzeKwlXT/pypt99yJXVjMO4J/LJpC8Ah9FMPVqWyRb3OqAb6XEEq9+2iVo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l1uwQe0NzdAQ1IwSmozNiWi3l3yoSfDvRQ5UUo9eCDLufnKFOD
 yqg/6vNuKGGuepXBNE1Fah+MiX9z0/ThklGoTgYcTqDeIysfW0Jg5AIq
X-Gm-Gg: AYBFou30L+Hgm807x+QXzzOf4RIzgFxC6AWn117hof4jXu5F20Qh8nirTKRalVi/tbC
 J7YBa0iOauLqprFwDuyUN42aVExcsOVh/OYOdAXypPHpt8Pe41ht3iXtC2W1aq7PbxubmDE3N8u
 yz1rT7Kcj7O71xDf9RtokwJQox4r7zWWTdZun7qq02PbUUtOE3305w9tzKNuOkjvp4LgpHnT1Uo
 30Rg3mJkl3hU5mZK7X35hqDzsNx5/DeZ2BYNsCfTi+C1uqOK7H5BxkpAWVwvV1d93U1eJO5cHcq
 8BMI7ZPh2vZaJVsLyC3ZsPKY52aXZZSmjK3hhEcPXJLVzdeJ7C04TJVz1cS3MgmeFwnYyA/qLXL
 u4xZjhFyAFdwY9Sg2WlWfIwKXmyTH3B05Wp9FpTxqtIFHIHepiTGVEZuVapKcbEJjB50TfXJoVj
 mk2jp4RVFzcAcbNFPEP1fyUbgitrAF8B2fSKT44SASetFJFKtBFuZ1961ng/W8MKTne5ZCxbLa1
 oQ+bgAsLV1DoOZn7f8zk6mZb+7OQfIMLlyzg+AE3q+NgZZ5DDVMEFkdPAHcRPiyMfkhnA==
X-Received: by 2002:a17:90b:4c0f:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-39b1325b61fmr1613732a91.9.1788422568460; 
 Thu, 03 Sep 2026 01:02:48 -0700 (PDT)
Received: from francomeister ([138.84.137.76])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm3742832a91.9.2026.09.03.01.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 01:02:47 -0700 (PDT)
From: Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org,
 Francis Marlou Pacaro <pacaro.francis.marlou.n@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix MALL hysteresis timer underflow at
 high refresh rates
Date: Thu,  3 Sep 2026 16:02:37 +0800
Message-ID: <20260903080237.5724-1-pacaro.francis.marlou.n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
References: <20260903055952.62906-1-pacaro.francis.marlou.n@gmail.com>
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

This is now runtime tested, so the "compile tested only" note under the
--- in the original posting is out of date.

I rebuilt my distro kernel (CachyOS 7.2.2, same source and config, clang
ThinLTO, generic x86_64) with this patch applied.  Hardware is Navi 23
(RX 6600, DCN 3.0.2) driving an ASUS XG279CNS over DisplayPort at
1920x1080, VRR range 48-360.

Unpatched:

  - the WARN fired once per boot, at the compositor's first modeset
  - after resetting /sys/kernel/debug/clear_warn_once it reproduced on
    demand at 280 Hz and 360 Hz, and never at or below 240 Hz, which
    matches the ~243 Hz threshold in the commit message

Patched:

  - no WARN at boot
  - no WARN at 280 Hz or 360 Hz, with clear_warn_once reset before each
    mode, so those are independent negatives rather than one suppressed
    warning
  - the function no longer bails out of the hysteresis calculation at
    those refresh rates

No display problems observed on the patched kernel.

Thanks,
Francis
