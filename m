Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3571090257
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F3410E9C9;
	Thu, 19 Mar 2026 17:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.b="dFKmxQsx";
	dkim-atps=neutral
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A810310E96A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 17:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4fcC4X1zKzz1XM5kY;
 Thu, 19 Mar 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1773940495; x=1776532496; bh=UHJsWGTSlJTfY7QnX97XerQU
 NMUaLpd7tP4C0EEZkzg=; b=dFKmxQsxM8O2hO+PntnmCfQmA2VsxQt1I9BWP45v
 e99xashdlvnQ0iqpzna366213RNXzYUgf1v3+givoQ4OAgp6jhkArR0HgCsDDvLP
 5u4QOdYjX9pUJlOX2DE3toANf60hlf5yDeqMcuMD1kjAv9XaSRRnHc2imlEmPZqQ
 YiM5s2CDkWV6Mdk4AFzavdqTRL89qGFkfAxKt3lZ3gbdurzVjr4dSZvtrHFIkz0p
 eIImjdzfLZxX4edUA95TsTfOxQ31EJmzDgr27Ispq2YeMv+HqZqSJu2XoNuEf+ZO
 v8YxxK8gPLxPwbUnDpqGfT41WYhoPLQKKf/Ytf8IZrNWLA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kgNEXQsIxXTY; Thu, 19 Mar 2026 17:14:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fcC482cLFz1XM5kW;
 Thu, 19 Mar 2026 17:14:48 +0000 (UTC)
Message-ID: <ea7a5729-3df0-49ef-ab8d-47ade75cc393@acm.org>
Date: Thu, 19 Mar 2026 10:14:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 phy-next 09/24] ufs: exynos: stop poking into struct
 phy guts
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Chanho Park <chanho61.park@samsung.com>
References: <20260309190842.927634-1-vladimir.oltean@nxp.com>
 <20260309190842.927634-10-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260309190842.927634-10-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/9/26 12:08 PM, Vladimir Oltean wrote:
> The Exynos host controller driver is clearly a PHY consumer (gets the
> ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> to get the generic_phy->power_count.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
