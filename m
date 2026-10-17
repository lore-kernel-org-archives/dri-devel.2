Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7125CCF2C1
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C942D10E455;
	Sat, 17 Oct 2026 17:25:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574E510E455
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 17:25:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AD0F60AB2;
 Sat, 17 Oct 2026 17:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5883B1F000C5;
 Sat, 17 Oct 2026 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792257921;
 bh=5f/gI5h5KZDV5ahz+DubqH0u+kHWiemTT4qZvIm49L4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SARNoqwM/PD9jQbMUNy5lcK4uolgw8lUHNblRsu+HBf6HTfwBR/cC3XAJFOmBXEBX
 hsQLt3ym8bAsb+K1gkxCXQcc7VUaz2DkxstNa7s+ugTzGGHjiOpv3LckO3UhdDuZQl
 xWRAB0A8OurEVBGn5/1J7C5vAZ2vvFCMFdFAA3tWOOCS3AGbeFMS44CtuN+UWZCVdV
 44P07DRJ4JbQZ2M64aizX/OlcH0D2KBrjKf1OmSSHhsiwQ3y2vEcfcQvdrL6hMrlI5
 7pFvMNGYW7nMmGHCZ/FdC4a2RlGEkiuJZgi3MaGkTdMMB2IgqvSI300JB9Las0lf2U
 YJTaR/jPJ0LTg==
Date: Sat, 17 Oct 2026 19:25:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Asif Ikbal <asif.ikbal@amd.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, thierry.reding@gmail.com, sam@ravnborg.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com,
 michal.simek@amd.com, naveen.gaddipati@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: panel-simple-dsi: Add AUO B101UAN01
Message-ID: <20261017-delightful-gleaming-bumblebee-af40f8@quoll>
References: <20261016094638.2958431-1-asif.ikbal@amd.com>
 <20261016094638.2958431-2-asif.ikbal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016094638.2958431-2-asif.ikbal@amd.com>
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

On Fri, Oct 16, 2026 at 03:16:37PM +0530, Asif Ikbal wrote:
> Add the bindings for the AU Optronics B101UAN01 1920x1200 10.1" WUXGA
> MIPI-DSI TFT LCD panel to panel-simple-dsi.
> 
> Signed-off-by: Asif Ikbal <asif.ikbal@amd.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple-dsi.yaml     | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

