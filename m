Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54236606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jVQDCZPa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A842310E2EC;
	Tue, 10 Nov 2026 08:35:04 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 805D510E2B2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTbvkmzYP56qLA7TH/njU2FLUJkPRY5jNcutfynylRHrPMRBfQsr3F6UPCF0WvynubzTYwFXxJJYhfgtkVeMNSOhspyfy9zL7Kn0VuQ06+izwLeIx+pfNm5OMmtPjZ1N/vH+o4P6mNaeUhigJZm3KBqYpJtsK7jb4rUc6UENKsdZbRK5A8qlR9aIOQc9c2WTBI7g/Gci7QopQ/ylJJUN17VGisZk09GnbMRC4AVHukGW2rA6Nz0jiG35nWAoB2FqsrDJt6JYkHeYXhGD4dVs1Y3SmiNUPawwPXva6Tu8jbGor5T+qYKh0uZBCYdaP34gW/XT62YZB2hrh99gZbFiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxdYfhNIGcLTy7pBHjHACuWUN6SJ3I2ZaHi5jvbf0DU=;
 b=wmDfbzHYwgaWlXgCNdMmdM0pBh5VcAlCqXhoB8nvw5xlwexb6Xz1tgzErNx+eSIx5o1mLWgUgpg8BWGwHnWohMYQiflCTC3ON0eH5VqACTNXMywapBlPhfvyYchtR1a+ku0HycjE7Z81eJn+I7USvsE82HMnhM0quYzjfNrYrH19eydAUhYnp2+P4mjOBCkYKotItvSWGBcz9OiEAyEP53B+dNgx7TWQQnZfkTlTLixgr5F0S0KvAin/hS6PjsbuUNuJpbMXLMtIe2z9oI3nLtrsTAFPfKcm/0/b6y7mdQIHaPvp7B2hFpkYZ3rUbjl1bCHXOVVaay9SSiuAcHbPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxdYfhNIGcLTy7pBHjHACuWUN6SJ3I2ZaHi5jvbf0DU=;
 b=jVQDCZPanIVd4p9mcLC8lRFHRMpIEFT9tRyAzf3GscgF0JHdEYD4vTKhgrPs23DBRBmau+ypRuP4SJYqdXmhhF6LaJxgC75kQYrlQQzLnLR6w4uw/RdJy6qvhP1Tvo68OrQ1E77TKl/x6oteIDtwUUBvTmyswOnAbxuuXhm2HAH5ipRCt5s6SxS2iHb1uq6I7za6ZxB3Yx+brb76AsYSuADrxY7D26JoQBjw6vO9pHfD4hbQmO7XO8KyvxAgVEf4h9wQoWPS+nQseZDP7Jxu3eq+A4atmikFMIkYGwg+vBcwoPFrcvE+ciXJuR/KGh4KYQW03yFI/59h2bZ5aXdP1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by MA9PR04MB355377.eurprd04.prod.outlook.com (2603:10a6:250:109::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:34:19 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:34:18 +0000
Date: Tue, 10 Nov 2026 16:35:59 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev
Subject: Re: [PATCH RESEND 17/83] drm/imx/dc: Switch to
 drm_mode_config_create_initial_state
Message-ID: <avLXb6qxA0ye7xZZ@raspi>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-17-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-drm-no-more-config-reset-v1-17-1f58d1e33380@kernel.org>
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|MA9PR04MB355377:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e25c453-da6b-49f0-3f13-08df3f056980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|23010399003|376014|18002099003|22082099003|10067099003|4143699003|11063799006|261028144727099003|261009223027099003|261102123227099003|261026140227099003|56012099006|261021121427099003|261022075727099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: u4RRm5k+NH5KpZIj/fYsM+RXKOJPn+fz8Y7tA6+WQBjkd+0KigowB+XWuVanDvBuIfSw8mLPHxOVPEE65FZvimkcoT2Geyx/rj7KWh8kDzWsLO3PpgD2aJ+U3ZRmuxRQ7RaCaf865TA36OXIb2nLb/jIeAiK13AIhKGVY2k8CDOa62JA68/GWmbt/u6pzdRnuNwLJkUTXB6SGf44AqoOFtcDv3DvxsrlqapNTDOwQnQpCKQ/n6zrVAjHVMcKbBd2bzac51CvMbiDeVYGnxYJXdQx0NFcJmxsJ8KL08eKRT2xlXl/ZQjK4vmGKGXNzubAY3Z3iNcCWwstu/M/USh5PeB0waTj/8w9UoZ45d6HkNzDFValfyptTCDSbbpA0tv6VEizc+C00uLvw3Ou8ra87V0Uht9vcSTSaTxNgDICAYnGY1FzT45E5Shg/cln3ER7i/fouBrSauYqgLDx+Q6eq0tlblCv+S7JSt0YfLguNHmsLlcOj8mUzQzEHzGy593FHl4anmjMtpEvQySBVC/UFSnBI2iql+pmbh3nzPDj+ex61Jd/Tr++SYYTTtCJS2if9XKey4LZbv+kqKXk0FUMD30SoA5OaVrIXL0E5rDwguZHpUY9UceOlWu5DCsKABZcwThCrAgdROmLm5GGQYs7PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261009223027099003)(261102123227099003)(261026140227099003)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tDSOssON7reUm9yy7TEuJfTAFRF8YLURr94SEVWXwFcdjHuid0E3k/MMiUhp?=
 =?us-ascii?Q?2CeKjAexoP3DZjru4b82O0/HvVk9LMaOZFgYLoR4Pbto+aRpkQQzlIylSGkI?=
 =?us-ascii?Q?c1VIEc/bRQ9vhyfo889ogXnz+AfH+Acm6ENu6l5Y9BMQBO4hqEpXLsSwNEe2?=
 =?us-ascii?Q?QJ75BxRnd/4CBrJhaYjr2Ih6S9Vh/prk/P6H0oj7+OBvVRaWbDG6LE7n/SSJ?=
 =?us-ascii?Q?GnYaebgWeVWo4XCF5p9YUHU/ePyBrIiknpofIq0nn+eFSuPR6R2nY4bA9eBR?=
 =?us-ascii?Q?LzjbbSdZVeqtfKMpIg24XAL3APo0V3gNRNLUyqzbx/wZdn3Lc0xLwjR9h069?=
 =?us-ascii?Q?ye/z9Z7zif/tNR2IS8wFuyRPhDQl6HL/EIDbLov+b+lEGUOYKj/4ZNswmXi4?=
 =?us-ascii?Q?ylJYBJF2oNWOF0mV46f2tKroS+1lxhSXkcpNGyf3ztxN8nyOszLhP4mBj+Dc?=
 =?us-ascii?Q?ljrgocrOc9MQuu77ANMT7AlWg6QRjWN22yoYMuuG64k+NtPZ5FxwkYre9yXc?=
 =?us-ascii?Q?Wf5N6Z398V2o8vpeFK2l7SheOeQkXL3ommFJk5i9Ap7298SrL45+HdKbmCtr?=
 =?us-ascii?Q?flV8UEgk/ACycWkt8o591sCz1XEIZAp6Qoknigm7WTzJkl1vqU9cG2ioOYrj?=
 =?us-ascii?Q?iCvXzzMtGZdiUgSecQjCVvp8oSq7DYjHx1yPt6fMlZ8leIVW9Dw7PW/sLHg/?=
 =?us-ascii?Q?IE4xwXdqBGQXBPy3Qh4dEkfksX2tHgFh2zQrsldKdXWlKSNZNY06j94MMAid?=
 =?us-ascii?Q?EmWG9xPiVheXsq6EqoVsW+eTRF/lP037kk4I2weL9PMBUR3WMes7e6IKDFFy?=
 =?us-ascii?Q?EYulaT0Wn7ukF6yXwkEm9eCIH07+euAqLXVKNtJW+ly3MZrauwGyW9bgVh0o?=
 =?us-ascii?Q?YnmumM/40c7SIf0SffnfDzBhBfI1x51RAkpJo35N3kni6Zb8k7ZJ1/ly3jzV?=
 =?us-ascii?Q?MbCNkMqj2PjCDSYXr8KMcmow1OnoEQ4zY9+gU/pJ+q+G7kVa9VpvP2irnCuD?=
 =?us-ascii?Q?3Z6+mt+8nL5EUDbwhSbPsXdulqmbbz63VFwCyIDK/ppEmzDTEmDiNqrnmOfU?=
 =?us-ascii?Q?9jeoQYN58Lvmfm6ZFU1XRM9C7BWBd6+h8QE91SHJP3Oy1BqjQ5G0d0xrqvZ5?=
 =?us-ascii?Q?1+YvmvArqwPORJl8lljRdxRIgSciYsAOgNpRDNoOwcCauCxY61GBSn+DET7C?=
 =?us-ascii?Q?Sn1usto8+F5NR8vs2XT5DTaLJammcqeOp009xAJJbtn1JyKA9L2sgglUaozM?=
 =?us-ascii?Q?O+1JH1pt2UfnwHSIuBkUIPKhaWsUtK29MPifK/6HmdBpu+lnmeSuyPlUcYJf?=
 =?us-ascii?Q?DCA2ogEImK9EcboYonADrrqaS6QcaqzR7289ctbPX/IERPfH983+nDC32qAA?=
 =?us-ascii?Q?Y4ToFp0eF2JKCAQaHJ7DReIWYR0EqHXGdpv7DTop+SRYz0QYBHzBIzDKOslD?=
 =?us-ascii?Q?gFevxaatlUu04vxsRQR1spdWlVVRKpspg9QP147IZuGXPXn9QV5LcMMvI5M6?=
 =?us-ascii?Q?yIwWwmY1IHypj0nmYLgd2m4MVADuAPF94CBAUVjQEYXRaC92bkgxYgMfXhAS?=
 =?us-ascii?Q?oKEGa9r3ou8myRUW1rdpz8+NS6smcve029j1tvE7WimEt8WhmmjvvPWVnOQs?=
 =?us-ascii?Q?4AXjrOK/p77NbpK+UJX7jkk34y8JXTa0umj14DZfYEIiL5I1XER/2BSmd2er?=
 =?us-ascii?Q?JKuuly2tJeB1JyXE6d047LwWTPkwzQRMrXZxeli5aQT1HdyGRdVzLTW62S7W?=
 =?us-ascii?Q?rRE4DGVVdQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e25c453-da6b-49f0-3f13-08df3f056980
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:34:18.8130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkapG8/bw2Dt7d0o0ghBuZO7QK29eY+gOkCiHgVlvJWXlLa6JabBlU9zo1UGtpMXdFpoAFtXGnteYZLfUF/Mkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR04MB355377
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 04:29:26PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Liu Ying <victor.liu@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: imx@lists.linux.dev
> ---
>  drivers/gpu/drm/imx/dc/dc-kms.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>
