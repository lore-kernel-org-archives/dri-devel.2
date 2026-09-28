Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC3DCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAC310E94E;
	Mon, 28 Sep 2026 18:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TlCegE3W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D85C10E94E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:03:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59916600D1;
 Mon, 28 Sep 2026 18:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D91F000FF;
 Mon, 28 Sep 2026 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790618594;
 bh=DO7o4JAF+6Q8Jr+W2hSDTGMsm586qLnk695cJOnqtK8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TlCegE3WItry3JOr3+uA5bnqD05RkKoEYikp2K1svBBSDzXiIR5lB69OEH3zS4Geh
 Nr/tdmF5b9gsXBqQev1qvEwzsQDub/A2k77VuZR2YAxyq9W4wdEcAqXyoV7YCKxEUm
 Sa9UrnG/UZbc6wxRhgs1u7B7S3Y8kInCL8dLsMp5svLOrdryu0kjEP5zaCWAjnNqyg
 58h+SPa+jOpVtabGFKGhsN5HN6Ii1fK7coXAYATn1U9yGDuVWTkrkz8qwaCtwwSRr2
 /KR6M303zUYsjQk3l1XRr6YW5DoB7p0VmG2M0Ony4Eb8WrRo4Rfbxqzi9qFuZpEtZO
 vwPxUx/xIRNow==
Date: Mon, 28 Sep 2026 13:03:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 David Heidelberg <david@ixit.cz>, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona@ffwll.ch>, Conor Dooley <conor+dt@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, phone-devel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: vendor-prefixes: Add Shenzhen TXD
 Technology Co., Ltd.
Message-ID: <179061859113.120376.10442541499029119870.robh@kernel.org>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
 <20260917-nt36672a-panels-v2-1-f8de8be5b86f@minlexx.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-nt36672a-panels-v2-1-f8de8be5b86f@minlexx.ru>
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


On Thu, 17 Sep 2026 19:43:03 +0300, Alexey Minnekhanov wrote:
> Add prefix for Shenzhen TXD Technology Co., Ltd., manufacturer of
> medium sized LCD and camera modules for mobile phones, tablets and
> automotive.
> 
> [1] https://en.txdkj.com/
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> ---
> v2: prefix changed from "txd" to "txdkj"
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

