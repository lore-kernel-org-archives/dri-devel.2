Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340360A2607
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BlcGd8zP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3514510E0ED;
	Fri, 20 Nov 2026 13:21:47 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E4010E0ED
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:21:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXAisG3YReAMku7yjNrsCZbNb5+cLEEXBsXuSOkbpl42qfRCNxloYTopEUP71eSMfnV+YgXRnhOgA1e2F8xFUcgrI76t/9g2L7oKu+zFqw5SvMjQRU15gjQ0zkU2xM/fAYiGoeVIkcPdN9wJnvsI2b7MAXGno2f8olmeoPyv+l2eL3KEOTGRQa6wrU0i2sPtg544+LGguVylJ6kWcmx0+gWwgK0MuN9RzWTx6mMgJVxYwSc+UyEjMHJRr3TYCslnh3UlUc9iYLww8eMI9IfX/Ur061af6dqrBMMuyt47kqkm5D8maZbDgqsDVS1OfVlFKhivih0UCrLUCAnplQcovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd1UlZJk2T4uPMauPNHWkG+WmC7STk1jZMHFCBmR7m8=;
 b=w/sDD4pFRLuxraovsoP8DF1IolXDYYb2bQz+pQBkcRicr9imhZb12PZaP5WI/9xgRim1w3viCR1IlpbyFn1CJnPl+JYvYYXiv2nd2q9Ovtpd9fSLejgb78k1K+C1Vm9CugaYTdAcILYrI33b1p/WJaJu2AcwwCbzmHjeZrMp0NLHe1ZVJKU9f8ygtnpSuvQKoOvvd9X7XHHqQ19IpxGWI6mZD28ljRJ9LoTfEf61/0rSFLUS4ArT2rXkTjikRqgYtkUlo+18sqzlHKdFR86IZxYLC6/s/pOUCpb4m3/1Vel/vVN0GAkaA8ESiEsyqrioxp7sepA19khQcybL7ePfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd1UlZJk2T4uPMauPNHWkG+WmC7STk1jZMHFCBmR7m8=;
 b=BlcGd8zPoAFDhD23mOP4Bn8vp98adc298gObvIBMibJJ+K/Crk/23hHwhuqB2M6hKM5mSG7WaAWhnes0wjGUEHnE6S67m5AQ1I8jWWk6U3f/50BmVyCQQSAnGg0hEcG/0cpuhSA+IhiNlK9Ovdk7vSkLkw4WKJh5H5Fd4L9KUDMLXyOUWgMGyAuWW6Pc2N44TN4fdRwfhpLpGARfcz5JbapWB4bpC6I4YcynzD8B3NwwQ2iqoWJctoocjCWHqIY5SsmKXq7AmuxleRGI2uRR7faH5umr8esBjCusmtvfYM1GD4Hc4k6tybwp40eVEwYWwOM3m3beIu3Ss/CNUS81lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU2PR04MB8789.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:21:37 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 13:21:36 +0000
Date: Fri, 20 Nov 2026 15:21:33 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, 
 conor+dt@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v13 2/5] drm/imx: Add support for i.MX94 DCIF
Message-ID: <awBJBXRvvADJDwEv@vm>
References: <20261120-dcif-upstreaming-v13-0-966ac248773f@oss.nxp.com>
 <20261120-dcif-upstreaming-v13-2-966ac248773f@oss.nxp.com>
 <sashiko-outbox-225210@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-225210@kernel.org>
