Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837DBD35179
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E180C10F0DD;
	Wed,  1 Apr 2026 12:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Nxt0+cq6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4425A10F0DD
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:18:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775045868; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H1BQJNJAvj1eSES0MQZ9UUdZ9ccmZ6tj/Du8W8KG3vLP/lWvBcL4euPlw85GSb+5i+xQ8xslLM9KS+EVKk1teZ/IKvLBAN1cBOED+pbE9zqIuvxsufHDsR7CWSSJbQIfZfBwQtErGUbWnY26mMzuHjnw9YZSf4+kpNGwZ6F6KQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775045868;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TJw/CfjLzcxAm0bwEh1CoqJ4c/lgYdwpRSlmJHfE8G4=; 
 b=aCYLIKfDg53kTBR63ZNm9bcs66Bs9tIfGPuc2WuTfQ++NI+85+IMw/Tdn6eJbB2ZOGQs1oI7C4Sqn5bYCjGFW9rTEhz8GZtVfazqEZtyADFoojtO7J9UMlsVdeOfqNCh4MvneL53l1+BIozvgLBFjGwiXBuqnq0oARhA4g6/GQQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775045868; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=TJw/CfjLzcxAm0bwEh1CoqJ4c/lgYdwpRSlmJHfE8G4=;
 b=Nxt0+cq69CXIGx4R6KzZm74ISy3GRmpkRhHKSPlyG63YpTkvoyQtN6/T43xU6YOs
 K7/9ljK17RZsFmiARbznv62BB8EEl75+48gDkU0NcArJJ6rr998NuKWIVCBa7R/r0MU
 kKD0Gf0kvrO/2i6O9NFn5lZM5qSUVixCk20J5Eb4=
Received: by mx.zohomail.com with SMTPS id 1775045867079379.81221661362736;
 Wed, 1 Apr 2026 05:17:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v6 0/2] Add "link bpc" DRM property
Date: Wed, 01 Apr 2026 14:17:41 +0200
Message-ID: <4517017.tdWV9SEqCh@workhorse>
In-Reply-To: <20260330-link-bpc-v6-0-ff124af93e48@collabora.com>
References: <20260330-link-bpc-v6-0-ff124af93e48@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Monday, 30 March 2026 10:33:08 Central European Summer Time Nicolas Frattaroli wrote:
> This series adds a new "link bpc" DRM property. It reflects the display
> link's actual achieved output bits per component, considering any
> degradation of the bit depth done by drivers for bandwidth or other
> reasons. The property's value is updated during an atomic commit, which
> is also when it fires an uevent if it changed to let userspace know.
> 
> There's a weston implementation at [1] which makes use of this new
> property. It is not representative of the entire use case of the
> property, but rather a proof-of-concept.
> 
> [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850
> 
> ---
> Changes in v6:
> - Drop amdgpu patch to unblock series.
> - Reword property documentation to make it more explicit as to what bits
>   this counts and why someone would want this.
> - Reword first patch message to do the same.
> - Link to v5: https://lore.kernel.org/r/20260319-link-bpc-v5-0-5306cd04a708@collabora.com
> 
> Changes in v5:
> - Split "drm/connector: hdmi: Add a 'link bpc' property" into two
>   patches; one adding the property, the other making use for it in the
>   HDMI helpers (Maxime)
> - Apply Maxime's Ack to the two split patches as per the review
> - Link to v4: https://lore.kernel.org/r/20260311-link-bpc-v4-0-51775e964720@collabora.com
> 
> Changes in v4:
> - Throw out the workqueue and delayed work item
> - Remove the drm_connector_update_link_bpc_state function
> - Reimplement it by updating the property and firing the uevent in
>   commit_tail
> - Check that the provided max_bpc value in attach_link_bpc_property is
>   within the expected range
> - Clamp the connector state's link_bpc value between 8 and max_bpc so
>   that no value outside the declared range is ever written to the drm
>   property
> - Update and reword doc strings
> - Add an amdgpu implementation
> - Link to v3: https://lore.kernel.org/r/20251022162843.1759-1-marius.vlad@collabora.com/T/
> 
> Changes in v3:
> - remove VRR mention from commit description (Ville)
> - add DRM_MODE_PROP_IMMUTABLE to flags (Ville)
> - provide helpers functions for drivers to use (can be used by other
>   types of connectors, not just HDMI)
> - send uevent informating userspace when 'link bpc' connector state
>   changed (Daniel @ https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850)
> - added missing doc entry
> - Link to v2: https://lore.kernel.org/r/20251006083043.3115-1-marius.vlad@collabora.com/T/
> 
> Changes in v2:
> - replace return with EBUSY if connector already exists (Dmitry)
> - add i-g-t test and an implementation for Weston (Dmitry)
> - re-wording patch description (Jani)
> - Link to v1: https://lore.kernel.org/r/20250801101750.1726-1-marius.vlad@collabora.com/T/
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> ---
> Nicolas Frattaroli (2):
>       drm/connector: Add a 'link bpc' property
>       drm/connector: hdmi: Add support for 'link bpc' property
> 
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  2 +
>  drivers/gpu/drm/drm_atomic_helper.c             |  9 +++
>  drivers/gpu/drm/drm_atomic_uapi.c               |  2 +
>  drivers/gpu/drm/drm_connector.c                 | 88 +++++++++++++++++++++++++
>  include/drm/drm_connector.h                     | 16 +++++
>  5 files changed, 117 insertions(+)
> ---
> base-commit: 3a48a999a2e3c3d1988d44370ed8f43ff54700b6
> change-id: 20260309-link-bpc-d0afc475ac49
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> 

There's a lot of unresolved discussion on v5 of the series going on at
the moment, so please don't merge v6 despite the acks, there will likely
be a v7.

Kind regards,
Nicolas Frattaroli


