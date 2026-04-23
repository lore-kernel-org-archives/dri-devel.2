Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97882F589D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6B810E110;
	Thu, 23 Apr 2026 13:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CG67FE+p";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA2610E110
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:54:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE70D113EA6; Thu, 23 Apr 2026 15:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1776952449;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/5kDiLo3LeuH+95+MFuYEP3leWavFJoDo98aa/1EQeg=;
 b=CG67FE+puenCVO2j7ap+lOpCcy9SKGWMHNRrE95UZ89NDr0hZujkpFfNkRgBonuyWOsZyd
 6ZiKYkzzqC7lQS9Gb4AL/1e5wiX9LFYko7hCiP/EvODdSCA73n9S6qEQN5RVi43Tp5Mhi+
 u8h5l/8xE0vaM5Gq7h9i+GFGt45wz5rh3Stuhkd6OMedH+3bnS5gz86mR16tpFtMxfRwSC
 Df+aB6bZ3fTFUywGlM7ofTo4dto4QxFzIrOn3QjUEW8V1MF0aLCJRp28eaikYtY7uVPsUd
 5CaHOjcVjqQw7lReI1nWp5bZZvl6vCuQGo3JVHPAp18/jSl+tJ2oHaAutwvOyw==
Message-ID: <da6bdb78-7fe8-4f51-b9e6-444748ebc319@nabladev.com>
Date: Thu, 23 Apr 2026 15:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
 <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
 <3z3u5mbngmbzsch3mzs3twlh3aec6r7jokstzv3ghxyusrzt6b@jqvdnuiapx6e>
 <af71183d-70b8-4a41-8466-67123e7aab02@ideasonboard.com>
 <20260423-kickass-fat-boa-209f68@houat>
 <72c2cd94-0a8b-46c8-981b-4ad4a3222e59@ideasonboard.com>
 <CAO9ioeVX6OChRTgUrUdgrPF+3s2_7vme7m0yb85pjYtH1MFskw@mail.gmail.com>
 <ced05a92-06b4-4f6f-95b6-c3dc104c35f3@ideasonboard.com>
 <b24c428f-5752-4544-a8b4-77e91d7bc158@ideasonboard.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <b24c428f-5752-4544-a8b4-77e91d7bc158@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/23/26 3:16 PM, Tomi Valkeinen wrote:

Hello Tomi,

>>> In the past I used this panel compat instead of the
>>> panel-raspberrypi-touchscreen.c and it worked.
>>> IIRC Marek splitted the multi-function module into a regulator and the
>>> panel description.
>> Ok... Indeed https://pip.raspberrypi.com/categories/651-pcn lists 
>> PH800480T013 as one of the panels used. Although two variants are 
>> listed, and also a third panel model, possibly from another vendor.
>>
>> My module is v1.1, and I think it has the PH800480T013-IAC21 D/5624/ 
>> KIT- LC variant.
> A question to Marek: Where did you get the timings for PH800480T013? Did 
> you find a datasheet?
Search engine first link:

https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5337/PH800480T013-IHC09.pdf
