Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D14606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YAyLwR46
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC80110FB19;
	Thu, 12 Nov 2026 08:25:47 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010042.outbound.protection.outlook.com [52.101.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F6B10FC56
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrTEREWIKworCpqLFFsyoG9pQIqLQ1RT/vZxdgW2Vg2pE6dvCU+6BkbKT1rChduy9mvRs0KIZ2XW/kZBqK9Iy83mlHi94eawQlNrx9eY1BtCCe3zopY05NuJNluxeoGPOc1lKJF5RuXCP//74PBdHEWdPS27D7iLU4bCuvgz2Y/ro6bNngDKRC0af59dtUAdv8pyvmzzepFFXmX+dN9cnfxKBXFTeGOr/ZCQ4ojarSbFgbfE8rfWx2oofDyV8BsNwdmZVFoFJgAzOYAPhjvNYCwMEXZa07J7WMrD0G6Mtz7p4H4jYyEDjrRY3ztIWOPQ31eiWMeFDZXEe+gioS7i7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcuwwCv5FqF/mvxFsOHV8NVpYQ0LUCiVaNsB6D6ugmU=;
 b=mnwsAVviejNZGABgyk0hcjAvhw4FOUPCKn8CqlD+YLS0yDv1CpOBkSO3velbftunVDAXWbbIgeE9dluv06g1CUEgN/KrJQqeZoD4juZIFPixhVa7LgHUeq8ODDMurmaTFfbIL/BFadN9QEHTH/L8I9obY27XW+7sbIb7bE1AnB4aghrcdmpKE+Uty1y/EXvpGBKG6Gd6941xkuyg8lmmEa2peIQq/vMokenQQfk57q1OXRp8rvqvBC3HXfGvCCUJaf1L+krpUD2OnJfYMITHr3Ax+NDVp3Vls9rFrTSOFXOL9xeLHCQA/gwAz4tfp/6cYffK3b/DuDrjYqhCcZni2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcuwwCv5FqF/mvxFsOHV8NVpYQ0LUCiVaNsB6D6ugmU=;
 b=YAyLwR46T2Y2JmYto6uM7groTq26IzBHXNecAuvNH3cqlqrVvQKW4nHlP0zoGmSUDva5LZOAmHnKhIkNJ2pdMrGNe4DT0VYMHz74zSI74co9YBu0unOwBjHINzh0vfad6prJl6eLRnQGhiYs5ikl24mDHaxvxsQPspovNr+4/FE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TYVPR01MB11262.jpnprd01.prod.outlook.com
 (2603:1096:400:366::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 08:25:32 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 08:25:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Date: Thu, 12 Nov 2026 09:24:59 +0100
Subject: [PATCH] drm: renesas: rz-du: Add suspend/resume support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-b4-tm-pm-du-v1-1-507474331137@bp.renesas.com>
X-B4-Tracking: v=1; b=H4sIANp39WoC/yXMTQ5AMBBA4avIrE3SNn5SVxEL2sFIirSIRNxds
 fwW710QyDMFqJILPB0ceJkjZJqAGdt5IGQbDUqoQkqpsMtwc7g6tDuSNaLUJtet7iEWq6eez+9
 WN7/D3k1ktncB9/0AYp5ALG8AAAA=
X-Change-ID: 20261112-b4-tm-pm-du-edc079c59a9f
To: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tomm.merciai@gmail.com, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471928; l=1727;
 i=tommaso.merciai.xr@bp.renesas.com; s=20251006; h=from:subject:message-id;
 bh=LzCmzLGWEHE7jsePadar9DepSkqBRLK+qeTQsmtVM4c=;
 b=IX0UPBUSSeynylArpBiPNNdT8ptky08M5v945hBS8ogb/N8jVjE4eJpKsZPdsVlBjvqz5/0nF
 nrjA5VrUGiQCgftDGEBW6S9slIVrHc96qX8QCn/ceCUpFcnw3EK5rSY
X-Developer-Key: i=tommaso.merciai.xr@bp.renesas.com; a=ed25519;
 pk=J15CiW2gJfhl906eXCszPfqo+ddBW7v9wVMkAFyVDys=
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To TY7PR01MB045388.jpnprd01.prod.outlook.com
 (2603:1096:403:405::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TYVPR01MB11262:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bf7c41e-6d7a-4893-84f7-08df4096849b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|52116014|366016|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: RBACwrCdzGp/3A2/ConyFGVXSWX4ZPDmCjpyMtIdUsRWWBDze/SkRyHSvgD0f3wiaOaCnk/XVk8AHgXrNwhtaHsmDrx86riXHEPskFCNomf9/Gg6bAJ0SOB7W5P87WwhTV99U+foiFexGwPinhTZ8xqLApIiF1GkPqd8mleFkbDSRRa3ndGC5w82TXC1ppPWj4PmAx88Pzd9XEHs3pr6Bg2/ZsJ4rjEQRGXuLp/skS1Oj9vzYgG272FDSN8OZ2zRQ9912ZG936kOBj1sjbrHLOLom3oqWilLVHFX90h9fNie5GDrca7NJVbfPhJ0MetFc+fvyksE4tWkdX+boh3TJjhUaOFU/Y/OcWZCXOLyaTGjLVunbAtgTH0tPM2YKw9x08WCGIdvPoAlh2lh3x4EwukVA7XGU0rjB+HaXhCkCKWBcupQULEwjimml4C3AkzEucDXiFlkxu6MBWVAnOc3V7caR7LlY4e+C7h5YjjRhTi4yAl2YNEf2WiheG7zpYTrwRzmmDro8VwNPWjtMKKNQuvUpc2LcA8lPq2kr/BB3P0TF594QVdJkax2CokXbZ2b6exMjlPlUDmGIivJpC+Dt3/MY9B1E8D1VMCabI2yri8eO+kr8V3otrX78xPB7y9Ql+Cg97YymzJ9ZZxGdRNwRpV1TubkLVyZL3Zujx0dehHHfpL7k0aMUU0kz+dAEVb5toni/K4DUR+0bmBrSkmotqu+oW+EHkMD63wgB0TyjPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSOPR01MB295138.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(52116014)(366016)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lZNXRsem1kZU1JbnRIc2hXY2FwMGRWRTdGQmNDQWRTYTUybmlHaFNKRjJO?=
 =?utf-8?B?Y2ZIQ2RTWXBEdWRsUjhScjNCQ2hHUC9qQmp3OGh5ek9xY3FSZjRuWFdoTktm?=
 =?utf-8?B?cWdXU2xWUlRLMVlYZTRhSks5Q1A4RGJCNi9OV0U5Wm9WcDhJVU9SSHJaT3BO?=
 =?utf-8?B?RXVIL3NJM3VOMHJWVlpqc0pJYVZlTmgya1o4QTU0Z2pIbFVIUWtHckJ4ektV?=
 =?utf-8?B?eTFkVVRMZjBRN3FxUHlzWFFRb09oMlAxaFQ3NWo1NDg3QUltYzdURWJwMG9D?=
 =?utf-8?B?OVd4SXRWNEFXMitJUC9OZTc2Mk9GUEhuTUsydlpmUEVSNHNPRVJRSmRlOHpO?=
 =?utf-8?B?M24wcmlhaWNLSk56bTVHUXI4TDlRTXRhTXJNeWgyMktSdUw5MFNFYUVoU2sv?=
 =?utf-8?B?UTF6WUJhWUVGeVRJSlVQZ2Z3U0cvYThIdFVyT1BMTGd5c1d3NlU2SkpEV0xM?=
 =?utf-8?B?Ky9ZcVE5amIrdmRRM0tjTEFvV0ZzOWNCc01CNi9iVlJrWDkyaDFHQmV4RER3?=
 =?utf-8?B?dXdmSTFEbTBZZFpMbXhUS09sMFdYWXZsMTVNN2loK0NKV3JZUzF2ZHo1THJv?=
 =?utf-8?B?dmVVMlhEM2QxM3d3d0pXTE1KT0dsbElSNTBEMHpBUjRmSVpXeHRLMnBvUG83?=
 =?utf-8?B?a2VMZS92UnM5Slg4ZTVhUm9UdkkxMHVtV3Rhb3RPU1BiQS91OWhqQnROVkxK?=
 =?utf-8?B?TktuOE9mMHAzOXVpOGE1M09JOTdDa0c0aEt0djFXaG5vNm0yS051WW9Pbkx2?=
 =?utf-8?B?WFU3WExjU1IrUVdqVXN2bkRTVnhaOUNYRlZMaGJmV1NzL054azE4Smh2Y2ky?=
 =?utf-8?B?UVRQOTNJUjA4aHl6ZitQbFh0V3JHNUhzQk1nd0tiajl4VGpQVzh3TG5jQUhI?=
 =?utf-8?B?dVJEbVgzRXlWQkV2VklmZ1hjYTJIY29CdU1WandySldLOTRHdWNJUHhKdWFv?=
 =?utf-8?B?cDYyL3B2WHFkd1ZnTE9qWUNBUTltZzA5bnJoeEs4MEgyb2I4L0dNaGRINE95?=
 =?utf-8?B?cEtmR0N3S0VkbFpmS3dBbUJmRXpLY0JSRUtmNG9sVWdKbk01MDdCUUx1VnR6?=
 =?utf-8?B?YlVHMXBJcEJyb0FnblpBN2Z3dGsrVGwrNllhek5vSHd6SEpuMzZFK290aE1N?=
 =?utf-8?B?c0xGb1dzWEdhUEQ0K3ZxL3pESXZiN3ExWnhSMGYvOFgvRlAzL2hnRFZ5Y2Rz?=
 =?utf-8?B?dEdKbUsveWxITU9tNTRSbzBTU0poKzE5NVNLbG13TG9uNGJzaHdNNWE3Y3gx?=
 =?utf-8?B?Q1VSQUR6aFBHUno0NGJVblVEY3dBdzdObVo4ODNSTHBtSUtzVFNZRHlNZzY0?=
 =?utf-8?B?aFlKd3ltYWxvcFVrRG9teWhHVzdub3ZmdStXQjhXbUJKd0hWN2RRWkxadGtR?=
 =?utf-8?B?dUlYSmlwZ3pSUUNJUnRuTjZDM21nWWdXbFlGNEJlMWpHMVNKRXlUc0VFQ2Y4?=
 =?utf-8?B?cGF1bmxNVGFwVURaSUdUZ1dLWlZIYUZIQ2duTHRCd3Y4bk9CMy9PUU92bG9r?=
 =?utf-8?B?bVdzVHpyVmdsODIvYlJGMjR6bzg3SW1CVjQvRTU2N2NnbWpGdDM5S2Y2LzBh?=
 =?utf-8?B?TVZyVVhGeFY0clJHTUdobjNqUU5NdEtLazdLakpqNFJtdm5FWi9TQlV1SWlE?=
 =?utf-8?B?b0dELzkzWWZoUmJia3ZMMllWK0VCUGl3SVRMWVA3T3NGWm9LZEZEVGdCeFJM?=
 =?utf-8?B?Wi9wUVU4TEZrVE02ZkxqVmthMkNwMjNsQzVjaWR4bzBENGJwYmFGWjgwMHBK?=
 =?utf-8?B?SkJjekZOWnlEN2lmbkFaVGxnNEExT0VGVlExRVB5SFFLejN5SW9mQ2FSVUp4?=
 =?utf-8?B?UmtSVTQwOEdiWC9RcG14OU1yUGFWZGQ2WnhFWjhtcXZZK0h1KzlqT0l1Tkpr?=
 =?utf-8?B?L085VDBYZ0pMenRVaHJId1BMYkVwaWVsdTlFbk1BTVkxZmRlMFM2Nk56TDVk?=
 =?utf-8?B?ZmJTbnpsYk4rNDRNYWJnQk5lZnFDTlR5V0NMU1FHTVBzaVBtb2lsWUtzSGtT?=
 =?utf-8?B?SXNHMnhpTHllU1Y5Sld0K3VrRFBtV0NETmhyenN3Ui9BK25wWFQ0citZeDYx?=
 =?utf-8?B?eUx4Y1FIRElaN3FxSHdTakh6M3VvSCtVa3dSNVh3OVdBUEJzekZZU0tTS0lS?=
 =?utf-8?B?MUdqNjc5ZmpSeXFiSWV3R3czWms0MTA3SzhldEJVNzA3SEdVaTY1WUI3aHlX?=
 =?utf-8?B?UGhWWUUxUTU4L2ZhRDBDR01NdWdVR09Od0h5anA3UW9vZ3pmb1NFR0RURklG?=
 =?utf-8?B?N2kxZERERlFIK2tSeDl3aDhFZ0FSRlFtS25GUmxiSUZJRFVNeGgra3hHWS9S?=
 =?utf-8?B?YXJwUWJCY1NmRTRiQzc2amFldVkwK1BVL0U3OGkxNU9rUnpkQVhEd0FXSmVQ?=
 =?utf-8?Q?jWNr5rexOPrcvxsgAsxEuMhKqRDLWVPgnCz2+?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf7c41e-6d7a-4893-84f7-08df4096849b
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB045388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:25:32.7140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK7ciqV7PwyXFOKB/E3HH4h5PrpQgcaWp4E04um4V/DuDCCJmWK+gGGTG6wpVYhw2jrGgYgVFVjIFxZoUrycI80X9BaW0waqz2JTpNh6Xxt+LnKCfUMN3N1Ib4Qj+wym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11262
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

Add suspend/resume support to the RZ/G2L DU driver.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 6c2dc86abc7d..c7d71dd9198e 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -140,6 +140,27 @@ static const struct drm_driver rzg2l_du_driver = {
 	.minor			= 0,
 };
 
+/* -----------------------------------------------------------------------------
+ * Power management
+ */
+
+static int rzg2l_du_pm_suspend(struct device *dev)
+{
+	struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_suspend(&rcdu->ddev);
+}
+
+static int rzg2l_du_pm_resume(struct device *dev)
+{
+	struct rzg2l_du_device *rcdu = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_resume(&rcdu->ddev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rzg2l_du_pm_ops,
+				rzg2l_du_pm_suspend, rzg2l_du_pm_resume);
+
 /* -----------------------------------------------------------------------------
  * Platform driver
  */
@@ -227,6 +248,7 @@ static struct platform_driver rzg2l_du_platform_driver = {
 	.remove		= rzg2l_du_remove,
 	.shutdown	= rzg2l_du_shutdown,
 	.driver		= {
+		.pm	= pm_sleep_ptr(&rzg2l_du_pm_ops),
 		.name	= "rzg2l-du",
 		.of_match_table = rzg2l_du_of_table,
 	},

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261112-b4-tm-pm-du-edc079c59a9f

Best regards,
--  
Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

