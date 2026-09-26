Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DABC9831E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 04:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23E510E030;
	Sat, 26 Sep 2026 04:48:14 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E85710E030
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 04:48:12 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.96.244])
 by APP-03 (Coremail) with SMTP id rQCowAAHE0GFTrdqYafICA--.2178S2;
 Sat, 26 Sep 2026 12:48:07 +0800 (CST)
Message-ID: <fc425e648644d94276bce7d3d4dac8b0acd4c5d8.camel@iscas.ac.cn>
Subject: Re: [PATCH v7 7/7] drm/verisilicon: fix DC8200 primary plane
 disable clearing FB_EN
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 26 Sep 2026 12:48:05 +0800
In-Reply-To: <fde43d758a66a8feefc50274f3573e33a67d43f2.camel@iscas.ac.cn>
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-8-a0987203069@gmail.com>
 <4a7b271d2a90eff94c27dec3bf24114ce44df1fd.camel@iscas.ac.cn>
 <1d988dfb-c930-4c17-ae77-47b93ff9f159@gmail.com>
 <cb30f57c0ac124aac85efad32626e6182b9f1369.camel@iscas.ac.cn>
 <b589c197-2297-42c4-b017-3594cdd1cd56@gmail.com>
 <fde43d758a66a8feefc50274f3573e33a67d43f2.camel@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAAHE0GFTrdqYafICA--.2178S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1DCF17Ar48Ary5tFW3GFg_yoW5Ar17pF
 ZrKa45KwsrJryIvwn2kw4kJa4YkrW8J34UJr95Gry0k398tFy8tFW8G3yfuFW8Xr4kWw12
 qF4jyr95uFWkA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7IU56yI5UUUUU==
X-Originating-IP: [120.85.96.244]
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

=E5=9C=A8 2026-09-25=E4=BA=94=E7=9A=84 22:55 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2026-09-21=E4=B8=80=E7=9A=84 15:49 +0800=EF=BC=8CJoey Lu=E5=86=
=99=E9=81=93=EF=BC=9A
> >=20
> > Icenowy Zheng =E6=96=BC 2026/9/21 =E4=B8=8B=E5=8D=88 03:30 =E5=AF=AB=E9=
=81=93:
> > > Maybe it's better to just make it the 2nd patch in this patchset,
> > > just
> > > after the binding change.
> > >=20
> > > Waiting for something into drm-misc-fixes again will need another
> > > fixes
> > > pull and another RC back merge, which can consume weeks and miss
> > > the
> > > current merging window.
> > >=20
> > > In addition, it's possible that `drm/verisilicon: introduce per-
> > > variant
> > > hardware ops table` also gets backported for a more clean primary
> > > plane
> > > atomic_update disabling fix.
> > Understood. I'll fold the FB_EN fix in as patch 2, right after the
>=20
> Should I just apply this revision of patch with this reorder?

Oh I think more fixes are coming.

There's one more DC8200-specific problem (which might be problematic on
DC8000 but I am not sure): The vs_dc8200_panel_disable_ex sequence must
be executed before vs_dc8200_panel_enable_ex, because some timing
parameters seem to be latched when the value going from 0 to 1, and
when a stale state is programmed before the driver is loaded (e.g. a
firmware driving the display) and the timing isn't the same with the
timing of the first modeset, the modeset will fail.

I'm thinking about sending a fix patchset first, which will pick the
FB_EN fix here, implement a fix for the stale state problem and maybe
implement fixes for the old state dereference problems for hidden
planes in their atomic_update callback (although this fix will
introduce a helper, which will then be moved and renamed in the DC8200
ops patch).

Thanks,
Icenowy

>=20
> Thanks,
> Icenowy
>=20
> > dt-bindings patch, targeting the current vs_primary_plane.c
> > directly,
> > so the ops-table patch just carries the already-corrected code
> > forward
> > into vs_dc8200.c. Agreed that's faster than round-tripping.
> >=20
> > On primary_plane_disable_ex - I'll keep the "_ex" suffix. DC8200
> > still
> > has a real per-variant operation there (clearing FB_EN + commit),
> > while
> > DC8000 leaves it NULL and does nothing, so the suffix still
> > reflects
> > an actual per-variant difference, not just structure introduced by
> > the
> > refactor.
> >=20
> > While testing the cursor plane, I found the same class of bug
> > there:
> > the disable register write was being triggered from the plane's
> > atomic_update() invisible-branch using the old plane state to look
> > up
> > the CRTC/output, which can be stale or NULL on a plane's very first
> > commit if it's already invisible then. I've fixed it locally by
> > having
> > atomic_update() derive the CRTC/output from the state it already
> > holds
> > before checking visibility, instead of falling through to the
> > old-state-based disable path. Just flagging it here for now -
> > vs_cursor_plane.c isn't touched by any of my patches.
> >=20
> > Thanks.

