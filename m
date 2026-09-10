Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7E9C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261AE10E4F4;
	Thu, 10 Sep 2026 08:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P8Oeo985";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1A910E4F4
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:53:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC33740950;
 Thu, 10 Sep 2026 08:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BAD1F000FF;
 Thu, 10 Sep 2026 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030381;
 bh=LWbuziL/gzqHiLZp9Iv1I9mzRwq5pd0PunHCM9fMJnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P8Oeo985doTWowffGnq4B6XCRHuOlPp945fNLrl/RMaXno6olC/NxJkFUaESpOkuR
 YLNIMjMbZqwhkEPTdMNHDNsAN9ooUev5jX2sNeevIRI7BBGSefrnQ5K6UgS276qZE0
 m4VJ41NsmnXmtNktvZZafKXYuD0vFWzNJ9zf4BZ8Dk2AAU8H84gVAWoWoG+NqYTqRO
 s82xf+MlMsbbCrkorGAvdCf7FcZCUlH9LjlB+/BBJwS1KQsCzY3quE07fCx/BHZh66
 ykks5wJPh9Sdbk9C4hyUuGTkmISDXa3Ygr0lKmSALL7oBiNzxH8AnTsZzIkHdv/2ZI
 LZUq4/Cm6wCvA==
Date: Thu, 10 Sep 2026 10:52:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joel Selvaraj <foss@joelselvaraj.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/panel: ebbg-ft8719: update Joel Selvaraj's email
 address
Message-ID: <20260910-large-tourmaline-frogmouth-ead837@quoll>
References: <20260909-update-email-address-v1-0-94a240f9469e@joelselvaraj.com>
 <20260909-update-email-address-v1-4-94a240f9469e@joelselvaraj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909-update-email-address-v1-4-94a240f9469e@joelselvaraj.com>
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

On Wed, Sep 09, 2026 at 01:12:02AM -0700, Joel Selvaraj wrote:
> My jsfamily.in address is no longer active, switch to my current one.
> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>

And this the same as mailmap. Same maintainer will apply all this. Don't
inflate commits for review without need. Only the binding is separate by
convention.

Best regards,
Krzysztof

