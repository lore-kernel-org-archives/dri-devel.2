Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A31C5DF74
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A2510E2E3;
	Sun, 16 Aug 2026 14:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBMZKeSb";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AF310E094
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 19:06:14 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc891373e0so20177465ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786734374; x=1787339174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=My7jF+YOkrbrcPXGk6Gqyp469SMTbOnsjBIhyRnuamA=;
 b=kBMZKeSbHU6Yo462/5f471CH3FEeLuTXdbXmgkDBlAKFTS84ZpJVfvd3cMs95tWLcg
 NBfK86qXAAwB1nhNu+g3kd2EIrcDlRTQH6tO9lFsr7uDdNE9VreAUC5hhYjtShBPBoQE
 0Kbix+vfX4leGvkjJBI4gVbDUKYWCqaZhkK+1NCdv3reUe5xUySlvvk3aZduvvVBx7Hm
 1XwmIBOH6rvBg7MG9arsr5YswEMAe5YXJUSVSIE6J6pZR1yV1Cx1NUY4sayVeq8luASo
 5yzaaZTQFiCRZBgkdrts/yWSOqlIOaYI49GRwYfm+m/8Dn0ucbEaDvJMHp/FeGRTf3cb
 C4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786734374; x=1787339174;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=My7jF+YOkrbrcPXGk6Gqyp469SMTbOnsjBIhyRnuamA=;
 b=S6S8ohUQj8Uyz+HwnNwliAuTtbYww4nKHw+Ev+Vc/ckizsIPzCFbk29H7Mx1SJVLu4
 rs9QGru40+S/6yXtQVwobA4vc2UcSQ1zFR6/ogvJae5iphkxO+W43ILrQ75u7Y9Yiwbw
 mHDHvsQNGReEaUvMo44OmcCIbLnar3HqkJDlM9TB6qO8qh+xsjkBQFW1VCLQEbmqVK8m
 4jUYEJCMdPd8FkMbjBTiLQD8KjRkg9jr3yULmm6sviLYcNi+n8dnDqm4zsytvrc8Tscn
 D6XjlnuukUdCkyuECiJzdx5TQjIYiRk0osYiAkCXE2kPRbhrfofjes70RBqQAD/Vjdf0
 M65Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RriuKBTtF7H/JIn6HeIgVc4BO1n7XCg/YJ+83hfmcP1PxI68SNIE5oW7Gl7hCr3jAnC+ShyO7ieCyw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMem5WMKQULmiIbB7AFZxiSUW/oMkZrKo6bNKesw+rfDXgfilY
 HkMbHmoxLPywfuIKHTbAbB+AB8Hk7vYOX4B75jEh+8sUCaSx+6WjNG2skGrmcKfps6Y=
X-Gm-Gg: AR+sD131QYgFz4uBq49P8TEp/wzDzQd74pBFdTIKjNCR92wIeLtgQmm61FA+LcOWAx5
 /WC/NYZBDFNxEhRGwvC8KVJEwH3q5qVjywzFz+ork046GG5fmlskOoDfS8m9zTN19h3xJtNfj5C
 08P/+ZfkOCDywqwhyBUbhFqa5Floy0j/6PlW4/BA0qrEnbdJhLJ/9I9OT1qsZlkGnTz4kpnyfSJ
 WO6FZW5m72wFnXbKbIL6lix4Da6nOvyNTD5jpm7ToHYpnKNjT320LNuQ2Ft9HUazBIbgVOtAYpN
 0GAe9w76iiAt2pVnyuI9yCt7G0rAwr4AHVDoCIDcDMvIP3ujxB1w1eY7kmR7m23DCGDEQ1Lofru
 thwHaI1iuh9hF68ZvhPKEbgII0+1I+UaGFgiw+yyLzHsSN9nMa9eFxShzEKaM9esrbqY1t1UAWr
 d8+pONNVnlgFnd8UfaxZ87y9bInPA7cLEtm+5UIHZ9OqdcpR2fExFnhDGDeHrWgiFRk2dcB8kxz
 itHyp74AjbvcMGavSE0JMb2BjVKZZdOKI2emSjYYQk/n89Dt5vuCQKUY4zNcjIIboCUY1jcKN16
 buZUmy2iTIigdg==
X-Received: by 2002:a17:903:1965:b0:2c0:e5ee:f55e with SMTP id
 d9443c01a7336-2d3b0db9f3cmr93241755ad.7.1786734373823; 
 Fri, 14 Aug 2026 12:06:13 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea8fe3cdsm7109215eec.28.2026.08.14.12.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 12:06:13 -0700 (PDT)
From: manushprajwal <manushprajwal555@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Manush Prajwal <manushprajwal555@gmail.com>
Subject: Re: [PATCH] drm: logicvc: fix device_node refcount leak in
 logicvc_layers_init()
Date: Sat, 15 Aug 2026 00:35:57 +0530
Message-ID: <20260814190557.987-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

From: Manush Prajwal <manushprajwal555@gmail.com>

Thanks for the review. I traced this through and the UAF is real,
though it's independent of this patch, as noted:

- logicvc_layer_init() embeds drm_plane in a devm_kzalloc()'d struct
  and registers it with the unmanaged drm_universal_plane_init(), so
  the plane stays linked into drm_dev->mode_config.plane_list.
- On a later layer's init failure, logicvc_layers_init()'s error path
  calls logicvc_layer_fini() on every already-succeeded layer, which
  does list_del() + devm_kfree() immediately, but never calls
  drm_plane_cleanup() first, so the freed layer's plane is still
  linked in mode_config.plane_list.
- drmm_mode_config_init() (drivers/gpu/drm/logicvc/logicvc_drm.c)
  registers drm_mode_config_cleanup() as a drmm action tied to
  drm_dev's own refcount, which is only dropped via
  devm_drm_dev_alloc()'s devres release on the parent device, i.e.
  later than the explicit devm_kfree() above, not before it.
- So drm_mode_config_cleanup() later walks plane_list and dereferences
  the already-freed layer/plane.

The same devm_kzalloc() plus unmanaged-DRM-object pattern exists in
logicvc_crtc_init() and logicvc_interface_init(), so this looks
driver-wide rather than layer-specific.

That's a separate, pre-existing bug in the error-unwind path and out
of scope for this one-line of_node_put() fix. A real fix would need
either drm_plane_cleanup()/drm_encoder_cleanup()/drm_connector_cleanup()
calls added to the _fini() helpers before devm_kfree(), or switching
these to drmm-managed allocations. Happy to send that as a follow-up
patch if there's interest.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
