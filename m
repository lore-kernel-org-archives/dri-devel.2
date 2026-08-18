Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D70EC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA77D10EA24;
	Tue, 18 Aug 2026 07:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmuU9PKw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvCfuhgh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8A710E187
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:56:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I7j0903645081
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/yJPjz/uBLxay3rtKLHC2ceb
 AGVRdladF79WW1q/FmQ=; b=GmuU9PKwU4lq4OIsxVicMdzhauaTyfdkUxLcKU7V
 SfYpeky0W2oauhx1pOMDulxARMjejYtndMFIAfzqnQJ67a2gl8ameSokdp0mlD3S
 ZpYoqtJirlduyvF5j6RVbU5Uv7jPzROnd5eD+N6R8kN8QOv/Hi4Z/wyt233O/OjW
 A3eHjlPvuzne5ir0mas0DJQr5LmPqwTyywGyFcs0GAd6+01ZLNgKRWLH8KRuJap+
 xRYgMVZQ14oCw+y16fvfqde4yOKsaTDXM/6m+1Mzpdo746bFK2Fw78B9a1xRh2Lz
 66ykGvWl6099RiPdqeeiskfcBCn6ge+/Z9Esz9XQFonNgg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ebpsb6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:56:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ddc70b9d5so1220034a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787039815; x=1787644615;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/yJPjz/uBLxay3rtKLHC2cebAGVRdladF79WW1q/FmQ=;
 b=cvCfuhghp5Zx9yNieVHN2/MNQYN4mjLC1z/uOBvLlw6Re1d+fdVJWXlipVfq392YfN
 vI+wwnar4zSRv+w8JmTbeBAK8Kg9oBUsgTKJ2aAGcCiPWdE3KL+6UuQBAhJFxU7rPmJr
 sMhhNv4E4f1QEGMbMOIfxgI8uWr/dBjfgvb04w+7htBY8X1dPOHce1MG7WoBRulrQbUf
 PErWuiXOggM4QecBOrXzfaOyfwjglBZGWRgFh1jvkWNo2xeqB/4pNLusee+lcic3hDF2
 gyc2+i4/Wnsw05qQpKyTLaV6KoW80/O2gJNXnmrr7H/sKu1ghLbHY0HLweUKPo8uaWNT
 Nbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787039815; x=1787644615;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/yJPjz/uBLxay3rtKLHC2cebAGVRdladF79WW1q/FmQ=;
 b=ikSjeY4uk57AZvTDDgmBYvFC+fkkiKn6V7RlsH7lkCy+mOdk4yl5YWhmUMPu80upOn
 t1lZKffM5fMLxsbPrGrOFYpJYtX8/j5u/80m1ZWJaxrb+XE/eHNsmfCHpI7tiJtu+JjD
 Rh4+NWfyrfQ7HA69RrfQs0THf+/+EL1yYxlhwyaiMBPNXWZ+tL7z2lRUHm9pn//cKELn
 3F44JX91FhVAZx3hUESQ0bWhu8F7VqhyU3MmAGsL/BXMfR7zxIm5mIIkIq1i43xpASVn
 Zl5sG9MZ20AQPO1RnlkVfF7aj0xPffP9vEAHI/XEhHumy79sxv7NF5RIHIG+DyR0EU+g
 ryFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5qudwB0dKJfqgGrb/JlnuSrnkx3i2ZvKvYlkHJNRM2Th3IbjGUzWguytEIXaEtPPraY36Q2QojdI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5LA91ctSH7YygJPK9oAi3e5EFTNfkmMluovCIeDo5R9BHhkk7
 HyVr0aDCQxbpgailNz7Dd5mh5QS7mVkI2HsSS4c6LcRTbSt2lRMUiWwU7fUqTsH0DRSzNXJ3HFp
 XBaanC8+3PfquLfELF7Fp7+U/AkwDM4ssFvWClB5ddCAsp1DthFk9hizA8G3IKYp0lZUz/q0=
