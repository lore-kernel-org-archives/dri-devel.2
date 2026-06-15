Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0B0CD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2E710E2EC;
	Mon, 15 Jun 2026 09:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AhmhtX4I";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D4010E2B7;
 Mon, 15 Jun 2026 09:06:32 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gf4443BVhz9tt1;
 Mon, 15 Jun 2026 11:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781514388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVEITHxOdrR3YJEFXN+E26Q1e+pfL+I4tukcWBuL11w=;
 b=AhmhtX4IHml6pvQwKWEqyT0cH8izlCD9NnEuLpSpCCmTc3mPQiJc+X29BLKk29YtMSj/7l
 IdEdBuuFVlNyeDJPzTpluhk+CEONRpAl6Fl/UHyIQ5F8jO/3dNTFlZsIrR7sIrfQsDPmnS
 sIYwTN8R1mSM29V5BatYCkEdlrluvf/fa/PWcJiss1QASLlb9MPVj0QF8vnnq3UJs7jh0f
 f1Xh8vWnpd/6hM89ldZdaar0vSRwly5OuEfIFhQL5SA0e5ewbg6jWAaPXBSOL5iY1zAgzk
 fxF9DP7n+Nw69208eLvZHK00lY/vQlQ8CmTXt1EkZIcAjLpoKEYVq697dAyopw==
Message-ID: <3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org>
Date: Mon, 15 Jun 2026 11:06:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh
 rate changes on eDP
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iu7sq1nnpeh5pb85s8bhwxx43wrrqnye
X-MBO-RS-ID: bb44ca48c4f250ccaff
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

On 6/12/26 16:41, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Tweak the eDP fixed mode selection algorithm to allow
> userspace to do refresh rate changes on VRR capable
> eDP panels without full modesets.
> 
> Ville Syrjälä (4):
>   drm/modes: Add DRM_MODE_MATCH_TIMINGS_VRR
>   drm/i915: Pass the full atomic state to .compute_config()
>   drm/i915/panel: Adjust intel_panel_compute_config() calling convention
>   drm/i915/panel: Attempt VRR based refresh rate change for
>     !allow_modeset

What's the motivation for this approach?

Per https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5091#note_2784749 , it comes as a bit of a surprise. The approach we've been discussing at display hackfests instead is to add properties for controlling the maximum & minimum refresh rates.

While the approach in this series could be considered an alternative for the maximum, AFAICT it doesn't allow enforcing a minimum refresh rate which differs from the maximum and default minimum.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
