Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D680BF588DC
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413DB10E66C;
	Mon, 20 Apr 2026 14:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ij+/00HH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E07C10E66C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:15:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2592D40A7E;
 Mon, 20 Apr 2026 14:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7538EC2BCB6;
 Mon, 20 Apr 2026 14:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776694530;
 bh=UZz/y334XGeR52ybtu8Bh/e06bVGnVdZ5lU3egC/qCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ij+/00HHLQhajGcWMlHx3cvr5gnQ2NMSErKPwAmw2K6pknz/yR79u74U3L4sUIdzD
 8UT6tp1eBLuYaciXi5rGtF265tq2uma5Hfm+/irG9o9sT7Y45MnZWaU3lM6MD9sCps
 ey5G5DIX8cVDsWJPPm4J2+sz5Ow9jzpazO0SCcrbj2wN1KNm7yBJu1rQmv54wMONQF
 62r4aqIEYOp4x7Mn8Ym1Cog6DqE85goRZDHSaUh4SymHEd9V9I1AHkpjYpwkPm0xOV
 oGdJ1gVEDEdtTf5xHJ9klDROg3DzqB+Qzi0kab07MaLk+X7a+BUOForB8JbUmhVdhc
 0pnH3xQ/gbQ+Q==
Date: Mon, 20 Apr 2026 16:15:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: syyang@lontium.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com, 
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com
Subject: Re: [PATCH v3 1/2] dt-bindings: bridge: This patch adds new content
 to the lontium,lt9611.yaml binding file
Message-ID: <20260420-sophisticated-scorpion-from-camelot-b9f326@quoll>
References: <20260420061644.1251070-1-syyang@lontium.com>
 <20260420061644.1251070-2-syyang@lontium.com>
 <192f1948-bb9a-4831-a1cd-5ef500cfb413@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <192f1948-bb9a-4831-a1cd-5ef500cfb413@kernel.org>
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

On Mon, Apr 20, 2026 at 01:33:46PM +0200, Krzysztof Kozlowski wrote:
> > -audio
> >  1.sample rates of 32~192 KHz and sample sizes
> >    of 16~24 bits
> >  2.SPDIF interface supports PCM, Dolbydigital, DTS digital audio
> >    at up to 192KHz frame rate
> > 
> > -Miscellaneous
> >  1.CSC:RGB<->YUV444<->YUV422
> 
> Commit msg is not a datasheet introduction chapter. What does this all
> mean for compatibility? What is the benefit of listing all this?
> 
> You did not even explain the differences between C, UX and EXD, so all
> above is pointless. Explain the differences and why devices are not
> compatible.
>

Also, you have checkpatch errors.

Best regards,
Krzysztof

