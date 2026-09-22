Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44DFC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1CED10EE5D;
	Tue, 22 Sep 2026 20:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qyVuKUNT";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qyVuKUNT";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011048.outbound.protection.outlook.com [52.101.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F53A10EE6B
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:48:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ABoJCI7n7HBeMDlYIcIJwD4kaU667SIj9/x0TrUaovN/rF8YPam9gGByph1kZeQ1B/kPsC0oL43a3gkTaR9NDVlW0TnVjfdGi/tALAvRJKHr8OEjbNIh3z/vhrrwjLQPIWtEKzO+KrMfRainvlGkYdT8E4L0Ow0XARd9i2P/cTIHqRimf/6DeZtwetyiLCfKLV8/ZXtPIKy21EG/DV0HekP0fSOvTUWk8A5S+uXzbNmYWVsAIeR1CMONpwNC2Qq8Izwi/alGj9Dum1zcSfj73FXvxk0kAvMfRxYjLdEpq0DnLK0Fn0R9pTh0veiJE6PyOtOARqVNEhGSz0sxq2vDpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL4tt9xfiu6dOgjKZVLEXnpy5Dt9Dn428w/U993q3bY=;
 b=dE/wWVDPiAMT5IZ1JJsgkdNPGygB1yjvCMuyYLqVVsmVrrAOfEk1g6Ays27rU5ZKDQMDsal3Ntx6/OR5cFwV+aBwGWeJTx9V6ALJTCHSFPUJMZSTNJjjOuEFhHRvvnJNUaEv1vrWpwdRtkwZjq37k2KY5GKyf8fNNYWqFjW/2RAFCyyW+QiSUbqqDNYvuD+pCKzBIgVBKtaefXltC/2k3nnYzL9+0DR4aE3eGQChBNrIn598z90ICbjTTOIzMwoXv2+vlnHPQDxNJ5hQPO3e+YWStn1rzEHZw+RFKk+Qw2oZCP9th9fy22s1+/MjyTiP2UV8RlsIWPVFIspOmD654A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL4tt9xfiu6dOgjKZVLEXnpy5Dt9Dn428w/U993q3bY=;
 b=qyVuKUNT9SkTguMWzCwjkqGJkLPyw1qhkQAPA59mkvTP9JAyvrYH0Utc8tzUTuLvTcvEpMWFlB49qeJ/rPBv7zCd42yOF4GJjvhukNOLLmZFSUp1GAipbbhtRrg9I8zmjEPTuVoajMihjUcVqzT0HYNIxWk4Q0gxJMUnkFcQ7QM=
Received: from AS4P189CA0067.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::25)
 by DB8PR08MB5337.eurprd08.prod.outlook.com (2603:10a6:10:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:48:08 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::9b) by AS4P189CA0067.outlook.office365.com
 (2603:10a6:20b:659::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET1rqae3XuiZSzRiSTrrBLiF9CeymRa3BZE3UJqMsxbbcIqOmckBbzguqaAn/UU1n4vE2dy/QAd8cRurbnpDG3vXmkWDeNpTJjkGs8V8i6YWWfYow5ybMGXlVbfFu2T+oa0L1gfhoymP9IGykTLgLpBNtYE4dW/amVDpLhDR7B+NozYGplFyKFJ3tJQml3nusgmEOppr7YRqEEiZcfM5mTJl4MehKrzae7JOFNubigY9w+yTTymcsm2Rr7q6sUT42ZBG7cgthePSlsZ26E1omnr8HQOq3J4bTQdAkppu5StckFxIufP9EUKh9u/zm5wGKfNoKiM6qYWdHKfMQO99XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL4tt9xfiu6dOgjKZVLEXnpy5Dt9Dn428w/U993q3bY=;
 b=e6Z92Ts8JZbPJJOykZi074ZFiz6+K1PCISved6W722rJBULei/TTTs9B/GypFl8K978+llLQ8fbp17QapX7G4KTYHbl3DLRQ6fi0CTQThRLH5doKHQ0905ZgXOg1v2/n5rFTlBzQCjvxA7qxv4rnOstJChf0kEWrsrgUYnWSL6pNbCkEoQFnLo5QKj0PamAdr9bMbmOIXWjW0GF4NUBGD05rUUPZ/cd2W9pqP5YeZX//FflXJNVy9mj6w+5J9k7cmnfyrHR6Ad0+7Kb6JAigb2jjEYJ4p+rNZJ12S6ooQZ4dGDWtLFvNNeWnQLLKJyx4tbIJyI2zegWrJAUZWa5fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL4tt9xfiu6dOgjKZVLEXnpy5Dt9Dn428w/U993q3bY=;
 b=qyVuKUNT9SkTguMWzCwjkqGJkLPyw1qhkQAPA59mkvTP9JAyvrYH0Utc8tzUTuLvTcvEpMWFlB49qeJ/rPBv7zCd42yOF4GJjvhukNOLLmZFSUp1GAipbbhtRrg9I8zmjEPTuVoajMihjUcVqzT0HYNIxWk4Q0gxJMUnkFcQ7QM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:35 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:35 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 25/27] drm/panthor: Tolerate access-window loss during HW
 waits
