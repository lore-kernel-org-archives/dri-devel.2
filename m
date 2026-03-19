Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36AB1088E6D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2E510E84B;
	Thu, 19 Mar 2026 03:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YCm/W8wo";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EBC10E84B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 03:19:19 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-415e568a7ecso265488fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 20:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890358; cv=none;
 d=google.com; s=arc-20240605;
 b=K+VCS/J+Jh/J/bGvCUG9ayUQSWIy0DP/Csna6qfJ5AeMlyGwHGnKd6uzouuGbsUWBf
 smAERHud26cJQy/TDlEPzxYd9U6YOa3FjOmw9OMXje+mazEzw1dmOfvFtNSgyMLHYchZ
 2lHo0zlrTDKyZPSTgqH1KvKai6Cus9OFdzPw5etOX5TWvdg29N7n1pym9LyRKbuXNHYu
 /o80I35A3qu35KDoMMH/rEUMY3xWKrYF7QFCnxtwiZeFs5vx/qD313yhY3kn78ykvcje
 mboLtzU3Hfm0a51SwDnu6m4bkgsP04WIhq8Xne+IcVlr+0AvATK40GkM7/9IlNRoVXbU
 1wXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0ysTLBrMyO5J7X2J7PiyEUD2C41UEmOyTszOq707Vrg=;
 fh=WJeqOmZh+Kk+gLRtuay23nN1sSog3BGbnAAP78erKjU=;
 b=ePzI7UIo3ybcbodHUqN4/W4SYa7MvDnWrftdJaDnwTnRV0Ftxo6nB+aWa7O5PuKGDS
 ynjU1RZ47HOPl3DQX/9RpKbLqE+VfstB8X0Wl7jgErLo/pOuvztFOwP4Uad2NDdoWNkw
 3/horuWtgltMWwlAZMBYv4uQTxsRMLmaHExRaNSpeKr7n+fbQhRoiGNPm9/v0MsNfr9K
 bl+ZhyWbQZZatGoJJjYyu6hNcOYpB6RiAGFjMyXC771GqQRXdwNDug1OHW/ia3nU0TQb
 FqlEVcrdE4fb4l6zhA3mbSmu9Svl3kn5r8vzk5j6ntipYf5M/qXOzz7M2otKpzyHRpw5
 bXlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773890358; x=1774495158; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0ysTLBrMyO5J7X2J7PiyEUD2C41UEmOyTszOq707Vrg=;
 b=YCm/W8wouMqDOrCh3loJJhUrrrECTpNnCJ4oEuAyECTsHl9bdAqd8yNiGIeowgZ+qJ
 RgFz5p3+5oww81FwYCxf3Pc6LoQUue0d34B1b7I/NCUrLEBSJdigY6JWoU0L9Ujlb1Gv
 abckvNNmfPebqBCsMzJ66Os7tkBuA2Bzbv2cH97qVN/+j6kn2/fVW/wfaTXMe5ygZc4k
 Jv4Pw5U+ouveV5VERc2F87SROwmIRHRCJSPDeA2KHL62aDJboyaGCvDXsYCBenQR/Hzi
 sW/6gyvi6quGX54h/oDiYuFnxnRRzAfWDCmE3VM5Kh6mi7BOql85myf1vNY/g21tE99k
 mm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773890358; x=1774495158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ysTLBrMyO5J7X2J7PiyEUD2C41UEmOyTszOq707Vrg=;
 b=duzMSJzwcxzLWkHypPSvzgwQ0atSO2yxcst6BJ7EFWcHCpDEsUfY6wgk/nKefKXXtE
 3fHpzWJEKTNfxl4u30ba55n49Fh6aQVYBSB5YKWeOzSi2iehxLnEk86hk+poelP/5byY
 jsTbkcX6ujfyoYrfSjtFr5I5SyY7VJ/S6PfY3J14GHeJZ84/xUh0VvTgw3s0ogpMLrnx
 IMzaY3m2s76Pqt613QmiX1JWvfIPuBkCGQ1jvUB49hYT0GJT+Tfl1iuhkNg4Q2pAtFSo
 6meRR+2VyosxYWn4SNZGQu3EgbOZBg71gl11ge5Sh0+xVjgtVJV9APfwrbEZLCZ9q40r
 WUZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQouTqD+5CE0WcWhpVN8qHM7gkLAqg+t/w5r5nPJNhOOGCVgDhc6iUqw9oAvb+xpk5qB23goobeFg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9FwXkGICY/XcBLXCwZluKj77amrHBBkAt7KZReonxfk42Rk6d
 73xKraf6MXOfwgifi9oOLi3ZEVo/ybc59ZzwPJEoAYX27QSa4phr/PIemwrMxz2xRk/B7UiEnu7
 5kzEKqzbJUIcRw1s/71MYrqB7b35idaY8DtXsd0in/A==
X-Gm-Gg: ATEYQzxYk6ZdGS+D/G2hZHZfhdThpiUHFDWmeW3RjA5jPKUFG1DGNjtBiKf0iC9H9dK
 sfGHz0PFW1HGVY2B8CA9A8AqUFj6nHIHJ9YxngZpgXK0xXjHTE8bOqr0xlzh0n64WVlINvGgii/
 Oq+CkzSr7SmjfPxJU/SNDuU5t3euRdJQgttqwPDObsa4uu7z//GSdluyhj4aDl8i097sfQ5lIv+
 n0ejxPSCm75pDLNadFC9T6OyPkulIwk7ZZp5J2j5u2k3zgLazBeFLvmYmqbDgCDr2mI06A72OGs
 noZ7WoudFejw+8xDew==
