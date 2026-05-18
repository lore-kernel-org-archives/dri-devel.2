Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C0DCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5E810E906;
	Mon, 18 May 2026 15:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TCshC5Xz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DE110E8EB;
 Mon, 18 May 2026 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779119828; x=1810655828;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tJceJ9FnV01hKZMaSarvfzweTpBeidH2MR5dC0e6SoU=;
 b=TCshC5Xzjhk9CRNgKsP9Y4smgxzNl/YdpXfn2CpORrS/8nWjnTslFiya
 oO/2OF7T6/ViZLCYq9JjxhgUYcYI0Mmbc5wNuj230K0Fkyo3Cbtj+tWRp
 QjuUo/9X0SsEoznus/kfdWQ/0WoVpZdr5jbRoOOwTsoe74YOyf1hUy5Pa
 Uv0XceY3+YuyXYCAT8MAwTUyo2qY0Lxi5WMzFn/mwdRlhXBxotHS8lP48
 rbA/7Y/uWCGA9ATg6EV7Cw0labj7sAfBNw47Cx+KMRycGBSIAE7upVWpV
 IDOmWC5oWvmgonnDOgjQ4sGs4sq1wNQvES/WPVo7V6J07+vt8ILMEz9Na A==;
X-CSE-ConnectionGUID: HiFxHxDKRSKXod4tSk7jiA==
X-CSE-MsgGUID: Hcl5RfFAQ5Ss0JtHYDMETg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91081870"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="91081870"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:57:08 -0700
X-CSE-ConnectionGUID: r13HizglSzKlXCHvw+o7WA==
X-CSE-MsgGUID: +gO8quK2RXar1DEXgejadQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="238619698"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:57:06 -0700
Message-ID: <029f47a6-722d-4429-a885-9b413c3a0fbc@intel.com>
Date: Mon, 18 May 2026 16:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] gpu/buddy: Introduce __gpu_buddy_undo_splits()
 helper
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-4-francois.dugast@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260518141446.124508-4-francois.dugast@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18/05/2026 15:14, Francois Dugast wrote:
> The pattern of merging a block back with its buddy on error paths is
> duplicated across multiple locations. Extract it into a
> __gpu_buddy_undo_splits() helper to avoid repetition and prepare for
> future changes.
> 
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Suggested-by: Matthew Auld <matthew.auld@intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>
