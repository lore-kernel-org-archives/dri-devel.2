Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E684C5DF86
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1ED10EF7D;
	Thu, 20 Aug 2026 09:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="EUR9HklN";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FED110EF7D
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787217006; x=1787821806; i=markus.elfring@web.de;
 bh=C/hfcOK7zM4LQEB9IqujIYfDMZGIv1G6kLyZkAL1T9M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EUR9HklNZhtLTPZ6yQeK+khDXGnUrbqdmMZIO5FkSc5SNOWNkOhni7uMxEzQ+Q65
 wteUrvHnX31lQvTQSXeOSAigSzzx0m7lfY7PxXLxZsviT1E2oGC7V3MeOrOzjWcF5
 bk+oD7mhSnDv4z5nHr8PzuVb1UaLWWtwjFfMiSrtXphbbDWfCfDvbaiUoSQPrJGRH
 u7BiXJ34mqg3oofBr7p0C1g3zr4JR5BWwRpac9haMIxRwzfvi0HkQ+fZkl1OFFGsq
 vXtvYJHIKc6/ZfiFyfWhRAyQ/xxQKI9YRR3Fy0ZvuJIomPzEdcYZcSGLCHj76f9zE
 i7/gZHtVb81apaHS8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwA1A-1we4QE1Ktg-013N9d; Thu, 20
 Aug 2026 11:10:06 +0200
Message-ID: <45534001-10da-454c-92be-9c6a96afc5c3@web.de>
Date: Thu, 20 Aug 2026 11:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Triet Hoang <triet.hoang.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, David Airlie <airlied@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260820085609.2103835-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH] drm/mediatek: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260820085609.2103835-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+fSKlASmaz/AotNPNzZvw6miU9//Ca0y1viDd8QtW+7qN8qrstr
 1p+TZ2tAkfc0iuo1b/NYorT7GLu6og19YOnDSOvyuuYGZ4S3b6aW8sBfOgeELcoTCehFj9b
 55gRwNSCaWNV6vAhEoWTf/GhupUW0MtCm3qAtMXKlOwBHBZp8+4QX1I95YCFsdEiXGSqe1X
 tM0/aQFcNi+cyvNmPiHpA==
UI-OutboundReport: notjunk:1;M01:P0:zWsw0++HIlc=;R6ZKcQxN0juoDJHeV+Om2AfK0H2
 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
 uwJ/APxo4iLdMGeBujRm4XHfrX74M=
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

=E2=80=A6
> This lets us drop the __maybe_unused annotations from its suspend and
=E2=80=A6
  Thus drop =E2=80=A6?

Regards,
Markus
