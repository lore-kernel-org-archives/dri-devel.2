Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AE3FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C64210E77D;
	Mon, 27 Apr 2026 14:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t4EhuuiI";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013025.outbound.protection.outlook.com
 [40.107.162.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 492C010E77D
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cnkdpy15VYQc5LuG9RKR0mQa/GyZoqeupn96cOxoz0l7HvDQNsdq9TRPiUW3X54m9s5CYFJJNgbA1F6L/k8IhvSZL61JOBN4w69p9JuYOr2qJjGoiNYqnJj5qn8SdLBikmRdfp8IExOe6Wa4Yl5/hTkr8vIplZAy3gwAyfqgB8YprDk1NRr4IJ1jKDTi4Cx9k08ZEMkdrYrXBhg/H4ZziXGny0A3bDrLU6Q1wbg28l2vItQxheKt3jkXRPNezbiEyuTO4+8VDfyuD/eRR9N8YT5L6PeCRZr7jePDr2PAki0ijbp9ntfB+eYXIRnJXoyVCJkwjFeO1SnjRadqxOBsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nmrlHbQhMCPxHc639QMIjFutLX0NzAaOLhOSwSw20Q=;
 b=rKwD2UEczYdUfZCqlnA4XqZPpDkbcFoROTa61P76eXmlD+Igs5ZksNEXQFX3Ii5S6TxxybNUFu+4mTPLCLwkbIGpAGf8D8/rA+fqETaFwwea8qPY9yWkhwpQHIyoBS77mVl2EzFiPENkAfqT9zvKUSHEyTk0vA3bt19lPBlJfm2ARlELckmGtH7X3sR7DoJOh2IIk/YBEEWeZ/qFqmk34k/WvM6uuov0eVjtzkTDkGQ0GzE9BDtTeHpuYZnkdjeaDrclcQqjEguhj/MTpzPrEKhBz3bwKolMOSUNtn9lXQEpi+/bc4cmqiwlCnY56lohY6ual2KBThFuKqzJ5yinjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nmrlHbQhMCPxHc639QMIjFutLX0NzAaOLhOSwSw20Q=;
 b=t4EhuuiIjLcL52gAiUSxAeBeIXxZpdSv8CTo4fR+3h0yYdoHZ8dd95lKVYuj70z2W/lYzncZxzF21gQhEA2lrHYVllPM5EoUvoGIaLlhiwB1CanVlbwvM9YRbMV683pHUvo1hZvbZyoECxnl7Y0n+UZkx7hsF+XDfXcZvpbx5NNCc/J48lJcTYG4udvqaXntjdpokLOMB0hgDP6lRR6/WIcD4lbcGI5imsZUBfNcPHWX3FcKcYFVNnD1vjCU86ah63pNzpyoZa89f5tlLVSxq9F92QKFm5o2loIftFP3Bgi0rpNtl2gwIb1Tonu+qa1N/pc2H3+CJh4KFGB+aRv8sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 14:36:00 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 14:36:00 +0000
Date: Mon, 27 Apr 2026 17:35:55 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Parshuram Thombare <pthombar@cadence.com>, 
 Swapnil Jakhade <sjakhade@cadence.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Nikhil Devshatwar <nikhil.nd@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v22 4/8] drm: bridge: Cadence: Add MHDP8501 DP/HDMI driver
