Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B986FFB5E87
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2887A10E3F5;
	Mon, 16 Mar 2026 22:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kUyfVj3M";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yAHm48Q+";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86EBD10E3F5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:55:29 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fZVmb6P3Xz9v00;
 Mon, 16 Mar 2026 23:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773701727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zQl7cPK8o82oDVPmKR3a3SOGUatFxVTSQfvqTycius=;
 b=kUyfVj3MwJuurhQGTygc63hJneZ/+dZ3F+/vliKECECbfXiFxZwHiqmaIZaT7/25/dgtSx
 sCzQlLh0HCx8OLBazpQEELJq8tXLfbLilClX+Rs0ntpsloxFMTXU/Jgpiem7niOikvJrGK
 NvzblDGsBLzlCCImr9e5zWC30LDHdHo1EsJtObpBM0wimktj8nVbMpNOnRxtC7BMaX3x/C
 Sce5WsM4w/Y7bSSSvoaHKLvgMQEyJ5vjImBghTsiB5yQaX13KwdfZ0O9jV08iCvbiLMqGp
 Pp1xcUGSvfKm149GXMS88gSHq2UxFIYiCQcG+K6YnDvwh3dkXwZMkbTZG+cdqg==
Message-ID: <75be8726-ad91-445d-b407-f438e76ff5cc@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773701726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zQl7cPK8o82oDVPmKR3a3SOGUatFxVTSQfvqTycius=;
 b=yAHm48Q+MxcfzuNaW06La5X6krCdtnXve+KfvSpkfqQInxCLQJg5PgOyCHiNJQJfgpDlGd
 yYI9NRMg6Y6ntf1BUcgWrsA78C46+o5TOmckDrjfBVUYOCXI2euKdqR6WjHAfmb+Dw63kL
 GzhdruqwxH8n0kTQWOycyjiqTy7WzFeMe5OM20dYoNDjB8zWdae5sseYMckTZM0s3J+GaY
 uqopbap1ztTgdK5/XrMNOsTIsxc4bcgJBOme0+hYoXk1z5VjYWsZX8Ey8SilY4Vcu7q1uc
 dehFR3ImiWBNbNhiFUGpMG+Rb0HrPzsQ3knzCB7bMEGRbOmeZnvU/zsM8wUR3g==
Date: Mon, 16 Mar 2026 23:55:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/bridge: waveshare-dsi: Fix signedness bug
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Ethan Tidmore <ethantidmore06@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, kernel test robot <lkp@intel.com>
References: <20260307033245.71666-1-ethantidmore06@gmail.com>
 <DGY7EL00XS8C.L5V6X9997G67@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DGY7EL00XS8C.L5V6X9997G67@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6115f17c11067e0c3db
X-MBO-RS-META: p14fb1wrm3uuum8qfyghrb7dnu7dj1ku
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

On 3/9/26 12:10 PM, Luca Ceresoli wrote:
> On Sat Mar 7, 2026 at 4:32 AM CET, Ethan Tidmore wrote:
>> The function drm_of_get_data_lanes_count_ep() returns negative error
>> codes and dsi->lanes is an unsigned integer, so the check (dsi->lanes <
>> 0) is always impossible.
>>
>> Make the return value of drm_of_get_data_lanes_count_ep() be assigned to
>> ret, check for error, and then assign dsi->lanes to ret.
>>
>> Detected by Smatch:
>> drivers/gpu/drm/bridge/waveshare-dsi.c:70 ws_bridge_attach_dsi() warn:
>> unsigned 'dsi->lanes' is never less than zero.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202603060341.hNj0pl9L-lkp@intel.com/
>> Fixes: fca11428425e9 ("drm/bridge: waveshare-dsi: Add support for 1..4 DSI data lanes")
>> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

(it seems FDO patchwork did not pick this up)
