Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED9D103E191
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CA710E7A8;
	Wed, 18 Mar 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JoHN3m3e";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JoHN3m3e";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CACE10E048
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:52:34 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O1Wml1mfiOnbKcVzRRx7+TQJ+ij7nZEkw8y2E6rQjY/JW418urtjJCqutKYc0KTDuElHMV8GEoGEUr4YcpHafDM6X1sFOEDbzo2Lokfj704r7C5lzJAXRKG9VupLoRwAhdfRaVDZVEG7e2GxOt9PY4eR5FCjALHEwf9UGPo4g6PfFbcR7/LDV7iNMuH8Qwcm3PUaK1TKL6Q67XJbWrNx4cwnpHdfh3XqTzeq/lR/om8guLRsz84UVu+5dy6NQ+MJiwnope+nv14ZIXkbQmna8Ww13BxLWPp/nXISZSecPN0ELcToKOjSIrZvNlWiLQSIeJAeeMKzMvANioHajFBa8g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5PVyDl/5PboisyH+lYaFsrPAn0bsP21C3aKFQiIKzE=;
 b=QrV4sxd4tqYXD0L38Y09kVZDQHm5lFz7crQ3aeoYXhQh+esgKfnklERaL6r8CUPSThNo6GlyYLBR0UChXH/rYXiGcDn7avTrfB5yeZBcZCkJGBXYh+HFEGZVSC5iGm6pEUs1Zrl6GDIN+lx0FnDH9RjW8jC+72XjCHUMkjzXe8EPR0YazZEYWi3/t/+UbI/o5LQjytuA3ToJ+167ymENShsT+ozhEHDMQM67l/cHAajzBEkDrd+dO5Za1ZlezXoOAkKqqUrdcmojqSYzEN4/Fo1a/Z9czGwuO9175XIBj3JgPmuiFSSkdAd1DK1v7AVtiIFWEH6gQk7npq82t5F99g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5PVyDl/5PboisyH+lYaFsrPAn0bsP21C3aKFQiIKzE=;
 b=JoHN3m3ehGPnVXUeDdBLmHMQCv2VvH49pxUWBxH7EsE4xD1+ELr6rwpG5xJFVGwRT3UyOcnkxQOwcsOnRtDyNLnJ6dj/EmVloQZ7AJy616bxOZjjCpM8/T9Usy4pDbn6TFu/9hXsoo3aY6UqwVJGvDps9ZCixOzQ8gNSKgq0o0M=
