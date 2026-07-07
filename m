Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA83BC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24E1010ECF1;
	Tue,  7 Jul 2026 13:16:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="ASeBTo/0";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E3C10ECEB;
 Tue,  7 Jul 2026 13:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783430152; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cpB50S59VRu/EKC48+ikzc9YvMgOjb8U5Ft9BR+34AcvftHQpubdQBUO8Kp4Tnii0393/df63cZZWxlNSwXV4v0ADaursX12DTXLdDvztPK3+WDFhKLayAGs93KKU7mTe+BhEHRKybK8GyB/oCR0BQ3XtAoMXHQDJooynakP84I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783430152;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AjiMAH+aUOZ1T5Y6Winl/yzirQDCF30FfDqJLLs3nI0=; 
 b=XoWvc7PgKPbRe4euzkb03O8L74Ui6RFjRRTnMIVj5k8XLyU5cC08klbz52cMlKejV/iRE57KxNzWliZ8uZU+4BYdLqxOiD3QiDORLVPkWlLFGsMY+mHa9xAFOh3OOZJIcPr67eK/rLI4OR2Juo29HJNFJAPBerrU9I+YVUEUak8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783430152; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=AjiMAH+aUOZ1T5Y6Winl/yzirQDCF30FfDqJLLs3nI0=;
 b=ASeBTo/0jYpDQViBrlxcZh+DVqaQYOejqc0HosMJJCUeUhh3KnToXBT9njL+QcZS
 2EviRqwfOu3LymyGLKAQA/8h/xP46I0WIfn73TyYz9z4eTcF8Em/cStE2RdpKaAQ7+I
 sibf1iY/kf4kvEOvgoO763I/JthTOnYTbiTppsmc=
Received: by mx.zohomail.com with SMTPS id 1783430149837990.5307558137384;
 Tue, 7 Jul 2026 06:15:49 -0700 (PDT)
Message-ID: <d3e954dd-381f-480b-8f48-698d8aead017@collabora.com>
Date: Tue, 7 Jul 2026 15:15:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
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

Hi,

On 07.07.26 15:01, Maarten Lankhorst wrote:
> Hey,
>
> On 7/7/26 10:03, Borah, Chaitanya Kumar wrote:
>>
>> On 7/3/2026 1:02 PM, Robert Mader wrote:
>>> The client cap is currently advertised unconditionally, even for drivers
>>> that do not support plane color pipelines. If clients supporting the later,
>> s/later/latter
>>
>>> like Wayland compositors or tools like drm_info, enable the client cap on
>>> such drivers they will be left without both color pipeline and the legacy
>>> properties COLOR_ENCODING and COLOR_RANGE, effectively breaking YUV->RGB
>>> conversion support.
>>>
>>> Prevent that by only marking the cap supported if there are actually planes
>>> with color pipelines.
>>>
>>> Note: while the color pipeline replacement for the legacy properties is
>>> still under review (1), we can assume that it will work as a drop-in
>>> replacement.
>> This change will but a driver can also choose to export colorops like programmable CTM_3x4 to achieve the same.
>>
>> We should also perhaps document this somewhere that if a driver supports LEGACY properties, it is imperative to implement some version of it with the color pipeline line property.
> Would this be doable inside drm core? Implement the color pipeline properties, get the fixed pipeline for free?
>
> But thanks for all feedback, as I was about to push this patch, I noticed it still uses -EOPNOTSUPP, can it be changed to -EINVAL?

For existing users it shouldn't make a difference. drm_info and Weston 
just check for "drmSetClientCap() == 0" - and old kernels without the 
cap will also return -EINVAL AFAICS.

I personally find -EOPNOTSUPP more appropriate and more in line with 
other return values in that function - but no strong opinion, thus feel 
free to change while applying (or I can resend the patch accordingly if 
you prefer).

Robert

>
> ~Maarten

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

