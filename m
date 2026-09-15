Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2F8C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF3010E50A;
	Wed, 16 Sep 2026 07:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="wY1y8xTa";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5509F10F358
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1789464799; x=1789723999;
 bh=hXSEs7BTDlc8dKDKpzIizZkxrmFqMoEY8BMFcJ/xLxg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=wY1y8xTaVY9o71t68zZ8xxpnHJIDVB1JeESHBv+1cj7WISv5xrNPHU/dzNiNh6mI8
 xtxbiTfFHVa7DJUXy5Ueyoex/ntihHchoHtjhDuihhcHlboLrbQnD5DAXiK/2jn0Us
 ayWGOvjJNWs4OHILwjPVjXAmxgfK/9HnvzivI9seOo/T8tPB/Oe/zUDmXcMlwR6HI3
 Qu/DN+XQoTr8bFHzKSJTuULS0SNgscpwOf1HZuirbSnVqbJs8UMRxnsTME3p/iieFB
 U9ZxR1Z5qpEBA7eL5iio25/sYPfWF+4aLMvasr+m0hhY4Em5u405/lCMmh0f4rwSaI
 3oiMy5SbdVyOQ==
Date: Tue, 15 Sep 2026 09:33:14 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: gpu: arm,mali-utgard: add mt6572
Message-ID: <qhCDchmGeChGRGsaz37FafYzJowgCzD3tkhtgZCAmpTdTZ7MloVCm3SgJPxz6_rJZJ_HIxpwgQZibP1bkX2tRz-XkcPVwznUO7issd2PYmI=@protonmail.com>
In-Reply-To: <20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com>
References: <20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 45b726ba5dba26f46e8487dde82dbede2970503f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

Hi Angelo,

Could you take a look at this patch? That's a one line change with a new
compatible string for mt6572 GPU.

Thanks,
Roman