X-Gm-Gg: AR+sD13ccCXSyR/GJc5ijOMBsGhR05zdtuTrvXbAOBnm3Ro5QpuA5RCVZFbsEdUx5Ii
 k/W/YSIIMwXy/SQpPlXAwcZ1819tO1pOr2s3jH1t85ueg+AvYKXWUjdIKjxQFpLjp5ZCoC+5SUE
 J30qsjCn4ENdz4ZIVpy7FOKMKI9hzdaQ2KFeEseT48W5tiCaWbLlq/sm86eZFqLsbLTSwZ+LroZ
 0v2XjISRLsPyrJwUNmanb8CGPxI0bIDFAjWvbMDiaf8SyENE/pEWkj17Mz1vLhLtiTM/oxWvW/f
 kPtH7ZIqZtIYexWGxspsaiaJmbmSi/boQHwmKgEeIYAr8kHySV21td785y2Cs7oBwFEzvbrh6n8
 47AhGoHMAr9SuInWeEK/IedGLWy4bhoxoLDL+VGspKapikIpKz8/LCQ5MWqanq1JjDoLePp24ev
 ut8dLi8XurTix5dVPDjMgV
X-Received: by 2002:a17:90b:3b42:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-3933baae9c6mr21870104a91.3.1787039815178; 
 Tue, 18 Aug 2026 00:56:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3b42:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-3933baae9c6mr21870050a91.3.1787039814476; 
 Tue, 18 Aug 2026 00:56:54 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531e319fbsm7581743a91.2.2026.08.18.00.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 00:56:52 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:26:43 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH v6 2/2] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <aoQQO4t8RJtPSkXL@hu-vishsain-blr.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
 <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
 <6ff452366cc35b4c97f7d7d4f0fff902095e3d49.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff452366cc35b4c97f7d7d4f0fff902095e3d49.camel@pengutronix.de>
X-Proofpoint-GUID: fTCJsliHjXlrOnlZLPSqRqBVfEGiuBRH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1OCBTYWx0ZWRfX3pOCmq+9zr5Q
 aNP2d4TLE5pEQwV5HYqvKnKF78P6pADSA35T+7nZrS6claSmXZGPszjjOyC9GXIHLESJiThEpBu
 26g0i11d9nwiJvBZEH0ULiE5Pxst+lgoIPLSqDlx74j3VSsVtaMNZIYIqeBNI+lcMSzCDUiec5j
 wu2kWueN/s3c6XAYCuMEc6wIoFpiUPRNJ+T/ASpBr5x4waf6WuH++AKiE6JF1Y/Z4I4GCHMHoup
 gyDBxlWBTUE3w7UzvkRwTNrS6tx5hw3zmjSLASGnZgkCle5BhVn2nyAxurujCUUoL85SzoNV6Fb
 3xZyv8F2IlVxC/7ZTF4QxA079FuDVKJRqV8ZXGuvpEDOS42t6MM7csnYumkfqF1L7TNiaqaIluC
 kurD/H1YRC2cXerReQpo7k6kMazeYjQ4Aiu58mPY3pG61tcI5Hxqx3NYwLDNixSlqjNKxRkt0Ok
 ts7vz+IbozXB57YIVYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1OCBTYWx0ZWRfXze6/lNpeiN0Y
 Tbb79iDN3UqXCbVpgsEbfwUm+f18vb9T9MT0Jfp0+fX7RH7Qz1U+x4WeNvqms4GEwR9p0Z0c17K
 ++jJWBSFJ/idpKdsCHWp/QwHLau+wTI=
X-Authority-Analysis: v=2.4 cv=FsU1OWrq c=1 sm=1 tr=0 ts=6a841048 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pMwecO-EOpg81CO5RMcA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: fTCJsliHjXlrOnlZLPSqRqBVfEGiuBRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180058
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

