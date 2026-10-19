Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13346606A330
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ni3drMGh;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=kN+6NTgm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC0D10E662;
	Mon, 19 Oct 2026 21:38:11 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9581C10E6A2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:37:57 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLH9sC742441; Mon, 19 Oct 2026 16:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=VJppSHgKdNqnpdVvvFSh9eUzrN5WnLvlpWKY2rap9
 zE=; b=Ni3drMGhxZTLLdQ58WLZg7Dkq+on+tngY/RRPLqw6GWBeP8uXUM4i84vc
 A2m158yqIlQEKBeJQ2++cMZLGnnr1t0RBel4ZKzE+Xo3JGAHBO34LsxSXVbtLHUM
 FpEd8/OtJLnkzo8P9/TNqhLp08PdO9CobAFjYZLcN9B5v7KdbTt9xpOGxBYjudUK
 8AsrRQ/RZ4Woqd4pOpi3OHKWsG0xs5Q4s2kW/5ylh2GV400yXMFijGRabyAitJ3J
 hOjwdViNAiW9A6f3wi5Qh5uNDyow0B8paEOl8CFAjTo/4B+vQs4TXhczdxUOinzt
 jOKsB5X8ZQoZLPLgbmhm0Lt2u8+Yw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hdjbkuq8w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:37:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fmr5OX7LihIHdx19EQxcH7LfNTldSaeSReEh/h7yxgFsDooQleiJSZ0A+K4GPnilxtzhyYnXMoSyHiPqeuA+zQ4Of2v23nVQ9UdtCCbKlg2HJ/G8DGtTZy0BaiFU+foZLB4/jA4mHNa1Vhj73tBxOEcKSkQHNjqSvE/jKwznVLSTIL8km1dwsY17UGYhvJQResMlVp+qvL9LdfuibrdnjzaK37Up5EugcXC4p6U3z5O0HndKU5z9kKqFZ22Fn6U++9z0wiuE05VJZ90vELvH7vZhErw72BEQBqlqdassuQDP2SvBG0sZ12rY/UAoG3j0hHTnZ54m3HTCLvQsqNN8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJppSHgKdNqnpdVvvFSh9eUzrN5WnLvlpWKY2rap9zE=;
 b=c8A8Oon+90r8/cQAo+qhj9ns39HLsTn/RFliKpIny4LExPJXj0h7lXudnWeNWv6blCndPtULMdx7FUlhtmk6Ab7zxc0OQx9wYLfqpXEqR0uW5TxsK+S70w9acXgQqzfINS6a+CdsH2Bhxrat7o8Kiylw09qT52tcvR9QR+6Daq9mfMKGIulCtGR1yY+ujHib4wCXnHts9jDd/pCoVlcG4Ibe4b3s82dxkxwUCNjgO6Jc0U4tM8dnd5Pj++DZiLGYHw9Um4W+NGrV0RZOdluzuYetIV/A/GGqLzNLHXXW0u261tnqGV71ZN/wdUs8iQsBdZVOw9pxPlcTR9XkgLQjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJppSHgKdNqnpdVvvFSh9eUzrN5WnLvlpWKY2rap9zE=;
 b=kN+6NTgmJxpuzVNkpfoYAXeZt/5gPyb1Km4J+ZWvWLshuyZBIC+/4v6SBfShcYtkJfHwktZcASZGbmiFiLcDRgZOWP+xaDdJQi7JvoqZXN0sJQq/noARvoVCPGpoNAYkU5WpEHK439hn30RMYA1zGQfEl9K0CD0bj+RYpnvugzo=