Message-ID: <q7rze73ohtylj4jgtxun3cg6ih42crfs2u6tioby6yfqciemem@udrdm2g32fgn>
References: <20260424-dcss-hdmi-upstreaming-v22-0-30a28f89298d@oss.nxp.com>
 <20260424-dcss-hdmi-upstreaming-v22-4-30a28f89298d@oss.nxp.com>
 <DI3YF7J7ZW0P.3OKMUXAM7GW5C@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI3YF7J7ZW0P.3OKMUXAM7GW5C@bootlin.com>
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM9PR04MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 158706cb-7fd8-4bb9-a297-08dea46a4d1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|19092799006|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P7dNZyC4Nr4GiE4ikKiQHNx1NtdCIc7qDXM0Wv4zf02/tiAQGO52rTV+WWuLLKhJ1KYksjq4ywp1jd3hAzin+2+i5Hsn18mw/2FGTEeV2X1OBYV1atI8aFChrymVnxqpTJuZxL0wEjnmkjbIMQvVogbkPhqbgTrpWNbAto0IepP173euXnYEyq8o+uHTea39emfahRKHTx09K3dV/XeFSBETDirlf95ya8lebILYei98wLMalSPHd8Je1qtSsBI9rVwn+1f4UuTwKIhHchn9dkM48ZppQaL9xjn75Bd+hHGaVchAPr9l/SV9CbJYdH6V5q4TZnPHr1F1yhEtCrCyd8MM/Bsk/3fBGdinmWkcTmu4EhhR8NGqMe4kv0UUmmtLBInLs95jHFZ71Wz/+/Rwe66OIwc4MeOLwdsmRJZbb0uPJSvrYh98Lyp12qRR4AAS6psIlfZvQXtaBj4Y7lgIli99X+JfzBqy4ibhjP5DOBZGzg0Lo57c10LmdwYNSni1PmPhKiMz0YG8On/KUGVfw2kCAspwxs0GvQl96y4XFZULrr+9qtHEzfUGwKb53DLyB6pwxUARanoPBFZxqdVSM7vTjdvO9le2daWSykrxwoL3+fCPwl16qMQBHDagKIHR/zYw+2uXRHKG08za9QZRGOyDKX0McWrgZ5aeHH4Sp59iFJLKZUgW6o7KA5zk0SztLMJ0DjTWOwaCmtB5+7mpt7KyxR8RM7eTNmspBtaRjEQay6SiiwKV8l+KfdwTiuAx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ymk1M5SAAOMlNSHwiadiOwpGPV92CaAodMFgpriNH9MrsNoUyVN5wuoUEgR?=
 =?us-ascii?Q?BjZZqB25FPseBpEL1aJrRZemnjFzb45XFkrWSx9PHRPoosZcL55fYJ+yHe0p?=
 =?us-ascii?Q?7zXebmBlfBWvIzuCA433tDUXs/YgonvvRSdB/yaVsskzJoEUVEuAJnB4dw9i?=
 =?us-ascii?Q?AcMIPY7+uB/ILLEQuzVER9IG8enIn7keRyREh1kOGuRTfOTn1nWKhpV+/qT+?=
 =?us-ascii?Q?7ujmYodNP6CG2li7RzT0sCYg1BqyBi5dZUqfmLI4F3xzQWPLsN6N3q6bFfjr?=
 =?us-ascii?Q?9DQ2m98NFc7FqBYo6y0GRF4ltkuaQShfzp+kaVk807IDBneyvhk1I6+Ir4/W?=
 =?us-ascii?Q?2+9OxlISeDiKTPFzc3uUDBbuDvfVf4MvsQjWuLOa7zKfFH479ncyxnZyImiN?=
 =?us-ascii?Q?gaF1cclRVLh8LVh30sT6IDLThVdJX3BTd8jwmpZiO3zJsWRRDWlIDL4yis0J?=
 =?us-ascii?Q?Z5mAt7YcSWZniWeIMlwYk2id2TakYC+pAJCeaYIN7eY5+vnR4/TBJZEENn43?=
 =?us-ascii?Q?RqEElqF5KCfXyrgoZqMv6kvQ5fDyZFaCmo/bSMHTknerqcTSSTw4NXptGHF6?=
 =?us-ascii?Q?kBIm/MeSlpsBur1E6EDlqhhAKI5T92NZ3zDW5ohgDpx6n6uci2s808BmcR3T?=
 =?us-ascii?Q?BsQUyPS6spI0ESiuJA851yE8TW7aqRojqY5xpYqCmCkNnilOKizhm9BYHpIt?=
 =?us-ascii?Q?EREfb0h+Hp/RuSeaozWbtmZa8eng3mVIgLsW3fz16qvxkK1HzJ7RqLlfC5w/?=
 =?us-ascii?Q?bIN3uv3f1jegpPyk50/yW6VMhRtnnx2NdSspkEZ2fiq2xVLKvunFpdBliXcA?=
 =?us-ascii?Q?x8kuAWgpy+1LWSkfx/BP10jBxbibFBtQMTuVvR2yn2RLIImAW5yHpdoFfGvJ?=
 =?us-ascii?Q?o/ha+cEPiVuMRAAt5sP8XHQwDM11JFXISAGXurJtMDFoqS2fk5eBgti4JbDx?=
 =?us-ascii?Q?JrdjAs3Hxv7RPclbCzA+Pf03ynKdu77AonvaBDaT/HGC37qOdAJvrDKjOv2F?=
 =?us-ascii?Q?Xz91ThaC4h2E7dFWI7ktEiF4EioYTnD6IecXblWgcwYLgHW2Uf1rC91o+pSX?=
 =?us-ascii?Q?xo+airJ8Qm85cP71SoRj/QxHtCcq9QX7KfxDzuCO49VfmnZcr49dsSe1PN+X?=
 =?us-ascii?Q?+5d/F4gjd5BNF0wUK6XIFOQHRuwsa9RldxGG3Vyi+yLkHHvyTKA/NKgGM/JW?=
 =?us-ascii?Q?fo0ae+3AKN4zup9D2bSDfCEsGUpLL33Nw1NobXH4SUiz31YsizPlE678t6t5?=
 =?us-ascii?Q?ytLF+RRtCcF3w0L84Ke9vzVNQKsQmuSZFvLXbxNQp5j00WKLFlexuqcWUMKJ?=
 =?us-ascii?Q?9XJAmhKZJFkKWQKBKYNh0f22qsmZ7KLLggfDdayzrBsQkhsQd1qkAqCs8L3+?=
 =?us-ascii?Q?YX8hhoQDKy3uc5ouDcXVSZhCKzHQqEGccyou1ueEPKNQsrhz48LvzEzLu+C7?=
 =?us-ascii?Q?1oxOxj+ClQrbukTBjQpEfdEfQreNjyblWBpau5sJDh88o3mJwAgzSvhgp4DL?=
 =?us-ascii?Q?e6xckGQN/KgDe0wPEESDvRtj7HVcPE4cMjJ9aNqOuCUNFC22PPMwJOmcgMtB?=
 =?us-ascii?Q?HwZ7lZcmK6guP5ECutlhhg3NI6B90brJhs64/25NmFL5ypULEWF3Nqeccfi+?=
 =?us-ascii?Q?6/l84cwZ5HZGpQiiw1Zd3GZ8essN8b239O1qkGu568gP2HJbXAFzz3gQv7V2?=
 =?us-ascii?Q?hrQg91O9kMZSOdERxostrsRNQ93fq+/rYW431u5b+dFD5NLJIKsGJ1dczlU/?=
 =?us-ascii?Q?z+Uy2h+/iD8rHHlYLAr0LLI1Et8gP0g=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158706cb-7fd8-4bb9-a297-08dea46a4d1b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 14:36:00.2417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GYP9ab6QK17pUZ3sbKlxL71KoOs4pRyU/KHI5CQyP33lw1Agxoa4qeZTJyRDj09oe/AUeiaXJAu1BhFqyIYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748
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

