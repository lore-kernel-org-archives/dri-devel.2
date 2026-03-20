Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4D410987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C9910EBEB;
	Fri, 20 Mar 2026 16:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rpttDwie";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB7F10EBE8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:43:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A837A4E4274C;
 Fri, 20 Mar 2026 16:43:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7F3A9600E0;
 Fri, 20 Mar 2026 16:43:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 07F8E10450CB2; Fri, 20 Mar 2026 17:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=a5CCYphBWllAlHFRBkfUjQHnqcWJbsIGLPVS6ckaC4w=;
 b=rpttDwie/Wz7XC0fGbQ3GtSVnegrACDIjqUZP7udIpK7qTH6ZbJ2gX4Ux68i907mjut0tX
 wsRJbG/tz3EGRaJo/uWQOj6lwamHt61AC6aFNcdBqK22Qw+KHnxQ9dsnnBxgma7aoL/ZWM
 c7jvI5L+zqoPEnIiXurx5dfYxTZwnt63DSLjIypTWWevfn61EKZjAsrSlbdTaLQPQFmDxz
 /kZH09flna1FfDSZLApDIoAnARfz6s6OrykyptC/xporw8f4kIzGEBV7cokdlmKjXhiCRG
 bhUyPN3uyTXcB7L2xrf4c7awpeq9dzK0jM959UM+Kwai11V8O8wXg3qpuTZ6uA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 54/65] drm-dyndbg: add DRM_CLASSMAP_USE to mgag200
 driver
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-55-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-55-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491470.6181.16798810287600388030.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=351;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=zA8op3FvDuU1uTc04pMmpQ2fuNrzmFOK2fDSUT79VPo=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjaOF/MX3Y005Bqs0gLP6UY9lzG3TKBC8S+O
 rNqFFSagpiJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOJOJRAA1FiWd7Kr6Nt+K5qPYeUTUKj0z0tLW42
 JAF7MGJmwUP1R041x2E8+v9pQkwrPcfZ8M49FYayx/f56/lCTxZl45pmH4zvGWkMqjBeusAZh5s
 UZRLJrzF+SjF7kftk6m53jJKLvUfodvHNWMaZFh1Cnx2htR0SxE54c+14586rIYFLzPGKnujlCE
 u+6dbEQdkXzQ/HIMDahW2a7+CmqNEUCebJtNC4QbRgV4fSktl1FCiszzc3lhdADVLwzAsL9Syii
 v/YpFJchYapsEsdKvXpW2W88zElB2KJEbN1KlQv9yjR1ogqNxKYxHufffTyYyyPYHHo3I4Rsj8L
 U2jajeLfNvGWeV0/nolKPAJe6LgG0dw93T03rxVOP7D7yLAowqLw4u3RLghEsdI5fWUyl2yVf1P
 6+ImzVZ4kMlZwYzFqbLiUIBaRLY8pMloFTZ/SdnUnAVis6Urb06MXeZWFc/gQUVEzuVglohhwlu
 W75hXUJ/7mHJYKdLVobMjqi5zU7CeZxYVv4V39vy943ONE41HcMqYaeM5nN95wjK2An2Yxg6mJB
 6amZQMg4Z7TWKvPEdcRbZ61899kwxDtoPrbclUFlhlTHdllViBNTJwL8Iw5Nt9R/PN1fQhh+Rsh
 PffGvZ/TvtC4CrLu2Hk283wxwoQkrvHNsF7isqClYKjHta/2UUl4=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:20:19 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The mgag200 driver has a number of DRM_UT_* debugs, make them
> controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
> that the module uses them.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
