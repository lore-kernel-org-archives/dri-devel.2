Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296BAC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 843A210EB5C;
	Tue, 30 Jun 2026 10:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q25uPx2C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA05310EB5C;
 Tue, 30 Jun 2026 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782815294; x=1814351294;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i5nO/jIZd0TtIDalodtoEW8qteZa4x1waL/+X1FSrDY=;
 b=Q25uPx2Cr+AbvPCKqg9tI94SR+ZSgVctJt2ejRdVVsFlUqHrX6u994UM
 ywsVvOyy4csmZJUdOkR1JkUKXnFYhwSSiuKJfjyxft/nbEb2vC529gdX2
 76OvcH270I3hAOTZ0wu9kOFtBZualEAojsB8T4lGJFdI/aG+IwABa8GJc
 VvHxlJqoCNIOGMo+goucnxqFtYGt85HBgjn0dyxzsNrYRH5K/asb8SqpG
 eSsxtS5k7BALzT1YomsjboCjjdip2Q/UEs/so6loVALgR3mVd4SQlL4TI
 BWa/PhCX/yY/ivGqMTDJTzyp5RwMDqQE2aFxqPHdv3AtXbCDA86//OzeM A==;
X-CSE-ConnectionGUID: rG0ApOhpTIWNAgqcXCdoHw==
X-CSE-MsgGUID: 2JiLs4T0SLW2ow9ot22QLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83395559"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="83395559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:28:14 -0700
X-CSE-ConnectionGUID: 9STfOcq+R8KH8gX4EHr2xA==
X-CSE-MsgGUID: gH7hYvirTSiLAzw3S9Ydhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="252873969"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:28:12 -0700
Date: Tue, 30 Jun 2026 12:28:08 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Riana Tauro <riana.tauro@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andi Shyti <andi.shyti@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/xe/i2c: Handler for SMBus Alerts
Message-ID: <akOaOD_sHI3exlXL@black.igk.intel.com>
References: <20260625125939.429078-1-heikki.krogerus@linux.intel.com>
 <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125939.429078-3-heikki.krogerus@linux.intel.com>
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

On Thu, Jun 25, 2026 at 02:59:38PM +0200, Heikki Krogerus wrote:
> Some devices that are attached to the I2C controller use the
> SMBus Alert signal for example to inform the host about
> thermal events, so registering the default SMBus Alert
> device for them. The alert device makes sure that the alert
> is processed and passed to the correct I2C client driver.

...

> +enum XE_I2C_CLIENT {
> +	XE_I2C_CLIENT_AMC,
> +	XE_I2C_CLIENT_ALERT,

Forgot to add, with this I think you can move XE_I2C_MAX_CLIENTS define
here.

Raag

> +};
