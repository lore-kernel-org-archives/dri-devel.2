Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CC4606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c+HPaTxE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19C310FC3F;
	Wed, 18 Nov 2026 13:46:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E2D10FCB6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795009604; x=1826545604;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=2nnrO4vW63S4GPqF/HfHgssdOyQWdoQo7DzmIusuWfA=;
 b=c+HPaTxEsNoLs28n8g1ouM/f1382um3gFBDANvHcB4zVM7qe4kNp3Cwd
 V0tz0jzY3eeSdpCwOs1EuK1d95B6V0cy7WVeeqMyh+gQOrXhJ5K+MpBoD
 uFaoaoIap+75EytyNVsT8Y84+cwOu0sd1Uv/ZOwZKlKcLLQocIz6TvJeG
 NsVEolmxbyFHgkdMCGf3IkeDcZeyOONJORpqcEduxWFtHb8I/XpwoLizV
 ysLQs4vJpX3BniEkr5zTMxZpjsZ2A32NsW4EoIPDs0gHYd63kLQiBhJsV
 NW9T2MQgOCgl6CzeSvMjC4fxH4C3ADZZB7C8m8Sd0WoqQzWlQgszxCI6g A==;
X-CSE-ConnectionGUID: LDYP9dCcRxm3VXiPiER1Ug==
X-CSE-MsgGUID: 2qoxeuO7SUm+kCky1S/2hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3832562"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3832562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 05:46:43 -0800
X-CSE-ConnectionGUID: +4Irg2mMRy+xLgtdAm7AVg==
X-CSE-MsgGUID: FTsun9RMTbO3UigHOLuUAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10287359"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.187])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 05:46:38 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xin Ji <xji@analogixsemi.com>, Xin Ji
 <anx-upstream@analogixsemi.com.cn>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Bernie Liang <bliang@analogixsemi.com>, Qilin Wen
 <qwen@analogixsemi.com>, "fshao@chromium.org" <fshao@chromium.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/bridge: anx7625: switch to drm_edid_read_custom()
In-Reply-To: <DM6PR04MB697059DAFCE167EB7CAE9B43C77C2@DM6PR04MB6970.namprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261116023740.2257699-1-anx-upstream@analogixsemi.com.cn>
 <d1553faf45c5651feefd667a3decb454fc596415@intel.com>
 <DM6PR04MB697059DAFCE167EB7CAE9B43C77C2@DM6PR04MB6970.namprd04.prod.outlook.com>
