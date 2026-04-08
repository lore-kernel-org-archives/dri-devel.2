Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D44FFD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23A810E548;
	Wed,  8 Apr 2026 07:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=windriver.com header.i=@windriver.com header.b="Amubntlj";
	dkim-atps=neutral
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8442C10E54E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:29:14 +0000 (UTC)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63856HcK3478919; Wed, 8 Apr 2026 07:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=PPS06212021; bh=+6RmWVrRq
 T00CEMV68MKVIV30n9RY9p+V694yN/Pwzs=; b=AmubntljT0UvzpN1vPq5m5cIn
 grjkIzRoE1FGVUzbU8+v2wAGFAN9do944tVFeA3E5nxyV3wpKDY9qra3zbjI62Bh
 f6ishEBplGdaZc2aMB0+/PdvdlKjFG/ielwxcSDsIm23VpNTu7ItSMdC2B7YDW4R
 RTHer8XzAKgO47bB3kEUaboutKrvnvTgJI6cNA8mk19LWPKkwhOtijBlaxk4bQh9
 YhNjoC6UjLNwsbIo55gkXU/nxKRVt9O1qnadEGZFJmUSE6ld3/dKF8x00d/SXD1R
 EmP5UYXc6NPshZt8VZB66EJ6SwbAoLvqe1LZsmoeqXNzQqvIIB7khB8m9IhQg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrya5ey-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Apr 2026 07:28:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVRT00ZfIRFTfpbE7ZnYEMmIfckkuun1Lrskqf/NTkFaBhd6UqQ7Q+jk5hqiF+/iyHzZYALJ666+edgAwBs0cB0+3LKoVW8TOs+NJzEphVDTe6Ro0/6jsoCcs39RwdtOuPvZOC6qwQyl/tZ/sHdJoQ6mH1lZRW5zqhjTT7LuAwhfCRKA+609fDB6LfM4d8oI9ec2C3LTwmb/yoi84xIHbIuB39js7PiUEL/4cwhszcM0hHCTnjSUC5MD0VyokyOgyKXChiaefLKvOrZMYDejYj3Zfi18k4m+8No4/I09pfsYhTBIv1U8Xo+btgL05AlNoHZ4JNAj/dYxJIL/5jGX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6RmWVrRqT00CEMV68MKVIV30n9RY9p+V694yN/Pwzs=;
 b=kL9tuoZ3w7zRvUtkteU7JG8PS32JkMN2g6PeuphLtsAf56CW+8gzfzuVnnG2QpioXW8GCy0VlTAobVEB9huygXJCYfQuQG5ldjuWDFi19GgoG400CQMOYjQk/M7WgSaKSAGrQT0IyizEsmqfm1I03KVrbmdKCBHkXcjIdzBypihyUa01i7qvc9wyh9sw3IjYIJeJl3LUg/+tYLBNr0JV6+3tl0+kil6zBmGXR0mIYwWglicSZOeDVmJYffoIFGlyTMxDkHTe1B0MwJcHRvY1kXHW8Ia0/IRXTpDm77dGNVNRLZ5EbqIQ3Mu9aiUvvqC5JM6++ot3tG2BIb1kd6dPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by CH2PR11MB8834.namprd11.prod.outlook.com
 (2603:10b6:610:284::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 07:28:21 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::acc9:24e7:5138:6cdf]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::acc9:24e7:5138:6cdf%4]) with mapi id 15.20.9769.009; Wed, 8 Apr 2026
 07:28:21 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, Xiaolei.Wang@windriver.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fsl-ldb: support downstream bridges in addition
 to panels
