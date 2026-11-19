Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9692606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=SDEgEo7N;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=SDEgEo7N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39403112601;
	Thu, 19 Nov 2026 15:47:49 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824651125DE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:47:34 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Be2rMuXE9ZMjTg3FMnWf90vczOxgTSYlO+EDBAYkFgQPoJYr5l0sqZzTzLL9VC4te70TDh0Ac9F75x+wGfgL6bpcy50ChzAHbMY3oiehmsDGeRuvFyJTDROx61cSe4Zf03Gr473MSqMDwazuWwoGjczJ1Rt6owJ4S/k0Dotx2sby7GLAv4qlF4CCsL/HvckQx/4r59XlsHL3ZxKlzEiRGg8mb2Ip39BAxSX3mDufVRnjCwKYk96tIs4C3eqLpCJXV0XbAKjWJcUFqfzVgOU7tEtj/B1G5GfT6iIoBQWZihGxYq83OKwj/bmc9ZKqrqgf7OSikpHEHyQG96NJpRcq+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of226oszI5xUoKBG2iY741LZoGM3YhykEUCl4c1wlZE=;
 b=c7vxqGpdf/oV/lY2xqBP+C3aui0pchWPCeVa8r+qB1aopvjBf1dwpammJ/06EYEvmFEmVeH/TzLg1zVF17vwh0TiJjNI0kQ8xKfAQ5+Mz+DqRe+SqWPzOwXYc3Q7ZgM/57SqRl0wmLxbg5vbFHbD34FGxhqmXvuuHHp6lGG6H1oDzgrTFkMxUEkMlkXmtyQ12tU+ZAJq79gRL0nlkzeyKnCJItxaaEpt5Wf4HILxyVFsJnDa7u0A/V3osshE+odjyc4Fjkzs+JjuHHpBrWiWa9rhZrMaG+wF7er3daefa2RirIj9Vug59mh6ALxB2L0xDzyW9siyBORaYdZ34rbEYQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of226oszI5xUoKBG2iY741LZoGM3YhykEUCl4c1wlZE=;
 b=SDEgEo7NPr3dIg8ZuveWyJjN4WoBB3DVI597IlS/DKhpyHz0Ed2kUrXeQGjUidL9IF9Fc4M2+Nx0JK/skko50Dte08eIZm8Kr54wbq0Yyw6bYySMyMVtLzcLIVchIUaT18gwWc8x8x+YdUQS+yFN5HychcbImde7XftYmgsUFL0=
