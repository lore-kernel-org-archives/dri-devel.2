Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26E7C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 21:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED55E10E4C8;
	Mon, 27 Jul 2026 21:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffBQyM+3";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617A010E4C8;
 Mon, 27 Jul 2026 21:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijA2w6BFngkXt3TGw2ZP9akziyImCoIwlScDMM3RwTVPn+mQuluSEDAeIiijmMXKUeV6Dz6GLimCDnRyS+Rqa4pWCaZoWGjP6+4cT2skttVUmyUrR/dBe2NJFUCli/zngC3uo6hq4WCC7AJknSKgSlkCH1wRY/Z4nqRlJe2dH8hGoC8RZHNeHKTc846jtLQk0tNeQTCzYIJCiZQxwnSm1xA5RX/tnnE2IgypglNp351AyaRnU4mVyQrQmSFe44uKDtitjw44eiP6s5GZkJGz3zkDb+f20uYse3K2ze8U97e/m3rrNK0MBwvComhtelo7UP6263IJw+8yI62036q54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8OO98+aPGNSnyiywJclYh954vipkobr2wv4ccDTAco=;
 b=Ba9CGv/LLQTY+3Nfw4PXaXVxPeaZUL2q5T7imkx0xvlb6B3plWp9NbOa3YdJWqs7kjY6Sm6MD3/UL2MXp1nQlZo6/WUPyLSEanuQFNz/cK3jLtLQ63R3zpzsqTz5lv1Xyc9dQcYL8Dlt0H9JYNjsP0qzSV8SBeZr5I9DQCztwxsq4NomOsHOqvgg3bdXJ4hNa9iPOGsKQybMWzRZ37Q+990MbIdNgECtv4beR563QDRlfu2fC3nada1cqkLqvnDGONzMzmvRszIxY67ga2s7xwQbdcvegymGvVEirAwJEepR4XyIo8P3+WyVW0iJKatWwgD+wt4S5K9/j/duGjCs9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8OO98+aPGNSnyiywJclYh954vipkobr2wv4ccDTAco=;
 b=ffBQyM+3A7Nuxpqc5U6ZHdiMDE4ihcQtMTo3f6dSoR0+yhr5SW3MraaznDGMKAMASgCmhjmP4eWly73DOz6ibxWPPYzHD3tlTpxVTfF8l64wdutvCH+BztqrPHd7ovvRB3WUbUSJkKjOpEMg/J+H2DQkojZ4h1twTufKfP7k/rI=
Received: from BL1P223CA0035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::19)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 21:34:17 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::86) by BL1P223CA0035.outlook.office365.com
 (2603:10b6:208:5b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 21:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 21:34:17 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 16:34:05 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <timo.proemer04@gmail.com>
CC: Fangzhi Zuo <jerry.zuo@amd.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] drm/amd/display: Use drm_edid_block_count()
 instead of raw extensions
Date: Mon, 27 Jul 2026 17:33:05 -0400
Message-ID: <20260727213305.810014-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194945.2AFE11F00A3A@smtp.kernel.org>
References: <20260713193237.2639-1-timo.proemer04@gmail.com>
 <20260713193237.2639-3-timo.proemer04@gmail.com>
 <20260713194945.2AFE11F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 70886c6c-3dd6-4f56-03a0-08deec26cfed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2qDEAOmMqJ/oQY1RSPDn6AyQIwcCnztoxHQ9FEk4PQc3YptfQlMl27l4mhjBeGK25vOQ4/KZxg+0W5tv5dN/lJeh4XL7Kvs0i6YVzaJ+i33t9kQCqTinSpvt1ZHoO5aBLGo+uOBB9sCx0CP2kGXGIxcrrxRA0x4qk1jW6DzkXOe78L3tjGEHZa28a26TUvSTPo16ZEcOxWBtvH9P5QC733vX0m7DA1I/gfPXF3BUY2SRJeTnF6RlxjcxfJGK14/IVSwNm8+KiZZLdyEFHNKO8DhCVL2/nbLQ+uZp+tH+aSdx9iS4f5RxGheGrRePsRA+x0rDmJj0vv40DkjslfFUTlZFYWuLKmE//0D3qYSk+bh6KsHgtK4n9d8ZcyrMq5l4OhMoJoinkWEu71vlUD0ZqCdweEBr5/RvRBx73JojbQ98reSBsc6k/M8CYQ0LwJPXqzZrd0U0WFX2k257ilZHmlNJ3FrygPmZPjGoVPJqOh71s6PgAwzg3cMy4cyc44XDazaQMLmLpelThvQy03ALO4QbteOgL1m91BBOmo3NEY0MyBw/qTu3kytOsZ98aB55ONKi/m4HDg4xtx6dX7hWl+lyaYF3EghGlBhZWmX+y5M6gOjNk1l1yfY1aLspMQRjIiYUj7BpDfrxVkRti4M60cajEu+g0Ix0uonyfv20+d/3SII9sVtXGsudkv6DOd4a80XjKyPonEoB1+MkM8DcTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sF8LcwvBnInIXj5PqOzMZ05IkGE4c3P1HE55gOmWEP3zcn76Chdud3mWRIhAf43HW17vQvyQAj/DRP9v70XzVqPxP/qppalkZvs8Pxc/f66G1HglTlT4gzxxziokf9VXHBjhDqs4YuFKOE0AFa9XmIr0kgLW7hINYedF4WYR0wHJqe+W1boVB9eoOIoiWgvpJAOkYHg74zS45bPWFQ73ZAyDUdJKD3egsQ+rV7fV3LYBxvfhRfpTFZqnkvf76HfSwh1F5LbzsbLLK0E6/TGu3yOPeL7NZNIs3SrhE+dSwHTeOEchTgOY7VLtmHcahErcSIyiZ/irrxRtHN5A+dYiI1cr+m8nnglcUOiU6eBDMweWCU2SufT+4TJDGCpjL8L5LgZvpbCTcWdBqHBprfe3C/E6oB68XdOHcewu31vayRh6nOaeYtJBmNwlilMHeEIh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 21:34:17.4151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70886c6c-3dd6-4f56-03a0-08deec26cfed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

Hi Timo,

Thanks for the patch. Heads-up that this overlaps with a fix already in
amd-staging-drm-next:

  21590e1adc9e ("drm/amd/display: Fix 8K Mode Not Parsed by EDID")

That commit addresses the same underlying problem your patch targets --
edid->extensions (byte 0x7e) not accounting for HF-EEODB blocks, so only
2 of 4 blocks of an HDMI 2.1 EDID get copied into sink->dc_edid and the
8K modes in the DisplayID extension blocks are lost. It takes a slightly
different approach: instead of drm_edid_block_count(), it populates
edid_blob_ptr with a full, HF-EEODB-aware blob and copies
edid_blob_ptr->length. So on current amd-staging the
dm_helpers_read_local_edid() hunk here no longer applies cleanly.

Could you rebase on the latest amd-staging-drm-next and see what, if
anything, is still needed on top? There may still be value in the
helper conversion for readability, but we should avoid re-fixing the
same HF-EEODB issue two different ways.

Thanks,
Jerry
