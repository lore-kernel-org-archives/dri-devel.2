Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF59606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FE9112BE0;
	Fri, 27 Nov 2026 15:39:36 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F16112BCB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 15:39:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.207])
 by APP-05 (Coremail) with SMTP id zQCowAB3ErgnpAlr_hobAg--.9342S2;
 Fri, 27 Nov 2026 23:39:20 +0800 (CST)
Message-ID: <125b59ea3e5c6d48d325b3ea0c04dbba140bf1c2.camel@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi: let the glue compute the
 hcomponent lbcc
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Romain TISSERAND <romain.tisserand@gmail.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sandy Huang	
 <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Liu Ying <victor.liu@nxp.com>, Chaoyi
 Chen	 <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 27 Nov 2026 23:39:19 +0800
In-Reply-To: <20261127095556.1794628-1-romain.tisserand@gmail.com>
References: <20261101143031.880389-1-romain.tisserand@gmail.com>
 <20261127095556.1794628-1-romain.tisserand@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: zQCowAB3ErgnpAlr_hobAg--.9342S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4xAry5XFWxCr1fJF43ZFb_yoWkuwc_ur
 98AFW29wn7Xa93Grs7tFWrur48X39rW34Iv3y8Awn7Aryvqr4qqF4kW34SqFyrCr4xuF1a
 gFs0gayUKa13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbsxYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07jgPEfUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-27=E4=BA=94=E7=9A=84 10:55 +0100=EF=BC=8CRomain TISSERAND=
=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> Gentle ping on this one, sent four weeks ago. It still applies as is on
> today's drm-misc-next.
>=20
> It fixes the garbled picture of non-burst DSI panels behind the Rockchip
> glue (GPD XD here), and v2 follows the reviews of v1 (Chaoyi, Sashiko).
> Is the get_hcomponent_lbcc() callback in dw_mipi_dsi_plat_data the shape
> you want, or should I rework it?
>=20
> Icenowy, Cc'ing you as you are working on dw-mipi-dsi for TH1520; the
> two series touch different parts of the file.

I dropped the change of dw-mipi-dsi.c in my next revision, as some usage of
dw-mipi-dsi-rockchip (as pure DPHY) seems to be working w/o a d-m-d
structure.

However, I am interested in your patch now.

- The panel used in my TH1520 device (Lichee Console 4A) seems to be also
ILI9881C-based, and it works in burst mode; I think a little power is saved
when running in burst mode instead of non-burst mode.
- I have to copy the ugly extra lane bandwidth logic from the rockchip glue
to make my panel work.

BTW is it worth to get a GPD XD for $50-? I have a little interest on this
device after searching for it.

Thanks,
Icenowy


>=20
> Thanks,
> Romain

