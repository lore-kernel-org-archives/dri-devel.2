Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BF4F013C5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7228610E309;
	Mon, 16 Mar 2026 07:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bN4kcqSY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2A210E309
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 07:44:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 499E7600AC;
 Mon, 16 Mar 2026 07:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A011C19424;
 Mon, 16 Mar 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773647063;
 bh=jGPrO2FQcvyYUSyWnPJsq1IIZQkTqFVZ1oXeZPGuRzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bN4kcqSYFAf7XV21HHQtKoB+eqXcgPVK062v90fDk17asbbxF5vEbEa90HIylDiLF
 wsOqxHXUK6z9YmTdzfl+pLLvSIuVCDdZLT81RV0gq7ZUdPvN+v4YTY1vN0rxjqO6i1
 BBjDRtQ/VtZG+XEjjnRjoKNqLttJQ71kRVnH0XiYXPYdNFasewIpMMMDNjslqyJN17
 nwtsjNapOiVMDrTA9dBLodCVovbCNKd7Ae7thC+BHdn/nnJ6FY8Avrx8RDkKVU5Iyh
 bq75916QftYFK9McLJ+eMiZOjl0YAvlgQ4BL77ZLCFCikAkihN03ffOS2IDK68jNcM
 yC9YYhN2YOYUQ==
Date: Mon, 16 Mar 2026 08:44:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Himax HX83121A
Message-ID: <20260316-demonic-delicate-manul-8ffb80@quoll>
References: <20260315144536.515032-1-mitltlatltl@gmail.com>
 <20260315144536.515032-2-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260315144536.515032-2-mitltlatltl@gmail.com>
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

On Sun, Mar 15, 2026 at 10:45:35PM +0800, Pengyu Luo wrote:
> HX83121A is a driver IC used to drive MIPI-DSI panels. It is found
> in HUAWEI Matebook E Go series (Gaokun2/3) with BOE or CSOT panels.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> v3:
> - remove '|' from description (Krzysztof)
> - drop description for reset-gpios (Krzysztof)

And all other changes?

Why aren't you testing this code?

NAK, drop the tag and request re-review.

Best regards,
Krzysztof

