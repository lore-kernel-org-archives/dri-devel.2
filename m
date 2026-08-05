Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5ECC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AFD10EE3B;
	Wed,  5 Aug 2026 12:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="RtMSpAvt";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B116710EE3B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785934740; x=1786193940;
 bh=5CHT89h5pXRG3aFQ5eEOuJMYrdQuBFF+YsLM7b0jO5w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=RtMSpAvtzmWYSgSolkSkmqnZqVubGIPWD29P81Byd/3KAr7ehRouugD7LYK2nNhv4
 MrMiifoXXjL0ZKqiHWoJAN1a/OTQ/4kb5C2U78Mm64ZCqhxHjuZsdzGzxpCKBT7L7P
 XgZ5wyOulBWfdupmT4RHcpRNSZ1xGOS5vZD5uhZ+e9CH1KpJx5WAXnngjPzGyHKgFe
 HvMFIfVwSdhRl8A1QKbqYxi/HgdmyuU1jXzXMKGhipTreYDGgm98swWZqfM48fqOXT
 ffhoQ9WTPbvALa1KmUv+gKsKj9pjhYYolF/6OJqf1Zz1DqYLIFtleM0O856Is+WG7z
 w8jY32wkRAkjQ==
X-Pm-Submission-Id: 4hFVpn6LCMz2ScQM
From: Esben Haabendal <esben@geanix.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Andrzej Hajda" <andrzej.hajda@intel.com>,  "Neil Armstrong"
 <neil.armstrong@linaro.org>,  "Robert Foss" <rfoss@kernel.org>,  "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>,  "Jonas Karlman"
 <jonas@kwiboo.se>,  "Jernej Skrabec" <jernej.skrabec@gmail.com>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
In-Reply-To: <178591896150.480618.7817290661302611456.b4-review@b4> (Luca
 Ceresoli's message of "Wed, 05 Aug 2026 10:36:01 +0200")
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
 <20260803-nwl-dsi-fixes-v2-4-1809a0ac453f@geanix.com>
 <bld31n2JbR3Fbe-m_60UNkaxXoX8D-drWr5qv7vSWABhEsm_1wWMhe7yyQh19o0Y_-3fyHGHMb0-T2-DwVlwBw==@protonmail.internalid>
 <178591896150.480618.7817290661302611456.b4-review@b4>
Date: Wed, 05 Aug 2026 14:58:57 +0200
Message-ID: <87wlu4afla.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

"Luca Ceresoli" <luca.ceresoli@bootlin.com> writes:

> On Mon, 03 Aug 2026 16:56:22 +0200, Esben Haabendal <esben@geanix.com> wrote:
>> There does not seem to be any good reasons for ignoring the return value of
>> the nwl_dsi_mode_set() function.
>>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>
> Here too, if it's a fix it needs Fixes: + Cc: stable.

Added for v3.

/Esben
