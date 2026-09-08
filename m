Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB7C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA3210E145;
	Tue,  8 Sep 2026 16:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FFx8GxvX";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A2210E145
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 16:48:09 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hfVHV4Hg8zMlBX;
 Tue, 08 Sep 2026 18:48:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788886086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBNavf/W3lZrxPMwGNFSc+f7vCLC4CALQ5e8BPseE7s=;
 b=FFx8GxvXl/s/MWiZUYz39+Xv0nvzYvMIADDnZ0BbhtEJUNB8PlbqfXlAwJFJtXM/iIBQf3
 mkUmuzeTVJYbwWhglslgN4xo8fepNP0yVgHswx+GEGqFlYy4iahDbsCS+87ckjbPqRwVZk
 s2xTrNU1mJbYMobZMeHvVAJZ0FbMIx/BgkRKTtcCL9coTIlmFZt4FMjTUDk3geMl1NhlFL
 jrf19jxCvQhH0FnymCi1DZYEI2B608RpUCpa5mBRGyUwh73wRwy+d0QUreGR2FRKLQPY+g
 eoXcLmSiNSSua5x1ZyZ+T1GJnzXMLKlSwabXdMKIpWFCshrRZ5HQn1lb9aEP7g==
Message-ID: <aa37076f-6963-45e2-910c-e45f4e08bebb@mailbox.org>
Date: Tue, 8 Sep 2026 18:48:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] drm/panel: ilitek-ili9882t: Add support for Ilitek
 ILI79600A-based panels
To: dri-devel@lists.freedesktop.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
 <20260820185506.84448-4-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260820185506.84448-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hkf7ukp56y8zazyspe65q1jobg1mdcct
X-MBO-RS-ID: b9e5883bb32405da422
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

On 8/20/26 8:54 PM, Marek Vasut wrote:
> The Ilitek ILI79600A display controller is similar to the ILI9882T and can
> be supported within the existing `panel-ilitek-ili9882t.c` driver.
> 
> This patch extends the ILI9882T driver to handle ILI79600A-based panels,
> such as the 10" Raspberry Pi Touch Display 2. The ILI79600A uses a similar
> command sequence and initialization flow, with minor differences in power
> supply configuration and timing.
Should I still change anything with this patchset ?

Thank you for your help !
