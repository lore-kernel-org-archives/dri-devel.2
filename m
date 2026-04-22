Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D1F9EDF3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6143210EA4C;
	Wed, 22 Apr 2026 14:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Xar1/eqH";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2002D10EA4C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776869413; x=1777474213; i=deller@gmx.de;
 bh=fdBITiU4r9Yiv5+k3sXluR2Y44BinhWwsR9TpdlW9aI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xar1/eqH+x7le+tf+BnNNjYDMLsSillDHli8W31AyS0LbQIuisj7g6CfgD6jQqC4
 VEmR0KBA8wLozvOxHOyBbHs0uLjEglwYhmO7AdmD8Yjetq7ib2wySGVLuQMjhWcdG
 Ges/XgN28O3nUog+L1tHMlDWgTSrdJaEvJHiZJn3uF2aFaEftsrAfN9BcF5Ps++P3
 A5ZCyYyGEfNnaC4Chifgpih1p37CDAUT8QNXwsYt0vaaoh6+z8Lk5CPBoLApzlqZ1
 OZm5pKVVx4pGW/vfUufit7G+RCiI/SOX0ZA2hTj6SQ+snWBcCTU7W7UGzTkCEcjw2
 kYLXRXr12RBjJWOIvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1vj0Nb33yU-00qHBG; Wed, 22
 Apr 2026 16:50:13 +0200
Message-ID: <404ec984-0486-442e-a108-4c5bad700248@gmx.de>
Date: Wed, 22 Apr 2026 16:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fbdev: cobalt_lcdfb: Request memory region
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
 <20260420134424.77494-2-amit.barzilai22@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260420134424.77494-2-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ySBElncOIBNlxy5XtwxK485qiYDkOr7qYpYV5DEQp7kUk5rPEL
 hM1NMBoXMOuWvxa3826FOx91BzEIK+N06rtxPQePwiytyGOHv+VhLBJ1Vm0MUWX5NZzcbyf
 MNFP46VI8MWEityAREjhIAkyLys4FmDLdmJ1bebcWzb6JYdmSIPyRtuR0WHRfYmBqpfn2HN
 EfdzIh8xYI6Ae/Tw2X3sw==
UI-OutboundReport: notjunk:1;M01:P0:qaqmg9m7E54=;z2gGRjgyFxADjmKDN1uDAS/DEGO
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

Hi Amit,

On 4/20/26 15:44, Amit Barzilai wrote:
> Use devm_platform_get_and_ioremap_resource() instead of open-coding
> platform_get_resource() and devm_ioremap() separately. The helper
> requests the memory region before mapping it, which registers the range
> in /proc/iomem and prevents another driver from mapping the same
> registers.
>=20
> Assisted-by: Claude:claude-sonnet-4-6

You missed your signed-off line, which I added while applying patches #1 a=
nd #2:
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>

Amit, please confirm that you wrote patches #2 and #3 and that you
are OK with the added Signed-off-by line, otherwise I need to drop the pat=
ches.

Helge

> ---
>   drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)

