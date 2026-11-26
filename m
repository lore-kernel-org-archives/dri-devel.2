Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C2606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Dyy0d+8F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C3210E3B4;
	Thu, 26 Nov 2026 08:23:33 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C07510E3F9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:23:27 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso3503830a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 00:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795681407; x=1796286207;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mDPiQneaNeUi2efSk5eylep7jPHdMpeW1fG4LwrvlbE=;
 b=Dyy0d+8FG3gB6n7r44BNyhLC4tDNS41xk8sHNi7wIbansQi+Htj7jbV9AYrph2EKAD
 r88sqqGGEKwwiHJlQjflDfks2N4X8S0HF/4o9WIzpk6ryZ6x+A58ophFWeBCJ4CI5kDs
 ZBxJDDMFXeH97gIzxlXmUW/p5/aUsX2qwUfFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795681407; x=1796286207;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mDPiQneaNeUi2efSk5eylep7jPHdMpeW1fG4LwrvlbE=;
 b=wJgGSFofrXKIk7jUHhnhTmVevKUXhjbvGoUdyeTYHNsLo71IWwDcARXrz45Tue2N7r
 hjOVLY984Ujci91zJj16XBXBAt8gbYyVDz6ewr+0U6FfapuT7bG6MkEWqw4uqq4pN7OZ
 +05j4jVNl5ZTbbBsgiQbzSfg3/CLaYjUwGgZKKhbwF52oEyWy4/eHv13APtzYQlJUh+E
 QJfuYJYsH/fWjectIqMuGpQTiedIM3NAN36cyVIE9d72d5QJhT8NHYNEc/UkiqRiYRXH
 pHXBF2S6kq63YMI1xhQAAjiPAkSQn72LvkIHU+3WDjPMAlDijYoIHHiweWGC226vDiHQ
 RnnA==
X-Forwarded-Encrypted: i=1;
 AL+hErF0OfMbmjMsW/8LGigwC6VyBmsGp/PNGc12+4HarkG+XqFO6kAHAtSdjU3VMMFxMJ/un/MatpZvMgM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9+nrT2jy6GbFnUzNO+v5MPruP+I3l0YPh+N5a+6uF+6e34vMY1
 GB+7/yEJLs5CE+QBFvYn0hfPuEY7uWTbOi8TjOJ6jaVM9WNwcdYg2xN2QCvw8GW8NsYS6r1swIp
 zMM0ptA==
X-Gm-Gg: AZFdTZdLWgmoSQpPgwE/PN0uBALvhu1v0o5uGAMljnwsFVwOzurv89AOlQs8joi/80K
 CM6ZcAY9AxKunvoGNTlsqjQHGMqrVJXcKacMNmC3OisHPK8Mj7e/qQwsqZvrAo4JLan1oUzNkua
 AON2bWpAVAzILsOXMUFZReJZUtsx+3O7DqgDb7GM+iIaunpBWj+TkRNTaxtgjOwPTKv6iI8zwti
 82pZcOucUDdBAj1wQYXuaKy1gWJ06Ok18TAQO8BHBEe8h42+/ZJpuYntP5HwBEaCPIAvTFwpm5i
 ZPzA/8O7/Usge+NGdDjxog4V0v7tCkMtAmtR2Mi8CYu5NNjkvuJoiLIsXphdl19ZnFLsnmknFSw
 4xny9CTP74dykOUfMlHOFH+GopHdj5AbQmVqKKmliR/DWvMciaJ5GIm8V8kI+iZIIJFrG2d7wle
 PtOx6sgVS9ogR3yEVbdVgCnDdRR4J9QwSc2Miz6zdNe40AK2Z39QEHkwUJ83j/HR92nw2tummdX
 J3hCdGx4EudwZy+yl7zC8KtFNQq+25LlcEDxBLv5YzIx2tsAcfKsk4AHah46YkUi5xgSNqJnTxD
 +CnyHgl3d1mHsBWPKwtXEejR6LA8jOrPCaXDdhqc1tjvTOVQ8YIeLveQa0LGrDVPl5Q=
