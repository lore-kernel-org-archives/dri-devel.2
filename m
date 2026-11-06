Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF979606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=gTL5a7z/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F82112FF8;
	Fri,  6 Nov 2026 20:26:06 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0825D112FF8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 20:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793996752; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iLuoB12MPAUZCn0lDQPOBrY1UeYyTF6NYas/6wfPdu+4SEW7W01+kAyz7R6dwZq3Spj2xxzQTTKyy64T2IKLSACKM6PH5wlVsxvHNqCZ8B+vitTOGfwCgwH5B5kAKnTI306/NnRM4j1yHp9imz6i7RdPGY1d3JzU4ePHFUGUUxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793996752;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cnYwR+x9gPGMRwQVukq4vu5rZwqZFuTK9bIZ00vuKqg=; 
 b=iCcxUe4vuOD2hHNNMgbBANS7Mpueurbe4SAGJL+b9psvBltnnrnL5Iqh8Ypnh3eGSwcNfVXqtOvEh9uJSHqK8oOflOVac/JllV48cjV3T9D4sOWHnMq0exsIaSWhw9NkVLcPtEWnjWGp9xYJvz0E5XgpKgwX5iKMEIbl6+Z3yGU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=leandro.ribeiro@collabora.com;
 dmarc=pass header.from=<leandro.ribeiro@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=gTL5a7z/CTVkhIylKco1cm7aRh4VXZzKhAHDW0HrAcxlwbgp00QkusQ8SzPj8Qp2whNbO++2z0hocny5TXAqbSsyqGEFD4rSDIUa/6CnkS2pV4NM32GwXfRjgDwM9dWMNnvSyc2gsuQYpcNg8qp3BGWOEipT8bQXfCwRP+vehH4=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=cnYwR+x9gPGMRwQVukq4vu5rZwqZFuTK9bIZ00vuKqg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793996752277586.3883449931958;
 Fri, 6 Nov 2026 12:25:52 -0800 (PST)
Message-ID: <9952c613-6344-47e2-8529-5a832eea6ab0@collabora.com>
Date: Fri, 6 Nov 2026 17:25:47 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] drm/vkms: improve color curve LUTs precision
To: Robert Mader <robert.mader@collabora.com>, louis.chauvet@bootlin.com
Cc: airlied@gmail.com, alex.hung@amd.com, daniel@fooishbar.org,
 hamohammed.sa@gmail.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
 <4082e72c-dba9-48cc-891e-1e6be5616fb4@collabora.com>
Content-Language: en-US
From: Leandro Ribeiro <leandro.ribeiro@collabora.com>
In-Reply-To: <4082e72c-dba9-48cc-891e-1e6be5616fb4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 6:15 AM, Robert Mader wrote:
> Thanks a lot for the series!
> 
> I'm using it as part of a branch [1] to test my/our Weston post-blend
> color-op pipeline implementation [2] - including additional commits
> using the new script to add gamma 2.2 and 2.4 [3] curves. The Weston
> tests compare the vkms output against the GL renderer for e.g. NV12
> bt709-limited-range bt1886/gamma2.4 content - successfully (i.e. the
> results match very closely).
> 
> I also went through the commits and didn't spot any more issues. Thus
> with the 32bit issues raised by the bot addressed the whole series is:
> 
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> 
> Tested-by: Robert Mader <robert.mader@collabora.com>

Hello,

Thank you! I've pushed v2 today, fixing the main issue caught by Sashiko
bot (see "vkms: properly compute gamma LUT size in vkms_atomic_check()").

Also added your Reviewed-by and Tested-by tags.

Thanks,
Leandro

> 
> Best regards,
> 
> Robert
> 
> ---
> 
> 1: https://gitlab.com/rmader/linux/-/commits/post-blend-2026-11-02
> 
> 2: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2157
> 
> 3: For SDR video, see https://gitlab.freedesktop.org/wayland/wayland-
> protocols/-/merge_requests/539
> 
> On 04.08.26 22:33, Leandro Ribeiro wrote:
>> Currently VKMS only supports uniform LUTs. Besides the userspace
>> provided LUTs, it also represents color curves with LUTs, as it can't
>> simply implement the continuous curve formulas (floating-point would be
>> required).
>>
>> This adds support to represent color curves with non-uniform LUTs,
>> improving the precision significantly. It also provides a script
>> that was used to create these LUTs.
>>
>> The optimized LUTs use more samples in regions where the interpolation
>> and quantization errors are higher (usually in regions with a steeper
>> slope). The LUT generator script compares different strategies and uses
>> greedy subdivision, which outperformed the other methods, to generate
>> the optimized LUTs for VKMS.
>>
>> Leandro Ribeiro (11):
>>    drm/vkms: rename VKMS_LUT_SIZE to VKMS_GAMMA_LUT_SIZE
>>    drm/vkms: allow color curve LUTs to have different sizes
>>    drm/vkms: remove TEST_LUT_SIZE
>>    drm/vkms: remove linear_eotf
>>    drm/vkms: improve the way in which we access LUT member
>>    drm/vkms: rename struct vkms_color_lut::base to y
>>    drm/vkms: rename get_lut_index() to get_uniform_lut_index()
>>    drm/vkms: add support to non-uniform LUT for internal color curves
>>    drm/vkms: test sRGB and inverse sRGB LUTs using more samples
>>    drm/vkms: add script to create optimized LUTs for color curves
>>    drm/vkms: replace uniform sRGB LUT and its inverse with optimal ones
>>
>>   .../gpu/drm/vkms/scripts/color-curve-lut.py   |  561 +++++++
>>   drivers/gpu/drm/vkms/tests/vkms_color_test.c  |   46 +-
>>   drivers/gpu/drm/vkms/vkms_composer.c          |  127 +-
>>   drivers/gpu/drm/vkms/vkms_composer.h          |    2 +-
>>   drivers/gpu/drm/vkms/vkms_crtc.c              |    4 +-
>>   drivers/gpu/drm/vkms/vkms_drv.c               |    2 +-
>>   drivers/gpu/drm/vkms/vkms_drv.h               |   13 +-
>>   drivers/gpu/drm/vkms/vkms_luts.c              | 1469 ++++++++---------
>>   drivers/gpu/drm/vkms/vkms_luts.h              |    3 -
>>   9 files changed, 1383 insertions(+), 844 deletions(-)
>>   create mode 100644 drivers/gpu/drm/vkms/scripts/color-curve-lut.py
>>

-- 
Leandro Ribeiro

