Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAE1CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8CA10EB5C;
	Tue, 19 May 2026 08:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="MU+7DdAM";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02E710EB5C
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1779179616; x=1779784416; i=markus.elfring@web.de;
 bh=Zs3fx5czFunHsQlJinpz5GhbywO2hVUNt9XZk+y6E+I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MU+7DdAMsiJLUx6sB52sdQfSUBx1sp/Te3sQzCRGbZsRM36OPo8dgUY1FyGwjuzF
 WQHpTq7ooH6T5bjwo5pGYwugyDZfCi2auCVOmadoAD0idCtrlHnyGENQxRA9tkU5+
 v9WKghxDaCx5A9SRV8wEzrP4uHwuLbG6DtaW8PmgjCjmSOj6th46mQnHdRT7T6DZ0
 9SNpMEi5U2tgsHKLHZIHtdmeiZ+AdHDODVKmrzXIdC9YqoUxu03u9lsz1tdcLtoXE
 +6HR8UANMqVehAy/+f9myiY1PK4yOsNgkZR/rAWozo4Ugp4hBV/Txva8IypWTsriC
 Q18GQptQNs7E7aIcGw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LwP-1xNf0F0s8Z-0122mT; Tue, 19
 May 2026 10:33:36 +0200
Message-ID: <47e5bbaf-7b39-4c5c-849b-314204db1b97@web.de>
Date: Tue, 19 May 2026 10:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lu Yao <yaolu@kylinos.cn>, dri-devel@lists.freedesktop.org,
 Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>
References: <20260519074046.143672-1-yaolu@kylinos.cn>
Subject: Re: [PATH] drm/loongson: mode_config.cursor_width should use
 hw_cursor_w
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260519074046.143672-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GZD2cBR9/PFYwZVW9hATRyB+CxG/6PvdsF+fVBtDVMS4hfc9Xiq
 IveMa33YqO6LUV8DgzEfTpQDDGeQnZ3TxaEvV2p92AhY2dkwbS9GLBsdOJ116mzdMWrGlDd
 UasallZVn7vnkBNmtfGCjF+mam7JsbtdESfs52QBJb+01xDMeXRlmRdGHxQxLZ5eU5WmVkZ
 0E/xB5c9jyyBFNwk0zyAw==
UI-OutboundReport: notjunk:1;M01:P0:qG708rpOwaQ=;rcdzyU91N8mFvN2vhJ9RpHggWUZ
 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
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

> mode_config.cursor_width should use hw_cursor_w rather than hw_cursor_h.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.1-rc4#n94

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?


https://elixir.bootlin.com/linux/v7.1-rc3/source/drivers/gpu/drm/loongson/=
lsdc_drv.c#L142

Regards,
Markus
