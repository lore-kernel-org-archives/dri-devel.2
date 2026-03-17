Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272DBFD8775
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E99710E3F4;
	Tue, 17 Mar 2026 13:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="EPwiq9Sy";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE01310E63B;
 Tue, 17 Mar 2026 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1773755879; x=1774360679; i=markus.elfring@web.de;
 bh=MaNG8uCPQyO6FAqh3I9totg0QV7pWK+opadzzs4G6CA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EPwiq9SyFXri0MejIq3rTJ8W2Oi0oGEwrpfnyz12QWk47qZv4OVc7MG3P9lijLuS
 ikvwcuMTaPRKjuEM+X89BfzeifmykDecGk9QGBf+QuEFwODJGiVxOHw2d7y1T8/j3
 Jz+Kk+gMo5Qe7kfgjPSqWCFDUn164gwjvgXB3Pdhb51hEeUHrvjfU51iYCT6CK+bT
 Hh5Wa/owEF0iWLynT7v+ZDxnaJ3UgnJGVeDVQY2VgY8JksExCwUfO+m5qP6tUXqsQ
 Dyo6fALZ1ph0yQiJrgsjrI4YNLE6khGJaQ5u8/IFE+8TKF8/C+J+pY0er8jmgybON
 ZVicnOgnshAWFi8Stw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MftC1-1vMXHS3GED-00kw0X; Tue, 17
 Mar 2026 14:57:59 +0100
Message-ID: <3c71bfaf-1470-4115-aaa3-5427f3cd13d0@web.de>
Date: Tue, 17 Mar 2026 14:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: refactor MQD init into per-IP helpers
To: Prike Liang <Prike.Liang@amd.com>, Junrui Luo
 <moonafterrain@outlook.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yuhao Jiang <danisjiang@gmail.com>
References: <SYBPR01MB7881D8124681BC48D009E222AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <8aea894a-1dd3-48d3-b21e-23b8c2796e0b@amd.com>
 <PH7PR12MB60009289D930B947E2775B64FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <PH7PR12MB60009289D930B947E2775B64FB41A@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UFxO8nyX9iTuWzZl1yELADNFVYahDKa1d6LmMclv8X6VKSLeefU
 Thr0WMp9RZtFYgYywLF9sZmJT3s7jkY+3U5LzsSU2jchiM90R/9jtmvytXlca+EJdMAg86x
 kSLF+vwFgZbW6UQCpGQJBv68zhHTgc5i5YaLFG7x8rwpJT3i5GEX80AAavy+mweX+bcp7RH
 upEGDLEn2Ydpl+m0/Fk/A==
UI-OutboundReport: notjunk:1;M01:P0:8MtufmNMwg0=;lka5w25/eIRNjfXjIYCdhZRjgGn
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

> We may need to clear mqd before returning on error to guarantee kfree() =
won=E2=80=99t see an error pointer at scope exit.

Would you like to take another look at a corresponding implementation deta=
il?
https://elixir.bootlin.com/linux/v7.0-rc4/source/include/linux/slab.h#L517

Regards,
Markus
