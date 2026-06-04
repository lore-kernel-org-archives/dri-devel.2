Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C597CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD6B1129E5;
	Thu,  4 Jun 2026 22:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="qcVLqjJq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D995B1129E5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780613199; x=1781217999; i=deller@gmx.de;
 bh=9XTZRdcVLAUvy3dFrUv+nicStcWX5FE8cZidlT1NIvQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qcVLqjJq89nvL+ioOUXnxT/C8ln51qvtOgLDh/KJRHq0aK8QAc5PwWOzX7vud+Sv
 3YqRbCqFGTlbo16B1QRMmF7a12tSpPH11fkPVI7kfQmVom0kqCTudR9ZgJADr0BUi
 VkucET5utr++KlYwC57CSKcwSnmRFqdE69CWAiD/DcGXzO7/d2TQlR6MEVWWYD5Pd
 19k/EinhPznY9+0g1hSwvJ1v99xNzUW1NrEnqouc8EZg9kqJ9e9n0iBgUJRlQ3LeB
 BVAUMbTUo+sjmQEGU3WYITuJ3emdLZ+2tbB8y6oXZns9Oa4yBnJehBFlnsELYhVCQ
 AiKaf3pcVkU/TaOBzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq6M-1xOTwt2urY-00wulk; Fri, 05
 Jun 2026 00:46:39 +0200
Message-ID: <35ba1816-bde9-49d3-abf2-127bc7e44574@gmx.de>
Date: Fri, 5 Jun 2026 00:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: pxa168fb: use devm_ioremap_resource() for MMIO
To: =?UTF-8?Q?Alberto_Ar=C3=B3stegui?= <aarosteguig@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260527153913.33342-1-aarosteguig@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260527153913.33342-1-aarosteguig@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fUKxC2MZ8n+BvGFDHm6tt7eiighm3oj0W9TPeiFhWdcBLTpd1Xd
 KVsr5m9y0LFsDPamLqjuCdVfDA29QQ7llNpObE34ML49PBpX0/x7W9gBJ8gsY6ZffRKFtlC
 b8JHiprVgnj41nkCt2JhZx073ToO452vvSJSjq/WWDt0x3s53IJvMc38dwEJXNtIiG/YvO7
 nA68GpeGx77F74m7huuGg==
UI-OutboundReport: notjunk:1;M01:P0:U/fLnU4o9mA=;ZmRVANQfKit7ohPOkJ80Erj/MUI
 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
 1S9MOKoQhzmjaCwAn/u4uoS+1/AM9l0j/wRk=
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

On 5/27/26 17:39, Alberto Ar=C3=B3stegui wrote:
> From: AlbertoArostegui <aarosteguig@gmail.com>
>=20
> pxa168fb maps the LCD controller register resource with devm_ioremap(),
> which does not request the memory region. Use devm_ioremap_resource()
> instead so the MMIO range is claimed before being mapped.
>=20
> This also handles cleanup automatically.
>=20
> Signed-off-by: AlbertoArostegui <aarosteguig@gmail.com>
> ---
>   drivers/video/fbdev/pxa168fb.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

applied.

Thanks!
Helge