Date: Wed,  8 Apr 2026 15:28:02 +0800
Message-ID: <20260408072802.3947600-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0117.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::6) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|CH2PR11MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a872c-1e3f-4962-7d49-08de95406988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|18002099003|921020|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info: mY+rVb97oWbN/TUjZHBUIFHJQrj3XnwD1BIaz18RRhOdzHpLwGzDQoG4rPb/lrlC5t3jR+JH5ZnvaBx+lnIbhJ6ob6FJxaFRu1U47lbsDUDpxvGGbcK64DZudfNLwyZLOWy1V5Nvej8T8kE0NGqjv8+MtIq4U041ckOU8PkSzVuydhXjwaGEEF3nLSA/v/9w+OdnB42jomJsp+T3eVo5eNACV8IagcOoN+4r2Wz3fk4UEgrE2daJQ5+5B8xq6gYjCxT5PJFdSaWuShidf8+iHV1R7kJlcsHqF38Jt7V0VHdlhJrB4gBUAdpSrI8fOLk8/DKv1uqoR26NL6rwYC6pmGpDoaUACBvGnDmpcboPeG8EMAUlRnZXj3qaITHrDD2MelssvvqK0PVtndJ4LsSnhvY+4Eu8sjmOz9vFbvRfMI1oEs8XnUG5l5KkfMgrV2zmHgZt+VzfDvHYTQucSSAPf1yRMWodtGgpDGbN9PgMi3c3TKJETSwfgLV/WhQ6uAaH18xlXiU7LICUTuMS8c/0AJypDbJ/pLnIyKDKZzeWA4vna3mk0aCI9ZhFstna4w85MZvEmLYrLdcaGnnj8k008BTLkNevjBwHc1eSQEHBCHzDe4DkDRkgHDY9r0yp97w7JlsxZnzpTOXsiKyECEeRIDVrUPsBGZZxcNzoL24ol6K9xtPAzVXfT3RvByEiw42P7mEEsxTNmdZ+/IZssA1ib2MjiYhYzNao6grm5azK8SKQ3vkb76Iw4ZvmpiDf7IbcaYvnrS0mixhwByY8iFWck9uPK5LwMyfs8GX2TeusyOwoZmh8B/elj+AlqSzdGVpt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFD667CEBB6.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(921020)(38350700014)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJlv15YSmmi7MggFZavmg449meCSsUwfEiEcdrSFMb+vFBU4EMqjHEOXyU81?=
 =?us-ascii?Q?uICjeLahWaH/UgvKG6zEkaPnfYhJ7G8PTqOP40KRyoyVQdALFEuFqYh4M5Xm?=
 =?us-ascii?Q?tPe3TuXNKwN6M8m+oLtf7EPF5bznmZM29lMmkT3keEPX/dGxNYshZQunibcp?=
 =?us-ascii?Q?EXlAsGwciHUe5xlyhOjWYVEnE3gAerf94MkSZkAfRf6qwDaHa0h0mPmUzPog?=
 =?us-ascii?Q?S9MSO8otu7A10CUIFv2ny/JgBTLNMWZkzh4DIBATwNtMQAOMzwBJpVvbYejj?=
 =?us-ascii?Q?5bkfKClkaCH5NfsiXq+e0rBcuMOnBV2JbdU8gzjrW+NP4hPtu7iK2KOJcFDP?=
 =?us-ascii?Q?Zxyb6e+iv8nSVlbwxQJ1LkEhk/Szve8EOB3CC/GpwllGNt3MUtcT38RqCC3s?=
 =?us-ascii?Q?GNKlFnheKXyeFWVX7jKASOOB/IWSxkIH0NXsID4B3QtNdIt8Hl2Jg10LBEnn?=
 =?us-ascii?Q?99PicyMp6S1BcRbxwDGQ8Rhm4ibnDkZuQt7Coke+FNmvqfZBt1KV9WIkhFnh?=
 =?us-ascii?Q?N2Aa2/4M7zMc7PGyxbUv9ztAcYf95F0Qdius+jzMN/2lNxJTluIWxnQP/k+/?=
 =?us-ascii?Q?mwxbevuD+a3JLhYY3l64xAU/lmgLJ/tIPO4f1v7uF2Mi5yjtLmK/InqsIU8T?=
 =?us-ascii?Q?OEXYyIZh5stEhIqUYdPbNycj+nFCfXnd24H5MRhW62OGsKx/f6rPhGLNvByE?=
 =?us-ascii?Q?idDE+Ph3IOdX6fXbmPSW02UDfSRXY/kowv4nM1I61Ms4GnnXIoXEMs78UrPL?=
 =?us-ascii?Q?7X89oWVvl3XOcFYGuXGf6MpZCBsUC7uXNVNhVmXFcl1evlpeosCzIBlQOJ6e?=
 =?us-ascii?Q?9lyx5b1wLs/UT83F+fnIAY95BB+fj+Nb+8/bg3bZyLYcPlWPAZ1chTX4FB8i?=
 =?us-ascii?Q?N3spQgUQl2EvslbEJIdJ/jOiEExzi638llgGJEoEPB0Q8Rhu2Ge0i4laEwYt?=
 =?us-ascii?Q?f9zxUPL5iyqKLbBHgmCcU8RFtAYJcguab2CTcvT/RQ3AFdIXHGunxGnG8M8B?=
 =?us-ascii?Q?alx9fFfMhIs5VSpi546kKSNks46n2ExfauynvZhtkNN2l3pSRiavUaXjjeAh?=
 =?us-ascii?Q?Du9kIdXrMBBOmN3FQe0vVEmnupTGyTS3JIaTZ5vU+pvVy0F856aLCPvJKZt+?=
 =?us-ascii?Q?7JhUU1UMYVIlpFcbms2RAxZ2qeSMO5yw1kcp1/sB53WJfNfiHHYNavTg66Ca?=
 =?us-ascii?Q?jES7BxS2/ZxluVb/Mwti3tbm97gsMPAnRoNAuEXmRe+Ldmdv7/7/zJu70nGB?=
 =?us-ascii?Q?g/apn3tdS8Qal1agQ+uXK2tNNLMJJLvqNyww2yVApKGzVD1pLOc8ULWq4awm?=
 =?us-ascii?Q?wVXDqNlonb850nJRaP6ZHCh8YQJc1Wq/nxE1BVDIZskW8+OIZY7XR3OBc9D2?=
 =?us-ascii?Q?9lfk7UQweFIK2Rc6TZyjN6HHWW4w4BF7NnHmOKXh6eKlX3n3kIhfPtVzeTco?=
 =?us-ascii?Q?2W5NNQ3tX9uxjp4VdbCuQ2wWu10nrwfTMZNYniFJzrq7v88qYaKeE5gA86I9?=
 =?us-ascii?Q?sgFbDK3olrGUWtMPa/duhTrrgKrdb2dLSUyBlR6WEJAIAEw+Jc64iiMm4biz?=
 =?us-ascii?Q?7wBnoasZ754r+NRvr7z/ujNj0sKn9KQd5B5uHZm3+Rw/qGDcGhlHv6p1Lprr?=
 =?us-ascii?Q?QFL5QzEJXaLpKxq5tsab6+YSPpz1mwV4tGVT8Z6gAbysiDa0knqSYQ2ixkYx?=
 =?us-ascii?Q?8h8SA0wwp7zuH8HWF1FBEUibo3bfLEFRXLVJRfDdYbwi6V7tiomWxMS8N3xV?=
 =?us-ascii?Q?gtYTSDD2Ddc2D6gZS5VMf6RaVUeNHi4=3D?=
