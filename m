Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F310606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VdNM4JMq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB8410F695;
	Tue, 24 Nov 2026 14:45:43 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2755B10F695
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795531535;
 bh=tHoKvhwF6A9T51xIenBUaT/9sNVdCw5DlAXYhy5j/Jg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VdNM4JMq1hqbGTjm3zvuGBEqN1rw1I2PzJOMuy8fKLsiFyo+yhp0z+23IIxxvYMmo
 9Q72OnZE0XYoWs4phW1UwDX3pAMuNmdvLKZ787eP5IuRx0jfl5inKeoZ0B+zazkaOA
 SBQAWWI2hzvlDWAlIwu15W0UK0S/A8akEmqHAWEVxRWJ5SfGIFYmWNAVuJDwcxZ/P4
 0lkpCl5qMxP/p5JaCvoeLBat51+osntHgJa1k0KUE04xznza4gxxj6G9ZN+EbtPlTo
 g5wlSov76Yg/XZa8ya2rPM6jBIixghlVh2gEYsYPufQ58YEUgaHCb+sapzBsMp6e8S
 7YhqhSPfauqCA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F199117E0CA0;
 Tue, 24 Nov 2026 15:45:34 +0100 (CET)
Message-ID: <0e279c15-c76f-4068-834f-84c0895f50c6@collabora.com>
Date: Tue, 24 Nov 2026 15:45:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/46] drm/mediatek: Add support for Display Layer
 Blender component
To: Daniel Stone <daniel@fooishbar.org>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
 <20260714114414.184512-32-angelogioacchino.delregno@collabora.com>
 <CAPj87rMW6c0BMELjn70vsc+mkMxegDbSgQC-8BEDGspFyxzW2Q@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAPj87rMW6c0BMELjn70vsc+mkMxegDbSgQC-8BEDGspFyxzW2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 15:33, Daniel Stone wrote:
> Hi Angelo,
> 
> On Tue, 14 Jul 2026 at 12:46, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>> +#define DISP_REG_OVL_BLD_L0_CLR                        0x20c
>> +#  define OVL_BLD_BGCLR_BLACK                  0xff000000
>> +#  define OVL_BLD_BGCLR_RED                    0xffff0000
> 
> We probably don't need a #define for every ARGB8888 colour tbh. :)
> 
>> +void mtk_blender_config(struct mtk_ddp_comp *comp, unsigned int w,
>> +                            unsigned int h, unsigned int vrefresh,
>> +                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
>> +{
>> +       struct mtk_disp_blender *priv = dev_get_drvdata(comp->dev);
>> +       u32 val;
>> +
>> +       /* Set ROI for this Blender */
>> +       val = ((h & GENMASK(15, 0)) << 16) | (w & GENMASK(15, 0));
>> +       writel(val, priv->regs + DISP_REG_OVL_BLD_ROI_SIZE);
>> +
>> +       /*
>> +        * Set both background color and constant layer color to Opaque Black
>> +        * (ARGB) for eventual Alpha Blending to be effective
>> +        */
>> +       writel(OVL_BLD_BGCLR_BLACK, priv->regs + DISP_REG_OVL_BLD_BGCLR_CLR);
>> +       writel(OVL_BLD_BGCLR_BLACK, priv->regs + DISP_REG_OVL_BLD_L0_CLR);
> 
> Would you believe that this does not in fact need to be black, as it's
> been configurable since 4c684596cde4?
> 

Heh, that's nice - I wrote this code also before the bg color property got
introduced, thanks! :-D

Cheers,
Angelo

