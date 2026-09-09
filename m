Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7764AC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D4D10E55F;
	Wed,  9 Sep 2026 14:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WHysCADl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C6810E55F
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 14:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788962588; x=1820498588;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=cd4JeYv5F5dPa0SI4hhDwoObMvk28qrjEPebQcnU2gY=;
 b=WHysCADlSc+MtA5GPJ6qsDnyPpTdWtDQzb8yDnMiAJ8oQeBcpJetm7W4
 WEsYUt2jNGJo76VRC5FEqbHxMZyiIK0BQ2KY+aBH2F9NFxH2VYzj0FQKD
 YiCMX2r72P8wYELUmyxDsyXce53ZKeCkLBRF+Vn+Q4r0EpoLTdgaWj08P
 c2DH+/JWSWTBv3WDbwXvPQCR/95Lh6ifr7OGsK+ap8mCAdeunfqPeVAUx
 JjSZDVMpBi0+jL+MI5Whjbb20lkJwkuC9QGS9aNMwJKnKYK/P2BBsJvC+
 p+KIOlsekqygW7D4iv+X7fFAEiXH6cAR0QcfrlDxpG9p4ibEO2CS852ZI A==;
X-CSE-ConnectionGUID: FcbjuIVxQyWjYmF/c+sJrA==
X-CSE-MsgGUID: hXLt/mTPRXaw0Y3fSgX+lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="76948644"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="76948644"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 07:03:07 -0700
X-CSE-ConnectionGUID: ub7ontpfRMqfkJniY7VrCA==
X-CSE-MsgGUID: cyj9KUgvQYCCAelxJzajEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="265122705"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.20])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 07:03:01 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Jessica
 Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, Inki
 Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Albert Esteve <aesteve@redhat.com>,
 Anusha Srivatsa <asrivats@redhat.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Hui Pu <Hui.Pu@gehealthcare.com>, Ian
 Ray <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
In-Reply-To: <aqEqx0zBQgmUgwqL@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <678ddef7e56703d9adffff5c490d4857af515343@intel.com>
 <aqEqx0zBQgmUgwqL@houat>
Date: Wed, 09 Sep 2026 17:02:58 +0300
Message-ID: <3efb06a30baae6ba1bfcf2be449bf207a30f674d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, 09 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> I really wish i915 was at least *trying* to fit within the larger model
> basically everybody else uses. I understand that it's a large
> undertaking and regression prone and everything, but I'm also concerned
> about having the "we can't because of i915" or "supported by everybody
> else but i915" on a regular basis now.

Okay, let's hear it, please name a few things where i915 is alone in
doing something bonkers that amd, radeon, nouveau also don't do, and
what would be the changes that would bring i915 closer to everybody
else?


BR,
Jani.


-- 
Jani Nikula, Intel
