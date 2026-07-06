Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC69C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBC410E324;
	Mon,  6 Jul 2026 07:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="xbOdLygW";
	dkim-atps=neutral
X-Greylist: delayed 341 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 07:39:52 UTC
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158E010E324
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:39:52 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783323248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tt5w7FHENYGSmUnLysArHs7fpiW1RbH2kKIfrTPwZN0=;
 b=xbOdLygWLbvY+igbSWp7n3fp3UsfDs2b3F9HnUpn45E90k0zC1Uzi1Na4inpXzulBhPk7L
 +rla/XvyvEb9j7j5KUr3K2/9mJwb2qzGiX7QPXoBAp5vnsy/9tlCwnBIxMWB1sqU9X1Hpu
 Nop8smXRT3XPA9ktxWAHtE4h2nb4E6Y=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>
Cc: junjie.cao@linux.dev, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update my email address for the AW99706
 backlight driver
Date: Mon,  6 Jul 2026 15:33:53 +0800
Message-ID: <20260706073358.1038452-1-junjie.cao@linux.dev>
In-Reply-To: <20260703080149.GF2108533@google.com>
References: <20260701133533.32585-1-junjie.cao@linux.dev>
 <20260703080149.GF2108533@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

On Fri, 03 Jul 2026, Lee Jones wrote:
> Doesn't apply.  Please rebase onto -next or for-leds-next.

My apologies. V2 (rebased on latest linux-next) sent.

Junjie
