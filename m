Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D96A10F2868
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845D010EF1C;
	Fri, 27 Mar 2026 18:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KdXbK4hJ";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59B010EF09;
 Fri, 27 Mar 2026 18:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBrdYhtuD7bVBNXSZRFJ/czhl8CleE1i3co6vQY1Qhv5TZTI3i45TH4gO4m1nlwYRjOQhB9VXZ4NcKDGuceBzBHQ1iRxDCjfNFw7OKuh9JLmjwUGVLJJraWePhZRrISofho1p/Hg8uzdVPrAofZG9NelzczTv5RYAhkU6ItFyOeWlOek0WrmQ01ToBKMTlVje1fP77tk3vGEj7r6aiiQli0hXMB+i0444BIGnkaGbBDjxSDtU40796Jnzp2eWqQhDnbc/ziF0YMY4jt/hITGBHhPVr9rOs+5Uy57IMDllO6nvj3h5G+t6yd7OaalRLTqOSfsCayMX8eq75RhUPueTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/8IFemO3A8G7HYoTa5WO0VaG7lZf+B1vLBMtAQUIrA=;
 b=L0ddRc8zFYcj/HZGu+ANM/W0qCPGwR7fopDujjdvBH/XAptEF9wmSAbdx6IrFKabcHdA7TVRcSuyCpSeV+giDfEQA7jlmXYVDbq4/lh/Q5Q3/xnecGqARuhCZoej6QMWxSeyp8DsWMimjX+V4y252sssbuECNWC53HF+SQBqFEoTZCqhIvg8LZMCXRHJXJ2m4vxz+FNgGX90+2WSCsjkAtlpI1pNGzqMhGY6vVAn4lXu7puwytVo2f1B9Ls3Ov/FxmN9S2o/ifn9pM2Y1HxrVUmzsBtK4bgbUizvjTiQlrkbMpGhc2ZebnPOUwAfExaXOPLn0Yp8UwebKpYm3Dp65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/8IFemO3A8G7HYoTa5WO0VaG7lZf+B1vLBMtAQUIrA=;
 b=KdXbK4hJYwowfR3YQ0EHdcfv2pp1gNgvPJJ1ETQAzafIrPb+4J9o8p7WhNBVdZG2Vfk18Dd/PhBTAzoLvAQMik1ea3vFPfhBGVTgAuP9h+V9zKrSoWem3WG6dX3X5dqhOsfNadYSfdoYTeG8UXciz75dp3VskyEw3EFFZNODU+eh3IKa6ZbXaHzTSIEBlzvFf3+V/D+sO/TuRrlsTMpIonGNOqHKa3sJbhV3+PxkubFd3j6Iu/RTJEowMkqbx9vpKCdA6awymF8FczSXUo7cNYccyKoV65EglQxlgAYX+IQHuRNfTQRejGgejFRqxA0GMrIwBB8jc4TGvb8Fllxjkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by MRWPR04MB11287.eurprd04.prod.outlook.com (2603:10a6:501:79::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 18:48:54 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%5]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 18:48:54 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH v6 phy-next 10/28] scsi: ufs: qcom: keep parallel track of PHY
 power state