On Tue, Jul 28, 2026 at 01:01:50PM +0200, Philipp Zabel wrote:
> On So, 2026-07-19 at 21:27 +0530, vishnu.saini@oss.qualcomm.com wrote:
> > From: Yi Zhang <zhanyi@qti.qualcomm.com>
> > 
> > LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
> > Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> > Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
> > bridge configuration by detecting and handling both LT9211 and LT9211C
> > variants from a single driver.
> > 
> > Chip detection in lt9211_read_chipid() is extended to identify the
> > LT9211C by its distinct chip ID registers.
> >
> > A separate regmap configuration is introduced for LT9211C to cover
> > its extended register map. The chip_type field added to struct lt9211
> > selects the appropriate regmap and code paths at probe time using
> > of_device_is_compatible().
> 
> This could be done via device match data instead.
Yes, will use device match data in next revision. 
> 
> [...]
> > The LT9211C requires DSI clocks to be running before the bridge can
> > be initialised,
> 
> Is this different from LT9211?
The chip behavior and register sets are different for LT9211C.

> 
> > so lt9211_atomic_enable() queues
> > a delayed workqueue item for LT9211C rather than initialising
> > synchronously as LT9211 does.
> 
> How does this follow? Isn't the DSI clock already enabled before
> atomic_enable is called?

> If the initialization is deferred to a delayed work item, we can't
> correctly enable downstream LVDS panels that require a few frames of
> valid LVDS signal before enabling the panel or backlight. This must be
> synchronous to work correctly.
I did few experiments to check this again, DSI clock is running before atomic_enable,
But when i make it synchronous autodetect format/width/height is failing.
1. Tried ading more delay upto 5s did not help.
2. Tried adding a dummy drm_hook hw_timing_enabled, which is called after enabling the timing engine
with this synchronous approach is working.
Let me know if we can keep delayed work apprach with some improvements, reduce the delay to minimum and wait in autect_rx for correct nonzero format/width/height ?

