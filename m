Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF215C624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B9D10F423;
	Thu,  3 Sep 2026 07:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="YyXP2J1/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C132C10F2D8
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 17:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9ZKNUAkOCtPoa6XN7dYmsVNWubukspZk1OLPBZiMpr0l4fhZ1UYc9EM8iRlYkKDmqprjPVh6xOHHdSXEmqbnFLcyKLOHLBvXsUlMhtALljT+QHwGFfCWKXwPx9ZFbUbmLvrfYaftIvLYWSL2/TzNw+W9wHomq4JdwzqCpe7vTm5k9e0J+pNsRIycHOSv95fI2IUsD6A4VFgPGyosdDl+VBeEG/FCIjx9u1mRuJicHgOSFORiqETH95pQmB64JDdbT4GWN12vYJefSoboLChgIndHy2YumDQAHsoIujjnhHOrI+vTpjM1DbAY++T5v331R/fs5QE56Ckafut+xW8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2hiFY2hGnNXO1OP9idJ8z5hnLIO6tDBRKKroug1f34=;
 b=Vgb/n4f+4s6Pn8vg7od/EImFGyLpx4Ru8dNscaQTsTLCblIKG9j3DqfRTQ6vhhkhMKK2dmuZxUAQAAsvMlOlx4x1GC7jBWm1jcnc/f1KBG0iy8a5FrhK/W89dhx/VqEmwXseITv0QW0TylKUbCAq6Dpss1IF/vUElnIzsaoW7fLrj9WGUfiMc8M3Nj9e5U8OaXoL4ykUF3AJnTVHxOuw1rIluNE6RjYc2ZZQ9CQ//EExdF+mrKVhHBN41DfzNU/Aq+xGkP/sExR3DbPtm02okkh748owg+q8BIgtlUDBAYuYa2rbqr9BOCP08GOZjlbtBERK18ksT9XMdDffsKltwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2hiFY2hGnNXO1OP9idJ8z5hnLIO6tDBRKKroug1f34=;
 b=YyXP2J1/6eA8LDP9tqcV8PqSUrFugaX6Ic0ggd9EnSPj8P5SB3ENFYR2oCy5jJoFku7nqnNF0mQsvNIiIjKB0Ey4bR6asRkyF5w9Ts4EUGtShazhuMe8oVurpvZ9VLo8ya7147b6pFi2kIiJ5T4Lk1rPJQmB8QLhN+/HtsgdB059AOOlVJh5YjFz04yCHXMUxewO1ucMvufXpXwRlSF5GsXg9sohaa/5sEjoWyUv8d4xFjF8LgCF6tfQZcVwHUxcsPogkncXYJEYAkU54VC0W9wZH0FbQy03xyizCONMOeIwsfO4eu11UKR8MxfgzxQxtbhoaBWOBQRZN63uFr7VmQ==
Received: from BYAPR21CA0028.namprd21.prod.outlook.com (2603:10b6:a03:114::38)
 by DS1PR22MB5827.namprd22.prod.outlook.com (2603:10b6:8:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 17:10:04 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::57) by BYAPR21CA0028.outlook.office365.com
 (2603:10b6:a03:114::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Wed, 2
 Sep 2026 17:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 17:10:03 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 5239919244;
 Wed,  2 Sep 2026 20:09:57 +0300 (EEST)
Date: Wed, 2 Sep 2026 20:09:57 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 20/23] drm: bridge: dw_hdmi: Rework HDP and RXSENSE
 interrupt handling
