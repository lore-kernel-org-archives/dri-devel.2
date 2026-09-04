Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B39C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DEB010F908;
	Fri,  4 Sep 2026 07:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cy6VyDeG";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F5310F908
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:54:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSyLLgCAQzfuvXF3LypwzU17+9FhYkQuoSAqrAMVJ+vxwQVZTsJmsVafaOlXUeRoI1vK5ufpBsDRIKb5nbWMSX8nG/2SthWsXI6jfEMptylPRyVtJdEpgbmjoUsz6YA/KF/8VY5img6RzCPyJ6TqAThclTFkLxmLDEuudD/rzpzbkFMrefeesFXe8JItBI+F6CBr4oStzrEK4Nwf3L9MN5EGcIqIQv8IWHl0coYy22fAsMu3UQ89fFZId4SWw8pgZJeA9GIDC9qfjSRLTqPhrxrshxW6vMPfP7U8Ig9FHKP2oWv/qGewi5gCL6To6RoJuPF3Tb7QXxrh/xeWm6giIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yGVr0KGvcf5tnRt1jlrl+6/VK6XIX3uzlldUmHfBJc=;
 b=PO/EPiOSNWav15I2YzQEiMs/Sl0vn8Dz6Q9kJ4d+q5GDKzv/i8MGbnBwF4POZ8htzs7mVAHdt+ROR4ZISUy9X40E4gFV3HYF/goi7oTS969ZMXWHvX+Exg2KuyRPe6VeSq4V9Bc2zGEdCqJ7JnPK9gpFrHd8c4jlOsPlG42znOmEJLjyvgvXJ5BraeTWS68dZZT2/LsWmOMLjIY8NX617ETUDSpW1wm1aQEqvqv5ghvHPWKuXoA6YeYqW0YNBcAJIieP90a+0pt/tMiAdydUrgSvMPalMCFrec73AvBf7vhjo48G620c9RU77HMBaOZJbGeAl4jbUyF2C/fL7KTiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yGVr0KGvcf5tnRt1jlrl+6/VK6XIX3uzlldUmHfBJc=;
 b=cy6VyDeG6IZ/6CjG8dnm1mvLLtGDlhDaELJY18NRdYyEWO2Hy6yCYVtjBG4H2iDHkfiri3jtp0EM0GwbUMzr7krLMxEieJyVmSXrBeBMa8sXetAkw3yqxIGEcoQZYvo1Jjfg+ZXNgGrjEkj4OKXyPjUbVtMVdvHqx9AzTO8eUiMOnlpd+oeb9Z6HHAcphNRzeXWrzOizDwAYbKUzaNHCmZJFG/BZdyAvWKrALeR8xMbyLzNf9KKVFrY3L6HayhtFQ5UQbYxr8CfXjOTqYTWtkqMQBDp6/S74YSszyFfNvaFOHFuGUCuGaG1nFvHH2XB2azLH2MuiWqX2weonZXdwJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by AMDPR04MB11702.eurprd04.prod.outlook.com (2603:10a6:20b:719::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:54:44 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:54:43 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Fri, 04 Sep 2026 15:55:01 +0800
Subject: [PATCH v6 11/13] drm/imx: dc-lb: Drop initial primary and
 secondary input selections
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-imx8-dc-prefetch-v6-11-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
In-Reply-To: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0298.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21e::8) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|AMDPR04MB11702:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8375ed-3e72-43d1-5741-08df0a59c830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: dDQFEjC7/9bShzc6M1Gf1Nxa6diUeA3XxHgs7YnLuJRoIPTasCdNHrJe/5uCr43cBd624qDNvkIHfdLW8M0JlT6n6tfWBg1W2/T3Se/ucyxdE5yl4I7HFF5fd1IHs6ju0tTMq5JCJmGa2v5QFtXZf0t+Q/8dEQDxTONJfVDKwY+Z9QQefbs45nVpaoOM87MTb0S6fqZGGm1iU97rHe9vctiMijSjPBOwIlSgkZSzfIC30W72ZxwqgwwiYH+/Mb3K7uh2RHm6LNpp7dBkEt0D/OYTIhr2HnGMHxaMwe83GiBXr9yjGp98yC1pxEpSSEBLAZAtf8X2M/WwDH/yiQtznH+aFOyEeORU/sE9p4GbovQV+nSGFcMBtc5kyX6dzzxYbfhFvrKU/UHL5euPqAxo8T0QJxM7dwCZv2zA3u3HzJpTavUTe1y6llWsVDgb7tV/4kFLD/MAjlMRb/hqlmzEov7Nf0pz1lnjesCDubyZ//BB5XjHdmWvdH8qBZqPc1GDcsjAdfTosLWHavr0/FbIL5i5NlKW9/p35og6rpcyCcYj/GPq4tKjz04fUnieWxS4gwyrEPkhf6e365zXia64jzTPMTMAvrpRv3BzXKuN/oF8QJ/hPLUEVqlzNQGxTAQXyBdKuUMo/PeVAC75TBv070WCH1DPAmWXvRRwn6NIitE9+61OPCh5EHvJ/IPR1sfujs1BpV8Ab0uPJ39jlHPG9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2l0bXY5c2tRKy8wWnhxemF6b2lJL255am1wRmxvWWZ6VTZXTU1kcktseFVi?=
 =?utf-8?B?S2JlSERJNkhyd05kTTNnNldObWZCaTJFR3MzTnFXSGRkdTdoMjN3RG5OTlVl?=
 =?utf-8?B?cWhBRzJGS2hHWkp5ME9tSXJMY291ZU44b05zSU5SNjFod2FDQmxmVkwyOGNh?=
 =?utf-8?B?OVVLaFFhQWUvb3RrWmFzUnpNL1l6ZlozY2VzRks3cFozd2ZtdGdqTVpBVERx?=
 =?utf-8?B?L05vSlVvNlYvS1hKQmtid3d4WjhJMldGU0IrV0NsOHhPYTZyRGdjb21GSHNl?=
 =?utf-8?B?M1BYSWJ0aHdUbW9WTjdkeHdIWnRQeXY1VlhBLzZzNzBHeC8yWWc3N3VtZjlZ?=
 =?utf-8?B?VTdVaUV0bHpKM1c1eGRZOHR4ZHRKblFxREVHWEJQbTdZTEVURldkSkdJV3kr?=
 =?utf-8?B?RFVsTHpXdmRVdmpiNG9XVE4ydkk3YlI5dVp0N1R5c2R2cUtIbzdXVDVsbXB4?=
 =?utf-8?B?OWlhcW9OL0tDckpCaUV1Nll0WjBqQ1hGVkpWeXpzT0xwMHRQbElGcFVMbVhV?=
 =?utf-8?B?Y0VQN2wrendzd3hjbGNadk1ZTEV4RkpXcDVHbmY0L0ZzalNrUmJZZUpFaUZR?=
 =?utf-8?B?SHhFYmhESWxCMTRhSzh3Q240UTVmRjBaUThubVBOcGlNeWZZaXJleFVzVW5s?=
 =?utf-8?B?RUNuN25LeTdVUmhpckJkbzFHWS9mM2JCTmUwZmpNcTdMalgvK2RZSEcwRzV0?=
 =?utf-8?B?RSs2UUhnTTBPZUh3SEJTS1RZZ2pMaHYzY3RPdnNLRDFVcjR2TWdsbHg2Nk1I?=
 =?utf-8?B?bFc2NS93T1J1NDk1dFIwc2hKS0xnQ3doY2dETVVuOUx3ME82ZE1qendqMTdE?=
 =?utf-8?B?cFBua2FhKzlKL3U0RWk0SWVrTU5LRG1jOURUbkZxd2FlODg1RGRubENFYmJi?=
 =?utf-8?B?aFJtakxuY3JoNHhlUUJOR0dPMzg1SDBiakJnb2pkMTNVN1kxdy84UHpjMDh1?=
 =?utf-8?B?TkhEbW5VZ3VYNk9JcFRzRG5RRDMrK1I5U3M2MjRpRGVJbWRNeFN4b2xubTBu?=
 =?utf-8?B?L0tCb3lOeXhWRkRuR1RLbVVzdWxiSUhyajlJeFRTWnRDdjNSZkQ0eXhhNk9B?=
 =?utf-8?B?RkVsaFhRdEtVVUJvWUxDNFkxWE5FR1ZmK05SQ25ZMWg5MXdFOUdIOUhtVUhs?=
 =?utf-8?B?M21PNFlvN0JjaXkvL2dWOGxrWEM0SWh4bDh5M3JIL01wV2J3dGVSMTl6NFlp?=
 =?utf-8?B?VFlwY2R6R2hWNlAvZXFweWZuN2hqQ2FBbFN0MkFKamRhOTZ5YmdUaFVoWEdh?=
 =?utf-8?B?RHdHTWFlSTdlZTg3d2NXQmRFZW80K1Q2QWplZWM0RUVFcmRCSjhkQmlCNENB?=
 =?utf-8?B?ZDU3ZnVTVStycDlSWTNTUVFVSTNyOUN4UTI0TDFuL3o3SHErVVRhdnM2V3M3?=
 =?utf-8?B?VDdRay9WU1kwaHhmcW9jVXE5R3F3SDF2ellhQ096SHhld3dkVjUxM2pScWNS?=
 =?utf-8?B?MG1kNTgzaEFmUkR5cjh1dEhYRExCenl6VCtmZUxvWTcwb1hnWHFGcDFQSjhH?=
 =?utf-8?B?SFE2SFdFYXM5NmlSMVRmY2k3U0ZuVWVwRjhFRk1YS3htNWs5NVJPRjQvWnlT?=
 =?utf-8?B?ZVNVTzJLaXd0T0YwaG5qYk1ob25EM25zU0JZZ0FNMmlzcVRkazQ5RWVWUkRj?=
 =?utf-8?B?ZEpWMldJMXhVRWZKUEhkUmM5TUZTVVJwckJsQzk1eUR1YlBadzhZVGtZNXFk?=
 =?utf-8?B?RVF2eU1BaGp0TkY5MWlRcGFMTkE3Mll6TVVlOUtqWEtJUDg0eTc4aUZnWjM4?=
 =?utf-8?B?UFhtZEtDVi9VY0tzbGJkNlg0V0U5KzdrbzF0eTRmKzhCRWNIRlc2VE5XT0I5?=
 =?utf-8?B?Y09HaE9JNlpQUWJ3cXhEK3h1V2VsazVseXFmY1NJcWkxR1RQN2pyTXZNSUx2?=
 =?utf-8?B?dGJqamUzY1dXQXlORlZPbmZLWlRhSCtJZWpjZXlHWmFOSWd4QmpKTDBFYUhk?=
 =?utf-8?B?U0JZYktKSS8vTmpnT3VRSW9VSkpKOG40VEFDbThJTllaL0lQZUd5VkpGYzZN?=
 =?utf-8?B?dE11VElUelFlOVdSdE5pU203eWp5QXJaU0hlcWtsSnltSW1saHZLYWJpRThL?=
 =?utf-8?B?d25xWVpzZEpiUExDOWFvSEQ4bGU4UkhnZlArSzdCcnNiMnVnTmNtTEo1bDZk?=
 =?utf-8?B?TVdQWGtHZkxFblVxUnAzWnpjNkJmN09kNGdva1FqVUtRTjJveWdlQUJNN3Jr?=
 =?utf-8?B?LzZwZmt3WjQ5WTdZYTA1eFVZOE5QUUZ6K2h1ZDVGQk8xcXVhR0J2SkJCZGVH?=
 =?utf-8?B?UG5QZ2JKZU4zM0hRN25DZi9PbFZueHNyZGp5dWRET2d0V00xMGpYQzNtcWp0?=
 =?utf-8?B?SlFRcDROVUFYeE42RS9jMUxMbWQ3R0ptL000Rk9EZXB0TUxPNHQydz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8375ed-3e72-43d1-5741-08df0a59c830
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 07:54:43.8925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVqaH7jJS/cl7LymhDgFZOkqsWsFnvQRJFReufRvcm9TAoA5KTM+MFDLWZTu7JWZgcFZhH4VNyWngii0mRaC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11702
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

It's unnecessary to set initial primary and secondary input selections
because KMS driver would do that when doing atomic commits.  Drop the
selections.  This is needed as a preparation for reading LayerBlend
secondary input selection when trying to disable CRTC at boot in an
upcoming commit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v2:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-lb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-lb.c b/drivers/gpu/drm/imx/dc/dc-lb.c
index ecc7e14b4a87..2c808e4f8053 100644
--- a/drivers/gpu/drm/imx/dc/dc-lb.c
+++ b/drivers/gpu/drm/imx/dc/dc-lb.c
@@ -253,8 +253,6 @@ int dc_lb_get_id(struct dc_lb *lb)
 
 void dc_lb_init(struct dc_lb *lb)
 {
-	dc_lb_pec_dynamic_prim_sel(lb, LINK_ID_NONE);
-	dc_lb_pec_dynamic_sec_sel(lb, LINK_ID_NONE);
 	dc_lb_pec_clken(lb, CLKEN_DISABLE);
 	dc_lb_shdldsel(lb, BOTH);
 	dc_lb_shdtoksel(lb, BOTH);

-- 
2.43.0

