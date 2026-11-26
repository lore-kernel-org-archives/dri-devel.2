Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6E606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=liEwAXni
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2E410E636;
	Thu, 26 Nov 2026 09:18:23 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BE010E636
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:18:17 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cdb628232d2so3788122a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795684697; x=1796289497;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YJ7q/+GsupT2Rad40vkEUvwwqt01kPVk/F4EqfpxWnw=;
 b=liEwAXninr76z8zo+IdxmXVOMFYEmvwYRcocQTm8ZUDMkpPFi1o6mWHKYSEjdaQ/96
 NCi3ritvYEC+UM6SL7F7dNogx3vhuonrA+v3zxAJpL6ypCo64fAXxSQjQUx4kRmSV0Ow
 XMgRNyt0oNaoiXt+8GNXsAnLtGfyb4CHTQ+FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795684697; x=1796289497;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YJ7q/+GsupT2Rad40vkEUvwwqt01kPVk/F4EqfpxWnw=;
 b=ZD9d//iYgepy8F6ySf+EGEHh/cOIPtRWzuohQdupXdqR0WR7noGwQiBtV1SS2LkMIQ
 4j9jAQ/KvZ03PlaJu81ATH4p8Vp8Au1dzE5CMfaRWvmCV1sV+4aCBeA+bH2rwO7Z679x
 BXoYKsmzeuvNm8e29DvMuuTn4mAqapmFJWXjlW1oJQyNK7ysmF0CWkYj9zCoR2wNw7Ic
 LYG1g/z+g4K3cPfaTQ2jpWgWdyq47u1xTdXQLbFafl12oir+Kti+E5s+tsvIzaLxzaS0
 04JgT6dy4pBw38Iy/9vwAH6Hz3sM8u4yUrCCzKEPBqZ17YaB5waEayqG2GUVws//4vO2
 YPXg==
X-Forwarded-Encrypted: i=1;
 AL+hErFPRDdkYvxzswU56K7AVWrIDCPpkeAYmqmnM75BdaizOrVjoNK/nllsahj41k7OhYXlqodbxPWws3Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yU4IgJvqSXSrb8CHjH5i/orHbPcWrfgkNPxiEwvUyX3wZOejf
 TMIsy7cr/7ecqtqVcRqdM28Nt6jXFaquZr8pEA/2rejj0C0HkZ6wQh5cUcGjGYtbyR7ZMFJq/Gj
 7VoZiPw==
X-Gm-Gg: AZFdTZc0U9IcHBL9ffHoUi86+Q0JAHhFjUcf+aLYanNwrrZmVFaviNCRla6oJg5qILJ
 cuCZ54yziKW84qQ8xVo+RKd0BCt8aAeeCuspGYyCbpWPN5GIsZMCPd82ucKrgYXoAT76OGz5Hnv
 jdSqqgXeWW1rfhDfiEGhBCxQMqodt6lo6S7RdbGZO3Uk/j+K22Zg0my+0rvGUJWbHgWtrGyVl9H
 /nxsZIo9Z+QPR05bx0NT9bp89zylFW4BcTi/MMrXLMRCc4MA/su3Qixg/M85+tbT+bBDzZD+jx5
 OFMdJEvf5QGTwd0UUxmInFNz8Jbwvt6DyVRNoKzikoVoxOOTzpW85CbsYtbjzk1FohN5gp0NHVg
 Zf0ZCEaFaNne+4vq1SA2r4HpbiUL6JmAjjEVWRBZO9cDC/a/8cpDe7pkpJk5TRwVi/qrIRYkmcq
 mSzLwdWZFChCwXFVHr/ZFz3OOYQSqvRnMEefHgBZFCiyo0eqD6YJuQcIPlKA/Yc7tB1MbSHYhU2
 zBGDeZ2b1h7xqYd5zfR/ErnOpvFPKh7g97yjWwaO6z4Zb3r0cEvgTvET9MuS0xjY16UPJGaC1Sc
 QJ9WzldfB3mcJ3128TeAziJxllMn5qPhxtOKnZnwspGSr2iuh7Mcr9AYu+eGt2eCJdg=