Message-ID: <aphYZfYAaLsNAR6g@zeus>
References: <20260518180206.2480119-1-jonas@kwiboo.se>
 <20260518180206.2480119-21-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518180206.2480119-21-jonas@kwiboo.se>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|DS1PR22MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff0f557-0438-4810-0669-08df091507c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|6133799003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kzuG2H8LrMGiYI/BkvvqMjocZlvQmUZ7uJrOR5m7HMdG53klFJbfqOj2CXgvx+W4pF1el0QT3zmui/tS2yOzL6xzsV2+B35c01QTp4nC5qkC2HDgBk2C0kIIoyvc3vMA3PcBJ0WqwcpB2quGeWKSK5kLXi3J/K89rz8GfcnRXZYeZV1QH4T1dlzzw1xT1XJJpgfFLuqeTpyE7tZbsHO9EX0MBaPlLnnLYpURrhU5n3hThcvpscyy5b+SBn7nw90ZKP5J3vL/4HtFDUpklOUlD4Ztw7bJuzbpZY73OEZImXC7sOTvgeU7m/s7foDYFsOKvkWbPVL/i3P2CIXkAs1Mx/+IOaIQiLx9ON5ewzPuDAdC2s+0/VWuCvEihk1ec47qmxngDnnPBviElxj/EUmR+qoaR+iG/x0/QMvBJ6eHFb+Hl6waov9vwZVejErCRuJQrUA+YLCfd5sIdBuDZGxAf/lA7zRg02DU/Eb8OND4Krl7LSm4iJfrffrAe5Puwp348NM/g0dx5Ys/VFtIFAXq+KMD0E+lCz7HCz1lmpNou4ChH6dHc5AS2Kbr7xXQFdCrsEgcIHy3fn9BQkOFDXJlgifxh0QsL8yB0HACcr6CyJZeDv0xsCzs6oP8n28l8RRjimEZZVkqrg619homCe6SVh5WzRwuQ1XMWSjIOO3eSOJ8kujmQpfOZzJVnov+mza4iWpgPmRw1HCklsWqqRwQBQ==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wWBitIPqP6RIaN+bbH5FvgMU9o8MVTvGfWZ9tMpX2G33bAKH3ZbcpCNQHIG+4MJXni9rr0a8xC/g4e81/iwoGkczghFOltR3pZdGftekm9yR8Pt82Mpr5fNJTyTNNthvyH/u8HzzB6/vYL3vyeKBXlANJIEl9nBBrEky9RaOqPDQ0+aV7IzutzYGtZgrPMuwqa62MnQCXkAF4F1VGUww3Jc5/kc9L+uqTA36f22n/UXxJnuAtpaCMLx3Y7UbJhjUkokx5Q4v7qU21uzgdau+v6kJzB0QoASxfRMeSiOciXypKcUgoQbpjSy5RI5QqhX9k/RFMvEElydUGe3ds0ddzAxfo1/MelNwUpLnmr++2N589isDY1j5k5vCsbaR6hKeKwOOa5NBGNdh+iGUsHQ4U5faLy8DoUFKkjM9gPw1TsILMmY1huMC+OniFd5SezuA
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 17:10:03.0737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff0f557-0438-4810-0669-08df091507c3
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR22MB5827
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