Date: Fri, 27 Mar 2026 20:46:48 +0200
Message-ID: <20260327184706.1600329-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:802:2::38) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|MRWPR04MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: f33495f2-deea-475b-edcf-08de8c317e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KKpkGAjXHUdsD/PJ3bx0Cx61TiSlnw3jU/3JRNoHAwDbGVQR0CD7oi1eIZ1AD5J+ss2nnmi8on3bf1O8Nc9wlFmrar8wgR5QZYsQ6WJsGNlb9cqyX70ooEggg8eh7dXJ1MucA5tXdUtXPdjCNWQmqqzG1Ftj6J8SqKn+uoagoM7JyPRvU8rQWKHNFTxLe2gU8fu+wQo0IUFa766ogetnrlkRlCm6tLeWKaOsI3fblE5laqmzWy2UuEZB8wvAPJOCrNWiTeGyPnDwj6iRa5LBqkZdzXLubM98qcDz3Rdo/eTIW2DqoLONqc17FCEhJoC5wYSjlm/sKmAkfD5rn/wXwbofcdWReyaqtSaocwwh/fMsM5OwQnzhb3+ei3BaDQz7sx828ySDw+TkRlLC8cSCUQcSoipp6c5a7fKA44WbNbSFwONMXkrnhZeSF+banVKVMkPEiH3+MFaT1r9e99Z+ZrQeUpKYoskxMSKaExqkkI66UGNUpdNlo0cOycxQZZzYL9wEcPJ7qgOTXEKTgC7BAJclfR395Ne7Nlmr/ojJwjlfRCloVKOQ6k4/CTWmxNLPnHWovjsCa2oBNr/JuEHGXwyBZ8FWBd3ANNdl+usKxUi2PlwvEcFIppbcya1dAL807GV9u2r+pCF/war7M77Q0bW/hCzCz0rOl1bGiuvuPLbUITeV0Idq9ZBeboq9KRuUEBeHkrlFlXhjIdpyCCMLxdjN/+jU2EkkPQtG7geBifAiPuwD3SMRZv8FWMCYzXf3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8584.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(19092799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ofrQe78l9h/8xAQf+dZIDuhUXH4V6y9XLPhTWmXwJ3EQyaszTj3AqEiwzSXi?=
 =?us-ascii?Q?CEV97jaG+fv6Cj9lDIBkKCprKMdRJNbX2PwCm2CzdjafJGYngQdXoNCSBJ7f?=
 =?us-ascii?Q?jDbnROErIhWqrDdlUKaHSUypDHRsuOnWv4c/hJvYoCQv6Hra5coc4tF/p33m?=
 =?us-ascii?Q?XVD0uv3zrwgzSFVOt68OjJoIc0TqLUwK+xtytmeKqyHYxr/9Ez0WZThmL+YL?=
 =?us-ascii?Q?exTYEyK7oFY00VLd8R9JHx8a1EV7zSHP6A/tCdiCvrZ4gbz7IkUseB9XbQK1?=
 =?us-ascii?Q?TriH/6Ln+KzD0zcC31EdZ5Ij9zD8YyCpTcmCRsN18hO8jQUSsHFeNP7vUh8H?=
 =?us-ascii?Q?Gt6jZuIf3nvofLbNOYGlhQqOr2lxbZlffjxvx3pCGfm0lWKwKiKZ5xgNzU6K?=
 =?us-ascii?Q?1YlMFr4XGh9vNyg91NVQANgymhmyDR6N0uDJStDKZHzQMnGLydWHqYtOOBuo?=
 =?us-ascii?Q?gfQoC+kwxwgD9YOICSB1oiF1uxh3afCwjK+/yKfqoFvsLFi5gEMplZp1IH5n?=
 =?us-ascii?Q?XXDkGIWw32SxMLlMcYhR+lwRV/9c9owJIWOwQB2N7rwd8NHUmmFcFGfsHxnL?=
 =?us-ascii?Q?IETtzon+qYGCPjbgGDP1Zoy61yI5WvmSaTo40Q+msJTWMiJDvsZ/szV8ozl4?=
 =?us-ascii?Q?yJFJg/BxrqhkkbkOcNFp2kJlSS5qVXo0+Nj6m4yURgCIU6aQ69lsgPxOuLOY?=
 =?us-ascii?Q?fN8H7skQsrzewSTN0ueulAqYT07G0gjDpM3T0OW/2O/aq1ay+LqOtIrsdcvK?=
 =?us-ascii?Q?IpyxnSrQjgllpcEd1jMBnA1FSYS2jvhb3rtdijPy4n+GJZ07AtFhBdn6Z+uQ?=
 =?us-ascii?Q?YHjs33WT6LTHl3pWLNyJw1FiSBeG+Ztq6b/tZnk+wgp9g9XrK8qiO7lhr+jW?=
 =?us-ascii?Q?8D+wj6smvQz72W21xgTb1PbNxN857HJe+6AuaxsLAFQreAq83kKxPDSOESes?=
 =?us-ascii?Q?ys9rSz5lY+jfFVDu4xkPZfFcSJ0k83SfufR0nhTyxPg8JcLMlatIUcqHmh82?=
 =?us-ascii?Q?fE0Wl8vU8eXnMRSdzkNYYsy0EBy4+mukwFAoR7o3VvdX5726U9fHUpavfJTB?=
 =?us-ascii?Q?hSqaoAepI02GzzsTuXHjcmXWsYJsUcnZ3mbxIbVYn1Suz9wj3Zns1zmY2ni6?=
 =?us-ascii?Q?5qeUQvxZs/c9lSsH4wVnCF1cCB5AwCFcpxAtXlbMS55Z2XBIoUz8rB/1Fez6?=
 =?us-ascii?Q?J3XSm4uLJYxecIbRl8TecHbLr0Hfn1Ou8Y4FltP2vjMmSkbFybHY3TntAcXD?=
 =?us-ascii?Q?Pv34ZQ9iV2GtHeKll/oarGgHaroW1gsmLrBo/W/1VzYRmbskPPFhKW0Ln6Cx?=
 =?us-ascii?Q?HOigCddVXIqeAFcXWAYILOPKeuJwseRarrZAUJdw7W4H/TrQajEkSXN8ehUR?=
 =?us-ascii?Q?bJc82++yhxs2pxuYjay7Vi9QlCIJeUpOVjoM8mSYm28rcSCeddIVJob+SlP1?=
 =?us-ascii?Q?4h+mfL6nr3LFg29dgOqvrrykRL0DIzSZOj3W7IoZde+x/s5OV4oGBQFDLTBH?=
 =?us-ascii?Q?7bQz0CcuiMVgB4Z0QfOPRr6dwuE/RKzIdqbaM0A9PJ8zVSTV6xYXElk/e3nP?=
 =?us-ascii?Q?MqxYBVx48ZpPdsdVP8HkogKCI+mP8Lk7RtXLzm5AfiRJ0h/yN3CxDFdo52hY?=
 =?us-ascii?Q?NMqGU9brmJG8gTVv0zgtiHETy9oLQP5fCKGwqKIF908G9Yfi31v30D5H0+t+?=
 =?us-ascii?Q?p0YTDZRdKUeM199DhRZoR6JQjIZfXGlvifnTixz/Gjl9K6T0cKsrU8vha+MK?=
 =?us-ascii?Q?2KbeLzLnW56KmMFyQ0kH99Bw0JEkOr303mO4v8WMp47Qt6kel7szm8iOTGzK?=
X-MS-Exchange-AntiSpam-MessageData-1: ck0bPn/L/xe+AVP2NuUwhSrem6PCqgVmRp4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33495f2-deea-475b-edcf-08de8c317e9b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:48:54.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEvEMrDtvb+pUQvcbEfh51leInynvkBrR9j5mTMsIvykCbnaznmvPvJLVXm2Vj545J2T90iJTcCQ2xDZBNfqTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11287
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

PHY consumer drivers should not look at the phy->power_count (a PHY
internal field), because in the general case there might also be other
consumers who have called phy_power_on() too, so the fact that the
power_count is non-zero does not mean that we did.

Moreover, struct phy will become opaque soon, so the qcom UFS driver
will not be able to apply this pattern anymore.

By all accounts, the need for ufs_qcom_power_up_sequence() to call
phy_power_off() prior to phy_init() denotes a skewed state of affairs.

(1) The Generic PHY API warns if phy_power_on() is called prior to
    phy_init() - which ufs-qcom.c does, from ufs_qcom_setup_clocks().
    The UFS controller driver hides its tracks by dropping the power
    count prior to phy_init(), and that API violation goes undetected.

(2) phy_calibrate(), as implemented by the phy-qcom-qmp-ufs.c provider,
    only works once after power on. Next time it will time out. And
    since ufs_qcom_hce_enable_notify() -> ufs_qcom_power_up_sequence()
    is called in a retry loop by the UFS core, the PHY power would
    normally be on, hence the phy_power_off() call to ensure the
    consistent state during phy_calibrate().

The above constitute improper Generic PHY API use, *but* fixing that
requires delicate surgery and I'm only here to stop this PHY consumer
from using fields it's not supposed to.

Once this discussion is settled, I will also address the above issues as
follow-ups:
https://lore.kernel.org/linux-phy/20260327112858.r5lpqygtvsane2vf@skbuf/

Until then, we can reimplement the logic in this driver in a
bug-compatible way, by keeping parallel track of just the UFS
controller's calls to phy_power_on() and phy_power_off().

Note that phy_power_off() shouldn't return an error in general and
doesn't return an error in the particular case of the phy-qcom-qmp-ufs.c
provider.  So I've removed the one handling of phy_power_off() errors
from ufs_qcom_setup_clocks().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Nitin Rawat <quic_nitirawa@quicinc.com>

v5->v6:
- rewrite commit message
- drop phy_power_off() error handling from ufs_qcom_setup_clocks()
v4->v5: patch is new
---
 drivers/ufs/host/ufs-qcom.c | 15 ++++++++-------
 drivers/ufs/host/ufs-qcom.h |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 375fd24ba458..99feabc69111 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -508,9 +508,10 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count)
