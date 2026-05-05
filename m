Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643DEFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 08:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1D710E150;
	Tue,  5 May 2026 08:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="C8rjF3Zd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C8rjF3Zd";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8568810E150
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 08:16:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=K48hQrQiztc8AHlP+LuSYVminMUQKULS0yhu4VYEx6uC79mdUCPIYxMWr1bJRPhRcyWrG6k/eGr2i10M+5pzuAp8sp7Xpt+xaFXtblGTfWtb1ootLPDxsM9h1yTh7H71qrfjsrF+TnLHm1RJhQKN7SEOuyd6KKzgqBGYLOeYHoVV26M1gqT3I6symxFOL4+FFcstHfzxgrH1oy0A4ElDP+Ig8Za4fEeU2g2fNfaDvSimem8G07xsq6qnYvAItVq/ArUKF0WJMzPf8TbIAhQn5vKVNsqyNaHvreuf7vWrRLHZdkFA5+mTH9zpCjbatb2F7za2B4WjrYeMUWFo5uTroA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPG503+juLMQUOaYRsrSMomMqIYiwNHGDCgta0T7VC8=;
 b=h8DqBvKL7MVHb9BilcgMYv6iGviPivv11IHoTO8Ss8Ch69hHyYf9FXRxa6BwNZNuBHixKvXiUmwDGaYmjpTiucjN/zWFpeLS4xdiQBixpRZe7C8D0HbFqCVbh/nOTDUgg55TKWMF1fWsxrKyGgXpmfI1PRonL9MIUuqhTcUXKsE0phC2yxzEnXGeIMD8B2eB2Q2jRffPawAkHFxRVL+C4dg1wHLbKIUYX49iewIm58fkY+3TLKE2P5uhCLdOazNz52oZC9gWdHEkrcURWHB903nsy1VqDftNaqIOLL+adyRZRFy3lb2rUQtghmqXTeQBUXcTIOOldgiQC7B2Ij1RhA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPG503+juLMQUOaYRsrSMomMqIYiwNHGDCgta0T7VC8=;
 b=C8rjF3Zd8dYYXLeQOealwsXtKYV5xkjc2hA/YupEUrjT/sRukIHK7h3eL0ylCnA8k1hxiHGtCohiVatHbBCdkg1fm67NtMZXweMw4WzSmeAN+vmz623tVoI9TPCcN/3irI1FuojUM6o7P1GNNffeWWtLCdbd+VQKpOQ3ythnyFM=
