Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23340CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880D610E2C1;
	Fri, 16 Oct 2026 15:23:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FBF310E2D5
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:23:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACCA4601FF;
 Fri, 16 Oct 2026 15:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC3B1F000C4;
 Fri, 16 Oct 2026 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792164218;
 bh=LzyfTfIddXTn2NFuv/gPTyuWRXFNmc0OZFCdBmjP2dU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gZtKhpDCZ2Fi9hIsiQX27oP5QUKUT4JkTvVlj4N2NmBLVs0mBENKZoGwTlsnVKgFn
 8RU5cEsv19+b4MS/PwxvyvbmxdX8yGY6meGJFWevYu1XB04vQV2qlKjDAlxFJ84kcO
 V3IFGDy6oOmcnRMg3YllGVSG8w/TOxTtSLl004dtvqwfiyrgZR8VeYyBq8SZOsKgkG
 b567GHYYHOjJNoYW2ghhgGne/YrN7CmkSGqhG5uJndXR0qtg8LUHErdMg88gWnjvt0
 mJjxm8rTtUxnYg8UF6haJA5Wr+cgIbSxcvZp7DFy3uns/gc91uPrdX56YRAEYFjbct
 0O5XoJ+1kBYig==
Date: Fri, 16 Oct 2026 16:23:31 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Document Skyworks AAT2870
Message-ID: <atJBc2Bx_UkQl5Oh@aspen.lan>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013180933.487013-2-clamor95@gmail.com>
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

On Tue, Oct 13, 2026 at 09:09:30PM +0300, Svyatoslav Ryhel wrote:
> Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
> Management Unit.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>


For backlight:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
