Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2C606A335
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dRUHpYiK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=So4bxGRt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D7010EF76;
	Mon, 23 Nov 2026 16:16:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E80B10EF76
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:15:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKoNU2621950
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J177179CGJ2GQjYr87voPJMa05W6qw1AlhaVh/7GqH0=; b=dRUHpYiKLEzRiPU3
 trSNVZPjlrfOGJYp9Nttmw3OlzxpCyTAQwgTDG3N4OBmaPnodREpP7qY+cWG0PPC
 5MpNr0MwyIQ/dg/AQ4HkfvIOwQp9vynbIq8jFtWW6DFPF2hYbqafXCo90bWy2Qfq
 CSZKzYOfPZOuGrhmoHZb1Njvqwwxgj5biTh0wZ8eoNawHLdwMihdBIIiUPVi30Nd
 Uk5boXCrFWAlAtRGtwr4Lxt1WGideU9mMNTWGf7l5godxwdGgICieDxZqWhaqB2a
 c2yksX3JmMv9nv32y9V6DINFWcJILH8xnp1nOPNm9x8ZWCeqdWsLNcoSpnHH2Xpx
 RI4kKA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1paasp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:15:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3b3fd219d07so2732211a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:15:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795450551; cv=none;
 d=google.com; s=arc-20260327;
 b=ldFPuLgrZTagxMGZPUk0ICFO5ndD4s/hNnui0PgUjc45fuBEE8rst6bG6r4/YUQmjD
 a4cKDW9xN8JIO2t2WgnQu+RR3noVEtVrzXc5A2CKCjp1rEErrgDFTVYIWzB0Pw1yHNOq
 EU7lLtWZGG6x9trQ+SR5yG7Dnbtkci7ru6DEMyPZUHL0aBaQKHhkJGOxdJbxFTVbM5ra
 EWXprHVB1U4ccs4EEtR/2GEuIEqmbTe563gRuyQbVb9PimmnD3YT4gCzAzXfK3b3hORg
 Ud5HYHrVpT1gsFGmwGQA1lFXbOyvnMhAVjehgV9Z7l37oGjkwxmXHtnNTQsfArlWJETJ
 q/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J177179CGJ2GQjYr87voPJMa05W6qw1AlhaVh/7GqH0=;
 fh=GmQ6BgEybayyqEx37odkFxD8wyBhlbrSWhhdd4yWBNo=;
 b=lDYJuJCn098NMiZ0zvpLm4eDKVg2vtKRb0kPBY0iXRdTOhXNafxKh3PLyMkBw0JAY/
 wFIakE3p5n5TLtWfh78aJLJV8sgngA5/ZDbFFHMTtyCcGOSfGla7oUmmFn2JgVUgK9uA
 X5BReYJhmhb/4r6ZuJGd4XpWiuZAxxLFMZCXJUCCaI7BpKEIvLdfFLWgmRC7Np5+2gwd
 tpq9zZkEA7ne2j9pnh65rodz4ObqS9iNQZzU8Fh4Qqybl/2EBCh5YRexDinJwr5189Bi
 yofeMUGKopCa+C2HNNd9NZLCLfgX9slAkDiklvB/i2DUWA934EuTGysp7GHcGAYv8Iwi
 fpnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795450551; x=1796055351;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J177179CGJ2GQjYr87voPJMa05W6qw1AlhaVh/7GqH0=;
 b=So4bxGRto7+9RrLZVB4qtMQlwhMoGU3ynboh4ZDyJ3hcp6NjpPM3GkJMW176oaUibR
 i65B7rJYlWZRqDfGxLv53+8WqbwBqykNhKKLskTQCDt9zi4nNH1ODs1f6fQkkPv82uCv
 C9SEYre2SYlU2NVitgSEQSfMxH0rYVlit+1ikl6+9T+mOQ6MNPE1+9DPobyO+BW1g2iK
 WXQPHuTMklMybKzKVzdngY23dnjsq9rh2AF7OGMF3J1KN9vlNgjiQjOe+hWaQevhzf60
 jforkgY/kH+qBOxI3M5DlzXFb+5kZQIhO/FdWmgjVlA3OchatElH0saEj2a3Vc0QtPcU
 0kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450551; x=1796055351;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J177179CGJ2GQjYr87voPJMa05W6qw1AlhaVh/7GqH0=;
 b=ioT13mhVgQJhVZVIC5QvMbnsrfDorU5IbiMTFjMqfHBZ2Ski1LO42w9gLDSG1XhvLm
 WWEGEx/7N8cpzJdDnu0BDuvvIiiXdlEho1DBDdePekY2X8wRbtk+nWDFlzf+/tj/PhYK
 wsUNX7ztZ8VQCocaeyxRsr8R+EfjMgHW+BP/RLCpSkDevX23Fasj2LR+BLulzXok4ZJg
 wTph8IfnPX1ssSwzHCLS7tufdHonhCE4NLYK8jkPhQxSVSv+RHaygUl+j7PqXnmHSrOb
 vbXNZ1fvVIieYDcEfuPr2R8Mti86yj4g756dxcnnB0bOQxzx9Lb1jzvyUIpi5Bvfm8LV
 NMtg==
