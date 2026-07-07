Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25EEC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028CA10ECE2;
	Tue,  7 Jul 2026 13:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HCfkxPK/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35CDD10ECCA;
 Tue,  7 Jul 2026 13:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783429250; x=1814965250;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=uJ/15sSLEddnwXrw2pLnwQ0IxlEn7Wg8w7D+lx2nZvs=;
 b=HCfkxPK/dE4aZdcwhJXDuP8T9vUFUHtya8nusCu0BjaOJCpN9NgT4vAi
 KBIrphNCI7pXEJJcvC6HZ9BPrl3RAPXswEUDF3OouNQpwm7hANxQAMbi0
 d/60tujDDjp3Zvhhrr5TJw6jZqBia8CLbgXnPCG2Aalo2zO0F8S7kfxVY
 flZTpWoYaiGqeAkKsopAAiorIr49WhlP7CwyGKARbb8I6DN/5jYsSOd8N
 LnAIZIA8g2BRWdrTHI/ORcQEl/VurQ1gXCNrlDq26iLfGZ4amn+GybhQC
 aiTFyc6ujH0Avm0/aSehkwhaMEK2KxIa4rjnZPMqwvYMVv5BgMk/8ES1g Q==;
X-CSE-ConnectionGUID: oSG86aZxTKmp+opk0gl3uw==
X-CSE-MsgGUID: rizzNf+hS5aXck3OrmPTyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84264300"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84264300"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 06:00:49 -0700
X-CSE-ConnectionGUID: jDywhpQ9St6f+1uM0T/NIg==
X-CSE-MsgGUID: 1xKxb15/Q4uDE9Oc5cgOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="284097910"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.223])
 ([10.245.244.223])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2026 06:00:44 -0700
Message-ID: <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
Date: Tue, 7 Jul 2026 15:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, dri-devel@lists.freedesktop.org
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
Content-Language: en-US
In-Reply-To: <6d8806b8-fc71-4699-82c4-7189a0ea2284@intel.com>
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

Hey,

On 7/7/26 10:03, Borah, Chaitanya Kumar wrote:
> 
> 
> On 7/3/2026 1:02 PM, Robert Mader wrote:
>> The client cap is currently advertised unconditionally, even for drivers
>> that do not support plane color pipelines. If clients supporting the later,
> 
> s/later/latter
> 
>> like Wayland compositors or tools like drm_info, enable the client cap on
>> such drivers they will be left without both color pipeline and the legacy
>> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
>> conversion support.
>>
>> Prevent that by only marking the cap supported if there are actually planes
>> with color pipelines.
>>
>> Note: while the color pipeline replacement for the legacy properties is
>> still under review (1), we can assume that it will work as a drop-in
>> replacement.
> 
> This change will but a driver can also choose to export colorops like programmable CTM_3x4 to achieve the same.
> 
> We should also perhaps document this somewhere that if a driver supports LEGACY properties, it is imperative to implement some version of it with the color pipeline line property.

Would this be doable inside drm core? Implement the color pipeline properties, get the fixed pipeline for free?

But thanks for all feedback, as I was about to push this patch, I noticed it still uses -EOPNOTSUPP, can it be changed to -EINVAL?

~Maarten
