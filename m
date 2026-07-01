Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629A4C43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDB810E3DC;
	Wed,  1 Jul 2026 16:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="XkiCTJN6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D7A10E1DD;
 Wed,  1 Jul 2026 16:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782922228; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D+DgbiLr5kexcx+lrub8/HrLRUgxgKUhBJDeeapRywpp7TFyGKClfXuuspUUN+mXBjxfFZ2Pcn6voS8py0L+fvBDY9KM6YVv8g6h6GZZpXA6mWo0viisyrIYF6HaQhLigmTYAxlSzrFh+xSLGg1rSUHK1xL6EkEliifobmA/UIg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782922228;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KDVZueUcLft5Z4nd96BM/LR5QgkNIeejRUglXYj5hQI=; 
 b=Cbza1F6zd4b8eNrJm6QQZnWbaXGROnXNwZE4X/KUxnMKjdmJ6T6TkOejYrBCzrWWvIlOUu54Ydz/4xgWeLqxSMF/yooELkyr78xPmfuwJvKgV7vO2CBt1ICyW7ytNIjzsUEwf2/uTyk4dRMnsPANa/i2aeG4VvTmkJUOR8lKGkk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782922228; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=KDVZueUcLft5Z4nd96BM/LR5QgkNIeejRUglXYj5hQI=;
 b=XkiCTJN6wZKvA/ALm8VS69i5BEgdDsDd6ybgh5VgMYpBWF2gc6f6h4hAo6gnff5E
 0XEvNcWLyFO1ZU1NHpR4NwtQ02jfo0K+29nSOp+Mge7+9gEDVyyHgOeStZfvdmhkxtM
 gjeL3fFmTfFQMeAebRZi22D3qFJ10DKK+8RXNZj8=
Received: by mx.zohomail.com with SMTPS id 1782922226555993.1991732003413;
 Wed, 1 Jul 2026 09:10:26 -0700 (PDT)
Message-ID: <52afa800-5b29-45d1-9418-19ae30122a30@collabora.com>
Date: Wed, 1 Jul 2026 18:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
 behind driver feature
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Daniel Stone
 <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <3bc9d27b-2886-48df-a897-7e73f14a88a2@linux.intel.com>
 <11792a51-aeeb-428f-a793-607ff09558f3@collabora.com>
 <853a147c-6565-4286-ba4f-60decd3b23e0@linux.intel.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <853a147c-6565-4286-ba4f-60decd3b23e0@linux.intel.com>
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

Hey Maarten,

On 01.07.26 16:26, Maarten Lankhorst wrote:
> Hey,
>
>
> On 7/1/26 15:32, Robert Mader wrote:
>> Hi Maarten,
>>
>> On 01.07.26 12:41, Maarten Lankhorst wrote:
>>> Hello,
>>>
>>> All you have to do is iterate over all planes at runtime until
>>> one is found that has the pipeline property attached, it's not
>>> a performance sensitive area and no locking is required for
>>> testing if plane->color_pipeline_property is NULL.
>> that's correct - I checked that before and while the amount of code changes necessary to support such a "check-planes-with-cap-enabled-and-reinitialize-without-cap-otherwise" is not big (AFAICS it should be possible with under 100 lines in Weston), it would need to be replicated in various Wayland compositors and lots of apps with native DRM backend (drm_info, Gstreamer KMS sink, MPV, Kodi etc.). The small change proposed here seems like a more elegant solution to me.
>>
>> In a previous chat Pekka and Simon seemed to agree, quoting: "< emersion> pq, you mean the cap is advertised regardless of driver support? that sounds like a bug".
> You misunderstand my comment, I meant this from the kernel side.

Ouch, you are right - and iterating over all planes in 
`drm_setclientcap()` with `drm_for_each_plane()` indeed looks like the 
much easier and cleaner solution. Will send out a v2 doing that and 
ditching the new cap again.

Thanks!

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

