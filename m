Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3F3C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 939D210ED36;
	Tue, 22 Sep 2026 14:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="npM6Y7+S";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65AA510ED37;
 Tue, 22 Sep 2026 14:17:03 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hq2Gg20pSzKp2B;
 Tue, 22 Sep 2026 16:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1790086619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVOufLgA9WAz0la1Oh+jjfdwzqg4zKoAiYSmro+Ag1c=;
 b=npM6Y7+Sre4CKi4VOvtHxwNWJrWhitpu0gGV2rutv1bBwQ270oIGis6/TFWikcglaMMpuL
 3r0i5PCJuI44zCT2ARMWTOVm2Fkq6XS2ihCCfcMdOUqyDO62hBg9t+laG9+m+awwkLNLVu
 4MqLwXspQUJqCFCeu/9zyi34pAUKcZvhtOuY7BXS1IDJIEPYxIyCNdGGMSdh7AOn3dlOnk
 zB/ae5hSrkBYMXS98HQ6qOSpfEF4w2kAchZ4iWfUTqA43N5WdaEBXsFOxR4aoBGnqsdZun
 M31+j0hm3GZ7Cjujmd4m0S/FLhHHtPhAjODsAUEc6f2fP0wPFJiHyFUK4l/qsA==
Message-ID: <737a7039-9b77-416f-a331-698a9cd980a2@mailbox.org>
Date: Tue, 22 Sep 2026 16:16:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH libdrm 2/2] tests/crtclist: add utility to inspect CRTC
 usage
To: "Murthy, Arun R" <arun.r.murthy@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "G M, Adarsh" <adarsh.g.m@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260921130747.2557722-1-arun.r.murthy@intel.com>
 <20260921130747.2557722-3-arun.r.murthy@intel.com>
 <IA0PR11MB7307D575C550CFF4AB2866BCBA842@IA0PR11MB7307.namprd11.prod.outlook.com>
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <IA0PR11MB7307D575C550CFF4AB2866BCBA842@IA0PR11MB7307.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qxq4w5b5wxq4cgj3i4hfdrigxxtipxbp
X-MBO-RS-ID: 242a110dd16996b28fa
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

On 9/21/26 16:07, Murthy, Arun R wrote:
>> From: Murthy, Arun R <arun.r.murthy@intel.com>
>>
>> Add a small diagnostic utility built on the new drmModeGetCrtcList() API. It
>> prints the total number of CRTCs, how many are free vs in use, and a per-CRTC
>> line with state, scanout framebuffer and active mode.
>>
>> Built like the other tests/ utilities (drmdevice, modeprint); it is a human-facing
>> tool and is intentionally not registered as a meson test, since correctness is
>> covered by the drmmode_crtc_list_ult suite.
>>
> ULT is removed from this patch, as this utility itself should suffice.
> This paragraph will be removed in the next version.

Note that we use gitlab MRs for libdrm: https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