Received: from DUZPR01CA0114.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::13) by VI1PR08MB10300.eurprd08.prod.outlook.com
 (2603:10a6:800:1bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:15:58 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::7) by DUZPR01CA0114.outlook.office365.com
 (2603:10a6:10:4bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 08:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Tue, 5 May 2026 08:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNCJfUkaoPTyf93nkqhuc6VeijSC0UqI/km45OOEOhZNadjbKMOF9O3H/Iv30mhq/JuiJOHiLkoOKdYSj+cxdz+NtrcvkFXn4TSUHcoFiEW80eKIxlsm1JcoaKfF6VYD0iLm9nwNPLsHi2TGK79moBFfB1GhA8nEUKdkKOZ8rVsac2072PY9ANqzmR7g5fH5htZuVUbLbJyLFrW2BRAeobd3bXyy2xQ8v/crRrh2rLZp0b9nC7ftRlRKTdMbkAdZQ+z3bhm3C7lBPqmQ/DeVnIZImhLP+QhhYlO6yaPdHCFugVo+P/iTOZIchP4xRsFq+il+R+XF/vShaqPduR3Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPG503+juLMQUOaYRsrSMomMqIYiwNHGDCgta0T7VC8=;
 b=By7yg1o867Vv9Q3VKUouADLV42l6hnOGJDtTRsE3lLq6xZJ8ZhybnC/QbZxOI0eQwMohms6UDdctI2ejhem/NTpxhWghMvwUPff52YTXPQsfqNGOYN6T0JD7ozDqhsSG+WM7apH1KZOMSBN41vpAC27uOuyOShW50SMLqJnUGEQgWlvdifWBYBF3v4PfSj25mtufFlkIQDoCo4jAcFfuRzdnfBQskrqtt/mo/7J4FYhKbM0UX+1D5gcrx6Ffphn1gtAlxiRfcHIlwYD0OTFM/6qtjEDrZwvw5N5ts4bGfzxzmZ0G5Cw9rUV1588tnvsjAZTjk4DWnUeKkqKWiKYz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPG503+juLMQUOaYRsrSMomMqIYiwNHGDCgta0T7VC8=;
 b=C8rjF3Zd8dYYXLeQOealwsXtKYV5xkjc2hA/YupEUrjT/sRukIHK7h3eL0ylCnA8k1hxiHGtCohiVatHbBCdkg1fm67NtMZXweMw4WzSmeAN+vmz623tVoI9TPCcN/3irI1FuojUM6o7P1GNNffeWWtLCdbd+VQKpOQ3ythnyFM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by PAWPR08MB9759.eurprd08.prod.outlook.com (2603:10a6:102:2ee::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:14:55 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:14:54 +0000
Date: Tue, 5 May 2026 10:14:50 +0200
From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
To: =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 kernel@collabora.com, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, nd@arm.com
Subject: Re: [PATCH v10 5/6] drm/panthor: Support sparse mappings
Message-ID: <afmm-gRz7W3LTW3H@e129842.arm.com>
References: <20260429183253.66422-1-adrian.larumbe@collabora.com>
 <20260429183253.66422-6-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429183253.66422-6-adrian.larumbe@collabora.com>
X-ClientProxiedBy: LO4P123CA0481.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::18) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|PAWPR08MB9759:EE_|DB3PEPF0000885C:EE_|VI1PR08MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1e116e-f60b-4a86-4c39-08deaa7e8967
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: uASqDiWK/48xnDlUbZICECdL56EYV8A9/ZBE4GmS3Fv7WVdt/veTLTNXyN8Att08IRHq0eulTIdEZzSHz+DMN0HAt8fOmicQT1agAwOc4Iune3ZoqoxsHDVpLlolX4jAp7cI2tEWMUsZjBdoTreQtn+Ois0asoVth9sHlu7gOsDdLuzUglBTiC9XWcRv/hAEGEniwbWQ00Ae7Xx2gEGAZbruqhgmOJDoBtDrVuIJ/E1C3GlWaSJOYJ8AxFy4GX1xhbYjWsnoUZ8wMnpWdas+nvsyY6ZvoPJS6+gUateA/cJSQi4FkcXpxicqTrnmVDnHIHKLH94w9rICMDQJnte3jbw0h209zDmdpldNQxstsPgW7H9L1dJQRHGPEEObd4HmJUPYZ3V0jguNPpBwpXpOmg8X3WPdDMWOrAmNAlNv51dI/r303zZ5WamZwBOTrjfUxpOp6dFoYfJd0li33cGEvDqE/tJe+azHXL+IwzXxlDQ1WwAb9ABSjYZXHU8R3BuuRb/QxSdYqD88b4nGyTIpnYhFSKgyLidXdn2hgdDuvGxPGupw+GgOs9cHxpKNt3JAg3mEQQey4MdpMv179KPr8CI8pCaTPJDU5LeduwZ7bjiVxOsDx78ZhliYe0C9Csu4scr/7upI5EfPETkXQGilzhN8i6sCxJsCriGKHUKhy3sZ7qblZgplqC6XBo0ji25n
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZpopgKyzhpdiB0dtzViRupWkAbTdiKgiE+vKoEnDIm4KVUtniVRldO/nEFRKksgKfaYLjkJxDcTaUQwG+dAd0jek9/Svn1rNchDiY4+FyTstyE+w4L1pQWk8AhGjXcbs42ZUqyP03M5lxf+zxa6vMjBgjTgSWYSmfPjYN2XaOIzo5URns1iFTQIv7LoHKeZggbDmdoH76R1fikzqr8ZpgoXo9hzzI/Sf3yoJ0JR0zTxTdcU+WEui3++GxofpYPEA3r6Dh95X/RJ06XlOMlvLLe9hTNE4TZZaCDJ0OwEbB/+XBq0umO+zl+eLdPFM2MUDxI2K9t9Xjx+rkBP5jff3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9759
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 569e0bef-a862-4d8d-1f03-08deaa7e637d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|14060799003|35042699022|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: eaH075CxAGDOzYKNCmX547kfeGtPYFRam7UfrJ8jacKdi0Va/8jPDyF7t+NHP33OpEhUekRGJT4eJXj/HMTKjZh/Cq8CCddYVr4L1AF5uGnvZ8d/19bDOw+HKUQVDhcBdmkydG/suQYzWEqsSvSgRkNbTX1qx25of7fHLv82u0xTMnaEy/rhXrxDA9TpJcxcsMFD5tazOxOEyakwQ0QwKf2CiOfMOSPVwKhPywbP0p9JmeIq2rdtjOpCAec4+ExJO4CmwHjRwknBKUzyiROLtsFJEEM8UIW+HmtrixcyGSrgOXxdbpHaPva7+Wo3ypRjig0UV2AucImb2K+y16ft8td3tnzw38GWvK20zbfCPo7b/CEuekO/ShJIK8G6fHwzTtq6+U0tOlnqprmptaNjbQSWkAD9hA+cBXQpgENlEJxg5i0Ps5l65qXDTpgEUlCXX4BpohkC132E8kjKgicYuSWRbFT3cJJ1MY8o3YuLCCuvaXPn13HB2auDAAnY5S9lUxwDZa+a+qtg3oJyMsUigddLwFPKgWUn8J2QqRiWTdAJYTv4g7GptVeEUeusMJCsc4heb7sbjh2nCSGITkNFg6bboRTfWrvIv7gh/EDxTVqEszchpWq4h2y6ZWIThCtoUZz1ShlIJ3V36EiuTq4jAu+dvmrsWgbnXNsCOKU1gj+BNYFMacfen65kzyrSUcusKLfPPFX45ffOwop7W7HY73yW/3GkbGXEohts8sLxcg8=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(14060799003)(35042699022)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9UNQ7hRolyrQoB5cwywZmnzQFvlJBxaSMRy0Hq9yFMqIxVgyYEibQ444bP+JbGnvKGfX10xOplovWNb2/AkhRLTi4frUErn3hajlbhTojNVmAIqfFaIMMF4HFMp9k8bq/Qd0V1BNc/9IGB4hl6Dz+B1E/YrPBsOFX/fhlczHd7WDk6IcGsNpTPF8+lki0unSqWN+QB7uB3tzKDTIdDVQ5wVR5YPMg4qr7VMFiVZqhTPAPIKVFWBtMEbZvk6e8eC4mp8Pjf/zEjYc1mg2bJ4qZTjVSGhytWVYu9E3iwHqx5dUKYnBEbO9L84gT78eZI26MsNuIEozj+4yNMnpx+DQYLLoBMjRe26kS935D7wYQBOo2IVtSd0NZBOMbIPGb0MW31muJUUS4qBc3+juSf6/t4TqWLLQ5jNXFSsda0cUeVbtA2oJDryOV91Eta6QvOVE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:15:58.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1e116e-f60b-4a86-4c39-08deaa7e8967
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10300
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

On Wed, Apr 29, 2026 at 07:32:17PM +0100, Adri�n Larumbe wrote:
> @@ -1651,6 +1715,13 @@ int panthor_vm_pool_create(struct panthor_file *pfile)
>  		return -ENOMEM;
>  
>  	xa_init_flags(&pfile->vms->xa, XA_FLAGS_ALLOC1);
> +
> +	pfile->vms->dummy = panthor_dummy_bo_create(pfile->ptdev);
> +	if (IS_ERR(pfile->vms->dummy)) {
> +		kfree(pfile->vms);
> +		return PTR_ERR(pfile->vms->dummy);

This is use-after-free.

> +	}
> +
>  	return 0;
>  }
