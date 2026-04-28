Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EB5FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BCF10E27E;
	Tue, 28 Apr 2026 05:50:03 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C2C10E27E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:50:01 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
 by APP-05 (Coremail) with SMTP id zQCowACHFgp+SvBpHObKDg--.35547S2;
 Tue, 28 Apr 2026 13:49:52 +0800 (CST)
Message-ID: <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after
 sending disable cmds
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Doug Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang	
 <yangcong5@huaqin.corp-partner.google.com>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 28 Apr 2026 13:49:50 +0800
In-Reply-To: <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowACHFgp+SvBpHObKDg--.35547S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFy7GFWDCrW5Xw48JF1rtFb_yoW8XrWfpF
 WUta9Ika1kJr4IyFn7XrZYvFWxAr4fAFZ0krn5W34kA345WFyFvay8trWq93WUXr4kCa1a
 qFsFqFyqka95AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU2wIDUUUUU
X-Originating-IP: [112.94.102.122]
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

=E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug Anderson=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> >=20
> > When preparing the panel, it seems that it always expects commands
> > to be
> > transferred in LP mode. However, the disable function removes the
> > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> >=20
> > As the unprepare function contains no DSI commands, re-adding the
> > flag
> > just after disabling the panel should be safe. Add the code re-
> > adding
> > the flag after the two commands for disabling the panel are sent.
> >=20
> > This fixes screen unblanking (after blanking once) on
> > mt8188-geralt-ciri-sku1 device.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# 6.11+
> > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as
> > separate driver")
>=20
> This "Fixes" looks wrong. The bug was still there even before the
> driver was broken out. ...and it looks like the driver that this was
> broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?

Yes, but I think the fix shouldn't be propagated to the other driver
because of the same reason with breaking out the original driver.

I have a device with a panel driven by the nl6 driver (device is
mt8183-kukui-kodama-sku32, panel is boe,tv101wum-n53), it shows the
same DSI timeout error message with ciri sku1, but the screen do come
back to life when unblanking. Maybe this fix should propagate there,
but I need more confirmation.

Thanks,
Icenowy

>=20
> -Doug

