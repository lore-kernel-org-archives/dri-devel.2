Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9663DFF886F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC14110E6DD;
	Mon,  4 May 2026 13:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cMwf+4U7";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCD010E6D0
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 13:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVbmn3SVJihRlknkiBShJUQLH6EQuc+lx0NrEqz7LnN38o6CxsdMwVnI8C6dgiYtF1pReWHJgXdBdqMq1WpoWkyldOoZMtPAd+03/YqvNKPrYA+stEXmvmJxoG04r4WXp1i7iHv93jI3DqaWlWwWHfBbqxXyfCQIou/ixdp5GwtOfDy0fz0CGKQYxOz78ya2enWQnNeJLIqPGJtX/8FPGF/e+D8Mi/WgpTsudkJIG8Vl4RsNFDbBTrbC38xtP24hQsB44PQvgoXDAtgeXZ+ROv0M82u4X7dOTMPoVwVf9SwpbtQJrfCUrlaSCef/mEmPesMt0ZoP++yy41peXo19+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=povR5NNTB5IFgCshnMtk/P6aa49ykPVE0y/ORjCr9BM=;
 b=X/dP03B+zHo4SCh0UQb3X+IOKEHy7w76PLv2m3vbWJIuYJbyRi4ZqHkE4N8vKf11CRKb3K+AeA/zloF/ZewxglTFLR4+N8kbggSrV+P5nY5fZJkbaR6/eNfVjqyCl+YNEZ5xcLURJ48eBSZB/iMDqxsuTgTB06IgEyYnqvW+ZnuoXCF73EsdCBW2MDRUX11PNd+sqANW1i8+JEiuNHhfvn7zLMEScUMBdR13gJ2hOfR8J0KcwjUrIwxw8/m9o+F48VZ+DbNEHWHcN6+ZA9OpTZb3zU2PpORDT7AN8UOvfK2WYu0qnco2kEpDQl7zSCzU6kQ9wZ4KvKJa8sPGMR+AFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=povR5NNTB5IFgCshnMtk/P6aa49ykPVE0y/ORjCr9BM=;
 b=cMwf+4U7QOOCprl3Se8VdGaBT9SWfQDBPY07PESFNz/Leso3LQeqe2T4ZFMc8IcTOKTsIYSe3PUSNXDrLMaJFAH7EtrAiuMZk49OESTBhmAeTL87VIfcAvtvcr1vEDQZGlzKb5Wc71oWEdx1EoOdFqX/n8muLlcD67ExxgdCrLoSuM9czz9cZKOqvgyLHumf47Tdl86V6bsgPnylsCH6XGaqljSEogvrwg2XXiEdugBXyWY6eapmFQHKgloblFZrFG/nPeUiPKYDTwvpghKM7qkRvLRnkQO2FjBOOcttBxIXi0Dy/L+V9wB4cNw7auRZco18cZAaZDsNPBH1xDHmLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AS1PR04MB9502.eurprd04.prod.outlook.com (2603:10a6:20b:4d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:07:30 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::3826:2706:1e81:c9e2%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:07:29 +0000
Date: Mon, 4 May 2026 16:07:24 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Marco Felsch <m.felsch@pengutronix.de>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: ldb: Require reg property
 only for i.MX6SX/8MP LDBs
Message-ID: <q2sfuv2qqzbhn6hlsavp352v7oj7ph3lmadn7nq7wzgexvtxkv@utcythnlzzno>
References: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329-fsl_ldb_schema_fix-v1-1-351372754bc0@nxp.com>
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AS1PR04MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 497d34ea-a374-4e7f-a645-08dea9de1858
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003|27256017;
X-Microsoft-Antispam-Message-Info: hoVSKub3FDvuylTOoERhpLOkKLZgtw4HaWrz3vm8s0AkAAOV8Z23FvzclUtx/ZuZ1hJupfNIk+mbGuqHJ/zcpQX/h9xiDSh72Rpfaqu9bANyxwcgU/yNytYtu+yZDh1aLGOA15VTe7TSQK/qU/guY9bx2S+Zd6Qscyb9t06qEEESCx3Hlsdrxqvmuhcuh42ncPLp2nPsDDUSiHlkryiEqt84ucH0dB+G0prlnUtzOd31Z5K+VbemOv2cMLeHqXaQ0HocoTGW4WllPjlIs+onFF0JRlh7HWI+DFdCbthVG88IIMIq/HpJj66T2HjuhJgFKjKlG1VfIEKjfamiuSm8625CoNPM+Gvm/rW2wZ7GcPCg37jHecLv+4lembF2NFbrXq98Wx0MvYZnEJK/gamBGYx8t63Dhi6XCw5dNVsVlWMmAm868qzb+JHkgSJAvWLlnjXZYMIU8sx7wiznXqyhxAi9ezp8j/rOKEWfsfF82X6YBRbnLTm2XB79eD5O3zOnhsERxH+re3i95X4FSwL7YuIedp/bROVIWdOLvn6NtyU1Y6PMtXdrhz+dKQzqq3oUvvbLKSJhPg+nXtzbWRzyF2BZbn0gKpFIM2Ze3Y3lUTpR8/bVv8LfvxHP5vrxASa1S1CFxvuXom0NRs3+FEr6I11K2VpqqLbwjeilueW/BiemZr2SEixziXq1uGAGlHzWK+2rKsh+LszKn1o1VDBz07egEqYjbR1G1pb8CjqszrNJtT30Te5IyN8h6Qrm4uN7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t9BtU41ja/Ahxb0xtXmw5zXRh38KJYRA1f1OaZBbBYPyx2fJgnKZwA8O9LnY?=
 =?us-ascii?Q?ha2yj3UTLUSUfUskXBEVvEWi2zLAFqnE/iSGbnBNcxMoMTVdXnbv05GT3YBe?=
 =?us-ascii?Q?wcxQ8ss31Tv8+nnX4uRd9KgNj4wwYZXdsR41Jkvepw1o++PlBVesuWcmh0iN?=
 =?us-ascii?Q?IQnmCYv2aNK2HydCJraoyhZWW5VtVcXNOJ7tkOJI8YCoPNo/1qHsJUTgwsuP?=
 =?us-ascii?Q?a3gQTtIhhTj8ZjxqmwCN+5A7drnCvzoltgv3g3VkeO6jIvxc1RMhuowMecYN?=
 =?us-ascii?Q?xj3NUmbsfROgFX1f1Hy/iIljoiHTLGAoZQZ7rsfw+0URD7Of3BPV5dfz7b9p?=
 =?us-ascii?Q?8lSUO3pre5C8yh98mElaLOhUwWo8XDRaN57eAoKXFnd0omJiVDHDyaRciSWX?=
 =?us-ascii?Q?W444nJS6oPkH0iRHQh38SUhrF9TRMgY2REkNbm2mxyBw77I1hPEWe2LMDxYP?=
 =?us-ascii?Q?YVqfOFVN1KCnAOOUA2G81IA7XSD6cYZTGuW5PtVuCGsCZZDu/ti/wt/6zKX1?=
 =?us-ascii?Q?bBD7OIkB6Mj0l4V84R14RaSiYXrNxmqGJW4v7GR3il5eV3GbMug7lPlkh/HU?=
 =?us-ascii?Q?Fv3f/LkTRE29wxJc6ENvFheQ+wzhwfa8ZsTE80Bwu3cQ7V5HnKNE7Y/AqoOO?=
 =?us-ascii?Q?L9T3+51hXK2zqUItQIX7+I1BP/ho9dSyWD6km59kEaglDaYVQ3AqIdNi6bmv?=
 =?us-ascii?Q?eHE11aZFMXjeQk0J7BapzabgRPvCAy5bxud1nQNWyPE7F/URYl4Tl0cd9lBp?=
 =?us-ascii?Q?a5O2MIWSLKSfZyFmWlzxtsfmqASaqWEcBb0GSHsTHL5uE79w56XRzoGBmIR9?=
 =?us-ascii?Q?AgOBBlxYGyaOAGRBVTb1TCsbKZv6LMHGZynx85rqCDPjWsNVeNKSxPSJJpt4?=
 =?us-ascii?Q?4OiDdzor7Ftgcez09SSbgFxpvkT/4Cdm8B01iLJRk6iNK9PU2RALWPBdwhDw?=
 =?us-ascii?Q?2IABqx0zPnMHd4L1d3nwJ8Wv0+PwizeCT4MARqH88cwLErl+Lb36uKE2yQjr?=
 =?us-ascii?Q?f5NFYYp6zdPRcbUDAUBNv5Y84n1rdngvLYbASMhq0F5xBKYL+UtzlTU2PNXo?=
 =?us-ascii?Q?LsOrvqEFenu3SXOvGVjfnRm5gwNG7cV9VbzVvu2TjZmLS3u2ZkKUMeNtDM3Q?=
 =?us-ascii?Q?9saY+ZEv4v703z7rt1ETWjMRT3yiKj0PIOFts+7UrXGmVXFYNrZ4LeemfsCb?=
 =?us-ascii?Q?mEK95P/i7G7PFHPX0cndaXzg4Ugon0oqHhucigh/mOxLLI1DzoAq8o2BXXx1?=
 =?us-ascii?Q?ocnlH7G4ebf/9DRPxAbmCLOgWpoAs4MCvN0wHjKnsOKqLEsrXCOFMyDPaL87?=
 =?us-ascii?Q?DaysALCk6Hqs3oJFcCrtgjRTN8acMUaXnt0QLDdPMt030DJuoT3x7yrsBuOr?=
 =?us-ascii?Q?mHj3bR46CFTDmfJ7hIusuFxWE1r6EBIdf8HG/2cEZHA89WIkxTzBSp4NrsLh?=
 =?us-ascii?Q?z2ut13A3r67DgLPYA26oQxjGJ08a0JJjglB8uj8O6R44qGYc9ApWI7vHLa9U?=
 =?us-ascii?Q?Lkk/Ab7G6ZwaoP+Spk2XGhhiFW0yoxvYkFImix/AlVcSYia0fIBPKvMkgq1K?=
 =?us-ascii?Q?eK8bGYqimw5BT9/GtcDR2EqchZ2m0phLQM22YtrRzeXRR/NJntn8ZPEbdQOP?=
 =?us-ascii?Q?uywWfXg+uVGgaAD0KzOxf6PuH6nJcWBaZS5GyK1XWm+A/ik/MYrywWyP2tu2?=
 =?us-ascii?Q?UmnumnZjToSaLrvnjW3uHfeV3dhC8UBdIhlUvEDI+mvi1mwRPFj+ZS8ZN/7C?=
 =?us-ascii?Q?nqZy663YVKWu8n9a7/AX0YpUarNx2gM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497d34ea-a374-4e7f-a645-08dea9de1858
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:07:29.2027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMAjfU8407cmXSSfpoZtaJZ79WIJtQxkj+uWe9TNEciUp1GXSwJEL0Br0Z/e9o5/NcRL7UUlYDdHqP7dXovYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9502
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

Hi Ying,

On Sun, Mar 29, 2026 at 03:51:54PM +0800, Liu Ying wrote:
> LDB's parent device could be a syscon which doesn't allow a reg property
> to be present in it's child devices, e.g., NXP i.MX93 Media blk-ctrl
> has a child device NXP i.MX93 Parallel Display Format Configuration(PDFC)
> without a reg property(LDB is also a child device of the Media blk-ctrl).
> To make the LDB schema be able to describe LDBs without the reg property
> like i.MX93 LDB, require the reg property only for i.MX6SX/8MP LDBs.
> 
> Fixes: 8aa2f0ac08d3 ("dt-bindings: display: bridge: ldb: Add check for reg and reg-names")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Acked-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