Received: from OL1P279CA0037.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::6) by
 DB3PR08MB8892.eurprd08.prod.outlook.com (2603:10a6:10:43d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 15:47:24 +0000
Received: from CPH1EPF0000052C.eurprd05.prod.outlook.com
 (2603:10a6:e10:14:cafe::36) by OL1P279CA0037.outlook.office365.com
 (2603:10a6:e10:14::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 15:47:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000052C.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 15:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6A0+5XSTGe+pnmtz4U16ynj0P8xfFRw5phmiV0JDZmT7k++iZYYpXyoud804/77aqv487Pkc3z2QLf7RuJdZTIyznbgAehwK08CwPS5elGBMU+KFl8vSgIQ76jnPz31bj+01t1NWM2z+YDy/fY5YFKFoiZTd1pxFFQj4G/2BlaVGbl9BH/XiBvNtZmdk8vXgH2/PlLTNv7YVanxqni7mcic/wY6+67uEV5h5D7RYfvtrPzhHqcuZ/T3rKxeW80JSucYYp3D3tHiOVzG4J3t/aiB1P/XphSpCBGQWOO/g8QEz0vJx/+XArwv0BMXL8VaN5oC00Uxci5fbfuKefBH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of226oszI5xUoKBG2iY741LZoGM3YhykEUCl4c1wlZE=;
 b=xsRemSeG/cNXVe4LwCcI1GKH/1BO6r1PQSR2yyb6H2xXVmUNOlN8IspYXx5YxTAlz+fk/okW64cLRUAC5wU+Oa2U3lvae3MjtjIXzoKQm3n2e0o7WxrrIMA7ek42uE0PgH5CrKG30taQO3ibG+U8hXJVJ84/Co+FUpHkwfi2AP0ju488rCLAm+1obIvzsIVEvWlavSfyj9on2PHsfCVJATt/2COMZ85iZp9gahYMjOyeNGeT8zX7zdG9kB6XJ3o6niljkzIAVofDBtahAfcunsyPEjwxxBfRIHC7dKVodIIKnpVx6nXo2mDlP+tCi4wnzmrsdrzBuwcKzt+vbGBlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of226oszI5xUoKBG2iY741LZoGM3YhykEUCl4c1wlZE=;
 b=SDEgEo7NPr3dIg8ZuveWyJjN4WoBB3DVI597IlS/DKhpyHz0Ed2kUrXeQGjUidL9IF9Fc4M2+Nx0JK/skko50Dte08eIZm8Kr54wbq0Yyw6bYySMyMVtLzcLIVchIUaT18gwWc8x8x+YdUQS+yFN5HychcbImde7XftYmgsUFL0=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB10630.eurprd08.prod.outlook.com
 (2603:10a6:800:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:46:47 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:46:46 +0000
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
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 9/9] drm/panthor: Add Mali v15 hardware support
Date: Thu, 19 Nov 2026 15:45:59 +0000
Message-ID: <20261119154604.2519184-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119154604.2519184-1-karunika.choo@arm.com>
References: <20261119154604.2519184-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB10630:EE_|CPH1EPF0000052C:EE_|DB3PR08MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e398d20-2767-4c2d-ab90-08df465467db
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|18002099003|6133799003|261009223027099003|3023799007|56012099006|261022113327099003|11063799006|261028144727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261021123027099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: kjQYeSyKB8M3SeUkMBnP7gjwTnAROvE2MagFgkAHLDd/i/Ek9KOgxGXyuq/y0a66OCJCI328qE7jxhgZJ+X+1Bnri5awXA/U5sm9JgvJuFRy44uVTxMQNdbS+AFBRK4ARSCiAUYuZzt1Dktyt2bF4FrL22ph0HYFvKl1oY2Zl1xmthU8uPcL42QMpzFs/G5kvUiSnS3lRO4B9SZJhu1Kx10RjoiBHAecPT4erPm00SUck/gHojHO8HJ7/7RaCnuiTjDK5bQQSDmMw9iB8ZtvlyfzovvLXMvG11LhRHnSvFpyeLg6R9ej3GSMQK0lu96cWY3YDdcGdC0KcneLAE/goag++B/rD1xRyWNNFmO1hdzOCwKsHjghmz9abifFMfVxV4PWm0i88fQpAR5iWpgSojqRm2gOgJ48bi6wOupnu/4J+Adc4gLJQ1mz3LpX4vHYCnNpiDnzTG/DO6Q8IF5cGNkZCSOishiRK6YDJn7OHAvTX6n8ezB6u79o9YK4vI40mPxdsoAwqSHTeJf7/BAu1q4Px4vVWhKIpxXU2dl5JXjZiY1Pi/wGTHTBTbpWPi/aEgps2dDcJgT4Xhq/EIPM9yksUXsnEd8/+bShdS8V07I=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(261022113327099003)(11063799006)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: K1AJ/HdzB/J/oIHT3AzB057v475rWvsx2lwoEAF2PNacgiuc1UmPS/YeXuy5dVQrqyFnKR/jUqgf1mYvhTXGjNMV+Rsbz2V981ZdiY7Eqtd67pqyGrum2wn0r83x5jzbuj6MFtfh5Hqd9kCTinleJv0rm2hUGzdnAVRPdEviR0FHvAihwY7dVmB9QRHwpD/SZ18DgI+lppBFpwzm+8lKu+PmDTzkdq7gfGw0NLv6I7M6ov6TKdNI2wl94Y5WUH2GryaUo2sxts0j+kJnRjNYKaRvDLRdplSBFJTExLHl2zvoQGwrp9D8UH5TpKTQ3k5t3NAnWjOMTz0aLVhAWWReiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10630
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000052C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a0caa9f2-0b90-466a-bf88-08df46544eca
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|14060799003|36860700016|7416014|1800799024|35042699022|376014|18002099003|22082099003|6133799003|3023799007|13003099007|261022105027099003|261021123027099003|11063799006|56012099006|261028144727099003|261022075727099003|261022113327099003|261102123227099003|261021121427099003|10067099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: gk/C95sj2saF6pzthLbrA6sFznWH3fJ1WIiw72gBf+FNjXrFiYbi23EeRKJFe1kgLWhcob7NkBVMnzj6wcTVmZhHHActUpEOS1SnOgr8dlR0srNIbDy0Flgy8wUVrx/oM4JFxbhYxaLKn02/9U1mvplrZWLicgF1aHwbk+gaJ9au4GsQqKqsIzZYmqpQZkvff1vV2gdMQBKxgpFbSmTeUFDaAc0u7qcoUAoNanLeVVVpEr/2aKdgv7/ZXxH9DBAJc1S3BpKtPc1ZLTOSk+2YbtG2Us1IJyYwCAI8dPjqBCYvxzo8POk5NmAi7ZEhb8MG+cjvwz+to904c/J0LYNCtbUp/hB9h5+kdWSVl563M7DpyUUnpHzEjILPzMDGm9wcvR/3fOHW56jzNhtdBSQaHwURcuWkN+gA8hbbL7JHpz7Z5pKV33I3PNrEPX6W3AAKW7iIlQGalHkUwwbC2jA1vhM/Z48oRySIoWurnVGty8X9uAWl0t4cfm8Voj8rx0xwU5qHkUnF5YaUn8h+sLRSVZpbHTDnmrOpcWRVtRR8yFV4+d9f7LF/iNI+4dYE9e9RnPWLA1aq2s4YVTnDCq7lu9WniArK/xNfGIE7QgGzK++8oqI3EXelN9B9oGAj+m3IOp2akwoBqvUlf3zkDPfhAQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(14060799003)(36860700016)(7416014)(1800799024)(35042699022)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(13003099007)(261022105027099003)(261021123027099003)(11063799006)(56012099006)(261028144727099003)(261022075727099003)(261022113327099003)(261102123227099003)(261021121427099003)(10067099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NKqlgCqUQ+HpkP6bqdQBKFXvtoYjpJo7BcjI3JVSjBL6uyHXDOQm1noKUn+LVg8cy7HNtaPWH+HEfq0ldDW6VGxmSphhx1SL9VJD4ghJsgKqkRdYhYCreedajLjqH4xKNKHgJF7cu7q8T3MPJ8FHstPrTBVgNyh5U+AhjMGeKOaVhy7V48uhkdUvooYdk9rLiJtYVQZ/uZof2pxCYTr2oLj+M7ROX+VhaJKDnKejxLdv+7n12x60qxTeYng7/JheYOXOUNO0NK8j4yVmvkA9FBPkmL2gNN45oG2zcMpqa/E0sXPoyC93YvSX29rSIrVcGSKt/pe+Bc2lrBds0LbdNMsJaOaTJfR6MOQiuyNXkalSkkITl/MMmaN3j5mTu/uRrC35Hk5FIV2E7JHbc+bCdIxOgXhZOnQWEWFPm7/4FIWMLuHbDQP016hJ1PUkfZNP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:47:24.1864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e398d20-2767-4c2d-ab90-08df465467db
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000052C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8892
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

Add the panthor hardware description for Mali v15 GPUs and hook it into
device matching.

This includes the v15 register map and product identification needed to
populate the GPU information exposed by the driver and its uAPI, as well
as add compatibility string for v15 GPUs.

Mali v15 also exposes a 64-bit GPU_ID register with a different field
layout from earlier GPUs. Add the register definitions and decoding
helpers for the new format, read GPU_ID_WIDE when the compatibility
value indicates a v15 GPU, and populate both the cached GPU_ID fields
and the uAPI gpu_id_wide field.

Bump drm minor to 10.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- squashed 64-bit GPU_ID decoding into this patch. Resetting R-bs as
  a result.
v2:
- check as_count is non-zero before generating as_present mask per
  sashiko's comment.
- Link: https://lore.kernel.org/all/20260922205812.C473B1F000FF@smtp.kernel.org/
- clean up l2_features value assignment.
- removed duplicated GPU_FEATURES macro definitions
- Picked up R-b from Liviu
v1:
- make COHERENCY_FEATURES register read use cached gpu_info values.
- Added Mali-G2 name variants and NX aware model identification.
- fix premature reading of l2_features gpu_info field during
  panthor_hw_info_init().
- build as_present using GENMASK.

64-bit GPU_ID:
v3:
- Fix the missing blank line after declarations in GPU_ID decoding.
v2:
- Picked up R-b from Liviu.
- Rename the register macro from GPU_WIDE_ID to GPU_ID_WIDE.
- Rename the uAPI field from gpu_wide_id to gpu_id_wide.
- Print the upper 32 bits of GPU_ID_WIDE as the logged 'id' for v15 and
  later GPUs. Keep the existing output for earlier GPUs. Continuation
  fix for previous sashiko comment.
- Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
v1:
- Decode selected GPU_ID format after checking compatibility value.
- Document GPU_DISCOVER and GPU_CONTROL register offset differences
  between GPUs.
- Fix mask generation in panthor_gpu_discover_regs.h

 drivers/gpu/drm/panthor/panthor_drv.c         |   9 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |   1 +
 drivers/gpu/drm/panthor/panthor_gpu.c         |   3 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 +++++
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 159 ++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h          |  13 ++
 include/uapi/drm/panthor_drm.h                |  23 ++-
 8 files changed, 230 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b4d3d339b04b4..94320799d5d75 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1788,6 +1788,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - adds thread_num_active_granularity, gpu_rev_wide, l2_features_wide,
+ *          and gpu_id_wide to drm_panthor_gpu_info
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1801,7 +1803,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
@@ -1880,10 +1882,15 @@ static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
 	.asn_hash = { 0xb, 0xe, 0x0, },
 };
 
+static const struct panthor_soc_data soc_data_gen5_am = {
+	.devfreq_disabled = true,
+};
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
+	{ .compatible = "arm,mali-gen5-am", .data = &soc_data_gen5_am, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 679ea1d233d53..1449d9a66302e 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1563,3 +1563,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index ab54119314da0..2e1b00e86cdea 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -503,8 +503,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
-		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
+	if ((ptdev->gpu_info.coherency_features & GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
new file mode 100644
index 0000000000000..05e90950ec6ad
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
+#define __PANTHOR_GPU_DISCOVER_REGS_H__
+
+#include <linux/bits.h>
+
+#define GPU_ID_WIDE					0x0
+#define   GPU_WIDE_COMPAT				0xF
+#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK_U64(63, 56)) >> 56)
+#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK_U64(55, 48)) >> 48)
+#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK_U64(47, 40)) >> 40)
+#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK_U64(39, 32)) >> 32)
+#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK_U64(23, 16)) >> 16)
+#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
+#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
+
+#define DISCOVER_REVIDR					0x8
+#define DISCOVER_GPU_FEATURES				0x20
+#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
+#define   GPU_FEATURES_SIMD_STATE			BIT(1)
+#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
+#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
+#define DISCOVER_MCU_FEATURES				0x40
+#define DISCOVER_PRFCNT_FEATURES			0x50
+#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
+#define DISCOVER_DOORBELL_FEATURES			0x60
+#define DISCOVER_MEM_FEATURES				0x100
+#define DISCOVER_MMU_FEATURES				0x108
+#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
+#define DISCOVER_AMBA_FEATURES				0x120
+
+#define DISCOVER_L2_FEATURES				0x128
+#define DISCOVER_TILER_FEATURES				0x200
+#define DISCOVER_CORE_FEATURES				0x300
+#define DISCOVER_THREAD_FEATURES			0x320
+#define DISCOVER_THREAD_MAX_THREADS			0x330
+#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
+#define DISCOVER_TEXTURE_FEATURES			0x360
+
+#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e91..afb7d68abc874 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -11,6 +11,7 @@
 #include "panthor_gem.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 
 /*
@@ -105,7 +106,7 @@ struct panthor_heap_pool {
 
 static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
 {
-	u32 l2_features = ptdev->gpu_info.l2_features;
+	u64 l2_features = panthor_hw_get_l2_features(ptdev);
 	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
 
 	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 593bf6743d6df..fc81fabbe62fd 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -1,13 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
+#include <linux/wordpart.h>
 
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_discover_regs.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
@@ -73,6 +76,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 	},
 };
 
+static struct panthor_hw panthor_hw_arch_v15 = {
+	.ops = {
+		.soft_reset = panthor_pwr_reset_soft,
+		.l2_power_off = panthor_pwr_l2_power_off,
+		.l2_power_on = panthor_pwr_l2_power_on,
+	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x3000,
+		},
+		.mcu_control = {
+			.offset = 0x3100,
+		},
+		.pwr_control = {
+			.offset = 0x3800,
+		},
+		.mmu_as_control = {
+			.offset = 0x2800,
+			.stride = 0x80,
+		},
+	},
+};
+
 static struct panthor_hw_entry panthor_hw_match[] = {
 	{
 		.arch_min = 10,
@@ -84,6 +110,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
 		.arch_max = 14,
 		.hwdev = &panthor_hw_arch_v14,
 	},
+	{
+		.arch_min = 15,
+		.arch_max = 15,
+		.hwdev = &panthor_hw_arch_v15,
+	}
 };
 
 static int panthor_hw_set_power_tracing(struct device *dev, void *data)
@@ -151,8 +182,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 						gpu_id->prod_major);
 	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
 					 GPU_FEATURES_RAY_INTERSECTION);
+	const bool neural_present = !!(ptdev->gpu_info.gpu_features &
+				       GPU_FEATURES_NX);
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
 
+
 	switch (product_id) {
 	case GPU_PROD_ID_MAKE(10, 2):
 		return "Mali-G710";
@@ -195,6 +229,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 		return "Mali-G1-Premium";
 	case GPU_PROD_ID_MAKE(14, 3):
 		return "Mali-G1-Pro";
+	case GPU_PROD_ID_MAKE(15, 0):
+		return "Mali-G2-Ultra-NX";
+	case GPU_PROD_ID_MAKE(15, 1):
+		if (neural_present)
+			return "Mali-G2-Premium-NX";
+
+		return "Mali-G2-Premium";
+	case GPU_PROD_ID_MAKE(15, 3):
+		if (neural_present)
+			return "Mali-G2-Pro-NX";
+
+		return "Mali-G2-Pro";
 	}
 
 	return "(Unknown Mali GPU)";
@@ -218,7 +264,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 	return 0;
 }
 
-static int panthor_gpu_info_init(struct panthor_device *ptdev)
+static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -259,31 +305,86 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
 		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
 	}
+}
+
+static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
+{
+	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
+	u64 texture_features;
+	u32 as_count;
+
+	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
+	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
+
+	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
+	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
+	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
+
+	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
+	ptdev->gpu_info.thread_num_active_granularity =
+		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
+
+	/* The upper 32-bits of following registers do not contain any information (yet) */
+	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
+	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
+	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
+	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
+
+	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
+	as_count = MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features);
+	if (as_count)
+		ptdev->gpu_info.as_present = GENMASK(as_count - 1, 0);
+
+	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
+	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
+	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
+}
+
+static int panthor_gpu_info_init(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		panthor_gpu_info_v15_init(ptdev);
+	else
+		panthor_gpu_info_v10_init(ptdev);
 
 	return overload_shader_present(ptdev);
 }
 
 static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
-	u32 major, minor, status;
+	u64 l2_features;
+	u32 prod_id, major, minor, status;
 	int ret;
 
 	ret = panthor_gpu_info_init(ptdev);
 	if (ret)
 		return ret;
 
+	/*
+	 * The logged 'id' contains four 4-bit architecture and product fields
+	 * in pre-v15 GPUs. In v15+ GPUs, this is now four 8-bit fields.
+	 * Preserve the pre-v15 format for compatibility. Tools decoding these
+	 * fields must handle the wider format for v15+ GPUs.
+	 */
+	if (ptdev->gpu_id.arch_major < 15)
+		prod_id = upper_16_bits(ptdev->gpu_info.gpu_id);
+	else
+		prod_id = upper_32_bits(ptdev->gpu_info.gpu_id_wide);
+
 	major = ptdev->gpu_id.ver_major;
 	minor = ptdev->gpu_id.ver_minor;
 	status = ptdev->gpu_id.ver_status;
+	l2_features = panthor_hw_get_l2_features(ptdev);
 
-	drm_info(&ptdev->base,
-		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
-		 major, minor, status);
+	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
+		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
 
 	drm_info(&ptdev->base,
-		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
-		 ptdev->gpu_info.l2_features,
+		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
+		 l2_features,
 		 ptdev->gpu_info.tiler_features,
 		 ptdev->gpu_info.mem_features,
 		 ptdev->gpu_info.mmu_features,
@@ -323,18 +424,42 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
 	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
-	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+	u32 gpu_id32 = gpu_read(ptdev->iomem, GPU_ID);
 
-	if (!ptdev->gpu_info.gpu_id)
+	if (!gpu_id32)
 		return -ENXIO;
 
-	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
-	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
+		/*
+		 * GPU_DISCOVER register block always starts at offset zero,
+		 * so does the GPU_CONTROL register block on pre-v15 GPUs.
+		 */
+		void __iomem *discover = ptdev->iomem;
+		u64 gpu_id64 = gpu_read64(discover, GPU_ID_WIDE);
+
+		if (!gpu_id64)
+			return -ENXIO;
+
+		ptdev->gpu_info.gpu_id_wide = gpu_id64;
+
+		gpu_id->arch_major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
+		gpu_id->arch_minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
+		gpu_id->arch_rev = GPU_WIDE_ARCH_REV(gpu_id64);
+		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
+		gpu_id->ver_major = GPU_WIDE_VER_MAJOR(gpu_id64);
+		gpu_id->ver_minor = GPU_WIDE_VER_MINOR(gpu_id64);
+		gpu_id->ver_status = GPU_WIDE_VER_STATUS(gpu_id64);
+	} else {
+		ptdev->gpu_info.gpu_id = gpu_id32;
+
+		gpu_id->arch_major = GPU_ARCH_MAJOR(gpu_id32);
+		gpu_id->arch_minor = GPU_ARCH_MINOR(gpu_id32);
+		gpu_id->arch_rev = GPU_ARCH_REV(gpu_id32);
+		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
+		gpu_id->ver_major = GPU_VER_MAJOR(gpu_id32);
+		gpu_id->ver_minor = GPU_VER_MINOR(gpu_id32);
+		gpu_id->ver_status = GPU_VER_STATUS(gpu_id32);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f93a6b16df2af..8d61a1099aa5e 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -105,4 +105,17 @@ static inline bool panthor_hw_is_devfreq_disabled(struct panthor_device *ptdev)
 	return data->devfreq_disabled;
 }
 
+static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
+{
+	return ptdev->gpu_id.arch_major >= 15;
+}
+
+static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		return ptdev->gpu_info.l2_features_wide;
+
+	return ptdev->gpu_info.l2_features;
+}
+
 #endif /* __PANTHOR_HW_H__ */
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec6915..da9f8f82413cf 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -371,11 +371,30 @@ struct drm_panthor_gpu_info {
 	/** @core_features: Used to discriminate core variants when they exist. */
 	__u32 core_features;
 
-	/** @pad: MBZ. */
-	__u32 pad;
+	/** @thread_num_active_granularity: Granularity of number of active threads */
+	__u32 thread_num_active_granularity;
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
+
+	/**
+	 * @gpu_id_wide: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
+	 * this is populated.
+	 */
+	__u64 gpu_id_wide;
+#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
+#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
+
+	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
+	__u64 gpu_rev_wide;
+
+	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
+	__u64 l2_features_wide;
 };
 
 /**
-- 
2.43.0

