Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D721075286
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68CB10E929;
	Thu, 19 Mar 2026 09:42:28 +0000 (UTC)
X-Greylist: delayed 501 seconds by postgrey-1.36 at gabe;
 Thu, 19 Mar 2026 02:14:04 UTC
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id BA36910E7F0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:14:04 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8CxJMHtWbtpkYocAA--.35544S3;
 Thu, 19 Mar 2026 10:05:33 +0800 (CST)
Received: from [10.20.42.172] (unknown [10.20.42.172])
 by front1 (Coremail) with SMTP id qMiowJBxrsLrWbtpAj1YAA--.38302S2;
 Thu, 19 Mar 2026 10:05:31 +0800 (CST)
Message-ID: <d2a2e493-40a5-4088-9581-7d7c9c6f96eb@loongson.cn>
Date: Thu, 19 Mar 2026 10:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Update GPU driver maintainer information
To: Jianmin Lv <lvjianmin@loongson.cn>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Xuefeng Li <lixuefeng@loongson.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260318092349.11651-1-lvjianmin@loongson.cn>
Content-Language: en-US
From: wuqianhai <wuqianhai@loongson.cn>
In-Reply-To: <20260318092349.11651-1-lvjianmin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxrsLrWbtpAj1YAA--.38302S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur4kGrW7Kr4xKw48AF4rXrc_yoW8XFy3pr
 s3G3s0krnFyF4fArs8Ca17AF4Yq395ArZ8urWqv3sxur90yw1ktr48Ja13JayDZFWUKa17
 twn7AFW0ka1DGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
 0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
 14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
 vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
 JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU
X-Mailman-Approved-At: Thu, 19 Mar 2026 09:42:18 +0000
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

Thanks for inviting me to be as co-maintainer and I'll try to do it well.

在 2026/3/18 17:23, Jianmin Lv 写道:
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
> index 96ea84948d76..4232039b7282 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8626,8 +8626,13 @@ F:	drivers/gpu/drm/lima/
>   F:	include/uapi/drm/lima_drm.h
>   
>   DRM DRIVERS FOR LOONGSON
> +M:	Jianmin Lv <lvjianmin@loongson.cn>
> +M:	Qianhai Wu <wuqianhai@loongson.cn>
> +R:	Huacai Chen <chenhuacai@kernel.org>
> +R:	Mingcong Bai <jeffbai@aosc.io>
> +R:	Xi Ruoyao <xry111@xry111.site>
>   L:	dri-devel@lists.freedesktop.org
> -S:	Orphan
> +S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>   F:	drivers/gpu/drm/loongson/
>   