X-ClientProxiedBy: AS4P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::6) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU2PR04MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: cf7bb928-7c9e-4085-97de-08df4709343d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|19092799006|366016|56012099006|11063799006|4143699003|261009223027099003|261022105027099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OsMq9ev66rdfWKhzv9w4mYTwcw2GZfvSQOMuQp2CPa2tdqVjvXtN6rPU6bpKeqiierhFvgRosslrFPZOYnfdndGWIndrMBRvEi6scCTz3Xh2ep3tY/HopRLJ8VDNqWxYPDlWgF35+9LoNsLN+mkpP6NXcihZl/P8f/7AgUJY3mO3MPHzxJPT1rZD3+e2QfjytjL0G5sWOs1pkn6gXCpJ01xQ1i8aLEtEhwjneofzwGGrkhX3CGBE4bktY5idIeQdYpSN9Von8pCPRchXM6d/CD8LnMnjl/szhTCJOxtul3mEmgjeb7jnCvSYTb3E52WYREoV3TRgFo3LIdaIjdBCBqN6ClxFn76BRPbya6fSYG6ECc66n18uKECPdfdRpcnfNXm3srrlmhdaOzHKRLSmQzf0ixxO2j3R7RTEnrSt4kOS6NMEyTmrmtrwoVi6CkoqMcH4A8BfCG341DcIiScpn31pRdGliq1/Wy7R07d//5+yMv9NjYjbOx8VGLsE8jzQnabdDe/fXPRvwj2EIDOhff/OfFSgc2ig2JZyYVbw2zfNYz8mSguPJAXtK/ceatBOFkA+9vXgsHpH2+l3qn3LFDRbxwIuvEr4634OdMKp0vQayGsSVh0rPmw3BUOaMBkS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(56012099006)(11063799006)(4143699003)(261009223027099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Zgo2KamjADR5y4Ny4pnXqaWz/7cZqUvxPTwiYwMlA+mlgFwmgz4tS6hRK3T?=
 =?us-ascii?Q?2/UQYCaG5jbeWxesO6MarAy9INFBN13wX3qAroGUpdecSoZ3WA06zR3kbj0+?=
 =?us-ascii?Q?LkAmJMbODsXfHdHS7onLxIRntG2yUdw9AfUblFpo94az/yaDGxUfl6DPFZJY?=
 =?us-ascii?Q?vE6pbkcc/7FDNyiRmca7My/lkg1kRQPqznN1czzxrKiI1TXeq07Ayjzjo/I+?=
 =?us-ascii?Q?V5dnT2kFv5F8L29J99Ij/pSl/pb3MSvkSQ53Ul9hPOJ9Ar0kB7/r+RZCCmZo?=
 =?us-ascii?Q?z/rCy/4Z8AxdfU83JrD5Mz3o6N4HJnfiofZH40N/QevQUL/SXswGl/OQBrwR?=
 =?us-ascii?Q?sMpWTRlTTAOnIzmqldpT9bWumHxpmWz390fk8jD4vGUZP+Wpt4D1GjiQKywW?=
 =?us-ascii?Q?cRrUjkWVaNjgh529W2iniEFiFqvEhEjhDHvcejbJGmbvPR5lBkm+VAUHTjhF?=
 =?us-ascii?Q?qUF6a2CwAapyJ7X2gY/gKiNNiC8HdPJj3RmYSOkenKvwynsD4DEj0KCzj80V?=
 =?us-ascii?Q?hANpi05nVortBjDQPGkPXxavpDfCc0KkNY2XH/USrCR69PMnUl/sVotjEIfe?=
 =?us-ascii?Q?EawJ7Xb/HRGm1lodtJCPqSzqUcDjcnIu4l3o9N/iRa+RIHLXp+7j2qxKRcgt?=
 =?us-ascii?Q?ah+FboMB0DFKW92VH5a8V8qrf67HZsBZXzuyGS5x+csYuDkeYK9st3MDk4L9?=
 =?us-ascii?Q?h5tnDs3JWyq3IKSE7fZ36Fyaop0ieN+h0eCYL6lpYRwZuw2OMpZTVlrZkEZB?=
 =?us-ascii?Q?I2zrE1xx8F0gA1Dc3aIcKYlXJanDsjQMUG4y6munNt9s91YNolHECwvgoi+a?=
 =?us-ascii?Q?+1DRNK1f1WOs7mYkZWo7gfV58E79Ek3tF6yoVN4wTfplF8PZC8zUia9YfLER?=
 =?us-ascii?Q?p4HfIiRVnGzW2SHe05/CtxFmjuzG2QrhATWKARoYOPbR+adTt4dTx/XpSejj?=
 =?us-ascii?Q?K0xOdw+cT4EC6Pu0wW+pCABU5ZP70cdMsPjOdDigR0P3aAfQKlbJW7kzfe6r?=
 =?us-ascii?Q?ySYWkT+XXHhUDCR91cNq7LmpUezOTuMGKSj7c/IUQJ4rgKRYNDkh+5QcMsi5?=
 =?us-ascii?Q?NndaYcELMsXLUNgFZjTPQkXS4y2se/yIgGK9K5JCWm5W8SedKizluLW4b4zT?=
 =?us-ascii?Q?VbQ6hhr1vWWPud5tq+aRztctVov7F/AxM6IUUn3X0ElGrRK7Z5b44eZMWtoM?=
 =?us-ascii?Q?YuQ0CQun8K48K0ohZwnan/oZZNGxcpD50MTlMh7+tli9L0LW3/9NpB6j3zpF?=
 =?us-ascii?Q?GOPT7mnuNJLsOVdCRAtWzFe0KfjwVQRFgEi8NYheUzu6gaCG85VVL4xkKGfI?=
 =?us-ascii?Q?OQvrQJat1/UIWJhulyBlcJInWEyRMNSE7k5SwPCBeIlhRyhanzidSR5gFkaj?=
 =?us-ascii?Q?oSIJqq6w92ZjLxc/TnykqWU1lzLwDc0aGwEZiUq90RoDZgCmMaofbu5HGUyN?=
 =?us-ascii?Q?2tqIr4aBWRTc+bwhda0TuCYKXPZ9TIof5+ozovYqgI4MRGpw57BPpNcpC6+B?=
 =?us-ascii?Q?wpHL2p0U/PgtYIEB2+qyJIDIQyQ4tpqUV5yKNQvIaSzghN13hE6RcBT2DON8?=
 =?us-ascii?Q?eOQVjsU9a68DQdrAUz+zLNTwJnLnif4axv8ZMKHBsXbM3M5lKn1DsZ8/SC2Y?=
 =?us-ascii?Q?7k02KMnUlhtWlBIO2WjFvYqTlkaWFA3n9pLO5AclrTkknuP6Cgu7n//1ZMle?=
 =?us-ascii?Q?UWu8qFjdPuh/vcVMDe2jHcQh5p8kXyEksrTqTIO5xKxMz9k4cJfwUKlCOyT1?=
 =?us-ascii?Q?30sSq5NxOw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7bb928-7c9e-4085-97de-08df4709343d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:21:36.7911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQq/s/CJlU/lHQ3bsf6z+/W0KiE9fJ86Zx9kS+bV2bhGBR3xVCCoUwTx0rUaSyFliobJ7K1WRlbqcYg325uQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8789
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 01:16:15PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] drm/imx/dcif: unclocked MMIO access after
>   pm_runtime_resume_and_get() fails
> - [Medium] drm/imx: dcif: unbalanced clock disable if
>   dcif_runtime_resume() fails

I mentioned in my reply to v12 comments why is not worth addressing these two:
https://lore.kernel.org/r/awAgaVs4LLwqVA57@vm

-- 
Thanks,
Laurentiu