X-Received: by 2002:a17:90b:48d1:b0:3b1:832b:bb3d with SMTP id
 98e67ed59e1d1-3b41c9817dfmr18765768a91.57.1795681406793; 
 Thu, 26 Nov 2026 00:23:26 -0800 (PST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com.
 [74.125.82.169]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b4b0f482bdsm15861321a91.14.2026.11.26.00.23.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 00:23:26 -0800 (PST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-3863db981d4so9497485eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 00:23:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEZ+tq/S3xpMXK4xWgoCjKHlx5+bY7KpJH9HGfX4OV1jA5Yeb3wbMXWhRm7QqPY5JeNGk0w6JCF4BY=@lists.freedesktop.org
X-Received: by 2002:a05:7300:a986:b0:386:c6e4:5732 with SMTP id
 5a478bee46e88-386c6e458eamr8946070eec.3.1795681404503; Thu, 26 Nov 2026
 00:23:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-22-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-22-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 16:22:46 +0800
X-Gmail-Original-Message-ID: <CAC=S1njgbFAsOruyi3tPecJTNnSM9xkeLqM6buvrvSTJXv1c-g@mail.gmail.com>
X-Gm-Features: Aa3M54rE91WEZuEtmgUF0iLv3_PtSqqif-lCGzmC6rPCZG5AI3LqYIpHVgEKyRo
Message-ID: <CAC=S1njgbFAsOruyi3tPecJTNnSM9xkeLqM6buvrvSTJXv1c-g@mail.gmail.com>
Subject: Re: [PATCH v2 21/46] soc: mediatek: mtk-mutex: Add new functions to
 add/remove triggers
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Jul 14, 2026 at 7:45=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add new mtk_mutex_add_trigger() and mtk_mutex_remove_trigger() to
> replace, in the near future, their older style equivalents such as
> mtk_mutex_add_comp() and mtk_mutex_remove_comp() for the Display
> Controller related MuteX triggers.
>
> The same functions will be used to also replace the Media Data
> Path 3 (MDP3) specific mtk_mutex_write_mod(), unifying the MuteX
> handling across all of the currently supported multimedia-related
> drivers for MediaTek SoCs.
>
> While at it, this also takes into account the upcoming refactoring
> of mtk_mmsys and mediatek-drm, which are about to migrate to a new
> Component "Type -> Hardware ID" mapping, by adding a new function
> parameter "hw_inst_id" to support that.
>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c       | 60 ++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-mutex.h |  6 +++
>  2 files changed, 66 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-=
mutex.c
> index eb5d381ff5af..ef8e77f7e2f6 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -887,6 +887,65 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_unprepare);
>
> +static enum mtk_mutex_sof_id mtk_mutex_get_sof_trig(enum mtk_ddp_comp_ty=
pe type,
> +                                                   unsigned int hw_inst_=
id)
> +{
> +       switch (type) {
> +       case MTK_DISP_DSI:
> +               return MUTEX_SOF_DSI0 + hw_inst_id;

Unfortunately, DPI / DSI IDs are not continuous in enum
mtk_mutex_sof_id. There are MUTEX_SOF_DPI0 and MUTEX_SOF_DPI1 between
MUTEX_SOF_DSI1 and MUTEX_SOF_DSI2, so this may point to an unrelated
SOF ID, Also, an out-of-range hw_inst_id (if ever possible) can also
map to a wrong SOF ID.
You might need to explicitly enumerate and map each valid (type,
hw_inst_id) pair and return DDP_MUTEX_SOF_MAX otherwise. I don't know
if there are easier way to work around this as reordering
mtk_mutex_sof_id breaks older SoCs.

Regards,
Fei

> +       case MTK_DISP_DPI:
> +               return MUTEX_SOF_DPI0 + hw_inst_id;
> +       case MTK_DISP_DP_INTF:
> +               return MUTEX_SOF_DP_INTF0 + hw_inst_id;
> +       default:
> +               break;
> +       }
> +
> +       return DDP_MUTEX_SOF_MAX;
> +}