Hi Luca,

On Mon, Apr 27, 2026 at 02:59:51PM +0200, Luca Ceresoli wrote:
> Hello Laurentiu,
> 
> On Fri Apr 24, 2026 at 1:07 PM CEST, Laurentiu Palcu wrote:
> > From: Sandor Yu <Sandor.yu@nxp.com>
> >
> > Add a new DRM DisplayPort and HDMI bridge driver for Candence MHDP8501
> > used in i.MX8MQ SOC. MHDP8501 could support HDMI or DisplayPort
> > standards according embedded Firmware running in the uCPU.
> >
> > For iMX8MQ SOC, the DisplayPort/HDMI FW was loaded and activated by
> > SOC's ROM code. Bootload binary included respective specific firmware
> > is required.
> >
> > Driver will check display connector type and
> > then load the corresponding driver.
> >
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > Co-developed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> 
> ...
> 
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-core.c
> ...
> > +enum drm_connector_status cdns_mhdp8501_detect(struct drm_bridge *bridge,
> > +					       struct drm_connector *connector)
> > +{
> > +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> 
> Please don't use driver_private. Write a oneliner function wrapping
> container_of(). There are many examples in bridges,
> e.g. bridge_to_sn65dsi83().

ack

> 
> > +static int cdns_mhdp8501_get_bridge_type(struct device_node *out_ep,
> > +					 int *bridge_type)
> > +{
> > +	struct device_node *incoming_ep, *node, *ep;
> > +	int ret = -ENODEV;
> > +
> > +	incoming_ep = of_graph_get_remote_endpoint(out_ep);
> > +	if (!incoming_ep)
> > +		return -ENODEV;
> > +
> > +	node = of_graph_get_port_parent(incoming_ep);
> > +	if (!node) {
> > +		of_node_put(incoming_ep);
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (of_device_is_compatible(node, "hdmi-connector")) {
> > +		*bridge_type = DRM_MODE_CONNECTOR_HDMIA;
> > +		ret = 0;
> > +	} else if (of_device_is_compatible(node, "dp-connector")) {
> > +		*bridge_type = DRM_MODE_CONNECTOR_DisplayPort;
> > +		ret = 0;
> > +	} else {
> > +		for_each_endpoint_of_node(node, ep) {
> > +			if (ep == incoming_ep)
> > +				continue;
> > +
> > +			ret = cdns_mhdp8501_get_bridge_type(ep, bridge_type);
> > +			if (!ret) {
> > +				of_node_put(ep);
> > +				break;
> > +			}
> > +		}
> > +	}
> 
> I don't follow what this logic is doing. Can you provide a practical
> example of the "next node" (@node variable) where you fall in the else
> case?

The else would be hit when there's another bridge after this one. But I
don't have a practical example since, on the i.MX8MQ, there is no other
bridge after it. However, as reviewers pointed out in earlier patchset
iterations, we needed to make it generic.

> 
> Also, while this resursion will probably work in most, if not all,
> realistic cases, it could take incorrect decisions. Consider the case there
> in the else branch your @node points to some node having two input
> endpoints: ep0 is the incoming_ep and ep1 is another input endpoint. In
> such case you would recurse on ep1 and return its bridge type, which
> however has nothing to to with the output and might be incorrect.

I believe you are right, I assumed each bridge has only one input
endpoint and one output endpoint... :/

> 
> Another question is whether this driver should have two compatible strings,
> one for hdmi and one for dp, and set the bridge_type based on that. This
> would make it a lot simpler and remove the need for this function.

I think this is a good idea. I see no reason why having 2 different
compatibles wouldn't work. I'll give it a try.

> 
> But if I guess right from the code, this device can output either hdmi or
> dp, and the implementation infers the type based on this device tree
> walk. Is it the case?

Yes, based on the PHY firmware (which is loaded by the ROM) we can have
HDMI or DP functionality.

> 
> > +static int cdns_mhdp8501_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct cdns_mhdp8501_device *mhdp;
> > +	const struct drm_bridge_funcs *bridge_funcs;
> > +	enum phy_mode phy_mode;
> > +	struct resource *res;
> > +	u32 lane_mapping;
> > +	int bridge_type;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = cdns_mhdp8501_dt_parse(pdev, &bridge_type, &lane_mapping);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = devm_of_platform_populate(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bridge_funcs = (bridge_type == DRM_MODE_CONNECTOR_HDMIA) ?
> > +			&cdns_hdmi_bridge_funcs : &cdns_dp_bridge_funcs;
> > +
> > +	mhdp = devm_drm_bridge_alloc(dev, struct cdns_mhdp8501_device,
> > +				     bridge, bridge_funcs);
> > +	if (!mhdp)
> > +		return -ENOMEM;
> > +
> > +	mhdp->dev = dev;
> > +	mhdp->bridge_type = bridge_type;
> > +	mhdp->lane_mapping = lane_mapping;
> > +
> > +	mhdp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
> > +	if (IS_ERR(mhdp->next_bridge))
> > +		return dev_err_probe(dev, PTR_ERR(mhdp->next_bridge),
> > +				     "failed to get next bridge\n");
> 
> devm_drm_of_get_bridge() is there to either create a new panel_bridge
> wrapping a panel or return an existing bridge. However based on the
> cdns_mhdp8501_get_bridge_type() code it seems to me that you will always
> have another bridge after this bridge. And so instead of
> devm_drm_of_get_bridge() you should use of_drm_find_and_get_bridge(),
> which handles bridge refcounting.

Ok, I'll switch to of_drm_find_and_get_bridge().

> 
> When switching to it, you additionally can use the drm_bridge::next_bridge
> pointer instead of having your mhdp->next_bridge. This will simplify
> putting the bridge reference. An example of its usage is in [0].
> 
> [0] https://lore.kernel.org/lkml/20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-4-8bad3ef90b9f@bootlin.com/
> 
> > +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8501-dp.c
> ...
> > +static int cdns_dp_bridge_attach(struct drm_bridge *bridge,
> > +				 struct drm_encoder *encoder,
> > +				 enum drm_bridge_attach_flags flags)
> > +{
> > +	struct cdns_mhdp8501_device *mhdp = bridge->driver_private;
> > +	int ret;
> > +
> > +	ret = drm_bridge_attach(encoder, mhdp->next_bridge, bridge,
> > +				flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> > +		dev_err(mhdp->dev, "do not support creating a drm_connector\n");
> > +		return -EINVAL;
> > +	}
> 
> Any good reason for doing this check after calling drm_bridge_attach()? It
> looks to me that you should first check for valid arguments, and if they
> pass take any actions.

There's no good reason for this. I'll move the check at the beginning.

> 
> Same below for the HDMI version.

will do.

Thank you for your review.

-- 
Thanks,
Laurentiu