Received: from DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) by DU0PR08MB8186.eurprd08.prod.outlook.com
 (2603:10a6:10:3ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:52:30 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::a7) by DUZPR01CA0032.outlook.office365.com
 (2603:10a6:10:468::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Wed, 18 Mar 2026 14:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBFj8pyN+W0nNkHA03LHwsI5GL2Y+zwl7Eo3CPL4dEeyf/NZVlWl3FPPcIOLUJmUfmCRxGhlgT6giC3Y1Xzy87Amtu0rldperMxGh61mIFztANNds3RwBRcVcm8J873RA1gSRQ292iAyizOpzL4y4rpWKa5oJGS0g55/8JX/uMegVtvS+Z/xcvZgS1pTZyfb98+HypBU8qVJl0MzFvQDvBFChF+9gg6cDCC3XDR/h1IY2i14+ADgrdELrPo6WFQg6YuBr9g7Q8kv/laOMCBZ+KjDuPAYW/WIJCb/BPABEFwJf+ON4XQkgz7lCpQHmj/WmhSPk1IB6cEwdlRknkgTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5PVyDl/5PboisyH+lYaFsrPAn0bsP21C3aKFQiIKzE=;
 b=gnVDVrq23vTJpApYwhE/DEwNXGlTr5D2eojQf7W15PLxTpCeIxmqWBaB9xC5fPonvOH/U9edy8JoXVDHBLZBC7SpoTAddfMc9xitiHutNbuLYlykfRt9BnnH2NCsiySWloY7hF1k3Qlt4xjA9ntSXOZCoFVgwoQKxohVxvl9sIhkqmvT0BIhyLAVko7z0BIF5pr4iO55ITjKCQ7EERWeq84gqQn6df1o27oBm3QcRzYEOjTZowZ9RoZTJOrQs/qn9D9alnw3yHNSRbFAiCoH2GbVN1UN2RkcefywXFzIMC+LUeZQMf2lAxR0zYQGzKGh0NnGENm6wWa6LVahzvVy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5PVyDl/5PboisyH+lYaFsrPAn0bsP21C3aKFQiIKzE=;
 b=JoHN3m3ehGPnVXUeDdBLmHMQCv2VvH49pxUWBxH7EsE4xD1+ELr6rwpG5xJFVGwRT3UyOcnkxQOwcsOnRtDyNLnJ6dj/EmVloQZ7AJy616bxOZjjCpM8/T9Usy4pDbn6TFu/9hXsoo3aY6UqwVJGvDps9ZCixOzQ8gNSKgq0o0M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by DBBPR08MB6284.eurprd08.prod.outlook.com (2603:10a6:10:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:51:27 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 14:51:27 +0000
Date: Wed, 18 Mar 2026 15:51:16 +0100
From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH] drm/panthor: extend timestamp query with flags
Message-ID: <abq75MJM5n-U33Fl@e129842.arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260318131030.4ae7f820@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318131030.4ae7f820@fedora>
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|DBBPR08MB6284:EE_|DU2PEPF00028D0E:EE_|DU0PR08MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eebb579-e06a-4486-1173-08de84fdfad1
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: JwrsYAMEf+CUiAiaiPh83x6ny8rESRQqj1rPNhsVJGfreSqD0LTDZWmDBHAT5h7p2R+JIxpus+ufyMAGGhmUg80BnxnvaQjHe3DfOzxqxX1t656JEc7yz4YgLbZrOEZ6K2wJ3AF2pC11Qew7Jg6nScSgxNxU1EYpTOUsQgpi7tC6HqJS149j4DwMLrg0UE8zFQ13040XW5/22bZhDz+/HWr4PN7MCPmg00a+tsB6QHLJRulG1Okhd7avYwEPRBu1NnfvRy+q1pPH8E6nauY0bXAwyTAYT4ACK2+AC7sFpYpgPE3hHMAtS36he8RZdZLxL3GTT1vpStHAABu2FhYWnGSPENCSjeGDJB/LQ8BGY4WZjZsgfPFU+jldcX+CHzJQ5Dmz6EBvmmhOsSfCBadKqp/Bhg8GVe87Hp/kbWyEQ+00cVUDApGwXKEzxUgzwQwyM1+tW0ezHGtLzx6I0F5Zx+icncqNDMVeiJtr7kUmpzufOSqlidrIWEDQ7It4XVnd3Kn6FozauxNn7fMFltB2jIysdEafaylFdx6jUPjszT/qKuxe3mshzX/g7yXYrHi7dXT5Kyg4IDBE3nTXrGDQJD3+hXhrYxExiJqAoNgOdfAKOAXjKl/i65pVoTjDh6pRe2hvY3D8cDcOND4+pQLP4hc5KuGlVydrQHkTt+48W7nq9C2GA9KUEqwEvr5l5qaV1HVJOAhdPyOps30hz7t9qQ9ZHKX3GhsZuNIRk0toLaY=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: FsIUzCzjcM0sIRPqKoqAfQpX0pW52R82KHBe79DRvyaf5NQzHI9lZgmpqv25HmUTQ3G7jo1TWWiA5FerMaIAqbAh5VAVOtmMgnLHAZyL7HFX1A00+7GyDPyFDhvGqhBQn2I0YeYSO5xYVffelXv5EQprn0rmBttxg3WNunE+5zYoT14V3oKgAphW3MnG38gv1YNCET2kvqBLtcw4WfUhs5xOp4yIH7ArlL1UHxas1wYxTxS55JiWJDoEF4+lR47Gzc4FIoJVdhvMZxt5JyVD8OBAUqeGO8ahZAQb4veny4JdqNz4BidGcmS3syNKXiCxKEGMPGeolF0DvozX30WYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6284
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b8fd99cc-40a7-4cc5-8930-08de84fdd507
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|14060799003|35042699022|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZTzKM55zrUThyhxIbdishcZsdmZnFXQjwA4OHRX5p7XV+3bwXf7u9AkSkft/CfKVmJZdDKj4Txlw9gXEeZ/nS6jFxcpwwiY7d51QgLmoFFpqKT+z/Nhcu4BEIPzTatBF3IgxirA+05caqXBVEzWpOIfaylDE6aJzj/SeCkUrLMTGJJWUi9JG3l7G8lY3f/ztQzAUiFxJX3TP3Vp0sNvtpCYKEVedTC0Xq4eHHW+2/jQMVJFBI6wd2oGU4V7kFv5/ToVDqOS7d07GEZYt7SXeJ9zl8zMsEjW0Zrn2LQrpdrVjLwTdzUq1m+vdmBrvFs65LYHa7J4YEz03/Q4QtmgCjbDP9foG9a2vvkrAyy36Kc3lo+YUj5LnsLS8+/w3rGj5o4X9TKQLiM73A95hdJzKuhAPjM2/gDwNJVt4j/yO0VdWmF/aRvHladu3AgNnl/zd14pLCEt4T4gP0np0RLcG32CQYxEHpH6s0jmhlk9I3uduJNX7nu/vg+tkbTQjje09D/onikT7fZozscEXdlc16XfYPd1A81lSdzVx4LBkizLNj/ReTZp8UdbW6rpk4meyLixNJgVx5kX5voQD91quBrhk3lbwuAbwNu8wOdvYo3mE3VHiv4SFvQWSJ4Zki3TYxm/HYDLwHp0zpwNZh13Pr1Md4kc/av6NV7faGpDj5PfVHOXEGlPtRTjVEZFW+vG9KOjY/MM/sa5WB6uNUq2RymbckSRJbisK9ohqfFey3L+JSwtCBrsW1LdjAbRwObrqCtd9iDAWyt70SlPtFvSbuA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(14060799003)(35042699022)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Dn4HN/IjwH6bOwRmjNPHqoR2qys1fE/WQ9A/spiKr2Xv8/2bg/QaGoRwOUhT49knU6d0PAGX0beuGBiEDhNfe/NDit1+5IqemeodC+QncPH9jse4emQL2biqCY9GrmfNhmF3rZAtpso/6Q9AWXrSra73SHy6MT2Zhq9aQ2hRXP9zPzbM1y4trQ99SrZmm4h+6JMs01jx8Zlnu5uB55JIYnv3j1nGyuPBxsJSt476IMGdV48ND7dRYHFHaRK/Y7Uair61lk6ihsS3rk1DMKQxFdnLYnsRhxA/EzhqP93jIS3mTObr+TIjc6J71TcaBP1dqcKrGBYNusa6uA80Vr922psTOxkF36IrJ5cb7m55bq5Pph6E1obSWwV+61aNaJs04wvZGZIb+eXbQLS7GvVWDo1UJicHKwWJdNbFlA82fhemF4S0fRrA6ynBXopht31
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:52:30.1653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eebb579-e06a-4486-1173-08de84fdfad1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8186
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

On Wed, Mar 18, 2026 at 01:10:30PM +0100, Boris Brezillon wrote:
> On Wed, 18 Mar 2026 12:29:52 +0100
> Marcin Slusarz <marcin.slusarz@arm.com> wrote:
> 
> > Flags now control which data user space wants to query,
> > there is more information sources, and there's ability
> > to query duration of multiple timestamp reads.
> > 
> > New sources:
> > - CPU's monotonic,
> > - CPU's monotonic raw,
> > - GPU's cycle count
> > 
> > These changes should make the implementation of
> > VK_KHR_calibrated_timestamps more accurate and much simpler.
> > 
> > Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
> > ---
> > This is counter proposal to https://lore.kernel.org/all/20250916200751.3999354-1-olvaffe@gmail.com/
> > ---
> >  drivers/gpu/drm/panthor/panthor_drv.c | 124 ++++++++++++++++++++++++--
> >  include/uapi/drm/panthor_drm.h        |  51 ++++++++++-
> >  2 files changed, 166 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> > index 165dddfde6ca..19ede20a578e 100644
> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> > @@ -13,7 +13,9 @@
> >  #include <linux/pagemap.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/sched/clock.h>
> >  #include <linux/time64.h>
> > +#include <linux/time_namespace.h>
> >  
> >  #include <drm/drm_auth.h>
> >  #include <drm/drm_debugfs.h>
> > @@ -762,21 +764,123 @@ static void panthor_submit_ctx_cleanup(struct panthor_submit_ctx *ctx,
> >  }
> >  
> >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > -					struct drm_panthor_timestamp_info *arg)
> > +					struct drm_panthor_timestamp_info *arg,
> > +					u32 size)
> >  {
> >  	int ret;
> > +	u32 flags;
> > +	unsigned long irq_flags;
> > +	struct timespec64 cpu_ts;
> > +	u64 query_start_time;
> > +	bool minimize_interruption;
> > +	u32 timestamp_types = 0;
> > +
> > +	if (size >= offsetof(struct drm_panthor_timestamp_info, pad1) + sizeof(arg->pad1) &&
> > +			arg->pad1 != 0)
> > +		return -EINVAL;
> > +
> > +	if (size >= offsetof(struct drm_panthor_timestamp_info, flags) + sizeof(arg->flags))
> > +		flags = arg->flags;
> > +	else
> > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> 
> How about we add a DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY flag that tells
> the driver whether the default should be picked or not instead of this
> weird is-this-the-new-or-old-struct detection based on the size.

Well, as is, we would read uninitialized data from kernel stack if
user passed old struct with the original size. It's fixable, but
I'm not sure why you think checking size to detect the use of new
interface is weird. I thought it's a pretty standard thing.

If the conclusion will be that checking size must be dropped, then
I think looking at flags being non-zero would be enough - there's
no need for new special flag that says other bits mean something.

> 	if (args->flags & DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY)
> 		flags = args->flags;
> 	else
> 		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> 			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> 			DRM_PANTHOR_TIMESTAMP_FREQ;
> 
> > +
> > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > +	case 0:
> > +		break;
> > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > +		timestamp_types++;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (flags & ~(DRM_PANTHOR_TIMESTAMP_GPU |
> > +		      DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK |
> > +		      DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > +		      DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT |
> > +		      DRM_PANTHOR_TIMESTAMP_FREQ |
> > +		      DRM_PANTHOR_TIMESTAMP_DURATION))
> > +		return -EINVAL;
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > +		timestamp_types++;
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > +		timestamp_types++;
> > +
> > +	minimize_interruption =
> > +		(flags & DRM_PANTHOR_TIMESTAMP_DURATION) ||
> > +		(timestamp_types >= 2);
> 
> It's probably worth a comment explaining where the >= 2 comes from
> and why query duration measurement needs to be done with interrupts
> disabled (though the latter is a bit more obvious than the former).

ack

> >  
> >  	ret = panthor_device_resume_and_get(ptdev);
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_FREQ) {
> >  #ifdef CONFIG_ARM_ARCH_TIMER
> > -	arg->timestamp_frequency = arch_timer_get_cntfrq();
> > +		arg->timestamp_frequency = arch_timer_get_cntfrq();
> >  #else
> > -	arg->timestamp_frequency = 0;
> > +		arg->timestamp_frequency = 0;
> >  #endif
> > -	arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
> > -	arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
> > +	} else {
> > +		arg->timestamp_frequency = 0;
> > +	}
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
> > +		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
> > +	else
> > +		arg->timestamp_offset = 0;
> > +
> > +	if (minimize_interruption) {
> > +		preempt_disable();
> > +		local_irq_save(irq_flags);
> > +	}
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
> > +		query_start_time = local_clock();
> > +	else
> > +		query_start_time = 0;
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > +		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
> > +	else
> > +		arg->current_timestamp = 0;
> > +
> > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > +		ktime_get_ts64(&cpu_ts);
> > +		break;
> > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > +		ktime_get_raw_ts64(&cpu_ts);
> > +		break;
> 
> 	default:
> 		break;

