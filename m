Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACC9C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09ED410E2A7;
	Tue, 21 Jul 2026 05:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H4AaNQ+A";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J5PbIM8B";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A900A10E2A7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 05:10:28 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNC6vF3420216; Tue, 21 Jul 2026 00:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XtF4ZHdkeBc76UmQTqGqFoIkI+AkelJe7+tvqGsQG
 3Y=; b=H4AaNQ+APwmPOH32OZYLDFW58jqVHMZgOH3UjxiPVQ2c7k7ihCNjD7uQ8
 6WS8zUoh6NdBh0ZbXd0xZF3nQmirJFk8KIsBBmV8RBVM5Wri70dy9qK6mdD0vY3T
 Y5Svxm1JzAaYJqs+D6tXl9ypjF8+y0NT+34+1FivGBSFcDKaNgmBfIqlEf0VlduV
 o45Gq8uO7pJ2drhbRmNGyOnxJvKaIptt5dmtCV2ySgfjb71U1z4lv7HEdoQmQlFr
 Joei/8iBjVncEEWwFa3Be3Aq1rRYspipRVhZxEC28lpJ5/fXM8zv/ZhsB3GP9iCr
 DZqdwdzIwJwEjeKyZKlvY1/Vrxx0w==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fhk19dfuw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 00:10:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePT8URpzwPmWIXd+Iq+YbphBhXh1d8H9TMpeVX4mbnycEAIg0MqbkCGydUqFW9tBZr9GozhCZw1dVHRhg0eTKuKtQAKmU22gpKXBp6PsEYwEgAKF+wEuSmRPj7HCYIcOk/rb5RupX40/T+3TIHW5GGMTjQRjeA0HM/4ow9TuX/6dV5snyQ5Ix+HAU9sit3E5RPHh0lAdCeK3awik555TUxlhjFaug6/Yokvnn6nBgLrAhQeQErN83JLWRRa7+0F8MesHStsTN4jlqnSj+VBemGDA3tKduq1G0iEyvwIz2JiyqUb47kQJF2TAaEM66OhuKgWte/hFKatJ98MTzNxo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtF4ZHdkeBc76UmQTqGqFoIkI+AkelJe7+tvqGsQG3Y=;
 b=oip6IcoQA2pstWCbAn0c9mQy0xR7wybz6BV9mRR6DlVLKTua6bmOHFQ9QEzZ9NMltdkVi7xTA1wqO3fYVqhA84YPxggImB5An3FMrD3oairIA3UZuDiiRRRCXotm2olvH/ecxUBxwSEDZBuKYiWg2X814AQMe301mDlvNAJ0/j3La4UTh38xkYN/nzgfpN9ptHbboIDgbGCfw9f0Qtw99pqk329Kev5q3APkD9v0nmIC3y0epUgu7cwZGDQj5BLRpGnFG2/Rs5W1FcOOzKKOwRVVDE4swivZIIrixvDrgiNWsa87zwYUfsp6JqWcCJvzePLlYyE2OHYxNd2x/jF++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtF4ZHdkeBc76UmQTqGqFoIkI+AkelJe7+tvqGsQG3Y=;
 b=J5PbIM8B3DbDYVNRvI9q9BivzIiiqLnh66oq6rvP9i6KGUosyaLFzeLyJvj92UTWOFzMVKOTIK8txP1FOTJFiH+5HiCPc6448hPRAD6PZ6pR1wpds3rq12eCPNU65NCVQKsWOqW9zX1WStINbYvE3YZeCvNP/+odaV7BvKVfs6A=
