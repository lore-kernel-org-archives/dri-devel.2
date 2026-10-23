Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B330606A33B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=t9ow3obm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E1310E6DD;
	Fri, 23 Oct 2026 16:49:51 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010037.outbound.protection.outlook.com [52.101.228.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB85710E6C9
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3Re4RAPWgp8XJnDh7Ey/ErhWe1w1On48CSHrGQlSM50oBkK6aEbhz074HFJJaRRRQcdaaEvoX9lzjVZxDUbw56+drKFeDxZ8Z8hDm77hTj0nJjdWLWT51Ink27W+T3DLyqrlAj+BWBihb0gTREH6mn/bCJjQ/d2mnZNP6uthtf7pmKC1a4+/4tJSxnwlTuLwJ3mJOMxg1oGzAW/xEVHMdQWxXhZ1Tzm2QM2r1eB6OLGa+WJEnmk79mwvIHWjGXLg28dcGLGbWTRfhSMNwwWOVs1LKLgg78g4EH1xqVtzmZWNLksiejIhlH5w19t0sPjmzU+2wt/9fDwl39hZh7pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96VWpJRejzO0X8hk4KkNkntkq+yB78jInW+yJv//Iss=;
 b=oDIbe5OmH8lEi+Zr3TvBf/agwRQteeJzOyNEn475pwI20rGAdZFXtcjvmEpPrVPbhe1dv5+Yy7dF3qxgdFT12R5f5M8AkZjS+bjXyrt47gtkpb3IrmQZhpjKG+4DCjPMHwZShkTkBK9e6pXiDIUgihxKuUOUbh5xpEbVVXmisWWUPa1ewI1CzGbAeuF8oyNcyJ6zCELEHcP94Lqt9R5qgOA+fRWnJ0p3IWR3bcICJPodfljfwJgB7hqe3rJ+L9pMCgrND2G/hRFSdE0EaRmqYrQ+a56NqZdRvbLk790lmXkfLbiOaR1F1+EdSj5mVY9oR8ENqK7htsLHJ7Fr487xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96VWpJRejzO0X8hk4KkNkntkq+yB78jInW+yJv//Iss=;
 b=t9ow3obmMACckrfYTfdqYFrEDFf053oSqi0sbeC3uHJ0jAakwIP0SS55bMAJ+G+IDL+LB2lLuxIF8VxOfOi1Nrqj3H8p2vJwCZMLtHfVqxl+Rb8rtwJQINBGayC/v306SFjTlrAhJxm+7/Nz3nv9+ZLniMeOXsxxF52XkeBUwb0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS3PR01MB9415.jpnprd01.prod.outlook.com (2603:1096:604:1c6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 16:49:37 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 16:49:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/10] drm: renesas: rz-du: Count all registered encoders
 for the possible clones
Date: Fri, 23 Oct 2026 18:47:38 +0200
Message-ID: <da4427d957427b6096facd3031bb265b9d5d3009.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS3PR01MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: ed512060-bada-4192-0fbd-08df31258d49
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|23010399003|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|3023799007|18002099003|22082099003|5023799004|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: qDXzJ0F8JMmSJC2eqV7TDBk/4b4zxl3hmhH+Qv/dLyceafR3NUoP3cRwYi9TGr248Wy6CumcPGNatbAVbA1CibCX057uYEYAJc2SQuCW/2yl8/A1D+zqaTL0w156h/F2T/vCt9T7Z3O0AAS/ER/NW+pqzKPi+wKRheNZZzE4J8cAHUEY9L7hss6PReB3HDtuhCSYVjl/jgWiDVxguG5bzzhiu6gEJMrgnLYziPlwLLGX5qdwwfo5LsfpqI+uSCVvy9AERgTadQiut0EoAmJx0Pr+EbToH7cYzxvoXPDTPtKtE6GtycyeWxHWKvazl/Luiwz+CO3YIkgVmQKHlmONqDRjM8MK+HmWO/X1Y1pLsDh0TJ9LaaDH4XwAOoLx2clqfrdT0qEzvg29yvLEQvBQ/Ew3P8TAH7ZnSLbf4fTdAJlqA/D7kc7NgvrfaMTd8X7rDy6e5qx0LJKuvhIKjc0iWekOpI1weTvIBXm74DflE+CL4Opp/N0rmM68pmIEXjrFtTcgQVHL6vINDvwEKkd3GoKEgOf1fZhmRQNCAq/NRNMsfphZU+YRO4/AA46ctLw60GHhEwakpaTZYKbQfdrvsbtzSIE1dVU/cnYBB0syyrDK/y8uwskxkPCYMNKVsiPqfL4dSDFeBuRMcoasrY6P+/xZFdNJONb1blkBynYzXMdEyB8WVIbuAtLLRQK4UdnQk0qjvdxrX0dLm2qrIKnLnUr/DJgGad5Hn2ADTHI+qYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13588.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?itgjav6fDEnnChJIbKyHNtQeQIiPmizaWclrUWJT9I45Atb/VrSqK0gqcAEU?=
 =?us-ascii?Q?/xsyt8erQaRG+uVO8NE3sf4rWibNdIeVIKU05FQq2M5PKd/SU04VlJvfok7j?=
 =?us-ascii?Q?0rCG6KNdI9OLc/UulxY4LEsAM0S76TQGIhAFWwCrkl8sUlXrDwvrRAdzROys?=
 =?us-ascii?Q?qlrJjR+0qTxSqozMXDFqerb0/OHl6anIJWQIUwJqzRfkKwfl4tCFIEp1ZYC/?=
 =?us-ascii?Q?Bah1F4oEjOQC6N0Nap1MtgdkJTVbd4fbQ3oot703MCFIdApcSpTfB9RTQz3f?=
 =?us-ascii?Q?sSqb7BitrhFHHll+ucORIv9mPVlN96/cHSiU1WzWLofQIZokear+v3Bs8vCd?=
 =?us-ascii?Q?O689RT6kMlbkh+X0eItFfMOSyj6DO0odWIbC5KYXM5GYdk8QN1Gq+xIccY4J?=
 =?us-ascii?Q?Xx7V/8WgeisqWZPPv5wDANMG2HCw9Nb1Ce3eIK0Qro/qUG5FttV9CYq9zIHT?=
 =?us-ascii?Q?Yzm+vVTitxYAPiQyFWsbHk4vXMTKJvkiBpngAntUc6oc8TXJ1DtcRPEMNjEk?=
 =?us-ascii?Q?cj2Ktqrb00XO5ggjlREynUhVe4A42V/DXe/H8xxJMXClpMM9TDzqagtDYIg7?=
 =?us-ascii?Q?xrwas7tpToykYy/l0w3/XkY7AbNGwuqFqYI0ccqKu972EY7tWiPyOUlt45t+?=
 =?us-ascii?Q?3BbnNKmnMhRxbfGxGS7Y3kmDTvDTy/+5j66U1m9RCC5hc7oycAmQvfBOjAJ+?=
 =?us-ascii?Q?gW0990Sv1OZb5gVllqqhm6nW+vTXGgSGI+040llijsio5Jtya1558aRHfugU?=
 =?us-ascii?Q?ZQuBbour/0yB+46qqXOMbGxifOP/a/+Z/afYJbqx540OcLLdyc3Fi3DCrQgl?=
 =?us-ascii?Q?BIry2/KHQ1ZA4Iab1MZWaLguncikiXzR/ZnDL5SCbsc470ecpV8+Z/asTcwL?=
 =?us-ascii?Q?+ROG8rHivUdX8jjERDC75vI4zOT9urjJNOeITeE7uL3wWdIL6eLS5cTtwlZY?=
 =?us-ascii?Q?/gd0j7KUPnyRy+FXVygl70walJQCK0EOyYFCN6rszxNKC32M8uXhTY1D139b?=
 =?us-ascii?Q?1GcOtNEpAtlb7/TOvpEahTreoYPnjaZNB0uI6tJcwhqD88MG9+755eviyIgr?=
 =?us-ascii?Q?nAiHZ3MPAs5sTgTKpfp9t9kdPMwoYE2BxitgNByxTC6T2X3M3+2h24tIyVx5?=
 =?us-ascii?Q?qCExUMSxsikruULnXv3OU6wFTvsoafRDPwrnQSMvrurtnngIci0CMWnNOq3S?=
 =?us-ascii?Q?I6jL/8caTJ8X7TWapjkc4LZ/i7NsYeqbqHueUe65UMvh2z6ysYL164rZ5LTX?=
 =?us-ascii?Q?UqDTlJ+7P1do5SpA4v/lFaYHnIOVFUasalWN9qCil01lh7egSZGJVvOXKiIa?=
 =?us-ascii?Q?p2TV1U9bwa91BPyZ/ZvvIZZjdf8g5dyaNRF8g14wNxphCVJKKqlnJg+Vbk+7?=
 =?us-ascii?Q?APoJQXyxmVsisoO4dTi2CAq4g9BEhayISAuQZ+ACcbLwBruB8j3UWsOGBqeV?=
 =?us-ascii?Q?J8lhlHGg8xW6dSDkVxoU7NX7G2L6/PL6vDzqrzKoXiC9hb2KRQoVCoBU563D?=
 =?us-ascii?Q?nn4NCexUau2y9D5l+3ZAz4jGsFOZ+PID9Erqwy85NKpszorO/fNIZMm9T3Aw?=
 =?us-ascii?Q?xKyEF9w29xisCr/1XyFCpfWCTo8353JxfZbx9TA9idxtPNFdh9onamyl2Sm+?=
 =?us-ascii?Q?YkhW1o0EqIYFlC6+MUZz+bvcYB8AiL/HBTNBZ+UMWNxp4VbIDhP9QktqSfDj?=
 =?us-ascii?Q?Zgf45ED34IAZuGFzVIYRilf3aPoOana8RKlzFm71cif/f92rlwJtdGsgqolr?=
 =?us-ascii?Q?7NjBHAE4nPjaewbVTWhwYGlgREC+iDaLFKuUzwlQaeGvVaVO3gUh?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed512060-bada-4192-0fbd-08df31258d49
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 16:49:06.7423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtdG18GE6K36qo+8EDuAp2WKU2MpBtk7Bpo07Kx+sfrNGqxvCH2xDsxsbYX4zVSu6xVsUeEKCYqWaODRtyyV7aRC+kToWf9YRVBnM0MeTHdCpafSyenLi4CbqLAujE43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9415
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rzg2l_du_modeset_init() sets the possible clones of every encoder
registered with the DRM device, but builds the mask from the number of
outputs that rzg2l_du_encoders_init() initialized successfully. An
output whose bridge fails to attach after its encoder has been allocated
is skipped and not counted, while its encoder stays registered. The
mask then misses the bit of the last encoders, and
drm_mode_config_validate() warns about bogus possible clones.

Build the mask from the number of registered encoders instead.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v8->v9:
 - New patch.

 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 13d14ecacba9..6eb1865f43b4 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -455,7 +455,7 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 		return -EINVAL;
 	}
 
-	num_encoders = ret;
+	num_encoders = dev->mode_config.num_encoder;
 
 	/*
 	 * Set the possible CRTCs and possible clones. There's always at least
-- 
2.54.0

