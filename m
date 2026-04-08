Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0357A1073C89
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 09:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6251610E54B;
	Wed,  8 Apr 2026 09:57:55 +0000 (UTC)
X-Greylist: delayed 490 seconds by postgrey-1.36 at gabe;
 Wed, 08 Apr 2026 08:16:33 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 62AB910E56F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 08:16:33 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxH6r0DNZpwxAjAA--.38258S3;
 Wed, 08 Apr 2026 16:08:20 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxKMHpDNZpHk1oAA--.54361S3;
 Wed, 08 Apr 2026 16:08:09 +0800 (CST)
Subject: Re: [PATCH V3] MAINTAINERS: Update GPU driver maintainer information
To: Jianmin Lv <lvjianmin@loongson.cn>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Qianhai Wu <wuqianhai@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260320101012.22714-1-lvjianmin@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <b3703928-0584-6c29-527a-76b32cc093dc@loongson.cn>
Date: Wed, 8 Apr 2026 16:05:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260320101012.22714-1-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxKMHpDNZpHk1oAA--.54361S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrWrCr47Gw4ftw4ftF47Awc_yoW8WFWUpr
 s3Gw1ayrn7tF4fZrn5Ca17AFWFq39YyrZ8WrZ0y3s8ur90yw1rtr4jya1UJa9rJFWUKa1U
 twn2y392ka1YkFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
 UUU
X-Mailman-Approved-At: Wed, 08 Apr 2026 09:57:54 +0000
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

Wonderful.

Hope the maintainers and reviewers could submit more Loongon GPU code, 
rather than occupy the position purely.

Regards
Bibo Mao

On 2026/3/20 下午6:10, Jianmin Lv wrote:
> I and Qianhai are GPU R&D engineers at Loongson, specializing
> in kernel driver development. We understand that the current
> Loongson GPU driver lacks dedicated maintenance resources
> because of some reasons.
> 
> As Loongson GPU driver developers, we have both the capability
> and the responsibility to continuously maintain the Loongson
> GPU driver, ensuring minimal impact on its users. After internal
> discussions, our team has decided to recommend me and Qianhai
> to take over the maintenance responsibilities, and recommend
> Huacai, Mingcong and Ruoyao to help to review.
> 
> And We'll continue to maintain it for current supported chips
> and drive future updates according to chip support plan.
> 
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96ea84948d76..eccb8273cd3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8626,8 +8626,14 @@ F:	drivers/gpu/drm/lima/
>   F:	include/uapi/drm/lima_drm.h
>   
>   DRM DRIVERS FOR LOONGSON
> +M:	Jianmin Lv <lvjianmin@loongson.cn>
> +M:	Qianhai Wu <wuqianhai@loongson.cn>
> +R:	Huacai Chen <chenhuacai@kernel.org>
> +R:	Mingcong Bai <jeffbai@aosc.io>
> +R:	Xi Ruoyao <xry111@xry111.site>
> +R:	Icenowy Zheng <zhengxingda@iscas.ac.cn>
>   L:	dri-devel@lists.freedesktop.org
> -S:	Orphan
> +S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/loongson/
>   
> 

