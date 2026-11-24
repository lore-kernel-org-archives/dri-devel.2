Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14660606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=im2Efrb1;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VdHE+f5s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD0C10F426;
	Tue, 24 Nov 2026 10:19:28 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2812310F426
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:19:16 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO83QUE718768; Tue, 24 Nov 2026 04:18:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=gncfHiimR2Ieq
 C5k9EUHNhd8zaf3y3f8uVWykSzfxbM=; b=im2Efrb173fCDcG1r5wOymFZRZB6A
 oPWDBL8GVCDR14CQKYj/sYIu59A6D3rJViNBA7K3E/E+nT5zyYetmGi0Thw5qfNY
 W53ZZ7bjFm48Rzz/s/I8AnBZFpAJ6qFht8o8dg1SRDyRqcIPUk9Q+h8AXV6lqD0c
 pxDGd3fvECMabchbgGcw6+v8PmEcgucVhn5AIqzgKtXdTgYnK53hl0RtAsszhkhy
 gb4MDgmfpQR3kwje8qawZ3m5mOwvEihU0b+EolaXBZrPkYH15pWCiv+eOs06DFSO
 xBX75gJiJ808BfbDk8sTgyfZeXbYi6+TpWFQGyIVW9bke82cDwcYfreDw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j4v8qbx7d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 04:18:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o83xmlxpurLESblVPOO71Bh9PkhojQprEb9dV3ztto0Xc84ZffjS9yueQ/b55wzes6xZKtYlxyqr4kiebIsQPta722Vfd+f/z8GohkWf0fGbxiFEjm6TCeDseCkvzHXdQsnfJh/JRlDhZQpoURjQ4Ah+6IsEinaLZMGCy22kBTm660OJULnE2WxwFgepkRmhpkKxVtWpY/ZHgMP7TrG2/xxIGpr0MgLoKooyYzaLc58qH7rnu1GPLZFzjBtXlmVc9ZFSaxFpnLnr25ODoDIDK2TbBWMDiDRTROhes9LTXjvQLnLrdqN5NgNClEe5lOmomStDBUHMll31EuwudEdWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gncfHiimR2IeqC5k9EUHNhd8zaf3y3f8uVWykSzfxbM=;
 b=zRnUrQcm6ma1Jb4dA9HXbsjmj1L1oRIjcEOG7KjMX7+iU5dzXAu3RW+B7GWwSoEjL3aNDN+fcy0Q8Frdxm0wye/ZJY+vdsAoOkXgL6XkRnQDYbMw2HtBYSBt6DWC0Yo+ZID+P+Vbrw81UMiRJvdfm/Ib2dDZP9VzzPqWC9XyFcMc0We2L3RmcClLhK9t5ePrgJYsjZCMENJhpX6TPcV0EJJWf7/l8X0IACek/HOW3qNac+B8pks5iDPn4MYhSJ4PpIeZvpH6lafG2IzXTkxnsfbiTiSyHyhuOvRig3WYyZNYekFE0I/mYMjnbw4sozGvKCXgHGAqPtokmddJsLJOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gncfHiimR2IeqC5k9EUHNhd8zaf3y3f8uVWykSzfxbM=;
 b=VdHE+f5sCTIkKcDInnvF40W8eB69POn5U5wVpv14W84TBiZvX22qxqT/Xld//Aaepd97JDozMWyNWlFN0e5xfUIgMZ0cRGqMBD5AQigDJsinur6eCYDHOtYLs77Gg4mxhzBAqP2BI+KbvPmooKjf/BbQHKIfdrvSOcFiIV8wu6c=
