Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF2ACD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 695E810E171;
	Fri, 22 May 2026 11:24:25 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D191110E171
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:24:23 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.115])
 by APP-01 (Coremail) with SMTP id qwCowAAHrGffPBBqDZIpEQ--.4546S2;
 Fri, 22 May 2026 19:24:17 +0800 (CST)
Message-ID: <355fbaf9adac7f8c61833f9c6983ebbc9b56df9e.camel@iscas.ac.cn>
Subject: Re: [PATCH v3 0/2] drm: verisilicon: add hardware cursor support
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard	
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Han Gao
 <rabenda.cn@gmail.com>
Date: Fri, 22 May 2026 19:24:15 +0800
In-Reply-To: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
References: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAAHrGffPBBqDZIpEQ--.4546S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJryDJryUXw1DZFWUCrWxZwb_yoW8GrW8pa
 10yr43AFWUAan3trnrCF1UKrW3A3WxXw4xWF4fJayUAr1Utr1jqr1UXF9Y9FWDJr4xJrWI
 gr4vkrW29FyIvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU89Z23UUUUU==
X-Originating-IP: [112.94.100.115]
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

=E5=9C=A8 2026-05-07=E5=9B=9B=E7=9A=84 01:56 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> Verisilicon display controllers have the hardware cursor feature.
>=20
> The hardware cursor layer is a simplistic and restrictive layer as
> the
> topmost layer of the display output. It can only support ARGB8888
> images
> and some certain square power-of-two sizes (32x32 is supported on all
> DCs).
>=20
> This patchset adds support for the hardware cursor as a cursor plane.
>=20
> Icenowy Zheng (2):
> =C2=A0 drm: verisilicon: add max cursor size to HWDB
> =C2=A0 drm: verisilicon: add support for cursor planes

Applied to drm-misc-next.

Thanks,
Icenowy

>=20
> =C2=A0drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 272
> ++++++++++++++++++
> =C2=A0.../drm/verisilicon/vs_cursor_plane_regs.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 44 +++
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_hwdb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0drivers/gpu/drm/verisilicon/vs_plane.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A07 files changed, 337 insertions(+), 3 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> =C2=A0create mode 100644
> drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h

