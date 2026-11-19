Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169B60A3802
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qK89M8Nt;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qK89M8Nt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A554B1125CE;
	Thu, 19 Nov 2026 15:47:20 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013001.outbound.protection.outlook.com
 [40.107.162.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717661125B1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:05 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EqW2dQv1ah4lCqxiAKhb2meZ6G15GX+n0Fw3vtueD8+59VBHKKMHtNKCz65iHomCSy/+RI1L7fz2UxSfj7Vj1uIkVtfgdpBIfo04/eI0CEi/WOD3WJzXpm7aJjF0+3Oo/xc+pRy/wGpS3aJ6bt6IUOzoM2iKC/nO1rdfID65XJU3XHylahjqX49f3gpSUV59tpdVhdDq7EEEhqVsvp7yvJrE5RLNCPtaVapHVHKBaSmbO4N770bYI4fWqdj3tBJRYLSGVQrpWzQvVlQXBMPZ7u9JU/wVjmz9y47t8YUVNP5NRveNwc/LwiS1STnxXp3i2Bf/Na3wAH+d2mKQKdxPxg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=hdU3y5GevJWOG4HYlEneuPwkPfZTGAm144EzisszIc5S4wH1QiPLw2zbTiL70aog3fagdTN7MDKE80/P6MQEsSDsQL36yaMFP3GEewcRyuEC6aEkasZD1snD2kY/WmmsYzkydN9lO207FOIuTHYdgA65b8uLQwFx++8Use4WbiYNQNK8h+e4yjvunxsGhToX7yfN+ku/9rVYRTB+gQROxsdJgWEOZfqUwjc2HKT1eUwgXq0nrx+07T+j7isQsoOlE1qSWtQudVCjRj1s7sXnG73RL+MSc6m3aLtqvCiHQUJcK1kiIvDQXsbq4tzt2XtJAJHN3dJR2kBx0zAA3msWdg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=qK89M8NtggktkJf1ybvoFa+R444oLpOTz5SDgesJM/LiWfIJg3Ly5q0gkioiimTeTn9F7gS9naDn//R89wjVuad5hnLBvbIxFe8ZW0MdrabmPt/dWGvoQFeI3szNXu6tEeNXp5qKfOauNsqksCpKNaUygJf0yFD9YgR4rp1pKk8=
Received: from DUZPR01CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::18) by DB3PR08MB8961.eurprd08.prod.outlook.com
 (2603:10a6:10:428::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:47:01 +0000
Received: from MAD0EPF000008BD.eurprd04.prod.outlook.com
 (2603:10a6:10:468:cafe::77) by DUZPR01CA0040.outlook.office365.com
 (2603:10a6:10:468::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.11 via Frontend Transport; Thu,
 19 Nov 2026 15:47:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008BD.mail.protection.outlook.com (10.167.241.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7JvS6Wf5qOzeg9BPGW/zFv1euWIZBNt4hu8l3rVHZCz43H9WauQFe2ZQXdcyzjysWKfIcIUQR6nywaQt33ZnRgGw/ddutq/bUWrZjMa6NcQJraFxGQelygvPjf9fRLKHWxEYwsdLWMGkBE9c6VZnMMnaGl3MdsgRCGZFUYW2Dv6zHX+NcTnhdlzhUPrv3H9ME/ceYQbm2+W/OcqpVQEMNW2aRD0gZFZOYRyEhgomZvx1fb6XY80+lw0DxGsSi/46OcQoofczwsohTL81WAz5FynnYwdECzqq5yppkOZl/vo/OnD9lWqProPI6PMsr5eLX0kXql4f02+m7NUkXncZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=YiCOObsGRblKyAbtV/f7CqIWvVsH8ZTbSvi13/jp84IZvCJ4r0N1SSoObfx2WlpHmORdRd6AIPfKhevNhow6KFjdNC4wvconIiLFkPGg1BErBCWqkt09jqXrTb8Q+uj1PELznB6y2sO7be/q5+HBsKM2x8EyLY7mPdvFVXXBFkODazr1arQiZ+/vd3LGNRnv3Omw3tNVXyDGVvz8nhc9xHSMd+XdJg1x446K9VhRqso7/Mhz16t/nUHyfXRFNXmCaHE2lhjf6l/TcaXLO3Zg35/ej1/1KcJq4U0MnwSbwG1PQleE/NIfEUA/hvNRK+kIGn6bubn4IEIdFDXZCXt8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKVO/THJY9BXThyvAQKAPS01Xdo9l61yZj6Z8u/uegM=;
 b=qK89M8NtggktkJf1ybvoFa+R444oLpOTz5SDgesJM/LiWfIJg3Ly5q0gkioiimTeTn9F7gS9naDn//R89wjVuad5hnLBvbIxFe8ZW0MdrabmPt/dWGvoQFeI3szNXu6tEeNXp5qKfOauNsqksCpKNaUygJf0yFD9YgR4rp1pKk8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:24 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:24 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 3/9] drm/panthor: Move register access helpers out of
 panthor_device.h
Date: Thu, 19 Nov 2026 15:45:53 +0000
Message-ID: <20261119154604.2519184-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|MAD0EPF000008BD:EE_|DB3PR08MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5bd514-6b5e-4aa0-a9b2-08df46545990
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|261009223027099003|56012099006|261022113327099003|11063799006|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: yC2emQuR/co6Zr5NWN092h/4Iy6w9SS6EIaSojS/L1YlX03+WjXOjsDYJdK7GwccazMt4dYtY+tFvUMmjfEvSwQ16ov0ha1q+texr69tFhK9qpxe1PVlGMFXAjfLPk99SfWcEbrlkguQN+OnZPXzY/YCZ5Pn5DWKrZj1GtFaJ9wHOqUSzCqzSXRDkWQ6HGjRJm8UCZDo+kDceTU5g9GXeBVtKGALOQKs/11e+9wKovRhdBr5wFGZkd8xt6E2+tys8qGLwY/+nj27OxeDr5pgw/Ex+wG8z4aJYXfUSlVT5CZ76Ryfp+kseus0ijXtr4iUvWsKkeXkGuHNp8+8FCocBdNlGtGZyIGYHy9y0dj+Edw44DlIwbVTWTdK1/YfMLXfO5V/7HqZ68LgtHdzvcrLoDcppPjUAPfc58V8qcamLwl6NXBx1VgvJSKW9xJas3zZZ7U+HHKOxTQdF6gvgLbXi4F7vBpEIik1wUGhofqEkDAi0lu008nfppa+tmoWvZqFn2HEp+UxzO3/A1MHB7I+ynaH3tWv4u+P7M1kmQxqcRqWyD1giPwEa3JaQx6zWj7tmt9xmO2gfzRnfsPABurmlH2et8x5AUB5Q/mY8g6Xcc4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(261022113327099003)(11063799006)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: WAdU3Gu3B6CesbwsvmwOkJJfQa3ftZgh3ZR0MLd8X7IbjyRJ0dHo4BkX1OUaWUvlE868ZgjyhRTtYrfxK/hlzmr6GLBVsURUBhq8cVLTQGFPC+uA1DN3goQCYfUYcuqhhIng8SyQviRnAI0rmn7yMTvhzaPIWcRwApTw78omGLEtvlLtZtNLsGyJrrPhPKMk/frxy40AxW/s+ZU2ux2obriyVFSkVtqnSqVfiVd83pMYcxuUwO4+GYXWHPz3gZec6xfntEj/jbJMKIRenpDtwI6mQeIuJkMkwaPbJD2CKB8i7i3xT2dAIYdE0+Xx/4+hAYjFF80ruWXfX9b7RvRRNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008BD.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 90359bf4-a19d-426b-0060-08df465443e0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|14060799003|35042699022|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|261102123227099003|261028144727099003|261009223027099003|261026121527099003|261026140227099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: zcUoRsVjPAso1N3WZObCRJPI3RoTG6FUnnBrO4a5ZZhd1axWIU9WFHML2V/SPTK4raD75PzTCzfZ9shllZov0agv2XmBFxdOvwr6qlx9f7b5Sit+KTNaxkQusIongEQVUde+BTWKnB2GSqeFM4HhPXItNmtDrMMcDMMs80UZ9mFkhoPhNAL1tE6pO2P57ZSfZEJ+SOmu6Qr3ZNq+th+UFXeLSSZe03UlU6kn/o/1R/b1A7qtZm6eeQiyDHSl8qJbSxq0ImaYSgqII5LqRjyMHmQ2AHjc4T1TLdRjm3PEuSdQi/zul2Hls1SHDnj9lvx34k/S/qR64DuP+6mWJuLTyRUg04xAnBXcbXnRYDILy2LhfmNawI8YmvkMG44LPqbzayHZMHVFhzB+SgYZDCqsRxyLl+rrsiGV5alUt9uNe4prdRzEsmo4D828U7Ogru2R8AYIECbZYWJ/08CQqmQYF7DhbTVqVX2HZl8B0nQ+vdmfJstjMkWg8tIthDoDx4TReMJJq2sAHQtzM9D8d42GE0CmOG7Uimhg7MhzSgXYiTi/TyDkxgu2SwiJQfmS0EwatWxrDpRf8RFlG30qSQbEx5TyhljCjQy3LEAFMa+Ayj+YdjcqtJpiba/IRQ5j8BBG//rZRuXj7+2NRzrJ5l/KIg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(14060799003)(35042699022)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EPeKJSTdxGiz+74xAtVnPo5/78hJdo09jkPvRxBsGk5LAeDlfAErt1Ji7qbIOEmo4VWLJbmEx7WrNi7H5fA5e6TCgYow0tfEfvc3XedOgeP7p3xu2N5sPTc1tki3WUsX9WwEuiU8oVPQwBdqtl1QLVMdpUav+W+aW/zse5ueDasuGf1whC8oauiX2x0SCyMqexwnxUMCqKUyNiSK4OOU6Nse31RoQieBAQC4zqPA8eBWKi88TX0r7ZR8O1NnFSvrtiVCZ384OXstkZOPX0iW/omx1t0hhlhqSqkVjmJlD1KR+vNeBHrXqm+VtA6A0J8IOlPIuqMbtabdnwEv9a8k4YqamRu+cEDyztywn+sVbrP5ZDBEoNw4+BDPM4/egoNzaFxL0s0u7XaOrlM9Bkyu+KRpGC81ZL5ULbuZgD1rkwmbBOz0w6981iY+Z6Z6VnFn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:00.1642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5bd514-6b5e-4aa0-a9b2-08df46545990
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8961
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

Move register access helpers out of panthor_device.h to allow reuse by
other panthor drivers that will be added to enable v15 support.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Picked up R-b from Boris
v2:
- Picked up R-b from Liviu
- Fix includes raised by sashiko
- Link: https://lore.kernel.org/all/20260922205441.263661F000FF@smtp.kernel.org/
v1:
- Includes "panthor_device_io.h" directly in "panthor_device.h" instead
  of peppering multiple files with the header.

 drivers/gpu/drm/panthor/panthor_device.h    | 73 +-----------------
 drivers/gpu/drm/panthor/panthor_device_io.h | 84 +++++++++++++++++++++
 2 files changed, 86 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_device_io.h

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index b55a3f9edd414..4add31b12cfd7 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -19,6 +19,8 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/panthor_drm.h>
 
+#include "panthor_device_io.h"
+
 struct panthor_csf;
 struct panthor_csf_ctx;
 struct panthor_device;
@@ -495,77 +497,6 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
-static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
-{
-	writel(data, iomem + reg);
-}
-
-static inline u32 gpu_read(void __iomem *iomem, u32 reg)
-{
-	return readl(iomem + reg);
-}
-
-static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
-{
-	return readl_relaxed(iomem + reg);
-}
-
-static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
-{
-	gpu_write(iomem, reg, lower_32_bits(data));
-	gpu_write(iomem, reg + 4, upper_32_bits(data));
-}
-
-static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
-{
-	return (gpu_read_relaxed(iomem, reg) |
-		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
-}
-
-static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
-{
-	u32 lo, hi1, hi2;
-	do {
-		hi1 = gpu_read(iomem, reg + 4);
-		lo = gpu_read(iomem, reg);
-		hi2 = gpu_read(iomem, reg + 4);
-	} while (hi1 != hi2);
-	return lo | ((u64)hi2 << 32);
-}
-
-#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				     timeout_us)				\
-	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
-	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  iomem, reg)
-
-#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
-				       timeout_us)				\
-	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, iomem, reg)
-
-#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
-					     timeout_us)			\
-	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, iomem, reg)
-
-#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
-					timeout_us)				\
-	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, iomem, reg)
-
 #define INT_RAWSTAT 0x0
 #define INT_CLEAR   0x4
 #define INT_MASK    0x8
diff --git a/drivers/gpu/drm/panthor/panthor_device_io.h b/drivers/gpu/drm/panthor/panthor_device_io.h
new file mode 100644
index 0000000000000..ce417c64abb44
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_device_io.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_DEVICE_IO_H__
+#define __PANTHOR_DEVICE_IO_H__
+
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/wordpart.h>
+
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
+{
+	writel(data, iomem + reg);
+}
+
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
+{
+	return readl(iomem + reg);
+}
+
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
+{
+	return readl_relaxed(iomem + reg);
+}
+
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
+{
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
+}
+
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
+{
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
+}
+
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
+{
+	u32 lo, hi1, hi2;
+
+	do {
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
+	} while (hi1 != hi2);
+	return lo | ((u64)hi2 << 32);
+}
+
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				     timeout_us)				\
+	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
+	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
+			  iomem, reg)
+
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
+				       timeout_us)				\
+	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
+				 false, iomem, reg)
+
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
+					     timeout_us)			\
+	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
+				 timeout_us, false, iomem, reg)
+
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
+					timeout_us)				\
+	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
+			  false, iomem, reg)
+
+
+#endif /* __PANTHOR_DEVICE_IO_H__ */
-- 
2.43.0