> > LT9211C uses VIDEO|LPM DSI mode flags, which differ from the
> > sync-pulse mode used by LT9211.
> > 
> > Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> > Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> > Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> > Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt9211.c | 796 +++++++++++++++++++++++++++++++-
> >  1 file changed, 779 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
> > index f39d83a5ae37..36c004df34fc 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/of_graph.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/workqueue.h>
> >  
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> > @@ -36,10 +37,21 @@
> >  #define REG_CHIPID2				0x8102
> >  #define REG_CHIPID2_VALUE			0xe3
> >  
> > +/* LT9211C chip ID values */
> > +#define REG_CHIPID0_LT9211C_VALUE		0x21
> > +#define REG_CHIPID1_LT9211C_VALUE		0x03
> > +#define REG_CHIPID2_LT9211C_VALUE		0xe1
> > +
> >  #define REG_DSI_LANE				0xd000
> >  /* DSI lane count - 0 means 4 lanes ; 1, 2, 3 means 1, 2, 3 lanes. */
> >  #define REG_DSI_LANE_COUNT(n)			((n) & 3)
> >  
> > +/* Chip type enum */
> > +enum lt9211_chip_type {
> > +	LT9211,
> > +	LT9211C,
> > +};
> > +
> >  struct lt9211 {
> >  	struct drm_bridge		bridge;
> >  	struct device			*dev;
> > @@ -50,6 +62,14 @@ struct lt9211 {
> >  	struct regulator		*vccio;
> >  	bool				lvds_dual_link;
> >  	bool				lvds_dual_link_even_odd_swap;
> > +	/* LT9211C specific fields */
> 
> This isn't LT9211C specific:
Will correct this. 
> > +	enum lt9211_chip_type		chip_type;
> 
> These won't be needed if the delayed work is dropped:
dropping delayed work is not working for LT9211C.

> > +	struct workqueue_struct		*wq;
> > +	struct delayed_work		lt9211_dw;
> > +	struct drm_display_mode		mode;
> > +	bool				bpp24;
> > +	bool				jeida;
> > +	bool				de;
> >  };
> >  
> >  static const struct regmap_range lt9211_rw_ranges[] = {
> > @@ -93,6 +113,49 @@ static const struct regmap_config lt9211_regmap_config = {
> >  	.max_register = 0xda00,
> >  };
> >  
> > +static const struct regmap_range lt9211c_rw_ranges[] = {
> > +	regmap_reg_range(0xff, 0xff),
> > +	regmap_reg_range(0x8100, 0x8182),
> > +	regmap_reg_range(0x8200, 0x82aa),
> > +	regmap_reg_range(0x8500, 0x85ff),
> > +	regmap_reg_range(0x8600, 0x86a0),
> > +	regmap_reg_range(0x8700, 0x8746),
> > +	regmap_reg_range(0xd000, 0xd0a7),
> > +	regmap_reg_range(0xd400, 0xd42c),
> > +	regmap_reg_range(0xd800, 0xd838),
> > +	regmap_reg_range(0xd9c0, 0xd9d5),
> > +};
> > +
> > +static const struct regmap_access_table lt9211c_rw_table = {
> > +	.yes_ranges = lt9211c_rw_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(lt9211c_rw_ranges),
> > +};
> > +
> > +static const struct regmap_range_cfg lt9211c_range = {
> > +	.name = "lt9211c",
> > +	.range_min = 0x0000,
> > +	.range_max = 0xda00,
> > +	.selector_reg = REG_PAGE_CONTROL,
> > +	.selector_mask = 0xff,
> > +	.selector_shift = 0,
> > +	.window_start = 0,
> > +	.window_len = 0x100,
> > +};
> > +
> > +static const struct regmap_config lt9211c_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.rd_table = &lt9211c_rw_table,
> > +	.wr_table = &lt9211c_rw_table,
> > +	.volatile_table = &lt9211c_rw_table,
> > +	.ranges = &lt9211c_range,
> > +	.num_ranges = 1,
> > +	.cache_type = REGCACHE_RBTREE,
> 
> Don't use REGCACHE_RBTREE without a good reason, current default is
> REGCACHE_MAPLE. But... if all RW registers are also marked volatile,
> the cache is useless. So, REGCACHE_NONE?
> Do you know anything about which registers may or may not be volatile?
I don't have this list from vendor but REGCACHE_NONE is also working, will use
REGCACHE_NONE in next revision.

> [...]
> > @@ -454,6 +526,651 @@ static int lt9211_configure_tx(struct lt9211 *ctx, bool jeida,
> >  	return 0;
> >  }
> >  
> > +static int lt9211c_configure_rx(struct lt9211 *ctx)
> > +{
> > +	unsigned int pval;
> > 
> [...]
> > +	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_seq,
> > +				     ARRAY_SIZE(lt9211c_rx_phy_seq));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_reset_seq,
> > +				     ARRAY_SIZE(lt9211c_rx_phy_reset_seq));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_clk_sel_seq,
> > +				     ARRAY_SIZE(lt9211c_rx_clk_sel_seq));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read(ctx->regmap, 0x8180, &pval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0x8180, ((pval & 0xfc) | 0x03));
> > +	if (ret)
> > +		return ret;
> 
> These two are
> 
> 	ret = regmap_write_bits(ctx->regmap, 0x8180, 0x3, 0x3);
> 
> or even
> 
> 	ret = regmap_set_bits(ctx->regmap, 0x8180, 0x3);

Will use regmap_write_bits in next revision. 
> [...]
> > +	ret = regmap_read(ctx->regmap, 0x8530, &pval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0x8530, ((pval & 0xf8) | 0x11));
> > +	if (ret)
> > +		return ret;
> 
> Not masking out bit 0x10 and then setting it is unusual. Was ((pval &
> 0xe8) | 0x11) meant here?
> 
> This corresponds to:
> 
> 	ret = regmap_write_bits(ctx->regmap, 0x8530, 0x17, 0x11);
Will use regmap_write_bits in next revision. 
> > +
> > +	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_input_sel_seq,
> > +				     ARRAY_SIZE(lt9211c_rx_input_sel_seq));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_dig_seq,
> > +				     ARRAY_SIZE(lt9211c_rx_dig_seq));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Give the chip time to lock onto RX stream. */
> > +	msleep(100);
> 
> Is there any status register that could be polled to see if the lock
> happened earlier?
Checked with vendor no status register for this, LT9211 is also using msleep(100);
I will try reducing this delay and poll for correct format/width/height in lt9211c_autodetect_rx.