X-Forwarded-Encrypted: i=1;
 AL+hErFlnfWZrVMKnohGKY0u4UqyGBCHGzQYKOPBQa+sQy4ErygZpll41pjUiTdbgYw/oYp0juf7eWpkoPM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Bf72D4GKtD8tnVz8UO41HWd7FPJNpVtzbIda/1ra/TUz8Ytxt
 znSwxhDfTXDVUEymcrsTAwS+1oHzl9dGfvhO5Ong9H020shxuyWto8lYaT1giBxWRSU+IH3em1a
 1Ja9V8CMM+KikBE07obdwvFH4LWcI7r+4ooj1jYKMzvkts4man+jNPsKAJ3HTAgsnWmELLU5OTQ
 H9QYqVRotgcTdpGPZxtFY3XcmaA+3Wvr7hDIDlLn2fIX4RzA==
X-Gm-Gg: AZFdTZcLiY9u+G2gFzT3W2UB3R/Q5XncXEwevafR5hkhTC7BTujVdS3mRG4HCNmV57R
 BYYnmBnHUzmdqJO8oUQtX3f2tn0tGa7Qq7vHFTOQLPnQMOnjQ9vPMprMOqNjSR8U5HnilX6VZhF
 Xt2TS9wPpcdEpH/6yhFmVNTScLVpDjJAe0FBfm1gtULjldIn2zzN440a247w2VYThQOFRyQh75G
 nqfVLxQ/+m1xgpZ
X-Received: by 2002:a17:90b:240f:b0:3b4:ab19:ae09 with SMTP id
 98e67ed59e1d1-3b4ab19af51mr1206243a91.52.1795450550805; 
 Mon, 23 Nov 2026 08:15:50 -0800 (PST)
X-Received: by 2002:a17:90b:240f:b0:3b4:ab19:ae09 with SMTP id
 98e67ed59e1d1-3b4ab19af51mr1206202a91.52.1795450549917; Mon, 23 Nov 2026
 08:15:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
In-Reply-To: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 17:15:37 +0100
X-Gm-Features: Aa3M54pI-nMqrQifP2PTTNFuHdzLxGSvIuSxp9oUL80BWWv_Lu9z1icInvkp32E
Message-ID: <CAPx+jO_w6-y82_5+DTLxb6dtiNv2KNMYLKpRJU0nLRLvy5-adg@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Use power domain for display power
To: Linus Walleij <linusw@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: CuzgRiAky8gd9HB-IJvkjj2TpD6EtNec
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b0466b7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=Q-y6Duihw73N38jVMmsA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX30l9fH3A/YXu
 Q40+IQmfQmDbSD7+aZvGdlpngNbz2BOf63+vMIcnNxwXiz0MZmH0SJsmlMh9NcZpc7g9/rgZ31P
 1w4doy1DeM0l54esOr9xiGwjwylpazI=
