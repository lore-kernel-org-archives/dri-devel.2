Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80135107527C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E961610E85F;
	Thu, 19 Mar 2026 08:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZGn2WPYQ";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013013.outbound.protection.outlook.com
 [52.101.83.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C1710E85F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7CpflLO+2hGnxacV726EVtZC4/XUsMGeDrL/bxS6xGaaIlfQ9R/3qkpQZwfzTbwQqiXcge5SGl+k4hDZCQpSX+ZoA0CbiHKGyVwMo475qCc0mNbvaNMt4ySb6FAIFHgjIoQz+1yYiMMes94kzAeaTjClhN5yvyHoOpPr+WSMTKXPHMjWzxy2qkmkTThb0Q+UW9fBzGDL4uRz64gMHFl344Iywhc6sNnG/DbSojlTSf+yu6Oaxsr/Mhf52+lDPn/Y+cDU7bQNd3VEX9qCubic4XmToaq75xScC4eMtpz6skKl96qDBZ5hY7a/+uDiQ7JUKo0Ub1NUL7hURtOp74WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1j8Pzya531RPX9LC+RRslTpng/WAG+DNgCgqYT95vk=;
 b=JvASQ58x/O8zlNa/SDCfu5smgMVJ+PINXncrhTc+Jp5bg6OwSoM0v/A5B7dq0kGLhX2zlUZysi1YPPtTC9Z1NjZEhJ2qxqbfKWBGROeUxn24zIPwliymNAkswhGuPvE+i2Idrg9MYUijd0p2HOsjeVYA9yzsbHy5sTHyTnRRc0HyUZiyRMigbk7ag6kEhCvitQcUS2R/41e01nHtLd0xkoIGVOPbbBgptMqSiCxdCEnZH9Id9+bfOgugFIJvGolEN5bHNt1MCKWMIEAgvjUSuY9jlSs5aezSWu/3RlaoCPhcW0xrBMNReYLdrJ9iPLW07Jv/5qrW3KkbeFHQv6QKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1j8Pzya531RPX9LC+RRslTpng/WAG+DNgCgqYT95vk=;
 b=ZGn2WPYQtUWnW/zZL7gpMHViecIPQmOdDIQ+bGPx/jAbnebusEwz2w8FenT8tj/004SgGwYViNWu/thpuwW7OKzhQzPIOAisT9Ju9u1iOivt4RJX3QAM7GMzmXqtHW2hqKONMaA6v16XEeHXJsHrIge8tgHJFPMwBtWfGGmuB8Xtq4z9JjuQ20IVtmZZEpAAfxy9pHWurXMHVIYmRYYLKxVsJ9MYqATgHqOxlZFSeymQtU8mBJlPEW4KnJ0ro3t3jv45lKgki++SrW5cQFIOgmcQDo9a6i9iQFEa2wmkAb5HSp5u75oG+3cC+hYALLHA5Wuudki3nvKoGc+ohMs6kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by VI2PR04MB10092.eurprd04.prod.outlook.com (2603:10a6:800:22f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 08:57:10 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:57:09 +0000
Date: Thu, 19 Mar 2026 10:57:05 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Liu Ying <victor.liu@nxp.com>, imx@lists.linux.dev, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marek Vasut <marex@denx.de>, 
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
Message-ID: <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-1-bec5c047edd4@oss.nxp.com>
 <b7968f1a-c4bc-4bad-bcf8-407ff2d8db27@nxp.com>
 <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|VI2PR04MB10092:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8cb5c7-d538-450e-e100-08de859580d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: xMIq7S/QeXmnXiwZ84HunfNUqYsk53oDlugIRnzx0WZIYMJF2uk33qVp45I2u5ATlqLChz3fdnVNSHJURocGKykgROseSYKeyzeQi7ymBd9JZyGJ2YWKk7FEu2WpnIlRmP2S2nsZsx9KKf5k+L76lt6bXK3PBPUOevTJOce/wnBR9J4Z8c1k/bRUS0RdWFgd29m8Dj4HrxYnKhCmMY4F/Xh0U57Zrz6Zi9ZGhyGzhEHV0IRGeCvq15dh6GfrIiBa3lpn8SBHxTBZwbfZFnMKlmBF6rRNBI/LwGSkG34QIJkJQeNGp47M6P4k79G+NBfyfprHFe2GHtlKi7uNzMM+HjmiXhBWtweq7OQtaVmoOex77SVX65VJozAc0sB7uq6baRVXisMOc1Pm5F7lVk8ezfsi5EQlXdsGcuWrUlNDAqVgJNzIIJYBdIKS5UqxzpbtxF4FOA/KLvq5r1ef77sz3DJ/6wnkakp8PX8bsDrfIqL3YbrjlA1G0BUnDAKzQ7vhPkPS5mReeX+4ZA0eGoUFQC0vkQGwJul09wR57v3c1s3IsKjje7tUW0BpbCzRPKQxfn0jpYLfqRs2Giw9YRMAaDs31KDHRJUb2zx1zOtlVo8D0+feDduXFfwtElE7p5l1LNOH5dKATfceNBD1tAwBUazyscnrOCXAs+OhTlIKKnmHS1Id4cBgLHBr3k00tROp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xanWGlkBNKrm3vBeA1FYni+zqllP5JO5Rw9Y06K6oEVffVUiP3A9+MO757x5?=
 =?us-ascii?Q?jwsVFzzwcXfupYxEHDX5s5QI93cVIUYefvLTRtYt3VT/iPC8sC3HHPmM/UL2?=
 =?us-ascii?Q?hOWyXIa90qOz8ZOWriX/Qulh7p0jkMe85VpoAhgYJgVMYL5Iwu6I8UrCAmKw?=
 =?us-ascii?Q?t9fweo/Zpm9i6WlZGvOK+9qFKUCENcqTZ/w6TLvIu0lSs/O9q+7P4ySwB49E?=
 =?us-ascii?Q?766S5wxcxrFuPyhP28kOhJu9WjEHj2k2LavpkTQN8M9A0TLQBhgb+P9Jv0rT?=
 =?us-ascii?Q?zBaNiMJ35l9QNNobx3u/Oon2jwD+uKBC8k/KhPuhuV4KIec/HUPi2JUcUQoV?=
 =?us-ascii?Q?DRfH4UUvQlYFp8t2qsPskAkh9ZP3j0Xg1AqP6GnYjof0AOBt48RH5sqakMdP?=
 =?us-ascii?Q?NSzyULDNkUPOlp8iJRojojMtp9f8XqWudfHiAObDsvQyi/E0ydihrIVnoyVg?=
 =?us-ascii?Q?ToCO1nJzEH6PpdWJmmO1fBXLkQpEUgqqUgfI7S7r8t1lSkc81iaIpTfpm08w?=
 =?us-ascii?Q?MD5yxAY7FMLhNlYe7KH/sPLP/wFdhn8gfMW/mFOUaIgH5NUAH9SqYF59xpBd?=
 =?us-ascii?Q?6OV/bE2rlTTVSUnZykWWMyz/mgyQAEPy+8lNKArgVQcz9r6GTnV5deH0ouEH?=
 =?us-ascii?Q?MII1CrswgL2Wxxm1IOtAYks/5X4OBWyVEr/bUnDdkH+eC6dyWvuj3RUjX60c?=
 =?us-ascii?Q?qkW0gf8lyGryXuDh74yr5Lt+c7HoH3oOUm+XtL9mWYOA+UBw6nU8W7pR0gun?=
 =?us-ascii?Q?TUjT89C2uWhluUPMFd7eq6X/TpdpwnOvwqOpqtHNgC7gV5ryuUqxsdy/+oDm?=
 =?us-ascii?Q?vYSp+k+NIPPE/oNL0fcarNVUH0PaMVmQY8Kb3iuYLkkE7gCGivALoJcF18F+?=
 =?us-ascii?Q?3ZukZ4UkNnNGzrAPsavpcjHO3XVP1FaKOIMsiykfrWU2VuA4fkVIA3Pe/VJm?=
 =?us-ascii?Q?SJusy/zqCbONc/4M1CcAd7xNnb+wyqyUCQYDJl4t5cW45nX2fjpxResYPj+P?=
 =?us-ascii?Q?XDPmigpTc2HUtu3B61OEUUVdLNYxZfBnCfkeew0Whg/7SWxB5xX8N+aVNhoa?=
 =?us-ascii?Q?Zeeiqmm8oxUybrZzM2ILlJqsGSX8DYAr9wPvNXYIhMdUZkTD/l2ilnhxcsvA?=
 =?us-ascii?Q?e5EuR9lpvtnIY/k6oucrrMNUu0cCpRUkYN0MdpNqEXgHX8OTwOR3U/FHHCu+?=
 =?us-ascii?Q?CY1fPYl2roDFx46NSnPe7jiAtVH39AY0nI4ZwaHQve7spHVNg65TCw+inuV3?=
 =?us-ascii?Q?NJs8L2tk1szn3PnGv4/nzjIGuB5CT+i4uDoXDHN0HrD267oo6yWYj9ywsQJZ?=
 =?us-ascii?Q?H8CAN7A2inFcKZJHynrKAH+c6JNoBfDu4j4SCnNoCzY977BtIr+tgIozlAZN?=
 =?us-ascii?Q?0r29HAvFC2R3yQ4A2++zV+3dP72P/J2Fa96thoknu+9Mrk0+cQl3B4YeCCf8?=
 =?us-ascii?Q?QKA/Zi9gQntzO6hFhigvp8Jwg8K0w1Ly680dMF3NtGDv4NrykQ7R0dTjhfgK?=
 =?us-ascii?Q?wkstpgdS7eUx/l6KFqdB3nDeBV/qgjbDs6iwScZl55VGlr9xbFb1Mn/99lxK?=
 =?us-ascii?Q?rc+Mgz4WiPY52Y0WYC5i8roE1pNSCIk8x7LqkHNrGP7LTEZrPO/k8IwrXVGe?=
 =?us-ascii?Q?uV0jX56STVt6JLc5RD5H30fDpbp0TcP/7pidUYdMPHCy9yVufomRiL06kZEN?=
 =?us-ascii?Q?HJHF3uw55I8k71XlvJco9++V4Bby5zA33XAC/NLj8+2IpMQ4RhHYnRvJIIKJ?=
 =?us-ascii?Q?yJBV7mcSixdz9vw2bEc10WNkcK5DNuA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8cb5c7-d538-450e-e100-08de859580d4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:57:09.4156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlEZHTd5k1+qspqobJ+211LjhT4JsiNpERu9hXLcNexnPrZSq8fOp12qG650JrSUtao4F+V7+WLoQZbMUHQrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10092
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

On Fri, Mar 06, 2026 at 09:46:57AM +0100, Marco Felsch wrote:
> On 26-03-06, Liu Ying wrote:
> > On Wed, Mar 04, 2026 at 11:34:10AM +0000, Laurentiu Palcu wrote:
> > > i.MX94 has a single LVDS port and share similar LDB and LVDS control
> > > registers as i.MX8MP and i.MX93.
> > > 
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> > > index 7f380879fffdf..fb70409161fc0 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
> > > @@ -20,6 +20,7 @@ properties:
> > >        - fsl,imx6sx-ldb
> > >        - fsl,imx8mp-ldb
> > >        - fsl,imx93-ldb
> > > +      - fsl,imx94-ldb
> > 
> > Cc'ing Marco.
> > 
> > Recently, Marco said that LDB node should not have a reg property...
> > 
> > https://lore.kernel.org/all/4sofljffovrorpxe2os3jl745qfjoglvl54oqf3v7r5bk5f6aq@6y3jwn4abiqy/
> 
> Yes, this has to be dropped. All variants of this specific "IP" use the
> same approach. This "IP" is part of a general purpose register layout
> with very loose reg-field definitions: e.g. resets and clk-gatting share
> the same register. Or a mux reg-field shares the same register as a
> MIPI-{C,D}SI configuration reg-field. Therefore this "IP" is part of a
> syscon and should be abstracted as such within the DT.

Even though I understand the logic behind why 'reg' should be dropped,
I'm not exactly sure how to proceed with this. It appears Marek made the
'reg' required in this commit (merely 2 months ago):

8aa2f0ac08d3b - dt-bindings: display: bridge: ldb: Add check for reg and reg-names

Should the above patch simply be reverted and have 'reg' as optional again?
Or should the 'reg' and 'reg-names' be removed completely from the
binding.

@Marek, any comments?

-- 
Thanks,
Laurentiu
