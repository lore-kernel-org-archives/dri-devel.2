Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72022CDB47C
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEAE510EE3B;
	Wed, 24 Jun 2026 09:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="zJqFV6vL";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295D410EE3B
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 09:24:28 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id ABE3220078;
 Wed, 24 Jun 2026 11:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1782293066;
 bh=pmBkesNmuLNvUJn5rrwSRud7R4UXCLNjjmtNsb00ATk=; h=From:To:Subject;
 b=zJqFV6vLGI/4MsUw1JuuF4VfY0/aHTgm4za771PD3OyLAKzSgRzGvVU2RNdTj8sP+
 8uaVnVdzFPvCezbAT5qoztkC+sL0fFwOtiAcNUgr52XroELvyObJd8dAIHpUVbRJVE
 kowxnSJ2rZ3lawvQdt44T2ggJsI65W6QSSf92GTji6GK9bdLtnt9aYwzebIVu3XmZc
 l0r9YpmxixJw38js4ET5+rRA4EvvonMPnlwBTdMXmf4L3JOkVDc+jFjukeV9PBQsHj
 w+QevUTrn7Avtb5kV8OCem2WNOVbdGitwRlQYgKpaxTeRv8bqMB7No018XI3K+O0Pp
 D1kV7z4BCdebg==
Date: Wed, 24 Jun 2026 11:24:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com,
 sam@ravnborg.org, leonardo.costa@toradex.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] arm64: dts: ti: k3-am62-verdin: Add Toradex
 Capacitive Touch Display 10.1" LVDS
Message-ID: <20260624092420.GA10665@francesco-nb>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
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

On Tue, Jun 23, 2026 at 04:57:36PM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> This series adds device tree overlays for Toradex Capacitive 
> Touch Display 10.1" LVDS V2 on Verdin AM62.
> 
> The display addition covers two interface types:
> 
> - Native OLDI (LVDS)
> - DSI-to-LVDS adapter based on the SN65DSI84
> 
> The Opto Logic vendor prefix and panel binding for the SCX1001511GGC49 is
> also added.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

