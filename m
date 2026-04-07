Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80795EDB7CC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 08:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60EB10E364;
	Tue,  7 Apr 2026 08:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IbhF+zst";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F47610E362
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 08:00:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B0AC2600CB;
 Tue,  7 Apr 2026 08:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EF9C116C6;
 Tue,  7 Apr 2026 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775548856;
 bh=iEz+dUNo81C1L3aGhMEQgTNaHtApnj+jMIi+id30px8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IbhF+zst1UklscRUfT6vNhEhZoiCXnQPX1xy3tFgAqTSDi/d+k6Y4JhKnA7EHJbwv
 bysXJr9SRzrC6vJ4OveSEsy0+G2OClLaSlCTdvlfqDZtq1vyF2DEWJWpYlEt8UxBPE
 WmuyC/ZFUScMRJ6SfsJQWNOkSwLSUqDScMhWr7A9RspcF+nFaQ2q5vAj8WEcQJAXa7
 Pp2N1EXniD5lQU5Td6xjjO1VAdgi5w7ycWzEo58rZ6koXaP8dC1QG528/Og2LjPMQ3
 78tcWAbBZYtsxJ1DNSleAniMY5yEDOJX5KNlVoD3RdWMJk5lex+AH47YwBtDZbmNAw
 +5Kb6Lx0WgeIg==
Date: Tue, 7 Apr 2026 10:00:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: devicetree@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: lt9211: Require data-lanes
 on DSI input ports
Message-ID: <20260407-archetypal-toucan-of-drama-b495a0@quoll>
References: <20260404034123.340818-1-marex@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404034123.340818-1-marex@nabladev.com>
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

On Sat, Apr 04, 2026 at 05:40:18AM +0200, Marek Vasut wrote:
> The Lontium LT9211 is capable of 1..4 DSI lanes per input DSI port,
> describe the lane count for each input port in the schema.

Ah, and subject does not really match what you did in the patch. It will
match when you fix the patch, though...

Best regards,
Krzysztof

