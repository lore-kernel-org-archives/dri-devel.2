Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5C9CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 645AC113B41;
	Tue,  2 Jun 2026 21:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VPXyvy+e";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3209F113B40;
 Tue,  2 Jun 2026 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780437500; x=1811973500;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=MfkKPtXQcB8aUW3HP/zdBEUmEP6RpNmrG8kxLpJOJ2o=;
 b=VPXyvy+ekPz9+LjTiD8Wod93P9zfGghZZ9uUFqLbepXVaI2Mrmxpq3eX
 y+F1wGfLodgC0hNHQzDv1MktyECGXhU6o0GZY1hTdcTDXmt2WOxBK+gL/
 /s1L5LJ/c71wNG8v6GEW8VbQKdxcHKDh8qXx1w2MpoDQ7udUjEQchLxCh
 gL8WtALaAZMNAuMj5p8zixodyFOCmLbW4knnKPqVS185YfEx/m4SzvZjy
 PYNsjfdukE8yVua7V8+SdJE23ZhWSlZeDrCroh84ZnYTl//7cYa4YuwbJ
 EIjU9SEHOeI1ljqPOJKjqgfl8Y+P/VoLi7C4lYuzpCmbGv70xc5VHDgoH w==;
X-CSE-ConnectionGUID: fUbyu5dzRt6AOmw1XOCfwg==
X-CSE-MsgGUID: opy6VB8qSOe1UzZbddZ9KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91547644"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="91547644"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 14:58:19 -0700
X-CSE-ConnectionGUID: vIF6VZFiQcy0HsyxwYX7oA==
X-CSE-MsgGUID: Ll/EKqWaSNeDih+M8w0nBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="248318077"
Received: from dev-417.igk.intel.com ([10.91.214.181])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 14:58:16 -0700
Date: Tue, 2 Jun 2026 23:58:14 +0200 (CEST)
From: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
cc: =?ISO-8859-2?Q?Micha=B3_Grzelak?= <michal.grzelak@intel.com>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/2] drm/managed: fix drmm_add_action() kernel-doc
In-Reply-To: <e645a8cf-45a2-423c-81c5-cdb9f6c57faf@intel.com>
Message-ID: <423f5568-0cc6-8e28-8886-9178d78847c8@intel.com>
References: <20260522135520.1862848-1-michal.grzelak@intel.com>
 <20260522135520.1862848-3-michal.grzelak@intel.com>
 <e645a8cf-45a2-423c-81c5-cdb9f6c57faf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-18171511-1780437498=:1544314"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-18171511-1780437498=:1544314
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 26 May 2026, Borah, Chaitanya Kumar wrote:
> On 5/22/2026 7:25 PM, Michał Grzelak wrote:
>> Kernel-doc of drmm_add_action() references @releases which is not
>> on argument list. Swap '@' between 'releases' and 'action' words to fix
>> the documentation.
>> 
>
> LGTM
> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>

Thank you Chaitanya for the review. Do you think this series can be
merged via drm-misc-next branch from drm-misc [1]? Asking because I
don't have commiter right to any of drm-* repositories.

BR,
Michał

[1] https://drm.pages.freedesktop.org/maintainer-tools/repositories/drm-misc.html

>> Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
>> ---
>>   include/drm/drm_managed.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
>> index 72bfac002c06..72d0d68be226 100644
>> --- a/include/drm/drm_managed.h
>> +++ b/include/drm/drm_managed.h
>> @@ -18,7 +18,7 @@ typedef void (*drmres_release_t)(struct drm_device *dev, 
>> void *res);
>>    * @action: function which should be called when @dev is released
>>    * @data: opaque pointer, passed to @action
>>    *
>> - * This function adds the @release action with optional parameter @data to 
>> the
>> + * This function adds the release @action with optional parameter @data to 
>> the
>>    * list of cleanup actions for @dev. The cleanup actions will be run in 
>> reverse
>>    * order in the final drm_dev_put() call for @dev.
>>    */
>
>
--8323329-18171511-1780437498=:1544314--
