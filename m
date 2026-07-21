Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DEAC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAB610EA36;
	Tue, 21 Jul 2026 13:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JhDto0ZR";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F03010E34C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784640447; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NJwfsYtV3MIZBekDB/KUatXs8lC+2a+ICO80rGmX8GgQPBVxi0ChhRTYLTbG3l0FjhpFtoPB9NIvTD/fDBTH+krqkkRSJYcK9UyOpcJt+cmMlQQamaGRXRvzgTXWxktfvfolphaTTw/k6MdjAGIBdZP8bg3mGB6DzBK16m/2lvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784640447;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vji0eOH2kOJChsUBQzXd/kLf5aGtxXHg+qKk4ia+R2k=; 
 b=krNfFCZP6tKODtIaNVcQNNfI9KrIjFLImkJoFW+RWj5CU+TBbBwSNd4VOJhZTpEs0GXZwjQtGn0+EGw7Lse2uVG3UX4LwCw2r25eZWjJ7AJ6xVcCuZIOGLqsP6EElzDQsKi16GxXPFC471VBN23vBGCHaOcIUnW7yT8eRnStaQg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784640447; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=vji0eOH2kOJChsUBQzXd/kLf5aGtxXHg+qKk4ia+R2k=;
 b=JhDto0ZRvbtJQjCYNlLmtDLp3e6vDhsCn1ryN2xQ5RKN81SKBvsZ1rd34sLO1CLj
 sLDgEP9/sE42nL5sTE7oDSdbOPQClprNrXAcIZCuIeDvuk4mSgeQmJd01hXJMcAT+bf
 bjNa7tLfYc2uVCeJQZHzW70a9rvL8ku33chJzttw=
Received: by mx.zohomail.com with SMTPS id 1784640446275793.1170840479422;
 Tue, 21 Jul 2026 06:27:26 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 3/5] drm/scdc-helper: Implement parsing and printing
 HDMI 2.1 fields
Date: Tue, 21 Jul 2026 15:27:22 +0200
Message-ID: <7WoIxTIITfip4OFe95yhkA@collabora.com>
In-Reply-To: <20260721091044.237A21F00A3A@smtp.kernel.org>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
 <20260721-scdc-link-health-v7-3-92df1b6ad5fc@collabora.com>
 <20260721091044.237A21F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Tuesday, 21 July 2026 11:10:43 Central European Summer Time sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Incorrect checksum validation range breaks 4-lane FRL error parsing.
