Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5366108B8FF
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6C610E299;
	Sat, 21 Mar 2026 05:05:28 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632B910E299
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:05:27 +0000 (UTC)
Received: from [192.168.1.204] (unknown [112.94.102.202])
 by APP-03 (Coremail) with SMTP id rQCowAC3m+IHJ75pwzRUCw--.57166S2;
 Sat, 21 Mar 2026 13:05:12 +0800 (CST)
Message-ID: <4180689d3426882dcac2eb74209d398477f88b90.camel@iscas.ac.cn>
Subject: Re: [PATCH 0/2] drm/bridge: th1520-dw-hdmi: Two fixes
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Felix Gu <ustc.gu@gmail.com>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Andrzej Hajda	
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	 <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Sat, 21 Mar 2026 13:05:10 +0800
In-Reply-To: <20260321-th1520-v1-0-ec877197770d@gmail.com>
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAC3m+IHJ75pwzRUCw--.57166S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1fXFykWF4rAw13CF1DAwb_yoWxZrg_Za
 9YyryqvrWUAFs3C3ZxZrn8Z3sYg345JFW5Ar1DK398G3yFyrnxW3WrW395Xry3uF4qkFy3
 trn3A398C3W7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbskYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxUVQ6pDUUUU
X-Originating-IP: [112.94.102.202]
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

=E5=9C=A8 2026-03-21=E5=85=AD=E7=9A=84 03:12 +0800=EF=BC=8CFelix Gu=E5=86=
=99=E9=81=93=EF=BC=9A
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
> Felix Gu (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: th1520-dw-hdmi: Fix error chec=
k on dw_hdmi_probe()
> return value
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: th1520-dw-hdmi: Fix remove() c=
allback

Both fixes look trivial and let me start to doubt how could I make such
mistakes.

Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

>=20
> =C2=A0drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: b5d083a3ed1e2798396d5e491432e887da8d4a06
> change-id: 20260321-th1520-f4326138c9bf
>=20
> Best regards,

