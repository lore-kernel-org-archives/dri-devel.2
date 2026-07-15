Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCF1C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEE210F026;
	Wed, 15 Jul 2026 12:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="O85N4H+5";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2188F10E126
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784118070;
 bh=P5Lr5a8lnxJ2NwysU8T3ytLeFd87MlRNnosplKhhFvA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=O85N4H+5j2DsMB+X6luVDzDfu7UiPw4R8Kr6JfIZuQBpa4gYq9HUi9x2LNSf+fNDU
 xJosArBmUa8DvGjU0KdmDXn/4HFu+t439/HuiK4jjENKOVn1OtXxo9B7QVAj2CPLPC
 UL4cVpM+1q0+8jodlAZ6NCW0ce7Jnr4mGFRe8H7htAr983qBHhfdUyBEiCyRk6ow1g
 esuWYBdGK9Ya/046SnecIZ8IkF6VaSoPwpSKjXvqip6BIbEZBmZiml51aScCV3qJGW
 u92LIJ646Qyy/PkKxk77gGjK0crWrhLuMh/FoejcsrBAWt/2Fpc4mrNtWJBw+YDhZQ
 5eP9xcHZnKOjg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A8D8617E023C;
 Wed, 15 Jul 2026 14:21:10 +0200 (CEST)
Message-ID: <e21d768e-36e1-40c0-8058-92acefe7cc95@collabora.com>
Date: Wed, 15 Jul 2026 14:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] drm/mediatek: mtk_dsi: Enable PM Runtime on probe
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-10-angelogioacchino.delregno@collabora.com>
 <20260715121611.420601F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260715121611.420601F000E9@smtp.kernel.org>
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

On 7/15/26 14:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Enabling PM runtime causes a kernel panic because the DSI device is never resumed, leaving its power domain off during register access.
> --

Same comments as v4 apply.

In short: This is not true and, even if it was, the HW won't crash and writes will
simply be ignored; that's how MTK SoCs work in the vast majority of cases.
