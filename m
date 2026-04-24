Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC84FED3F0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB5310F649;
	Fri, 24 Apr 2026 17:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XiAHcg/N";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A08E10F649
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 17:04:09 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id ABD1D1A96;
 Fri, 24 Apr 2026 19:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1777050147;
 bh=H5tHFyISA/0brrNnyaE2kzW6wQFAU93vXx+COSGJ2Qw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XiAHcg/NYff3donuXTxSvj6CvLhyxI2BBomH4dXRaejocQyrdW7dv7FtdpgHaZF2n
 nET9x2w9HxMtb50x46PRDFf8rgWRFM+gEK8h7iTqsLD/ZXzE3fKbHbemOoeXal04c1
 sLLz4bAF2drrLzX/PlU3F2Yc8iDiFqYHpilDPpRE=
Message-ID: <cb19eafe-6c25-4a2a-bd31-9fb280837623@ideasonboard.com>
Date: Fri, 24 Apr 2026 20:04:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] arm64: dts: ti: beagley-ai: Enable HDMI display and
 audio
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Louis Chauvet
 <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andrew Davis <afd@ti.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-15-f628543dfd14@ideasonboard.com>
 <CAOCHtYjJgqomKreDxLUiVbUtpeh36f0bL-jA6P-6rsoJrweshQ@mail.gmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <CAOCHtYjJgqomKreDxLUiVbUtpeh36f0bL-jA6P-6rsoJrweshQ@mail.gmail.com>
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

Hi,

On 24/04/2026 19:16, Robert Nelson wrote:
> On Mon, Apr 20, 2026 at 8:04 AM Tomi Valkeinen
> <tomi.valkeinen@ideasonboard.com> wrote:
>>
>> From: Andrew Davis <afd@ti.com>
>>
>> Enable HDMI support for BeagleY-AI platform. The display controller used is
>> TIDSS and the HDMI bridge used is IT66122.
>>
>> Based on DT by: Robert Nelson <robertcnelson@gmail.com>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>> [tomi.valkeinen: cosmetic fixes]
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> Tested-by: Robert Nelson <robertcnelson@gmail.com>
> 
> Thank you for getting the display back end working on j722s family!
What displays did you test? I don't have OLDI panel...

  Tomi