+	if (host->phy_powered_on) {
 		phy_power_off(phy);
-
+		host->phy_powered_on = false;
+	}
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
@@ -531,6 +532,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 			__func__, ret);
 		goto out_disable_phy;
 	}
+	host->phy_powered_on = true;
 
 	ret = phy_calibrate(phy);
 	if (ret) {
@@ -1263,11 +1265,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				ufs_qcom_dev_ref_clk_ctrl(host, false);
 			}
 
-			err = phy_power_off(phy);
-			if (err) {
-				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
-				return err;
-			}
+			phy_power_off(phy);
+			host->phy_powered_on = false;
 		}
 		break;
 	case POST_CHANGE:
@@ -1277,6 +1276,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
 				return err;
 			}
+			host->phy_powered_on = true;
 
 			/* enable the device ref clock for HS mode*/
 			if (ufshcd_is_hs_mode(&hba->pwr_info))
@@ -1467,6 +1467,7 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
 
 	ufs_qcom_disable_lane_clks(host);
 	phy_power_off(host->generic_phy);
+	host->phy_powered_on = false;
 	phy_exit(host->generic_phy);
 }
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 1111ab34da01..72ce0687fa42 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -282,6 +282,7 @@ struct ufs_qcom_host {
 	struct clk_bulk_data *clks;
 	u32 num_clks;
 	bool is_lane_clks_enabled;
+	bool phy_powered_on;
 
 	struct icc_path *icc_ddr;
 	struct icc_path *icc_cpu;
-- 
2.43.0