Received: from DS7PR06CA0026.namprd06.prod.outlook.com (2603:10b6:8:54::16) by
 MN6PR10MB8189.namprd10.prod.outlook.com (2603:10b6:208:4f8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.14; Mon, 19 Oct 2026 21:37:43 +0000
Received: from DM3PEPF000265AD.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::aa) by DS7PR06CA0026.outlook.office365.com
 (2603:10b6:8:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:37:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DM3PEPF000265AD.mail.protection.outlook.com (10.167.23.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:37:42 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:37 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:37 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbaxG3576950;
 Mon, 19 Oct 2026 16:37:36 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devarsht@ti.com>, LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 05/14] drm/solomon: ssd16xx: Add
 clear_on_init/close/disable session management
Date: Tue, 20 Oct 2026 03:07:17 +0530
Message-ID: <20261019213726.4145532-6-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AD:EE_|MN6PR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 30222123-a073-45dc-5389-08df2e293520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|921020|6133799003|22082099003|18002099003|10067099003|3023799007|260925021911599003|260925022911599003|5023799004|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: o8Kl5iP9EwojCJIDW/Q39jgp5WyKrXo+CdGHtGaRS8Rw+ZwUBhzDjNYrrup7tgR+YOfqRoqb8SCoz9+NpM2zEdVVC9wR26hdTqkHXIeoNuPxZqwSokwvH4VEt/95nddTP7FhVgNhj7t/7esRGpKtW3MxwvFVK3hBuVT4AC7pTobB3ZLBaFNL3xxA/nBvW71/GTI1ldfJiz0qkTQAtPVDVrMg0eQ30KRREtLgUXZEBCYCP+ttFi8NF/UtqQ7GN1Tyiw8TTmu8uH92UnShgjFmwQtdaiyWUKijfD/bfucoYnReaGPnVWCfjQmgTRQJ0/AbubT6gz7Y0Uu08x0jrn1hnj84MsY8u/QmILbxeUTmVwZWZptQb9YDe2rewnfuOrWHFpw3+g6PwQ0b93ZXic/mDqDyVUh/o11gE8C4KHwr9WleUZV1p3ZlCvyEN0ObQ+A5I4ZfLC5s00pHz98ip7tnO2bHzOtU7i+u6tkyU9nSoGYtksubuV5v7qP3MSCqnRGgznGC3HTh8QQ1nEF6dJcuv1DuWWwANrFnOK9KBZukx4dtVK6CseKFIv0GbL5myeuNVzZ7mEWPvuu+TglyOOGgYiB+iANlPWU2hPGmp7bWi9uXtwgKcJSO41aMkVW4jZlIfX9Qp2MPfvfFZhsWxPyFMrijh2nbyOszbmMvjZLaz9Dv+1Vs2LA/W7SWG3ASnFps6m3N11EUFo2XSWZ8DRQ8zNwvQXDC25UDiTvdVE53XdYo4koNgvegWXwTqU0j54Yh
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(921020)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(260925021911599003)(260925022911599003)(5023799004)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fl8m22YjJQTHiYbaFo6r0T6CYJwGhiTvZ1zvZRXVILN8kleKXuKvP8gm2ogddJMu+Diy/kmXvjyiBJIY3c00oXWAZnk515KlUkQRTP+IR5oNU4yxR6G16IFyzuIIOb3WUCORWLufhrhEtmdtZ/QxgpcReWn4/TPDKKVjEpwwC1NfgY0Klg4k07RIKkhiWHupG+aoyov10830Mcx5O3KHJ/8RLcEkFXnGm+PgXPQHewzvp9ObstbTlNsE1TCNIrKeS8eSaJSvXgqZZk13FcsRQAVPhyNEVpEDEPzb6MijqaSmJfoolLTyahwQc1xzPz9HvxSNFUYGG8+KAKDjVyVnI3W0jAgttS8VsbDdqdDRnV0wn7K3QU9PpYe+KUYObVCDeDiGX3ILOsYNsXWcO8ie/2RjcjCS6pkmiihD2OFUMVw0HTJb2rOC4w4oIwzwJTHL
X-Exchange-RoutingPolicyChecked: vEpxv5xRZM36RrKuSx0h7NQq+G5jejFsaRsJSio7S3cgoTvPxWgwctZmsJKIjWpFZ184+o5tDUmM5mYkbFw7nDidBx0TV1T8iAMmkV1UYNccKaMO9s2EN/0WZxThlCts4U9trH9AacwbYM9tNn6CrrBgy1MpJ/MmyJV/8ccMEbKpOu6B+tb/n+ZJ+w0jX5R7TEskSNQoHibnUbAdok+KjLhzJeWE92UJ2VWLl8oW+vQ32ApT/bastPrJUW2WRIzyyIxgfV01qGaTBISzwHEJQieaeLkQAlhxAF4+Y6RV8sT031LW+EgsdNwLKppwpgy+z6pUaSzAft7IWG0V/2wUrQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:37:42.8723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30222123-a073-45dc-5389-08df2e293520
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265AD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX+DVMkqgw+Uav
 WcK5hQWT1+TY+Hnw3I7NHfkdx8Y3fnQ9RWtTIv2uDN4BU2+ButGmkw1k2wsyWsOe9CTHb8LW7Di
 EZRjGQA0pPyPp8m1tuSPzmkNExVci+DSswVf4DwCHTT9O+xOmrrK/9DWkYl0eeggptc8pmW3Fi4
 GOjPgcDmzgWP6JIwNATy8trvKv6pD7RTaMOnWe+CQ+Na3WzcubnYoqXqc1B72EHh+ne2ayyJSen
 Cvmkqjtl731GUnvwdmtKfHn9qrAqvcJZ2mQQ7srNJRZ6CGnQRh0JvpW739w0af82B75cI2S5+nV
 S/uLO25m4adoMm4h7xh4L/9JrRkrV+H1hiivZmOSFcbeGDoXkFTzgN+/FLuceivmAs4wHxXlZtZ
 o8BemVk5nRaPN6YRUXNNbMthFWZrfbGQHMSOrPJ3qE6qVEJ4SEVcMizS/m3GrtYst0P62hTjKeb
 etLjwbUAxbXQ15TIRvQ==
X-Proofpoint-ORIG-GUID: gUxeSlTI41tubdLbEedDh1sDRjH3QxCZ
X-Proofpoint-GUID: gUxeSlTI41tubdLbEedDh1sDRjH3QxCZ
X-Authority-Analysis: v=2.4 cv=Vsa2kO2n c=1 sm=1 tr=0 ts=6ad68daa cx=c_pps
 a=W+em2WlbpAENNNrDSTAr1Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=hi-VLxQeUbnF0Pn8EGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX7GffxBjlzc0/
 CUdW3zW3yA0G0mYHvGxYhMiaJnfGCxPRoUGtH0eeAZg2GJLxzU3qQXaEpQQxAoDhOKP+lpbyeWl
 rRLgFwgWiZc8GmMiMe4dsNtasQoOmwM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

E-paper displays are bistable: the last rendered image persists
indefinitely across sessions and power cycles. This creates a session
management choice with no LCD/OLED equivalent since unlike volatile
displays, content visibility outlives the rendering process. Whether this
persistence is a feature or a liability depends entirely on the
application.

Add session-lifetime display clearing with three configurable hooks:
clear_on_init: blank the display when a new DRM master opens the device.
Useful for kiosks and applications that need a clean slate on startup.
Example: a hospital patient room sign must start with a clean slate when a
new patient is admitted, discarding the previous patient's name, dietary
restrictions, and risk warnings.

  clear_on_close: blank the display when the DRM master exits (fd close).
Useful for applications that should not leave content visible after exit.
Example: a transit departure board at a remote bus stop must erase stale
schedule data when the service daemon is stopped — displaying yesterday's
departure times actively misleads commuters.

  clear_on_disable: blank the display on CRTC disable / DPMS off.  Provides
an independent clear point separate from master lifecycle.  Example: When
userspace trigger DPMS off, similar to LCD screen, here with the epaper
too, the display would be cleared.

These hooks help enabling diverse use cases:

  - A conference badge sets clear_on_init but leaves clear_on_close
    disabled, leveraging e-paper's bistability to keep the attendee's name
visible indefinitely after the rendering app exits — saving power while
remaining useful.

  - A hospital patient room sign sets both clear_on_init and
    clear_on_close: a clean slate for the new patient and automatic erasure
on discharge so protected health information does not persist on the
display outside the door.

  - An airport boarding pass kiosk sets clear_on_close so the previous
    passenger's name, booking reference, and seat assignment are erased the
moment the session ends — preventing the next person in the queue from
seeing personal travel information.

  - A meeting room booking display sets clear_on_disable so the schedule is
    wiped when the room session ends via DPMS off, independent of whether
the calendar sync daemon continues running.

Each is an integer selecting the refresh waveform for the clear (-1 =
disabled, 0 = partial, 1 = full, 2 = fast), defaulting to -1 (disabled) in
the panel configuration so the behaviour is opt-in.  A
display_cleared_on_deinit guard prevents redundant double-clears when
multiple paths fire for the same session (e.g. compositor does DPMS off
then exits). first_clear_done ensures clear_on_init fires exactly once per
client session; master_drop resets it so the next client gets a fresh
clear.

All three default to -1 (disabled) in the panel configuration so the
behaviour is opt-in per panel and does not affect panels that have not set
an explicit default.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Split display_cleared_on_deinit into cleared_on_disable and
  cleared_on_close. A single flag made a clear on disable suppress the
clear on close and was never re-armed on re-enable
- Add the atomic_disable helper here, with drm_dev_enter()/drm_dev_exit()
- Reset the RAM window before clearing and size the clear buffer per row
- In 3-colour mode clear the red RAM to 0x00 (no red) instead of writing
  the all-white buffer to it, which would paint the panel red. In
black/white mode it keeps the white buffer, as it is the previous-frame
reference for partial refresh
---
 drivers/gpu/drm/solomon/ssd16xx.c | 208 ++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index ca6550b5dd5b..7b0096448768 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -298,6 +298,18 @@ struct ssd16xx_device_config {
 	/* Whether to re-send border waveform command before each display update */
 	bool default_border_refresh_on_every_update;
 
+	/*
+	 * Default clear-on-init behaviour.
+	 * -1=disabled, 0=partial, 1=full, 2=fast (matches enum ssd16xx_refresh_mode)
+	 */
+	int default_clear_on_init;
+
+	/* Default clear-on-close behaviour (-1=disabled, 0=partial, 1=full, 2=fast) */
+	int default_clear_on_close;
+
+	/* Default clear-on-disable behaviour (-1=disabled, 0=partial, 1=full, 2=fast) */
+	int default_clear_on_disable;
+
 	/*
 	 * Default refresh-mode-init: -1=disabled, else skip baseline establishment
 	 * and start directly in this refresh mode.
@@ -347,6 +359,9 @@ struct ssd16xx_device {
 
 	bool initialized;
 	bool init_refresh_pending; /* First frame after refresh_mode_init enable */
+	bool first_clear_done;  /* clear_on_init has already fired once */
+	bool cleared_on_disable; /* Avoid redundant clear in atomic_disable */
+	bool cleared_on_close;   /* Avoid redundant clear in master_drop */
 
 	int orientation; /* Display orientation in degrees: 0/90/180/270 */
 	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
@@ -360,6 +375,9 @@ struct ssd16xx_device {
 	bool border_waveform_pending;   /* One-shot: send border cmd on next update */
 
 	/* Display control */
+	int clear_on_init;    /* -1=disabled, 0=partial, 1=full, 2=fast */
+	int clear_on_close;   /* -1=disabled, 0=partial, 1=full, 2=fast */
+	int clear_on_disable; /* -1=disabled, 0=partial, 1=full, 2=fast */
 	int refresh_mode_init; /* -1=disabled, else use this mode for the first frame */
 
 	u8  *tx_buf;     /* 1bpp frame buffer (mono + white) */
@@ -417,6 +435,9 @@ static const struct ssd16xx_device_config ssd16xx_device_configs[] = {
 		.default_border_waveform_init   = SSD16XX_BORDER_LUT1,  /* white, clean clear */
 		.default_border_waveform_update = SSD16XX_BORDER_HIZ,   /* floating, preserve */
 		.default_border_refresh_on_every_update = false,
+		.default_clear_on_init    = -1,
+		.default_clear_on_close   = -1,
+		.default_clear_on_disable = -1,
 		.default_refresh_mode_init = SSD16XX_REFRESH_FULL,
 		.red_supported = false,  /* 2-colour black/white panel */
 		.default_color_mode = SSD16XX_COLOR_MODE_BW,
@@ -754,6 +775,138 @@ static int ssd16xx_hw_init(struct ssd16xx_device *device)
 	return err;
 }
 
+/*
+ * Clear display by writing all-white to both BW and RED RAM.
+ * The ctrl2 argument selects the waveform (full/partial/fast refresh).
+ * Border waveform is set to init value before clearing, then restored
+ * to the update value to preserve the border during subsequent updates.
+ */
+static int ssd16xx_clear_display(struct ssd16xx_device *device, u8 ctrl2)
+{
+	const u8 *bw_tbl = device->controller_cfg->border_waveform_table;
+	int err = 0;
+	unsigned int data_size = DIV_ROUND_UP(device->width, 8) * device->height;
+	u8 *white_buffer = device->tx_buf;
+	u8 *red_buffer = white_buffer;
+	u16 ram_x_end, ram_y_end;
+
+	memset(white_buffer, 0xFF, data_size);
+
+	if (device->controller_cfg->ram_x_address_bits == 8)
+		ram_x_end = (device->width / 8) - 1;
+	else
+		ram_x_end = device->width - 1;
+	ram_y_end = device->height - 1;
+
+	/* Reset full display RAM window before clearing */
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_START_END, &err);
+	ssd16xx_send_x_param(device, 0x00, &err);
+	ssd16xx_send_x_param(device, ram_x_end, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_START_END, &err);
+	ssd16xx_send_y_param(device, 0x00, &err);
+	ssd16xx_send_y_param(device, ram_y_end, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
+	ssd16xx_send_x_param(device, 0x00, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
+	ssd16xx_send_y_param(device, 0x00, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_WRITE_RAM_BW, &err);
+	ssd16xx_send_data_bulk(device, white_buffer, data_size, &err);
+
+	/*
+	 * In 3-colour mode RED RAM is the red plane, so clear it to 0x00 (no
+	 * red).  Otherwise it is the previous-frame reference for partial
+	 * refresh and must match the now all-white BW RAM.
+	 */
+	if (device->color_mode == SSD16XX_COLOR_MODE_3COLOR && device->tx_red_buf) {
+		red_buffer = device->tx_red_buf;
+		memset(red_buffer, 0x00, data_size);
+	}
+
+	ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
+	ssd16xx_send_data_bulk(device, red_buffer, data_size, &err);
+
+	/* Set border waveform for the clear operation */
+	drm_dbg(&device->drm, "clear_display: Set border init waveform: 0x%02x\n",
+		bw_tbl[device->border_waveform_init_idx]);
+	ssd16xx_send_cmd(device, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
+	ssd16xx_send_data(device,
+			  bw_tbl[device->border_waveform_init_idx],
+			  &err);
+
+	/* 3-colour mode: CTRL1_NORMAL (read both RAMs); BW mode: bypass RED. */
+	ssd16xx_display_update(device,
+			       device->color_mode == SSD16XX_COLOR_MODE_3COLOR
+					? device->controller_cfg->ctrl1_normal
+					: device->controller_cfg->ctrl1_bypass_red_ram,
+			       SSD16XX_CTRL1_BYTE2_DEFAULT, ctrl2, &err);
+
+	/* Restore border waveform to update/preservation value */
+	drm_dbg(&device->drm, "clear_display: Restored border update waveform: 0x%02x\n",
+		bw_tbl[device->border_waveform_update_idx]);
+	ssd16xx_send_cmd(device, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
+	ssd16xx_send_data(device,
+			  bw_tbl[device->border_waveform_update_idx],
+			  &err);
+
+	return err;
+}
+
+static u8 ssd16xx_refresh_mode_to_ctrl2(struct ssd16xx_device *device,
+					enum ssd16xx_refresh_mode mode)
+{
+	if (mode < ARRAY_SIZE(device->controller_cfg->ctrl2_refresh))
+		return device->controller_cfg->ctrl2_refresh[mode];
+	return device->controller_cfg->ctrl2_refresh[SSD16XX_REFRESH_FULL];
+}
+
+/*
+ * Clear display on new DRM master open (if clear_on_init >= 0).
+ * Guarded by device->first_clear_done; master_drop resets it unconditionally
+ * so each new client session gets a fresh clear.
+ */
+static int ssd16xx_clear_display_on_init(struct ssd16xx_device *device)
+{
+	int ret;
+
+	if (device->clear_on_init < 0 || device->first_clear_done)
+		return 0;
+
+	drm_dbg(&device->drm, "clear_on_init: running, mode=%d\n",
+		device->clear_on_init);
+	ret = ssd16xx_clear_display(device,
+				    ssd16xx_refresh_mode_to_ctrl2(device, device->clear_on_init));
+	if (ret)
+		return ret;
+
+	device->first_clear_done = true;
+	return 0;
+}
+
+/*
+ * Clear display when the displaying client exits (if clear_on_close >= 0).
+ * Called from ssd16xx_drm_master_drop().
+ */
+static int ssd16xx_clear_display_on_exit(struct ssd16xx_device *device)
+{
+	int ret;
+
+	if (device->clear_on_close < 0)
+		return 0;
+
+	drm_dbg(&device->drm, "clear_on_close: running, mode=%d\n",
+		device->clear_on_close);
+	ret = ssd16xx_clear_display(device,
+				    ssd16xx_refresh_mode_to_ctrl2(device, device->clear_on_close));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /*
  * ssd16xx_pixel_luma() - return ITU-R BT.601 luminance (0-255) for one pixel.
  *
@@ -1367,6 +1520,33 @@ static int ssd16xx_crtc_atomic_check(struct drm_crtc *crtc,
 	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
 }
 
+static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
+					struct drm_atomic_commit *state)
+{
+	struct ssd16xx_device *device = crtc_to_ssd16xx_device(crtc);
+	int ret, idx;
+
+	if (!drm_dev_enter(&device->drm, &idx))
+		return;
+
+	if (device->clear_on_disable < 0 || device->cleared_on_disable)
+		goto out;
+
+	drm_dbg(&device->drm, "clear_on_disable: running, mode=%d\n",
+		device->clear_on_disable);
+	ret = ssd16xx_clear_display(device,
+				    ssd16xx_refresh_mode_to_ctrl2(device,
+								  device->clear_on_disable));
+	if (ret) {
+		drm_err(&device->drm, "atomic_disable: clear failed: %d\n", ret);
+		goto out;
+	}
+
+	device->cleared_on_disable = true;
+out:
+	drm_dev_exit(idx);
+}
+
 static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_atomic_commit *state)
 {
@@ -1388,6 +1568,12 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 		}
 		device->initialized = true;
 	}
+	device->cleared_on_disable = false;
+
+	/* Clear display on first app launch if configured */
+	ret = ssd16xx_clear_display_on_init(device);
+	if (ret)
+		drm_err(&device->drm, "crtc_atomic_enable: clear on init failed: %d\n", ret);
 
 	/*
 	 * If refresh_mode_init is set, arm init_refresh_pending so
@@ -1407,6 +1593,7 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 static const struct drm_crtc_helper_funcs ssd16xx_crtc_helper_funcs = {
 	.mode_valid     = ssd16xx_crtc_mode_valid,
 	.atomic_check   = ssd16xx_crtc_atomic_check,
+	.atomic_disable = ssd16xx_crtc_atomic_disable,
 	.atomic_enable  = ssd16xx_crtc_atomic_enable,
 };
 
@@ -1473,6 +1660,9 @@ static void ssd16xx_drm_master_set(struct drm_device *drm,
 {
 	struct ssd16xx_device *device = to_ssd16xx_device(drm);
 
+	device->cleared_on_close = false;
+	device->first_clear_done = false;
+
 	if (device->refresh_mode_init >= 0)
 		device->init_refresh_pending = true;
 }
@@ -1485,8 +1675,23 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
 				    struct drm_file *file)
 {
 	struct ssd16xx_device *device = to_ssd16xx_device(drm);
+	int ret, idx;
 
 	device->init_refresh_pending = false;
+	device->first_clear_done = false;
+
+	if (device->clear_on_close < 0 || device->cleared_on_close)
+		return;
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	ret = ssd16xx_clear_display_on_exit(device);
+	if (ret)
+		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
+
+	device->cleared_on_close = true;
+	drm_dev_exit(idx);
 }
 
 static struct drm_driver ssd16xx_drm_driver = {
@@ -1623,6 +1828,9 @@ static int ssd16xx_probe(struct spi_device *spi)
 	device->border_waveform_update_idx = device->device_cfg->default_border_waveform_update;
 	device->border_refresh_on_every_update =
 		device->device_cfg->default_border_refresh_on_every_update;
+	device->clear_on_init    = device->device_cfg->default_clear_on_init;
+	device->clear_on_close   = device->device_cfg->default_clear_on_close;
+	device->clear_on_disable = device->device_cfg->default_clear_on_disable;
 	device->refresh_mode_init = device->device_cfg->default_refresh_mode_init;
 
 	/* Parse "rotation" DT property; swap mode dimensions for portrait. */
-- 
2.39.1