X-Proofpoint-ORIG-GUID: CuzgRiAky8gd9HB-IJvkjj2TpD6EtNec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX2/2Qc9FzjdIh
 Vt87HIRqCxTCqyM/3MLHdW/24RVGMghEA2KSuk7H6QNqog6SIrJUPoT53ePuhdKLo05UhLavraN
 JGqpWUENT0Ab4WMfYthLizWWi0lDIP0RHHgMzTVI9HbTOG2x3SMcbliM8f8MBfiRFfy9a/xOuUW
 a/LZmVvVxGiLvZFMamidxJQslMijH5nCajLu2bfWY0lS7kPlV4AacPONtv9uPmZKBZWUn59LWvo
 y16F2Y8ZLTdnknAQ8pD462oAjpv1+jrZKIajhrpuD3rSMd4p+qCgjoSbwMgs0bM70Z6KRLHngdn
 gnO0vS21MHePyMzGnZ6152QAu3ez9dgC6wtsw1zwUNvuf4dcoUofcgvZHi/Wv4SVNGt6mGWgYln
 FM/QybusoT2Mgl523B6wRGOs8+PRASFzFwlxmemKM2XIqxq5Wz135IJCYK4ZDMTV8Dz4O7Y4zh5
 LBGTG6CbTXxGF5Lw6Ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230064
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

