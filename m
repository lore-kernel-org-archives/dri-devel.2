Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F19ACD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75CA710E040;
	Sat, 23 May 2026 02:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I/2cyfcM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8504510E040
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:20:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 560FA43F2C;
 Sat, 23 May 2026 02:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4361F00A3A;
 Sat, 23 May 2026 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779502828;
 bh=lFM5PWOdU5SJvKfq+edrZNlVRfXERJPQJqK2WjRV0rI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I/2cyfcMuq7HfchzqdP1HEW7M5rJk1BvAIrR9mnaRzzTJw+GYeIc1SpNgXtHyqHyA
 /Lz/aPZV360LhT296CJp3I94RTxdzj/9uYKdEVxOSkJW+iog4F/8g/GJ8kowfmGh+A
 t7A2ZnfB1rhCbS9dKRLx36EMpCInCC15ADxyqoKAXm//gsvu/JmUDJ0iFTnVLurCS/
 68QX8NQK+HMi6/jjohzFCT8pyBC1k63/uQo/7LHpCaBfP9/Nuv0CLjZJv65Ui1T0tI
 OFRAdfKDHGSexVL7e0SfHqFVYVHWupXYddbCjnZnallvaOrtrUgOt5ExSpf8z2pZVf
 JVBTC+1CPulXA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Richard Acayan <mailingradian@gmail.com>
Cc: Yifei Zhan <yifei@zhan.science>
Subject: Re: (subset) [PATCH v3 0/5] Support for the Pixel 3a XL with the
 Tianma panel
Date: Fri, 22 May 2026 21:19:55 -0500
Message-ID: <177950280316.1097700.11750721441821313484.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310002606.16413-1-mailingradian@gmail.com>
References: <20260310002606.16413-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 09 Mar 2026 20:26:01 -0400, Richard Acayan wrote:
> This expands Pixel 3a support to the Pixel 3a XL, starting with one of
> the panel variants. The Pixel 3a XL has two variants with panels from
> Samsung or from Tianma/Novatek.
> 
> This series depends on the IMX355 front camera devicetree patches
> (https://lore.kernel.org/r/20260217002738.133534-1-mailingradian@gmail.com).
> 
> [...]

Applied, thanks!

[4/5] arm64: dts: qcom: sdm670-google: add common device tree include
      commit: fe9f4a46895dc3062cedcdd38772dd578de9e62f
[5/5] arm64: dts: qcom: add support for pixel 3a xl with the tianma panel
      commit: f3919fa784a3e6dd557dfe2c41072f55742e013f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
