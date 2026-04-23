Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D09F589DA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0C210F14B;
	Thu, 23 Apr 2026 14:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MnFDp/Go";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6B910F14B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:05:40 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9819227;
 Thu, 23 Apr 2026 16:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776953040;
 bh=wqniVq9yEq7QN1zP9YpKxgcUq4s7oP2llFTuHjHuy04=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MnFDp/GocbhxsUcToEMstatKOCP67wZpMIU3CSf2ZxhYNGDr7UVKluUnbOyKIACV6
 OGF4pmKbFOdMaKDo2o9cs0EP8bcghzwPCBJCw1ZVo574ntEdJB1L/r7XpFKhRjNqwo
 2IjxOOY2TR0Hk8vDHobycLW2DT32EfEjlQ2cOx6M=
Message-ID: <a5f67f4d-cfbf-4726-980b-0dbcb47255a9@ideasonboard.com>
Date: Thu, 23 Apr 2026 17:05:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7"
 panel
To: Marek Vasut <marex@nabladev.com>,
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
 <da6bdb78-7fe8-4f51-b9e6-444748ebc319@nabladev.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <da6bdb78-7fe8-4f51-b9e6-444748ebc319@nabladev.com>
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

On 23/04/2026 16:54, Marek Vasut wrote:
> On 4/23/26 3:16 PM, Tomi Valkeinen wrote:
> 
> Hello Tomi,
> 
>>>> In the past I used this panel compat instead of the
>>>> panel-raspberrypi-touchscreen.c and it worked.
>>>> IIRC Marek splitted the multi-function module into a regulator and the
>>>> panel description.
>>> Ok... Indeed https://pip.raspberrypi.com/categories/651-pcn lists 
>>> PH800480T013 as one of the panels used. Although two variants are 
>>> listed, and also a third panel model, possibly from another vendor.
>>>
>>> My module is v1.1, and I think it has the PH800480T013-IAC21 D/5624/ 
>>> KIT- LC variant.
>> A question to Marek: Where did you get the timings for PH800480T013? 
>> Did you find a datasheet?
> Search engine first link:
> 
> https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5337/ 
> PH800480T013-IHC09.pdf

Thanks. That's not exactly the same variant, though (IHC09 vs IAC21). 
Even so, that datasheet also lists the backporches as 46 and 23, which 
are not the same as in d69de69f2be105b2474c05a5ca4827aac3e80ad3.

But oddly the datasheet pic shows that the backporch times would include 
the sync time. Taken that way, the commit's hsw=2 and hbp=44 would 
match, but the vsw=2 and vbp=22 still wouldn't.

I'll test my HW with the PH800480T013 compatible at some point and see 
how it behaves.

  Tomi

