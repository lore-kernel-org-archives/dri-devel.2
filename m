Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21D2F94CA0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB8110E911;
	Tue, 21 Apr 2026 17:57:04 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3308310E913
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:57:03 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.10])
 by APP-03 (Coremail) with SMTP id rQCowABXPONnuudpPWnLDg--.22657S2;
 Wed, 22 Apr 2026 01:56:56 +0800 (CST)
Message-ID: <3318ac65b5d16875bdee6b79c808290b93a5d23a.camel@iscas.ac.cn>
Subject: Re: [PATCH] pvr: acquire vm_ctx->lock before mapping memory to GPU VM
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>
Cc: Brendan King <Brendan.King@imgtec.com>, Danilo Krummrich
 <dakr@kernel.org>,  Donald Robson <donald.robson@imgtec.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Wed, 22 Apr 2026 01:56:55 +0800
In-Reply-To: <20260421175228.1928742-1-zhengxingda@iscas.ac.cn>
References: <20260421175228.1928742-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowABXPONnuudpPWnLDg--.22657S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr47GrW7XF1Uury5WF1fCrg_yoWfGrcE9r
 WUGw1kuFWxGan3tr40g34F9Fy3KrWjg3y8u3y5tr45J3y7tr1vqFs8W3sxZrnrXa18KFn0
 93Z0qrWFyrs7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbV8YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
 DU0xZFpf9x07b0SoAUUUUU=
X-Originating-IP: [112.94.102.10]
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

Oops, wrong commit title prefix... Wrote too commits for Mesa recently.

Should be drm/imagination: instead.

Will send a replacement patch (and remove an unreachable Cc).

Quite sorry,
Icenowy

=E5=9C=A8 2026-04-22=E4=B8=89=E7=9A=84 01:52 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> The drm gpuvm code doesn't protect find operation against map
> operation,
> and the driver needs to ensure a map operation shouldn't happen when
> a
> find operation is in progress.
>=20
> As all occurences of drm_gpuva_find*() is already guarded by
> vm_ctx->lock, make pvr_vm_map() to acquire this lock to prevent
> disturbing any find operation.
>=20
> This fixes occasional NULL deference in drm_gpuva_find*().
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4bc736f890ce ("drm/imagination: vm: make use of GPUVM's
> drm_exec helper")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

