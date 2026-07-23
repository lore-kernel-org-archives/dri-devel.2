Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DC7C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B1C10F112;
	Thu, 23 Jul 2026 13:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="daYl0o3d";
	dkim-atps=neutral
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012004.outbound.protection.outlook.com [52.101.126.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2195910E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl3iOJWCagIq8qbkWtp1PzCXydRPhzgE6//UOkbc44GdsoAj89J3UKrq9Pdo/iF9j/vFkTMjVU56JcxerrVNohAwxqqo4ckFg+KCt5hB5sL+1sx6WnUI+zNmhRwdVNr0aaE/C3vdeKX8zhIKA2IGcjxPvHQcWwAH1wRhFjZu69154AEP64b8b79ueBanE2e4kv2wai2bsHSDNuJwB8ajbtEwv8WXlktWEFuolOxKh9ZYaMpyxsjPgnd92CeJEW5jkkwK3jZTClW0xKi1oN+9v/LOStEKjiVAMVqewtU2erDVKtdo5Y06tLSGKaxtJcPNWHvcUkM1Au1kMdmx4ju7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LrVIgBSFvkMixz75o8YqxXe3sBM3uOV6P6hNRCg7/k=;
 b=lI/91AjcqtuuyDi2OsqLatK9pN9Pun5e2Nd/XVCqQyxzH7tTa1sn/6LcSrzwVpfCMtyd/8Ga+yTKkT0US9pfbUx1ccfeHDy5jOhOk0+HVYTkKb5YHiLXOyCefRjV9JV0tfyzMEGGP6AKk9VamxBLX5TuzWIJR4vADQO6mq/RqGCqVtbPxUzFlXhHCnCP+W9zGxOnr8VpmaPTb1mh5qAs2xB9C8CNnU0BsEbjPLZVNAfqxCCOXbGodGtJHHGVHfzhYD2UENVwDhNGHeqWqV7mwWHwL6TTEbFIRFhIMp2AO3tJw0BpnEnU140yVs/uQvOU4ucdtCFT/mpP7HvfDo7a6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LrVIgBSFvkMixz75o8YqxXe3sBM3uOV6P6hNRCg7/k=;
 b=daYl0o3dQSqCt5UJCu75R54miwxrONRNosMTZvjkZuas0/h1JIiSsvFKkqxbpF0wwSfP6blcpW3/iA1faAkbQXRy67mXyZcPO8E5KMU+zOQnOQHM4vaCac7seFqPR+9AeTXeNxBwC2llTNq/etbG6eBIEe3hpHc14ZF7AlKeoDsO/YatvqWmfiOkZy6PvKojU3hq5uQQktiW3GJEJRrrJn67xg9tK8ocIoa8ukRXP7F9R9nrKKRiu79m6PAlv6NVmN0lXGi4ktQCgnB1OmpQfCNCivOC/p+6SrCzDveFB74ZE+OvTB+p9DPTcImJr6+pd4mLIILO6bFMxvjMKIh3Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:27 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:27 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Douglas Anderson <dianders@chromium.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant
 dev_err_probe()
Date: Thu, 23 Jul 2026 21:16:42 +0800
Message-Id: <20260723131649.134127-11-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fbd3c2-6f9d-493b-1011-08dee8bcbdba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ucwluCIVPtvvIXHdUaMVxvmjYCIRTEcmvN9gU6K6DfXUu8xsgSgx9fI4M3SVH7KDuy+kgYnShoTJ9Mki23HokK2JjbUF2Fu/O1clAuKoU/K7jCAY2fLG9IVeSazQ3j4EAsLI31Y1P8Xr6T7C9167aRc3CWbalAWk/7WWWES7N9ZUmiipuLdtl7EWcJAR4dNltYEKkwnuhsteqlfo48VedO6MN0c7TG3IZEdZ1QA7FuJ7cSBUZjzOq6qQMbIaF8IH9TiZpccvlJ4YiPiyO6R/IkGysd2gx0Vc+P3fL8vnEdqasvy8X0WzthjiKo20ohjOJyqTBB74EdXStqfQsVWdFfbZa62Cxh0xAwqhhatUdZ05t5bHMU5O3Ey+2klD0I3Woj35GNWNoZjI/LL4nS8rLIOJjPFE335gneUiHuTw+/eLhAb1XqLLx+6HSzykaHUhyBqoZAKKTIGc0ccvkNsS6Qb1kMM0s7+Iyr7XOi2c3Y0Epc8rsagdNNsEm8YnartNoQXlGg7IHQCqZY9KVydosfYlzZ+PTzgpyvmAeiRBF/Bfjfc4ai5F8LZs8+5r12iW+ZlAVj7xe4EoxB6r2l70K82eyBWbDQUZE9AdCXp32PP4WBvQqaZEaFWmmaHQDaa7JXOUZYTAYsf0Eq+5Xfep9FWIUe2lbMGoQXIHHXcn1aV+Jj/xDtZr4lFKSbjmEjv+lf4tqqHNQEzmG/brd1JuumQe+FI8jTdi5avhnpejeMVMXPjjohKevrLl1SixI2Cy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upigqR8PMHGZiub5RWsAJpD+b/5nHov2KSmc5isq960kwrPlE221OMc1huMI?=
 =?us-ascii?Q?b31asb0BIW+5swZPVxhRDqsvmOfVDtU05slwslcSXEVjMPKZTBSrhp2bwoNH?=
 =?us-ascii?Q?BfhltVMnifv/5N/kwreFK4WychV1hZNf8zxvj43+SOhncJliI5kb/l8q2YAN?=
 =?us-ascii?Q?zKZp6yRPU5umeg1cqJpcdNwFoKiJb1xK1xDjhXRTT6nHlerWc27+BDBihnVW?=
 =?us-ascii?Q?bawd8tS6Q7Imu83eSbOAapqxqsMaP9Mi3OCJ8QR3A52Cv0mmFvD5NnYJVNVw?=
 =?us-ascii?Q?0FoZPLs9E9ci3x9Uf6AWvlP7MQlIFcPkKoLV0Pw4tia9DSGBROvU76EcCAp8?=
 =?us-ascii?Q?8AxQx0bRynvZU4570WauszGvV1NN8RyyP9XE1TIiAUjbs7H5hu6J6HvDs+T/?=
 =?us-ascii?Q?zc1b/RF5aj6nPUgGLUv9SgMbhTpNTAHDQdJFaPc6IEWgSJOiQvnRbK0uknbd?=
 =?us-ascii?Q?Oym9HDgjETgV8h9l3fh/fW+xsPfsW9VuaBagytQCRok0l7Ekqcq2BZdbCOBM?=
 =?us-ascii?Q?I5SgbMNPZgP7VcUsqVGh6ez91qiL85rGOFkMSYlL6MnC1q3s/aAJW5sGx2lK?=
 =?us-ascii?Q?KF5LsH4D1cunOCMYXAtMkRw6hb/vRAf2VF+PleqCf8z7Nl/sodxFUpAcXiIJ?=
 =?us-ascii?Q?YHQkKaDy7HHaUWwsE7RYf1Nz6RRgNWgyKZq4HJyrWeVH45FsVpG3sXOA3w3+?=
 =?us-ascii?Q?B1NM1irbnomJJviD85Pwk34lWuM0RRFXUdcPimPFS+LWgnLdpQcN+A644VRC?=
 =?us-ascii?Q?YvPlJxzMsyFfsjOE2xHLL11ofKR+U7v7gNQm/TvzdvyefWEnarJyWzGIvh+h?=
 =?us-ascii?Q?vWCHl8EQEJROCGgt5HB6Uas27Pqhxu84wIMPd72nO7D/eRodnQ9nRRJNLcpe?=
 =?us-ascii?Q?mf0/AGgdMlAq9tbp4iIvrjpPNtBXXthBgErqprpZfrU9H9I2w4qrlaIhFfyn?=
 =?us-ascii?Q?1psdpD9AZ0eSNBkZ5xAyTfEcsLdcRZ4t7k8Osp65waprfNcya5+aIS6TBonx?=
 =?us-ascii?Q?x2u7FZV+6YEhltvdwi09lhrmKzNgvpaEQzxhZnBgVFYL+hCmFYKLrmP/PQkK?=
 =?us-ascii?Q?Jl1sprOekhFHSHusMl55hKAcHuS35xbxXyB9OIWI/WZ5+bZQOFFW7sRY4PYV?=
 =?us-ascii?Q?73G6DFnTHggWoN+ZkKu7KJdrEs2aaEQXGikDUGITivaigehbg8e9jcWNrbaK?=
 =?us-ascii?Q?kO9lVil8WczcyAsmZqIzvozp8Tl44wKRM2+JsneEla0mckmgpI/9wurISrpA?=
 =?us-ascii?Q?wqaoVxVYqsOaRl9n3lec77t7qK5izrAE9P4TSnPZEs/ROxKDGEWgO8O+nlrx?=
 =?us-ascii?Q?aij5WGhP0JoD+HATvJjBUIrjpmpCX1IEMlRLwbx2bcaxv83OJ2WDOnPd7GuL?=
 =?us-ascii?Q?Q9zOzQYbGdIU+X6NPCa6WqMdwCGMP/VvUaP1+08HapBov0hBQQIZUcmwpijl?=
 =?us-ascii?Q?kS7YygNJLGrDY34HR8eyA+2Z8XBKmx5TtxujbdoMczpP09gLCzrXt9LVOdW0?=
 =?us-ascii?Q?Ddz2Lubbm9Za6hfTGM0/lJ/djgKu4uIFRSG0DSktCzeE7nrUALeM4YI9Oqm+?=
 =?us-ascii?Q?Wm+MSs1WhVmNb4h3vPgLss7/qLtAW1aGEg2t4wlhz2mQiXI0py1uMZH65xzo?=
 =?us-ascii?Q?D3g5vHieJJoXNScjGSe8IharmBvblvT6O5un16i1/2KuKtxGzIRrzO7c6QCR?=
 =?us-ascii?Q?sSiYDgn/VGpXc9VpvG9vpBO7MmOVDeFEB3IKmFYRflbrZVu1gW4r952NEp6z?=
 =?us-ascii?Q?TwsUV7MOYA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fbd3c2-6f9d-493b-1011-08dee8bcbdba
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:26.9673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nflDOpRTNtxnJBC8XfoEQEIpF7q8MKp7iFjnjaX9TiZyOwDMGO/vI3ayYVg3PNC8N7cXkId67flFs6KO9sIWAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8724
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:26:48 +0000
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

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err_probe() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 1da242f17413..2fcb4039fd61 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -2080,7 +2080,7 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 						dev_name(pdata->dev), pdata);
 
 		if (ret)
-			return dev_err_probe(dev, ret, "failed to request interrupt\n");
+			return ret;
 	}
 
 	/*
-- 
2.34.1