Date: Wed, 18 Nov 2026 15:46:36 +0200
Message-ID: <6fab6bf1beef0c38b95f0b3e628237ef2142f5b8@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026, Xin Ji <xji@analogixsemi.com> wrote:
>> > From: Xin Ji <xji@analogixsemi.com>
>> >
>> > Currently, sp_tx_get_edid_block() only reads the base block extension
>> > count at 0x7e and ignores CTA-861 HF-EEODB overrides in block 1. On
>> > displays using HF-EEODB, the driver only reads 2 blocks, which
>> > drm_edid_valid() then rejects due to the size mismatch.
>> > Switch to drm_edid_read_custom() with a per-block read callback so DRM
>> > core handles block count discovery (including HF-EEODB and >4 blocks)
>> > and validation automatically.
>> 
>> Yay!
>> 
>> It warms my heart that the work I put in drm_edid.c to handle HF-EEODB still
>> keeps paying off, and people can enable the complexity of it by
>> *simplifying* the driver code. :)
>
> Yes, thanks! The HF-EEODB handling in drm_edid.c has been very helpful.
> It's great to see it paying off.
>
>> 
>> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
>> > ---
>> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 172 +++++-----------------
>> >  drivers/gpu/drm/bridge/analogix/anx7625.h |   4 -
>> >  2 files changed, 33 insertions(+), 143 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c
>> > b/drivers/gpu/drm/bridge/analogix/anx7625.c
>> > index c3af88e14f8b..eb503be005e0 100644
>> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
>> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
>> > @@ -1022,27 +1022,6 @@ static int sp_tx_aux_rd(struct anx7625_data *ctx,
>> u8 len_cmd)
>> >       return (ret | wait_aux_op_finish(ctx));  }
>> >
>> > -static int sp_tx_get_edid_block(struct anx7625_data *ctx) -{
>> > -     int c = 0;
>> > -     struct device *dev = ctx->dev;
>> > -
>> > -     sp_tx_aux_wr(ctx, 0x7e);
>> > -     sp_tx_aux_rd(ctx, 0x01);
>> > -     c = anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, AP_AUX_BUFF_START);
>> > -     if (c < 0) {
>> > -             DRM_DEV_ERROR(dev, "IO error : access AUX BUFF.\n");
>> > -             return -EIO;
>> > -     }
>> > -
>> > -     DRM_DEV_DEBUG_DRIVER(dev, " EDID Block = %d\n", c + 1);
>> > -
>> > -     if (c > MAX_EDID_BLOCK)
>> > -             c = 1;
>> > -
>> > -     return c;
>> > -}
>> > -
>> >  static int edid_read(struct anx7625_data *ctx,
>> >                    u8 offset, u8 *pblock_buf)  { @@ -1123,18 +1102,16
>> > @@ static int segments_edid_read(struct anx7625_data *ctx,
>> >       return ret;
>> >  }
>> >
>> > -static int sp_tx_edid_read(struct anx7625_data *ctx,
>> > -                        u8 *pedid_blocks_buf)
>> > +static int anx7625_get_edid_block(void *data, u8 *buf, unsigned int
>> > +block, size_t len)
>> >  {
>> > +     struct anx7625_data *ctx = data;
>> >       u8 offset;
>> > -     int edid_pos;
>> > -     int count, blocks_num;
>> > -     u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
>> > -     u8 i, j;
>> > -     int g_edid_break = 0;
>> > -     int ret;
>> > +     int ret, i;
>> >       struct device *dev = ctx->dev;
>> >
>> > +     if (len != EDID_LENGTH || block > 255)
>> > +             return -EINVAL;
>> > +
>> >       /* Address initial */
>> >       ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
>> >                               AP_AUX_ADDR_7_0, 0x50); @@ -1147,85
>> > +1124,18 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
>> >               return -EIO;
>> >       }
>> >
>> > -     blocks_num = sp_tx_get_edid_block(ctx);
>> > -     if (blocks_num < 0)
>> > -             return blocks_num;
>> > -
>> > -     count = 0;
>> > -
>> > -     do {
>> > -             switch (count) {
>> > -             case 0:
>> > -             case 1:
>> > -                     for (i = 0; i < 8; i++) {
>> > -                             offset = (i + count * 8) * MAX_DPCD_BUFFER_SIZE;
>> > -                             g_edid_break = edid_read(ctx, offset,
>> > -                                                      pblock_buf);
>> > -
>> > -                             if (g_edid_break < 0)
>> > -                                     break;
>> > -
>> > -                             memcpy(&pedid_blocks_buf[offset],
>> > -                                    pblock_buf,
>> > -                                    MAX_DPCD_BUFFER_SIZE);
>> > -                     }
>> > -
>> > -                     break;
>> > -             case 2:
>> > -                     offset = 0x00;
>> > -
>> > -                     for (j = 0; j < 8; j++) {
>> > -                             edid_pos = (j + count * 8) *
>> > -                                     MAX_DPCD_BUFFER_SIZE;
>> > -
>> > -                             if (g_edid_break == 1)
>> > -                                     break;
>> > -
>> > -                             ret = segments_edid_read(ctx, count / 2,
>> > -                                                      pblock_buf, offset);
>> > -                             if (ret < 0)
>> > -                                     return ret;
>> > -
>> > -                             memcpy(&pedid_blocks_buf[edid_pos],
>> > -                                    pblock_buf,
>> > -                                    MAX_DPCD_BUFFER_SIZE);
>> > -                             offset = offset + 0x10;
>> > -                     }
>> > -
>> > -                     break;
>> > -             case 3:
>> > -                     offset = 0x80;
>> > -
>> > -                     for (j = 0; j < 8; j++) {
>> > -                             edid_pos = (j + count * 8) *
>> > -                                     MAX_DPCD_BUFFER_SIZE;
>> > -                             if (g_edid_break == 1)
>> > -                                     break;
>> > -
>> > -                             ret = segments_edid_read(ctx, count / 2,
>> > -                                                      pblock_buf, offset);
>> > -                             if (ret < 0)
>> > -                                     return ret;
>> > -
>> > -                             memcpy(&pedid_blocks_buf[edid_pos],
>> > -                                    pblock_buf,
>> > -                                    MAX_DPCD_BUFFER_SIZE);
>> > -                             offset = offset + 0x10;
>> > -                     }
>> > -
>> > -                     break;
>> > -             default:
>> > -                     break;
>> > -             }
>> > -
>> > -             count++;
>> > +     DRM_DEV_DEBUG_DRIVER(dev, "Read EDID block %u, len %zu\n",
>> > + block, len);
>> >
>> > -     } while (blocks_num >= count);
>> > +     for (i = 0; i < len; i += MAX_DPCD_BUFFER_SIZE) {
>> > +             offset = (block & 1) * EDID_LENGTH + i;
>> > +             if (block < 2)
>> > +                     ret = edid_read(ctx, offset, &buf[i]);
>> > +             else
>> > +                     ret = segments_edid_read(ctx, block / 2, &buf[i],
>> > +                                              offset);
>> >
>> > -     /* Check edid data */
>> > -     if (!drm_edid_is_valid((struct edid *)pedid_blocks_buf)) {
>> > -             DRM_DEV_ERROR(dev, "WARNING! edid check fail!\n");
>> > -             return -EINVAL;
>> > +             if (ret < 0)
>> > +                     return -EIO;
>> >       }
>> >
>> >       /* Reset aux channel */
>> > @@ -1235,7 +1145,7 @@ static int sp_tx_edid_read(struct anx7625_data
>> *ctx,
>> >               return ret;
>> >       }
>> >
>> > -     return (blocks_num + 1);
>> > +     return 0;
>> >  }
>> >
>> >  static void anx7625_power_on(struct anx7625_data *ctx) @@ -1958,37
>> > +1868,6 @@ static ssize_t anx7625_aux_transfer(struct drm_dp_aux *aux,
>> >       return ret;
>> >  }
>> >
>> > -static const struct drm_edid *anx7625_edid_read(struct anx7625_data
>> > *ctx) -{
>> > -     struct device *dev = ctx->dev;
>> > -     u8 *edid_buf;
>> > -     int edid_num;
>> > -
>> > -     if (ctx->cached_drm_edid)
>> > -             goto out;
>> > -
>> > -     edid_buf = kmalloc(FOUR_BLOCK_SIZE, GFP_KERNEL);
>> > -     if (!edid_buf)
>> > -             return NULL;
>> > -
>> > -     pm_runtime_get_sync(dev);
>> > -     _anx7625_hpd_polling(ctx, 5000 * 100);
>> > -     edid_num = sp_tx_edid_read(ctx, edid_buf);
>> > -     pm_runtime_put_sync(dev);
>> > -
>> > -     if (edid_num < 1) {
>> > -             DRM_DEV_ERROR(dev, "Fail to read EDID: %d\n", edid_num);
>> > -             kfree(edid_buf);
>> > -             return NULL;
>> > -     }
>> > -
>> > -     ctx->cached_drm_edid = drm_edid_alloc(edid_buf, edid_num *
>> ONE_BLOCK_SIZE);
>> > -     kfree(edid_buf);
>> > -
>> > -out:
>> > -     return drm_edid_dup(ctx->cached_drm_edid);
>> > -}
>> > -
>> >  static enum drm_connector_status anx7625_sink_detect(struct
>> > anx7625_data *ctx)  {
>> >       struct device *dev = ctx->dev;
>> > @@ -2647,10 +2526,25 @@ static const struct drm_edid
>> > *anx7625_bridge_edid_read(struct drm_bridge *bridge  {
>> >       struct anx7625_data *ctx = bridge_to_anx7625(bridge);
>> >       struct device *dev = ctx->dev;
>> > +     const struct drm_edid *drm_edid;
>> >
>> >       DRM_DEV_DEBUG_DRIVER(dev, "drm bridge get edid\n");
>> >
>> > -     return anx7625_edid_read(ctx);
>> > +     if (ctx->cached_drm_edid)
>> > +             return drm_edid_dup(ctx->cached_drm_edid);
>
> The patch will return with drm_edid_dup() if ctx->cached_drm_edid is not null.
>
>> > +
>> > +     pm_runtime_get_sync(dev);
>> > +     _anx7625_hpd_polling(ctx, 5000 * 100);
>> > +     ctx->cached_drm_edid = drm_edid_read_custom(connector,
>> > +                                                 anx7625_get_edid_block,
>> > +                                                 ctx);
>> > +     drm_edid = drm_edid_dup(ctx->cached_drm_edid);
>> 
>> Consider deduplicating?
>
> No need to check it again as the patch checked it before.

Obviously you'd remove the check before. Point is, you'd only have *one*
instance of drm_edid_dup(ctx->cached_drm_edid); and use it on both code
paths.


>
>> 
>>         if (!ctx->cached_drm_edid) {
>>                 // ...
>>                 ctx->cached_drm_edid = drm_edid_read_custom();
>>                 // ...
>>         }
>> 
>>         drm_edid = drm_edid_dup(ctx->cached_drm_edid);
>> 
>> 
>> BR,
>> Jani.
>> 
>> > +     pm_runtime_put_sync(dev);
>> > +
>> > +     if (!drm_edid)
>> > +             DRM_DEV_ERROR(dev, "Fail to read EDID\n");
>> > +
>> > +     return drm_edid;
>> >  }
>> >
>> >  static void anx7625_bridge_hpd_enable(struct drm_bridge *bridge) diff
>> > --git a/drivers/gpu/drm/bridge/analogix/anx7625.h
>> > b/drivers/gpu/drm/bridge/analogix/anx7625.h
>> > index 957d234ec07c..55615ad274f2 100644
>> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
>> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
>> > @@ -424,10 +424,6 @@ enum audio_wd_len {
>> >
>> >  #define MAX_DPCD_BUFFER_SIZE 16
>> >
>> > -#define ONE_BLOCK_SIZE      128
>> > -#define FOUR_BLOCK_SIZE     (128 * 4)
>> > -
>> > -#define MAX_EDID_BLOCK       3
>> >  #define EDID_TRY_CNT 3
>> >  #define SUPPORT_PIXEL_CLOCK  300000
>> 
>> --
>> Jani Nikula, Intel

-- 
Jani Nikula, Intel
