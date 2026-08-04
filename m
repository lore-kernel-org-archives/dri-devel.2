Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E47C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AC510E67C;
	Tue,  4 Aug 2026 11:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="s8g+swmT";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A025610E67C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:08:40 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 14176741;
 Tue,  4 Aug 2026 13:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1785841649;
 bh=8maOdKXZZdlgEKtChtKM+Xq4lTV0NTWga9dYHBgtUko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=s8g+swmTuXKR7TDiw35+fJW3/UdDNRlAgP5KYwmQuWKS4EzejfT6fWDb2L7HO3LMr
 HZutwUuvD0eJBRCV5LLlPpD2AqLmxAO++xcwrdunDJe3hIVd0A+vDAwItn2QiR1VhX
 3CWZtslG0Vv87Q4DXywqhZq32nSrA6eNiTI4huAk=
Message-ID: <660d65ee-92af-4420-a2b7-6feda2dca11f@ideasonboard.com>
Date: Tue, 4 Aug 2026 14:08:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/omap: dsi: do not copy isr table
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
 <d8d897b2-9108-4286-9859-54edcc2a8259@ideasonboard.com>
 <20260804104908.46937116@kemnade.info>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260804104908.46937116@kemnade.info>
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

On 04/08/2026 11:49, Andreas Kemnade wrote:
> On Wed, 29 Jul 2026 11:23:21 +0300
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> 
>> Hi,
>>
>> On 02/07/2026 18:27, Andreas Kemnade wrote:
>>> To te able to unregister stuff from isrs, the corresponding table was
>>> copied.  Nobody seems to unregister stuff that way, so it does not help.
>>> But there are stack-allocated objects passed to these isrs giving chances
>>> of UAF of these objects if irqs are unregistered while they are handled,
>>> so better do not copy that table.
>>>
>>> Fixes: 4ae2ddddf44cd ("OMAP: DSS2: DSI: Add ISR support")
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>> If this gets backported, it should be re-checked that
>>> no isr unregisters itself in older kernel versions`.
>>> ---
>>> Changes in v2:
>>> - remove variable definition (Sashiko)
>>> - Link to v1: https://patch.msgid.link/20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info
>>
>> Looks good to me, applying to drm-misc-next.
>>
> It seems not to be on linux-next. somehow this did fall through the cracks?
It did. I applied it to my local dim branch, then went looking for other 
omapdrm patches (the dsi one), which took a while and... yes, forgot to 
push...

Pushed now to drm-misc-next.

  Tomi

