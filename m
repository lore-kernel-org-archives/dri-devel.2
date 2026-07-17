Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2291C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D6110E301;
	Fri, 17 Jul 2026 15:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a4nAFonr";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013023.outbound.protection.outlook.com
 [40.107.162.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5483610E0EA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYgjldY85noakJBAuQdmN5sTSsTdkI+RueCEp2iCh80p+wNMbHJHRu4PGStdyoHSi6BVYhKzSTmYEwvm5aPRz4FKWnBDl9fEQYlDY2KujY0bj0PJtcPEM6qg6Q5BwU/wAhB65vPwW3OVzn3dT4vX7wxAUQ9jIbKbDH0RX1m8iuvX1jRBATYJBMd3fEUZlHfcSmhrJIZDVljuzxz3Es/jgGe1oWjqDvKD493pby0ytXYaXxsHqS75TwnigTWHfQNxMc0Q6zUHrbkyjcmCxqijZifqB3JCCqEfZCASjj/GNjZZKlMYd4KhGp9RE40nbw0jDY8SEsNyMIXDciVRUVvt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkG9sYeqXWkUZgOQYxB8nKv5ivTwkbVjaalqaDLMVmI=;
 b=sD+va9ExOByQNmWGS/3gH3+IuCBFzTZcy7jG6tJHPFRGeM9r+sLqcMsP1qaNALBEZxhJtBVmsZ2rd7djUwY4gdQDe1w7nLSWlNICduterDah4s377TWKO7SJAc+L8AQYe2ywKsM3XlheAnI72aBz3b3DmUgmN578fVf9pJLQpHFe5PmoxLpCyhyEzGWwY1WmA5GbFC4/W+sHvdH5JslXMbv2Rs4SLL4e4I5qb/NSRG58OBIlYKwIKluEX9nGBz+le/I2ssV3rmfutcQncwA4aO8rDdibYaxEYFooJTcvd1aenv/UPAGquToy+3o5/wY8SO15TG9uaUU6c3MuiOLeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkG9sYeqXWkUZgOQYxB8nKv5ivTwkbVjaalqaDLMVmI=;
 b=a4nAFonr7km61fXtKarhNVPNz60/fnghq/GW6nfDLz5aJTZ5PVzn1t+avPnyi0bUFyZwcyMR6U99aYvIUTeqDHatPZasGymwhOJJ7bO0yfoGPCYp+DQltywTm+5MJZPYfkqWBqno0d0NKV+P5b3qytFKupRmlJwTFg0g94elmeFA5RC5I9bvEgM3+NQtxlxg/yxBqprGrIGSmAkqRqvHMSOc9hIf0rhQAxb82oiIJlfHePbgl5IFekt15dYsqQSgt9cZdR0KYDdo7h000yNLX3B4r+oRUNhB2HwYBeOYzJ2OUP4yuhTH/6+nbviBnLKxu/xiWG6Vqw3d4Peh+hjXGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10192.eurprd04.prod.outlook.com (2603:10a6:800:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 15:56:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 15:56:00 +0000
Date: Fri, 17 Jul 2026 10:55:51 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Francesco Dolcini <francesco@dolcini.it>, devicetree@vger.kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format
Message-ID: <alpQh0ASY1HgdNqE@SMW015318>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-2-francesco@dolcini.it>
 <20260717122808.693211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260717122808.693211F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH7PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:510:325::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10192:EE_
X-MS-Office365-Filtering-Correlation-Id: 316639dc-c310-468d-4122-08dee41be565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|19092799006|56012099006|4143699003|11063799006|5023799004|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jTRwSPPbWxolW/BTy83WaOJ/Lq5JsFaHKPIBcncDbW2PAFqdMay/4GHR7KpGQ80euNQlG/1xEf2k60TIVLCFpMkh2XmKe3nQqkIilY4L/AaiduGbSze9igvC7AhW8fzNZvv+In10Ynb1hbortVqHuFx0Jqg8KM2O9xhoP0QDxG3Evdj3oM9LB5iFzskLhKIuM824h8qeqMNGijxVARThXsAdAhRhrM6daXAqHHMlCbSvToqDUfGwqrxPM7ssJ9Kf2BeAtELYzZXgUj0aoypG9Qfy8zFNDV+3IpXRfEL2QBPRWSTrMHdNIx2SmHhtL13pLcvK/6DiyzLnL+i0MsZpB8chPDep6deDWWrOfOvyjCbF3PBkQUbo3VXBvPWCPVo0ovAPkhbnwunYO5Khw+5gVLr8HJY+pVAIuUhYSnJhjFZIOkn6GKewK6SAaqjJf/rdLKX/lQQhElGE77figFXPc8qzhvIGlIbfTpiMaTIh/6IXBJjk7HGyg1QLM5t+HX6bm5wFSE5ytAn3cJI/Uj7UHieBljhyqAgSB/l6aYgaxTHmBnncfLtN20S7dYku8uTcjon0we5ssoJp/DD0/TveCdghZD+on8Wkhhc0mjwgQm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11799.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(56012099006)(4143699003)(11063799006)(5023799004)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ZkPJDFqiZygnr1O19YSg4aaHzo2a0ikSC80VRGq1A2VnY39SGlyuHpQz71?=
 =?iso-8859-1?Q?oFhPDtoTmXrigiB46HbhZYHdAqphMsDajoMBd888BgI84BYeTCH8HNUD3C?=
 =?iso-8859-1?Q?YaU586MAsU1GVt/zL7omyEk/48zeBxp2LM/vhwU+96h9JDcU4PaU5uOngn?=
 =?iso-8859-1?Q?HIkMIMIKDp2v2n3e8BZZGlPsqo2ymhNSxhIp27RkYuZJNpBTo4yz+bG7qq?=
 =?iso-8859-1?Q?L0e0fVUF1t8YTpPoAF74+W10dNF7RNppOlr+ubytoV8N8CGTTH12xRyIWp?=
 =?iso-8859-1?Q?iswmm1AeXVt7QMLEWFB16UytpJPsQhGO4zmiC9ARqInFuBus9wLaEtJGfP?=
 =?iso-8859-1?Q?ZpQ8JX4hSpGpnJAvNOnbwv5lZmJu8e1jcx90ZopfHBA9g8mAs/AqKAGGw1?=
 =?iso-8859-1?Q?982+yn+pncpxtXyqfgbgBxqwtZe56lGvae/8yeLeSH5crTjqkHxXsy8wr9?=
 =?iso-8859-1?Q?/hWF9lY7IeTWTayWBT0RpaiUJFgQhVOki8K1remNtBIMjqLHKpY9R8w8w0?=
 =?iso-8859-1?Q?misS083vq9nMaUCXhrAHBRqp5+402J6ksSDjNPLYsDLTexcvSUs6mQ0eGi?=
 =?iso-8859-1?Q?cgynG0bur4Ruv8+9gbK3wlL1D9cVge7hb/e49LUPRgoz61xIZVgDmUMK9Z?=
 =?iso-8859-1?Q?JfocyMT4lQFWH+ymqA5VvN1Aa+AwgCdOFz+klCeDapzkhtBpw/qAwU/2TM?=
 =?iso-8859-1?Q?zq3H2sy3UD+i6sG4M//BR2Hnxi3dYY4a4wK8Dpe6vXPXy33gzY4fKwPk8e?=
 =?iso-8859-1?Q?bUF5xAsl0HOaRnlHWr/OOVNybW/ak6oewUa9vw+ZIWkYztotBgC420lkrl?=
 =?iso-8859-1?Q?ZEuD5+jmmg7kCm7kgjlYgBz5B9lCkpyehfeU7YPIJ50tLKy45xkXydJL7I?=
 =?iso-8859-1?Q?rJdIESlaKIs3G60O9LbagMaKB7hYufxyJJl4gUOSDSe+cWXU4M+W1yDyn3?=
 =?iso-8859-1?Q?tm5ULEzv04lS0Odm5LueumC0rIcHdrlu/MGUBJ5j+tntzS/IUtTQuLdpZA?=
 =?iso-8859-1?Q?oS5VhV+aj3rgktVF9z8KOFSvjvLQcjV4D1JkgqO63xfEJiq8JauDjUXYaJ?=
 =?iso-8859-1?Q?SNPcGGdNEOO9R0j1njZwhAsR/cLUR/yD1QR3oSPeTo2tPnm1YRkyhQ3rUw?=
 =?iso-8859-1?Q?LeFpPdBD3tlldcwooDNlYK8RGqhe3d45u1diIB8XymY2Y9f9oUcjRMn1lX?=
 =?iso-8859-1?Q?sst1dzwFqJOuycWRq70asPZeR9SJzNw6TWkBosLQ6Ot/r9M5h0X0829f2e?=
 =?iso-8859-1?Q?BppQJSHGEnbj5r51VzJWDNGJus7bYfEP2Wpuv35tGbfC9dYDtS7A4Aq03V?=
 =?iso-8859-1?Q?yH7fv6/78P5depwL+CvGtr4OCi3WUTc3+iUiT+43kQneGGGGM2dx+vDIF+?=
 =?iso-8859-1?Q?Ndx/B+HpONv9ICwW7UBCZJ6M99IQwtgukyqXKQa7QDsXc/8hln7u3Ahicm?=
 =?iso-8859-1?Q?125CXmYUwU2+WFryckBg1udfQtrTHJQ5sG4WF50BjttSwM9spS4de6tMIS?=
 =?iso-8859-1?Q?J1sSkxggp7XZWXjzBeJHg2+Z5ED+DEAnhLEvQoi+vhY5tBdVHuPL8sHdCY?=
 =?iso-8859-1?Q?9bsOTz1lvZzy8WAsddjWTh2f3YZ08UE16BBfpAmwMWXS2pgGbk0hYd2k8P?=
 =?iso-8859-1?Q?urN1jWfjTjy964UIeXv8DorE4/VDvqDSNw6stRChoNOiRBrNjGnBtZMeLh?=
 =?iso-8859-1?Q?NEFgeyIVdvs5DV0xMb9ed+jYO/g/xpdPFTbHCnBznsWYq8wWFIoSRIfgsM?=
 =?iso-8859-1?Q?G2xpv1NhX8z4WvgIbXm0eTmlz1y0LWVqHEp2BQwT7Mfsc5WgRzfxG/CwC8?=
 =?iso-8859-1?Q?0c3OhFwxmOYcrKsB4mbRnKfFdNSQ3n5Wu56Ho1evzD34AscLhohq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316639dc-c310-468d-4122-08dee41be565
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 15:56:00.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Dfix/R2K72wyh9S3bdJzylIjxKQr2jri0djjMXjy6od3ihYe6WqJdIg+DRlzlT7Ajb131C2L6HNLrKNQegXs8HbGxEoYzRVGGyrPYLViNYanuiiGHPhCLazg/NQL814
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10192
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

On Fri, Jul 17, 2026 at 12:28:07PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Introduction of the legacy, non-standard `interface-pix-fmt` property for a standard hardware concept (parallel bus width), violating modern DT principles.
> --
>
> --- Patch [1]: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format ---
> commit 7225ea545d2ff50540972dd75d375b8ecea4f315
> Author: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> dt-bindings: lcdif: Add interface pixel format
>
> This commit updates the fsl,lcdif device tree binding to support the
> interface-pix-fmt property. The property is used to describe the hardware's
> parallel data bus transfer width to match board wiring and prevent shifted
> colors.
>
> > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > index 2dd0411ec6516..209ee5a96e393 100644
> > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > @@ -58,6 +58,13 @@ properties:
> >      items:
> >        - const: rx
> >
> > +  interface-pix-fmt:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum:
> > +      - rgb24
> > +      - rgb565
> > +      - rgb666
>
> [Severity: Low]
> Is this introducing a legacy, non-standard property into the new schema ABI?
>
> Standard devicetree guidelines usually prefer endpoint properties like
> bus-width (defined in video-interfaces.yaml) to describe physical parallel
> data line configurations, such as setting bus-width = <18> for RGB666.

Make sense, can we use standard property?

Frank

>
> If a custom property is strictly necessary here rather than using the standard
> endpoint properties, does this require a vendor prefix like
> fsl,interface-pix-fmt to comply with modern devicetree naming conventions?
>
> > +
> >    interrupts:
> >      items:
> >        - description: LCDIF DMA interrupt
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260717121847.488148-1-francesco@dolcini.it?part=1
