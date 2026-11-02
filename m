Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA335606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m6qnEhOg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E3510E2FC;
	Mon,  2 Nov 2026 14:02:30 +0000 (UTC)
Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA0E10EE81
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:02:23 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=+GKTSizLrrZQBsZt056y5c/KPEn+gWcclfGVamWBXAE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793628141; v=1; x=1794232941;
 b=m6qnEhOg8/7wJnc/sV3n4A+UeJe0ESULsytD7G8zc8NVwxrKzga8kFA/K/P2ON4987ImgqJG
 0/gSAlRWBTPPdmFDPkKIh/Pybujg+qtO5OVUyl1/N78WwzgQ/5xVWqY/GkTfz/uvEyTib/QJrNU
 /Zc71WzYgOWdoPscP0eABqac=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 308c65e25e6731cd;
 Mon, 02 Nov 2026 14:02:14 +0000
X-Mizu-Trace-ID: 308c65e25e6731cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <5782a7a2-3fb4-4d74-aae9-e1ff0d0d4393@linux.dev>
Date: Mon, 2 Nov 2026 14:02:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] drm/tidss: Add support for AM62P display
 subsystem
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
 <20261029-beagley-ai-display-v4-12-dc7f2b532478@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20261029-beagley-ai-display-v4-12-dc7f2b532478@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tomi,

On 29/10/26 10:18, Tomi Valkeinen wrote:
> From: Swamil Jain <s-jain1@ti.com>
> 
> The DSS controller on TI's AM62P SoC features two instances of the TI
> DSS. Each DSS instance supports two video ports, similar to the DSS
> controller found on the TI AM62X SoC. This allows three independent
> video streams to be supported: OLDI, DPI, and DSI.
> 
> Since the DSS instances on AM62P are architecturally similar to those
> on the AM62X DSS controller, the existing dispc_am625_feats
> configuration can be reused for the AM62P DSS support.
> 
> This commit adds the necessary device tree compatibility entry for
> "ti,am62p-dss" in the tidss driver, pointing to dispc_am625_feats,
> thereby enabling DSS support on AM62P devices.
> 
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

> ---
>  drivers/gpu/drm/tidss/tidss_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 44b0b009c29a..8e3cbfb5ef87 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -240,6 +240,7 @@ static const struct of_device_id tidss_of_table[] = {
>  	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats, },
>  	{ .compatible = "ti,am62a7-dss", .data = &dispc_am62a7_feats, },

On a separate note,

Now that `vp_bus_type` support has been dropped, the only thing
different `dispc_am62a7_feats` has from `dispc_am625_feats` is the
subrev macro.

The DSS in AM62A7 SoC is functionally same with that in AM625 SoC; the
only difference being the absence of both the OLDI TXes in AM62A7.

The dt-bindings enforce that rule.

The only place subrev DISPC_AM625 is used, and subrev DISPC_AM62A7 is
not, is for an OLDI reset done log print.

if (dispc->feat->subrev == DISPC_AM625 ||
    dispc->feat->subrev == DISPC_AM65X)
	dev_dbg(dispc->dev, "OLDI RESETDONE %d,%d,%d\n",
		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(5, 5)),
		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(6, 6)),
		REG_GET(dispc, DSS_SYSSTATUS, GENMASK(7, 7)));

Should we consider some workaround for this print, so that we can
entirely drop `dispc_am62a7_feats`?


--
Regards
Aradhya