X-Received: by 2002:a05:6820:4cc7:b0:67c:ceb:df6b with SMTP id
 006d021491bc7-67c0daa1a53mr4043973eaf.26.1773890357952; Wed, 18 Mar 2026
 20:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260318125326.3709098-1-shiyongbang@huawei.com>
In-Reply-To: <20260318125326.3709098-1-shiyongbang@huawei.com>
From: Xinliang Liu <xinliang.liu@linaro.org>
Date: Thu, 19 Mar 2026 11:18:42 +0800
X-Gm-Features: AaiRm51kTncfyNS5U906mzA4M8EP6FGpKSz_i_aLxjJ54JljpfG513cWE6NcYtk
Message-ID: <CAKoKPbzAFi+MjTq-foT78zHsdZ7kpb5ciSfVHFuHH3Tr8-MLrA@mail.gmail.com>
Subject: Re: [PATCH V1 for drm-misc-fixes] MAINTAINERS: split hisilicon
 maintenance and add Yongbang Shi for hibmc-drm matainers
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: tzimmermann@suse.de, tiantao6@hisilicon.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
 dmitry.baryshkov@oss.qualcomm.com, liangjian010@huawei.com, 
 chenjianmin@huawei.com, fengsheng5@huawei.com, helin52@h-partners.com, 
 shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

,

Hi,

On Wed, 18 Mar 2026 at 21:01, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
> To improve maintainability, split the maintainer information for the hibmc and
> kirin drivers under the drivers/gpu/drm/hisilicon directory.
>
> drivers/gpu/drm/hisilicon/hibmc driver has almost completed feature development
> based on the new generation HiSilicon BMC chip. It was co-developed by
> Yongbang Shi, Baihan Li and Lin He. Going forward, this module will be
> maintained by Yongbang Shi.
>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> Acked-by: Tao Tian <tiantao6@hisilicon.com>
> ---
>  MAINTAINERS | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d7241695df96..4f8dbadbe70b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8603,18 +8603,31 @@ S:      Maintained
>  T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:     drivers/gpu/drm/gma500/
>
> -DRM DRIVERS FOR HISILICON
> -M:     Xinliang Liu <xinliang.liu@linaro.org>
> -M:     Tian Tao  <tiantao6@hisilicon.com>
> -R:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
> -R:     Sumit Semwal <sumit.semwal@linaro.org>
> -R:     Yongqin Liu <yongqin.liu@linaro.org>
> -R:     John Stultz <jstultz@google.com>
> -L:     dri-devel@lists.freedesktop.org
> -S:     Maintained
> -T:     git https://gitlab.freedesktop.org/drm/misc/kernel.git
> -F:     Documentation/devicetree/bindings/display/hisilicon/
> -F:     drivers/gpu/drm/hisilicon/
> +DRM DRIVERS FOR HISILICON HIBMC
> +M:      Yongbang Shi <shiyongbang@huawei.com>
> +M:      Xinliang Liu <xinliang.liu@linaro.org>
> +M:      Tian Tao  <tiantao6@hisilicon.com>
> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
> +R:      Sumit Semwal <sumit.semwal@linaro.org>
> +R:      Yongqin Liu <yongqin.liu@linaro.org>
> +R:      John Stultz <jstultz@google.com>
> +L:      dri-devel@lists.freedesktop.org
> +S:      Maintained
> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:      drivers/gpu/drm/hisilicon/hibmc

Please remove me, Sumit Semwal, Yongqin Liu, and John Stultz from here.
I'm going to hand over the hibmc DRM driver maintenance to you.
And if you look at the git log, the other three guys were added here
for the kirin DRM driver.
ce1fc502de42 MAINTAINERS: Add Sumit Semwal and Yongqin Liu as reviwers
for kirin DRM driver

> +
> +DRM DRIVERS FOR HISILICON KIRIN
> +M:      Xinliang Liu <xinliang.liu@linaro.org>
> +M:      Tian Tao  <tiantao6@hisilicon.com>
> +R:      Xinwei Kong <kong.kongxinwei@hisilicon.com>
> +R:      Sumit Semwal <sumit.semwal@linaro.org>
> +R:      Yongqin Liu <yongqin.liu@linaro.org>
> +R:      John Stultz <jstultz@google.com>
> +L:      dri-devel@lists.freedesktop.org
> +S:      Maintained
> +T:      git https://gitlab.freedesktop.org/drm/misc/kernel.git
> +F:      Documentation/devicetree/bindings/display/hisilicon/
> +F:      drivers/gpu/drm/hisilicon/kirin

Please remove Tian Tao and Xinwei Kong from here. They are here mainly
for the hibmc DRM driver.

Once address the above comments, please add my ack:
Acked-by:  Xinliang Liu <xinliang.liu@linaro.org>

And to be a DRM maintainer, you might need to apply the push
permission of the drm-misc git repo for pushing the hibmc driver patch
in the future.
See the docs below for what DRM-misc is and how to apply the permission:
https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html
https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html

Thank you very much for maintaining the hibmc DRM driver.

Best regards,
Xinliang

>
>  DRM DRIVERS FOR LIMA
>  M:     Qiang Yu <yuq825@gmail.com>
> --
> 2.33.0
>
