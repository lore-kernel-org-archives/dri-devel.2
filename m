Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D16C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E3610E4D1;
	Fri, 17 Jul 2026 19:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GgnSTNEZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B12E10E4D1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 19:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2011960051;
 Fri, 17 Jul 2026 19:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7CD1F000E9;
 Fri, 17 Jul 2026 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784318392;
 bh=bV/Io+zsnPmqBhppNdxP8U+BiGfJ4lrDJ7eHx6qQ8P4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GgnSTNEZNvEYOezdPmowldxslh+zdS3dJjoAQoftgqAibn5fyvzxsTxA0bM8RYQqb
 9WGXB10xn+2S41PO/LWbs3EbFoBxZB6wfpB+fMwL3/j8eyXfPhHnxZneAka0tmnqPO
 zHyACXlKtvq9eJQz71iDZFr9WXlA3nJxx46jBNYB9954MOtWpYhfpYXDXIUVn5n1n5
 +L0RVJKA5IM2B0NMHzfjSRjjxdirdh3AHqiqHzea8Xa0vJrx6gosYcqRcVlEAv866+
 CvL9HaYKlSiHx7zV2Cf9YNKNpvYo6SH8w0K3PIfFiT4hCFU7/8Ox8JkitJHihz6wL0
 aeUdtAt6iKQrg==
Date: Fri, 17 Jul 2026 14:59:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 Jagan Teki <jagan@edgeble.ai>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: display: panel: add compatible for
 DCLTek 300250 9.35in panel
Message-ID: <178431839160.2208367.2195697663410310276.robh@kernel.org>
References: <20260708213500.1867092-1-marc-olivier.champagne@savoirfairelinux.com>
 <20260708213500.1867092-5-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708213500.1867092-5-marc-olivier.champagne@savoirfairelinux.com>
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


On Wed, 08 Jul 2026 17:34:59 -0400, Marc-Olivier Champagne wrote:
> The DCLTek dt300250 is a panel using the jadard-jd9365da controller.
> Add a new compatible for it.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

