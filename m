Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D76C44533
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013A10E388;
	Tue, 21 Jul 2026 14:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="V+PSS6fI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363EE10E4D7;
 Tue, 21 Jul 2026 14:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784643357; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QuGCdl4Szlg2KXEmcHJjRrk/SIi4eWKvbTtkl929ldYHyqcXkMIFptezcql8xahJHk+POokMWZ2bkUbV1B2OT67PAhO7Qvt4H4Dr2YL5n7ZHMcx+QruwQCJ9jDCWtrxjeDkiOEIp/TLHrq++4VeHOgUz+jUYHD3bIhnI4F5nxcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784643357;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OUxzupHf4j6LntV2VOwhFmAlGB9SptJ5KFJPdSciEow=; 
 b=dGqu8NhMHGewwcnl3g+ThmgwPsKJYjIcUVsmDNUHnX1ub7cItuV8kdr7Dk3eTqEgd0Q47dY2BHxJzWrNBVbb3GDL8VH3R9ouF2jk2uk+DiGIWDV4wVC1c8ldkaWx3mpGhwsJYUOxLH3pSrSpU5Qs1+SJeAmA4Sa8MoAwW7GUb/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784643357; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Content-Type:Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Message-Id:Reply-To;
 bh=OUxzupHf4j6LntV2VOwhFmAlGB9SptJ5KFJPdSciEow=;
 b=V+PSS6fIyGouG0O9oQ9uM72oovX37UGAe+4jduj9YVl1AkkyDw8Q/jnbaP4ak8Hd
 oHBnJXTTcC4nrQiaid7QY5dnnvabwC8XGUKll3lhqI5Eiw5A9jcv+TIxZx63Y4fRB6Y
 HH1D3/5jWNDmzJbAvtk6wvKR/NovaZxKlzoX9eGE=
Received: by mx.zohomail.com with SMTPS id 1784643355399871.6881216922268;
 Tue, 21 Jul 2026 07:15:55 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------3aQ6Vfv9xo3S5dEIz0PeyWI4"
Message-ID: <9339663a-a0ed-4b7d-968e-1ced87db7c65@collabora.com>
Date: Tue, 21 Jul 2026 16:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm: Guard DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE
To: Harry Wentland <harry.wentland@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Daniel Stone <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>
References: <20260703073230.19982-1-robert.mader@collabora.com>
 <6d8806b8-fc71-4699-82c4-7189a0ea2284@intel.com>
 <bb5918f5-a6da-4908-9332-18e0df39c005@linux.intel.com>
 <7d58b289-eabe-4d68-9080-c7202b0f60a0@intel.com>
 <d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com>
 <361dfc91-94e8-4289-9b3e-5280803d9257@collabora.com>
 <a7887776-c26c-4f6d-a662-2d8ef005ff4c@linux.intel.com>
 <2fa23cb1-b4c9-459b-a0dc-31960313a243@amd.com>
 <b670d594-0582-4c91-8264-88d1de5de1d8@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <b670d594-0582-4c91-8264-88d1de5de1d8@amd.com>
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

This is a multi-part message in MIME format.
--------------3aQ6Vfv9xo3S5dEIz0PeyWI4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harry,

On 21.07.26 15:55, Harry Wentland wrote:
>>> ...
>> If I understand you correctly you suggest to map legacy COLOR_RANGE and COLOR_ENCODING to the new FIXED_MATRIX colorop in a generic way, instead of having drivers advertise them separately. Do I have that right?
>>
>> It's probably a good idea. It should be easy to make that change after merging the Fixed Matrix series with YUV support.
>>
> I sketched this out but both VKMS and amdgpu have HW generations
> or configs where no color pipeline is created. For that we still
> need the current way of COLOR_RANGE and COLOR_ENCODING handling.
> Because of this the code to create COLOR_RANGE and COLOR_ENCODING
> based on the color pipeline is not really simplifying things, but
> merely adding more code.
>
> At this point I am not convinced adding helpers to create COLOR_RANGE
> and COLOR_ENCODING based on the color pipeline is a net positive.
> Maybe in the future that equation changes.
>
> If anyone is interested I'm still happy to share the code. Just
> let me know.
>
> Harry

thanks for taking a look! I'd be very interested - mainly because in my 
understanding the "both VKMS and amdgpu have HW generations or configs 
where no color pipeline is created" should be fixable:

 1. For amdgpu every hardware generation supporting COLOR_RANGE and
    COLOR_ENCODING should be able to create a color pipeline *only*
    exposing the corresponding FIXED_MATRIX colorop, mapping to the
    exact same hardware block internally. I hope that shouldn't conflict
    too much with the current architecture?
 2. In case of VKMS the "enable_plane_pipeline" config could be adopted
    so that - if it is disabled - the plane pipeline is still
    initialized but only the FIXED_MATRIX colorop is added. Additionally
    we would need to disable DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE -
    possibly by a driver cap similar to v1 of this series - so that
    userspace can't enable/use the colop-op directly. As a result, VKMS
    with enable_plane_pipeline=0 should get the legacy properties via
    your helper, be able to drop explicit handling of them.

Does that make sense / do you think that could work?

Best regards,

Robert

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

--------------3aQ6Vfv9xo3S5dEIz0PeyWI4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Harry,</p>
    <div class="moz-cite-prefix">On 21.07.26 15:55, Harry Wentland
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b670d594-0582-4c91-8264-88d1de5de1d8@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">...</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
If I understand you correctly you suggest to map legacy COLOR_RANGE and COLOR_ENCODING to the new FIXED_MATRIX colorop in a generic way, instead of having drivers advertise them separately. Do I have that right?

It's probably a good idea. It should be easy to make that change after merging the Fixed Matrix series with YUV support.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I sketched this out but both VKMS and amdgpu have HW generations
or configs where no color pipeline is created. For that we still
need the current way of COLOR_RANGE and COLOR_ENCODING handling.
Because of this the code to create COLOR_RANGE and COLOR_ENCODING
based on the color pipeline is not really simplifying things, but
merely adding more code.

At this point I am not convinced adding helpers to create COLOR_RANGE
and COLOR_ENCODING based on the color pipeline is a net positive.
Maybe in the future that equation changes.

If anyone is interested I'm still happy to share the code. Just
let me know.

Harry</pre>
    </blockquote>
    <p>thanks for taking a look! I'd be very interested - mainly because
      in my understanding the "both VKMS and amdgpu have HW generations
      or configs where no color pipeline is created" should be fixable:</p>
    <ol>
      <li>For amdgpu every hardware generation supporting COLOR_RANGE
        and COLOR_ENCODING should be able to create a color pipeline
        *only* exposing the corresponding FIXED_MATRIX colorop, mapping
        to the exact same hardware block internally. I hope that
        shouldn't conflict too much with the current architecture?</li>
      <li>In case of VKMS the "enable_plane_pipeline" config could be
        adopted so that - if it is disabled - the plane pipeline is
        still initialized but only the FIXED_MATRIX colorop is added.
        Additionally we would need to disable
        DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE - possibly by a driver cap
        similar to v1 of this series - so that userspace can't
        enable/use the colop-op directly. As a result, VKMS with enable_plane_pipeline=0
        should get the legacy properties via your helper, be able to
        drop explicit handling of them.</li>
    </ol>
    <p>Does that make sense / do you think that could work?</p>
    <p>Best regards,</p>
    <p>Robert</p>
    <pre class="moz-signature" cols="72">-- 
Robert Mader
Consultant Software Developer 

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England &amp; Wales, no. 5513718</pre>
  </body>
</html>

--------------3aQ6Vfv9xo3S5dEIz0PeyWI4--
