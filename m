Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D160C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FCC10EF59;
	Thu, 20 Aug 2026 08:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=boogiepop@gmx.com header.b="UN/w+ccq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F6610E1AD
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1787170080; x=1787774880; i=boogiepop@gmx.com;
 bh=F0HN2rt6KtjcYs9YkufiPzjOy9R5j8ZTKh4GWljahIs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UN/w+ccq1f6JdTFx96Kj4d9RDSS3XU3Kcrekh6EMDNCsOesmghRW2ltxTFgg5X6L
 tTV6gGiLDp615IYRxcEh5QI311S+oYqLerxkFzStjoGjH05l0MJgqAnLYzYsv4ouK
 flVUZrarnbqQQcNXPDt09C3OBpYpGNAkK3RVv4Y0lb+DHHcMcqT/TtcfcIJTgmoFH
 xYWR8Vg58nOlW9KrHomhliQvFbFI4En4QMAKs2j8dHJxY2BtysDuWLyXgkf/ApFe/
 YA8dD4w2N6WBzTqefWX8Vp9l8Rij7+srpa+5rDVAfIrr9hzKEY4Bdi88n8vMIdNVO
 J1Ao8YdoQb1U3NEfaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDywu-1x4Vnw1m5s-00BgSa; Wed, 19
 Aug 2026 22:08:00 +0200
Message-ID: <f5241666-9657-4f49-958f-476fd366e408@gmx.com>
Date: Wed, 19 Aug 2026 22:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
 linux-rockchip@lists.infradead.org
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
 <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
 <20260819184807.6665-1-royalnet026@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?H=C3=BCseyin_BIYIK?= <boogiepop@gmx.com>
In-Reply-To: <20260819184807.6665-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mlv8S7CUH/7RBz8WXD4sT0R2t5FnyExmoyLbrAdw9qbPOduOzIc
 dkfXLh3jqXMqDbDCh2fyDkzN0NYNsWI3WCVVKSw7+umm/msOBjFJgwq+3Xt+wAM+1+hO4Ps
 1CBmSEonmgLR5Bbz8KdNtDE7dRjFcaiLQEdNhM1kB9KzY/56esS2Am57A2SLYqcyy+voKjE
 nOsLNrTIq03ONEUCHF5bA==
UI-OutboundReport: notjunk:1;M01:P0:F5zTgo2ZjLg=;uvySno1TM0IbkTD4AQyqwLhhFki
 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
 9Ayx3yrDyLA=
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

Hello Igor

On 8/19/26 20:48, Igor Paunovic wrote:
> So a question for you and for H=C3=BCseyin (added to Cc): is that
> STATUS register perhaps readable from EL3 only, with EL1 reads as
> zero? That would explain everything, since [3] reads it inside the
> firmware. If so, the clean path is the one [3] already implements -
> after my trip I will cherry-pick it into the BL31 my board runs (it is
> plain upstream v2.12 there) and re-measure through plain clk_get_rate,
> which also spares the kernel any GRF access at all.

No you can even read them from userspace with mmap. i think there is=20
also a firewall configuration where you can restrict the access per ip=20
core, but default configuration should not require any EL escalation.

If the status register is providing 0, most likely it is not started (i=20
am guessing by past experience).

Here are the most relevant registers:
GRF.CON0_L.start =3D 1; // start the status counter
GRF.CON0_L.en =3D 1; // enable PTVPLL
GRF.CON0_L.osc_ring_sel =3D n // ring to use
GRF.CON0_H.ring_sel_len =3D k // length of the ring
GRF.CAL_CNT =3D 24 // how many sample to average

Result is in:
GRF.STATUS0.OSC_CNT =3D ...

You can also mess around with this mmm userspace tool where you can edit=
=20
the GRF registers visually in an easy way, the python code also shows=20
how registers interact with each other when clock is calculated if you=20
want to dig in deeper:

https://github.com/hbiyik/mmm

Here is a quick tutorial i had written on how to observe the PVTPLL=20
status using mmm.
https://forum.radxa.com/t/mmm-memory-map-manipulator-perfect-tool-to-un-br=
eak-your-soc/15332/6

I hope sharing links is fine in mailing list.

H=C3=BCseyin
