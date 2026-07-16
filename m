Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8534C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5539410E25E;
	Thu, 16 Jul 2026 11:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FIGf+TL1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C572F10E25E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:02:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14FD06001A;
 Thu, 16 Jul 2026 11:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8283A1F000E9;
 Thu, 16 Jul 2026 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784199739;
 bh=6nnmo/F1N1BR3ZAsLT77Fh9RIM/5mhmAJ8ig8kx0k9c=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=FIGf+TL12hw9Y1OZkWdlvnyP8NlyvXz1zoY2H/5seIXqs+HA08EHSOqxiZnFkrqq1
 ymv2gYsDmSt5bMOkIEDb1Egi78rgoZmcqwsdNFnTz+YMYunocK4VwyQf9qQAVh30Y6
 M59nQGwBgT11zApwGIORq55xe/c0y3rqr3MDkWxsyRSvNOz+0fvDp4koFtCgQVUeva
 a1cU3kAAK3AKo5P0+2nn2XRg6ropCT7SbuvVKlDHuCKMtEQNExrtaDv4a6iMBtDZrm
 4wSzbwtQIf1yfxWAOst66yX41kQ15fr6xiZL0NqS8ByBt9y88bzk0WsSApWh9zU1y6
 mAXy8v2LjQV9g==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manuel Ebner <manuelebner@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260710112529.435341-2-manuelebner@mailbox.org>
References: <20260710112529.435341-2-manuelebner@mailbox.org>
Subject: Re: (subset) [PATCH] dt-bindings: Add missing bracket
Message-Id: <178419973728.1276269.15658607490515790554.b4-ty@b4>
Date: Thu, 16 Jul 2026 12:02:17 +0100
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

On Fri, 10 Jul 2026 13:25:29 +0200, Manuel Ebner wrote:
> Add missing '};' to code.

Applied, thanks!

[1/1] dt-bindings: Add missing bracket
      commit: ce6fc04113241c82a698f362f8dc6e1cc2f65448

--
Lee Jones [李琼斯]

