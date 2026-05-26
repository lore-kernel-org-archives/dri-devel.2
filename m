Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05238CD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 06:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A5610E144;
	Tue, 26 May 2026 06:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hZDRy9w9";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81A310E144
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 06:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG7DdyAw6ba6cureBExqtIgmyk3wk4ddun9Bc4CcRSo6r63YezhRhkIAueBNFP0KRi+DfCc+0dBwLEAR6djne2r65E/oYYeQDQQOMlAxHGKREh1196QHF/UPdFTuV9cTawHW/K3VFcDonj/nhCLsu2JjXSR/TGILsHOHO11ruiagqFWXNf+pJ2citafQAd21/fFqQI7Xy8VnkB2VJZZRG7bLaYJJFTzXadNvvI7c2vEqrCChfU3BJF3pdIvvMeDz+pFaP0iwd+UgapJoFh2T8XRHMy0rNvKDV5o8RnQYVEyAWNv4/i2Tc8wfYMRxIiHa3qtFSqBEtA41aTjgXS6+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRnidN5zNQaRB1EPvo9TfbtlGxbBvkwKTQzEDewSdlg=;
 b=kVqwiZofbQL6GY8wGHHGTu+nTsl8J8wBbpTpfmNcd9kSV5ivu6Y5Yw8xWRDP5hAMIgry1YZqpxstjtIJbu4Q7hcAmW5QhimQReTnjhUryo8hkSd4CHuXjl59HoVXq5EV9zJd0vqaDjn9fmicwO1mEcJIOGEkWacESEyYXU1NB5WyWkxJgQ7PILVq0BA6m4Z53Jw/xc8ahJf4GKqg+9RupsK6ft7WcTWB0NxyHuowzcxUgFwkc8wUGrD44+YePIZGXhB1SQ02AD/Oux7YsCSGiHMdmqW5vJr/rWwIiMTTnb95vRf/2Ma+gtK+qQvC0EOeqK67rApXiuAUhKV8Ohi6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRnidN5zNQaRB1EPvo9TfbtlGxbBvkwKTQzEDewSdlg=;
 b=hZDRy9w9OrA83Hqk0HUOK3d0JU49vBR9hrghiN4WXWkXQhRSpTbCH9JraNxzR06X2d9lkwkUdKmnNflB9bGg4Tbxo0UfIKlku/AeVSF/wxlwDlGX2dTrq1IXYxjQteOnBHR/OHbtm+Rc/Qbdji4JWJALH1Gplidt1oAmaMK3lsyjuK5rZ3MY50qHC4LHYhB+WLOifV4x6E8HBPSp5Uyl8eQOdr0Y+4PJdVZeSwUC/dm07RCso3oybfWt4RSh5pFCsleRAemZX7o8p7Z4dFDKjqqdtFHyd1GGcR0DJwFCsjGMkOOj9zDM6tzDXwbM6PwFdD1iogyCY6m+ojQXRHz21g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU2PR04MB8549.eurprd04.prod.outlook.com
 (2603:10a6:10:2d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:44:59 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 06:44:59 +0000
Date: Tue, 26 May 2026 09:44:53 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 linux@ew.tq-group.com, Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Ying Liu <victor.liu@nxp.com>
Subject: Re: [PATCH v23 5/8] dt-bindings: display: bridge: Add Cadence MHDP8501
Message-ID: <6oub7yyy22dtrevw7oayaqkcncz6tmmddy6fb75gsn3z6yfe3r@zr5lehbaohof>
References: <20260519-dcss-hdmi-upstreaming-v23-0-5615524a9c63@oss.nxp.com>
 <20260519-dcss-hdmi-upstreaming-v23-5-5615524a9c63@oss.nxp.com>
 <20260526-golden-bobcat-of-aurora-fd1fef@quoll>
 <2301c829-5203-47ea-bc26-09f9e3b459a4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2301c829-5203-47ea-bc26-09f9e3b459a4@kernel.org>
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU2PR04MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: fd51b472-fb53-4a02-406f-08debaf24e19
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|3023799007|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: +9q8c4MCvyXRIYAq5j0MoNEuIZHHXz9kfnyCqVCTzz1tDsfnheL2YQGwv7WDRC30etDzS/gtg5L3/1MeXYFefNPcfj0zT3+EVL09arKkufry86/lplLG9dCQrJNfsixsQlGdlU17CgKqciYkcqrAZQ2IB157KO0qcilt6Q1YSK/pZzxJSequewXyRY+IKBqvNijPRLMaB13/lE/Z9wuumK2AH0btacAKUiuJeMHU9c8nKkFccwnRRQyTv98oFT4gzEFSLscs5Psw34R4x5U0P2eLGz5+/jD1YBM5MJ0f1UzlnC8bTlqH8R4FC3G+Lhj4a42Xm+dibVqPfxPj7aOkskb4BEOq8vWdkIxI44wZQarDBSaLV5XgoePJU6itqNO5Mp1mk65C7ieF5685Qt8Ot260md9JOVO8UwM1AyoFrmWvPtFiRCACjTrU9U4BFuLgoLNLirEdRcTddGsVkVVosdEWQLizL/cT3StBuLwmqw0EuSE42GSDaaKzO9mRRXnu4xuiN6FJ0dArew5pswMa6MiZjnZwhe/OpUmnOAiaGRtu1+h6EhmIbcGFgL7o8Q0Za5yQvGwGXUMFXvtyL7glk08qq4/tYCV0V7skrlxasu1gxvJr3SPGdIMv/QegB7fxYJR2DgTP2zJvNQH5+O7awA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(3023799007)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKocyKRroxBptAjXGYivfpsMbfPYCEqbtZSiU8qFEJamkcRYeFaB6jVVgrG7?=
 =?us-ascii?Q?w5dSyXMKRmovKMuV3XbMoHh/7ciZffXJkqiTnbVj1f2jLLwJsfiWGwcU9lm1?=
 =?us-ascii?Q?/hNH+6Ck7UlrEgkw0/HRX/J1lGrC4sFRtYcyuOS0hN/of89JbykgacrDlxxD?=
 =?us-ascii?Q?A+oZcimMhHOPOsfej6lSltHlbDPbrG9wBq6RkBKNFSauno2Ul6wVsb+5Ia7v?=
 =?us-ascii?Q?BT4qCmikqXXhycNjgozfYkU7U7Zf2nQCp14FMtMGVRLHJ95RwyYMOLsC/FnM?=
 =?us-ascii?Q?xpCqG/GBQ+33dIOolExRaM5XS4m9uq1Zs7ZNs6ujpq/UOXBGHmBk5tY5pc0t?=
 =?us-ascii?Q?7aU9X2WiZhNFe5ZhuHLlYzNC2ALyYPmnt2MSxEHp8+53TXu8UTB5S1AfRG6p?=
 =?us-ascii?Q?wTpVoRj9j//HyMI/rIpZxeYGoABUzvWK1YDwC+aBUjUUoubku/O4EFsvOwUM?=
 =?us-ascii?Q?cWtHfi/XQUSGsU4rBNl4fPmDVbk0dhCdGgP1lAGfqOmLSx21RI2QpV+UeS2s?=
 =?us-ascii?Q?zFEK3p1JvJPriUXmsj2GP0aD7THJS6PHJLNsH5YRfsyEqV8FoIJdzJmMUKM+?=
 =?us-ascii?Q?+9N6TPlds89LfxF8zZZP8jZ/CGgqI98p6t9xJdNsIrNi+q0xhRxahbxKqohr?=
 =?us-ascii?Q?Zt57spQiqUPN95ejD0SxEUuawBbEGBx8hfwyW0XiqzIMw9ypkn2di5xRHs/1?=
 =?us-ascii?Q?P+dNpWzDrrqtgqruzR9gfSD1yIq7vQvkbxnT5Rmrl81Hx0i27VN/tjoXOzFT?=
 =?us-ascii?Q?VnFiJX1GcvQPDJEnWNMGGFEWJSpYZkc4urkfSHdDcbnZgns7zzDN7GGu9itJ?=
 =?us-ascii?Q?fzq8clFqAWPYm+x/WmmVKKZK0K+Kamnciza187nIwprOB7vFVxjGQi8ILlOA?=
 =?us-ascii?Q?wsNb/jv0jpzuGJjVSnAGstQfUrrRiESc0I9OULJaPNiW6msmmaGilGNxltUA?=
 =?us-ascii?Q?HzJxa81vJylVnloWyMgibKOEXyPFP1vcDBQvZoCV8jWflE8s4n2MlYq2LoKp?=
 =?us-ascii?Q?q7LKU32FGiTgpyNc5I8Jp3aRJXf55GXKAf6T+KD0ZIDlEyz9Fo1jv8jLVjl5?=
 =?us-ascii?Q?O74iTe5kYl/h5/MaagWvsQ1k2VczD7y0phJfQ+K10iYNjoySIL4oFnQ/5zX3?=
 =?us-ascii?Q?dGDTIzGOYxz4agSPIoREfCiJEPSUWTa7vjvhGUi8RaaLnIKmgBuAJrZ9e0iZ?=
 =?us-ascii?Q?GR8dUK3KXG3t5BG3TXFh3Qbr2RiOzGkkQ0wkYvrLO4BK2D8UKxW0HgaY20oq?=
 =?us-ascii?Q?iYWRZFo3rmFuIZ2l71vljlRdXtN7Bwu4HKZRRvtmzbX02zLfDHWLOvgJpRut?=
 =?us-ascii?Q?xHMUt5xxLwu+/L7GGzQZrZist2uW1WAGOBEZWOwMAVI+rnjnJqPkaFqVjJx1?=
 =?us-ascii?Q?B5fXEnUcvSztBZ7cy/cq1wTDKIU1X4aO+4E65LtDFrX+U/fE0ND8gnPTQK0M?=
 =?us-ascii?Q?xq8/wLeuCJir0iep6SEBZTfC4OlsmybhKChn4LIKcSuzwxJZR9JdBZYUHkvl?=
 =?us-ascii?Q?XMwQP8t9nZ4/vHMygTOCtlLYuboRTqwKmiDjPWwILxje6JX04DU7eWwZluGS?=
 =?us-ascii?Q?eME/CFXkehqRm5+p7beemPfwony2d6jAgx7PU6mFiHaTKlpxfasQmd630oQZ?=
 =?us-ascii?Q?PiehGTlWMuj0qMDPBXy5A2vP3zxXZ/X1kLi1AiyaSHw4oU8mCzHRWGtRIv8/?=
 =?us-ascii?Q?iGGs1isbNkqhRLsfBe9TGsYtnfFT3aQ/rm5fAoSy1ts4H9OYPHjJvKCvZLsu?=
 =?us-ascii?Q?LZIuE4pjobhNVWdGatpPRCAKu8euMBI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd51b472-fb53-4a02-406f-08debaf24e19
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:44:59.1103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67L+3gOqE5+OzwVBPpQZBS4uVp5OLR7DO4AAtVDTK3KwJ9zPfy7EqTktV4HzLvuO/yQQU0Y7VGQIX6vKh8Z19Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549
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

Hi Krzysztof,

On Tue, May 26, 2026 at 08:10:43AM +0200, Krzysztof Kozlowski wrote:
> On 26/05/2026 08:08, Krzysztof Kozlowski wrote:
> > On Tue, May 19, 2026 at 02:42:28PM +0000, Laurentiu Palcu wrote:
> >> From: Sandor Yu <Sandor.yu@nxp.com>
> >>
> >> Add bindings for Cadence MHDP8501 DisplayPort/HDMI bridge.
> >>
> >> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> >> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> >> ---
> >>  .../bindings/display/bridge/cdns,mhdp8501.yaml     | 136 +++++++++++++++++++++
> >>  1 file changed, 136 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> >> new file mode 100644
> >> index 0000000000000..57e7e95199777
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> 
> Filename must match compatible.
> 
> >> @@ -0,0 +1,136 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Cadence MHDP8501 DP/HDMI bridge
> >> +
> >> +maintainers:
> >> +  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> >> +
> >> +description:
> >> +  Cadence MHDP8501 DisplayPort/HDMI interface.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - fsl,imx8mq-mhdp8501-hdmi
> >> +      - fsl,imx8mq-mhdp8501-dp
> > 
> > We are at v23 and you will be getting the same questions till you
> > finally fix that commit msg.
> > 
> > Why bus/connector is part of the compatible? Device is exactly the same.
> > Please read writing bindings - it covers exactly this case.

The device is the same but, based on the FW, it can act as DP or HDMI
controller. For 8MQ, the FW is loaded by the ROM. I did look at the writing
bindings doc and I assume you're referring to this exact paragraph:

   - DON'T use bus suffixes to encode the type of interface device is using.
     The parent bus node already implies that interface.  DON'T add the type of
     device, if the device cannot be anything else.

I don't see how is this applicable in this particular case. The parent bus node
does not imply the interface and, as I explained previously, the device can be
either DP or HDMI.

> 
> And this was BTW completely different in previous version.

It was indeed. However, the problem is that there's no way to detect
from the controller's registers if we're in DP mode or HDMI. In v22 I
added a DT traversal function to detect the connector type from the last
node but it was suggested to me that having 2 compatibles would be a
much cleaner solution and I agree.

-- 
Thanks,
Laurentiu
