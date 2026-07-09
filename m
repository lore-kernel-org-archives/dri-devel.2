Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1294C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5359810F4D0;
	Thu,  9 Jul 2026 10:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9y96QwG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DC310F4D0
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:57:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6B8D419D9;
 Thu,  9 Jul 2026 10:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2381F000E9;
 Thu,  9 Jul 2026 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594650;
 bh=l8jwpRzuklUNqFt2VCLS4GmwDHQPef/tVTCpOjZJlFM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=b9y96QwGQyjcii+BfXrVlm4/GEmkMGeHyMF6vvO7ly7mbiCQGTNeBaJL0Ky4yW5Lr
 VpzCIVyJsR/dv4i+c8YriAyD5bCAA5yaVpKCPqgH7fDNReyFS4PD7G343VLd1h2Z/j
 PvVqDcYQZbJycF9pK5k3/fU7GBIrTrnGyBEH2mudjQgknhhR/dMrSN7ojOErYg7Euh
 O4yUNMepPv2lNGdMVpmeFaS89dz1qUud5WZK1fQEga1fGDfa4+wowo+6JmDxYiTPG/
 wfRtEuP2Onbx1oRYkYc3Y9zZx8hEYSnJ9ehVlcHT0O506MXzsrU5z8CuU2MR+hmsTo
 U0AG77pz9bVug==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Junjie Cao <junjie.cao@linux.dev>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 krzysztof.kozlowski@oss.qualcomm.com
In-Reply-To: <20260706073307.1038430-1-junjie.cao@linux.dev>
References: <20260706073307.1038430-1-junjie.cao@linux.dev>
Subject: Re: (subset) [PATCH v2] MAINTAINERS: update my email address for
 the AW99706 backlight driver
Message-Id: <178359464819.2111333.7818516262621173390.b4-ty@b4>
Date: Thu, 09 Jul 2026 11:57:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Mon, 06 Jul 2026 15:33:07 +0800, Junjie Cao wrote:
> Switch my maintainer entry for the Awinic AW99706 WLED backlight
> driver from my personal Gmail address to junjie.cao@linux.dev.
> 
> Update both MAINTAINERS and the device-tree binding maintainers field.

Applied, thanks!

[1/1] MAINTAINERS: update my email address for the AW99706 backlight driver
      commit: 4b3f5baf67dea91452b5b114dcb19139feba71dd

--
Lee Jones [李琼斯]

