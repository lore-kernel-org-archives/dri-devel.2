Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518A6C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933A410E7C6;
	Tue, 28 Jul 2026 07:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOLI+tcI";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8105910E44B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 15:28:25 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49557167508so27911615e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785166104; x=1785770904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xR8fBXhyULcS9rw8dxfF/pU3nQ4nEDbAUP33X1bCS3I=;
 b=jOLI+tcIiMnJyey0K1t6NWld0kgXuZdCVWQvFTerrwDLFV4T+qImQGreYda1RGJY8z
 fKv6zYpt0wsQ/h4SW5XioxWXuA+LEBF0i9L1PmX7ooi44tpsFJfYtbG4IIuvktoZzgND
 ny+3NEgFTDj0uvw/Gq0OMaILVpDI0yx8OeA6yiCNq54T5Gh6GSVhoGXSCNyWkF9Kjv6F
 beudl1Dr9Bf22jvHS7fgvrZCuiqy0/iktbrgaZVAc/8miuk2Gp5tZzIBRYj+qRXdEgNm
 ykS5X0gIkONHUeZ7M/RCT/Zj6oYL3BfI5G9dJtBtwjxfR9qvA+a+vx+nUGZmzB9ABuWa
 zRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785166104; x=1785770904;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xR8fBXhyULcS9rw8dxfF/pU3nQ4nEDbAUP33X1bCS3I=;
 b=oCZYAHkDxeYex7arE9x161xZcyg7rqVeblJnOEVkQRP/B0WgMd4HN58CuX+skPaDao
 a2jNVCxk7WVWBXUzfNO/S2rHBUgoIyD5BCdCn7ARFSCN7yZmu6KkcXKAft+sKsdNfMO+
 UHFgtgejhkOqllXu1vkqMMP2xSXZUc6AmJ1N2Z3dSCzbCgLFD/h0UYKYFFReBtEZgTJo
 6cZS+gyY3ITwYKi4FwuunfaSFLNfmKzzX0ynrgQmAw/yIw6NbDaDmvynxQCTN0r/ulKo
 FfmN8OPO6564CoNiNwVYYXmwrNpjd9XKgU7WKJepqLx7i9ngB4Y8nfpTDpk4gkYhT5LC
 NzgA==
X-Gm-Message-State: AOJu0Yxl1dbpJg1El/7x5iVjc1uKAK8PBb/xxjFazcmH9kViFJzHDitP
 ZoARnVUav9ebAVvGDySlce3esGQvkfw2WeSUa+iNgvk9ZAzTn8kxKFUG
X-Gm-Gg: AR+sD123CTEZk++rJU5qslan+8CMEsMNR9LLmMnk/Dz8puT8JMV9v+jD5XdLe4sjoj/
 QW+bbI5nBNn4CNNvWoT+ETQPKBbcooujvn2QZsjtQrAdVaBG4hzSH0AoGaxzbmz7kCwNJv4ZeQh
 80/7ddrmECQLYe2JnfSgUOMfJK7ylLaJr681mh4va04ku8ofp+AdN9rm4Sv2t4dfcyyE/RGd1qI
 46SoiMf+zt6HZP7ZYRbWn6SLYFh1/DY82TvjLwYbASm1Z36D/a+MILWx1AwmM/foEZOe8QLrgve
 cJqqnH2jSTDqusWKo0sRfcBsIKfabBPOTMpA3ictKQI1mp3TxWa4okfO/O/HE8Srs/z+rBkq/GQ
 gxwOn+uEh7qL+IFogwGxKj9yL2Aak3mbyhGJIamBkVlfT8Pio9ar6TWccNei1X2kxPfEnXH2CG2
 R1lBw1l5Q=
X-Received: by 2002:a05:600c:630d:b0:495:5dcc:52b4 with SMTP id
 5b1f17b1804b1-496b56bbe6fmr121439075e9.3.1785166103817; 
 Mon, 27 Jul 2026 08:28:23 -0700 (PDT)
Received: from fra-x8664.lan ([151.16.232.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b816ef8sm214838735e9.1.2026.07.27.08.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:28:23 -0700 (PDT)
From: Francesco Magazzu <postadelmaga@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 0/2] drm/nouveau/clk: fix RAM error handling and pstate desync
 in nvkm_pstate_prog
Date: Mon, 27 Jul 2026 17:28:19 +0200
Message-ID: <20260727152821.128432-1-postadelmaga@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

Follow-up to "[PATCH v2 0/4] drm/nouveau: fix list cursor use after loop
in the clk pstate paths" (20260712123616.1180830-1-postadelmaga@gmail.com).
Sashiko AI review flagged three pre-existing issues while reviewing patch
2/4 of that series; the third (clk->func->prog()'s error being clobbered
by nvkm_volt_set_id() in nvkm_cstate_prog()) is already fixed by patch 4/4
of that series. These two patches address the other two:

  1. nvkm_pstate_prog() drops the RAM reclock error and falls through to
     core clock programming anyway.
  2. nvkm_pstate_prog() commits clk->pstate to the new state before the
     hardware transition has actually succeeded.

Francesco Magazzu (2):
  drm/nouveau/clk: don't ignore RAM clock programming errors in
    nvkm_pstate_prog
  drm/nouveau/clk: only update clk->pstate after hardware programming
    succeeds

 nvkm/subdev/clk/base.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.55.0

