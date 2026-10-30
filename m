Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14F606A322
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qWMrOsrQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEA3112700;
	Fri, 30 Oct 2026 10:16:49 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296F510E0FB
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:16:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgvKyHb6Ei/Z+OiKPd/kPj24frDpRo25dpw1FJMQ2iwPIKXPRrm9ACNiLV9hqbfKiL1vnfeqeSSQAegMKRGEO+1p8fBUlX1WAr2hGYlUuGeNVz6yKxNJ/gt4J2aJ1C8WyDCEQ8dM1YPU9MLQ3ch0hmM90oNelPw1e29Jxwv/kuMxhDe3nF0AghNMdhx3NSDiA02WO2awexUYxvWJ8TjbUM66qN5vC+RBGQtyUN0X6HZ01kJf1c0FYLr+1DG8vGedh0BDdKBa2nod7VcPTAGxrY4WXxAftF3BeyQYDUukSoOgeyGqWRiiYvZxocJ9Am35g1uMwHLA0QvS9VomBNt+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKKR4S9AQhJDStSbuwGW0EWdZumlZVGx3b3Yu5Euvig=;
 b=XdnC7oyZoawqZDhqku7mGzBBcguOjufpIm6yNCztT1bjAZCEtwZC08D1nFl3yf8D/0tlPQ14BMA9eYgiR6NZZD81diNZDzM+KTO2glhB/SEh4ZTKbnWqR9LAk9bjHHnEBeYU2glBcbpwRm1mizB4fpZnbCIDlJJutVnnQxk1+1+0mgvFiJCm9kS0AZH+62+hYWQ+d4seSDjTNgQBjnON1L4uObAQ0/lmXnkPZQWEzXuiFYK54sjxvT1p+Kc5p3AuaK+ghQQreHKCkkUX6yzroHDNKDI7Kfc37aLrqdNJIVtbzIAbDwWH0QswSwgHEXlJxqrXS+yXRVxzKKszSTmD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKKR4S9AQhJDStSbuwGW0EWdZumlZVGx3b3Yu5Euvig=;
 b=qWMrOsrQDRxIRB1M7AB2GJJUI9BVoFR8nvi9OblMHvKKGIT2xcjC0/jkoG9xcd2MtjIO1rPLCGVYeyKxjIrEumZ3tKQAamScFl/4Oj2fNwgnv5CoBmTJhfjoiMdNRACT/xwKzcO4umK5U2T3YJJ+h8HELud2OYghHY/gd7uyAm/QQWVsB0y78b5sNsWwyheaiuF76pKfebZ9gDNuIv48En+f1VfK+is9q6mtHWOcZcQL3XfEuR9GXGoglZObmfM0CIUQmnQZrQNDarqeJoc5jIVr1zrk6AGSA4YXq6jVqYlkIlwMqEX0a8v3t+9nslz4Ksy0eDpgPBO6zluZFOvKZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by VI0PR04MB12032.eurprd04.prod.outlook.com
 (2603:10a6:800:311::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:16:38 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 10:16:37 +0000
Date: Fri, 30 Oct 2026 12:16:33 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
Message-ID: <auRsorXM4UQJzoWF@vm>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-2-bcfb28de0aae@oss.nxp.com>
 <179334897994.680709.5849266352850173475.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179334897994.680709.5849266352850173475.b4-review@b4>
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|VI0PR04MB12032:EE_
X-MS-Office365-Filtering-Correlation-Id: 28724186-5cc2-4593-25f6-08df366ee1f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261026130827099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003|261021135927099003|261021130227099003|261022113327099003|261021121427099003|261022115727099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: svlBkGyq0gktqEMXwglYLJEd2zAT4S8N8OHx30T3ocD7m9eT80Ai8ztRuQArHGIx8+d2x0fx7ku3ybSKk7HkyoVWNK/WdlU7bq/qaNqB4mWJp/AxA83oLbKc3mMge4a2kgEow8AiZvN/a9eS4sbBD8MpHMr4k0Q1Cim6ubwmqOlV7E96MN2h0QC0NzfHEO/QpDltwKx4eTYU+RkXz7yuopawlf4artuih2wLM5fbL2Vy6HWUh6kcBA2rQcssQM4ZNjUnSlol3XlLNKd7BNEC+6vWwD6395AXh9j5OleB/c+lsZVlqZt15SyCp1KltoCcYvgxodUhOC0BCZ7+ULbYboey4xou6O7PHNddTcDqn+nD3bBBB2O1Uj9hIpKJ0cgYMu6qSqVPWSNYBATNlspoSesVjAaffNwTihxjGVLUDAThQz80SjSJ+spHTRbSXAU2ic4vTv8J18QFyp/NHVFfvezypvAvpsrcUmX+GuVVCBF2MbioFSurX8vI28A3+9QiAss+qJXTDid3YXRvdy3tdkeMcRByOtd7l9vaCR/LDghm6ffZu02ZgLhyWAu5QL3SDnhFA5enNjVYbbQgtJb6RcclgNFkEg/Q0a9ZN1SiBXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261026130827099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003)(261021135927099003)(261021130227099003)(261022113327099003)(261021121427099003)(261022115727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkQ2BZemnFPd4RGFmY6oRcpMwlFCV3IJnN5vqdFXikWI4LtGCjPJglqWLQVx?=
 =?us-ascii?Q?HBS0BEYtp12PsvBmdPZrDi6mCExfqFFCMeMVDTQyFEWuGkFheQdDAQFUTD/G?=
 =?us-ascii?Q?qhE9TrAGCEP86ic3DPkHUMakOWGtJT/8sSsrNOS/YXwgJu6PHAizpu6rQlIL?=
 =?us-ascii?Q?C+ridy24UVWnnSjXIrx8S1CVrX2D987ukNBBZNZ1Ku0PObBrAbfXBbdzt5Md?=
 =?us-ascii?Q?1dk+4g2Xz+RkD9CxrShevOuHE0KDcm9J8m9V5Ft3gB1AQi5e792JcYTQQbrT?=
 =?us-ascii?Q?PdEuGrNkpRoTtWcr7aGIUSTVt4d5ON2U2fnIWKcIgP78V7oo4o0sVVnmdvY5?=
 =?us-ascii?Q?dhup4NNX2cjPm5dW8sDk4rL2Lu4yh9eMTfh/IR5EIeLJfmHURb65uDWiHm0v?=
 =?us-ascii?Q?DNXtfTZIiX7bzfYb55FP5cAd+JaD+DeJokW3gDtSX22FN9IiQ4cwYRWQw6LE?=
 =?us-ascii?Q?VyXOxs8GWFIKLSYJVWd+IR/1a3gjaxScXuaIayJEw+kJO7NVsg2dXWWdy4UK?=
 =?us-ascii?Q?j7+Llk9n64/K6V/d7pYUfoZlZz0WfWBgHwLJu+BkwyviuXPbldre1uz9T2t8?=
 =?us-ascii?Q?whn7SCUapcOEyDzDwQ3Iyy9xrvwJUZo5URHKOePlVhe3yJ+pa+nDK/WU3E8E?=
 =?us-ascii?Q?5FpTSncUQrEBYB8UGGM53SuGZ7y/kAQHthL/C3EW5jpe5QS5Wj6EN1qVDARm?=
 =?us-ascii?Q?uNy77+khyUEwzU9USDJKRmgBmVhdJGIrJTZfT5MuCmTG7017QxfxCAY/y0HR?=
 =?us-ascii?Q?Ja7s4wgjoNMugcCWL/PRet63xo9Jqt+5qyAy5F+HtMeJ7U2knlVUfaxNXSRc?=
 =?us-ascii?Q?uNnN2UwTTrlcKF7Rmaz66NJPmv8cQx0CXb7b9ZHBAbdtHOvPvr5yCq/TaX+M?=
 =?us-ascii?Q?s8LieEbPKbqgtoBgYXinp7pc9fzpU1A8wDyTjas8WaDEr38J6rPfJbzwo4nr?=
 =?us-ascii?Q?H1db44HsHiW08kpXUsmzWl2xZiCSxrGn5+CTHiQl5UCVsjD43zabk0DVQ+qz?=
 =?us-ascii?Q?fqCVNe2S3XfnJhRhD3OgJTarnUj97PjUj2KulGu9rvbUMsi2XT/cUphvB1sc?=
 =?us-ascii?Q?DPPHe5Tk0Tz1lW1cbc45zOBT5oAyLcitPGPWenTyfJ3yYFjHG7Pl6A40akUL?=
 =?us-ascii?Q?R+7fY1C52CfkvsXMHtHfkaUBi1XjNudi7NvKhpqj1f6FeIgQDwp4wkLt+Wcl?=
 =?us-ascii?Q?aCmniLmQpG0uaGliEqMwNeiUtvZdZwRkICERWsxwz2YAPzLssGntUmWMjrln?=
 =?us-ascii?Q?M7/wvKQxio5LYl3d1OsFtFY7VyHpJAyy0WF5pRKablo5nwaGQbzWkkNI4Gpu?=
 =?us-ascii?Q?3zTyj/By7+JZJ4E7DlObuc9Rrsi9/C2VCv1AlZ9FJOv4zkbiDoJi97CkNT6y?=
 =?us-ascii?Q?3b3fcGmt4FPErO4YhJDYh5pZ4/FvGD6CI/OzXFVbgxBjDyxQgxfrr+vKY+7b?=
 =?us-ascii?Q?Klw59qEYA7DZZCZ0CoWSqA2QouhKQEcU/TK2IUoTvJNB8pEQwGoLBfg/c00Q?=
 =?us-ascii?Q?UsRlxZaDWbeDqF9OafoDHvF7aAp2VVv+gLsBmBZ1azAhayxuJtoweeUTy7Kw?=
 =?us-ascii?Q?XAneBWxrxFV1L/6zeKfigifD6WiM8K07hJXabnywSJ0NxIRT2Of/oZIt6cm6?=
 =?us-ascii?Q?dzwawba+hvFyWIFtioVv+GZq0Lob4bNOxsHCZMPyuuO/w+zRY4+ZLD0l9Cw/?=
 =?us-ascii?Q?Rue+pn9af0fggcBg3USI5d9NxnrLG8tF3FLSatG7ecQdZ48yn8ffFWDdh4j+?=
 =?us-ascii?Q?zTnt34g5IQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28724186-5cc2-4593-25f6-08df366ee1f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:16:37.7081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3WsjzDIIYyL/XM1DLF375O/gNLQcy4Mugo/YLX9mpLpAXKa7DHFZIve31C5lY+2t/9VnXUwW3Rpd6QVYDLhug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12032
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luca,

Thanks for looking over this patch.

On Fri, Oct 30, 2026 at 09:29:39AM +0100, Luca Ceresoli wrote:
> Hello Laurentiu,
> 
> > The next bridge in bridge chain could be a panel bridge or a non-panel
> > bridge.  Use devm_drm_of_get_bridge() to replace the combination
> > function calls of of_drm_find_panel() and devm_drm_panel_bridge_add()
> > to get either a panel bridge or a non-panel bridge, instead of getting
> > a panel bridge only.
> 
> Since commit b7797081ccfe ("drm/panel: embed a drm_bridge into every
> drm_panel") there is no such thing as a panel_bridge. Now every panel just
> embeds a bridge, and there is no reason to use the panel_bridge API. All
> bridges/encoders/whoever needing to interact with "the next component, be
> it a bridge or a panel" should just use the bridge API.
> 
> The old panel_bridge APIs are deprecated [0] and by now they are just
> complicated wrappers to the bridge API.
> 
> I'm addressing the conversion to bridge API and eventual removal of the
> deprecated panel_bridge API as time permits (but pathces would be
> welcome). This driver has already been converted by commit 802372cf316a
> ("drm/bridge: fsl-ldb: don't create a panel_bridge"), so this patch is
> basically not changing anything: it's still getting a pointer to the next
> bridge, but switches to a slightly more complicated implementation.
> 
> So I'd drop this patch.

Agreed

> 
> Still it's good to get rid of the obsolete "panel" wording because now we
> don't interact with a panel aymore, see below.

OK, I'll replace this patch with one addressing your comments below.

> 
> [0] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/Documentation/gpu/todo.rst#remove-panel_bridge-api-functions
> 
> >
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> >
> > diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> > index 7ec84c81cd78..52ae7f5b63c7 100644
> > --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> > +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> > @@ -294,8 +294,8 @@ static const struct drm_bridge_funcs funcs = {
> >  static int fsl_ldb_probe(struct platform_device *pdev)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	struct device_node *panel_node;
> 
> This could be renamed remote_bridge, or next_bridge_node, or the like.
> 
> >  	struct device_node *remote1, *remote2;
> > +	struct drm_bridge *next_bridge;
> >  	struct fsl_ldb *fsl_ldb;
> >  	int dual_link;
> >
> > @@ -318,19 +318,16 @@ static int fsl_ldb_probe(struct platform_device *pdev)
> >  	if (IS_ERR(fsl_ldb->regmap))
> >  		return PTR_ERR(fsl_ldb->regmap);
> >
> > -	/* Locate the remote ports and the panel node */
> > +	/* Locate the remote ports. */
> 
> This is OK.
> 
> >  	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
> >  	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
> >  	fsl_ldb->ch0_enabled = (remote1 != NULL);
> >  	fsl_ldb->ch1_enabled = (remote2 != NULL);
> > -	panel_node = of_node_get(remote1 ? remote1 : remote2);
> 
> I'd leave it as is, it's just less code (and more efficient FWIW)
> than... see below (*)
> 
> >  	of_node_put(remote1);
> >  	of_node_put(remote2);
> >
> > -	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
> > -		of_node_put(panel_node);
> > -		return dev_err_probe(dev, -ENXIO, "No panel node found");
> > -	}
> > +	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
> > +		return dev_err_probe(dev, -ENXIO, "No next bridge node found");
> 
> This can be simplified by using a clenaup action on panel_node (or whatever
> the new name will be), so the of_node_put() would disappear. See for
> example commit 23bc92902edd ("drm/mxsfb/lcdif: simplify ep pointer
> management using __free").
> 
> 
> > @@ -339,10 +336,14 @@ static int fsl_ldb_probe(struct platform_device *pdev)
> >  	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"))
> >  		fsl_ldb->use_termination_resistor = true;
> >
> > -	fsl_ldb->bridge.next_bridge = of_drm_find_and_get_bridge(panel_node);
> > -	of_node_put(panel_node);
> > -	if (!fsl_ldb->bridge.next_bridge)
> > -		return -ENODEV;
> > +	next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node,
> > +						    fsl_ldb->ch0_enabled ? 1 : 2,
> > +						    0);
> 
> (*) ...this code.
> 
> > +	if (IS_ERR(next_bridge))
> > +		return dev_err_probe(dev, PTR_ERR(next_bridge),
> > +				     "failed to get next bridge\n");
> > +
> > +	fsl_ldb->bridge.next_bridge = next_bridge;
> >
> >  	if (fsl_ldb_is_dual(fsl_ldb)) {
> >  		struct device_node *port1, *port2;
> 
> Luca
> 
> -- 
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
Thanks,
Laurentiu