Date: Tue, 22 Sep 2026 21:45:19 +0100
Message-ID: <20260922204535.2850094-26-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0637.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|AMS1EPF0000008E:EE_|DB8PR08MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdf0b30-6ae3-490f-c338-08df18eacec0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: +GfPzDoNH5YpFR4+JZ/x2kTxo9R3WQHkIlQr3q6HWkZDBaEaQ75ELWQ78DhkjcvNvVxlAF6UV32xcyTX/gH/pDvbfIujb7twOZFywk4FPUR6iW5iVgfJ6MSeqNZTfJ6ukha22qrPYoVrmaP7ZKOOE8urv93m6b8jlZZLUI07juUCVbB9E9Pb29YKYVCdCvWZ8HFYZIdICdiKwmmU2jB0xKZNjd4P8So3JpefI5Ml92oKMDFVj3G8pZVOsHJqwDANOVh5hhjPwLnbD2NB4AeyMm/R3x0PjwfooGRA8qq8PsHxaS4N1JfO0UpveBL5bqJ6ho8aqV5pf/JeiDiRl3bRu0pPq3W8RZKZmxUhnEybXyENMNd9ZREeRIWzkDJJqBAHnlYtWn9JnPKGxp8c+tKm2jr09t17Q4BG17wUTDIzAl0uHdOwg6QercYnbId7CVzetaBj1mN2dROrX7ngJWMkC/qFJ//Nldkvlp9wLrebFmYe22n7IPdbhK710vLZjbJ5oiW6v8x3rI1rMFxJnqZMxj/M83JfR1LC16iVc6vUzC6EtcdZROp0D+zvgESa1RthWJlak2W0q0Kb4sSEA4zdG3bKbmCH5LyiKBd4e+PPDXXVv89B/BFIOGrASg6ehMSfwypT/hFH8OVwhCjXWgp+wInFEN5WN8KCQm4+edLAAn4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: S/BKwOm1RVTphOBWgYaVytCLB1Da+CszlmslOAWefdhXeyu4L38Zm0mL8PQ727ZSt3YOEDEcbVneTL5nXNmcpqvj+CJ62Bp3tZTZdOcnWRpn4DNTivqnq2cP6NBPeTSkY5YMaqAEyCeZ6LAD4XPExO+do18cAMrBBRmnEK/Rn/21MVGrj8ef2O+lhYUzY/MUOep+oifkmLbK1UtmYPOVmOlW3A5NExMbCnpEssfVuz0ko0BzR4Kz2ADTTkFlJEwgxILSd+yAHtrFWIYkUSTOxIHw9NRZOyHohvwr4EQtH5MtI58xXufLB8RttPSHv8Qd7Nefd8Xj9Iop27j8FeOMNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8025f6b2-5166-40dc-7ee1-08df18eabb2b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|35042699022|376014|14060799003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: JH/qCSPN6dxwh1zNDeCQuNw37Jl95h35w0RLy81R1l9uI0Bf8P7HfEdf6fMWn5h2Em0zjsxQ3izRBYYO5XOlz3Smwc7TVUgJE6qjHU+uyrqtQcHiirEzfrBM3K5g/7r4GHvleEX8HtyVscWWX/0K9q5H0u7Jk2vDyHEAte4GZIvN/qnjzWz7+EqrUim8YBLMDb5gQaoF4mpKT0t4LMV4Xu0m4cF0/xM219alE1bKleMvX6BoFTSm9sHX00WLldGOZwxhsk6nAD2f44zEsS6yF8NYR8l3kTfhjrha19XEqmHvVFmQZJWti7vWs0Z2BaxngLBjKjaYM/lrYzc5MWSBUUG5QrH7RU0UVqaBO4jamCPehTHtS//74dqdsVwTmCeSlKeU1lPVxrTmtYw/MuNn7tTPrq5KNHK9ZMJOdKtr9ZBIA64iWX0qENSTiB52dF4rHqAuO5EJYsaQVJKBQADM01vrK1zAQ6tVyns8wMStcaJRyT8IFUY02XnO2m3avMLsUOZQvWU5LaAXXc+zx5TnM8lgnLwkDo401fV0JkCoAPx5IGeBgrX0P7DhEnpdX1yXhqEwacLJp0aIhSZQsuCoM590epVcI0udOfvaBY5RrETwWLMQZXoSy6Oc0EReUZzqonsP08gPPztmaLbzCMdcOSemC2V5AFkDqz7d7amsMsXT+Gor2iWfbJJU8G679+ZSe6UsbvgZEqRwtuB3urf8pQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(35042699022)(376014)(14060799003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SKZj/V8iYGtJ82JT52TJNk85x+PA7K9v8WYVpBgQ4olADWtDV2/Cs1u+IgAqs52GfZX4Fu1bFliVB+MGd8UiTLaE6fEDEgipysvMH+wNsBu4denOUVgrteHjK/ye0b8ZPR5NgPoQz5glj4KP2AiXmHbQkOFaq52o/wzNERoD8olRjq3NH5AByURLynTCGIXX7E+33A2zypnVajEAir6EjzVx2/bmVnA6z4MQIDnknP/xFVq4wQSJRLAJprWEOs0Au9a838TY0tfyJDpDsQ8LFdxDPYXvFtN+/watj6n4a83aMTcDhRiA8AtAgO7Ng3IlBZZRi9SuNc9U75iJrNoapzZGebtAQmLgUxKNecEiXzSt2tLiUN+r3P1uBAwlK1HuMDGYJb6NQWeAPG0EPU/H0Huu3kVgwXNBSbBVVbaSjUrGCMTS/Ds0P0VNV1B0zdlx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:48:07.9024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdf0b30-6ae3-490f-c338-08df18eacec0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5337
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