X-Received: by 2002:a05:6a20:748b:b0:3f8:c7b1:688b with SMTP id
 adf61e73a8af0-4014d4579b7mr22211597637.34.1795684696676; 
 Thu, 26 Nov 2026 01:18:16 -0800 (PST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com.
 [74.125.82.172]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87077fe3fsm10778464b3a.4.2026.11.26.01.18.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 01:18:16 -0800 (PST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-33fb4680717so2092178eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:18:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErFxw6qUSXl69S0rIwo19G07PqInRTJg54Yh7vI8+SFanD403nwzbvpiFDMomFrakbVHsfw9OjxxOMA=@lists.freedesktop.org
X-Received: by 2002:a05:693c:8859:b0:386:b826:3f9 with SMTP id
 5a478bee46e88-386b82605b9mr10045446eec.7.1795684694765; Thu, 26 Nov 2026
 01:18:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-23-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260714114414.184512-23-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Nov 2026 17:17:37 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhLFoHcCCPT8KzfeGR=_FE_-WXXjttWL8N9j5RyXdbdTw@mail.gmail.com>
X-Gm-Features: Aa3M54qPRICfCIh7RUjjGiJ_0TC4b-0YY-WXywPDgZZ0L82ERU6OYtXByrL3V2k
Message-ID: <CAC=S1nhLFoHcCCPT8KzfeGR=_FE_-WXXjttWL8N9j5RyXdbdTw@mail.gmail.com>
Subject: Re: [PATCH v2 22/46] soc: mediatek: mtk-mmsys: Migrate to new
 Multimedia DDP HW indexing
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
> The mediatek-drm driver is ready to switch to the new Multimedia
> Subsystem Display Controller HW indexing.
>
> Perform the switch by:
>  - Adding new "from_comp_inst" and "to_comp_inst" members in the
>    Multimedia Subsystem HW Routes structure (mtk_mmsys_routes);
>  - Changing the MMSYS_ROUTE() macro to use those, which performs
>    the migration of all SoCs in one go (as all of them use this
>    macro to declare their route entries);
>  - Adding new mtk_mmsys_hw_connect() and mtk_mmsys_hw_disconnect()
>    functions, making use of the new HW Component Type-Instance
>    indexing.
>
> Unfortunately, this change needs to go along with the related one
> in the mediatek-drm driver, otherwise functionality of the Display
> Controller will regress.
>
> The only way to make this possible in two steps is to duplicate
> all of the routes structure arrays for all of the SoCs, which
> would result in a total of around ~1200 lines changed twice, and
> that ignores the big increase in size for this driver during the
> migration process so, in order to avoid useless bloat, I opted
> for an inter-dependency between the two changes: mediatek-drm
> and mtk-mmsys.
>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/soc/mediatek/mtk-mmsys.c       | 99 ++++++++++++++++++++------
>  drivers/soc/mediatek/mtk-mmsys.h       | 15 ++--
>  include/linux/soc/mediatek/mtk-mmsys.h | 16 ++---
>  3 files changed, 90 insertions(+), 40 deletions(-)
>
[snip]
> +void mtk_mmsys_hw_connect(struct device *dev,
> +                         enum mtk_ddp_comp_type src_type, u8 src_hw_inst=
_id,
> +                         enum mtk_ddp_comp_type dst_type, u8 dst_hw_inst=
_id)
>  {
>         struct mtk_mmsys *mmsys =3D dev_get_drvdata(dev);
>         const struct mtk_mmsys_routes *routes =3D mmsys->data->routes;
> -       int i;
>
> -       for (i =3D 0; i < mmsys->data->num_routes; i++)
> -               if (cur =3D=3D routes[i].from_comp && next =3D=3D routes[=
i].to_comp)
> -                       mtk_mmsys_update_bits(mmsys, routes[i].addr, rout=
es[i].mask,
> -                                             routes[i].val, NULL);
> +       for (int i =3D 0; i < mmsys->data->num_routes; i++) {
> +               if (src_type !=3D routes[i].from_comp_type ||
> +                   src_hw_inst_id !=3D routes[i].from_comp_inst ||
> +                   dst_type !=3D routes[i].to_comp_type ||
> +                   dst_hw_inst_id !=3D routes[i].to_comp_inst)
> +                       continue;
>
> -       if (mmsys->data->vsync_len)
> -               mtk_mmsys_update_bits(mmsys, MT8188_VDO1_MIXER_VSYNC_LEN,=
 GENMASK(31, 0),
> -                                     mmsys->data->vsync_len, NULL);

The refactor drops this vsync_len register write block, leaving MT8188
VDOSYS1 unconfigured.
Is this intentional? Otherwise please mention it in the commit message.

Regards,
Fei

> +               mtk_mmsys_update_bits(mmsys, routes[i].addr, routes[i].ma=
sk, routes[i].val, NULL);
> +               dev_dbg(dev, "Connected %u-%u to %u-%u\n",
> +                       src_type, src_hw_inst_id, dst_type, dst_hw_inst_i=
d);
> +       }
