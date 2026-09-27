Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8771FC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B228010E3DD;
	Sun, 27 Sep 2026 08:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ososcwGZ";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DC210E3DD
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 08:51:54 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260927085153euoutp016c7d835ef129a89304ac235561590cc6~ZIXT3fC3a0064700647euoutp013
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 08:51:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260927085153euoutp016c7d835ef129a89304ac235561590cc6~ZIXT3fC3a0064700647euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790499113;
 bh=TL2WWCHAv5jgtlCzKv1V0I+GLkNMiDKcRehtweoJ4Z8=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=ososcwGZ4xfr/2WYXIdWgJ04YNs2w/oxKN8JIrxSP2NhuW0U6MJnH98VoQs6RAdII
 buPZaQBZbhpAJyRPOv+MjTWIZJI66GP/mEHV8wYK7ifJtO+Nr6Yz+Kdxw8sZgtttLS
 TD2FkrF65rme0ROEVgVLnA7UXseF1oNF4Bbqj+zU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260927085152eucas1p274e0c4d85641cbbc5e727b4b559d21cf~ZIXS8Kxee1311413114eucas1p2N;
 Sun, 27 Sep 2026 08:51:52 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260927085151eusmtip17821e73d4d34df7984d3e446c0c89c58~ZIXSnxm0o3108831088eusmtip1b;
 Sun, 27 Sep 2026 08:51:51 +0000 (GMT)
Message-ID: <9274543d-c569-43a6-888c-9b74d1a8c92a@samsung.com>
Date: Sun, 27 Sep 2026 10:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/bridge: inno-hdmi: reset DDC segment pointer per
 I2C transfer
To: Dominique Belhachemi <domibel@debian.org>, Andy Yan
 <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260528184145.384114-1-domibel@debian.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260927085152eucas1p274e0c4d85641cbbc5e727b4b559d21cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260927085152eucas1p274e0c4d85641cbbc5e727b4b559d21cf
X-EPHeader: CA
X-CMS-RootMailID: 20260927085152eucas1p274e0c4d85641cbbc5e727b4b559d21cf
References: <20260528184145.384114-1-domibel@debian.org>
 <CGME20260927085152eucas1p274e0c4d85641cbbc5e727b4b559d21cf@eucas1p2.samsung.com>
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



On 5/28/26 20:41, Dominique Belhachemi wrote:
> The segment_addr and ddc_addr fields need to be reset per I2C transfer
> to avoid stale values. The reset wasn't required on simple displays with
> only one segment, but modern displays with two or more segments end up
> with corrupt EDIDs.
> 
> This was found on a StarFive VisionFive 2 SBC.
> 
> Signed-off-by: Dominique Belhachemi <domibel@debian.org>
> ---
>  drivers/gpu/drm/bridge/inno-hdmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
> index 5fa533a4eb342..297be02bbd58d 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> @@ -989,6 +989,10 @@ static int inno_hdmi_i2c_xfer(struct i2c_adapter *adap,
>  
>  	mutex_lock(&i2c->lock);
>  
> +	/* Reset segment_addr and ddc_addr at the start of every I2C transfer */
> +	i2c->ddc_addr = 0;
> +	i2c->segment_addr = 0;
> +
>  	/* Clear the EDID interrupt flag and unmute the interrupt */
>  	hdmi_writeb(hdmi, HDMI_INTERRUPT_MASK1, m_INT_EDID_READY);
>  	hdmi_writeb(hdmi, HDMI_INTERRUPT_STATUS1, m_INT_EDID_READY);

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>