ack

> > +	}
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > +		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
> > +	else
> > +		arg->cycle_count = 0;
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_DURATION)
> > +		arg->duration_nsec = local_clock() - query_start_time;
> > +	else
> > +		arg->duration_nsec = 0;
> > +
> > +	if (minimize_interruption) {
> > +		local_irq_restore(irq_flags);
> > +		preempt_enable();
> > +	}
> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > +		timens_add_monotonic(&cpu_ts);
> > +
> > +		arg->cpu_timestamp_sec = cpu_ts.tv_sec;
> > +		arg->cpu_timestamp_nsec = cpu_ts.tv_nsec;
> > +	} else {
> > +		arg->cpu_timestamp_sec = 0;
> > +		arg->cpu_timestamp_nsec = 0;
> > +	}
> >  
> >  	pm_runtime_put(ptdev->base.dev);
> >  	return 0;
> > @@ -851,7 +955,12 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
> >  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
> >  
> >  	case DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO:
> > -		ret = panthor_query_timestamp_info(ptdev, &timestamp_info);
> > +		if (copy_from_user(&timestamp_info,
> > +				   (const void __user __force *) args->pointer,
> > +				   args->size))

Umm, now I see that I forgot to explicitly validate args->size. It's done
inside of copy_from_user, but it relies on __builtin_object_size doing
the right thing. Will do that in v2.

