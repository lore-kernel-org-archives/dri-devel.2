Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0172C88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4A610E1E4;
	Mon, 14 Sep 2026 17:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="H7/bhH0t";
	dkim-atps=neutral
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Mon, 14 Sep 2026 17:22:36 UTC
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1BE10E1E4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789405646; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Edlam33l1X0WI1OrB7u2Oi2y4BDkKlma8QjA02JvSoaDxpCa92P/CCtUkM16iKiJx9M7DYtg86KhuipKWOJQvzDTNeyeodYwJhhFXDRbUhUWpbd9TFoh4LjLMzVIsU+H36ZMvSktV3SfeKTEBeAqOFeMeK25RGsuUeQW986dtkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789405646;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+angtaWnDipQewgGz9mUegs+98WHwzGZawVa6NY7uGc=; 
 b=LPNxssC28lKjfWdU8WDWwBoYFepkrqhrMfFW6eWiD6kKWjmgHtgd2y6Vjg684Y1IVpBsZm/f1chPLwaOy3Cdp/0/0uTGBPStOAsED0ZPugdJZ0Hg9BlmCmHPdariz5scbgT4HLcoCUGDcfdiOD+Ah13Tr/pg2Lg3vQ+nyUB85Zs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
 dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789405646; 
 s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=+angtaWnDipQewgGz9mUegs+98WHwzGZawVa6NY7uGc=;
 b=H7/bhH0tH3/76qPygUPmL4xEqjOXzbIP20K2eJgFNDrskKak1+9ZMBsWZQOHjc1e
 hVrFKHf6f7ksMGiPzhmSf2DbgcQj+Qq4TEx7qteiSFn/FLKpd90IAS9twFhPRPJP5XR
 rFjBmWErxwCGnP1kCJCvGDfNJ8By2okwkPx7U8RY=
Received: by mx.zohomail.com with SMTPS id 1789405645288547.3965894530555;
 Mon, 14 Sep 2026 10:07:25 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Maud Spierings <maud_spierings@hotmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Frank Zhang <rmxpzlb@gmail.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi-qp: Return -EOPNOTSUPP in HDMI audio
 functions
Date: Mon, 14 Sep 2026 13:07:22 -0400
Message-ID: <5kr9i6ZJT46mREykuuT_Jw@collabora.com>
In-Reply-To: <20260907153000.hdmiqp-audio-2-royalnet026@gmail.com>
References: <20260519-fix-hdmi-audio-warnings-v1-1-9608966c993f@collabora.com>
 <20260907153000.hdmiqp-audio-2-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External
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

Hi Igor,

Thank you for testing !

On Monday, 7 September 2026 09:01:30 EDT Igor Paunovic wrote:
> Hi Detlev,
> 
[...]
> 
> One more reason I think this and Frank Zhang's patch [1] belong together:
> since the startup now fails, ASoC never marks the DAI as started, so for
> a PCM opened on a dead link the close never reaches hdmi_codec_shutdown()
> -> dw_hdmi_qp_audio_disable() -> clear_audio_infoframe(). That is the
> same class of bug as the SError we hit here on 02.09 (PCM closed after a
> failed prepare, register access with the PHY down -> SError, panic; full
> trace in [2]). I can't be certain this patch alone would have prevented
> that particular crash - a PCM that is already open when the output goes
> down still walks that path, which is what Frank's guard is for - so both
> still look needed to me. (I saw Cristian's question on v4 about
> open-coding the clear; either shape works for the crash I hit.)

Yes, Frank's patch is still needed, this is not fixing the SError, only giving 
asoc and userspace the right error code.

The situation you describe on opened PCM that goes down can indeed still 
happen (This patch may just decrease the probability of seeing an SError)

> [1] https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/
> [2]
> https://lore.kernel.org/all/20260907153000.hdmiqp-audio-1-royalnet026@gmail
> .com/

Detlev.