Received: from CH0PR03CA0419.namprd03.prod.outlook.com (2603:10b6:610:11b::8)
 by LV1PR10MB998099.namprd10.prod.outlook.com (2603:10b6:408:3f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Tue, 21 Jul
 2026 05:10:12 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::61) by CH0PR03CA0419.outlook.office365.com
 (2603:10b6:610:11b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 05:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 05:10:10 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 00:10:09 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 00:10:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 00:10:09 -0500
Received: from [127.0.1.1] (uda0132425.dhcp.ti.com [10.24.50.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66L5A1uT528303;
 Tue, 21 Jul 2026 00:10:02 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <laurent.pinchart@ideasonboard.com>, <neil.armstrong@linaro.org>,
 <jesszhan0024@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <nm@ti.com>, <kristo@kernel.org>,
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, <thierry.reding@gmail.com>,
 <sam@ravnborg.org>, Leonardo Costa <leoreis.costa@gmail.com>
CC: <leonardo.costa@toradex.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
Subject: Re: [PATCH 0/5] arm64: dts: ti: k3-am62-verdin: Add Toradex
 Capacitive Touch Display 10.1" LVDS
Message-ID: <178461059322.873002.1418626911524696580.b4-ty@b4>
Date: Tue, 21 Jul 2026 10:39:53 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|LV1PR10MB998099:EE_
X-MS-Office365-Filtering-Correlation-Id: b6578dde-8fe2-4b2d-9d7c-08dee6e6570e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|36860700016|1800799024|376014|82310400026|18002099003|22082099003|56012099006|10067099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info: VQitPCq6U3tvZa4nxq3Lf7xxFDD1cFUivlEE3ckJlSrZMSw/nSUkGWuknx1dkQdjbmcTGY5ztw9COrosu2a4sXWGihCDDvvKXsSuk3VJ/tCkFx85Si24paoK2iuGOeBNUv69Qr1NracPu5Pqf859FeO8APvhZ6+h0J8r/E5x1AT+Quf9DzH/8u/jy9esrPuAibVJuL1wkRrMUWFU2AyaE0AkTpZXwsaP8jS+oEdXrXW119GWtku2jpNJljVYtgg/rVRV/cBGtX1TJmTVtPUqjo29lGB2RRLwnrBgI7MhcP52dvwuQ2Ud6+ZDsQu7I/ID9MNRVJGh59Df3wmUrgWLUDvxzBCCd1p1An8kMtv34IVTbHBCV1J+dGcIyZtZijE5YxxzBT9iFc+z+Ar7Ax35xn+/YZsuWj7kfJjYS1hMOtGfwIbR+lwvuQrzMG1FkdKNjyrBeXjzOrHP6aXHLE0qNg5bt2icLzdC4A0aiZZdKRLJe5RXN4JxMB2nPhL/Sdd6/uDPSxqq+RZ+iOp/OJBUs9ND5ca4KLgAe8/byDbDaDFuy3crlgNgTO9wLNKRZkG5Le5mCG1cRas7JjEniIgrSa8kfFd+qEN2Ff6AmZwcleunl7jb/bHsfC8Z2L98vMMaN+VxKSVSYgahdHKs9RWH/z6Xkgx5/PRFWZxrpDlzcZpNQ8atDmTJjabOEtDcBoWgVwiI0wzd2sVsIbaydM6PIXH4OuNHSyIBkCNJ78tMNWi5cmVcyKGHaj/R9uITvMYZ
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(10067099003)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k7BPXXn72L+MThdVijXqyDJCzKLTadl5dlgvousuCrrLZlhwwnWGKBmDtbnbc2qMTTdsODEMlkRhJW2WQD/0fpzijKBhc3HMTtGmRycUgeuDUiOwy5GASeWC27bSRTGhp+urJeLuJnHf7zISKIuk1UN1mEK9wNbwh7LoE1u9OS/4and4jQ2D6gx6Y7la4bjp6mJaDWhYpnbIIjz9+KewmA+H43RXsuuCFYtSS3WG7dg5zHbf5T9aL0wbaTZou7iu2Fig+GmgktKVUmz99CZIP/z+W1v4ehRKy56p7ZwyR1HtK4qjo1xNj+jZuSzUh6o4+QKnj934s3N3gLsmEXfnNO5jwzLS4I/3TxTDKN4BzoB0uLYylhWqVDXCpvUaSH05tUn1OZidl9yLlprsGepY+XhnqbHG2fTEDRwX7KeMiNwTEABocMxKoOyfqaqfny5h
X-Exchange-RoutingPolicyChecked: ck2FdEqrFZ5iho1V0DJJ5F8jetpE+WB3lxhjvZLTgO81vbF15nBCfqLDWrRpcsptNbNmtGEkfYuaenbaURRf8w65ktZZqhfZO1yyG7WvJ0AUFeJA9f0iHtl5eC4gd1jgZAwvRKQSwLaK/osI64dbJ1+yjLX46Cd4eMd8zsKi7ZH1nwtm0jEtRA0LsTu6YS6DHE0Av0Rd7UodwLYGV8l5bIS8dn7JkqJTz1DJZ8moS5k1Vld9Cwg/lsXIN0mGAvFXmnTllt/cecM3dVGhoZAK6loN9x0ZAMj1YkD2oNgphTmd+PRBoABqEMK+SBW1FJvel5M4W1rRRASHVUEL0KMr7w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 05:10:10.9551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6578dde-8fe2-4b2d-9d7c-08dee6e6570e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR10MB998099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA1MSBTYWx0ZWRfXwfz/nbidQ+8F
 0IG5F6i9Cv3donni8WpG5nBmOG74AEoi81WM52OVnjSc9mHO7H0ETI4He2UmAf8I0UXfhk4sUe7
 OGW4OkXC6YDEuxVipAoJTqodaEwQOgW1d3ZXZfTqLVO3DJSyZ60XHjX8oWUv4lV3dSNXBM1IkSG
 WpODPiOKwE37s4dAZn5WSAHK4+btsYbvspnJojdvJIYwRK05ETw9F8WWZDtXwOX0eYkHMRu/5xu
 pNU/byAT5vSPIVwiOM83FHQaKwOHLYUOx6VA6WUoiOoos+3sztzyRVWZFGd0gRT3FxENswuph76
 1v002jUV+sjf8tVYyumOqr8BXmh7hGtLRCQJKFM5AHlPv8asnyHJHschb/zozmG4QHKSGRMbozy
 uN04r1F0SyPLlvPuqC+BA+OM44aK4smbGCeiW8ksPrivkYx2ToK9c0od9smT6M6LuW+bMiblcr5
 qdn8yfYLaYFjkMw4dIA==
X-Authority-Analysis: v=2.4 cv=I4pVgtgg c=1 sm=1 tr=0 ts=6a5eff37 cx=c_pps
 a=8g4i1X1tkAMDiabECo8pFg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=m8ToADvmAAAA:8
 a=o1kACPpZKAZCWsj7fAYA:9 a=QEXdDO2ut3YA:10 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-ORIG-GUID: WWhHGwK3szqNT51oi8vhiqpvZuDA7clj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA1MSBTYWx0ZWRfX9nazMepuOUxd
 f1H79H2qm+/aYSHf0DX3YvIsAYiDbSiCnGt2HNOQpZ4v4aQk+qlmuuRMA82qH7KT+KdwQPt0sBj
 7PtW9ewW3oTxLZXpPdgF+yukSGWrYkQ=
X-Proofpoint-GUID: WWhHGwK3szqNT51oi8vhiqpvZuDA7clj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210051
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

Hi Leonardo Costa,

On Tue, 23 Jun 2026 16:57:36 -0300, Leonardo Costa wrote:
> arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display 10.1" LVDS
> 
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> This series adds device tree overlays for Toradex Capacitive
> Touch Display 10.1" LVDS V2 on Verdin AM62.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] dt-bindings: vendor-prefixes: Add Opto Logic
      commit: d980b7b9263e43bcf876be2f36355d23d58b24bb
[2/5] dt-bindings: display: panel-lvds: Add compatible for Opto Logic SCX1001511GGC49
      commit: 854310180235e4c1df953eea3c97e9a1fca5b53c
[3/5] arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display 10.1" LVDS V2
      commit: f19e38321d061fcbc695f9a7aa609e4ef9eff1a2
[4/5] arm64: dts: ti: k3-am62-verdin: Add Toradex DSI to LVDS adapter with the 10.1" V2 display
      commit: fea4b900f4e8afb518def13b487b44472d3974c1
[5/5] arm64: dts: ti: k3-am62-verdin: Add Mezzanine with Toradex Display 10.1" LVDS
      commit: 46d70de6c0afc95252330ef08c70704aa47a6a95

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