> > +
> > +	return 0;
> > +}
> > +
> > +static int lt9211c_autodetect_rx(struct lt9211 *ctx,
> > +				 const struct drm_display_mode *mode)
> > +{
> > +	u16 width, height;
> > +	u8 buf[5];
> > +	u8 format;
> > +	u8 sot[8];
> > +	int ret;
> > +
> > +	/* Read the SOT from the chip. */
> > +	ret = regmap_bulk_read(ctx->regmap, 0xd088, sot, sizeof(sot));
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(ctx->dev, "Sot Num = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n", sot[0],
> > +		sot[2], sot[4], sot[6]);
> > +
> > +	dev_dbg(ctx->dev, "Sot Data = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n", sot[1],
> > +		sot[3], sot[5], sot[7]);
> > +	/* HS Settle Set */
> > +	if (sot[0] > 0x10 && sot[0] < 0x50)
> > +		regmap_write(ctx->regmap, 0xd002, sot[0] - 5);
> > +	else
> > +		regmap_write(ctx->regmap, 0xd002, 0x08);
> 
> You could prepare the value then call regmap_write() once.
Yes, will correct this in next revision.
 
> [...]
> > +static int lt9211c_configure_timing(struct lt9211 *ctx,
> > +				    const struct drm_display_mode *mode)
> > +{
> > +	const struct reg_sequence lt9211c_timing[] = {
> > +		{ 0xd00d, (mode->vtotal >> 8) & 0xff },
> > +		{ 0xd00e, mode->vtotal & 0xff },
> > +		{ 0xd00f, (mode->vdisplay >> 8) & 0xff },
> > +		{ 0xd010, mode->vdisplay & 0xff },
> > +		{ 0xd011, (mode->htotal >> 8) & 0xff },
> > +		{ 0xd012, mode->htotal & 0xff },
> > +		{ 0xd013, (mode->hdisplay >> 8) & 0xff },
> > +		{ 0xd014, mode->hdisplay & 0xff },
> > +		{ 0xd015, (mode->vsync_end - mode->vsync_start) & 0xff },
> > +		{ 0xd04c, ((mode->hsync_end - mode->hsync_start) >> 8) & 0xff },
> 
> Apart from 16-bit hsync_len this is identical to
> lt9211_configure_timing, maybe that could be reused.
yes, will reuse lt9211_configure_timing

> > +		{ 0xd016, (mode->hsync_end - mode->hsync_start) & 0xff },
> > +		{ 0xd017, ((mode->vsync_start - mode->vdisplay) >> 8) & 0xff },
> > +		{ 0xd018, (mode->vsync_start - mode->vdisplay) & 0xff },
> > +		{ 0xd019, ((mode->hsync_start - mode->hdisplay) >> 8) & 0xff },
> > +		{ 0xd01a, (mode->hsync_start - mode->hdisplay) & 0xff },
> > +	};
> > +
> > +	return regmap_multi_reg_write(ctx->regmap, lt9211c_timing,
> > +				      ARRAY_SIZE(lt9211c_timing));
> > +}
> > +
> > +static int lt9211c_configure_plls(struct lt9211 *ctx,
> > +				  const struct drm_display_mode *mode)
> > +{
> [...]
> > +	if (mode->clock < 22000) {
> > +		ret = regmap_write(ctx->regmap, 0x822f, 0x07);
> > +		ret |= regmap_write(ctx->regmap, 0x822c, 0x01);
> 
> 0x822c is never cleared in the other branches. Would it be possible to
> enable with a mode clock < 22000 and then disable and enable with a
> mode clock >= 22000 but < 44000, ending up with 0x822c still containing
> 0x01 ?
Will fix this in next revision.
 
> > +		div = 16;
> > +	} else if (mode->clock < 44000) {
> > +		ret = regmap_write(ctx->regmap, 0x822f, 0x07);
> > +		div = 16;
> > +	} else if (mode->clock < 88000) {
> > +		ret = regmap_write(ctx->regmap, 0x822f, 0x06);
> > +		div = 8;
> > +	} else if (mode->clock < 176000) {
> > +		ret = regmap_write(ctx->regmap, 0x822f, 0x05);
> > +		div = 4;
> > +	} else {
> > +		ret = regmap_write(ctx->regmap, 0x822f, 0x04);
> > +		div = 2;
> > +	}
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	pcr_m = (mode->clock * div) / 25;
> > +	pcr_k = pcr_m % 1000;
> > +	pcr_m /= 1000;
> > +
> > +	pcr_up = pcr_m + 1;
> > +	pcr_down = pcr_m - 1;
> > +
> > +	pcr_k <<= 14;
> > +
> > +	ret = regmap_write(ctx->regmap, 0xd008, 0x00);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* 0xd026: pcr_m */
> > +	ret = regmap_write(ctx->regmap, 0xd026, (0x80 | (u8)pcr_m) & 0x7f);
> 
> Why set bit 0x80 only to clear it right away?
will simplify to `(u8)pcr_m & 0x7f)` in the next revision. 

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* 0xd027 0xd028 0xd029: pcr_k */
> > +	ret = regmap_write(ctx->regmap, 0xd027, (pcr_k >> 16) & 0xff);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0xd028, (pcr_k >> 8) & 0xff);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0xd029, pcr_k & 0xff);
> 
> This always writes 0 because of the pcr_k <<= 14 above.
You're right that it's always 0, but this isn't a bug - it's expected given the value ranges.
It's part of one logical 24-bit field. 0xd027:0xd028:0xd029 together encode pcr_k as a single 24-bit fractional value,
so explicitly writing the calculated value.

