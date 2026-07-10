Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C36DC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 17:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E105C10E1F4;
	Fri, 10 Jul 2026 17:01:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Q754yrp4";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6590B10E1F4
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:01:36 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gxdQk1wVwzKvvm;
 Fri, 10 Jul 2026 19:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783702894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKzHnlIZLuU1Xzuk8UDxJlC4nU1oQy2BzPSlzIVSSK0=;
 b=Q754yrp4hHbS7WTz4vrIm0drqEWhrSKv+2okAvi4W7B07sDTUWmh+g78x/WBI6PHnlJzY8
 CFDLZBnGsMIKQA6wsbmdZ/+twzoA/+zYZMi/HqLfvLMzP1VUZuUEkVXbBrbzFmoLL8mXEZ
 KJab2YheSWuYrHnJsaMQ9v4eqSBUIEciQCIHrD/DD57minzO62xpx3pvH2PmY7XxNadl4t
 q9z21u3fDMy7hH03qMjkBrVbz/PnyKoZ0Jg+7RTBs6FoqIl/jFC0msj+Bh/9L6ddZn8bnS
 DUqngSlSxrbDhxOIWy3P7wNzZGsXNyGHR7GeTpyCeQt8wRMgkT+8xEwcAibCLA==
Message-ID: <fd3b9da8-6ccc-4730-b8ff-08cfcfa286a9@mailbox.org>
Date: Fri, 10 Jul 2026 19:01:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH RFC 0/8] drm: Add DRM_MODE_ATOMIC_RESET flag
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Jonas_=C3=85dahl?=
 <jadahl@redhat.com>, Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>, Xaver Hugl
 <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260708-drm-reset-state-flag-v1-0-c37dc985485d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f430b2d2da537883163
X-MBO-RS-META: 5m4tntjbid6zrwgj6ur5y1fq18rhoma1
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

On 7/8/26 18:08, Maxime Ripard wrote:
> 
> Userspace currently has no atomic way to bring a display pipeline back
> to a pristine state. A compositor that wants to start from a known
> baseline must explicitly set every property on every KMS object to its
> default value, which requires tracking which properties exist and what
> their defaults are. This is fragile and must be updated every time a
> new property is added to the kernel.
> 
> This series introduces a new DRM_MODE_ATOMIC_RESET flag for the
> atomic ioctl. When set, the kernel fills the commit with default
> states for all KMS objects before applying the properties supplied in
> the request. Properties not explicitly included remain at their
> defaults (CRTCs inactive, planes disabled, connectors unbound, and so
> on). This allows userspace to describe the desired end state
> declaratively, without having to care about the current state or the
> full set of properties.

Nice!


> Patch 8 wires it all up by adding DRM_MODE_ATOMIC_RESET to the atomic
> ioctl.

The new flag should be accompanied by a new DRM_CAP_* cap, so user space knows when the new flag is valid.


> This series is untested and relies on all drivers implementing the
> atomic_create_state hook, which is not yet the case. The conversion
> is actively in progress but not complete, so this will not work as-is
> today.

As discussed on IRC, the new cap could be made conditional on the atomic_create_state hook being available. That would allow this series to land before all in-tree drivers are converted. (As a bonus, it would also avoid issues with out-of-tree drivers which might not support the atomic_create_state hook)


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