The arbiter can close the access window while the driver is waiting for
GPU, power, or firmware acknowledgements. In that case the pending MMIO
wait cannot complete, but it should not be treated as a hardware timeout
or trigger recovery.

Add a helper to report whether the access window still owns GPU access
and use it to suppress timeout handling once access has been revoked.
Skip firmware-event processing when GPU access is unavailable.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- extend access-window loss handling to fw boot wait.

 drivers/gpu/drm/panthor/panthor_aw.c    |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_aw.h    |  2 ++
 drivers/gpu/drm/panthor/panthor_fw.c    |  5 +++--
 drivers/gpu/drm/panthor/panthor_gpu.c   |  4 +++-
 drivers/gpu/drm/panthor/panthor_pwr.c   | 27 +++++++++++++++++++------
 drivers/gpu/drm/panthor/panthor_sched.c |  5 +++++
 6 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panthor/panthor_aw.c
index 4fcfb3ad05073..9ebb23eadfec5 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.c
+++ b/drivers/gpu/drm/panthor/panthor_aw.c
@@ -573,3 +573,11 @@ int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev)
 
 	goto again;
 }
+
+bool panthor_aw_has_gpu_access(struct panthor_device *ptdev)
+{
+	if (!ptdev->aw)
+		return true;
+
+	return (atomic_read(&ptdev->aw->state) == PANTHOR_AW_STATE_GPU_GRANTED);
+}
diff --git a/drivers/gpu/drm/panthor/panthor_aw.h b/drivers/gpu/drm/panthor/panthor_aw.h
index 7a46a1e18093a..1da613fa330a0 100644
--- a/drivers/gpu/drm/panthor/panthor_aw.h
+++ b/drivers/gpu/drm/panthor/panthor_aw.h
@@ -41,4 +41,6 @@ int panthor_aw_suspend(struct panthor_device *ptdev);
 
 int panthor_aw_ensure_gpu_access(struct panthor_device *ptdev);
 
