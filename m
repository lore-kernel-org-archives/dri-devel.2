Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEF106B53A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D99410E7E7;
	Wed, 25 Mar 2026 13:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L5DtdEUN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E77810E1E0;
 Wed, 25 Mar 2026 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774445518; x=1805981518;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AfbjMFvIEQIsKqipV64JeUiV3a4hNryaOeC6I7cYi70=;
 b=L5DtdEUNnaxyhx8uz/37g0t9jAJ73HFJVwUPflDPZhqGKMka1az5A8us
 hdMsSGs7zmIdT3cR7bg5uaGyY2zwRZAr0gd7SSdHrfmC8n6ZZeJcjcuPL
 ZFgDcq16tcfcUICCT4aHWAjkwwYDnCaQJOvyyG+YMlBfitBc7eIw2KKum
 vwoYNYyblye290UEZT1oT5fTVwVUhW4GfJ3BXGDFlTeZkztkfF8gXZTJR
 ankfJLHjk3VSzTzho9TUEWfoO2BnQU0yjswDSV7aYomonni3CvGwaJa6q
 nPovKOuG63bXjJFZT+uG0WPB4ovchR2p6bXTY992z2GO6yDNKzEC1Vozy Q==;
X-CSE-ConnectionGUID: 9mGaavPDTauwFnAq6Ytt1Q==
X-CSE-MsgGUID: EL5+yx7qRdqrX5+DRWMvMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86558687"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="86558687"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 06:31:57 -0700
X-CSE-ConnectionGUID: Ob0snIG0TcmV3mTY+a4Nww==
X-CSE-MsgGUID: b43bz8bhRTqaD0inBrd4Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="224937123"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 06:31:53 -0700
Date: Wed, 25 Mar 2026 14:31:49 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
 airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com,
 Jakub Kicinski <kuba@kernel.org>,
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 3/4] drm/drm_ras: Add DRM RAS netlink error event
 notification
Message-ID: <acPjxf5XTYuR7sbM@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-9-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311102913.3387468-9-riana.tauro@intel.com>
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

On Wed, Mar 11, 2026 at 03:59:17PM +0530, Riana Tauro wrote:
> Add support for asynchronous error notifications in drm_ras.

It's either drm_ras or DRM RAS, make it consistent in all patches
(both commit message and subject).

> Define a new `error-event` netlink event and a new multicast
> group `error-notify` in drm_ras spec. Each event contains
> a node-id and error-id to identify the type and source
> of error.
> 
> Add drm_ras_error_notify() to trigger this event from drivers.
> Userspace can receive this event by subscribing to the
> multicast group error-notify.
> 
> Example: Using ynl tool

Ditto. Either Usage or Example, make it consistent in all patches.

Also, please utilize the full 75 character space where possible.

> $ sudo ynl --family drm_ras --subscribe error-notify
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> ---
>  Documentation/gpu/drm-ras.rst            |  9 +++++
>  Documentation/netlink/specs/drm_ras.yaml | 14 +++++++
>  drivers/gpu/drm/drm_ras.c                | 48 ++++++++++++++++++++++++
>  drivers/gpu/drm/drm_ras_nl.c             |  6 +++
>  drivers/gpu/drm/drm_ras_nl.h             |  4 ++
>  include/drm/drm_ras.h                    |  2 +
>  include/uapi/drm/drm_ras.h               |  3 ++
>  7 files changed, 86 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 4636e68f5678..09b2918f67bd 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -54,6 +54,8 @@ User space tools can:
>    ``node-id`` and ``error-id`` as parameters.
>  * Clear specific error counters with the ``clear-error-counter`` command, using both
>    ``node-id`` and ``error-id`` as parameters.
> +* Listen to ``error-event`` notifications for error events by subscribing to the
> +  ``error-notify`` multicast group.
>  
>  YAML-based Interface
>  --------------------
> @@ -109,3 +111,10 @@ Example: Clear an error counter for a given node
>  
>      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>      None
> +
> +Example: Listen to error events
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --subscribe error-notify
> +    {'msg': {'error-id': 1, 'node-id': 1}, 'name': 'error-event'}

Can we also have error-name and node-name? I'd be pulling my hair off
if I need to remember all the ids.

On that note, I think it'll be good to have them as part of request
attributes as an alternative to ids (also for existing commands) but
that can done as a follow up.

Also, what if I have multiple devices with multiple nodes. Do they need
separate subscription?

Raag
