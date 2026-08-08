Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAE7C5B567
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D733F10E643;
	Mon, 10 Aug 2026 06:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bnqVXVGg";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6D410E08D
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 22:30:11 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso506412a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786228211; x=1786833011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S+lUmXf0M1/AoHp7ybgP/EVeQH1GTrMXgFQpOQU1h9c=;
 b=bnqVXVGg+FusaZvKgn35571fxVSuhPC4Fg8yCX5zJmTjikCjWDnl8lis+ecrMb080A
 CTpdzkiI1F3yD3+O64jY9ykmojT/jfDwqQFFlGERS72e/91NLZHDUhG03ypkiub4ld56
 ft5SriaWWTTrnkzQykiUtA/Ilei2C9ML61n31aAyp46kHuGArbjJJgvvQ5ZvJeepaVOs
 IrJluGAfz1quYJ5TeHlO6ttGuTLnRlodfiY0gMM0lt9JnpleIXm49ejXKPJoxinboHzD
 7y+qenLgqv2LAq5MzCTU9rkLe6gaMpVfVRig+eO+oON5aKONQ8EBf86lkaE0MwCUGu/B
 CWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786228211; x=1786833011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+lUmXf0M1/AoHp7ybgP/EVeQH1GTrMXgFQpOQU1h9c=;
 b=k2hhDerV97p6RWnvBqQ6OVecgUIPKvMekN6GD8Df9N2uU5wA5S6jNMztZsUE1Wb0mV
 gKho1QyfucfODlvNUL4Ziy4LeORqnTGBgGmd4EXf/ZUl0wAjCyOuJuM6n7lwMZIbYK+4
 WCkk9IHqw7hzM3v5ENrg452RXQdxKIH4u/HVXAti2lqTJYnFvrR32t7CM8jrrRuwL45w
 MFm0FRm9bBOjTJ57zjjwgNwlnt4mQYLoS+T48UtGn0gdZBKH9Yf6wkX0I9r1BJfxvNjw
 XLy/fQA1+RHFTRlHqQ8IZv/QGkxmTTc4v9KV0ut3kvdAUsoDRN656x+5hzWoPvFwS2EW
 9ERg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPT6gdIYq81nI4IcZO7G7HwvxG1x+aOcJ4hvUDdIU+HaXiKT6tAwq7lr2I4n+7Lauljoy++IOwqms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmOY21BXudvTLbTjXYu5P/ylvBWpu8Y0AphwsObOMpVpzMTBqT
 Hy3EicZUcnHHhCQigAqhanJQ1Z9TqM8b2zwQWqXg84wTN8utJMrvIHL6
X-Gm-Gg: AR+sD11f+W6mPpPMBVZlCw0plbTnt/XJ4QRqrlOuM17RjPMEK20h4gDE8GIB0MhzAxr
 OGSxxx3nkFNN/cuS/f48CdzQ1kfQ6mjvDuY/Py2Ikck8cY+qmAHglUa8UWSwjDaX9bKuJKdpOhH
 Uziui2e5FFTSWhYNEWvXkSINEJB/l9Tsq52TRHF3SERk7Rd+gkhSaYK6aNJXBQGJAaqiEb/7Wdo
 C8WutAxTaQ5djYGjr6CGwQW0nFs7YucRjLPx0EhAGAYYKcK+/l0f99RTswKfcprqGHCviKJffF2
 fwunUAckSf+FWWVz+FRFDvUCHp9SbIFuDnv54F2e0c7fjq+L33SzjDttbaXi++Y7DJJwuxkrMLV
 ZG9tmuEmvjHaQ+1HuPG5hZ1tPegTnKF4EIuQXoFvTcCJFZz0O3ysTOfjpADpBN8tHVH4dhgg67w
 H9LcKMGFtU+48wexP4B9aurL+laWX9q3DUEwoPxivNUj+vE90g+vuxqYq8aRg8Urte0V67bP2xb
 Qsrg8VE5gQ=
X-Received: by 2002:a05:6a20:4309:b0:3c4:48da:8102 with SMTP id
 adf61e73a8af0-3cbce930129mr10090468637.29.1786228210822; 
 Sat, 08 Aug 2026 15:30:10 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315beb877b4sm27463910eec.19.2026.08.08.15.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 15:30:10 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v2 3/5] drm/amdgpu/aca: Fix inverted validation logic and
 handle cleanup
Date: Sat,  8 Aug 2026 22:27:40 +0000
Message-ID: <20260808222742.2859-4-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
References: <20260808222742.2859-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

aca_handle_is_valid() returned false if !list_empty(&handle->node)
evaluated to true. Because active registered handles have non-empty
nodes in the handle list, valid handles evaluated as invalid.
Consequently, amdgpu_aca_get_error_data() returned -EOPNOTSUPP
whenever aca_handle_is_valid() evaluated to true.

Fix the logic in aca_handle_is_valid() to verify that the handle is
non-NULL, contains a valid mask, and is currently registered in the
list. Negate the check in amdgpu_aca_get_error_data() so valid
handles are processed properly.

Additionally, update remove_aca_handle() to use list_del_init()
instead of list_del(). Standard list_del() leaves node pointers
poisoned, which causes !list_empty() in aca_handle_is_valid() to
evaluate to true for removed handles, leading to a potential
use-after-free during device teardown.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c76664af9902..b4c1438a56d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -586,10 +586,7 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 
 static bool aca_handle_is_valid(struct aca_handle *handle)
 {
-	if (!handle->mask || !list_empty(&handle->node))
-		return false;
-
-	return true;
+	return handle && handle->mask && !list_empty(&handle->node);
 }
 
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
@@ -599,7 +596,7 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *han
 	if (!handle || !err_data)
 		return -EINVAL;
 
-	if (aca_handle_is_valid(handle))
+	if (!aca_handle_is_valid(handle))
 		return -EOPNOTSUPP;
 
 	if ((type < 0) || (!(BIT(type) & handle->mask)))
@@ -717,7 +714,7 @@ static void remove_aca_handle(struct aca_handle *handle)
 	struct aca_handle_manager *mgr = handle->mgr;
 
 	aca_fini_error_cache(handle);
-	list_del(&handle->node);
+	list_del_init(&handle->node);
 	mgr->nr_handles--;
 }
 
-- 
2.54.0