> - [High] Redefinition of `SCDC_CH_LOCK_MASK` breaks TMDS lock checking for HDMI 2.0 sinks.
> - [Medium] Stale state leakage for `rs_corrections` across debugfs reads.
> - [Medium] Reserved FRL rates cause debugfs read failures and unreachable dead code.
> - [Medium] Concurrent debugfs reads cause a data race on `priv->state`.
> --
> 
> --- Patch [3]: [PATCH v7 3/5] drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields ---
> commit c31217f1c2c58d659c6532a48bf298ea495b08b1
> Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> drm/scdc-helper: Implement parsing and printing HDMI 2.1 fields
> 
> HDMI 2.1 redefines previously reserved fields in SCDC for various new uses.
> Implement reading and outputting these fields over debugfs.
> 
> > diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
> > index 5871fc101815d..7e17272d52f23 100644
> > --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> > +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
> 
> [ ... ]
> 
> > -static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[3])
> > +static int drm_scdc_parse_error_counters(const u8 scdc[256], u16 counter[4],
> > +					 unsigned int num_lanes)
> >  {
> > +	u8 end_reg;
> >  	u8 sum = 0;
> >  	int i;
> >  
> > -	for (i = SCDC_ERR_DET_0_L; i <= SCDC_ERR_DET_CHECKSUM ; i++)
> > +	switch (num_lanes) {
> > +	case 3:
> > +		end_reg = SCDC_ERR_DET_CHECKSUM;
> > +		break;
> > +	case 4:
> > +		end_reg = SCDC_ERR_DET_3_H;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (i = SCDC_ERR_DET_0_L; i <= end_reg; i++)
> >  		sum = wrapping_add(u8, sum, scdc[i]);
> 
> [Severity: High]
> Does this break the checksum validation for 4-lane FRL links?
> 
> The standard HDMI checksum is designed to sum registers 0x50 through 0x56
> (SCDC_ERR_DET_CHECKSUM) to zero.
> 
> By extending the loop's end_reg to SCDC_ERR_DET_3_H (0x58) for 4-lane mode,
> won't this incorporate non-checksum data into the sum and incorrectly return
> -EPROTO whenever Lane 3 has errors or its valid bit is set?
> 
> [ ... ]
> 
> > @@ -356,11 +423,26 @@ int drm_scdc_read_state(struct drm_connector *connector, struct drm_scdc_state *
> >  
> >  	state->scrambling_detected = buf[SCDC_SCRAMBLER_STATUS] & SCDC_SCRAMBLING_STATUS;
> >  
> > +	state->rate = FIELD_GET(SCDC_FRL_RATE, buf[SCDC_CONFIG_1]);
> > +	num_lanes = drm_scdc_num_frl_lanes(state->rate);
> > +	if (num_lanes < 0)
> > +		return num_lanes;
> 
> [Severity: Medium]
> If a sink reports a reserved FRL rate (between 7 and 15), does this cause
> debugfs reads to fail entirely?
> 
> drm_scdc_num_frl_lanes() returns -EINVAL for these reserved rates, causing
> drm_scdc_read_state() to immediately abort. This makes the reserved rate
> strings in drm_scdc_frl_rate_str() unreachable dead code.
> 
> > +	if (!num_lanes)
> > +		num_lanes = 3;
> > +
> > +	state->ffe_levels = FIELD_GET(SCDC_FFE_LEVELS, buf[SCDC_CONFIG_1]);
> > +
> >  	drm_scdc_parse_status0_flags(buf[SCDC_STATUS_FLAGS_0], &state->stf);
> > -	ret = drm_scdc_parse_error_counters(buf, state->error_count);
> > +	drm_scdc_parse_status1_2_flags(buf[SCDC_STATUS_FLAGS_1],
> > +				       buf[SCDC_STATUS_FLAGS_2], &state->stf);
> > +	ret = drm_scdc_parse_error_counters(buf, state->error_count, num_lanes);
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (num_lanes == 4 && (buf[SCDC_ERR_DET_RS_H] & SCDC_CHANNEL_VALID))
> > +		state->rs_corrections = (buf[SCDC_ERR_DET_RS_H] & ~SCDC_CHANNEL_VALID) << 8 |
> > +					buf[SCDC_ERR_DET_RS_L];
> > +
> >  	return 0;
> >  }
> 
> [Severity: Medium]
> Does this leak stale state across debugfs reads?
> 
> If a 4-lane link transitions to a state where the RS channel valid bit is
> cleared, or if it drops to 3 lanes, the missing else branch here leaves the
> old rs_corrections value intact.
> 
> Since the state struct is reused across reads, could this expose stale
> correction counts to userspace?
> 
> [ ... ]
> 
> > @@ -406,6 +488,8 @@ static int scdc_status_show(struct seq_file *m, void *data)
> >  {
> >  	struct scdc_debugfs_priv *priv = m->private;
> >  	struct drm_scdc_state *st = &priv->state;
> >  	struct drm_connector *connector = priv->connector;
> >  	struct drm_scdc *scdc = &connector->display_info.hdmi.scdc;
> >  	int i, ret;
> >  
> >  	drm_connector_get(connector);
> >  
> >  	if (connector->status != connector_status_connected) {
> >  		ret = -ENODEV;
> >  		goto err_conn_put;
> >  	}
> >  
> >  	if (scdc->supported) {
> >  		ret = drm_scdc_read_state(connector, st);
> 
> [Severity: Medium]
> Can concurrent debugfs reads cause a data race on the shared state structure?
> 
> Multiple threads reading the scdc_status debugfs file share the same private
> context. Calling drm_scdc_read_state() mutates the shared I2C buffer
> (state->scdc) and its bitfields directly without serialization, which could
> corrupt I2C reads and mangle the debugfs output.
> 
> [ ... ]
> 
> > diff --git a/include/drm/display/drm_scdc.h b/include/drm/display/drm_scdc.h
> > index 3d58f37e8ed8e..7f0b05b2f2800 100644
> > --- a/include/drm/display/drm_scdc.h
> > +++ b/include/drm/display/drm_scdc.h
> > @@ -46,14 +48,25 @@
> >  #define SCDC_CONFIG_0 0x30
> >  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
> >  
> > +#define SCDC_CONFIG_1 0x31
> > +#define  SCDC_FRL_RATE   0x0f
> > +#define  SCDC_FFE_LEVELS 0xf0
> > +
> >  #define SCDC_STATUS_FLAGS_0 0x40
> > +#define  SCDC_DSC_FAIL (1 << 7)
> > +#define  SCDC_FLT_READY (1 << 6)
> > +#define  SCDC_LN3_LOCK (1 << 4)
> >  #define  SCDC_CH2_LOCK (1 << 3)
> >  #define  SCDC_CH1_LOCK (1 << 2)
> >  #define  SCDC_CH0_LOCK (1 << 1)
> > -#define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOCK)
> > +#define  SCDC_CH_LOCK_MASK (SCDC_LN3_LOCK | SCDC_CH2_LOCK | SCDC_CH1_LOCK | \
> > +			    SCDC_CH0_LOCK)
> 
> [Severity: High]
> Can this redefinition break TMDS lock checking for HDMI 2.0 sinks?
> 
> Since HDMI 2.0 sinks only have 3 lanes, the SCDC_LN3_LOCK bit will always
> be 0. Existing drivers performing an equality check against this mask
> will systematically fail to detect the lock.
> 
> 

One of those (state race) is already in the previous patch's review,
the rest are all delirious nonsense.



