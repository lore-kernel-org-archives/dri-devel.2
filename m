Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48FCC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3B210F200;
	Thu,  2 Jul 2026 08:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nfGzv4gN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4DA10F1A6
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:00:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A86CE6001D;
 Thu,  2 Jul 2026 08:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0887B1F00A3A;
 Thu,  2 Jul 2026 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782979203;
 bh=Q4PYqXEPA9CrErHqa91ZJaH1kjYdbpYUf9UuYq6zkao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nfGzv4gNN7z2ExxL240I0Gbl0zh0l+AvOBpM02Qw2GF2kbT+rsa/Vpf47GM/Dsbvs
 UeNAX/nLxswRSgVjAeQSARnGkcKkTVWYs5wLRXsJmUrk/ou6ScpCE4GB5V5iAkNt/m
 yzLoV+IFhj2neMYJ8INuEBG3r+7hNipm3lx9Iw/oobb/o+ZczRu586hbxyJ1B6eAyk
 g5loD7xSWUUxW/omAGX/kRXhcO9NV8FpW1dsnMJbs8IKZFLDR5P1PTMiev8LE6N84t
 +sf+TltQ/ErSy0kh+aJqpJZypkRjhycPmQsb+WLHfB0rzBj97I3NgadJDPcYFIL5T1
 ImX2zueWK4vWQ==
Date: Thu, 2 Jul 2026 09:59:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, matthias.bgg@gmail.com,
 andi.shyti@kernel.org, djakov@kernel.org, broonie@kernel.org,
 jitao.shi@mediatek.com, 
 ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH 3/6] dt-bindings: display: mediatek: Allow
 trigger-sources on relevant HW
Message-ID: <20260702-authentic-dugong-of-whirlwind-ac3e3a@quoll>
References: <20260701122043.19612-1-angelogioacchino.delregno@collabora.com>
 <20260701122043.19612-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701122043.19612-4-angelogioacchino.delregno@collabora.com>
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

On Wed, Jul 01, 2026 at 02:20:40PM +0200, AngeloGioacchino Del Regno wrote:
> Most of the MediaTek Display Controller hardware sub-IPs need a
> specific (and reserved to them) MuteX trigger.
> 
> Since now MuteX is a trigger source, allow specifying trigger
> sources in all of the display IPs that support one.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

