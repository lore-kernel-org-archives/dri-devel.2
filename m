Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F02FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D276710E35E;
	Tue, 28 Apr 2026 15:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dgUbo7W7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBEF510E352;
 Tue, 28 Apr 2026 15:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777391783; x=1808927783;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yBCWaGEAZeKO/Fd4KAgTA5laTmjGSUePRDsNW05n9lA=;
 b=dgUbo7W7z+yUxzF9Fx6G9AskFbEN3NyFR07+MFARCBfK9bLc6qFE6LYt
 iwzTUm8/JXZes5hlz6+7TTQAqBf5N558nTO8IpEePNwV0xtAct+1uJ3gr
 y30lKWssHKgRtlivYIt5FwYgzTYfX//60r/ENnTOzcGNE5J+fTlL7HvtD
 y3BDcJWESvbjmQHY/pqy3/EN5xf2Ur9Bb839VjXB3LLz7tmjUGWWL8itZ
 ThFgqdruejys9e2IX/XFFTr+g7j2T52rP0jzA0vrj8tXoK6Nq+asXv6bA
 e6ND9RYNas5+mihALmpyXEPg6iy+1a8/usMNQrcRYE7e+13FKVMokd4jP A==;
X-CSE-ConnectionGUID: lfjdW3nERSG9A579xa4iDg==
X-CSE-MsgGUID: T0nFTFhFTCeZFO2rH8m4TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82171084"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="82171084"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 08:56:23 -0700
X-CSE-ConnectionGUID: ansQcULMTDGbd+eWCN9Bbg==
X-CSE-MsgGUID: fkcEUSxFTSmaWipH/JaYQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="257554633"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.213])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 08:56:18 -0700
Date: Tue, 28 Apr 2026 18:56:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kees Cook <kees@kernel.org>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Don't use UTS_RELEASE directly
Message-ID: <afDYn8Uy6PwvOVbH@ashevche-desk.local>
References: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428144553.1103785-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Tue, Apr 28, 2026 at 04:45:53PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
> uncommitted changes in the source tree or new commits). So when checking
> if a patch introduces changes to the resulting binary each usage of
> UTS_RELEASE is source of annoyance.
> 
> Instead of using UTS_RELEASE directly use init_utsname()->release which
> evaluates to the same string but with that a change of UTS_RELEASE
> doesn't affect msm_disp_snapshot_util.o or msm_gpu.o.

Would you like to submit similar changes against driver/auxdisplay?

-- 
With Best Regards,
Andy Shevchenko