On Mon, May 18, 2026 at 06:01:56PM +0000, Jonas Karlman wrote:
> The commit aeac23bda87f ("drm: bridge/dw_hdmi: improve HDMI
> enable/disable handling") added use of PHY RXSENSE indications to avoid
> triggering a full enable/disable of the HDMI block when a sink use a HPD
> low voltage level pulse to indicate changes of the EDID.
> 
> HDMI Specification Version 1.4b chapter 8.5 mentions:
> 
>   An HDMI Sink shall indicate any change to the contents of the E-EDID
>   by driving a low voltage level pulse on the Hot Plug Detect pin. This
>   pulse shall be at least 100 msec.
> 
> A delayed work is now used to debounce reacting on a HPD low voltage
> level pulse when a sink changes the EDID. The delayed work triggers a
> hotplug uevent every time the connection status or EDID has changed.
> 
> Remove RXSENSE handling to simplify the HPD interrupt handling and
> instead depend on the delayed work to detect any connection status or
> EDID changes.
> 
> This also ensures the initial HPD interrupt polarity is based on current
> HPD status to avoid an unnecessary interrupt from being triggered
> immediately at probe or resume when a sink is connected.
> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # Rock64, RockPro64, Quartz64-B
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Tested-by: Ian Ray <ian.ray@gehealthcare.com> # i.MX6


> ---
> v7: Remove clear of STAT0_RX_SENSE in dw_hdmi_remove() added in prior
>     patch
> v6: Update commit message,
>     Collect t-b tag
> v5: Add comment about interrupt generation
> v4: New patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 147 ++++------------------
>  1 file changed, 22 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 270db58a0e7c..2e09bff5faf7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -161,11 +161,7 @@ struct dw_hdmi {
>  	struct pinctrl_state *unwedge_state;
>  
>  	struct mutex mutex;		/* for state below */
> -	enum drm_connector_force force;	/* mutex-protected force state */
>  	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
> -	bool disabled;			/* DRM has disabled our bridge */
> -	bool rxsense;			/* rxsense state */
> -	u8 phy_mask;			/* desired phy int mask settings */
>  	u8 mc_clkdis;			/* clock disable register */
>  
>  	spinlock_t audio_lock;
> @@ -196,14 +192,6 @@ const struct dw_hdmi_plat_data *dw_hdmi_to_plat_data(struct dw_hdmi *hdmi)
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_to_plat_data);
>  
> -#define HDMI_IH_PHY_STAT0_RX_SENSE \
> -	(HDMI_IH_PHY_STAT0_RX_SENSE0 | HDMI_IH_PHY_STAT0_RX_SENSE1 | \
> -	 HDMI_IH_PHY_STAT0_RX_SENSE2 | HDMI_IH_PHY_STAT0_RX_SENSE3)
> -
> -#define HDMI_PHY_RX_SENSE \
> -	(HDMI_PHY_RX_SENSE0 | HDMI_PHY_RX_SENSE1 | \
> -	 HDMI_PHY_RX_SENSE2 | HDMI_PHY_RX_SENSE3)
> -
>  static inline void hdmi_writeb(struct dw_hdmi *hdmi, u8 val, int offset)
>  {
>  	regmap_write(hdmi->regm, offset << hdmi->reg_shift, val);
> @@ -1702,36 +1690,25 @@ EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
>  void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>  			    bool force, bool disabled, bool rxsense)
>  {
> -	u8 old_mask = hdmi->phy_mask;
> -
> -	if (force || disabled || !rxsense)
> -		hdmi->phy_mask |= HDMI_PHY_RX_SENSE;
> -	else
> -		hdmi->phy_mask &= ~HDMI_PHY_RX_SENSE;
> -
> -	if (old_mask != hdmi->phy_mask)
> -		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_update_hpd);
>  
>  void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
>  {
>  	/*
> -	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
> -	 * any pending interrupt.
> +	 * Configure the PHY HPD interrupt polarity based on current HPD status
> +	 * and clear any pending interrupt.
>  	 */
> -	hdmi_writeb(hdmi, HDMI_PHY_HPD | HDMI_PHY_RX_SENSE, HDMI_PHY_POL0);
> -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> -		    HDMI_IH_PHY_STAT0);
> +	hdmi_modb(hdmi, hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
> +		  0 : HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
>  
>  	/* Enable cable hot plug irq. */
> -	hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
> +	hdmi_writeb(hdmi, ~HDMI_PHY_HPD, HDMI_PHY_MASK0);
>  
>  	/* Clear and unmute interrupts. */
> -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> -		    HDMI_IH_PHY_STAT0);
> -	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
> -		    HDMI_IH_MUTE_PHY_STAT0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
> +	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_phy_setup_hpd);
>  
> @@ -2395,26 +2372,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>  	}
>  }
>  
> -/*
> - * Adjust the detection of RXSENSE according to whether we have a forced
> - * connection mode enabled, or whether we have been disabled.  There is
> - * no point processing RXSENSE interrupts if we have a forced connection
> - * state, or DRM has us disabled.
> - *
> - * We also disable rxsense interrupts when we think we're disconnected
> - * to avoid floating TDMS signals giving false rxsense interrupts.
> - *
> - * Note: we still need to listen for HPD interrupts even when DRM has us
> - * disabled so that we can detect a connect event.
> - */
> -static void dw_hdmi_update_phy_mask(struct dw_hdmi *hdmi)
> -{
> -	if (hdmi->phy.ops->update_hpd)
> -		hdmi->phy.ops->update_hpd(hdmi, hdmi->phy.data,
> -					  hdmi->force, hdmi->disabled,
> -					  hdmi->rxsense);
> -}
> -
>  static enum drm_connector_status dw_hdmi_detect(struct dw_hdmi *hdmi)
>  {
>  	enum drm_connector_status result;
> @@ -2512,9 +2469,7 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>  	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi, connector);
>  
>  	mutex_lock(&hdmi->mutex);
> -	hdmi->force = connector->force;
>  	hdmi->last_connector_result = connector->status;
> -	dw_hdmi_update_phy_mask(hdmi);
>  	mutex_unlock(&hdmi->mutex);
>  
>  	dw_hdmi_connector_status_update(hdmi, connector, connector->status);
> @@ -2932,10 +2887,8 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>  	struct dw_hdmi *hdmi = bridge->driver_private;
>  
>  	mutex_lock(&hdmi->mutex);
> -	hdmi->disabled = true;
>  	hdmi->curr_conn = NULL;
>  	dw_hdmi_poweroff(hdmi);
> -	dw_hdmi_update_phy_mask(hdmi);
>  	handle_plugged_change(hdmi, false);
>  	mutex_unlock(&hdmi->mutex);
>  }
> @@ -2954,10 +2907,8 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>  	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
>  
>  	mutex_lock(&hdmi->mutex);
> -	hdmi->disabled = false;
>  	hdmi->curr_conn = connector;
>  	dw_hdmi_poweron(hdmi, connector, mode);
> -	dw_hdmi_update_phy_mask(hdmi);
>  	handle_plugged_change(hdmi, true);
>  	mutex_unlock(&hdmi->mutex);
>  }
> @@ -3060,78 +3011,29 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
>  
>  void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>  {
> -	mutex_lock(&hdmi->mutex);
> -
> -	if (!hdmi->force) {
> -		/*
> -		 * If the RX sense status indicates we're disconnected,
> -		 * clear the software rxsense status.
> -		 */
> -		if (!rx_sense)
> -			hdmi->rxsense = false;
> -
> -		/*
> -		 * Only set the software rxsense status when both
> -		 * rxsense and hpd indicates we're connected.
> -		 * This avoids what seems to be bad behaviour in
> -		 * at least iMX6S versions of the phy.
> -		 */
> -		if (hpd)
> -			hdmi->rxsense = true;
> -
> -		dw_hdmi_update_phy_mask(hdmi);
> -	}
> -	mutex_unlock(&hdmi->mutex);
>  }
>  EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
>  
>  static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  {
>  	struct dw_hdmi *hdmi = dev_id;
> -	u8 intr_stat, phy_int_pol, phy_pol_mask, phy_stat;
> -	enum drm_connector_status status = connector_status_unknown;
> -
> -	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
> -	phy_int_pol = hdmi_readb(hdmi, HDMI_PHY_POL0);
> -	phy_stat = hdmi_readb(hdmi, HDMI_PHY_STAT0);
> -
> -	phy_pol_mask = 0;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_HPD)
> -		phy_pol_mask |= HDMI_PHY_HPD;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE0)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE0;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE1)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE1;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE2)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE2;
> -	if (intr_stat & HDMI_IH_PHY_STAT0_RX_SENSE3)
> -		phy_pol_mask |= HDMI_PHY_RX_SENSE3;
> -
> -	if (phy_pol_mask)
> -		hdmi_modb(hdmi, ~phy_int_pol, phy_pol_mask, HDMI_PHY_POL0);
> +	u8 intr_stat;
>  
>  	/*
> -	 * RX sense tells us whether the TDMS transmitters are detecting
> -	 * load - in other words, there's something listening on the
> -	 * other end of the link.  Use this to decide whether we should
> -	 * power on the phy as HPD may be toggled by the sink to merely
> -	 * ask the source to re-read the EDID.
> +	 * Interrupt generation is accomplished in the following way:
> +	 *   interrupt = (mask == 0) && (polarity == status)
> +	 * All interrupts are forwarded to the Interrupt Handler sticky bit
> +	 * register ih_phy_stat0 and muted using the register ih_mute_phy_stat0.
>  	 */
> -	if (intr_stat &
> -	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
> -		dw_hdmi_setup_rx_sense(hdmi,
> -				       phy_stat & HDMI_PHY_HPD,
> -				       phy_stat & HDMI_PHY_RX_SENSE);
> +	intr_stat = hdmi_readb(hdmi, HDMI_IH_PHY_STAT0);
> +	if (intr_stat & HDMI_IH_PHY_STAT0_HPD) {
> +		enum drm_connector_status status;
>  
> -		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
> -		    (phy_stat & HDMI_PHY_HPD))
> -			status = connector_status_connected;
> +		/* Set HPD interrupt polarity based on current HPD status. */
> +		status = dw_hdmi_phy_read_hpd(hdmi, hdmi->phy.data);
> +		hdmi_modb(hdmi, status == connector_status_connected ?
> +			  0 : HDMI_PHY_HPD, HDMI_PHY_HPD, HDMI_PHY_POL0);
>  
> -		if (!(phy_stat & (HDMI_PHY_HPD | HDMI_PHY_RX_SENSE)))
> -			status = connector_status_disconnected;
> -	}
> -
> -	if (status != connector_status_unknown) {
>  		dev_dbg(hdmi->dev, "EVENT=%s\n",
>  			status == connector_status_connected ?
>  			"plugin" : "plugout");
> @@ -3141,8 +3043,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
>  	}
>  
>  	hdmi_writeb(hdmi, intr_stat, HDMI_IH_PHY_STAT0);
> -	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
> -		    HDMI_IH_MUTE_PHY_STAT0);
> +	hdmi_writeb(hdmi, ~HDMI_IH_PHY_STAT0_HPD, HDMI_IH_MUTE_PHY_STAT0);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -3343,9 +3244,6 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  	hdmi->dev = dev;
>  	hdmi->sample_rate = 48000;
>  	hdmi->channels = 2;
> -	hdmi->disabled = true;
> -	hdmi->rxsense = true;
> -	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
>  	hdmi->mc_clkdis = 0x7f;
>  	hdmi->last_connector_result = connector_status_disconnected;
>  
> @@ -3599,8 +3497,7 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
>  	/* Free, mute and clear phy interrupts */
>  	devm_free_irq(hdmi->dev, irq, hdmi);
>  	hdmi_writeb(hdmi, ~0, HDMI_IH_MUTE_PHY_STAT0);
> -	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE,
> -		    HDMI_IH_PHY_STAT0);
> +	hdmi_writeb(hdmi, HDMI_IH_PHY_STAT0_HPD, HDMI_IH_PHY_STAT0);
>  
>  	/* Cancel any pending hot plug work */
>  	cancel_delayed_work_sync(&hdmi->hpd_work);
> -- 
> 2.54.0
> 
