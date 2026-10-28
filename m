Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FF606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=Wt+0ixG5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE6510E6EA;
	Wed, 28 Oct 2026 18:39:51 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA0B10E6EA
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 18:39:44 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-48e94879f02so517464fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793212784; cv=none;
 d=google.com; s=arc-20260327;
 b=s7B3vxgYZYjzj3w7J/kAvHOmVRxWq7UriE+D+IsnF11RyUZpXp6NLjHjUD8DlpWEVO
 xhZQJHvqNssdOVnnPq6lBo269VBiGBtEAhX2OQyRrijj5zfmP6f3UYj1VGubPzgSxwQF
 SaSLsBH/DNltFlt0uqhH/Rw+7GVqP3JM2YltqWi8kUe1GlOGm4MOAUjjW4hrqe7iy/wQ
 5y4mYDR+NLp4chht2T9CmyM3FWbLonzoUvGDFTzvdWvfSOg84BDe+AIWhXl7xGYdrK10
 DThiIp/p6kj3rL8puPj+FNs99tfwMDjf+33MGlh27ZsnzMmcLmxuH9emKSjioh8nFMWd
 kX2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
 fh=TJeq0uIWXCn71jR652r/DdVxU/jyJvffmgFgGB8Vlc4=;
 b=FBwkwQUdKRkA5ogyXRvTjyxl/YwihLW229XA7j9Lq5Uc76Q9rNHIi+MZAJJtrg6Lur
 GcH6rZvRZEZYrVlFDtHwEci0kuWtIRhMBm87fyzIehKZpJrDguSgpLB2N5AZosR6ir7h
 3qYtX7v8wrEj/BaIco3yMq6/UXtkIftLeKwbNXDMgza8zTNgXpzu7Qj/yxX1oZY8iXS1
 sm1xoIYXmmJFyV+f1dyZY6wvXhy7vYd30E1miNNplroFCCjVpxnRLPwyoJyCS5+vbaNF
 YwBj4bRx4FjSrAcUOhhyXnRYYhSKjyN+KVY7/WQMhdsEXJK+spauBrMzUbvp7j7zqPnH
 xmZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793212784; x=1793817584;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
 b=Wt+0ixG5msgX4oC91Nrjx42kCm6/VqTBwac4ebkuOlvaWz++pMVSvQpAVggUob7M6K
 ie3TZKR89BiSSvaK7TAsAVEe83OZCvxBTTvNrwMw6Lyzk8CNpebYTgG8IF3wenchmT6N
 0VVD7sWnWomIcKmNR9fGet25LP+tD5+QLZaRkdFvy3zlSv41MxcCswxkQzn5gOu8tB1d
 Eo0kfqV3KMg8sFzIf3VBxG66MMMxmicOXgz21JhnZV9IFL1gQ2PbhsLFPelBVtJ56vM2
 n6dkoMNrd0DdZFNfPEFEEHmbuhSETeFOA0dls9oDv9G2lBHCV4tIN+6rLjzk+5uPNmDA
 qVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212784; x=1793817584;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lzWBDFykZYmQVbPs60wnZX1zpllZ/48DYMT9Prys7GQ=;
 b=oOcxEutuq9/v0UiE3mnXT3mYi7wNZUgPPloBCC0wau1mLeKOkMBtPtJ9m+9qIZdGk5
 u13cQcntBpxxUGlVeYrsbMH4TkJ/TxRBrAcMwoSfhXBXlSv2H0bJx7okk2Giq4WD26y4
 g9kTUqiKtJNyhtlJ+Yc9Xc3VrLrFZxKiuwDBSXCVWArb6Z5izqNiHlDEpai2BLAm7ayL
 j215LYTQwadIQd4lQZKm3uffHWmgtAfJ6LJaWceOb2maqTBkj/sJQCsxk7kN87smnHlK
 d73sQtVfKFqGG/L2zafaz0/iJ/rSrmQ2t6iGGpNEsPKUdutTwQCQ/fUrsy5PFxn2wBHe
 BQuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx56+F3Q7iiAvTWUDaxvHOQZoI7uL2ynUNwgRtRIK68DgyLP6z63p3m3eWt9xScKqrqGKaKF6JpbGk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIC0/Gw/x8Fpj8MQt4gDi1OQ/W5VWj1yOkaV+Bd7OcgE6BfsFD8
 ugk9lOpUk+ogghttqvRbetE6SmPjItI+qbH7NSSFZXviKBJAef3SC7/I3xHFYqLFAPmrIFsk1fT
 q3OwHyt3YkaclY07nRWvCA0AE3BgWYjGFLvenHiPYKw==
