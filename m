Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699060A2635
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iK1vpS04;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=iK1vpS04
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3686410F7AD;
	Tue, 10 Nov 2026 15:41:16 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D51F10F79B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:03 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Lf2to4ePr2TfnDARlNUUpWw0f94P7hF/mUL+ERN3C1X1CSQ9UKUWrxkoss4HJuRqEhR1AT8DNxRe0oShoVovaUI6xmumA/owH8XxNnApJv+YhUoVENuWB6MGB7Evm69T7MdmqTAnjIHdkCIqTHuQ9zhOpKnTa5zbxCL5jTLAIWSxWSkcLQcUhAmMgnak+9+TzDszFz4denQXLESb5C0AFcNcfKtLFxKBhITSwUE6GeCUD4mU/ObruNbaKAvIqf+HMu4OeUqifJOkeZY59kEXvRF2mk9pxcb/6YBB8s3leDofgPKq5BJQkb2J2YfgX2NeSRb0yjEcqO2VwbARr+r/iA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH0jJIW1JsKHxUwax5IvsC2xKEX/3ApiklwxdKuA3X8=;
 b=RK/VS92PFj0nnxUocJyG+xPz3niKT0oEhldugy3sS51iwBW7d8LZrZpbtGhA6WcGTizo54o5kl7wAXIMK3D+2mvCWFtPbhR+/Vq4gvSmedQNwxGyPwRX08I48pq850OIRPqn9kK2HAYWuXdVPlkzLaBejc5uWRFYDlnnayXFVH6qGrmdOYdDyZiNxGoB+Em2IrXMh6+BYSXBJCp+NmuYjY873vrb384OPWoyIFcqcBLukj3ocCPOIz8exzEnNkKI9/GAaqFcRdP/lXj0QrhnCyP4BAqJZO3TtCWcplyHu7N+AUoDtZnq+Sq3F7Smws85+YSw9djXvLFFhN1WVtpi3w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH0jJIW1JsKHxUwax5IvsC2xKEX/3ApiklwxdKuA3X8=;
 b=iK1vpS04eimFJB/ynNwRgvoinAG/qsEw7j/95pHotoQiQB/eoGyfWba1WjO0bFsncayHNjCOc2Jo7xV96eHjPxdiLqEgmDq/J7L+3sWVpr+NsQrh+PpEPzmkj7hh7JkUZQ75f1xp0/TM55A0jtU7o6Wda/ay1akVbrpkjvvnmFc=