> [...]
> > +	if (mode->clock < 44000) {
> > +		ret = regmap_write(ctx->regmap, 0xd00c, 0x60);
> > +		ret |= regmap_write(ctx->regmap, 0xd01b, 0x00);
> > +		ret |= regmap_write(ctx->regmap, 0xd01c, 0x60);
> 
> The sashiko bot correctly complained about this. Please fix the error
> handling.
Yes, will fix this in next revision.
 
> > +	} else {
> > +		ret = regmap_write(ctx->regmap, 0xd00c, 0x40);
> > +		ret |= regmap_write(ctx->regmap, 0xd01b, 0x00);
> > +		ret |= regmap_write(ctx->regmap, 0xd01c, 0x40);
> 
> Same as above, you could prepare the 0x60 / 0x40 value in a variable
> and only call one set of regmap_write()s.
yes, will fix this in next revision.
 
> > +	}
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_pcr_reset_seq,
> > +				     ARRAY_SIZE(lt9211c_pcr_reset_seq));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* PCR stability test takes seconds. */
> > +	ret = regmap_read_poll_timeout(ctx->regmap, 0xd087, pval,
> > +				       ((pval & 0x18) == 0x18), 20000, 3000000);
> > +	if (ret)
> > +		dev_err(ctx->dev, "PCR unstable, ret=%i\n", ret);
> > +
> > +	ret = regmap_write(ctx->regmap, 0x8180, 0x51);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0x863f, 0x00);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0x863f, 0x01);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_read_poll_timeout(ctx->regmap, 0x8640, pval,
> > +				       ((pval & 0x01) == 0x01), 50000, 250000);
> > +	if (ret)
> > +		dev_err(ctx->dev, "Video check not stable, ret=%i\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int lt9211c_configure_tx(struct lt9211 *ctx,
> > +				const struct drm_display_mode *mode)
> > +{
> [...]
> > +	ret = regmap_read(ctx->regmap, 0x8530, &pval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(ctx->regmap, 0x8530, ((pval & 0x3f) | 0x40));
> > +	if (ret)
> > +		return ret;
> 
> 	ret = regmap_write_bits(ctx->regmap, 0x8530, 0xc0, 0x40);
yes, will fix this in next revision.

> > +
> > +	/* [7]0:txpll normal work; txpll ref clk sel pix clk */
> > +	ret = regmap_write(ctx->regmap, 0x8230, 0x00);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (ctx->lvds_dual_link)
> > +		phy_clk = (u32)(mode->clock * 7 / 2);
> > +	else
> > +		phy_clk = (u32)(mode->clock * 7);
> > +
> > +	/* 0x8231: prediv sel */
> > +	if (mode->clock < 20000) {
> > +		val = 0x28;
> > +		pre_div = 1;
> 
> Is this case the same as ...
> 
> > +	} else if (mode->clock < 40000) {
> > +		val = 0x28;
> > +		pre_div = 1;
> 
> .. this case on purpose? If so, why not merge the branches.

Yes, will merge the branches in next revision.
 
> > +	} else if (mode->clock < 80000) {
> > +		val = 0x29;
> > +		pre_div = 2;
> > +	} else if (mode->clock < 160000) {
> > +		val = 0x2a;
> > +		pre_div = 4;
> > +	} else if (mode->clock < 320000) {
> > +		val = 0x2b;
> > +		pre_div = 8;
> > +	} else {
> > +		val = 0x2f;
> > +		pre_div = 16;
> > +	}
> > +	ret = regmap_write(ctx->regmap, 0x8231, val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> [...]
> > +
> > +	return 0;
> > +}
> > +
> > +static void lt9211_delayed_work_func(struct work_struct *work)
> > +{
> > +	struct delayed_work *dw = to_delayed_work(work);
> > +	struct lt9211 *ctx = container_of(dw, struct lt9211, lt9211_dw);
> > +	const struct drm_display_mode *mode = &ctx->mode;
> > +	int ret;
> > +
> > +	if (ctx->chip_type != LT9211C) {
> > +		dev_err(ctx->dev, "LT9211: Delayed work called for non-LT9211C chip\n");
> > +		return;
> > +	}
> > +
> > +	ret = lt9211c_configure_rx(ctx);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = lt9211c_autodetect_rx(ctx, mode);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = lt9211c_configure_timing(ctx, mode);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = lt9211c_configure_plls(ctx, mode);
> > +	if (ret)
> > +		return;
> > +
> > +	ret = lt9211c_configure_tx(ctx, mode);
> > +	if (ret)
> > +		return;
> > +}
> > +
> >  static void lt9211_atomic_enable(struct drm_bridge *bridge,
> >  				 struct drm_atomic_commit *state)
> >  {
> > @@ -523,6 +1240,15 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
> >  	if (ret)
> >  		return;
> >  
> > +	if (ctx->chip_type == LT9211C && ctx->wq) {
> > +		drm_mode_copy(&ctx->mode, mode);
> > +		/* LT9211C must enable after mipi clock enable */
> > +		queue_delayed_work(ctx->wq, &ctx->lt9211_dw,
> > +				   msecs_to_jiffies(100));
> 
> Why is this deferred to a delayed work item?
> Can't we just wait here and run all the initialization synchronously?
> 
> As the sashiko bot points out, this calls the delayed work function
> without initializing ctx->jeida, ctx->bpp24 and ctx->de, and both
> atomic_disable and driver remove are missing some kind of
> cancel_delayed_work_sync().
> Further, with the delayed initialization it is impossible to correctly
> enable downstream bridges or panels that require an active LVDS signal
> before (post)enabling.
> All of this wouldn't be a problem if the initialization was done
> synchronously.
WIll correct the uninitialized variabled in next revision but removing delayed work is not working
for this bridge chip as it needs timing engine running.
As mentioned previously i will try improving the delayed work to reduce the delay and poll for correct
format/width/height, if this approach is acceptable.
 
> > +		dev_dbg(ctx->dev, "LT9211C enabled.\n");
> > +		return;
> > +	}
> > +
> >  	ret = lt9211_system_init(ctx);
> >  	if (ret)
> >  		return;
> > @@ -671,11 +1397,6 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
> >  
> >  static int lt9211_host_attach(struct lt9211 *ctx)
> >  {
> > -	const struct mipi_dsi_device_info info = {
> > -		.type = "lt9211",
> > -		.channel = 0,
> > -		.node = NULL,
> > -	};
> >  	struct device *dev = ctx->dev;
> >  	struct device_node *host_node;
> >  	struct device_node *endpoint;
> > @@ -697,7 +1418,22 @@ static int lt9211_host_attach(struct lt9211 *ctx)
> >  	if (dsi_lanes < 0)
> >  		return dsi_lanes;
> >  
> > -	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> > +	if (ctx->chip_type == LT9211C) {
> > +		const struct mipi_dsi_device_info info = {
> > +			.type = "lt9211c",
> > +			.channel = 0,
> > +			.node = NULL,
> > +		};
> 
> Moving mipi_dsi_device_info into device match data would allow to get
> rid of the branching here.
Yes, this will be fixed in next revision.

> > +		dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> > +	} else {
> > +		const struct mipi_dsi_device_info info = {
> > +			.type = "lt9211",
> > +			.channel = 0,
> > +			.node = NULL,
> > +		};
> > +		dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> > +	}
> > +
> >  	if (IS_ERR(dsi))
> >  		return dev_err_probe(dev, PTR_ERR(dsi),
> >  				     "failed to create dsi device\n");
> > @@ -706,10 +1442,16 @@ static int lt9211_host_attach(struct lt9211 *ctx)
> >  
> >  	dsi->lanes = dsi_lanes;
> >  	dsi->format = MIPI_DSI_FMT_RGB888;
> > -	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> > -			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
> > -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> > -			  MIPI_DSI_MODE_NO_EOT_PACKET;
> > +
> > +	if (ctx->chip_type == LT9211C) {
> > +		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
> 
> This could also be stored in device match data.
Yes, will use device match data in next revision.
 
> > +	} else {
> > +		dsi->mode_flags =
> > +			MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> > +			MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
> > +			MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> > +			MIPI_DSI_MODE_NO_EOT_PACKET;
> > +	}
> >  
> >  	ret = devm_mipi_dsi_attach(dev, dsi);
> >  	if (ret < 0) {
> > @@ -747,10 +1489,25 @@ static int lt9211_probe(struct i2c_client *client)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ctx->regmap = devm_regmap_init_i2c(client, &lt9211_regmap_config);
> > +	if (of_device_is_compatible(dev->of_node, "lontium,lt9211c")) {
> > +		ctx->chip_type = LT9211C;
> > +		ctx->regmap =
> > +			devm_regmap_init_i2c(client, &lt9211c_regmap_config);
> 
> The branching here could be avoided by getting regmap config from
> device match data (e.g. via i2c_get_match_data from lt9211_id or
> lt9211_match_table).
Yes, will fix this with i2c_get_match_data
 
> > +	} else {
> > +		ctx->chip_type = LT9211;
> > +		ctx->regmap =
> > +			devm_regmap_init_i2c(client, &lt9211_regmap_config);
> > +	}
> >  	if (IS_ERR(ctx->regmap))
> >  		return PTR_ERR(ctx->regmap);
> >  
> > +	if (ctx->chip_type == LT9211C) {
> > +		ctx->wq = create_workqueue("lt9211_work");
> > +		if (!ctx->wq)
> > +			return -ENOMEM;
> > +		INIT_DELAYED_WORK(&ctx->lt9211_dw, lt9211_delayed_work_func);
> > +	}
> 
> I think this should be dropped.
will be required for delayed work, will drop otherwise.
> > +
> >  	dev_set_drvdata(dev, ctx);
> >  	i2c_set_clientdata(client, ctx);
> 
> Not your addition, but these two calls to the same thing.
> This could be dropped with the lt9211_remove function by
> switching to devm_drm_bridge_add().
yes, this will be fixed in next revision 
> 
> regards
> Philipp