X-Exchange-RoutingPolicyChecked: qSF2iBBbh6FQJ8MKA8JdsXYKTiv3GbLJaZDtwgQSC3IMgFX9NELIUxiT32RNye1PxwbCEvgFqa1B/XlttidsBSvX4cboVnjik0am+pH9rBb10qw/CCOpp5+ZnxmxppLIocIzu41xMfqRegETOONKHAOOAK/rLBlngbKCsMza+0Qm+MDN9foc3tGr9JpMkSnPaZUhj4fQ4lukEj1pH85f6jdP7Pct5tva7HwyfHA2DP2q7M8a2S8FXH4OP80jcqz6WAdeZpxLTFKTHBmszf7EwyueciWGkUf2d9Dcwq0hcsB07gnNnYn+DQ+C3tG3uOzuf/Abzj2zKaKNwMtbPsamQA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a872c-1e3f-4962-7d49-08de95406988
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:28:21.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTPlYOclQk6nfQOtGXyCIqBKiVip5J0nmIYztIBA5Hft0sZA+v8nxr58H/fL/dCJf16tMnf/TmQ4M1juU00eHLj2W/4CbAG7MM9WEfd7VEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8834
X-Authority-Analysis: v=2.4 cv=QoduG1yd c=1 sm=1 tr=0 ts=69d6039a cx=c_pps
 a=9KM80f3Gg1/mZdPsmiBtBA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=Mncm4iutsJNvaOiebwAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: KvCUDz5q0gpFNFA6d8H-_pZmgTlkHNjN