X-Gm-Gg: AYBFou35Srg8fZvnplbikvzWdRmq4qHgFB8PYdHFhx6zuO8+h+TNcnlceQ11MVwHNSJ
 kqECIRxSqJj/SInqBuA8UjYKwfUCVUYyjo95q+cnbLPxrmIT7+oTQCFCHnryVsVcgKe6xIOiRXy
 5nMWX62FzxnwOiin6r2IgFK4tmF5oIZLtGg2fZu6chkZtXANkbU1lAXv4jzb6nHMrHXTbZ0tkwJ
 Sl5cmPtjW2wUzG02+smisE+1Q2RQ3uKyaLnrrOterkr5nm6Iw5bSFSp9/Rm3xhMnvAWCh1dUwmJ
 6iTrdyVNp/ik9UlVQunnEONf0bY0JyabXvTBjdNCiwohmbe9md82gaRVjbbHiwUsriu+49QrMRL
 YdYYrwswz4fw4ohtrsrH3dKIfLOyec1BTq47bcYqaknbZZwUFa98oR8A/npufnj292mS5PrhmP6
 U20IpwH6BbVC7TmHzI2b/0DoZ0SSKljYQJhImI1FetKDfSS+RlIaP6fq1i8Ujlo8XCE96B1t/ES
 g==
X-Received: by 2002:a05:6870:702b:b0:491:88f1:f3aa with SMTP id
 586e51a60fabf-4a8bb48c1b5mr2356106fac.26.1793212783847; Wed, 28 Oct 2026
 11:39:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026164028.78792-1-lucas.tanure@neat.no>
 <20261026164028.78792-2-lucas.tanure@neat.no>
In-Reply-To: <20261026164028.78792-2-lucas.tanure@neat.no>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 28 Oct 2026 18:39:27 +0000
X-Gm-Features: AclHuK8Od9Fw9YArha1MRLfNbwD9hyqoyIn5oK-539amYVA4Yy6MtEUKuv8b45Q
Message-ID: <CAPY8ntBg==BaznZcnm+zj+GWcooDeo7fW3_WfyAAEes86BNhBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/vc4: hdmi: power down the BCM2712 PHY when the
 output is disabled
To: Lucas Tanure <lucas.tanure@neat.no>
Cc: Maxime Ripard <mripard@kernel.org>, Dom Cobley <popcornmix@gmail.com>, 
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 16:40, Lucas Tanure <lucas.tanure@neat.no> wrote:
>
> From: Dom Cobley <popcornmix@gmail.com>
>
> vc6_hdmi_phy_disable() is empty, so on BCM2712 the PHY keeps its PLL
> and TMDS drivers running after the HDMI output is disabled, until the
> next vc6_hdmi_phy_init(). The TMDS clock is therefore not stopped
> between two mode sets, which the SCDC clock ratio change requires, and
> the idle PHY wastes power.
>
> Reset and power down the PHY on disable, as the BCM2711 variant does.
>
> Fixes: 0b1dbe82e051 ("drm/vc4: hdmi: Add support for BCM2712 HDMI controllers")
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> [lucas.tanure: Rewrote commit message to clarify the issue and fix]
> Signed-off-by: Lucas Tanure <lucas.tanure@neat.no>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi_phy.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> index 56e6a35da357..5040f014bf7e 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi_phy.c
> @@ -1197,4 +1197,9 @@ void vc6_hdmi_phy_init(struct vc4_hdmi *vc4_hdmi,
>
>  void vc6_hdmi_phy_disable(struct vc4_hdmi *vc4_hdmi)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
> +       vc6_hdmi_reset_phy(vc4_hdmi);
> +       spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>  }
> --
> 2.56.0
>
