Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC700CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4517310F529;
	Tue, 13 Oct 2026 07:33:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F8D510F529
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:33:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C3934330B;
 Tue, 13 Oct 2026 07:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F61F000FF;
 Tue, 13 Oct 2026 07:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791876822;
 bh=MtxkqZsYWfDcUkWU6En+19yAwPMCTyC65/gEd56cH1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VSQonXouTURdDmZOEnfAJ1ZwBsMub36mFTvktIKLrkdIawbEF2YMFJ7lt2SvIe0bZ
 NQ7DEt3hHfFHdJMOIvQJQwwujmwgrktQTbbnnJmHieX9xjcFg4J0mduEl4kzFrTd99
 iVakr5+3TKmNNeDnt6nOlcQ5WGGUHfGbiJwSRHKZrMqSY1mZsRSgjHf3I+mGmsXeDe
 7hn7mG/CD/dWMd4SjFJtc1wqaxhI97GIP/ycE/dzwk5LTMNdM4/tkx9cfJ3Q4wwxNK
 musmcFfdNpeD6WHzlLw2DxhYiYMWPnC7n5EMI30JDKhkmfcLXiuNaUAoAm3Ge3FdsW
 Nuyf8kDHQwHXA==
Date: Tue, 13 Oct 2026 09:33:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adam Azuddin <azuddinadam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, 
 tzimmermann@suse.de, jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Message-ID: <20261013-artificial-splendid-goat-d078dc@quoll>
References: <20261012064518.3497285-1-azuddinadam@gmail.com>
 <20261012064518.3497285-2-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012064518.3497285-2-azuddinadam@gmail.com>
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

On Mon, Oct 12, 2026 at 02:45:04PM +0800, Adam Azuddin wrote:
> The RA8875 is an SPI-connected TFT display controller by RAiO
> Technology Inc. It supports display resolutions of up to 800x480.
> 
> Add YAML binding schema for the RA8875 controller, along with

So you ignored my feedback.

Not reviewing the rest.

Best regards,
Krzysztof