Received: from MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9) by
 CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.13; Tue, 24 Nov 2026 10:18:31 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::31) by MN2PR01CA0040.outlook.office365.com
 (2603:10b6:208:23f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 24 Nov 2026 10:18:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 10:18:30 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 04:18:11 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 04:18:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 04:18:11 -0600
Received: from uda0543015.dhcp.ti.com (uda0543015.dhcp.ti.com [10.24.50.243])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 6AOAI5A61414766; Tue, 24 Nov 2026 04:18:06 -0600
From: Abhash Kumar Jha <a-kumar2@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <devarsht@ti.com>, <u-kumar1@ti.com>,
 <sjakhade@cadence.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <y-d@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <benjamin.robin@bootlin.com>
Subject: [PATCH] drm/bridge: cdns-mhdp8546: Power on/off the PHY in
 probe/remove
Date: Tue, 24 Nov 2026 15:47:47 +0530
Message-ID: <20261124101747.2432344-1-a-kumar2@ti.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 8393fda5-93c2-48c4-b694-08df4a1449cd
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|921020|10067099003|56012099006|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|261102123227099003|261026140227099003|18002099003;
X-Microsoft-Antispam-Message-Info: S+sPREEKzFPPW+Ef/35CcBiMceVN4TkYFms//KXjg8ClU6zlxg3mMNHwKm9tDAL9xKyBuMwl1OpUjhW08R2AKJhKG+Zldbl4Zdli+QycdIth3U0Tgn9unIQS95WRoSmRv0slDfERWH3U0224KujN8rps9ZxE/R38IbosIT5MQuBk3NEYRIrTuC+fOyPmVfnfkzJhl/zZqiGjv9KO5juls8zzLdK4+FAlAofihGn5TXErYIAIKfBOgA85Q15a/8iuAiVbKApkfWkxSYpaGUVwm2RHruN7ktM+xv15NDG5svJWk6lrQKMRD7qC0HX+pFuYqi4O38wm468P23uvagklW2Cs0AlthQxOWuEqrjGshkQy/s6wuai1xMmI1Jd3VD6BNUfnCshc8XAyL1GQ0H8Jrj6BzH+E5OOo5hhPaGCyT0sCpgEYvFWE44INJeCM/1wpoNR1bkZHwEN+nDDkNYc6qvUUVZPh59+EPSl0k7fXDRcFkIGK8NGwuc7d8DiiuI0naFLeWkMF77K0RBzWKBB05XZK1b9l+P5WBRC9AwOENQ6dKQDzNeM4q0s2FkoMfjbAXw7ssT0DIp6rcviyyuIb0Yzsfy1hBBeUHNGNLtgJB+J3G578Z+umexoTGolbEBDotV1Gj7VdiWtfICh5sXMytpbZf4WuwCRH/uu8YKdNNcpXNg9pfKsxBvbI+T9kQPDLMg5oFwS3sHUKoQmprvxyr9k07VLlv44CmZ9WmjzB39p6nYRjboDIRqXZNdTxmSXW
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026140227099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HSe8XPkKKtr6JhFG5RRsSylvJLLD5uKWewVqlXBslXQHm7PdhSKCiM0HiJ/Ig0Fk7G8YkheYSbO0azCIgA7yJGEPvmtKLM4jiF9d7A5uLVwDkY2AHzhErK9m4h4I5oSp6axvZfnK1WSo6fFlTxt3Mqk+8RrQjcJQW9TnTHagTMVEA9wDdGJUCiw4lFSxy5o7w2wEAof7cOGslnl2ld1WCCmm2aRfknW7+UoGCu1MQ9kf5THuas9PcQ+Kl30QaPGzWVP6QYS5AKk+cv6FoLpWDtBN15kViRJrXTvjPDA508uxxQVFYdhaNyiGSdcKzwXIU4gvxHZMQ8TZ8Gc/L2WLdRAIZm0dQW6lickuy+B8SSh7Ih3VPUfL+yzi7P8rscBET1trRTpAI8SIhHkjG44ihqm8TNp8+GguStRiBJoBK6+oewQ8tchHxAHLSFcuoaW5
X-Exchange-RoutingPolicyChecked: kMN23ull6ow2d2G8TVafNDeBmASyjyx4SCz0yjOHJ/6t4KeKwu2TsKsRXhbLS/RTF+6k1gijvxJKb6hqMhYGQ36Zb3BrWkU04nJWoMwc0BIxV6j9h4xTBucNmDUKjOrK2gTX3DvwQ+51UP5JvKANNSf6COue4V4ceUy9bqk8K5Nz8ZW9XciENXbhkg6TrVzsvoEbaujq9OvPHhxEQ3tF1m1AGcKpSiiA7sG//pAimXcnHOKMjqvbIpplGEiazTCGK9E0ADu4qMVu4uwaxfBoAM5ykF2/taJCSuWvi/5oBJmpOgzsMLCdhkpxjpa6NCRZS8j/jsmrrENko9THldxF+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:18:30.6677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8393fda5-93c2-48c4-b694-08df4a1449cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-ORIG-GUID: yQkkW0h2tZpgIq3Ksw-HbKtrdvqmt2Sm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX9qI1MentR/14
 agDJm8fJrsSBIbZAzON9HvXqbtYmEz/Ac5TRHDv3tVmGo+eK62NCh+IR4Gmm0xG2gOd0Mo8o0vC
 oZXwhgmfrMK6YndvMKM0GwPNgjHLAqbhyNluzAbn0NBVeMw/HyJYxyJXzkOOKNp3f+rtIGGQDg5
 Bmm6lXBJ2R1oRcrZtXKPZxjYqXf+Sgj7kb7opt+GTkqqAWbDe5MSv3qlLDEoI0cyKp2z2EQGW4T
 Q/aHCVriEmoB94Snx4vXjNMVSyoYY017YbNT9RyAAXbeMYB3NUEUWb2rtVF+AkQyaGtio0xeMBz
 ECQdB+7Qi1Av8I8OUkNNbigUS4x7j4f+cTOiukZ0rzLRuq8kw+dxgx5QQC1RZkmr3NkxnQuLgEZ
 8TatKsuLQQASkbEzxT60pIvFmHyqNWXq6I8dkCTm8vfbf2644vIHMLaQElyrWnayQyMtSHevovq
 ZOJGBkoujYqkHBRI+aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzOSBTYWx0ZWRfX5sfLbvSjIrV5
 bCvEL6DlkYmDWB3cWUs0GiMGL8u9/nlHcCR+EiYv9SYB7xo2pLYH2VkVHSNXkH1AVIJEbYakE8w
 kLH+cj3H/pEdl++nnEfnpI9HhTQTWas=
X-Proofpoint-GUID: yQkkW0h2tZpgIq3Ksw-HbKtrdvqmt2Sm
X-Authority-Analysis: v=2.4 cv=CNe/zhrD c=1 sm=1 tr=0 ts=6b05647a cx=c_pps
 a=NhzRQjsTkbCjHKaZ4k3NFQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=eBZGQTtviXP9TzdQMdMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240039
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

The driver currently calls phy_init()/phy_exit() but never
phy_power_on()/phy_power_off().

Follow the PHY API guide's recommendation to call phy_power_on and
phy_power_off along with phy_init and phy_exit respectively to be
compatible with different PHYs.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index f47717bd10798..86e850a4752dc 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2369,6 +2369,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 		goto plat_fini;
 	}
 
+	ret = phy_power_on(mhdp->phy);
+	if (ret < 0) {
+		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
+		goto phy_exit;
+	}
+
 	/* Initialize the work for modeset in case of link train failure */
 	INIT_WORK(&mhdp->modeset_retry_work, cdns_mhdp_modeset_retry_fn);
 	INIT_WORK(&mhdp->hpd_work, cdns_mhdp_hpd_work);
@@ -2378,7 +2384,7 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	ret = cdns_mhdp_load_firmware(mhdp);
 	if (ret)
-		goto phy_exit;
+		goto power_off;
 
 	if (mhdp->hdcp_supported)
 		cdns_mhdp_hdcp_init(mhdp);
@@ -2387,6 +2393,8 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	return 0;
 
+power_off:
+	phy_power_off(mhdp->phy);
 phy_exit:
 	phy_exit(mhdp->phy);
 plat_fini:
@@ -2424,6 +2432,7 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 				ERR_PTR(ret));
 	}
 
+	phy_power_off(mhdp->phy);
 	phy_exit(mhdp->phy);
 
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)
-- 
2.34.1