Received: from PR1P264CA0113.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::14)
 by PA6PR08MB11583.eurprd08.prod.outlook.com (2603:10a6:102:520::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:57 +0000
Received: from MI3PEPF00008490.eurprd03.prod.outlook.com
 (2603:10a6:102:2cd:cafe::44) by PR1P264CA0113.outlook.office365.com
 (2603:10a6:102:2cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008490.mail.protection.outlook.com (10.167.240.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewDyPXyUSEMA8knvmDrzC9OT0MwIED0L8QTYLXLPwZufVp0jOMdOTdOG+KhkSlcrV5trH4alaKV3X/8lO2tpGWcPcS0BuEHhKyOfbYR6RY1/P1D/uPhHoKGBxqx6kWlogTnOEW4GWe8IRhS4iVBNUN1S/PENI0cmj+i2wP7c1NAeW7m5Hi4K2zMCYbaJDK591koD0bixgqEr69YXmFvl2xTJOe4wuIvIdzF7s9znjiyduH1U6xnvnPM6xhKc9wEXOdBV4x1HFZ3IEJA5miXTHf4HiMVCKI4nxr+Sqar24zrxGmlqAQaLycKRdS/ATQcFmIZrcRIg9xQQ4rTf/Mkp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH0jJIW1JsKHxUwax5IvsC2xKEX/3ApiklwxdKuA3X8=;
 b=g01uCOrnyg9EUhanTNk6J2yUvQgkjPnmZep3/8yRI3ZRo/0LDrszJEkp1+aS60rkc+saSHHhZaCOEoaxCbxtKO4KpZvQvKzQrqDRpbiejiq7Syrgh0mKHdx9lmHi/WuBWh9exGI5Hx3WkeglqHIwyVrZ8fWJv6COXxQYoACuerwLGfLcvWUDCOiBGmRpFkiaUNgo52biDv+aHQioGqOG/goMoLIttERyrHalVdChRvzs/3PhvK4ZrSCr9U/EgAFIPlI6ZOwkpzDM3kkydH1aFkMnDcLKEC6yc9GwbdLxH42Qdmtvgrtmn+LzGejXqgP9lxJur5y9DIK6OUDm+pzDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH0jJIW1JsKHxUwax5IvsC2xKEX/3ApiklwxdKuA3X8=;
 b=iK1vpS04eimFJB/ynNwRgvoinAG/qsEw7j/95pHotoQiQB/eoGyfWba1WjO0bFsncayHNjCOc2Jo7xV96eHjPxdiLqEgmDq/J7L+3sWVpr+NsQrh+PpEPzmkj7hh7JkUZQ75f1xp0/TM55A0jtU7o6Wda/ay1akVbrpkjvvnmFc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DB9PR08MB7844.eurprd08.prod.outlook.com
 (2603:10a6:10:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 10 Nov
 2026 15:40:24 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:22 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 09/28] drm/panthor: Add Mali v15 hardware support
Date: Tue, 10 Nov 2026 15:38:30 +0000
Message-ID: <20261110153907.3241978-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::9) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DB9PR08MB7844:EE_|MI3PEPF00008490:EE_|PA6PR08MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f34e673-9592-479e-7043-08df3f41034a
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|261022075727099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261022113327099003|261021123027099003|261026121527099003|56012099006|261026140227099003|261028144727099003|261102123227099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: YdCqy2CZTfhNe/WqTt2AL8b5j7CCHf+aBqK/OmyQOhbjD3Qs1ErS2ci9+FEK4rhAdCxvpTJPPdP4th7qkUvAosXhPUz8dzh1rQge56rQetHwqG9HNlV/eBlyA70uPI2kkGErfOsRAmXI1zen4dwKN6Bdq+9zvznMFO6RpyM2+l3fJ70b7VWQtsak2wQIck0Q775NLPFuleTVCZfehickyim/gmojCaNvE+cNfc5g+v3uw6b379acU6DfpecUrfuSTz+yqN4rHBvQeD8QFEbJD9KcmcZdbUxTMro3tUPmDxofNABEIBGuetqiGHZahvxaibv/hIqgAlFwKLpSeobEWDGq5Ck/kjuA4aba3CZQ8PBZVJ5fayuvimd7Skvpl2BIZ4blXiacmZbuSIQXD6hmi5w2F+NiYhiLl+NXZqIYeYMED3ueSEcxI+safBE3rywRmhsLgDFvkQpoNMHu0ql+wA4weO+9oZV8mGD3pZSsoGJNUydv43JhZjYsUxGbfLpvVhdTMULxOKmauoqSW7KksG6Mp1Ww0W+yrZigeR7MhsqsbNQZ/5p6hx7JVqqVZMT4NuQSaB3BpcWu1VAtJhGseHFD3dVTWPxPu5zRteLkQDaDnuBAq8hj9K97WXeaf2ch
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(261022075727099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261022113327099003)(261021123027099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: sKwh44PuLmARt9saNTZY6eRSiX/xqcmibVh9d6sK2nP2jdW2kfAmk7PeoIojS0ikob9bZJ68XpylrC0pK6Sfu9tPhPRVvluBqW0b0lOOMaitz86yLjxLqdkpugYmm9PUbXz+hfnCkwsmMKHTrlWKaKvibZ1TWSaObQyQXx6ERCPc+dQCId++OpYacUkMAWSwDhh+stH+W/weYrAqQ499qdzv9mjLJm4+gaO0wFzb1Ak9+qqGWxdJJGOegCCmfZ+c49eMerbFSnwc4McUUgAgcBTYh39edjojuGj+KzI0k7BRbCmHJZ4NHx4NtrpOHE+gLbBeQ7eRPAV0diEA8AePoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7844
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008490.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 856e798c-61a3-44f8-c031-08df3f40eeb2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|35042699022|23010399003|14060799003|7416014|1800799024|261028144727099003|11063799006|261102123227099003|56012099006|261026121527099003|261021123027099003|261022075727099003|261022113327099003|261022105027099003|261026140227099003|261021121427099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: kkYCU1JhjY11KIyRD1EYbLIQrLvJJ8iQOmSbT7Fa0i/BQrdxI5VYgQSIkF9gk+M8TmGZeVyKHVP9LlopfpBc+zzQ3EiFjH+s0r9SOrsm0AracIzxMotEgbdoDeKGmCoopfqSTjY13BWQSLCLxN98ZkNkDYjsQoyB4ViaAbe8p49AS6cbO3pH8z6jSyQurXmuzkmYUtjYwXKFNooW7Xkn2jDUsGJUMYA93HpTBeeHKdbAwfk61aq5aRdocq38PXWCQd9S05DSRd/+Nb09tFdXTGph+gIWNQUK9Ivuzwpr1LN57C/GKPUJ/UCEAaZGrKJimZWWxp+ofSsDH8W1isp2BJHkfC1FoCRSF9MpOlQuzolk1A8vs/bP5c5hRiZ/rm2qf2reXMo5U7WZ+X8O6rJ/KBSA12Q6qxv6T7BB8Gjz8Mms+1PlFq0ub3LbxZAxJGaX06fJ3FG+OXoutTHlQCoTmmchdjO3Lq8jAsPZo2nKIv5cjgqZX/+AhQduO5fMtVuVtrml3JIyjTxND26ohK3DmVVd5Mv61WtLQTNlxL2DEHHi+dVFP6C/9ZLKCjL/FjDIZSfAiitUWI/FQMKrvWn96KTVINj1rQX/qUBftE+zve1FRHAVVUAHcfsExBBep+IqDAboVns+JzB8KOJJjGy7Hw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(35042699022)(23010399003)(14060799003)(7416014)(1800799024)(261028144727099003)(11063799006)(261102123227099003)(56012099006)(261026121527099003)(261021123027099003)(261022075727099003)(261022113327099003)(261022105027099003)(261026140227099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fuFo1peSXtyj76ioGD8Ez+yLcA+Uwb/Rz6BSmhDRUmmbsNDnRW8op3GXAzbKq2Wf5kbrQiNHAoL5LXO0AEtBRSozqv5QqMDxrkL/SRbSdnwCITtk7F94XjNT5MbJuGDVe0i+bckBrVMzEkcDx34Hbu04X5cHQ9Kty7QLACo7XlahEFCEUusQ8j6MyMrfrDw5lsx93cw1bvdUSOn0dMeRfW1NtqKvKxmzd8Sg8YqKRiQ0AFUWNSeELAWBT29Q9599CSqFaGHI4/dlbDWOzWq3VGJMso2mbA0o0VooTeBgFdZPczafn1A53TaB6qP3kUyA9fp/jVHXYS4NLHUygsWMu5s8hgdKApIfpSn/cN1LyhYq+pogOurQrUhxhLyC54PEcd27ebNF1StBOES+SMotD/s9/J+RPpMSuRWENzNtTuWItce9t40ZVMRl4PSWCTJu
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:56.8473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f34e673-9592-479e-7043-08df3f41034a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008490.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11583
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
populate the GPU information exposed by the driver and its uAPI.

Add compatibility string for v15 GPUs and bump drm minor to 10.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
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

 drivers/gpu/drm/panthor/panthor_drv.c         |  5 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c         |  3 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   | 23 +++++
 drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 96 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
 include/uapi/drm/panthor_drm.h                | 10 +-
 8 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef42..e9b71ff5ee53f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1785,6 +1785,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - adds thread_num_active_granularity, gpu_rev_wide, l2_features_wide,
+ *          and gpu_id_wide to drm_panthor_gpu_info
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1798,7 +1800,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
@@ -1881,6 +1883,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
+	{ .compatible = "arm,mali-gen5-am" },
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
index 6896c263f76b6..05e90950ec6ad 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -16,4 +16,27 @@
 #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
 #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
 
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
 #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
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
index 3a344fa292168..e8e899c638128 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include <linux/wordpart.h>
@@ -75,6 +76,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
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
@@ -86,6 +110,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
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
@@ -153,8 +182,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
@@ -197,6 +229,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
@@ -220,7 +264,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 	return 0;
 }
 
-static int panthor_gpu_info_init(struct panthor_device *ptdev)
+static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -261,12 +305,57 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
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
+	u64 l2_features;
 	u32 prod_id, major, minor, status;
 	int ret;
 
@@ -288,13 +377,14 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	major = ptdev->gpu_id.ver_major;
 	minor = ptdev->gpu_id.ver_minor;
 	status = ptdev->gpu_id.ver_status;
+	l2_features = panthor_hw_get_l2_features(ptdev);
 
 	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
 		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
 
 	drm_info(&ptdev->base,
-		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
-		 ptdev->gpu_info.l2_features,
+		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
+		 l2_features,
 		 ptdev->gpu_info.tiler_features,
 		 ptdev->gpu_info.mem_features,
 		 ptdev->gpu_info.mmu_features,
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 4cb603a3acef6..fe31c1088af5a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -95,4 +95,17 @@ static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
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
index 09b7f7931e4f4..da9f8f82413cf 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -371,8 +371,8 @@ struct drm_panthor_gpu_info {
 	/** @core_features: Used to discriminate core variants when they exist. */
 	__u32 core_features;
 
-	/** @pad: MBZ. */
-	__u32 pad;
+	/** @thread_num_active_granularity: Granularity of number of active threads */
+	__u32 thread_num_active_granularity;
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
@@ -389,6 +389,12 @@ struct drm_panthor_gpu_info {
 #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
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

