Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAADFC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3018A10E060;
	Mon, 21 Sep 2026 18:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="CvmdGQZE";
	dkim-atps=neutral
X-Greylist: delayed 479 seconds by postgrey-1.36 at gabe;
 Mon, 21 Sep 2026 18:48:50 UTC
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E8E10E060
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:48:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D1EA91034B8; Mon, 21 Sep 2026 20:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1790016045;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1IYSOWDSdVHavPw5AagIbmQivLGnywmbta0NyEZGhlY=;
 b=CvmdGQZE6caIekfX+VDVlUD40Y5GvROg5DGKfHwS7TBY3BImNPFYKzza7e1TKqC4dD/vKK
 THgiqTiqT0Ri5qTYOVW5R389tgFAZEd2CFeWc3H+d3l+mccWIgsCzOoD4nmIAEmMdvhuQZ
 Czyj3A1NtzviXQA9VFjLjePVN6xQACIQ8YJJMjHP8nfeU9JOaQiooFdy+SkVU8ls4op29b
 v/PuV8XzpIWGdTCDc0Qbqk9T+ljPBzEfl+tLgBgQd6yBTwrwglyP2ktPmNjZItmUquh4V/
 Pqrt1zY+WuQlRjQ6QCMaQsBMr+pXlhzUkv55tN35mV+6m7+ZWBbHkdGyYjhnKw==
Message-ID: <c43103f6-348c-48b9-a831-ecb9379ce46f@nabladev.com>
Date: Mon, 21 Sep 2026 20:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
To: Liu Ying <victor.liu@nxp.com>, Piyush Patle <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, daniel.baluta@nxp.com,
 Frank.Li@nxp.com, shawnguo@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
 <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
 <aksVMhFr8YzedE1w@raspi>
 <CAMB+xkY2rut-sEUMyFnXqYCNmyseP4nAGj4BfreORTTM=SN8_g@mail.gmail.com>
 <akuEOT2FRa77L0Jn@raspi>
 <CAMB+xka8Fame7aFZSiWEtVcozSTXX8g9MKJu+cycU2vtiSDHmQ@mail.gmail.com>
 <akxjwULa-p6c6IvR@raspi>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <akxjwULa-p6c6IvR@raspi>
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

On 7/7/26 4:26 AM, Liu Ying wrote:

Hi,

> I need to point out that i.MX95 display controller also has 2 display engines
> and 1 pixel engine, which is something missing in your code.  This makes me
> think that you have no enough i.MX95 display controller documents.
> 
> Generally speaking, I'd say there is a lot to be improved before posting the
> formal patch series.  Gut feeling is that maybe it's a bit too difficult
> for you to get the drivers right.  As I said earlier, my original plan is to
> add i.MX8QXP prefetch engine support first with the posted patch series and
> then to add i.MX95 display controller support, but maybe I can try to add the
> latter first - just need to find a time slot.  However, adding prefetch engine
> support first would directly show a reason to people why two DRM drivers are
> warranted when adding i.MX95 display controller support.

I haven't seen any MX95 DPU patches posted (except for my work from last 
year), was there any progress since this discussion ?
