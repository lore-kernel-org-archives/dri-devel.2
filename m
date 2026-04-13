Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35DDF34C79
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3548B10E26C;
	Mon, 13 Apr 2026 17:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bcxjb6eS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DE910E086;
 Mon, 13 Apr 2026 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W/+9VIBULAh5qU5eIreJOL4QIZ+ishGKTEeGrEIkCGY=; b=bcxjb6eScrJfqCyN1ytGnPCw6v
 IHLetkQP7h/i0I4fWSD+julPF1hjiZ8B6c1Ouw8/AIaudJz0HmW1xRiOrxVRc0CqOwEuFDq9QL9jz
 uJ0Kw7Cz/+A0O1v8jQmAsBEdctvH9Zv8wCEm4tDey5Ukq+bXLz52EHlkrLhkzDUDHQc77ZZ9PP2Ag
 hO51opgoz2DjTOg2hu7/g8ug53Ei3kfu7qHaNxudkLbptxVeTKf/DPp5LrzJe9SOfHq/u2HRC+RHf
 V4cryxqobFsaN9KC/rVyGxtZgP5R2q3jLvEvK60mYW5KqW1Ls0+QmXBB6/ILa2m0+nDZW1xJM54u7
 VBqVVoxA==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wCLRm-00FX0k-Uw; Mon, 13 Apr 2026 19:51:43 +0200
Message-ID: <be7debbf-727e-4017-906a-36ee81fd844e@igalia.com>
Date: Mon, 13 Apr 2026 14:51:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] drm/amd/display: more drm_edid to AMD display
 driver (partial)
To: Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, airlied@gmail.com, alexander.deucher@amd.com,
 alex.hung@amd.com, andrzej.hajda@intel.com, christian.koenig@amd.com,
 harry.wentland@amd.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 Laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mario.limonciello@amd.com, mripard@kernel.org, neil.armstrong@linaro.org,
 rfoss@kernel.org, simona@ffwll.ch, siqueira@igalia.com, tzimmermann@suse.de
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Michel Daenzer <michel.daenzer@mailbox.org>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260225121903.236115-1-mwen@igalia.com>
 <3856874.aCxCBeP46V@timur-hyperion>
 <3d928ea8-dee9-40cc-9fcc-af063b67138a@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <3d928ea8-dee9-40cc-9fcc-af063b67138a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 31/03/2026 12:45, Leo Li wrote:
>
> On 2026-02-27 03:52, Timur Kristóf wrote:
>> On Wednesday, February 25, 2026 1:04:29 PM Central European Standard Time
>> Melissa Wen wrote:
>>> Hi,
>>>
>>> This is a reduced version of `drm/amd/display: more drm_edid to AMD
>>> display driver` [1] sent a few months ago only with the less invasive
>>> changes, i.e., those changes that don't affect DC. This partial focus on
>>> using more drm_edid helpers instead of raw EDID helpers. Most patches
>>> here are already reviewed by someone and I think they can be merged
>>> without major concerns. They can also prevent new initiatives of keeping
>>> parsing raw EDID as driver specific code, which can make harder for us
>>> to remove `drm_edid_raw()`. They should focus on moving raw EDID
>>> handling to the DRM common code instead.
>>>
>>> Regarding code changes from previous version, here I added some r-b tags
>>> (from Mario and Timur), fixed commit message syntax (Mario) and
>>> centralized error handling (Timur). I'll follow up the changes in DC to
>>> accept the Linux/DRM opaque object in a separate series since those look
>>> more sensitive.
>>>
>>> [1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igalia.com/
>>>
>>> BR,
>>>
>>> Melissa
>>>
>> Nice work, Melissa.
>>
>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>> For this series.
> Thanks for your patience Melissa, series is also
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>
> We'll include it in this week's testing.

Hi Leo,

In the end, was this series applied to AMD's branch or do I need to 
rebase it?

Melissa

>
> - Leo
>>