X-Proofpoint-ORIG-GUID: KvCUDz5q0gpFNFA6d8H-_pZmgTlkHNjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2NiBTYWx0ZWRfX2V0x4ZfVlAwE
 KWaOh8CKwqUYfceiAEHQo74OS02qe6Ao5IjJpMTpiSGgYVl3WOE1HPNhnsFDstLi7cpg83hzzEq
 Jqz1vcmHLwgQNRQPIOwdWTtd2Om/vEAVnJk5yRqS0yd7p1mrXvACdak62gUJJouhP9DjL4SupFe
 z1h9C9JTbE0PFSv7e9QGMNenJviHQUfs0r//6MqRIbtlZ+AOeUl1nkaG338wGQL5+i4Jk/Xv0db
 SrBu0cm6aVi69miAUuaPgfiOMCNKweK7nCBJgBKZ5nVNT4e+kPf55C4wmeYZ234aF95UbWEDWlo
 3T7919aHOpNLpaXnMaa3n8J3ZnkQBrnfdiR56TYvl11elTV1GXqtdU7dJBjZsbECCcns37YdY+4
 r0thj7goHfx61vr9t+kl/7+mwJgF6kauUunJ9E3KOI9PvYvruT5bm0OkJawWx5QrkK04rVMDRQI
 HQrUo3Ja9uGEkyZrFCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080066
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

The fsl-ldb driver currently only supports connecting to a drm_panel
via of_drm_find_panel(). This prevents it from working with downstream
bridge chips such as the ITE IT6263 LVDS-to-HDMI converter.

Replace of_drm_find_panel() + devm_drm_panel_bridge_add() with
devm_drm_of_get_bridge(), which handles both panels and bridges.

This fixes the LVDS-to-HDMI display output path on i.MX8MP EVK.

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 5c3cf37200bc..2936c945ba52 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -292,9 +292,7 @@ static const struct drm_bridge_funcs funcs = {
 static int fsl_ldb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *panel_node;
 	struct device_node *remote1, *remote2;
-	struct drm_panel *panel;
 	struct fsl_ldb *fsl_ldb;
 	int dual_link;
 
@@ -322,25 +320,18 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
 	fsl_ldb->ch0_enabled = (remote1 != NULL);
 	fsl_ldb->ch1_enabled = (remote2 != NULL);
-	panel_node = of_node_get(remote1 ? remote1 : remote2);
 	of_node_put(remote1);
 	of_node_put(remote2);
 
-	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
-		of_node_put(panel_node);
+	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
 		return dev_err_probe(dev, -ENXIO, "No panel node found");
-	}
 
 	dev_dbg(dev, "Using %s\n",
 		fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
 		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
 
-	panel = of_drm_find_panel(panel_node);
-	of_node_put(panel_node);
-	if (IS_ERR(panel))
-		return PTR_ERR(panel);
-
-	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	fsl_ldb->panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node,
+						       fsl_ldb->ch0_enabled ? 1 : 2, 0);
 	if (IS_ERR(fsl_ldb->panel_bridge))
 		return PTR_ERR(fsl_ldb->panel_bridge);
 
-- 
2.43.0

