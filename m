Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F6ECD6E56
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 10:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A51C10E2A8;
	Sun, 31 May 2026 10:04:21 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACE610E2A8
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 10:04:19 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.239])
 by APP-03 (Coremail) with SMTP id rQCowACXrNOeBxxqUCYVEw--.24510S2;
 Sun, 31 May 2026 18:04:15 +0800 (CST)
Message-ID: <7e758b6272db2928f5ca48299758c69769d5d3c1.camel@iscas.ac.cn>
Subject: Re: Bug#1138033: linux-image-7.1-loong64 dmesg has Call Trace
 Workqueue: events drm_fb_helper_damage_work [drm_kms_helper]
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian>, xiao sheng wen
 <atzlinux@debian.org>, 1138033@bugs.debian.org
Cc: dri-devel@lists.freedesktop.org
Date: Sun, 31 May 2026 18:04:14 +0800
In-Reply-To: <ahvW9WD3MlcnafyV@monoceros>
References: <177987707102.1022.7617225206902682287.reportbug@3A6000>
 <ahvW9WD3MlcnafyV@monoceros>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowACXrNOeBxxqUCYVEw--.24510S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWxGry7Ar13XFW8tF13Arb_yoWfCrX_Ga
 s5KFZa9ryUGa12ga1rKr90kr12kFW8Z34FyryxKryfKr97JF17ZrZ7Kr95Zw13Ww47Ar98
 WwsrK39rArySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbrkYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
 4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
 WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
 Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
 WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
 YxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-Originating-IP: [112.94.101.239]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-05-31=E6=97=A5=E7=9A=84 08:49 +0200=EF=BC=8CUwe Kleine-K=C3=
=B6nig=E5=86=99=E9=81=93=EF=BC=9A

> That patch wasn't accepted, there is a newer patch under discussion
> by
> the same author, but I'm unsure if that is the continuation of
> addressing this issue:
> https://lore.kernel.org/dri-devel/20260519092420.1124348-1-zhengxingda@is=
cas.ac.cn/

Yes, this is trying to address the same issue; however it seems that
fbdev emulation is some kind of rabbit hole difficult to address, and I
start to doubt whether this fix is correct (but at least the previous
change to drm/loongson is surely wrong).

>=20
> @Icenowy: Is that the same issue that you're addressing in the
> currently
> discussed patch? If yes, can you please add
>=20
> 	Closes: https://bugs.debian.org/1138033

Okay, I will add this in the next revision.

Thanks,
Icenowy

>=20
> to the next revision to simplify tracking for us (=3D debian-kernel
> team)?
>=20
> Best regards
> Uwe