+bool panthor_aw_has_gpu_access(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 1449d9a66302e..b4c234f3d3ea4 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1140,9 +1140,10 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
 
 	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
-				ptdev->fw->booted,
+				(ptdev->fw->booted ||
+				 !panthor_aw_has_gpu_access(ptdev)),
 				msecs_to_jiffies(1000))) {
-		if (!ptdev->fw->booted &&
+		if (!ptdev->fw->booted && panthor_aw_has_gpu_access(ptdev) &&
 		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
 			timedout = true;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index e6e970e9b59d3..25fe7c77f8763 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -17,6 +17,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_device.h"
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
@@ -376,7 +377,8 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
 			if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-			    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+			    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) &
+			      GPU_IRQ_CLEAN_CACHES_COMPLETED) && panthor_aw_has_gpu_access(ptdev))
 				ret = -ETIMEDOUT;
 			else
 				ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index cc2e01595f23b..2a0feb0b39ece 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -10,6 +10,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
+#include "panthor_aw.h"
 #include "panthor_device.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
@@ -122,7 +123,8 @@ static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
 		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);
 
-		if (reset_pending(ptdev) && !reset_irq_raised(ptdev)) {
+		if (reset_pending(ptdev) && !reset_irq_raised(ptdev) &&
+		    panthor_aw_has_gpu_access(ptdev)) {
 			drm_err(&ptdev->base, "RESET timed out (0x%x)", reset_cmd);
 			return -ETIMEDOUT;
 		}
@@ -266,9 +268,14 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 
 	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val, (mask & val) == expected_val,
+	ret = gpu_read64_poll_timeout(pwr->iomem, ready_reg, val,
+				      ((mask & val) == expected_val ||
+				       !panthor_aw_has_gpu_access(ptdev)),
 				      100, timeout_us);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base,
 			"timeout waiting on %s power domain transition, cmd(0x%x), arg(0x%llx)",
 			get_domain_name(domain), pwr_cmd, mask);
@@ -330,9 +337,13 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	 * allow-flag will be set with delegated-flag being cleared.
 	 */
 	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
-				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
-				      PWR_TRANSITION_TIMEOUT_US);
+				      (((delegated_mask | allow_mask) & val) == allow_mask ||
+				       !panthor_aw_has_gpu_access(ptdev)),
+				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base, "Retracting %s domain timeout, cmd(0x%x)",
 			get_domain_name(domain), pwr_cmd);
 		return ret;
@@ -387,9 +398,13 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 	 * allow-flag will be cleared with delegated-flag being set.
 	 */
 	ret = gpu_read64_poll_timeout(pwr->iomem, PWR_STATUS, val,
-				      ((delegated_mask | allow_mask) & val) == delegated_mask,
+				      (((delegated_mask | allow_mask) & val) == delegated_mask ||
+				       !panthor_aw_has_gpu_access(ptdev)),
 				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
+		if (!panthor_aw_has_gpu_access(ptdev))
+			return 0;
+
 		drm_err(&ptdev->base, "Delegating %s domain timeout, cmd(0x%x)",
 			get_domain_name(domain), pwr_cmd);
 		return ret;
@@ -519,7 +534,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
 
 	/* Abort if L2 power off constraints are not satisfied */
-	if (!(pwr_status & l2_allow_mask)) {
+	if (!(pwr_status & l2_allow_mask) && panthor_aw_has_gpu_access(ptdev)) {
 		drm_warn(&ptdev->base, "Power off L2 domain not allowed");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ac6aee554820e..6d801329514e0 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1887,6 +1887,9 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 
 	guard(spinlock)(&ptdev->scheduler->events_lock);
 
+	if (!panthor_aw_has_gpu_access(ptdev))
+		return;
+
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
 		events &= ~JOB_INT_GLOBAL_IF;
@@ -2060,6 +2063,8 @@ static int csgs_upd_ctx_apply_locked(struct panthor_device *ptdev,
 		csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
 
 		ret = panthor_fw_csg_wait_acks(ptdev, csg_id, req_mask, &acked, 100);
+		if (ret && !panthor_aw_has_gpu_access(ptdev))
+			ret = 0;
 
 		if (acked & CSG_ENDPOINT_CONFIG)
 			csg_slot_sync_priority_locked(ptdev, csg_id);
-- 
2.43.0

