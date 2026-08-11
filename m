Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E83FC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B66910E2D0;
	Tue, 11 Aug 2026 09:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ipUxO/Kh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE2610E2D0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786441832; x=1817977832;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Dfmvdw/culho4GPh3SNbuEpAoO3xxlAwvTqR0vMoJ4Y=;
 b=ipUxO/KhaunjEf9dN76RcFCmizHmGgNm3tw9TyMTa+VpJ1mT647ZBnuw
 5jqSuhXoCUGgJrHKOPUBN4ek/Kc1hGZKQg0gAkV4MDW9/hRfbFmnZQ/V5
 nNnfTbqBH2ZATh0SRYQDqcep/jdmrU5CBxK21n/bkMc9OJAxBaqdnfTZ+
 zcChwYR3gedXUjcO+DtMUitLDGVh3Nqm6lHJBjiYCnExaf/KirO464Lcz
 Vdyn/QwM54OgjsPvNcUY8XGItNcxdUAknihqJJudDQRBniegjHIDm5o1c
 8KGrkrLjhgXE5Xb1wkGNNy5e7YPixrKJtb94R5x4WemO4KLKOU4m8NNsr Q==;
X-CSE-ConnectionGUID: 31vG0kuSR82as5CK5OS2ug==
X-CSE-MsgGUID: yOUUTlTlS2OQ290ujHvZGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86729134"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="86729134"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:50:32 -0700
X-CSE-ConnectionGUID: Ytr36kbnSq2ZFur0XiU7Vw==
X-CSE-MsgGUID: sKNYaCJqRWmyARl2TpS3EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="293234329"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.254])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 02:50:27 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Diederik de Haas <diederik@cknow-tech.com>, Albert Esteve
 <aesteve@redhat.com>, Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray
 <ian.ray@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/panel: remove .orig file committed by mistake
In-Reply-To: <20260810-drm-remove-drm_panel-c-orig-v1-1-90592f91974e@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260810-drm-remove-drm_panel-c-orig-v1-1-90592f91974e@bootlin.com>
Date: Tue, 11 Aug 2026 12:50:24 +0300
Message-ID: <673b05048bc6a2c8eaf75e2a0224706483ede95b@intel.com>
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

On Mon, 10 Aug 2026, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Commit ac3baea883da ("drm/panel: find_panel_by_fwnode() return a counted
> reference") inadvertently added a .orig file which should not be there.
>
> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> Link: https://lore.kernel.org/all/DK9KRSOWRHY0.H7SC0R3BIIUZ@cknow-tech.com/
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Beat you to it with commit 651b0bd0922b ("drm/panel: remove accidentally
committed .orig file").

BR,
Jani.


-- 
Jani Nikula, Intel