> > +			return -EFAULT;
> > +
> > +		ret = panthor_query_timestamp_info(ptdev, &timestamp_info, args->size);
> >  
> 
> nit: drop the blank line.

ack

> >  		if (ret)
> >  			return ret;
> > @@ -1680,6 +1789,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
> >   *       - adds DRM_IOCTL_PANTHOR_BO_SYNC ioctl
> >   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
> >   *       - adds drm_panthor_gpu_info::selected_coherency
> > + * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
> >   */
> >  static const struct drm_driver panthor_drm_driver = {
> >  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> > @@ -1693,7 +1803,7 @@ static const struct drm_driver panthor_drm_driver = {
> >  	.name = "panthor",
> >  	.desc = "Panthor DRM driver",
> >  	.major = 1,
> > -	.minor = 7,
> > +	.minor = 8,
> >  
> >  	.gem_create_object = panthor_gem_create_object,
> >  	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
> > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > index b401ac585d6a..c869e8b95ecd 100644
> > --- a/include/uapi/drm/panthor_drm.h
> > +++ b/include/uapi/drm/panthor_drm.h
> > @@ -409,6 +409,35 @@ struct drm_panthor_csif_info {
> >  	__u32 pad;
> >  };
> >  
> > +/**
> > + * enum drm_panthor_timestamp_info_flags - drm_panthor_timestamp_info.flags
> > + */
> > +enum drm_panthor_timestamp_info_flags {
> > +	/** @DRM_PANTHOR_TIMESTAMP_GPU: Query GPU time. */
> > +	DRM_PANTHOR_TIMESTAMP_GPU = 1 << 0,
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC: Query CPU time using CLOCK_MONOTONIC. */
> > +	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC = 1 << 1,
> 
> Can we define
> 
> 	DRM_PANTHOR_TIMESTAMP_CPU_NONE = 0 << 1,
> 
> for completeness.

Yeah, good idea.

> 
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW: Query CPU time using CLOCK_MONOTONIC_RAW. */
> > +	DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW = 2 << 1,
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK: Space reserved for CPU clock type. */
> > +	DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK = 7 << 1,
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_GPU_OFFSET: Query GPU offset. */
> > +	DRM_PANTHOR_TIMESTAMP_GPU_OFFSET = 1 << 4,
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT: Query GPU cycle count. */
> > +	DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT = 1 << 5,
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_FREQ: Query timestamp frequency. */
> > +	DRM_PANTHOR_TIMESTAMP_FREQ = 1 << 6,
> > +
> > +	/** @DRM_PANTHOR_TIMESTAMP_DURATION: Return duration of time query. */
> > +	DRM_PANTHOR_TIMESTAMP_DURATION = 1 << 7,
> 
> 	/**
> 	 * @DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY: Advanced query requested.
> 	 *
> 	 * When missing, flags should be 0, which is equivalent to
> 	 *  DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY |
> 	 *  DRM_PANTHOR_TIMESTAMP_GPU |
> 	 *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> 	 *  DRM_PANTHOR_TIMESTAMP_FREQ
> 	 */
> 	DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY = 1 << 30,
> 
> > +};
> > +
> >  /**
> >   * struct drm_panthor_timestamp_info - Timestamp information
> >   *
> > @@ -421,11 +450,29 @@ struct drm_panthor_timestamp_info {
> >  	 */
> >  	__u64 timestamp_frequency;
> >  
> > -	/** @current_timestamp: The current timestamp. */
> > +	/** @current_timestamp: The current GPU timestamp. */
> >  	__u64 current_timestamp;
> >  
> > -	/** @timestamp_offset: The offset of the timestamp timer. */
> > +	/** @timestamp_offset: The offset of the GPU timestamp timer. */
> >  	__u64 timestamp_offset;
> > +
> > +	/** @flags: Bitmask of drm_panthor_timestamp_info_flags. */
> > +	__u32 flags;
> > +
> > +	/** @duration_nsec: Duration of time query. */
> > +	__u32 duration_nsec;
> > +
> > +	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
> > +	__u64 cycle_count;
> > +
> > +	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
> > +	__u64 cpu_timestamp_sec;
> > +
> > +	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
> > +	__u32 cpu_timestamp_nsec;
> > +
> > +	/** @pad1: Padding, MBZ. */
> > +	__u32 pad1;
> 
> Let's re-purpose the existing pad field into flags, move duration_nsec after
> cpu_timestamp_nsec, and get rid of this pad1.

I'm not sure I understand. Do you want me to extend flags to u64?
What's the point of that?

> 
> >  };
> >  
> >  /**
> 
