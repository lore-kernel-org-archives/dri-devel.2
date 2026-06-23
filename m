Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A256CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BFD10EB38;
	Tue, 23 Jun 2026 13:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HxpBy6LJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HxpBy6LJ";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013045.outbound.protection.outlook.com
 [52.101.83.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1933F10EB38
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:02:38 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tjotaAGY232k9PWA0rzN6CN1+w9FqowR0xE9QKLReJbHAb5DXO4jf7tWaAGPY2vzlFGIOBNv2jGjsmEXrb2sR599gcM0Lx1zvkyyPS7wL1Knned+LIFYckxEqBGiM2ee3lwMSpR57CquSI8qslzo/hFO9CFRnLYNmV7HUY50LYgH+EkVs1rRoV7/xzuwKCzevDlxs8SMJ3iT1p2tCzNCB+xreN6E9B8zcfwCzjhwfqXh78mueji7t/WwgEVY7g/ao4F9KZFn8CtY5DEmgMAGO599mhLy20D90i/3MPd6j1Y9vuGA8jq+L4avxchWc3kO9GLb0Pl2F22a3z5okh17Kw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQjGRPs5TQ//x/BAvWysdUrwwfneD1MWhs8411QfuJ0=;
 b=LQ+S2tf4JHHg/QTnKRQX+7gOPxW/VmYT0fcjM7U4EUVDKaWFgkoReOL0FCt+9cNLknk1u4F+kWr0Jw05CPW9tVP5XhuofVITvPVb4mnUgWwLh4M6CKD/oklDNhTNFot4WobXDGcAbRXrCFeWyF660ssiXIglvG7ELMYA7sB5bQcN8SDLRsqY7/SgIoBkiYonj75+UxsO8Ku1Qku3FgcPaIPedKTly3ZuEDwIfU71q7QOLP5Lz2cBVJJ8tDTgm7VhMSJsA8m5pGIhkOAlw/CCvgcmY9O/PE4qdUlCwJKjK3QtQb0p9DjFX/+1ETsCOCx/9A15jvFaWtHeBU+N0XF+4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQjGRPs5TQ//x/BAvWysdUrwwfneD1MWhs8411QfuJ0=;
 b=HxpBy6LJnnw5meKQPIp9Zc+tjlUdx5BHbkCyfSFA2Aapd8S71ve8pqNOJ0VGVgfUoEeNqJ2RPT7Bj8oAVV3cj02ppoRxE2Qc/KESvW1EXXbknmAvjG1r9XL76omq1ueCO5nkDwrLNYaJmkz1VoX8woQ5v4b6AksbqqCRxDQTyyY=
Received: from DU7P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::22)
 by AM0PR08MB11736.eurprd08.prod.outlook.com (2603:10a6:20b:73e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:02:33 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::7a) by DU7P191CA0022.outlook.office365.com
 (2603:10a6:10:54e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Tue,
 23 Jun 2026 13:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 13:02:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6ipl7t2Nd64iknZdIhCkimmjMqLG0U/EeNOhjclfOF9j+1/f/bHUv9OQ1jyzpf2hIkxrfTaXSbnSCzEM/jkSc8GaqsKUp12cnRJeC7dRT21z+BSTtQq/yrCmZYUyUeYT5FEr+9UndrOYYhN5OHtPL52Bx5XIMcLLBjX2ByLWpb+1NwSPC6suXgiYc4wEZlLtfrm2G7tD+FgFKvtDDHMCIDa88HFkxNTmT1g7rrRmLLCyfy4SN0+aft7vOQi35MEC9GbO53IkJG2a9eRcpbop+kDsJVTeeYEGa1SpCitfjlkmqZQ/HM9qrADkOv06ogltUqtkodRaym0s6xWqnekSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQjGRPs5TQ//x/BAvWysdUrwwfneD1MWhs8411QfuJ0=;
 b=b+NPRDMLIG/KvPmaQIqMORmwBsaSoVAKUN5/3zyKhEQ6aDzXxEfAI9JtPQmE7Alrn6Qw4TYzH251fxJbkn1MEuqBuKmfPxa9m1FgwzLjJj64C51i9WF4llTSKS3trk6VdBYEcLH94yoU8aSrZc8R0eHGoCBq02+LiIakdKEWRLBma9dRTvMz7n0d7t8NCBoSVF6r/QWF9rAJVTLq/soOcCr6zTDMLQB88z53FS0Q/hucnm/lmVV2KQxzDEeIYY3CGENxzDUh+N1rIJyOjsEKnj5MkiJPZJEX2C50Uxri5byyD+1naJOvuvgePgRoZnieI0Mxhfv8FjMmlzTp/DkG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQjGRPs5TQ//x/BAvWysdUrwwfneD1MWhs8411QfuJ0=;
 b=HxpBy6LJnnw5meKQPIp9Zc+tjlUdx5BHbkCyfSFA2Aapd8S71ve8pqNOJ0VGVgfUoEeNqJ2RPT7Bj8oAVV3cj02ppoRxE2Qc/KESvW1EXXbknmAvjG1r9XL76omq1ueCO5nkDwrLNYaJmkz1VoX8woQ5v4b6AksbqqCRxDQTyyY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by AS8PR08MB8181.eurprd08.prod.outlook.com (2603:10a6:20b:54e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:01:26 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:01:26 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com, liviu.dudau@arm.com, steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
Subject: [PATCH v2] drm/panthor: Fix NPD issue on partial unmap of an evicted
 BO
Date: Tue, 23 Jun 2026 14:01:19 +0100
Message-Id: <20260623130119.2737003-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0139.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::18) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|AS8PR08MB8181:EE_|DB1PEPF000509F8:EE_|AM0PR08MB11736:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c92c86-e7ea-4e48-de83-08ded127b018
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info-Original: mbTCivSRziJ5fWjkj3X1BHHb2wkS7BKRtZxC/37BWPFkH/Gfw9X9SPs8z8pKVFkfWT799iTP+r0ybg3L9TNWFpa/zM9YC18DlodFSSDBcRJaxpIW76YRthtzwlenXEEHB+8j1FzlPlbNTJc9P5/NKwXoQBPnWELkIkLjg0Jir5ccr3A9mv8Tym3koBEOHPEJXUUrEbxSU8pRUtG/+wXpKyfL3QpUUAlbemAu7rf7SJ0jeqCXd4fKzsKo0fnU7vfGUSPphdLuw6z0a3+mYOlrVqR61Hag8hF7wt9ZOgmv+Zp9WWEerCTZK7CMxzmMm4PA5I9Gkb4ZTIw6pfq+8k3lA59CJteMFLfWigNvFnVJizzKX9AXrCJ0LOvio2CXVsgHGQ5NVgaxjkZgU9eB30NXBxqtgS15sDpw1ZTTelLH10wcH8LNm/9667XovyRnEmslikiVEFlbqh5lYDk6gp17CBbyT2cBbGu4dkSq8mcabot0SNipnnx8ZGscSP3Fu8D6HIn85tGQsHt4Q9KiKJ5cS4aHPJzXj6TFX3XkQGnsK/hy1h8OYMj7YEaz6twzKi97DksDJ47IWms3Sjt4PB8Xmv0F7CG5Sgkx1A4g7KuKkLUOasNIlHGmexsMCdsj4EW76yqyQTI57MDsNrRX7QnrDLMjA/wRzrcJ5F2Zy1ZRDR0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(6133799003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: XJ/999+4xLs6qOMQUwc4s/TaZA2hcZa+hGsSfH52TmPnm3YXNeavgvN2HbM+IP6LNyJPmVbaJKu1jW/ei6VRSQ6I13VdypyoF+U8ld8XLO21IMyNVHGlzlKC3XkbreChikunq9a+CKbezXIvLMo3i+E5MM0mVBiNku6+gTdvlCFQzSwUnlj8g7EeDuoZz2eYljD6YO0aDYPtdSCiHqN9BAZCJgGVZBp+LVU/2N0gp0TyI2dANvL7sXjMtngMiLK/K0l9/gcKftmy+Mj0TQjiyTKW4CPLM161o4+DS7N7dxc5FgyaauzqJZGywdA+1C/hLVKz6YfN5ulsXuBIn38OCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8181
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4831dc24-adab-40ff-85aa-08ded12788b5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|1800799024|36860700016|376014|35042699022|23010399003|18002099003|56012099006|5023799004|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: E+lK5e0hLhnwIMg1g26qQADoOtg4LwV5W/E3QfJY91uChvo1ilAScIBa2crGEmbjjivcEM3/6toB/QwdvX/6L5wfy2HSV9soMZdq1wg4Hc0YQ+7ov79lIJIzIWuj4g1/LaBcmZ0fuO5HueJMziuyWp5tI+S8B0JIX+Q2mtUEVz9dCufD82UBkfC2GQ6oNLNI0OMvP6v/2BtOuzxFSAXFq6FaoJFK2ouxL3yFDrY8pLoROLf23WZY4gSmNPVLpkKLve9CG7m4UrD1/UjVG5+z8esy/IvJAlx3BJId8N9HXFs9k577Sc7144W/mh04MhdgdXLt4ie24t2+vnJfVQYOF3N9e5lIZkc4X17xPAe2tt10XxWx/SHtFjZqvuyaPuW/DbbBrepDFZFoUpGveWhh5djjO5piExCImxVz39Sja+GRk8QwI6E7ep6tsSck3dfLbfF1MEbJO2MmFGGS8xGPOL2rBAY9NJhXB7q4GV2jBtQSPZ2fhlsC9gl1mVX7C9YxWc/S2CveJ6RMv0DqEXvgh/L0Vh5EOPKkuMl+N8BGKLT28K4KOc7d6TK0CPT+3KjzmJ4bV9foOJFQpF5cZ6q2b3IOcp5lZavB1Lz5fiN+OvsUEX20jFi1Op/bwGASBD/B+LAXJkGGwWRYDHpzqAMyTakS7/zSgaOEZIHlj3UMtroCvPEXX5P7hp19+aPUzyh3K6o3bRFXdb5q0JwnIyfFhw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(1800799024)(36860700016)(376014)(35042699022)(23010399003)(18002099003)(56012099006)(5023799004)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4BC6XjsLhpXiTZHxD+tzw2KUslAFS/FNhcb8xey4Cdc+pTAu+rNygyIzOpAJM4z/WptnjvizvH6YQCAMZDWSFxqnAxztp5MCqUX6EEC9glXPKfE7BWn40mkHV4/XHli2H07LJC4LY8CRDON9S/vZSn8aUuCjnkykTn4Vc2SGQsL6vrGqs0fkKlXkTT7LNqMX16kBar0IyWwQoprbWYAL0Nj3BoDd88+AemXwXTMdUJxO9n5910nVWPe9YxrWwFx0q/aXYZPKrN89kEx2/uP32d2nOXYL+DqD4UNuwKQqiy7Pk915iXtWlXFjaj85yY4IPWPUF8fsWvW8j3nRDGa+qCKH6ODANAcrymJC09u3aZe9Zgm9n+jQ72u9WHGiIm5Q1+oweJZGVXfOWAqHsxj0Q8Sj0MJGrl47aaY3vRwHX20unx14Aq0ddlvnDKtA2sWY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:02:32.0477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c92c86-e7ea-4e48-de83-08ded127b018
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11736
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

This commit fixes the NULL pointer dereference issue that would have
happened on the split of GPU mapping due to partial unmap of an evicted
BO. There is a logic to handle the partial unmap of huge pages when the
GPU mapping is split. That logic was not being completely skipped for
the VMA of an evicted BO and that resulted in a NPD possibility for the
'bo->backing.pages' pointer, which is set to NULL when pages of a
BO are released on eviction.

Following dump was seen when a partial unmap was exercised for an
evicted BO.
Unable to handle kernel paging request at virtual address 0000000000002000
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000008842e8000
[0000000000002000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
<snip>
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : iova_mapped_as_huge_page+0x20/0x68 [panthor]
lr : panthor_gpuva_sm_step_remap+0x39c/0x498 [panthor]
sp : ffff800086193920
x29: ffff800086193920 x28: ffff800086193a18 x27: ffff800086193b80
x26: 0000000000400000 x25: 0000000000810000 x24: 0000000000400000
x23: ffff000808af1800 x22: 0000000000a00000 x21: ffff800086193a00
x20: ffff000806fd3f00 x19: 0000000000410000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800083ce2d83
x14: 0000000000000000 x13: 3120646574636976 x12: 6520303030303138
x11: 2d30303030313420 x10: ffff8000836e6c80 x9 : ffff80007bfc889c
x8 : 3fffffffffffefff x7 : ffff8000836e6c80 x6 : 0000000000000000
x5 : ffff00097ef19088 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000010000 x1 : 0000000000000400 x0 : 0000000000000000
Call trace:
 iova_mapped_as_huge_page+0x20/0x68 [panthor] (P)
 op_remap_cb.isra.0+0x70/0xb0
 __drm_gpuvm_sm_unmap+0xf8/0x1c0
 drm_gpuvm_sm_unmap+0x40/0x60
 panthor_vm_exec_op+0xa0/0x168 [panthor]
 panthor_vm_bind_exec_sync_op+0x8c/0xb8 [panthor]
 panthor_ioctl_vm_bind+0xbc/0x170 [panthor]
 drm_ioctl_kernel+0xc0/0x140
 drm_ioctl+0x20c/0x500
 __arm64_sys_ioctl+0xb4/0x118
 invoke_syscall+0x5c/0x120
 el0_svc_common.constprop.0+0x48/0xf8
 do_el0_svc+0x28/0x40
 el0_svc+0x38/0x128
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x198/0x1a0
Code: 8b030021 cb020021 f940b800 d34cfc21 (f8617801)
---[ end trace 0000000000000000 ]---

v2: Fix indentation

Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
Signed-off-by: Akash Goel <akash.goel@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..7c99cd422add 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	 */
 	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
 
-	/*
-	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
-	 * so when a partial unmap is requested, we must first unmap the entire huge
-	 * page and then remap the difference between the huge page minus the requested
-	 * unmap region. Calculating the right start address and range for the expanded
-	 * unmap operation is the responsibility of the following function.
-	 */
-	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
-
-	/* If the range changed, we might have to lock a wider region to guarantee
-	 * atomicity. panthor_vm_lock_region() bails out early if the new region
-	 * is already part of the locked region, so no need to do this check here.
-	 */
 	if (!unmap_vma->evicted) {
+		/*
+		 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
+		 * so when a partial unmap is requested, we must first unmap the entire huge
+		 * page and then remap the difference between the huge page minus the requested
+		 * unmap region. Calculating the right start address and range for the expanded
+		 * unmap operation is the responsibility of the following function.
+		 */
+		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
+
+		/* If the range changed, we might have to lock a wider region to guarantee
+		 * atomicity. panthor_vm_lock_region() bails out early if the new region
+		 * is already part of the locked region, so no need to do this check here.
+		 */
 		panthor_vm_lock_region(vm, unmap_start, unmap_range);
 		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
 	}
-- 
2.25.1

