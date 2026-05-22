Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE2FCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE3E10F546;
	Fri, 22 May 2026 11:33:19 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F09A10F546
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:33:15 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.115])
 by APP-01 (Coremail) with SMTP id qwCowAAHsm30PhBqUL4pEQ--.4624S2;
 Fri, 22 May 2026 19:33:09 +0800 (CST)
Message-ID: <36c9f600659923045c84e59c7a3b61e29cce1013.camel@iscas.ac.cn>
Subject: Re: [PATCH v3] drm/loongson: Use managed KMS polling
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Myeonghun Pak <mhun512@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Sui Jingfeng	
 <suijingfeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu	
 <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai	
 <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org, Ijae Kim
 <ae878000@gmail.com>, Huacai Chen	 <chenhuacai@loongson.cn>
Date: Fri, 22 May 2026 19:33:08 +0800
In-Reply-To: <20260513065706.23803-1-mhun512@gmail.com>
References: <20260513065706.23803-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowAAHsm30PhBqUL4pEQ--.4624S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4ktw13Gr48KFy5Ar47Jwb_yoW8GF4DpF
 W3G3sxtFyUGrn8CF4qg34xXF1xuaykJa43CrsxJ397uw1qya4fWr1xtF4Yg3WDJrWY9F4F
 yFyqvr1Skw1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07jaXdbUUUUU=
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

=E5=9C=A8 2026-05-13=E4=B8=89=E7=9A=84 15:57 +0900=EF=BC=8CMyeonghun Pak=E5=
=86=99=E9=81=93=EF=BC=9A
> lsdc_pci_probe() initializes KMS polling before setting up vblank
> support,
> requesting the IRQ and registering the DRM device. If any of those
> later
> steps fails, probe returns without finalizing polling. The driver
> also
> never finalizes polling on regular removal.
>=20
> Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> lifetime and automatically finalized on probe failure and device
> removal.
>=20
> This issue was identified during our ongoing static-analysis research
> while
> reviewing kernel code.
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Jianmin Lv <lvjianmin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Thanks,
Icenowy

> ---
> Changes in v3:
> - Capitalize the subject as suggested by Huacai Chen.
> - Add Reviewed-by and Acked-by tags.
>=20
> Changes in v2:
> - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
> =C2=A0 and Thomas Zimmermann instead of adding manual cleanup paths.

