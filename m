Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A54C44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFFB10ED8D;
	Tue,  7 Jul 2026 14:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KdFQjeIX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FA410E4D1;
 Tue,  7 Jul 2026 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783433842; x=1814969842;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=n6IDX0ZcCgLBKVR2hEqdAQZ+aHjY/cRF0MzfnOL8oQc=;
 b=KdFQjeIX/fkPw0DjjSusRds90MWkJw/wT0B1NjNG8uOF9jnVPGzsbvTE
 2FH4whIfFEi3KFl5SINv618iJUjBSQl21VQmuYkLODZmJzfHTuDRgK4Q0
 lsr3E1vSeTvc0Wd+5ZW6UJqEAJ0Bys5KLw714XnQkLnV+Ur/UwxPizqob
 CXZrb2ASbEuZNF5fgqtMBs5KIvX3bcz8qeVwtEePi5f76dCYalljswtZP
 hHGRt0V1SzqxjkpCjDwnhkJBp0i2yIluT+IBdY3CwF1jO1ofuLSuenTjC
 H+cyEw3M758loUxN8oyLMFW3202KJ67EhHd56SfgxyIFGEYuTxXUKVfol w==;
X-CSE-ConnectionGUID: OJcX1zQwQ0K94WepV/hgew==
X-CSE-MsgGUID: OhWFRznQS6OidqA2kB9Lfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="109623897"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="109623897"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 07:17:21 -0700
X-CSE-ConnectionGUID: azXCJv3QRBqATUv6ZUoP7g==
X-CSE-MsgGUID: 86IffxY4TpGK38ceQPgUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="250653344"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.223])
 ([10.245.244.223])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 07:17:17 -0700
Message-ID: <d0aaa4c0-280c-4796-b8fd-d5908ff7b279@linux.intel.com>
Date: Tue, 7 Jul 2026 16:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: Robert Mader <robert.mader@collabora.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Daniel Stone
 <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260703073230.19982-1-robert.mader@collabora.com>
 <6d8806b8-fc71-4699-82c4-7189a0ea2284@intel.com>
 <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
 <d3e954dd-381f-480b-8f48-698d8aead017@collabora.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <d3e954dd-381f-480b-8f48-698d8aead017@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

Hello Robert,

On 7/7/26 15:15, Robert Mader wrote:
> Hi,
> 
> On 07.07.26 15:01, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 7/7/26 10:03, Borah, Chaitanya Kumar wrote:
>>>
>>> On 7/3/2026 1:02 PM, Robert Mader wrote:
>>>> The client cap is currently advertised unconditionally, even for drivers
>>>> that do not support plane color pipelines. If clients supporting the later,
>>> s/later/latter
>>>
>>>> like Wayland compositors or tools like drm_info, enable the client cap on
>>>> such drivers they will be left without both color pipeline and the legacy
>>>> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
>>>> conversion support.
>>>>
>>>> Prevent that by only marking the cap supported if there are actually planes
>>>> with color pipelines.
>>>>
>>>> Note: while the color pipeline replacement for the legacy properties is
>>>> still under review (1), we can assume that it will work as a drop-in
>>>> replacement.
>>> This change will but a driver can also choose to export colorops like programmable CTM_3x4 to achieve the same.
>>>
>>> We should also perhaps document this somewhere that if a driver supports LEGACY properties, it is imperative to implement some version of it with the color pipeline line property.
>> Would this be doable inside drm core? Implement the color pipeline properties, get the fixed pipeline for free?
>>
>> But thanks for all feedback, as I was about to push this patch, I noticed it still uses -EOPNOTSUPP, can it be changed to -EINVAL?
> 
> For existing users it shouldn't make a difference. drm_info and Weston just check for "drmSetClientCap() == 0" - and old kernels without the cap will also return -EINVAL AFAICS.
> 
> I personally find -EOPNOTSUPP more appropriate and more in line with other return values in that function - but no strong opinion, thus feel free to change while applying (or I can resend the patch accordingly if you prefer).

Yeah no worries, I looked at the code and it seems -EOPNOTSUPP is used a lot in getcap/setcap. In particular when driver support is missing
for features, I'll leave it as is and push it now.

Kind regards,
~Maarten
