Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A2FCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 19:30:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D880D10E24A;
	Tue,  5 May 2026 19:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LcS80M1X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0A510E24A
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 19:30:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A27464081B;
 Tue,  5 May 2026 19:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E307C2BCB4;
 Tue,  5 May 2026 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778009452;
 bh=BSXjw9y3KYoAOtp4MKHJYGZVUScd4L94J8qMpikSXXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LcS80M1XsfS2qDLN4lcCjVu+8ZIOi6RttY7/OiKj0iinJIwz6c1egpyZJMkc0ejQ8
 AXMVO7dzRkBBFUGg357piGKkJGw3zVRPA3ey4w/zqop/nmC//IY/VnpMNbpl8A/iN6
 35aCGKNViUVfgyiCVUil4skzo/qhsfg+ukEnmWd1mF57Mnmnm37stQt/f3O+8MI4GH
 MZEQP5jLa5NA79rBik6NeX67i6m97WeFnBAIPKr2Hevf3/muI3k0xZUnCMaCOVwNah
 3ekp9AOENsMy65i4fs+uFgV+qvYvWgQ4HjeQKgHstZPpgaztHpwsfO3ftE668YCrfi
 HwfcSMd1Do2mg==
Date: Tue, 5 May 2026 14:30:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Lee Jones <lee@kernel.org>, Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 David Airlie <airlied@gmail.com>, Nishanth Menon <nm@ti.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 01/15] dt-bindings: display: ti: Move ti,am62l-dss
 binding to a new binding file
Message-ID: <177800944993.3784016.8382311748877095453.robh@kernel.org>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-1-f628543dfd14@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-beagley-ai-display-v1-1-f628543dfd14@ideasonboard.com>
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


On Mon, 20 Apr 2026 15:54:08 +0300, Tomi Valkeinen wrote:
> We currently have two binding files for different TI K3 DSS versions:
> ti,j721e-dss.yaml which contains bindings for the "full" DSS version,
> with four planes and outputs, and ti,am65x-dss.yaml which used to
> contain bindings for the "lite" DSS version, with two planes and
> outputs.
> 
> ti,am62l-dss binding was added recently to the ti,am65x-dss.yaml file,
> which only has a single plane and a single output. To keep with the
> above "binding file per DSS model" style, and to simplify the
> ti,am65x-dss.yaml file, let's move the ti,am62l-dss to a separate, new
> file.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  .../bindings/display/ti/ti,am62l-dss.yaml          | 136 +++++++++++++++++++++
>  .../bindings/display/ti/ti,am65x-dss.yaml          |  94 +++-----------
>  MAINTAINERS                                        |   1 +
>  3 files changed, 156 insertions(+), 75 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

