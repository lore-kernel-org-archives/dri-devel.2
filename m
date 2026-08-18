Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D9EC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B40E10EA43;
	Tue, 18 Aug 2026 08:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hLAYyBdz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBC210E29C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787042275; x=1818578275;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=G6sf36lxpjs+UKAI9HoAQBgocUntJgL3ULkaxxLNTpY=;
 b=hLAYyBdzql+lpE+az6Dd3mzl4CKuQyXTL5jRAqnGpyhmLvGdhLxlGRym
 MXBZCwLefCurXx1R43leXNLS1c38mojMV6JNLXGTn95qX4cz1qAgjLfF+
 ZtsXyWsPaB1i5WwM9UvBzgGwBiLikTFH/mrdn2AqCIahPGt+76mENUyuP
 BF6qYvjor7GyoPZYGbnYbV8SESuOl8SkMdavqrMvOwHYCTtug/ADgi2Hd
 PTFuqDqC7NFcaQOhhYZ7Oh8Xg5FNnIE2U+EmkxqkJwwXFi09+ezqZ632o
 fjjXiiRUJYlWVxhc6K4/zaZet2LAUcxhdLd2gRwT93d8g/RCe42fG83sI w==;
X-CSE-ConnectionGUID: W3mGMr1YQ3Goe6nJ3cu4KA==
X-CSE-MsgGUID: DvaGK/PGTfuEb2v9SJ/vbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98195445"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="98195445"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:37:55 -0700
X-CSE-ConnectionGUID: iB9MBv7oQICw7Sjos0KUeA==
X-CSE-MsgGUID: G2b5iq79Sziakvn9sXovbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="289974521"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:37:52 -0700
Date: Tue, 18 Aug 2026 11:37:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Piparo <holofermes@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] drm/ssd130x: Constify ssd130x_write_data()
 'values' parameter
Message-ID: <aoQZ3u_RoLHviJo2@ashevche-desk.local>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-4-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818080626.30430-4-amit.barzilai22@gmail.com>
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

On Tue, Aug 18, 2026 at 11:06:23AM +0300, Amit Barzilai wrote:
> At no point does ssd130x_write_data() change the bytes it receives via
> the 'values' parameter. Constify the parameter so const-qualified
> buffers pass through without casting away const.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


