Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53860CD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 13:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689E510E24F;
	Sat,  2 May 2026 13:47:42 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFAF10E24F
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 13:47:41 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
 by APP-03 (Coremail) with SMTP id rQCowADnCeF4APZpjD7fDw--.27563S2;
 Sat, 02 May 2026 21:47:36 +0800 (CST)
Message-ID: <c6a4439d757a812994c4a0314a52f236ea7a9b38.camel@iscas.ac.cn>
Subject: Re: [PATCH drm-misc-next v4 0/4] drm: verisilicon: convert
 drm_format to vs_format in atomic_check
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 21:47:36 +0800
In-Reply-To: <21479f6d-80c1-4f46-8a41-e50a2d564a94@suse.de>
References: <20260331060126.1291966-1-zhengxingda@iscas.ac.cn>
 <21479f6d-80c1-4f46-8a41-e50a2d564a94@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowADnCeF4APZpjD7fDw--.27563S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4DKF47uF4ftF15WFy5twb_yoW8GF1kpF
 Z2yFZ8tFWkAwn3J3sxtr4Ut3y3Ca1xJ3WxWF4xJ3WUArWrtr40qr48WryI9FyDGrWfGw1I
 9r4Yyr9xuF97AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j1nmiUUUUU=
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

=E5=9C=A8 2026-03-31=E4=BA=8C=E7=9A=84 08:27 +0200=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> I only looked briefly over the update, but it seems good now.

Could you have a more thorough look on this patchset (and if possible,
apply it)?

Thanks
Icenowy

>=20
> Best regards
> Thomas
>=20
>=20
> Am 31.03.26 um 08:01 schrieb Icenowy Zheng:
> > This patchset tries to move the process of converting drm_format to
> > vs_format into plane's atomic_check callback (instead of the
> > atomic_commit one, which the process currently sits) for more
> > proper
> > error handling (because atomic_commit cannot fail).
> >=20
> > In addition, because of the original flow of primary plane's
> > atomic_check seems to be flawed, it's also updated before filling
> > vs_format is added there.
> >=20
> > Icenowy Zheng (4):
> > =C2=A0=C2=A0 drm: verisilicon: make vs_format conversion function retur=
n int
> > =C2=A0=C2=A0 drm: verisilicon: subclass drm_plane_state
> > =C2=A0=C2=A0 drm: verisilicon: call atomic helper's plane state check e=
ven if
> > no
> > =C2=A0=C2=A0=C2=A0=C2=A0 CRTC
> > =C2=A0=C2=A0 drm: verisilicon: fill plane's vs_format in atomic_check
> >=20
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_plane.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 54
> > ++++++++++++++++++-
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_plane.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 18 ++++++-
> > =C2=A0 .../gpu/drm/verisilicon/vs_primary_plane.c=C2=A0=C2=A0=C2=A0 | 4=
8 ++++++++++----
> > ---
> > =C2=A0 3 files changed, 98 insertions(+), 22 deletions(-)
> >=20

