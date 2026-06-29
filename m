Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F460C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 05:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8B210E02D;
	Mon, 29 Jun 2026 05:47:53 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5CE10E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 05:47:51 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.182])
 by APP-05 (Coremail) with SMTP id zQCowABXr9IFB0JqwRvqFQ--.34785S2;
 Mon, 29 Jun 2026 13:47:49 +0800 (CST)
Message-ID: <b7edb3650856d154b860dce9260dffe4932458af.camel@iscas.ac.cn>
Subject: Re: [PATCH] dt-bindings: display: verisilicon,dc: make resets
 non-optional
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, robh@kernel.org
Date: Mon, 29 Jun 2026 13:47:49 +0800
In-Reply-To: <20260629053600.336811F000E9@smtp.kernel.org>
References: <20260629053017.4050868-1-zhengxingda@iscas.ac.cn>
 <20260629053600.336811F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowABXr9IFB0JqwRvqFQ--.34785S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJry7Xw4fCr4rKr18tw1DJrb_yoW8GF13pF
 sxXF42kr48tFs7tFsrAr4rCa42q3Z3tF15JrnYqrWDAay7GFy3tFWakFyruayDCr18Z345
 uw45WwnIva4q9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
 82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
 C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
 MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4oUDDUUUU
X-Originating-IP: [112.94.101.182]
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

=E5=9C=A8 2026-06-29=E4=B8=80=E7=9A=84 05:35 +0000=EF=BC=8Csashiko-bot@kern=
el.org=E5=86=99=E9=81=93=EF=BC=9A
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [Low] The commit message incorrectly states that the controller
> requires 'two reset lines', while the actual binding schema and
> examples define three reset lines ('core', 'axi', 'ahb').
> --
>=20
> commit 11712ddd9a2861c41656c6eb9cdbd525c93e3665
> Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>=20
> dt-bindings: display: verisilicon, dc: make resets non-optional
>=20
> This commit makes the resets and reset-names properties mandatory for
> the
> DC8200 controller variant. The commit message notes that the in-tree
> device tree already populates these lines and the driver handles them
> gracefully if missing in other variants.
>=20
> > The only variant supported by the binding now, the DC8200
> > controller on
> > T-Head TH1520, requires two reset lines.
>=20
> [Severity: Low]
> Is the description of "two reset lines" accurate here?=20
>=20
> Looking at the existing schema in verisilicon,dc.yaml under the
> resets
> property, it defines three reset items (DC Core reset, DMA AXI bus
> reset,
> and Configuration AHB bus reset). Should the commit message mention
> three
> resets instead of two?

Thanks for this tip, it seems that my memory in brain bitfilpped and
this deserves a fix.

Thanks,
Icenowy