On Sun, Nov 15, 2026 at 7:10=E2=80=AFPM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Replace explicit EPOD regulator handling with runtime PM, including the
> power cycle used to reset the display hardware. Treat only negative
> pm_runtime_put_sync_suspend() return values as errors.
>
> Keep the separate VANA regulator enabled while the driver is bound:
> the AB8500 CSI/DSI analog supply is not controlled by the MCDE power
> domain. Preserve its probe failure and removal cleanup.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
> The Ux500 genpd prerequisites have been merged into the powerdomain tree.
> Please take this conversion through DRM; the companion bindings and DTS
> changes will be submitted separately.
> ---
>  drivers/gpu/drm/mcde/mcde_clk_div.c |  4 +--
>  drivers/gpu/drm/mcde/mcde_display.c | 13 ++++-----
>  drivers/gpu/drm/mcde/mcde_drm.h     |  1 -
>  drivers/gpu/drm/mcde/mcde_drv.c     | 56 +++++++++++++++++--------------=
------
>  drivers/gpu/drm/mcde/mcde_dsi.c     |  1 -
>  5 files changed, 33 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/mcde/mcde_clk_div.c b/drivers/gpu/drm/mcde/m=
cde_clk_div.c
> index 8c5af2677357..1a22e6233946 100644
> --- a/drivers/gpu/drm/mcde/mcde_clk_div.c
> +++ b/drivers/gpu/drm/mcde/mcde_clk_div.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
>
>  #include "mcde_drm.h"
>  #include "mcde_display_regs.h"
> @@ -95,7 +95,7 @@ static unsigned long mcde_clk_div_recalc_rate(struct cl=
k_hw *hw,
>          * It will come up with 0 in the divider register bits, which
>          * means "divide by 2".
>          */
> -       if (!regulator_is_enabled(mcde->epod))
> +       if (!pm_runtime_active(mcde->dev))
>                 return DIV_ROUND_UP_ULL(prate, 2);
>
>         cr =3D readl(mcde->regs + cdiv->cr);
> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/m=
cde_display.c
> index 281f5b3274bd..57305fdbcdcc 100644
> --- a/drivers/gpu/drm/mcde/mcde_display.c
> +++ b/drivers/gpu/drm/mcde/mcde_display.c
> @@ -7,7 +7,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-buf.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/media-bus-format.h>
>
>  #include <drm/drm_atomic_helper.h>
> @@ -1187,16 +1187,15 @@ static void mcde_crtc_helper_atomic_enable(struct=
 drm_crtc *crtc,
>         int ret;
>
>         /* This powers up the entire MCDE block and the DSI hardware */
> -       ret =3D regulator_enable(mcde->epod);
> +       ret =3D pm_runtime_resume_and_get(mcde->dev);
>         if (ret) {
> -               dev_err(drm->dev, "can't re-enable EPOD regulator\n");
> +               dev_err(drm->dev, "can't enable MCDE power domain\n");
>                 return;
>         }

Neither regulator_enable() or pm_runtime_resume_and_get() (unless
marked irq_safe) are supposed to be called from atomic context.

Isn't mcde_crtc_helper_atomic_enable() called from atomic context?

That said, converting to pm_runtime_resume_and_get() doesn't makes
this any worse.

>
>         dev_info(drm->dev, "enable MCDE, %d x %d format %p4cc\n",
>                  mode->hdisplay, mode->vdisplay, &format);
>
> -
>         /* Clear any pending interrupts */
>         mcde_display_disable_irqs(mcde);
>         writel(0, mcde->regs + MCDE_IMSCERR);
> @@ -1347,9 +1346,9 @@ static void mcde_crtc_helper_atomic_disable(struct =
drm_crtc *crtc,
>                 spin_unlock_irq(&crtc->dev->event_lock);
>         }
>
> -       ret =3D regulator_disable(mcde->epod);
> -       if (ret)
> -               dev_err(drm->dev, "can't disable EPOD regulator\n");
> +       ret =3D pm_runtime_put_sync_suspend(mcde->dev);
> +       if (ret < 0)
> +               dev_err(drm->dev, "can't disable MCDE power domain\n");

I suppose this is kind of equivalent with the error handling to
regulator_disable(). So I would argue that that this is okay for now.

However, even if pm_runtime_put_sync_suspend() doesn't return an error
code, there is no guarantee that the corresponding PM domain (managed
by genpd) actually gets turned off. What we probably want instead is
to is to get a notification from genpd to let us know when this has
happened.
See dev_pm_genpd_add_notifier().

>         /* Make sure we are powered down (before we may power up again) *=
/
>         usleep_range(50000, 70000);
>
> diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_=
drm.h
> index edbb4580a7d8..296edf9ebef4 100644
> --- a/drivers/gpu/drm/mcde/mcde_drm.h
> +++ b/drivers/gpu/drm/mcde/mcde_drm.h
> @@ -93,7 +93,6 @@ struct mcde {
>         /* Locks the MCDE FIFO control register A and B */
>         spinlock_t fifo_crx1_lock;
>
> -       struct regulator *epod;
>         struct regulator *vana;
>  };
>
> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_=
drv.c
> index 759e279b645a..af26ac5a4455 100644
> --- a/drivers/gpu/drm/mcde/mcde_drv.c
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c
> @@ -61,6 +61,7 @@
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> @@ -283,33 +284,26 @@ static int mcde_probe(struct platform_device *pdev)
>         mcde->dev =3D dev;
>         platform_set_drvdata(pdev, drm);
>
> -       /* First obtain and turn on the main power */
> -       mcde->epod =3D devm_regulator_get(dev, "epod");
> -       if (IS_ERR(mcde->epod)) {
> -               ret =3D PTR_ERR(mcde->epod);
> -               dev_err(dev, "can't get EPOD regulator\n");
> -               return ret;
> -       }
> -       ret =3D regulator_enable(mcde->epod);
> +       pm_runtime_enable(dev);
> +       ret =3D pm_runtime_resume_and_get(dev);
>         if (ret) {
> -               dev_err(dev, "can't enable EPOD regulator\n");
> +               dev_err(dev, "can't enable MCDE power domain\n");
> +               pm_runtime_disable(dev);
>                 return ret;
>         }
> +
> +       /* The CSI/DSI analog supply is separate from the MCDE power doma=
in. */
>         mcde->vana =3D devm_regulator_get(dev, "vana");
>         if (IS_ERR(mcde->vana)) {
>                 ret =3D PTR_ERR(mcde->vana);
>                 dev_err(dev, "can't get VANA regulator\n");
> -               goto regulator_epod_off;
> +               goto pm_runtime_put;
>         }
>         ret =3D regulator_enable(mcde->vana);
>         if (ret) {
>                 dev_err(dev, "can't enable VANA regulator\n");
> -               goto regulator_epod_off;
> +               goto pm_runtime_put;
>         }
> -       /*
> -        * The vendor code uses ESRAM (onchip RAM) and need to activate
> -        * the v-esram34 regulator, but we don't use that yet
> -        */
>
>         /* Clock the silicon so we can access the registers */
>         mcde->mcde_clk =3D devm_clk_get(dev, "mcde");
> @@ -412,14 +406,15 @@ static int mcde_probe(struct platform_device *pdev)
>
>         /*
>          * Perform an invasive reset of the MCDE and all blocks by
> -        * cutting the power to the subsystem, then bring it back up
> +        * powering down the subsystem, then bring it back up
>          * later when we enable the display as a result of
>          * component_master_add_with_match().
>          */
> -       ret =3D regulator_disable(mcde->epod);
> -       if (ret) {
> -               dev_err(dev, "can't disable EPOD regulator\n");
> -               return ret;
> +       ret =3D pm_runtime_put_sync_suspend(dev);
> +       if (ret < 0) {
> +               dev_err(dev, "can't disable MCDE power domain\n");
> +               pm_runtime_get_noresume(dev);
> +               goto clk_disable;
>         }
>         /* Wait 50 ms so we are sure we cut the power */
>         usleep_range(50000, 70000);
> @@ -428,13 +423,7 @@ static int mcde_probe(struct platform_device *pdev)
>                                               match);
>         if (ret) {
>                 dev_err(dev, "failed to add component master\n");
> -               /*
> -                * The EPOD regulator is already disabled at this point s=
o some
> -                * special errorpath code is needed
> -                */
> -               clk_disable_unprepare(mcde->mcde_clk);
> -               regulator_disable(mcde->vana);
> -               return ret;
> +               goto clk_disable_pm_disabled;
>         }
>
>         return 0;
> @@ -443,10 +432,15 @@ static int mcde_probe(struct platform_device *pdev)
>         clk_disable_unprepare(mcde->mcde_clk);
>  regulator_off:
>         regulator_disable(mcde->vana);
> -regulator_epod_off:
> -       regulator_disable(mcde->epod);
> +pm_runtime_put:
> +       pm_runtime_put_sync_suspend(dev);
> +       goto pm_runtime_disable;
> +clk_disable_pm_disabled:
> +       clk_disable_unprepare(mcde->mcde_clk);
> +       regulator_disable(mcde->vana);
> +pm_runtime_disable:
> +       pm_runtime_disable(dev);
>         return ret;
> -
>  }
>
>  static void mcde_remove(struct platform_device *pdev)
> @@ -457,7 +451,7 @@ static void mcde_remove(struct platform_device *pdev)
>         component_master_del(&pdev->dev, &mcde_drm_comp_ops);
>         clk_disable_unprepare(mcde->mcde_clk);
>         regulator_disable(mcde->vana);
> -       regulator_disable(mcde->epod);
> +       pm_runtime_disable(&pdev->dev);
>  }
>
>  static void mcde_shutdown(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_=
dsi.c
> index daac8d67913d..86ae23894cda 100644
> --- a/drivers/gpu/drm/mcde/mcde_dsi.c
> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
> @@ -8,7 +8,6 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> -#include <linux/regulator/consumer.h>
>  #include <video/mipi_display.h>
>
>  #include <drm/drm_atomic_state_helper.h>
>
> ---
> base-commit: 9ae477db090b44816741fd9c49a3c459fc7d407b
> change-id: 20261115-ux500-drm-mcde-powerdomain-8a8d9d4c5a44
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>

Even with the comments above, feel free to add:

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe
