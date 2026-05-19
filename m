Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC7CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3DD10EAFC;
	Tue, 19 May 2026 08:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="hYMOx+Ea";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F58910EAFC
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1779177621; x=1779782421; i=markus.elfring@web.de;
 bh=19EjJ5W9oMM8L/b8Nw5yO1bZa251eFV/nzdubGhI4Vc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hYMOx+EaF6Fa5htRUrLtby/iLpSEaIJgnys7MzqFb9X89ZmSPcf1hS2k5p04X7uk
 EnvyWZn7dODRrlv2VIZu0ye6GQVIbgoxVdo8knS0Z7J+WkyqIcMBY4EEVliTr9TnS
 RBudIAApZ6NxuT4uvr0jats9qNPx/wEouVUS5le2EjKJctG3Jp2ZLwmY+EfghnZre
 O/XJ6L7EiVX2qxx3xFsFk62CrGWjT7sYi1K61kSxAByN/JwIKlBDr8RgKjVcRS5pR
 yNsS29Epj4qMM+fX9/QJF+RPCaszuy9jJsv9Hr9aKHgW9Fla2ewsgFUid5cMKqBbk
 CendMPWTaUl0ej+vUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2gkf-1wMlru05nT-003Ir4; Tue, 19
 May 2026 10:00:21 +0200
Message-ID: <8ba844ab-9851-4045-a4e8-a96e6d1511e2@web.de>
Date: Tue, 19 May 2026 10:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lu Yao <yaolu@kylinos.cn>, dri-devel@lists.freedesktop.org,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>
References: <20260519073807.142372-1-yaolu@kylinos.cn>
Subject: Re: [PATH] drm/loongson: fix pci_dev refcount leak in
 lsdc_get_dedicated_vram
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260519073807.142372-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mtrPLzgu/WzmqrsflqIZR20QJWyYtUx/Q3eNnlTl7W7cME31qxq
 w2d9GHpwJPiCg4WMgGeMCDPK/A7HD39fddtIXkoO4YEe2AdBEEJArbXbji2Gj5UlxYfnLQq
 7GIoBU7bvOniv6zMv7bSzDztBNc8bwlDSBoqiKf22WFsXD7bTFiU4gujt11SjJgdfAsf9GW
 5s0se7SCgbjmxSRoK7t5w==
UI-OutboundReport: notjunk:1;M01:P0:2UiZjl/vKds=;xEJOlEzE9Ml1xc5oNCPTGJ68UA0
 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
 hAB4XjOs6XV0LFi5yj89pI8J5NDTWXsqAWX4=
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

> Need call 'pci_dev_put' after 'pci_get_domain_bus_and_slot'.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.1-rc4#n94

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Would it be helpful to append parentheses to function names?


https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/gpu/drm/loongson/=
lsdc_drv.c#L154-L190

Regards,
Markus
