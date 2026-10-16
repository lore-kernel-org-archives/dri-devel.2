Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D69CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457E110E695;
	Sun, 18 Oct 2026 14:53:56 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32B8410E043
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:49:41 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cd5e6f0a22bso1659486a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 06:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792158581; x=1792763381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1mrwer+9rG6x0Ix2L4QYhOLb2chGH6YfSMQHz63yd7A=;
 b=T7zTpyrj8foAvAbSj+gV298qKIThLHm9ACyJrnnGs0eMT4yC/i+zG0nfqONtqescQ9
 kc6nM/Wi9VlnEu24xyrgNQA/NsIM903CjePFRhe2a52Vv+HlOWiZ6ZgPcUaSoiY1sJxC
 hm+4LWe1jtmLcafaSAgdO6p9ijbfQW+NGNT1D09o7DjoiPUeq8DhlsSlENUARpu+K6Fx
 U4NepwkpdIntlJy+QF2X38UPjWSP7OrvK/UYRc4/D/2398wuAThhWPuqQzryDBDpkxkf
 OxpwO9KmsPFdqTnw33UTcDItaqnAlbw262LZ8kczYD8kXhI80GeWP2UAUkQ6n75tt4uK
 PFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792158581; x=1792763381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1mrwer+9rG6x0Ix2L4QYhOLb2chGH6YfSMQHz63yd7A=;
 b=Jccoc18M+9MDZVnVgJtSWkmdpBz0Hnjq7suIYcu5cjFRTPgNC6QKLURWEIxDX9PYmP
 zKiaIg7lxrUqCyRBaVXcFHnzhoeoMq8tzJmsz6PJPSX2V8UWM/QTdMms4d5zGcCzBqZ1
 88z6J1VDMWhd0L8k3ruCuthhzpqHhjB6OET/GkfS88xkugIOaNyoK0eR8uib631W6laC
 9/cZHO4anNXuHcgxp5JSlKlDzJIhJaybCKUhlc2+KjQFIZUAtR2lY7UpgFzIm01fhF0h
 /2JrS+QYsrbXV7bUI+jN88wLA/jfHqx1e9dEphGXvGxZcFo6fGRc1Wx4pgvWbsvXZuht
 jBdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSssxe8g0U7CECKb410Zllg9t2JWDyxWecEhT5YmeDJVj1txHLGVE4JAiJbGYB4yu7bFSOIF/U/cc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/I9xT7NjD1+RDXrux5lSqeJe5lWuFqO4pgeIzxTjStUBSBMIc
 l6jXhboyTLyTsUanMK9CFwUMSJqM5UcsmaURDpM+xPeUqLanQqKwZRng
X-Gm-Gg: AYBFou2xxm46zPhxOk0AVGaUOwzxpedZk1GOuQmO5UqX9vLDJeXWeWdgYW0drIrkLo9
 03k5wCuwfil/zJaIhcm/Etj/T3t+ieWtw2jI35Ryo7VrxsMvhv3wS/cQiaAauJeVmIYZ0JwjGku
 l7Uo5M5sWHEVb0YbZGEdU70mLCEQ8XslfHBfay97ta1Axn7zc/NTTkD2aeVJ60m1cw8atvQwPyj
 A2FNui6nF8ucH1HszeYmga68jNVcbJCURr2X7CbsDELkgKRdvRHaIMefs1CU29jRyWzJ+Z/Yl9t
 QqRfjawAGPkg9VRFOHdUeikU/OaDvAUGQi5idLhU7eGJWb+QLWIpLMxXDieotYReWngq7Ua57uA
 eTT0qo64/TqSDKA7dz57t3ClDPvVvsZ5opWvrMoDNQBHwaaGrED61VDcWdDtUW3cVhp2cvmt3o1
 lE48YSbzcGtEGkxW/NXMoalQLnJoQuYOD6FlOWJXHFTH1Z5zXFAs+lbcSb4Ov9v//ZWgkLhkisl
 5cWt9+VASMZT1ezrP3mIdnCTT7L+gfUyPKOvlOR7jeZRu1fVGn764zSonGWhujN3qZrO3lz
X-Received: by 2002:a05:6a20:e293:b0:3dd:a009:3182 with SMTP id
 adf61e73a8af0-3e16be7214fmr19585384637.42.1792158580457; 
 Fri, 16 Oct 2026 06:49:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd65497fa3fsm1142333a12.5.2026.10.16.06.49.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Oct 2026 06:49:40 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Fix kernel-doc parameter and member names
Date: Fri, 16 Oct 2026 19:19:19 +0530
Message-ID: <20261016134933.35084-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016101534.14179-1-sinha.aryan03@gmail.com>
References: <20261016101534.14179-1-sinha.aryan03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

This is an accidental resend of a patch I already posted on 12 Oct, with
nothing changed between the two:

https://lore.kernel.org/all/20261012154449.42015-1-sinha.aryan03@gmail.com/

Please drop this copy and use the original. Sorry for the duplication.

Aryan
