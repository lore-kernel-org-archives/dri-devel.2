Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112FCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECF410E36F;
	Tue, 19 May 2026 07:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="DvpeIEp5";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80AD510E36F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779175729; x=1779780529; i=deller@gmx.de;
 bh=f8NhlNPDLIuqPmfv2I5UmHdnQ9SKvpexMqQF0e/GDh8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DvpeIEp5rIrdQTSnhAUPPg4755Mg75r7CtoQ803IHtOhGG09gFwXWIRlK5W0Bpiq
 RW0S9ZoLVS86swAaa4So+oXwNLwPG3URij6adJ3oQiQ4NryvSk8A+bOIRY+z5g3uv
 o8GN41PLP/52zSpzXkugBzgjuhIpp6alHzsw1jYV7xI+RdPQTvNP8lbXBriNCY644
 FctbQ7Fnf6+PRm5P7Sw9byijr8LVtKrG3/BFM66NcNZtDWbAlBz7U2BDmpBLBN64u
 YZg0jNZSexgXw0nFcyQZcugh/IUsdQKx5J79t+cWXWD3jkIM5l9ruA8GAQolk5gcf
 1LRVlDbLI7j+OVqBFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1xGW5h3SID-00xWZ2; Tue, 19
 May 2026 09:28:48 +0200
Message-ID: <91d315bf-ed9b-48d2-aa4e-59e3e61b343f@gmx.de>
Date: Tue, 19 May 2026 09:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fbdev: Use named initializers for struct i2c_device_id
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260518160808.802423-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260518160808.802423-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:txY7cD5l4wBbsbPltYJ/slzOhGdFmWkc21Yfwad306GRsqXG1bL
 yMfpj6CwJEI5eliZHJWFDPSnC49WqrLXpldFUD61GHb6dvO13mq2HpMXbMnaBcrM99ihPid
 M7hr57BzQvMkCNN1SbOrV55sjqpa3G6aUy5HljtvlPOlmux0h5p7w/jabIB9I5vU0Kd81PP
 noFJksxoSQgw/BOWHHWNw==
UI-OutboundReport: notjunk:1;M01:P0:xU91bz/84VA=;x1pwcARkMZnGMus+dKOluRRskv7
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

On 5/18/26 18:08, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
..
>   drivers/video/fbdev/matrox/matroxfb_maven.c | 2 +-
>   drivers/video/fbdev/ssd1307fb.c             | 8 ++++----
>   2 files changed, 5 insertions(+), 5 deletions(-)

applied to fbdev git tree.

Thanks!
Helge
